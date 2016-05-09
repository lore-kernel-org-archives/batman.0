Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Mon, 09 May 2016 18:39:57 +0200
Message-ID: <6307812.WAqRcEYAvX@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4559634.SJDs4U7Ugh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v7 0/8] batman-adv: throughput meter
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

--nextPart4559634.SJDs4U7Ugh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I was told that the general approach seems to be ok. I have therefore prepared
the compatibility wrapper for multicast netlink for Linux <3.12. The batctl
patches didn't change but were only resubmitted.

The changes since v6:

 * add compatibility code for v3.13
 * make batadv_netlink_mcgrps non-const because v3.12 needs it writable

The changes since v5:

 * increase total_bytes to 64 bit to allow links with higher speeds/longer
   test times

The throughput meter patches aren't marked anymore as RFC because now the
actual implementation should be discussed.

Kind regards,
	Sven
--nextPart4559634.SJDs4U7Ugh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXML1dAAoJEF2HCgfBJntGeW0QAJaksNXLECImtwux1ZMdhZr4
kC0mC2g4+kWlaQIXDO223wq9MzwXF5PaTc4muYYsEI5ZUvnV3/Ug9WOYK6KHiMvz
4Ze30ys9HA1bd1FDEYovv6uixIgM7ReqK8wH1K5JcgkQ/670L/LtXi1weW65hWJY
uu0tGtk3LpGyjDnWfojoztcjdpTS8Y3mU2uFPEqlydngfR1fZ9NxfY4FaU9XIsoI
J7u2vrLjxUyxVebHXxEriyankz7n47YQ+uSY/11+CZvrNAaW3Dp85ciyoZOLyssH
vhtHZxZrcXjqdj9mRvVKqiJDEOSdjCXb/9+UF/d9FiG/DP6HOxdBPBi/i9WRagwS
Ptj5ZV65zqo7XlcPHcCEPSJL6tnx0nmS7SEBsmm1MpQ6uoWcxnS7rvtcZjT+EB04
VlJA+ifyL6Gf+n9KgjZ7opvD0B/JHpaapPmN1CKVq+iXswA6Ox+2iwrcQy+6Uzp7
uopmlWVvp6cxEE57hPXVegP2zRhZlODdT3j1RkT0bKNSE9e5G7HUyh4e0cGhUlf1
9ZPBMxIjOAtPHDHaD1mKtz7VwrC7HDwrF0PJjsi6WWfnSty+B2/vH0bpcIGwrkEW
8PBIi8NcgDRQfyDIRqp0tDHK4i8sSXbCVfl5EXcMKSWKjsrWMmTGdKxdYy/XlkBb
nugVEZpqAc1UyAyQrfg3
=pZWU
-----END PGP SIGNATURE-----

--nextPart4559634.SJDs4U7Ugh--

