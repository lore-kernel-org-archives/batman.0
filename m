Return-Path: <antonio@meshcoding.com>
Message-ID: <539726E7.9070500@meshcoding.com>
Date: Tue, 10 Jun 2014 17:40:23 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <53957653.5000406@meshcoding.com>
 <1402334059-28681-1-git-send-email-gaul@web-yard.de>
 <53962199.4060202@meshcoding.com> <539628F6.9070706@web-yard.de>
 <53969F3D.5040306@meshcoding.com> <5397267F.4040107@web-yard.de>
In-Reply-To: <5397267F.4040107@web-yard.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XRAahrWPGsXEEDoJqfkb9onqIKIPFM3GM"
Subject: Re: [B.A.T.M.A.N.] [PATCH] remove unnecessary logspam
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
Cc: =?UTF-8?B?QW5kcsOpIEdhdWw=?= <gaul@web-yard.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XRAahrWPGsXEEDoJqfkb9onqIKIPFM3GM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On 10/06/14 17:38, Andr=C3=A9 Gaul wrote:
> Hi Antonio!
>=20
> Am 10.06.2014 08:01, schrieb Antonio Quartulli:
>> maybe it's the mail client that messes the patch up? Are you using
>> git-send-email ?
>=20
> Yep, it's git-send-email. Maybe you are running into this mbox/eml issu=
e
> [1]? Thunderbird seems to save plain text files with DOS line endings
> when saved as .eml. I can reproduce the errors you got with an .eml
> file. When saving as .txt it has the correct line endings and the
> checkpatch script gives no errors or warnings.
>=20
> If this resolves the issue with the DOS line endings, I'd resubmit with=

> the corrected subject line.
>=20

Oh you are right. I should have continued using mutt...


Thanks! :)


--=20
Antonio Quartulli


--XRAahrWPGsXEEDoJqfkb9onqIKIPFM3GM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTlybvAAoJEJgn97Bh2u9eqaMP/iphEsWj4wI9jemCw3v4YvxH
Ne/hAV5urfGmCKmhKQjz8T1ht7FIDMlHOhh0ptlNBaIdTe4JSJdM4xQIjEoM3Hej
UogCAAP9shvrvBkaYXZa+87kQFQzC73lCUYdw54uI1rTdHQnvIFmxdMYLMSs+H2D
Y2Ma84q8bn0nH/i/49jkgqajtRMuEgxzWCnLR+0luVsVDBNinx+G6H95LwCG02JO
2mDjpb+wPAFykQTJ16aDzHqHVdTEgg2TXpLGP3QfY9u9PRuavj046bk+JWRiLcJx
JxHM2tfZJzWBiN5vCKszZUWkdBg8S6k5g/F3wtSCbSWlIxOFd0yVqEGI6RpRTUTG
d8L+luDedHGww1uWZLs3L4uykx05qvYISWQQY8zJSCp3mXxTB9V03dji70QbJYQ4
kZDjYO2rHP/M1GBHrOOQuz3n+kRbgzDb5Cz0oEB0SEHSZgMMtLwjhqF1fPvXJkpn
TzzIGorBQ8bHeZc/hW2zhnVT1WW0adADrnaxCowKK5ia3cvuo6lpI3/ZRYfA/LNQ
/vEoDP5KS8BbKx8oqSZNV2GzSbLJ1mf8yFcBeQFvVUAhspffnc0jAfjI5Fe6NuqN
Krcdo1LXVBgrOaKNyb5XdlXY8VqBH3JZp7QbYu5FbnMBPolRg/Vjq1QCwVEmyn1E
tN8qla2RkvP5uwIlocGd
=/r3A
-----END PGP SIGNATURE-----

--XRAahrWPGsXEEDoJqfkb9onqIKIPFM3GM--
