Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Nov 2016 10:37:38 +0100
Message-Id: <20161106093738.17010-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7] alfred: Check batadv interfaces via
	netlink
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

From: Jean-Jacques Sarton <jj.sarton@t-online.de>

alfred is checking the status of the mesh interface before it starts. The
mesh interface has to have accessible debugfs files "transtable_global" and
"originators" before alfred will accept it.

batman-adv will not create debugfs entries for network namespaces. Thus
this check has to be modified to first check via netlink if the interface
is providing the same information without debugfs. If it does then no check
for the debugfs files is necessary anymore.

Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
[sven@narfation.org: fixed commit message, mark debugfs function static,
 fix whitespaces, fix unused init of variable, only fallback to debugfs on
 EOPNOTSUPP, rewritten batadv_interface_check_netlink, fix return of
 batadv_interface_check]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v7:
 - rewritten commit message
 - mark batadv_interface_check_debugfs static
 - fix whitespaces
 - fix unused init of variable ret
 - fix return of batadv_interface_check
 - only fallback to debugfs on -EOPNOTSUPP
 - introduce check_nlcmd_cb to stop netlink processing early
 - rewritten batadv_interface_check_netlink to not misuse get_tq_netlink_cb
v6:
 - sixth submission from Jean-Jacques
 - dropped basically the complete patch (doesn't apply)
v5:
 - fifth submission from Jean-Jacques
 - rewritten commit message
v4:
 - fourth submission from Jean-Jacques
 - rewritten commit message
 - introduced check for BATADV_CMD_GET_TRANSTABLE_GLOBAL
v3:
 - third submission from Jean-Jacques (corrupt)
v2:
 - second submission from Jean-Jacques (corrupt)
v1:
 - first submission from Jean-Jacques (corrupt)
---
 batadv_query.c | 16 +++++++++++++++-
 netlink.c      | 25 +++++++++++++++++++++++++
 netlink.h      |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/batadv_query.c b/batadv_query.c
index a671b79..c17132f 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 	return 0;
 }
 
-int batadv_interface_check(const char *mesh_iface)
+static int batadv_interface_check_debugfs(const char *mesh_iface)
 {
 	char full_path[MAX_PATH + 1];
 	FILE *f;
@@ -166,6 +166,20 @@ int batadv_interface_check(const char *mesh_iface)
 	return 0;
 }
 
+int batadv_interface_check(const char *mesh_iface)
+{
+	int ret;
+
+	enable_net_admin_capability(1);
+	ret = batadv_interface_check_netlink(mesh_iface);
+	enable_net_admin_capability(0);
+
+	if (ret == -EOPNOTSUPP)
+		ret = batadv_interface_check_debugfs(mesh_iface);
+
+	return ret;
+}
+
 static int translate_mac_debugfs(const char *mesh_iface,
 				 const struct ether_addr *mac,
 				 struct ether_addr *mac_out)
diff --git a/netlink.c b/netlink.c
index 1b5695c..73fab28 100644
--- a/netlink.c
+++ b/netlink.c
@@ -365,3 +365,28 @@ int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
 
 	return 0;
 }
+
+static int check_nlcmd_cb(struct nl_msg *msg __unused, void *arg __unused)
+{
+	return NL_STOP;
+}
+
+int batadv_interface_check_netlink(const char *mesh_iface)
+{
+	struct nlquery_opts opts = {
+		.err = 0,
+	};
+	int ret;
+
+	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
+				   check_nlcmd_cb, &opts);
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_query_common(mesh_iface, BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				   check_nlcmd_cb, &opts);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
diff --git a/netlink.h b/netlink.h
index b08e872..9bc75a1 100644
--- a/netlink.h
+++ b/netlink.h
@@ -49,6 +49,7 @@ int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
 int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
 		   uint8_t *tq);
+int batadv_interface_check_netlink(const char *mesh_iface);
 
 extern struct nla_policy batadv_netlink_policy[];
 
-- 
2.10.2

