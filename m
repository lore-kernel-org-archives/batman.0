Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jun 2016 21:41:13 +0200
Message-Id: <1467315673-9950-1-git-send-email-sven@narfation.org>
In-Reply-To: <1467310246-5820-1-git-send-email-sven@narfation.org>
References: <1467310246-5820-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint v2 4/4] batman-adv: Free
	last_bonding_candidate on release of orig_node
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

The orig_ifinfo reference counter for last_bonding_candidate in
batadv_orig_node has to be reduced when an originator node is released.
Otherwise the orig_ifinfo is leaked and the reference counter the netdevice
is not reduced correctly.

Fixes: 797edd9e87ac ("batman-adv: add bonding again")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - added new patch
---
 net/batman-adv/originator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 40626b4..8208276 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -787,6 +787,7 @@ static void batadv_orig_node_release(struct kref *ref)
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_orig_node_vlan *vlan;
+	struct batadv_orig_ifinfo *last_candidate;
 
 	orig_node = container_of(ref, struct batadv_orig_node, refcount);
 
@@ -804,8 +805,14 @@ static void batadv_orig_node_release(struct kref *ref)
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

