Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 30 Jul 2014 17:37:49 +0200
References: <1406649982-3577-1-git-send-email-sven@narfation.org>
In-Reply-To: <1406649982-3577-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12028690.e6HFluyzxm";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201407301737.53582.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: add more debug output for libc
	errors
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

--nextPart12028690.e6HFluyzxm
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> perror(..) can automatically decode the errno variable and print more
> information for an error.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in commit c9f5a5d.

Thanks
     Simon

--nextPart12028690.e6HFluyzxm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPZEU0ACgkQrzg/fFk7axbS0gCgyKfG4YodSX1a6As5RkUJ3HuK
864AoLTOKSuq8/qjGi2xOjif1Tzfi5x0
=Gu4U
-----END PGP SIGNATURE-----

--nextPart12028690.e6HFluyzxm--
