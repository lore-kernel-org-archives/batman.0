Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 15:53:47 +0100
Message-Id: <1457189627-8839-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Reduce refcnt of removed
	router when updating route
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

_batadv_update_route rcu_derefences orig_ifinfo->router outside of a
spinlock protected region to print some information messages to the debug
log. But this pointer is not checked again when the new pointer is assigned
in the spinlock protected region. Thus is can happen that the value of
orig_ifinfo->router changed in the meantime and thus the reference counter
of the wrong router gets reduced after the spinlock protected region.

Just rcu_dereferencing the value of orig_ifinfo->router inside the spinlock
protected region (which also set the new pointer) is enough to get the
correct old router object.

Fixes: d90ddb94423f ("batman-adv: Make orig_node->router an rcu protected pointer")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1fb1be3..61fdefe 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -104,6 +104,8 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 		neigh_node = NULL;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
+	curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
+
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 	batadv_orig_ifinfo_free_ref(orig_ifinfo);
-- 
2.7.0

