Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Nov 2012 22:16:16 +0100
Message-Id: <1352409376-28885-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1352409376-28885-1-git-send-email-ordex@autistici.org>
References: <1352409376-28885-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: improve local translation
	table output
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

This patch adds a nice header to the local translation table and
the last_seen time for each local entry

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index cb0281a..4657d9e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -472,10 +472,14 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
+	int last_seen_secs;
+	int last_seen_msecs;
+	unsigned long last_seen_jiffies;
 
 	primary_if = batadv_seq_print_text_primary_if_get(seq);
 	if (!primary_if)
@@ -484,6 +488,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn));
+	seq_printf(seq, "       %-13s %-7s %-10s\n", "Client", "Flags",
+		   "Last seen");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -491,7 +497,15 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
-			seq_printf(seq, " * %pM [%c%c%c%c%c]\n",
+			tt_local = container_of(tt_common_entry,
+						struct batadv_tt_local_entry,
+						common);
+			last_seen_jiffies = jiffies - tt_local->last_seen;
+			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
+			last_seen_secs = last_seen_msecs / 1000;
+			last_seen_msecs = last_seen_msecs % 1000;
+
+			seq_printf(seq, " * %pM [%c%c%c%c%c] %3u.%03u\n",
 				   tt_common_entry->addr,
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
@@ -502,7 +516,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_PENDING ? 'X' : '.'),
 				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'));
+				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
+				   last_seen_secs, last_seen_msecs);
 		}
 		rcu_read_unlock();
 	}
-- 
1.8.0

