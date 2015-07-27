Return-Path: <def@laposte.net>
From: Def <def@laposte.net>
Date: Mon, 27 Jul 2015 11:58:18 +0200
Message-Id: <1437991098-22983-1-git-send-email-def@laposte.net>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix batadv_compare_tt
	function
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

batadv_compare_tt have to check vid.

Signed-off-by: Def <def@laposte.net>
---
 translation-table.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index d73b103..d16433a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -45,13 +45,16 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 unsigned short vid, const char *message,
 				 bool roaming);
 
-/* returns 1 if they are the same mac addr */
+/* returns 1 if they are the same mac addr and vid */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
 	const void *data1 = container_of(node, struct batadv_tt_common_entry,
 					 hash_entry);
 
-	return batadv_compare_eth(data1, data2);
+	struct batadv_tt_common_entry* tt1 = data1;
+	struct batadv_tt_common_entry* tt2 = data2;
+
+	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
 }
 
 /**
-- 
1.7.10.4

