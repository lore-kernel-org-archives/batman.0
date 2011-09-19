Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Sep 2011 12:29:19 +0200
Message-Id: <1316428159-31010-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: tt_global_del_orig() has to
	print the correct message
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

When deleting the entries, tt_global_del_orig() has to print the message passed
as argument instead of a static one.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index cc53f78..7de9960 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -720,9 +720,10 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 			if (tt_global_entry->orig_node == orig_node) {
 				bat_dbg(DBG_TT, bat_priv,
 					"Deleting global tt entry %pM "
-					"(via %pM): originator time out\n",
+					"(via %pM): %s\n",
 					tt_global_entry->addr,
-					tt_global_entry->orig_node->orig);
+					tt_global_entry->orig_node->orig,
+					message);
 				hlist_del_rcu(node);
 				tt_global_entry_free_ref(tt_global_entry);
 			}
-- 
1.7.3.4

