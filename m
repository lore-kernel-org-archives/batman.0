Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Oct 2012 16:17:33 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121017141733.GB30441@pandem0nium>
References: <1350478385-676-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <1350478385-676-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix broadcast packet
 CRC calculation
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


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good catch! When can I buy you the beer? :D

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wed, Oct 17, 2012 at 02:53:04PM +0200, Linus L=C3=BCssing wrote:
> So far the crc16 checksum for a batman-adv broadcast data packet, received
> on a batman-adv hard interface, was calculated over zero bytes of its
> content leading to many incoming broadcast data packets wrongly being
> dropped.
>=20
> This patch fixes this issue by calculating the crc16 over the actual,
> complete broadcast payload.
>=20
> The issue is a regression introduced by
> "batman-adv: add broadcast duplicate check".
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> It led to about 60-80% broadcast packet loss to a direct neighbor
> with a ping6 with a 1s interval in our scenario, but about no
> packet loss with an interval smaller than 0.2s.
>=20
> Also see: https://projects.universe-factory.net/issues/65 (German)
>=20
> v2:
> ~ fixed typo (regrission vs. regression)
> ~ commit name instead of commit hash in the commit message
>=20
>  bridge_loop_avoidance.c |    8 ++++----
>  routing.c               |    8 +++++++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index a617f2c..b828875 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -1247,8 +1247,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
>  /**
>   * batadv_bla_check_bcast_duplist
>   * @bat_priv: the bat priv with all the soft interface information
> - * @bcast_packet: originator mac address
> - * @hdr_size: maximum length of the frame
> + * @bcast_packet: encapsulated broadcast frame plus batman header
> + * @bcast_packet_len: length of encapsulated broadcast frame plus batman=
 header
>   *
>   * check if it is on our broadcast list. Another gateway might
>   * have sent the same packet because it is connected to the same backbon=
e,
> @@ -1261,14 +1261,14 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
>   */
>  int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
>  				   struct batadv_bcast_packet *bcast_packet,
> -				   int hdr_size)
> +				   int bcast_packet_len)
>  {
>  	int i, length, curr;
>  	uint8_t *content;
>  	uint16_t crc;
>  	struct batadv_bcast_duplist_entry *entry;
> =20
> -	length =3D hdr_size - sizeof(*bcast_packet);
> +	length =3D bcast_packet_len - sizeof(*bcast_packet);
>  	content =3D (uint8_t *)bcast_packet;
>  	content +=3D sizeof(*bcast_packet);
> =20
> diff --git a/routing.c b/routing.c
> index 6b2104d..5da62df 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -1181,8 +1181,14 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
> =20
>  	spin_unlock_bh(&orig_node->bcast_seqno_lock);
> =20
> +	/* keep skb linear for crc calculation */
> +	if (skb_linearize(skb) < 0)
> +		goto out;
> +
> +	bcast_packet =3D (struct batadv_bcast_packet *)skb->data;
> +
>  	/* check whether this has been sent by another originator before */
> -	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, hdr_size))
> +	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, skb->len))
>  		goto out;
> =20
>  	/* rebroadcast packet */
> --=20
> 1.7.10.4
>=20
>=20

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlB+vf0ACgkQrzg/fFk7axa97ACff2Tf+z6hp58vIrnyB4tIAxyR
Y9kAoPTrv9MyHvCWwLsFoJasZ4WwgceS
=ZKPj
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
