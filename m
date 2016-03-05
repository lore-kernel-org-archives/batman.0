Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:19 +0100
Message-Id: <1457190564-11419-4-git-send-email-sven@narfation.org>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Use kref_get for hard_iface
	subfunctions
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

The callers of the functions using batadv_hard_iface objects have to make
sure that they already hold a valid reference. The subfunctions don't have
to check whether the reference counter is > 0 because this was already
checked by the callers.

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Andrew, this should be what you've reported in
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014588.html and
what I've added to the issue tracker at https://www.open-mesh.org/issues/244

 net/batman-adv/bat_iv_ogm.c     |  9 ++-------
 net/batman-adv/hard-interface.c |  7 +++----
 net/batman-adv/originator.c     | 30 +++++++-----------------------
 3 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b390ff9..d389dc6 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -679,12 +679,6 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	unsigned char *skb_buff;
 	unsigned int skb_size;
 
-	if (!kref_get_unless_zero(&if_incoming->refcount))
-		return;
-
-	if (!kref_get_unless_zero(&if_outgoing->refcount))
-		goto out_free_incoming;
-
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
@@ -716,6 +710,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	forw_packet_aggr->packet_len = packet_len;
 	memcpy(skb_buff, packet_buff, packet_len);
 
+	kref_get(&if_incoming->refcount);
+	kref_get(&if_outgoing->refcount);
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
 	forw_packet_aggr->if_outgoing = if_outgoing;
@@ -747,7 +743,6 @@ out_nomem:
 		atomic_inc(&bat_priv->batman_queue_left);
 out_free_outgoing:
 	batadv_hardif_put(if_outgoing);
-out_free_incoming:
 	batadv_hardif_put(if_incoming);
 }
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 56b148a..e70d13f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -236,8 +236,8 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 
 	ASSERT_RTNL();
 
-	if (new_hard_iface && !kref_get_unless_zero(&new_hard_iface->refcount))
-		new_hard_iface = NULL;
+	if (new_hard_iface)
+		kref_get(&new_hard_iface->refcount);
 
 	curr_hard_iface = rcu_dereference_protected(bat_priv->primary_if, 1);
 	rcu_assign_pointer(bat_priv->primary_if, new_hard_iface);
@@ -464,8 +464,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		goto out;
 
-	if (!kref_get_unless_zero(&hard_iface->refcount))
-		goto out;
+	kref_get(&hard_iface->refcount);
 
 	soft_iface = dev_get_by_name(&init_net, iface_name);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 44c508a..2d288ea 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -381,12 +381,8 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 	if (!orig_ifinfo)
 		goto out;
 
-	if (if_outgoing != BATADV_IF_DEFAULT &&
-	    !kref_get_unless_zero(&if_outgoing->refcount)) {
-		kfree(orig_ifinfo);
-		orig_ifinfo = NULL;
-		goto out;
-	}
+	if (if_outgoing != BATADV_IF_DEFAULT)
+		kref_get(&if_outgoing->refcount);
 
 	reset_time = jiffies - 1;
 	reset_time -= msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
@@ -462,11 +458,8 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 	if (!neigh_ifinfo)
 		goto out;
 
-	if (if_outgoing && !kref_get_unless_zero(&if_outgoing->refcount)) {
-		kfree(neigh_ifinfo);
-		neigh_ifinfo = NULL;
-		goto out;
-	}
+	if (if_outgoing)
+		kref_get(&if_outgoing->refcount);
 
 	INIT_HLIST_NODE(&neigh_ifinfo->list);
 	kref_init(&neigh_ifinfo->refcount);
@@ -539,15 +532,11 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (hardif_neigh)
 		goto out;
 
-	if (!kref_get_unless_zero(&hard_iface->refcount))
-		goto out;
-
 	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
-	if (!hardif_neigh) {
-		batadv_hardif_put(hard_iface);
+	if (!hardif_neigh)
 		goto out;
-	}
 
+	kref_get(&hard_iface->refcount);
 	INIT_HLIST_NODE(&hardif_neigh->list);
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
 	hardif_neigh->if_incoming = hard_iface;
@@ -650,16 +639,11 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	if (!neigh_node)
 		goto out;
 
-	if (!kref_get_unless_zero(&hard_iface->refcount)) {
-		kfree(neigh_node);
-		neigh_node = NULL;
-		goto out;
-	}
-
 	INIT_HLIST_NODE(&neigh_node->list);
 	INIT_HLIST_HEAD(&neigh_node->ifinfo_list);
 	spin_lock_init(&neigh_node->ifinfo_lock);
 
+	kref_get(&hard_iface->refcount);
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
 	neigh_node->orig_node = orig_node;
-- 
2.7.0

