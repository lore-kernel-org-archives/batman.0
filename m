Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 26 Apr 2016 11:27:18 +0800
Message-Id: <1461641239-7097-5-git-send-email-a@unstable.cc>
In-Reply-To: <1461641239-7097-1-git-send-email-a@unstable.cc>
References: <1461641239-7097-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Reduce refcnt of removed
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

_batadv_update_route rcu_derefences orig_ifinfo->router outside of a
spinlock protected region to print some information messages to the debug
log. But this pointer is not checked again when the new pointer is assigned
in the spinlock protected region. Thus is can happen that the value of
orig_ifinfo->router changed in the meantime and thus the reference counter
of the wrong router gets reduced after the spinlock protected region.

Just rcu_dereferencing the value of orig_ifinfo->router inside the spinlock
protected region (which also set the new pointer) is enough to get the
correct old router object.

Fixes: e1a5382f978b ("batman-adv: Make orig_node->router an rcu protected pointer")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/routing.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 4dd646a52f1a..b781bf753250 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -105,6 +105,15 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 		neigh_node = NULL;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
+	/* curr_router used earlier may not be the current orig_ifinfo->router
+	 * anymore because it was dereferenced outside of the neigh_list_lock
+	 * protected region. After the new best neighbor has replace the current
+	 * best neighbor the reference counter needs to decrease. Consequently,
+	 * the code needs to ensure the curr_router variable contains a pointer
+	 * to the replaced best neighbor.
+	 */
+	curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
+
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 	batadv_orig_ifinfo_put(orig_ifinfo);
-- 
2.8.1

