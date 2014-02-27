Return-Path: <antonio@meshcoding.com>
Message-ID: <530F1360.8020302@meshcoding.com>
Date: Thu, 27 Feb 2014 11:28:48 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OtGObX5grBHjPIGoCIxro7KkJEDik2jxi"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batctl: fix wrong header lines
 number for local translation table
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
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OtGObX5grBHjPIGoCIxro7KkJEDik2jxi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/14 05:11, Linus L=C3=BCssing wrote:
> A commit in batman-adv has added a second header line to the local
> translation table output.
>=20
> Introduced by 59cb0861498776c62bd17584c31f34477fa301a0
> ("batman-adv: improve local translation table output")
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Nice catch! I think we should use the "-H" option a bit more often :)

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--OtGObX5grBHjPIGoCIxro7KkJEDik2jxi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTDxNkAAoJEEKTMo6mOh1VzJUP/15fLLkR+twT6bbQjJwDIIp2
EbQxpeUAfZ/xyK87n+kAsRiQyCwAMlrKu2SN33xPdRIY13/t5uuJYvYzk4UhIHZ8
v7rqIC9CSYBQV0rpKh030G/Pq4hxDgPFNRm8Q/nYCe10DKXffzTGwrTDygZJfS66
PhWBsdCS8jVHlYFkJjRHob6dRHkWp0TavQIhTbdzviuhMEQMqAL1eot7l3TWA0Po
I6e+NATD7QyaHeLzGuJmMUaV3YqXjeLAx8jAc+YnifCCKSv7TNSd8Gv10jwjlyk0
otGAjDDGjyr9Sfn0uesOXB3znvHnzE41kmN38bi239qV4rOGIERWCC3/yWu3T6DW
KkanBW6hO/Cb+ZpHIGaUlN54XZwPsW10soLYhEdCTMSOc3xlgUGUqlbiuYPqwVSh
phM+tch9svmm9zYcS0UB23PZzYwN8p2gGJj4VS/HCvQ1s5DQNNWYsMj1mAea6waU
op2QnDGFAxSLAi3nAbKMR+c+BhzPsTaMyQHrlyzU9ZyPxmEY0LKges/ZEAjQy5E9
+0vubJCA6zVxh5D/HvqMG3mfXVQpSCNeNjnieVUtZK4DeBx701fiIXCj4Y/34+hL
xc5G7JZ++eexP8BU29vsjlYgjqV81ZmURLYs30Y+KrooDAe85S/Kv1DisSYnhVQH
i4ZYFT5ON5YBCjNz8JDl
=ZND3
-----END PGP SIGNATURE-----

--OtGObX5grBHjPIGoCIxro7KkJEDik2jxi--
