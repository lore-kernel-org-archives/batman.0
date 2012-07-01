Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 01:43:36 +0200
Message-Id: <1341186226-10549-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1341186226-10549-1-git-send-email-ordex@autistici.org>
References: <1341186226-10549-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/16] batman-adv: Prefix local debugfs
	structs with batadv_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_debugfs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_debugfs.c b/net/batman-adv/bat_debugfs.c
index 4dcda43..bd618e4 100644
--- a/net/batman-adv/bat_debugfs.c
+++ b/net/batman-adv/bat_debugfs.c
@@ -265,13 +265,13 @@ static int batadv_vis_data_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_vis_seq_print_text, net_dev);
 }
 
-struct bat_debuginfo {
+struct batadv_debuginfo {
 	struct attribute attr;
 	const struct file_operations fops;
 };
 
 #define BATADV_DEBUGINFO(_name, _mode, _open)		\
-struct bat_debuginfo batadv_debuginfo_##_name = {	\
+struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 	.attr = { .name = __stringify(_name),		\
 		  .mode = _mode, },			\
 	.fops = { .owner = THIS_MODULE,			\
@@ -294,7 +294,7 @@ static BATADV_DEBUGINFO(transtable_local, S_IRUGO,
 			batadv_transtable_local_open);
 static BATADV_DEBUGINFO(vis_data, S_IRUGO, batadv_vis_data_open);
 
-static struct bat_debuginfo *batadv_mesh_debuginfos[] = {
+static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	&batadv_debuginfo_originators,
 	&batadv_debuginfo_gateways,
 	&batadv_debuginfo_transtable_global,
@@ -308,7 +308,7 @@ static struct bat_debuginfo *batadv_mesh_debuginfos[] = {
 
 void batadv_debugfs_init(void)
 {
-	struct bat_debuginfo *bat_debug;
+	struct batadv_debuginfo *bat_debug;
 	struct dentry *file;
 
 	batadv_debugfs = debugfs_create_dir(BATADV_DEBUGFS_SUBDIR, NULL);
@@ -340,7 +340,7 @@ void batadv_debugfs_destroy(void)
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
-	struct bat_debuginfo **bat_debug;
+	struct batadv_debuginfo **bat_debug;
 	struct dentry *file;
 
 	if (!batadv_debugfs)
-- 
1.7.9.4

