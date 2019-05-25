Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 3/3] batman-adv: forward broadcast packets via unicast
 transmissions
Date: Sat, 25 May 2019 12:21:11 +0200
Message-ID: <11000634.v2cH04sJFL@sven-edge>
In-Reply-To: <20190514073859.2053-4-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
 <20190514073859.2053-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2206477.k6HNqMgy6z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2206477.k6HNqMgy6z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, 14 May 2019 09:38:59 CEST Linus L=C3=BCssing wrote:
> +static bool batadv_forw_bcast_may_ucast(struct batadv_priv *bat_priv,
> +                                       struct batadv_hard_iface *if_out)
> +{
> +       unsigned long num_direct_orig;
> +       unsigned long num_bcast_no_urcv;
> +
> +       num_direct_orig =3D atomic_read(&if_out->num_direct_orig);
> +       num_bcast_no_urcv =3D atomic_read(&if_out->num_bcast_no_urcv);
> +
> +       return !num_bcast_no_urcv &&
> +              (num_direct_orig <=3D atomic_read(&bat_priv->multicast_fan=
out));
> +}

ecsv/pu|sparse linux-3.16.66 cfg: BLA=3Dy DAT=3Dy DEBUGFS=3Dn DEBUG=3Dy TRA=
CING=3Dy NC=3Dn MCAST=3Dn BATMAN_V=3Dy SYSFS=3Dy|/home/build_test/build_env=
/tmp.I4uiDZgE1M/net/batman-adv/send.c:928:57: error: no member 'multicast_f=
anout' in struct batadv_priv
/home/build_test/build_env/tmp.I4uiDZgE1M/net/batman-adv/send.c:928:47: war=
ning: call with no type!
/home/build_test/build_env/tmp.I4uiDZgE1M/net/batman-adv/send.c: In functio=
n =E2=80=98batadv_forw_bcast_may_ucast=E2=80=99:
/home/build_test/build_env/tmp.I4uiDZgE1M/net/batman-adv/send.c:928:50: err=
or: =E2=80=98struct batadv_priv=E2=80=99 has no member named =E2=80=98multi=
cast_fanout=E2=80=99
         (num_direct_orig <=3D atomic_read(&bat_priv->multicast_fanout));
                                                  ^~
/home/build_test/build_env/tmp.I4uiDZgE1M/net/batman-adv/send.c:929:1: warn=
ing: control reaches end of non-void function [-Wreturn-type]
 }

Kind regards,
	Sven
--nextPart2206477.k6HNqMgy6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpFxcACgkQXYcKB8Em
e0as6RAAmw7/0yVx8jCVUulQY1DzAL0MXntLbwTPUdWMpiRRH9+xC4XfpfGxcJmM
QYpnIIYjc/y2+ATM02Cnh8AlX6nhbadsg6woRxY7rNezb9OAH1LxDoNHJyNHK8ix
LiamWPqPvzc5jEEgz1QHsKtvin/DX9eruWJf6UR3cI9kFpdtdRZKWXTStpB/qzcT
Y/2voBN344Ipo0Js5zNQ9Ib6qA5nhMpc+K1LgkesCx+GB3SJiuTxd7iLNHSL7CIc
F9BQKkoB2PhUyRqrfL+UCWXLx4TWtUNGISuo71Nzk0gbokI9Z4CwfJYiQuOL5sAP
IMPIGpXig9JV3WHK0CsRjLyi55wgL7NXn6qJAzOGkwMO4vX1G8k0QQaOxVFKAP/T
3P8CNW96JbBboUS0iOoZlE0YlMP28wwHCKjEzkqvnRK2JtdOs7bjVngRRhLyr+0s
hNFB8qCbwF594zS1CB7zDFnkCYXf7RkjfP7dSS6as05Tr5YUn1vM6xlURyQ+e/Pu
IoxfIZy2cdHmkbHgWY94fykSGQpISsJ7LN5dpsjANPmnfx841bNGtLwDDpkgrPGG
bGrrsgkDKjYhN2e/yop1ll3p0Sm7b2poaW+XjSRifGNeeo4GeMrNiknVEYhnhNEg
ZoxEfhl1lt40nP9HIuObvyIREJa4G4FInIH3cnJkmxeJ03dVWNw=
=haM7
-----END PGP SIGNATURE-----

--nextPart2206477.k6HNqMgy6z--



