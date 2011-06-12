Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Jun 2011 11:52:00 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7788183.ksVBPEBuUP";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106121152.02177.sven@narfation.org>
Subject: [B.A.T.M.A.N.] Combination of flags in tt_query packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart7788183.ksVBPEBuUP
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

just looked a little bit closer at your tt_query implementation and was=20
reminded that we had a small discussion in IRC some weeks ago.

<ecsv> can those flags be mixed?
<ordex> mixed? in which way?
<ecsv> request | table -> still a valid package
<ecsv> sry, packet
<ordex> yes it is, because it means "I'm requesting a full table"
<ordex> all the combinations are valid

This sounds wrong when I look at the tt_query packet. There we have a tt_da=
ta=20
field which can used used exclusive by either TT_REQUEST (x)or TT_RESPONSE.=
=20
Therefore, it is not possible to use both flags at the same time. Can you=20
please explain how this is handled or otherwise change it so that only one =
bit=20
in flags is used to decide if it is an response or a request.

Maybe this was the result of the discussion with Marek about the roaming st=
uff=20
=2D but i don't think that it applies here.

Kind regards,
	Sven

--nextPart7788183.ksVBPEBuUP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN9IxAAAoJEF2HCgfBJntGtZkQANTtve2oLDl5YvMJsauBjXsA
bgARJzrGmH7k0TMfZHcYU4vcfWFVAR08cNjy/MBk7bTXVBXAPrPlDn2gqlTTdYPz
UYVStfHUAYkra+UTudr3KgUWvS37SW2Ivicgz1kDH6+OBco25r9s4LTXrWkV506y
otjL6LKwbLbMdmJw6RZe0mseUp5BZCmUVfgzfBU8Nu+PlvHyJMAHoRblPZfSWqQK
GrtZpCCdksNuznddGmdKVMohwuN6aJj3/TXZohd9pD+TpJZiqWBZkTFQ3O2k1/xa
2k3ESVVoE/3BuDJGWkJ2tj62SKRMdh/xY4CYc0pasPJ8qHtOK/npsvHWQbOSDvCQ
TkETFviFe1VmswE5Kp1698wejLOsAveOvxhKqbAstht72qHPV/drCT4wU9WmT2j7
CG0jxopjizaJcsjLUGjfZl3XhiCuDYc8d7ADaVqC1kpSrfr8oyzrtw8xIBPfgM45
SsBrPxBekEhNBpngiIQaW0p7b57S1iESMw/4y6NQfTeW1sQ30jE06IGTMZVl53bl
yJkyc2ZLMev6VCD8e8y7fPaIo1uz5GlAcd+ZlwENe4YbA6dbqFPd/Tjn/tTMnZYH
9mi/z1YIdaEtOzwc2n++xOd7V6pcReUdG2HKkIPhygKeK98JOCBcNIOTMEdzMYPV
d4FySOxdvWNihtInJls9
=giM/
-----END PGP SIGNATURE-----

--nextPart7788183.ksVBPEBuUP--
