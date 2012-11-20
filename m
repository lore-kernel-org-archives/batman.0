Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 20 Nov 2012 20:44:15 +0100
Message-Id: <1353440655-10461-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] Revert "batman-adv: export
	compatibility version via debugfs"
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

This reverts commit 0679ec75758588e185ceec11e5823de65b427a6f.

Conflicts:
	main.c
	main.h

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 debugfs.c | 12 ------------
 main.c    | 12 ------------
 main.h    |  1 -
 3 files changed, 25 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index ae79b19..6f58ddd 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -245,16 +245,6 @@ static int batadv_algorithms_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_algo_seq_print_text, NULL);
 }
 
-/**
- * batadv_compat_open - Prepare file handler for printing of the compat version
- * @inode: inode which was opened
- * @file: file handle to be initialized
- */
-static int batadv_compat_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, batadv_compat_seq_print_text, NULL);
-}
-
 static int batadv_originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -337,11 +327,9 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
  * placed in the BATADV_DEBUGFS_SUBDIR subdirectory of debugfs
  */
 static BATADV_DEBUGINFO(routing_algos, S_IRUGO, batadv_algorithms_open);
-static BATADV_DEBUGINFO(compat_version, S_IRUGO, batadv_compat_open);
 
 static struct batadv_debuginfo *batadv_general_debuginfos[] = {
 	&batadv_debuginfo_routing_algos,
-	&batadv_debuginfo_compat_version,
 	NULL,
 };
 
diff --git a/main.c b/main.c
index 253e240..f65a222 100644
--- a/main.c
+++ b/main.c
@@ -423,18 +423,6 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 }
 
 /**
- * batadv_compat_seq_print_text - print the compatibility version
- * @seq: debugfs table seq_file struct
- * @offset: not used
- */
-int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "%d\n", BATADV_COMPAT_VERSION);
-
-	return 0;
-}
-
-/**
  * batadv_skb_crc32 - calculate CRC32 of the whole packet and skip bytes in
  *  the header
  * @skb: skb pointing to fragmented socket buffers
diff --git a/main.h b/main.h
index ec9c5ad..94de8ee 100644
--- a/main.h
+++ b/main.h
@@ -176,7 +176,6 @@ void batadv_recv_handler_unregister(uint8_t packet_type);
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
-int batadv_compat_seq_print_text(struct seq_file *seq, void *offset);
 __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
-- 
1.8.0

