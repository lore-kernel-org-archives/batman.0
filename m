Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  8 Jul 2016 11:49:18 +0200
Message-Id: <1467971362-3607-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467971362-3607-1-git-send-email-sw@simonwunderlich.de>
References: <1467971362-3607-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: Fix orig_node_vlan leak on
	orig_node_release
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

batadv_orig_node_new uses batadv_orig_node_vlan_new to allocate a new
batadv_orig_node_vlan and add it to batadv_orig_node::vlan_list. References
to this list have also to be cleaned when the batadv_orig_node is removed.

Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 7f51bc2..fe2fcda 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -765,6 +765,7 @@ static void batadv_orig_node_release(struct kref *ref)
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
+	struct batadv_orig_node_vlan *vlan;
 
 	orig_node = container_of(ref, struct batadv_orig_node, refcount);
 
@@ -784,6 +785,13 @@ static void batadv_orig_node_release(struct kref *ref)
 	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	spin_lock_bh(&orig_node->vlan_list_lock);
+	hlist_for_each_entry_safe(vlan, node_tmp, &orig_node->vlan_list, list) {
+		hlist_del_rcu(&vlan->list);
+		batadv_orig_node_vlan_put(vlan);
+	}
+	spin_unlock_bh(&orig_node->vlan_list_lock);
+
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
-- 
2.8.1

