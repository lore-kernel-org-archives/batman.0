Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 Nov 2011 22:26:49 +0800
Message-Id: <1322317612-7770-8-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
References: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/10] batman-adv: directly write tt entries
	without buffering
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

When the translation tables (global and local) are written for debugfs,
it is not neccesary to allocate a buffer, we can directly use
seq_printf() to print them out.

This might actually be safer if the table changes between size
calculation and traversal, and we can't estimate the required size
wrong.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c |   57 +----------------------------------
 1 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f28a7f0..78b9528 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -314,8 +314,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	size_t buf_size, pos;
-	char *buff;
 	uint32_t i;
 	int ret = 0;
 
@@ -338,34 +336,13 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		   "announced via TT (TTVN: %u):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->ttvn));
 
-	buf_size = 1;
-	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		__hlist_for_each_rcu(node, head)
-			buf_size += 29;
-		rcu_read_unlock();
-	}
-
-	buff = kmalloc(buf_size, GFP_ATOMIC);
-	if (!buff) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	buff[0] = '\0';
-	pos = 0;
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_local_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 30, " * %pM "
-					"[%c%c%c%c%c]\n",
+			seq_printf(seq, " * %pM [%c%c%c%c%c]\n",
 					tt_local_entry->addr,
 					(tt_local_entry->flags &
 					 TT_CLIENT_ROAM ? 'R' : '.'),
@@ -380,9 +357,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		}
 		rcu_read_unlock();
 	}
-
-	seq_printf(seq, "%s", buff);
-	kfree(buff);
 out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
@@ -591,8 +565,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	size_t buf_size, pos;
-	char *buff;
 	uint32_t i;
 	int ret = 0;
 
@@ -617,35 +589,13 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s %s       %-15s %s %s\n",
 		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "Flags");
 
-	buf_size = 1;
-	/* Estimate length for: " * xx:xx:xx:xx:xx:xx (ttvn) via
-	 * xx:xx:xx:xx:xx:xx (cur_ttvn)\n"*/
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		__hlist_for_each_rcu(node, head)
-			buf_size += 67;
-		rcu_read_unlock();
-	}
-
-	buff = kmalloc(buf_size, GFP_ATOMIC);
-	if (!buff) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	buff[0] = '\0';
-	pos = 0;
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_global_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 69,
-					" * %pM  (%3u) via %pM     (%3u)   "
+			seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   "
 					"[%c%c%c]\n", tt_global_entry->addr,
 					tt_global_entry->ttvn,
 					tt_global_entry->orig_node->orig,
@@ -661,9 +611,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		}
 		rcu_read_unlock();
 	}
-
-	seq_printf(seq, "%s", buff);
-	kfree(buff);
 out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
-- 
1.7.5.4

