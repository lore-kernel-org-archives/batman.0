Return-Path: <antonio@meshcoding.com>
Message-ID: <52CA6676.2070108@meshcoding.com>
Date: Mon, 06 Jan 2014 09:16:54 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1388921809-4005-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1388921809-4005-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G3xEQ99Ih2QejCuI24DBiOD023abAWV7m"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use batadv_compare_eth when
 possible
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
To: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G3xEQ99Ih2QejCuI24DBiOD023abAWV7m
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/01/14 12:36, Antonio Quartulli wrote:
> When comparing Ethernet address it is better to use the more
> generic batadv_compare_eth. The latter is also optimised for
> architectures having a fast unaligned access.
>=20
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>

Martin,

I forgot to add you to the CC list :) Sorry!


Cheers,


--=20
Antonio Quartulli


--G3xEQ99Ih2QejCuI24DBiOD023abAWV7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSymZ6AAoJEEKTMo6mOh1VcTsQAJrYD2mTxgst8VobAm7NlgXg
ob+8uU+p9cX8R+er5HkQmg3KLn3IAYgzDk49vxesDNVihvBMMm/hDhgORxB+H/Le
amxCTsLY7Oc8T1TBCKGF0cQw8sLmNb/SmePd+C0KS17DvVii/cwRMOMJKLORxCBx
BcQoI4EDyYbQfpJpWFmMoLB8XsLGAKbV0otBgmoVmXaGATd4y5vbsrEpDuqLH2hk
07mV3GHDG5p8fZwNPAT5afDOBdZlERVMKQ+DeXxo0UFiJqww96eISNuvRmcquVeC
BakIiLQ9ob7uFdLUyWQTw3uOAoUMimnp+3hAPXk+jg9guHcPWt7DzOkNysi7imM1
I0FYPGrV8SMTS90B5Zs4/fr9D3K+NQEmIXOHEW1Vcn4RdrNDibA6/5sDlAYoTjza
4QkNL1zxqs/6tpzPqJs/Cw0miq/UhL/SWuELh3f84TNIHDig0xmQV4qj8tN0qNHG
oxAcVLdQ97SS4CVQ63P7UGElNb7wUSChdR6hGjs7UAMoaVmEoNAQcnS5VEO/8bgR
bZ2WXpXbRZq/kO7GVAyimhyfWI4L4664IFsGEMRzWIOQBIa/9PuQYQP3XiL3XXhn
g9++g0XXfMKIymR+7W8Lkk2PvdMrg+KiQKN7zhptd2WG/0XJ8kow0ia5EuA4/Uez
44XYnfTCIPfJV4MKUlv4
=qObx
-----END PGP SIGNATURE-----

--G3xEQ99Ih2QejCuI24DBiOD023abAWV7m--
