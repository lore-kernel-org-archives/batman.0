Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 11 Mar 2010 23:33:14 +0100
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<1268342346-13713-1-git-send-email-linus.luessing@web.de>
	<201003112306.48652.sven.eckelmann@gmx.de>
In-Reply-To: <201003112306.48652.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3424493.6YdsMTFPEd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003112333.15318.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3424493.6YdsMTFPEd
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> #define seq_before(x,y) ((x - y) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
> #define seq_after(x,y) ((y - x) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
> ....

That must be=20
#define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
#define seq_after(x,y) ((y - x) > 1 << 7 + 8 * (sizeof(x) - 1))

Or otherwise it would be wrong balanced between equal, after and before. In=
=20
other words: For every x in N0 and y in N0 is only one true of (x =3D=3D y)=
 or=20
seq_before(x, y) or seq_after(x, y) after the change of >=3D to >

Best regards,
	Sven

--nextPart3424493.6YdsMTFPEd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLmW+qAAoJEF2HCgfBJntGwAkQAMWn48ncfR2wxnoim567RZ09
ihuk1AJjikv0+3SUTZn68uz2kf7DEr/APP11LHljaCPTMrMvdftSqniQNd2xgxt0
ekhXXFKrAFG2flP2RSMJCO7b3zC0QqX4uQqIRPqS1usMYBIa1gkAxR3gGzIqGxy0
wIJ5/bBHAO4moJh+WBmjjP/NSMYCtlNwAn/3qbCQf3wOd58q/5d5rTfbPJ8W46BN
7ik8G/1WI3mSLmH2Dvp6WgnBkNVsVUuSyySughcp1pDpzd9ICS5xkfqzQ6ht8Dtm
1b4eTsOOveTyTuW7oaORk971uNczaT+0CKBaEB6PDPVNDTJCoRmlvcyyLO2pM4pj
sBIKW7mo3EkrYteXynQRj5B95xXCF0/6rE0RrWDTLx/epkdUr0r4i3nZ++kTqyYV
LilrPFlh8BPvm9B1+mEpTVx83O8MEqx3N2Ua06dNv9As4n/09TPtWLHNtilLIsOc
3ZV3FVUVftchSJu805f05kGc6anN/V7SpVzHWLY/DqDJgIgKD0H497UghquAZf2E
RytuMxtpUfdSrv6oWxCfx7oBf3XEf8UzFtb5wShc+NuM5Fa9BiAnxuyZJ1lsKEAB
RiVidS3Ns0WXNyr/NQ0Sv2f9iOMTuT0Tvw+8ENDNbGWB34MerUhMAqxTUnK0xa6U
zRbnZ3PLF+AB2VcEwu6t
=Sqw0
-----END PGP SIGNATURE-----

--nextPart3424493.6YdsMTFPEd--
