Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 17 Dec 2016 11:58:29 +0100
Message-Id: <20161217105829.13461-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused variable in
	batadv_tt_local_set_flags
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 30ecbfb4..367e88fe 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3714,7 +3714,6 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
-	u16 changed_num = 0;
 	struct hlist_head *head;
 	u32 i;
 
@@ -3736,7 +3735,6 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 					continue;
 				tt_common_entry->flags &= ~flags;
 			}
-			changed_num++;
 
 			if (!count)
 				continue;
-- 
2.11.0

