Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Aug 2011 15:00:36 +0200
Message-Id: <1314190838-2273-7-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1314190838-2273-1-git-send-email-lindner_marek@yahoo.de>
References: <1314190838-2273-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batman-adv: print client flags in the
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Antonio Quartulli <ordex@autistici.org>

Since clients can have several flags on or off, this patches make them
appear in the local/global transtable output so that they can be checked
for debugging purposes.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c |   37 ++++++++++++++++++++++++++---------
 1 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1f128e1..e8f849f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -332,7 +332,7 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		__hlist_for_each_rcu(node, head)
-			buf_size += 21;
+			buf_size += 29;
 		rcu_read_unlock();
 	}
 
@@ -351,8 +351,19 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_local_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 22, " * %pM\n",
-					tt_local_entry->addr);
+			pos += snprintf(buff + pos, 30, " * %pM "
+					"[%c%c%c%c%c]\n",
+					tt_local_entry->addr,
+					(tt_local_entry->flags &
+					 TT_CLIENT_ROAM ? 'R' : '.'),
+					(tt_local_entry->flags &
+					 TT_CLIENT_NOPURGE ? 'P' : '.'),
+					(tt_local_entry->flags &
+					 TT_CLIENT_NEW ? 'N' : '.'),
+					(tt_local_entry->flags &
+					 TT_CLIENT_PENDING ? 'X' : '.'),
+					(tt_local_entry->flags &
+					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
 	}
@@ -589,8 +600,8 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
-	seq_printf(seq, "       %-13s %s       %-15s %s\n",
-		   "Client", "(TTVN)", "Originator", "(Curr TTVN)");
+	seq_printf(seq, "       %-13s %s       %-15s %s %s\n",
+		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "Flags");
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx (ttvn) via
@@ -600,7 +611,7 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		__hlist_for_each_rcu(node, head)
-			buf_size += 59;
+			buf_size += 67;
 		rcu_read_unlock();
 	}
 
@@ -619,14 +630,20 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_global_entry, node,
 					 head, hash_entry) {
-			pos += snprintf(buff + pos, 61,
-					" * %pM  (%3u) via %pM     (%3u)\n",
-					tt_global_entry->addr,
+			pos += snprintf(buff + pos, 69,
+					" * %pM  (%3u) via %pM     (%3u)   "
+					"[%c%c%c]\n", tt_global_entry->addr,
 					tt_global_entry->ttvn,
 					tt_global_entry->orig_node->orig,
 					(uint8_t) atomic_read(
 						&tt_global_entry->orig_node->
-						last_ttvn));
+						last_ttvn),
+					(tt_global_entry->flags &
+					 TT_CLIENT_ROAM ? 'R' : '.'),
+					(tt_global_entry->flags &
+					 TT_CLIENT_PENDING ? 'X' : '.'),
+					(tt_global_entry->flags &
+					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
 	}
-- 
1.7.5.3

