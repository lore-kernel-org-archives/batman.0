Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 16 Jun 2016 21:49:15 +0200
Message-ID: <2601328.mlZH1BliTQ@sven-edge>
In-Reply-To: <1465937810-17394-1-git-send-email-linus.luessing@c0d3.blue>
References: <1465937810-17394-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1818585.9sxb2vLDGA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Remove unused primary_if
	and bat_priv variables
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1818585.9sxb2vLDGA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 14 June 2016 22:56:50 Linus L=FCssing wrote:
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
> Fixes: 29b9256e6631 ("batman-adv: consider outgoing interface in OGM
> sending") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>


> v2:
> * Remove now unused bat_priv variable, too
>=20
>  net/batman-adv/bat_iv_ogm.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>=20
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.=
c
> index 19b0abd..6af4462 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -528,36 +528,25 @@ static void batadv_iv_ogm_send_to_if(struct
> batadv_forw_packet *forw_packet, static void batadv_iv_ogm_emit(struc=
t
> batadv_forw_packet *forw_packet) {
>  =09struct net_device *soft_iface;
> -=09struct batadv_priv *bat_priv;
> -=09struct batadv_hard_iface *primary_if =3D NULL;
>=20
>  =09if (!forw_packet->if_incoming) {
>  =09=09pr_err("Error - can't forward packet: incoming iface not speci=
fied\n");
> -=09=09goto out;
> +=09=09return;
>  =09}
>=20
>  =09soft_iface =3D forw_packet->if_incoming->soft_iface;
> -=09bat_priv =3D netdev_priv(soft_iface);
>=20
>  =09if (WARN_ON(!forw_packet->if_outgoing))
> -=09=09goto out;
> +=09=09return;
>=20
>  =09if (WARN_ON(forw_packet->if_outgoing->soft_iface !=3D soft_iface)=
)
> -=09=09goto out;
> +=09=09return;
>=20
>  =09if (forw_packet->if_incoming->if_status !=3D BATADV_IF_ACTIVE)
> -=09=09goto out;
> -
> -=09primary_if =3D batadv_primary_if_get_selected(bat_priv);
> -=09if (!primary_if)
> -=09=09goto out;
> +=09=09return;
>=20
>  =09/* only for one specific outgoing interface */
>  =09batadv_iv_ogm_send_to_if(forw_packet, forw_packet->if_outgoing);
> -
> -out:
> -=09if (primary_if)
> -=09=09batadv_hardif_put(primary_if);
>  }
>=20
>  /**

--nextPart1818585.9sxb2vLDGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXYwK7AAoJEF2HCgfBJntGcwYP/28LTh0BbQzF6izataYyHw7y
OpeOo0pPuTpnR+wocZx3uttNsYxp3H6BLeEEhH0UX4ri+2jOVnC8FK/YE3Tb1PDe
7lQfMiL/WtZmWV7LUcDC3F0mFY/N2Kk/5hft9ri+XXvLuuUb4OP+Cja91ygw9+jC
YXbVFfXl4UHyONhXY9rn0Dcx0Q8ZBNG/65MAV6934W/boaj9Ou96XjAT518ahUA4
KkItNC0bqt4YjWpquL5iptSA4jHnu0RMLRLgG581WM35+oN3TQ9tcPgNCm4Ym5fA
sH3kDu8JiID0QTjFNy9csz9AO+1TdID+A4+9Vwczn7b+PTjBW1iYdiJugWmEC8Xo
Sk9DqG6m2y/WCdA0tLgjz0R8Kx0S9zd2d39SXbKyr5k7xafwBa19S/ZaQ3UkYoBo
Wtxu/5ay49I2PIYQj7rhlN0/hS6Gs0o+huqF8CqorjB81N5TXMXelfER6G2HROtb
JOmUHZJjqr6WaKgQGS9jswY1ScbQhK+Rm+iUzntWZNGF/UijoVluO7X/3DESVJ/6
aKUKerSM4kBzL1i2RhZrWOF+tmOtbr1u4Jg2vZN959bGp/WJfWTVb1meZUnZAQ/F
9unxBqnZ/yx0RG7fVOiZzKwC/mv0UiT/L5Wb4LqMvpvt3uNKut2lMi0MEOOfcNet
XKbbqvvCn/6hCpvNV3SD
=hgzQ
-----END PGP SIGNATURE-----

--nextPart1818585.9sxb2vLDGA--

