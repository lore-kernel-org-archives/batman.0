Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Nov 2012 09:24:05 +0100
Message-Id: <1353313451-2930-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1353313451-2930-1-git-send-email-ordex@autistici.org>
References: <1353313451-2930-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: export compatibility
	version via debugfs
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

Different versions of the batman-adv module may use the same compatibility
version, but this is not understandable at runtime (the only way is to parse the
kernel log and fetch the batman-adv advertisement message on loading). The user
may want to know whether two nodes using different versions can communicate or
not. For this purpose the module has to export this value through debugfs.

Reported-by: Moritz Warning <moritzwarning@web.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/debugfs.c | 12 ++++++++++++
 net/batman-adv/main.c    | 12 ++++++++++++
 net/batman-adv/main.h    |  1 +
 3 files changed, 25 insertions(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 6f58ddd..ae79b19 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -245,6 +245,16 @@ static int batadv_algorithms_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_algo_seq_print_text, NULL);
 }
 
+/**
+ * batadv_compat_open - Prepare file handler for printing of the compat version
+ * @inode: inode which was opened
+ * @file: file handle to be initialized
+ */
+static int batadv_compat_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, batadv_compat_seq_print_text, NULL);
+}
+
 static int batadv_originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -327,9 +337,11 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
  * placed in the BATADV_DEBUGFS_SUBDIR subdirectory of debugfs
  */
 static BATADV_DEBUGINFO(routing_algos, S_IRUGO, batadv_algorithms_open);
+static BATADV_DEBUGINFO(compat_version, S_IRUGO, batadv_compat_open);
 
 static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 	&batadv_debuginfo_routing_algos,
+	&batadv_debuginfo_compat_version,
 	NULL,
 };
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index dc33a0c..70797de 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -420,6 +420,18 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+/**
+ * batadv_compat_seq_print_text - print the compatibility version
+ * @seq: debugfs table seq_file struct
+ * @offset: not used
+ */
+int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
+{
+	seq_printf(seq, "%d\n", BATADV_COMPAT_VERSION);
+
+	return 0;
+}
+
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8f149bb..3243189 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -174,6 +174,7 @@ void batadv_recv_handler_unregister(uint8_t packet_type);
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_compat_seq_print_text(struct seq_file *seq, void *offset);
 
 /**
  * enum batadv_dbg_level - available log levels
-- 
1.8.0

