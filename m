Return-Path: <jj.sarton@t-online.de>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <735c49a8-6ccd-9932-5835-27b59b3f1c98@t-online.de>
Date: Tue, 1 Nov 2016 16:20:07 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q5Os8q0kgBNFwJ0IA3OILnmFhhW0KnTq6"
Subject: [B.A.T.M.A.N.] =?utf-8?q?PATCH_a=C3=B6fred_don=27t_start_idz_with?=
	=?utf-8?q?in_a_network_spaxce?=
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5Os8q0kgBNFwJ0IA3OILnmFhhW0KnTq6
Content-Type: multipart/mixed; boundary="359DOUVbO2LRGftrig5jVT0agNvSKs0cV";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <735c49a8-6ccd-9932-5835-27b59b3f1c98@t-online.de>
Subject: =?UTF-8?Q?PATCH_a=c3=b6fred_don't_start_idz_within_a_network_spaxce?=

--359DOUVbO2LRGftrig5jVT0agNvSKs0cV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello I hope that this will be a valid patch.

This patch shall allow to use the debugfs as previouly, including
the check for valify of the interface used.
For netns the check seem to be implemented within the function
netlink_query_common().
For netlink we check if the originators ans transtable_global
informations are accessible through netlink.


Signed-off-by: jj.sarton@t-online.de
---
diff --git a/batadv_query.c b/batadv_query.c
index a671b79..dc8a042 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct e=
ther_addr *mac)
        return 0;
 }

-int batadv_interface_check(const char *mesh_iface)
+int batadv_interface_check_debugfs(const char *mesh_iface)
 {
        char full_path[MAX_PATH + 1];
        FILE *f;
@@ -166,6 +166,18 @@ int batadv_interface_check(const char *mesh_iface)
        return 0;
 }

+int batadv_interface_check(const char *mesh_iface)
+{
+       int ret =3D 0;
+       enable_net_admin_capability(1);
+       ret =3D batadv_interface_check_netlink(mesh_iface);
+       enable_net_admin_capability(0);
+
+       if ( ret < 0 )
+               return batadv_interface_check_debugfs(mesh_iface);
+       return 0;
+}
+
 static int translate_mac_debugfs(const char *mesh_iface,
                                 const struct ether_addr *mac,
                                 struct ether_addr *mac_out)
diff --git a/netlink.c b/netlink.c
index 1b5695c..9288770 100644
--- a/netlink.c
+++ b/netlink.c
@@ -365,3 +365,30 @@ int get_tq_netlink(const char *mesh_iface, const str=
uct ether_addr *mac,

        return 0;
 }
+
+int batadv_interface_check_netlink(const char *mesh_iface)
+{
+       struct get_tq_netlink_opts opts =3D {
+               .tq =3D 0,
+               .found =3D false,
+               .query_opts =3D {
+                       .err =3D 0,
+               },
+       };
+       int ret =3D 0;
+
+       memset(&opts.mac, 0, ETH_ALEN);
+
+       ret =3D netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINAT=
ORS,
+                                  get_tq_netlink_cb, &opts.query_opts);
+       if (ret < 0)
+               return ret;
+
+       memset(&opts.mac, 0, ETH_ALEN);
+       ret =3D netlink_query_common(mesh_iface, BATADV_CMD_GET_TRANSTABL=
E_GLOBAL,
+                                  get_tq_netlink_cb, &opts.query_opts);
+
+       if (ret < 0)
+               return ret;
+       return 0;
+}
diff --git a/netlink.h b/netlink.h
index b08e872..9bc75a1 100644
--- a/netlink.h
+++ b/netlink.h
@@ -49,6 +49,7 @@ int translate_mac_netlink(const char *mesh_iface, const=
 struct ether_addr *mac,
                          struct ether_addr *mac_out);
 int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,=

                   uint8_t *tq);
+int batadv_interface_check_netlink(const char *mesh_iface);

 extern struct nla_policy batadv_netlink_policy[];


--359DOUVbO2LRGftrig5jVT0agNvSKs0cV--

--Q5Os8q0kgBNFwJ0IA3OILnmFhhW0KnTq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgYsqcWHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
CzWqAJ4rFKHnNj3n4gMF47T7954mlleMRgCeP4ZhqZDvTRRvpoW7HAbTs436XSM=
=UqX1
-----END PGP SIGNATURE-----

--Q5Os8q0kgBNFwJ0IA3OILnmFhhW0KnTq6--
