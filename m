Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 Nov 2011 22:26:44 +0800
Message-Id: <1322317612-7770-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
References: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: tt_global_del_orig() has
	to print the correct message
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

From: Antonio Quartulli <ordex@autistici.org>

When deleting the entries, tt_global_del_orig() has to print the message passed
as argument instead of a static one.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c7aafc7..1db9d96 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -735,9 +735,10 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
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
1.7.5.4

