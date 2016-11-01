Return-Path: <jj.sarton@t-online.de>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <b861d75b-1ece-c8d6-a7cf-1b26b2c47bfb@t-online.de>
Date: Tue, 1 Nov 2016 20:07:24 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7Qiqjo0C6sWchM4KNmPcrsluWA2NNoDqB"
Subject: [B.A.T.M.A.N.] [PATCH] Alfred not working within network name space
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
--7Qiqjo0C6sWchM4KNmPcrsluWA2NNoDqB
Content-Type: multipart/mixed; boundary="v3wVooRdu06VjNPLsTIxOC2rBf6aBa8rA";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <b861d75b-1ece-c8d6-a7cf-1b26b2c47bfb@t-online.de>
Subject: [PATCH] Alfred not working within network name space

--v3wVooRdu06VjNPLsTIxOC2rBf6aBa8rA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch shall allow to use the debugfs as previouly, including
the check for valify of the interface used.
For netns the check seem to be implemented within the function
netlink_query_common().
For netlink we check if the originators ans transtable_global
informations are accessible through netlink.

To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
---
 batadv_query.c | 14 +++++++++++++-
 netlink.c      | 27 +++++++++++++++++++++++++++
 netlink.h      |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

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
+	int ret =3D 0;
+	enable_net_admin_capability(1);
+	ret =3D batadv_interface_check_netlink(mesh_iface);
+	enable_net_admin_capability(0);
+
+	if ( ret < 0 )
+		return batadv_interface_check_debugfs(mesh_iface);
+	return 0;
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
+	struct get_tq_netlink_opts opts =3D {
+		.tq =3D 0,
+		.found =3D false,
+		.query_opts =3D {
+			.err =3D 0,
+		},
+	};
+	int ret =3D 0;
+
+	memset(&opts.mac, 0, ETH_ALEN);
+
+	ret =3D netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
+			           get_tq_netlink_cb, &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	memset(&opts.mac, 0, ETH_ALEN);
+	ret =3D netlink_query_common(mesh_iface, BATADV_CMD_GET_TRANSTABLE_GLOB=
AL,
+			           get_tq_netlink_cb, &opts.query_opts);
+
+	if (ret < 0)
+		return ret;
+	return 0;
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

--=20
2.7.4



--v3wVooRdu06VjNPLsTIxOC2rBf6aBa8rA--

--7Qiqjo0C6sWchM4KNmPcrsluWA2NNoDqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgY5+wWHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C+mIAJ90SO2BS8Y/wvgE0QiJtt8CJ7fznACfeSwa+IChQra5nxI/XMIr7LCtF0o=
=nx5s
-----END PGP SIGNATURE-----

--7Qiqjo0C6sWchM4KNmPcrsluWA2NNoDqB--
