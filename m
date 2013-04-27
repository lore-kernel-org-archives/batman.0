Return-Path: <ordex@autistici.org>
Date: Sat, 27 Apr 2013 18:59:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130427165903.GB3179@ritirata.org>
References: <1367078393-5646-1-git-send-email-ordex@autistici.org>
 <201304280046.11511.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <201304280046.11511.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: properly handle Network
 Ordered variables
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


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2013 at 12:46:11AM +0800, Marek Lindner wrote:
> On Saturday, April 27, 2013 23:59:53 Antonio Quartulli wrote:
> > --- a/gateway_common.c
> > +++ b/gateway_common.c
> > @@ -202,8 +202,8 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct
> > batadv_priv *bat_priv, gateway.bandwidth_up =3D 0;
> >         } else {
> >                 gateway_ptr =3D tvlv_value;
> > -               gateway.bandwidth_down =3D
> > ntohl(gateway_ptr->bandwidth_down); -               gateway.bandwidth_u=
p =3D
> > ntohl(gateway_ptr->bandwidth_up); +               gateway.bandwidth_dow=
n =3D
> > gateway_ptr->bandwidth_down; +               gateway.bandwidth_up =3D
> > gateway_ptr->bandwidth_up;
> >                 if ((gateway.bandwidth_down =3D=3D 0) ||
> >                     (gateway.bandwidth_up =3D=3D 0)) {
> >                         gateway.bandwidth_down =3D 0;
>=20
> There is no bug.=20

I did not intend to fix a bug, I just wanted to use the __be32 notation for
stuff sent over the wire.
Well, I have to admit I thought you forgot some htonl/ntohl (this is why the
notation is useful, to spot missing conversions..) but this was not the cas=
e :)

> The original code converted the incoming big endian value to=20
> host endian (whatever that is) and works with that value internally. Now =
that=20
> you reversed the logic you have to adjust *all* occurences. Especially, w=
hen=20
> the tvlv bandwidth value is copied into a gw_node struct. You can use spa=
rse=20
> to help you find the sections in the code by changing gw_node to be32 as =
well.
>=20

So far everything seems to be converted the right way: sparse does not comp=
lain,
and here is the code where the GW component does the assignment yu talked a=
bout:

420         gw_node->bandwidth_down =3D ntohl(gateway->bandwidth_down);
421         gw_node->bandwidth_up =3D ntohl(gateway->bandwidth_up);

> However, I am not convinced that converting the values every single time =
we=20
> access the variable is the optimal approach.
>=20

True, not really beautiful but this will avoid future bugs thanks to the __=
be
notation.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRfAPXAAoJEADl0hg6qKeOGEwQAIfDis1Ys66glLTomINts4rL
gZIjxr97cV+Jk9yftiPsLnSZ4O/vKmjIeoovsCzIpyITeU0kjhpjkBf300mej+uQ
+ja7dM9RxEdPlu3ZyNomQ03oRosNC7vvik0+N4SrqP3oY7IgX0NNBEfQeyOQeDq0
1x00PaZ8KekCXGwUU1uxZL5YZPOf0ZQ/TVLlJYuCC6AgxJWhV7qzsR1h1+U3g/Jj
NMmykRV0erAAdMQAoYs6JTtODnblHEAmPTofDP8fLfMtYFkTeepOWQunh+0lyfCe
EmaanoQW5YJWVB13cUfgU0ZwdXNI9AXTK/Ts3SreJKdqvM5x3CDkd2EZPIrMaGUR
Yc43eRoFhnCCWMqNWJ5ZKpUcLE/Qmb4wgbdodLJLowVi+FubkPVMZi5bosdRmwcH
MYQhqikX1Y+dj+Xm7pj8vbEHfWr4sCaIHsUajkG1YH3RUJqRWa/AVVatPaW+zQHQ
Uko6qvwB9fLpIByjDLWCW20oJrxyhBQiSfO+jLGHX+ksfFcBf98X5RGhj4AI8A1E
YOQYajZUQcVk0i6pwTu1a8wqlM+utvd//shqoPidjZMnARn3cvBtQmRsyQoM1zZf
BlIZ2BHrWZyqwz/kdusnxnxd9PuQZI+CTiFY7kmcu/RJSrXlyESyEzXiB1lsU4v/
pTDgtd+nDfLCFzkcyOSs
=qiOW
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
