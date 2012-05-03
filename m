Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 03 May 2012 08:26:40 +0200
Message-ID: <4871527.FqzISMEzZu@bentobox>
In-Reply-To: <20120502211612.GB2093@ritirata.org>
References: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
	<20120502211612.GB2093@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2328720.PmtILdMkdu";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Change "make install" path
	and run depmod
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>


--nextPart2328720.PmtILdMkdu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 02, 2012 11:16:13 PM Antonio Quartulli wrote:
> would it be cleaner to run depmod -e $(uname -r) instead of using -a ?


Why? The module doesn't have to be build for the current kernel.

Kind regards,
	Sven
--nextPart2328720.PmtILdMkdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPoiUgAAoJEF2HCgfBJntG6rgQAIkw8hsFlIen4XZ6T5APVFD9
GtuGb7ObD7W0x6mMx3/jTf9GthxaSYp2t1abE9yN6qnSjysHDiww8PULIfLO5Xk7
dvTXgaXkQwEf14T9atSKzLQoja2oUXOjOlYumn2A+hzUYZxS8dkmrVfVAqHJwxHw
o8fjGjqJUIwZQWlw17PHjAFE6Hd17iUe62sY1yCVR3+jidSgwSADvbXZGXyRIdwg
DZlNQm/fAcbXgyhsllr1mPVFIorV8tpX7XcyK7pI7QAhAMjMHvIaU8hJ27t82a4Q
Tg1IKuXUgm1YD+xHWi9q0T900k187HkRHnndlxHboeu86VLap54lhHFA04WMIUgv
VaFlFb4/lzRXK8+LYlbt/6Foi7VuqGdUdASytsacNlcyTUzt/BHH0Hk0dyUCFn6u
2SU5PFgzAC06RYW4l6eOqEVDtxXD0csXroc2vLVODSRb4h5jE52cy0tIY8QcI8N4
EoM0qWj5eCK4Y4Ef7+DrB2LAk3iyPhw+CCYPV7xFsNRpbw6XUY5WoPB6D/1OmwoD
OfbzG39MMMmY0tgozhEgNDR5A8LGT+6JIN1xYJeGIvGtk19IV+VcGM9/qu+wpvMb
Xqg2MJteuEm4xaRqM++DJnos39o1RmaA6JTU5vKtlfS7Hjs0lE5jlwVIOJIwycWM
EwQRxKRFy+sGpLe/8wOg
=k+dM
-----END PGP SIGNATURE-----

--nextPart2328720.PmtILdMkdu--

