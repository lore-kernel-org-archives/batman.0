Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Jan 2017 17:44:02 +0100
Message-Id: <20170126164404.16074-6-sw@simonwunderlich.de>
In-Reply-To: <20170126164404.16074-1-sw@simonwunderlich.de>
References: <20170126164404.16074-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: Remove unused variable in
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 941afad92121..6077a87d46f0 100644
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

