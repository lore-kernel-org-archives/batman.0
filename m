Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 19 May 2013 13:52:25 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130519115225.GA16839@pandem0nium>
References: <1368960916-861-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1368960916-861-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: use htons when possible
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <ordex@autistici.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2013 at 12:55:16PM +0200, Antonio Quartulli wrote:
> When comparing a network ordered value with a constant, it
> is better to convert the constant at compile time by means
> of htons() instead of converting the value at runtime using
> ntohs().
>=20
> This refactoring may slightly improve the code performance.
>=20
> Moreover substitute __constant_htons() with htons() since
> the latter increase readability and it is smart enough to be
> as efficient as the former
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>=20
> v2:
> - patch rebased on top of
> "batman-adv: use VLAN_ETH_HLEN instead of sizeof(struct vlan_eth_hdr)"
>=20
> v3:
> - use __constant* for vlan_insert_tag() argument
>=20
> v4:
> - use htons instead of __constant_htons

Looks good, using htons is a lot better. :)

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>=20
>  bridge_loop_avoidance.c | 12 ++++++------
>  gateway_client.c        | 14 +++++++-------
>  hard-interface.c        |  2 +-
>  send.c                  |  4 ++--
>  soft-interface.c        |  4 ++--
>  5 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index 9e691b0..ab537ec 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -863,25 +863,25 @@ static int batadv_bla_process_claim(struct batadv_p=
riv *bat_priv,
>  	struct arphdr *arphdr;
>  	uint8_t *hw_src, *hw_dst;
>  	struct batadv_bla_claim_dst *bla_dst;
> -	uint16_t proto;
> +	__be16 proto;
>  	int headlen;
>  	unsigned short vid =3D BATADV_NO_FLAGS;
>  	int ret;
> =20
>  	ethhdr =3D eth_hdr(skb);
> =20
> -	if (ntohs(ethhdr->h_proto) =3D=3D ETH_P_8021Q) {
> +	if (ethhdr->h_proto =3D=3D htons(ETH_P_8021Q)) {
>  		vhdr =3D (struct vlan_ethhdr *)ethhdr;
>  		vid =3D ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
>  		vid |=3D BATADV_VLAN_HAS_TAG;
> -		proto =3D ntohs(vhdr->h_vlan_encapsulated_proto);
> +		proto =3D vhdr->h_vlan_encapsulated_proto;
>  		headlen =3D sizeof(*vhdr);
>  	} else {
> -		proto =3D ntohs(ethhdr->h_proto);
> +		proto =3D ethhdr->h_proto;
>  		headlen =3D ETH_HLEN;
>  	}
> =20
> -	if (proto !=3D ETH_P_ARP)
> +	if (proto !=3D htons(ETH_P_ARP))
>  		return 0; /* not a claim frame */
> =20
>  	/* this must be a ARP frame. check if it is a claim. */
> @@ -1375,7 +1375,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
> =20
>  	ethhdr =3D (struct ethhdr *)(((uint8_t *)skb->data) + hdr_size);
> =20
> -	if (ntohs(ethhdr->h_proto) =3D=3D ETH_P_8021Q) {
> +	if (ethhdr->h_proto =3D=3D htons(ETH_P_8021Q)) {
>  		if (!pskb_may_pull(skb, hdr_size + VLAN_ETH_HLEN))
>  			return 0;
> =20
> diff --git a/gateway_client.c b/gateway_client.c
> index 3a27408..131136f 100644
> --- a/gateway_client.c
> +++ b/gateway_client.c
> @@ -637,7 +637,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, un=
signed int *header_len)
>  	*header_len +=3D ETH_HLEN;
> =20
>  	/* check for initial vlan header */
> -	if (proto =3D=3D __constant_htons(ETH_P_8021Q)) {
> +	if (proto =3D=3D htons(ETH_P_8021Q)) {
>  		if (!pskb_may_pull(skb, *header_len + VLAN_HLEN))
>  			return false;
> =20
> @@ -648,7 +648,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, un=
signed int *header_len)
> =20
>  	/* check for ip header */
>  	switch (proto) {
> -	case __constant_htons(ETH_P_IP):
> +	case htons(ETH_P_IP):
>  		if (!pskb_may_pull(skb, *header_len + sizeof(*iphdr)))
>  			return false;
>  		iphdr =3D (struct iphdr *)(skb->data + *header_len);
> @@ -659,7 +659,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, un=
signed int *header_len)
>  			return false;
> =20
>  		break;
> -	case __constant_htons(ETH_P_IPV6):
> +	case htons(ETH_P_IPV6):
>  		if (!pskb_may_pull(skb, *header_len + sizeof(*ipv6hdr)))
>  			return false;
>  		ipv6hdr =3D (struct ipv6hdr *)(skb->data + *header_len);
> @@ -680,12 +680,12 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, =
unsigned int *header_len)
>  	*header_len +=3D sizeof(*udphdr);
> =20
>  	/* check for bootp port */
> -	if ((proto =3D=3D __constant_htons(ETH_P_IP)) &&
> -	    (ntohs(udphdr->dest) !=3D 67))
> +	if ((proto =3D=3D htons(ETH_P_IP)) &&
> +	    (udphdr->dest !=3D htons(67)))
>  		return false;
> =20
> -	if ((proto =3D=3D __constant_htons(ETH_P_IPV6)) &&
> -	    (ntohs(udphdr->dest) !=3D 547))
> +	if ((proto =3D=3D htons(ETH_P_IPV6)) &&
> +	    (udphdr->dest !=3D htons(547)))
>  		return false;
> =20
>  	return true;
> diff --git a/hard-interface.c b/hard-interface.c
> index 9746600..5edbe52 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -379,7 +379,7 @@ int batadv_hardif_enable_interface(struct batadv_hard=
_iface *hard_iface,
>  {
>  	struct batadv_priv *bat_priv;
>  	struct net_device *soft_iface, *master;
> -	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
> +	__be16 ethertype =3D htons(ETH_P_BATMAN);
>  	int ret;
> =20
>  	if (hard_iface->if_status !=3D BATADV_IF_NOT_IN_USE)
> diff --git a/send.c b/send.c
> index 23c7f79..f2ec99c 100644
> --- a/send.c
> +++ b/send.c
> @@ -63,11 +63,11 @@ int batadv_send_skb_packet(struct sk_buff *skb,
>  	ethhdr =3D eth_hdr(skb);
>  	memcpy(ethhdr->h_source, hard_iface->net_dev->dev_addr, ETH_ALEN);
>  	memcpy(ethhdr->h_dest, dst_addr, ETH_ALEN);
> -	ethhdr->h_proto =3D __constant_htons(ETH_P_BATMAN);
> +	ethhdr->h_proto =3D htons(ETH_P_BATMAN);
> =20
>  	skb_set_network_header(skb, ETH_HLEN);
>  	skb->priority =3D TC_PRIO_CONTROL;
> -	skb->protocol =3D __constant_htons(ETH_P_BATMAN);
> +	skb->protocol =3D htons(ETH_P_BATMAN);
> =20
>  	skb->dev =3D hard_iface->net_dev;
> =20
> diff --git a/soft-interface.c b/soft-interface.c
> index a6ab9e4..4696142 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -147,7 +147,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  	struct batadv_hard_iface *primary_if =3D NULL;
>  	struct batadv_bcast_packet *bcast_packet;
>  	struct vlan_ethhdr *vhdr;
> -	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
> +	__be16 ethertype =3D htons(ETH_P_BATMAN);
>  	static const uint8_t stp_addr[ETH_ALEN] =3D {0x01, 0x80, 0xC2, 0x00,
>  						   0x00, 0x00};
>  	static const uint8_t ectp_addr[ETH_ALEN] =3D {0xCF, 0x00, 0x00, 0x00,
> @@ -304,7 +304,7 @@ void batadv_interface_rx(struct net_device *soft_ifac=
e,
>  	struct vlan_ethhdr *vhdr;
>  	struct batadv_header *batadv_header =3D (struct batadv_header *)skb->da=
ta;
>  	unsigned short vid __maybe_unused =3D BATADV_NO_FLAGS;
> -	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
> +	__be16 ethertype =3D htons(ETH_P_BATMAN);
>  	bool is_bcast;
> =20
>  	is_bcast =3D (batadv_header->packet_type =3D=3D BATADV_BCAST);
> --=20
> 1.8.1.5
>=20

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGYvPkACgkQrzg/fFk7axYXygCggcGgWbQuUeZnbddLktiE/8a+
xkIAoJJ12dPMDVWKklSuSdVqvrxpuYYF
=sG9r
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
