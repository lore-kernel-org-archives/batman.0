Return-Path: <antonio@meshcoding.com>
Message-ID: <53031D28.4000006@meshcoding.com>
Date: Tue, 18 Feb 2014 09:43:20 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CACgQMV++TDB_HSdLmXR+GeVWGaVL9dPA7YmGV1F33Ahde0Q7bQ@mail.gmail.com>
In-Reply-To: <CACgQMV++TDB_HSdLmXR+GeVWGaVL9dPA7YmGV1F33Ahde0Q7bQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="epbRmrh003qA3ixn0VRx4c2ueuh2riE6B"
Subject: Re: [B.A.T.M.A.N.] Hiding the ad-hoc network
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--epbRmrh003qA3ixn0VRx4c2ueuh2riE6B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/02/14 09:41, Dirk van der Walt wrote:
> Hi List,
>=20
> Although not strictly Batman-adv related I was wondering if someone
> here knows how to 'hide' the Ad-hoc network of the mesh.
>=20
> Another person asked the same on the OpenWrt forum but no-one gave him
> a proper or clear answer:
>=20
> https://forum.openwrt.org/viewtopic.php?id=3D44665
>=20
> I've managed to get hold of him and he said he still has no clear
> answer on this one.
>=20

"Hiding" means not broadcasting the SSID (like it can be configured for
AP mode) and this is not allowed by the current cfg/mac80211 kernel modul=
e.
It is quite out of the standard and requires some "hacks" that the
maintainers will probably never like.


Regards,


--=20
Antonio Quartulli


--epbRmrh003qA3ixn0VRx4c2ueuh2riE6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTAx06AAoJEEKTMo6mOh1VabgP/1iup1bQMUAbsR9IcCgjbI5R
AgMIpzUy84hEFIpZA1sEug8KLYLrH/6Yik/myPqfbhG/vT3J++H4/NVHMsPzzH2W
rBrGvpruf+v5MJxsSfkUpu1ckBjvMNbIbvSgYaewPxeUce5LTBSrokYSx5N4oLMU
AmTGWeOtyNuBvZznObEVRa21ZCbAkO3Oi8ataSOJc8uJHKBU8lZMHnIyfE1MKrAT
DAS6tetL26DwjbbD+q82uwYX1I4YD7O1HmNRPHutSDn89/Wif/bnbMQ9QDIwYHPz
bs99FfE/+g7x0OjPf1iwidmTMkRaL1bciq34rTaS1GqYJbSayyJfb2vmRPOTYxaf
78uFzzOifloxw9V4C5RmIhLrTeEYWmzIMfUGJOMdUu8I2DbuT+lLLcIEBKciQlNc
coiE1Oipl0VSKRSrlcR7P5y4HGtOswCk0ymAERbD2gNCiyJj/5ocYi0rWBM+MFdr
6Rciju/57Pbm1b1l1WtkXOoQmMY6ooNLBd6F/TpGEcjzYhWoriBJWxcZ8Sa0xFvd
jHoPRZ3LE/atOGhmoarfsyCrqrwLmhVTOcz4IC9I8HfaEnpyAj3wWLceBQ6cFZxY
o/qQDywuy9q7cLbRelk6RwbJQZYTNAiV7ocJXVbbmcjkkA8dGd7FmIJKdiF7oidY
q3tSj5kl42sgNfTV7cJ1
=Ixu6
-----END PGP SIGNATURE-----

--epbRmrh003qA3ixn0VRx4c2ueuh2riE6B--
