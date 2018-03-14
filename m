Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Mar 2018 11:25:11 +0100
Message-ID: <11982076.7SjS3eRglR@bentobox>
In-Reply-To: <20180313104358.19895-1-linus.luessing@c0d3.blue>
References: <20180313104358.19895-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22707354.SiqetoPzCU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/4] batctl: netlink support for DAT
 and MCAST
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

--nextPart22707354.SiqetoPzCU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 13. M=E4rz 2018 11:43:54 CET Linus L=FCssing wrote:
> This patchset adds netlink support for dumping DAT cache and multicast
> flags tables.
>=20
>=20
> Changes in v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - renamed netlink attributes:
>   - BATADV_ATTR_DC_ADDRESS   -> BATADV_ATTR_DAT_CACHE_IP4ADDRESS
>   - BATADV_ATTR_DC_HWADDRESS -> BATADV_ATTR_DAT_CACHE_HWADDRESS
>   - BATADV_ATTR_DC_VID       -> BATADV_ATTR_DAT_CACHE_VID
>=20
> Changes in v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> - Removed htonl() conversion for BATADV_ATTR_DC_ADDRESS as batman-adv
>   now provides it in network byte order (via nla_put_in_addr() )
> - Increased BATADV_ATTR_MCAST_FLAGS and BATADV_ATTR_MCAST_FLAGS_PRIV
>   size from 8 to 32 bits to enhance extensibility
> - Changed mcast_flags error value from -EINVAL to -ENOTSUPP to allow
>   a fallback to and retry via debugfs, for compatibility with older
>   batman-adv versions
>=20

Applied in bfff37a..b560610 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/c353d3a0da6068fd759ebf96727=
189fcc3c3dbae
    https://git.open-mesh.org/batctl.git/commit/33260655b3b029b05f76fbc71d1=
bcdd4aa5c655b
    https://git.open-mesh.org/batctl.git/commit/c1bb431577f1b2a4250a780f9c2=
9355eb3694ff9
    https://git.open-mesh.org/batctl.git/commit/b56061058113913c9e16b388761=
b873ab216e1d4
--nextPart22707354.SiqetoPzCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqo+IcACgkQXYcKB8Em
e0Yixg/7BAzQ25OqAqMplJNmtI3Kvj7bj3kiFwjTCISELrK73xR/08ELerAHnemA
eS5pAIjHkrE7lqqymP54QxKf1pj6nv6BHIYaGBga1faGZz9LMn3DTqWtPyzytwPr
wS2tAfYOW9tutNQYk+3twy8R04FNjT/xJWN6nsI3fgsVd3kBLHz4+Wb03V1CP5Gn
kCbb2QIFCFN40s8znAAWhfuOP8PmzUDliQKDN6vxfXuOOPFlwHZ7fCKZK3qw7NGu
c4En7piXYFLTdtaSsE7lQoOpmIpcMy7H0smFZRjzIcgISnbj0fbVcKrZhOpDMXeg
tKrSp7JXJeqhctraT5cBLXmh9bZfR6rSxxB5WaXMmtXWkJO6vPFxKHNhSjBpTfnw
4R0XhwdFqJdwARNLyeIJwXFM/RTCE8nhDhyIXknUjIv/TrMR6rF39po3JYpB2VBv
db3yY0mupR9oVNcjFe1ex1BbEY8kS9uLDJhqhW07VGUQTnVS61Yl+jtG0Hpikszf
oTJEHPK/aTAEssEqaovOBIAivKgscjRI6rOh5q6SAEDJeMZ4FT46omqF5ZEsCXjE
Oa34GTf3y6i3rpfC48uCJ3NNtHvoNxxBG8xuhWlUbmowAxx9hujB72t+wR8+P+1P
8MLvEnslFrrP1/vUmOjd13a7jVScU/QNMrQz/PbvlOerCVKPnYc=
=Vamx
-----END PGP SIGNATURE-----

--nextPart22707354.SiqetoPzCU--

