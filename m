Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 14 Oct 2012 22:03:00 +0200
Message-Id: <1350244981-14026-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: support array of debugfs
	general attributes
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

This patch adds support for an array of debugfs general (not soft_iface
specific) attributes. With this change it will be possible to add more general
attributes by simply appending them to the array without touching the rest of
the code.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 debugfs.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 61c7d4d..43e0fde 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -328,7 +328,17 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 		}					\
 };
 
+/* the following attributes are general and therefore they will be directly
+ * placed in the BATADV_DEBUGFS_SUBDIR subdirectory of debugfs
+ */
 static BATADV_DEBUGINFO(routing_algos, S_IRUGO, batadv_algorithms_open);
+
+static struct batadv_debuginfo *batadv_general_debuginfos[] = {
+	&batadv_debuginfo_routing_algos,
+	NULL,
+};
+
+/* The following attributes are per soft interface */
 static BATADV_DEBUGINFO(originators, S_IRUGO, batadv_originators_open);
 static BATADV_DEBUGINFO(gateways, S_IRUGO, batadv_gateways_open);
 static BATADV_DEBUGINFO(transtable_global, S_IRUGO,
@@ -363,7 +373,7 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 
 void batadv_debugfs_init(void)
 {
-	struct batadv_debuginfo *bat_debug;
+	struct batadv_debuginfo **bat_debug;
 	struct dentry *file;
 
 	batadv_debugfs = debugfs_create_dir(BATADV_DEBUGFS_SUBDIR, NULL);
@@ -371,17 +381,23 @@ void batadv_debugfs_init(void)
 		batadv_debugfs = NULL;
 
 	if (!batadv_debugfs)
-		goto out;
+		goto err;
 
-	bat_debug = &batadv_debuginfo_routing_algos;
-	file = debugfs_create_file(bat_debug->attr.name,
-				   S_IFREG | bat_debug->attr.mode,
-				   batadv_debugfs, NULL, &bat_debug->fops);
-	if (!file)
-		pr_err("Can't add debugfs file: %s\n", bat_debug->attr.name);
+	for (bat_debug = batadv_general_debuginfos; *bat_debug; ++bat_debug) {
+		file = debugfs_create_file(((*bat_debug)->attr).name,
+					   S_IFREG | ((*bat_debug)->attr).mode,
+					   batadv_debugfs, NULL,
+					   &(*bat_debug)->fops);
+		if (!file) {
+			pr_err("Can't add general debugfs file: %s\n",
+			       ((*bat_debug)->attr).name);
+			goto err;
+		}
+	}
 
-out:
 	return;
+err:
+	debugfs_remove_recursive(batadv_debugfs);
 }
 
 void batadv_debugfs_destroy(void)
-- 
1.7.12.3

