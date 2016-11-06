Return-Path: <jj.sarton@t-online.de>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <5944fa3d-ab98-176d-aac2-a1412590c174@t-online.de>
Date: Sun, 6 Nov 2016 08:29:27 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F8R0ta1iLAGJKVKam0hDvW8tnbOcnDwlU"
Subject: [B.A.T.M.A.N.] [PATCH v2] Alfred not working within network name
	space
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jean-Jacques Sarton <jj.sarton@t-online.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F8R0ta1iLAGJKVKam0hDvW8tnbOcnDwlU
Content-Type: multipart/mixed; boundary="v6v13iA8MTpqv3PCkEDTUrWLd62eCV5vI";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: b.a.t.m.a.n@lists.open-mesh.org,
 Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <5944fa3d-ab98-176d-aac2-a1412590c174@t-online.de>
Subject: [PATCH v2] Alfred not working within network name space

--v6v13iA8MTpqv3PCkEDTUrWLd62eCV5vI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

scope of function corrected, has to be static

Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
---
 batadv_query.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/batadv_query.c b/batadv_query.c
index dc8a042..69f5a48 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct e=
ther_addr *mac)
 	return 0;
 }

-int batadv_interface_check_debugfs(const char *mesh_iface)
+static int batadv_interface_check_debugfs(const char *mesh_iface)
 {
 	char full_path[MAX_PATH + 1];
 	FILE *f;
--=20
2.7.4



--v6v13iA8MTpqv3PCkEDTUrWLd62eCV5vI--

--F8R0ta1iLAGJKVKam0hDvW8tnbOcnDwlU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlge29cWHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C1z9AJ4rLO+ao9ijhQ7Aen9Xj3j9SFPZpQCePbUf6yuT1cShSFH44F15yEJrFGs=
=m1os
-----END PGP SIGNATURE-----

--F8R0ta1iLAGJKVKam0hDvW8tnbOcnDwlU--
