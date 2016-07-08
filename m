Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  8 Jul 2016 11:49:21 +0200
Message-Id: <1467971362-3607-7-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467971362-3607-1-git-send-email-sw@simonwunderlich.de>
References: <1467971362-3607-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: Free last_bonding_candidate
	on release of orig_node
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

The orig_ifinfo reference counter for last_bonding_candidate in
batadv_orig_node has to be reduced when an originator node is released.
Otherwise the orig_ifinfo is leaked and the reference counter the netdevice
is not reduced correctly.

Fixes: f3b3d9018975 ("batman-adv: add bonding again")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index fe2fcda..ab8c4f9 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -766,6 +766,7 @@ static void batadv_orig_node_release(struct kref *ref)
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_orig_node_vlan *vlan;
+	struct batadv_orig_ifinfo *last_candidate;
 
 	orig_node = container_of(ref, struct batadv_orig_node, refcount);
 
@@ -783,8 +784,14 @@ static void batadv_orig_node_release(struct kref *ref)
 		hlist_del_rcu(&orig_ifinfo->list);
 		batadv_orig_ifinfo_put(orig_ifinfo);
 	}
+
+	last_candidate = orig_node->last_bonding_candidate;
+	orig_node->last_bonding_candidate = NULL;
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	if (last_candidate)
+		batadv_orig_ifinfo_put(last_candidate);
+
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry_safe(vlan, node_tmp, &orig_node->vlan_list, list) {
 		hlist_del_rcu(&vlan->list);
-- 
2.8.1

