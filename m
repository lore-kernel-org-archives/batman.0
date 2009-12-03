Return-Path: <linus.luessing@web.de>
Date: Thu, 3 Dec 2009 01:24:07 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091203002407.GA10048@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] Updating orig_str for debug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In commit 1488 the orig_str has been removed from
purge_orig_neighbours(). Apparently, this breaks compilation when
enabling debug-flags, as bat_dbg() is expecting this variable as a
parameter. Actually, this variable has never been initialised also
before commit 1488 (which was probably the reason for mistakenly
removing it).
This tiny patch adds the orig_str again, but initialises it now as
well.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
---

Index: originator.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- originator.c        (revision 1489)
+++ originator.c        (working copy)
@@ -163,7 +163,7 @@
                                 struct neigh_node **best_neigh_node)
 {
        struct list_head *list_pos, *list_pos_tmp;
-       char neigh_str[ETH_STR_LEN];
+       char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
        struct neigh_node *neigh_node;
        bool neigh_purged =3D false;
=20
@@ -179,6 +179,7 @@
                                ((PURGE_TIMEOUT * HZ) / 1000)))) {
=20
                        addr_to_string(neigh_str, neigh_node->addr);
+                       addr_to_string(orig_str, orig_node->orig);
                        bat_dbg(DBG_BATMAN, "Neighbour timeout: originator =
%s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->las=
t_valid / HZ));=20
=20
                        neigh_purged =3D true;

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLFwUmAAoJEBKw7u43QNpfxiYP/2kIn4G63wvUTZMRtoyOGUZK
1e8t5VnzW98fdmgPNDq+inHs8+Fqekp7p+RPGWbsJP6a6ZM1+3P3xMMy63KZqVCF
78+ofWDcPnJkbDEEhzd4gq3jd3jPQmvwdKZdsiGVkp5jNwzQ+7pdmGscL9tTTk1Q
zePNHFofnnRf3z483yDS71PXu4LCp1r6q0Z6CgcV73a/NfsS9ZzAti/d2YDL9VBD
tOShNebTTuXPXqNlqzy7+V/eKA5wwP7tpNoJM3dZv9fdcRWVnOxhU33RoLMglFLu
xYp2jgNtGxiT6XDCdzdrcBonxFNPV1nWh7DmIf+AZXel2TL0Q/t4lzqy/Y2Lqx1Z
8m9SyfyeLbIk+8ELrp44Gc/ZlCepgXfLm7IT2VYXxVIIYIIKTWPZOGUNO6JEpkE3
Fj8uire+rFtsQgGXJ00Zueq3mbl5qnHoNwRvuQbW1WXMdHMzCgwUqPR3WD08RKZE
0JiIQkWz9XCY+b2/j4hxqQlPL72nGll4S4xaCOBSWsiCYCpfHQmdMI+XQeuwPxjt
lAh9Ywsag0t0QLaTD6mLdZxzOxDceicwS9DlHReXGkmtgVEi8vZSAcZCvoEBSfdC
d9PIkqKg09jKaaKVAtqfqZiprKhitUFQlsoqtQbFSYNoqGZ3WfSXqZlZod6sif/l
1ZO/gezblo/vhPR353qC
=qRHt
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
