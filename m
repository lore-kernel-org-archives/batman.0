Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 17:39:18 +0200
Message-Id: <1468597173-25378-3-git-send-email-sven@narfation.org>
In-Reply-To: <1468597173-25378-1-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 03/18] batman-adv: Place kref_get for
	tt_orig_list_entry near use
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

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems causedy incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patch based on type

 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index af2bfef..89d7b1d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1402,9 +1402,9 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
 	kref_init(&orig_entry->refcount);
-	kref_get(&orig_entry->refcount);
 
 	spin_lock_bh(&tt_global->list_lock);
+	kref_get(&orig_entry->refcount);
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
 	spin_unlock_bh(&tt_global->list_lock);
-- 
2.8.1

