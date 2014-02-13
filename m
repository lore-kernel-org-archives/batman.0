Return-Path: <antonio@open-mesh.com>
Message-ID: <52FC7FAC.60404@open-mesh.com>
Date: Thu, 13 Feb 2014 09:17:48 +0100
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-19-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b5tiH8Vko6omWn6g0MveF3H9lGw7MnNJc"
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
	determine link characteristics
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b5tiH8Vko6omWn6g0MveF3H9lGw7MnNJc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 13:48, Antonio Quartulli wrote:
> @@ -297,6 +299,7 @@ void batadv_update_min_mtu(struct net_device *soft_=
iface)
>  static void
>  batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)=

>  {
> +	struct net_device *dev =3D hard_iface->net_dev;
>  	struct batadv_priv *bat_priv;
>  	struct batadv_hard_iface *primary_if =3D NULL;
> =20
> @@ -315,6 +318,22 @@ batadv_hardif_activate_interface(struct batadv_har=
d_iface *hard_iface)
>  	if (!primary_if)
>  		batadv_primary_if_select(bat_priv, hard_iface);
> =20
> +	/* set the default values */
> +	hard_iface->bat_v.flags &=3D ~BATADV_FULL_DUPLEX;
> +	hard_iface->bat_v.eth_throughput =3D 0;
> +	if (dev->phydev) {
> +		if (dev->phydev->duplex =3D=3D DUPLEX_FULL)
> +			hard_iface->bat_v.flags |=3D BATADV_FULL_DUPLEX;
> +
> +		/* set the speed according to the phydev setting. Store the
> +		 * value in Kbps (as done for the other throughput variables)
> +		 */
> +		if (dev->phydev->speed !=3D SPEED_UNKNOWN) {
> +			hard_iface->bat_v.eth_throughput =3D dev->phydev->speed;
> +			hard_iface->bat_v.eth_throughput *=3D 10;
> +		}
> +	}
> +

For the record: I just moved this chunk into a proper
bat_algo_ops->bat_iface_activate() API.

This initialisation is obviously B.A.T.M.A.N. V specific and cannot live
in the batadv_hardif_activate_interface() function.


Cheers,


--=20
Antonio Quartulli


--b5tiH8Vko6omWn6g0MveF3H9lGw7MnNJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/H+vAAoJEEKTMo6mOh1VeP0P/Rd8OCAxjY9Lsk8s7Jos3jPr
1tiWxp+XJ/bI9B8KRZKE6dDqIWzwzEsVHoDpRytSooxQyzmHeCyoyYHxMUUEvEdL
uTdPQsD6FLZ+/3X67G8DBe+C0+d1XCGa9ZaqJvUMVIHWosloYQRqiBYrHoubCjM+
XCyiDRcep0U+hDNYkyI+PGb9VLDgXJ1vS/Ik6qWEn++hzMgw2tYKPdDdXVta9kEe
sTMQXa42TJfruCQ7DxQBfQj5uEw4g5yzqsvU9hgObMW7nH4X6z0iMus83vjiBSHK
W0XZimlTL+mQfQA2+Wk/bdM/GqwzyoTScZkgRbdKGrugoZDYGPmCT/wBROv/9kkz
hvlEj0hsRTJhcarR9mhEPxX2aPf6ECHWGUfPmSGH/h99N6OPGiLAQkm4FPFlhk/h
g6l7q2k6shH17x/2ud54KsgoZONkM/KqxedceTegYI3K4pqkzohMy1vLL8BW9EDb
cjReQffZxLTcYZ9L7NlsdB3MuW40MPb/SgmVzalEEzNPhC2a7UpenrnzUg3CxMzS
YIVnWvOTLoRubI2TKdrcA0Iiyl8XsvxZqKshNhEJIMbDchvQW0jLvnP0GNZ3cpkX
PNEFWtk40/CJdPjBtDQ1jIudGCdeeKRR7XtlNFzsHJJDMHFHIRlrOhdb6epfELUh
esiXdbqb+DfTn8tkgNvL
=DrP+
-----END PGP SIGNATURE-----

--b5tiH8Vko6omWn6g0MveF3H9lGw7MnNJc--
