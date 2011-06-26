Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 26 Jun 2011 23:00:17 +0200
Message-Id: <1309122017-29823-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1307307664-19910-1-git-send-email-ordex@autistici.org>
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: print client flags in the
	local/global transtables output
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Since clients can have several flags on or off, this patches make them
appear in the local/global transtable output so that they can be checked
for debugging purposes.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index f5a772f..b413eff 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -331,7 +331,7 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		__hlist_for_each_rcu(node, head)
-			buf_size += 21;
+			buf_size += 27;
 		rcu_read_unlock();
 	}
 
@@ -350,8 +350,14 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_local_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 22, " * %pM\n",
-					tt_local_entry->addr);
+			pos += snprintf(buff + pos, 28, " * %pM [%c%c%c]\n",
+					tt_local_entry->addr,
+					(tt_local_entry->flags &
+					 TT_CLIENT_ROAM ? 'R' : '.'),
+					(tt_local_entry->flags &
+					 TT_CLIENT_NOPURGE ? 'N' : '.'),
+					(tt_local_entry->flags &
+					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
 	}
@@ -588,8 +594,8 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
-	seq_printf(seq, "       %-13s %s       %-15s %s\n",
-		   "Client", "(TTVN)", "Originator", "(Curr TTVN)");
+	seq_printf(seq, "       %-13s %s       %-15s %s %s\n",
+		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "Flags");
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx (ttvn) via
@@ -599,7 +605,7 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		__hlist_for_each_rcu(node, head)
-			buf_size += 59;
+			buf_size += 66;
 		rcu_read_unlock();
 	}
 
@@ -618,14 +624,18 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_global_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 61,
-					" * %pM  (%3u) via %pM     (%3u)\n",
+			pos += snprintf(buff + pos, 68,
+					" * %pM  (%3u) via %pM     (%3u)   [%c%c]\n",
 					tt_global_entry->addr,
 					tt_global_entry->ttvn,
 					tt_global_entry->orig_node->orig,
 					(uint8_t) atomic_read(
 						&tt_global_entry->orig_node->
-						last_ttvn));
+						last_ttvn),
+					(tt_global_entry->flags &
+					 TT_CLIENT_ROAM ? 'R' : '.'),
+					(tt_global_entry->flags &
+					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
 	}
-- 
1.7.3.4

