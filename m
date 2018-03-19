Return-Path: <mschiffer@universe-factory.net>
References: <20180318121201.29052-1-sven@narfation.org>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <b50d17c8-e55f-6a05-88db-acdcc4c35732@universe-factory.net>
Date: Mon, 19 Mar 2018 14:02:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180318121201.29052-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TQltcRjTmWnBLgsywZSkX1pBq24FgSwEr"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix skbuff rcsum on packet
 reroute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TQltcRjTmWnBLgsywZSkX1pBq24FgSwEr
Content-Type: multipart/mixed; boundary="728SpDlzDTsWIvv8WMiAwcjbTKSDOcuLZ";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <b50d17c8-e55f-6a05-88db-acdcc4c35732@universe-factory.net>
Subject: Re: [PATCH] batman-adv: Fix skbuff rcsum on packet reroute
References: <20180318121201.29052-1-sven@narfation.org>
In-Reply-To: <20180318121201.29052-1-sven@narfation.org>

--728SpDlzDTsWIvv8WMiAwcjbTKSDOcuLZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/18/2018 01:12 PM, Sven Eckelmann wrote:
> batadv_check_unicast_ttvn may redirect a packet to itself or another
> originator. This involves rewriting the ttvn and the destination addres=
s in
> the batadv unicast header. These field were not yet pulled (with skb rc=
sum
> update) and thus any change to them also requires a change in the recei=
ve
> checksum.
>=20
> Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanis=
m")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Matthias Schiffer <mschiffer@universe-factory.net>
>=20
> This is an alternative fix for the problem reported by Matthias and his=

