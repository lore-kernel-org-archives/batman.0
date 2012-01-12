Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 12 Jan 2012 19:07:00 +0100
Message-Id: <1326391620-28509-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: TT_CLIENT_PENDING is never set
	in struct tt_global_entry
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
To: b.a.t.m.a.n@lists.open-mesh.org

Actually the TT_CLIENT_PENDING flag is never set in the tt_global_entry
structure, therefore this code is useless and can be removed.

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index d105cbd..27753a0 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -603,7 +603,7 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 						       struct tt_global_entry,
 						       common);
 			seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   "
-					"[%c%c%c]\n",
+					"[%c%c]\n",
 					tt_global_entry->common.addr,
 					tt_global_entry->ttvn,
 					tt_global_entry->orig_node->orig,
@@ -613,8 +613,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 					(tt_global_entry->common.flags &
 					 TT_CLIENT_ROAM ? 'R' : '.'),
 					(tt_global_entry->common.flags &
-					 TT_CLIENT_PENDING ? 'X' : '.'),
-					(tt_global_entry->common.flags &
 					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
@@ -838,11 +836,6 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
 		goto out;
 
-	/* A global client marked as PENDING has already moved from that
-	 * originator */
-	if (tt_global_entry->common.flags & TT_CLIENT_PENDING)
-		goto out;
-
 	orig_node = tt_global_entry->orig_node;
 
 out:
-- 
1.7.3.4

