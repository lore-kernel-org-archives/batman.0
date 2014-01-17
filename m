Return-Path: <antonio@meshcoding.com>
Message-ID: <52D8D696.1080707@meshcoding.com>
Date: Fri, 17 Jan 2014 08:07:02 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAAxzKbR22CvtrPapZkDdXdRL=_dNC-HUzvCWZPi0HZ-h8ZFLQA@mail.gmail.com>
In-Reply-To: <CAAxzKbR22CvtrPapZkDdXdRL=_dNC-HUzvCWZPi0HZ-h8ZFLQA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a3t2iGEpV125HqlTjCJBODoeVOkoF1ixx"
Subject: Re: [B.A.T.M.A.N.] Barrier breaking kmod-batman-adv package
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, tjhowse@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a3t2iGEpV125HqlTjCJBODoeVOkoF1ixx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/01/14 07:41, tjhowse wrote:
> Not sure if this is appropriate for this list, but I'm trying to get
> batman-adv running on the latest bleeding edge barrier breaker r39286
> but kmod-batman-adv is not available from the package repo.
>=20
> When I was setting up a r38816-based router a few months ago and I
> didn't have to set up the build environment and whatnot, just opkg
> install kmod-batman-adv.
>=20
> Anyone know why it's not available anymore? I'm working on creating an
> updated system image using batman-adv 2014 for the purpose of
> future-proofery.
>=20

Travis,

maybe somebody else will correct me (I am not a real openwrt expert),
but my feeling that you have to install the openwrt-routing feed (where
batman-adv is currently located).

This was not needed in the past as batman-adv was part of the standard
packes.

Cheers,


--=20
Antonio Quartulli


--a3t2iGEpV125HqlTjCJBODoeVOkoF1ixx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS2NaaAAoJEEKTMo6mOh1VKukP/37KEAo9AXve7ZjucdqvbY6s
dw9V+hN5yI1Gr7K8b2suRm43h8zfg9YrFZWToqKA0qPMbULE+/vw5PAzI8bHE4dK
6fiNAr1DkxRrPEoOpjz92bRxWWFGUU4E+Rzl1MP0SRzHJ8hRO8WLNx6lq1Uz/YpK
rAG8RvLb88R5W5aAr+Hu2uwtCurnlAiVD8IoofK9Tc8zAtpLHwkAthB55N4DzaKd
xsFOa78dSDMvYE5ORIJdqHbBiWInfdQV2dJneJZnZTGT6kWpLVh/JBOGjkJTjZg1
qPRqAfaRHB5NwUQxY5x25lw24dC/yZ33Fy7QhzV1GCS8vIWanvk8rOjymzdkC4Zf
U4zpF7sN+gHxYjGTu2LP9XtfnTLIV4Z7cXx0C41VZOAqTjHuvjFnz+pZajuwWOvC
kBjEtmumFrbU73nvuFcxpmiCcIql7VALF17YSjanY0EG/99dJfdntfjN/4PBmJ1v
iqkWNsa0yH4YcYh0OkDbJSmI8bURnqVAQ0a8cR8E062L38JDuntG4K6Ct6vYy5L9
Us7jHg5zYePwYZFlT2ouSF1Z5EnkDZnVEtsXBddzwwi5/ViJW363/c7q8Ag5Fy74
OzyzGD79nip/yPKcYQ/qugDKpfL0qKXwtCWUcKESnMSe++ZiYr4lsD/ldUJyWC6H
E47nrNRKs6R4jyjh1tEB
=Iqop
-----END PGP SIGNATURE-----

--a3t2iGEpV125HqlTjCJBODoeVOkoF1ixx--
