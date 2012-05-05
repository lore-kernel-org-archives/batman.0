Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 May 2012 17:29:25 +0200
Message-ID: <7681860.DNINY4YzOT@sven-laptop.home.narfation.org>
In-Reply-To: <33fd135ed9ad65c70bd3a509b538f1d59fa20fef.1336230279.git.mschiffer@universe-factory.net>
References: <33fd135ed9ad65c70bd3a509b538f1d59fa20fef.1336230279.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8459531.O9TyjaAy8A";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix visualization output
	without neighbors on the primary interface
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


--nextPart8459531.O9TyjaAy8A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

WARNING: line over 80 characters
#102: FILE: vis.c:236:
+                               if (compare_eth(entries[j].src, packet->vis_orig))

WARNING: line over 80 characters
#123: FILE: vis.c:287:
+                               if (compare_eth(entries[j].src, packet->vis_orig))

total: 0 errors, 2 warnings, 0 checks, 47 lines checked

http://www.open-mesh.org/wiki/open-mesh/Contribute#Submitting-patches

Thanks,
	Sven
--nextPart8459531.O9TyjaAy8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPpUdVAAoJEF2HCgfBJntGTn8P/iXzBPfEXym4YBDjI9C+/q0c
04YWDJLpO7S7i7c7EzyW4iFBNQAUedaYpUkXG/ZJ9+bmpu3wPJ1G7/uLgYP5B/vq
eGpnX/CVa5AK/hNd8pJfRGe4iZ3Z+/+xwhs5aMEKW90QUT4zn+lbVSPjTSgunQt6
CIPBtjDuwZvt+QDf7AsIuUo4PVDJJvpBv8vJ0LRuTSvJoplMMaX5uuoKk8kRijFH
HyLY/HZ8f/bthpm96ZuZS73eIJpDZBOeFnsG3QUGCv7cHKJAcHhanzVjSjyzqEaI
+g0QIdnIeCKugBSzEXQGuV5Kj+tloGwZgUVlyn+WmLMZreyzj+Tw99ysg1JORbA+
FeCrCUtx28w9WeQurydGaepolWVAKkIOssKS1zhjSs8tEfy8lD0nTI+XyzR/JmlZ
98rH2LbxirU0bfrURVb4P9BLuKzVx3EU/d9i93PXElGR4SrGxZSq1sQRQVKiKdkb
ZaypWvdb1RjnfZtFHeb6b1L+qb58wz2M6W5FshEqQpV1IGkUlLc87R/qHrjO04Em
V26XecrQazTj9l3l72SffovyRqHRJZqBK7MNTkYXcKnveHKVFZ0tZeiG4DpQTdGd
04pkNTAO+1s1MbK2TpuXiMyOK0d+XbPazqwAm5a3v8Jv6uKrEmPeivWR133gNNIy
LNrWcks26CzCvrQL7ndO
=kSGZ
-----END PGP SIGNATURE-----

--nextPart8459531.O9TyjaAy8A--

