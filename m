Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jun 2016 20:10:46 +0200
Message-Id: <1467310246-5820-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/3] batman-adv: Fix orig_node_vlan leak
	on orig_node_release
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
Cc: Antonio Quartulli <a@unstable.cc>

batadv_orig_node_new uses batadv_orig_node_vlan_new to allocate a new
batadv_orig_node_vlan and add it to batadv_orig_node::vlan_list. References
to this list have also to be cleaned when the batadv_orig_node is removed.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
--
v2:
 - nothing changed
---
 net/batman-adv/originator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 8755e5c..40626b4 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -786,6 +786,7 @@ static void batadv_orig_node_release(struct kref *ref)
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
+	struct batadv_orig_node_vlan *vlan;
 
 	orig_node = container_of(ref, struct batadv_orig_node, refcount);
 
@@ -805,6 +806,13 @@ static void batadv_orig_node_release(struct kref *ref)
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