> patch https://patchwork.open-mesh.org/patch/17305/. I've prepared it
> because I don't feel good about fixing one thing and at the same time a=
dd
> regression to another thing (even when it is only the debug output for =
arp
> packets) - at least not when this patch should end up at
> stable@vger.kernel.org
>=20
> This patch was not actually tested. But it should help to see a differe=
nt
> approach. Other code in the kernel which does something similar is:
>=20
> * seg6_do_srh_inline
> * set_eth_addr (openvswitch)
> * set_nsh (openvswitch)
>=20
> I would still like to merge the cleanup patches from Matthias - just no=
t
> for net.git/stable@vger.kernel.org. Maybe Simon can decide about the ma=
int
> patch - at least he will be the one who forwards them to DaveM.
>=20
> Btw. in theory, only ttl+ttvn+dest have to be read to update the checks=
um
> correctly - but this patch also reads packet_type+version to keep the
> change simple.
> ---
[...]
> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 0f10c565..cc3ed93a 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -759,6 +759,7 @@ static int batadv_route_unicast_packet(struct sk_bu=
ff *skb,
>  /**
>   * batadv_reroute_unicast_packet() - update the unicast header for re-=
routing
>   * @bat_priv: the bat priv with all the soft interface information
> + * @skb: unicast packet to process
>   * @unicast_packet: the unicast header to be updated
>   * @dst_addr: the payload destination
>   * @vid: VLAN identifier
> @@ -770,7 +771,7 @@ static int batadv_route_unicast_packet(struct sk_bu=
ff *skb,
>   * Return: true if the packet header has been updated, false otherwise=

>   */
>  static bool
> -batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
> +batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_=
buff *skb,
>  			      struct batadv_unicast_packet *unicast_packet,
>  			      u8 *dst_addr, unsigned short vid)
>  {
> @@ -799,8 +800,10 @@ batadv_reroute_unicast_packet(struct batadv_priv *=
bat_priv,
>  	}
> =20
>  	/* update the packet header */
> +	skb_postpull_rcsum(skb, unicast_packet, sizeof(*unicast_packet));

Using skb_postpull_rcsum here is incorrect: As the name indicates, it is
supposed to be used after pulling, and will thus subtract the checksum of=

the header *before* skb->data, while we are interested in the
sizeof(*unicast_packet) bytes *after* skb->data.

>  	ether_addr_copy(unicast_packet->dest, orig_addr);
>  	unicast_packet->ttvn =3D orig_ttvn;
> +	skb_postpush_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
> =20
>  	ret =3D true;
>  out:
> @@ -841,7 +844,7 @@ static bool batadv_check_unicast_ttvn(struct batadv=
_priv *bat_priv,
>  	 * the packet to
>  	 */
>  	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid))=
 {
> -		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
> +		if (batadv_reroute_unicast_packet(bat_priv, skb, unicast_packet,
>  						  ethhdr->h_dest, vid))
>  			batadv_dbg_ratelimited(BATADV_DBG_TT,
>  					       bat_priv,
> @@ -887,7 +890,7 @@ static bool batadv_check_unicast_ttvn(struct batadv=
_priv *bat_priv,
>  	 * destination can possibly be updated and forwarded towards the new
>  	 * target host
>  	 */
> -	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
> +	if (batadv_reroute_unicast_packet(bat_priv, skb, unicast_packet,
>  					  ethhdr->h_dest, vid)) {
>  		batadv_dbg_ratelimited(BATADV_DBG_TT, bat_priv,
>  				       "Rerouting unicast packet to %pM (dst=3D%pM): TTVN mismatch=
 old_ttvn=3D%u new_ttvn=3D%u\n",
> @@ -910,12 +913,14 @@ static bool batadv_check_unicast_ttvn(struct bata=
dv_priv *bat_priv,
>  	if (!primary_if)
>  		return false;
> =20
> +	/* update the packet header */
> +	skb_postpull_rcsum(skb, unicast_packet, sizeof(*unicast_packet));

Dito.

>  	ether_addr_copy(unicast_packet->dest, primary_if->net_dev->dev_addr);=

> +	unicast_packet->ttvn =3D curr_ttvn;
> +	skb_postpush_rcsum(skb, unicast_packet, sizeof(*unicast_packet));
> =20
>  	batadv_hardif_put(primary_if);
> =20
> -	unicast_packet->ttvn =3D curr_ttvn;
> -
>  	return true;
>  }
> =20
>=20

Regards,
Matthias


--728SpDlzDTsWIvv8WMiAwcjbTKSDOcuLZ--

--TQltcRjTmWnBLgsywZSkX1pBq24FgSwEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlqvtPMACgkQFu8/ZMsg
HZxKBRAAqkSDXJsUGHAfBiYRQ5PYmGElCKRnWzqc34+uKB8wn1+MaOPS/n3c7txd
blyMr0xK+OunKfm+4fIZTxSpvKkvXIqvny1aVxZ16R/HLWz4YXyV4oKYgvNLx29V
yFkfpuGp+JuuPGSx5eNzO0QmMWZ28/jicV16yLI9sXb4v0KPgP6vAxu4Sp+CntwZ
9JA6xCIIinCIbdq4NNVVEbN15/wSQ6OUxX3pCAiMJlCsphWxc11M+96L3XXEENjb
/Z5lpRJqHll5lFdT4w0D7MIPkIWjYHA0dH5Son8fXmCjWF1RoDlLlyMMeAjE3VBb
Sc0erEmNwPcr1x2gfmJsJldG472VresJ00undl57IFecpokSgq5XmTcw97Fyy5lf
lhIMPMeDeNg5UYZDN1STWBRWnfaUvgwjqby5jqzDmE7Wzfb8aUX4uJ2omR4F2Z/n
wXsZe8kJ0EWz0O6x25/CKWvO/eUVHGj1SdhyH7TM+iFRN3goqAV/pozHJFOlCmtL
uVz3ZkAlwIJKKBU9tpNmZ0kA6NgIa9zjnRFx4yfyyTyueJ3+VzsYgk3aJ5ynT/0F
kj78lyDuYNZnzG696UZcmtRbhJbVIO5miMRqHqs0KE6InkD3faP9XqlmfRqB05kh
1V+Mw1l3BfgvDauvlmUuvilz1QQXUsH3T7/LQL5gvuRQXcaTzxY=
=jkot
-----END PGP SIGNATURE-----

--TQltcRjTmWnBLgsywZSkX1pBq24FgSwEr--
