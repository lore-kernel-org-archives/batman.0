Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:08 +0200
Message-Id: <20160822135620.15337-9-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/20] batman-adv: Place kref_get for
	tt_common near use
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems caused by incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 094da1a..d94e298 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1645,13 +1645,13 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		if (flags & BATADV_TT_CLIENT_ROAM)
 			tt_global_entry->roam_at = jiffies;
 		kref_init(&common->refcount);
-		kref_get(&common->refcount);
 		common->added_at = jiffies;
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
 		atomic_set(&tt_global_entry->orig_list_count, 0);
 		spin_lock_init(&tt_global_entry->list_lock);
 
+		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
 					     batadv_compare_tt,
 					     batadv_choose_tt, common,
-- 
2.9.3

