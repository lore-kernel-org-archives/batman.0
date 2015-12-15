Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:54 +0100
Message-Id: <1450222316-1764-21-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 21/23] batman-adv: Convert batadv_orig_node
	to kref
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            | 16 +++++-----
 net/batman-adv/bridge_loop_avoidance.c |  4 +--
 net/batman-adv/distributed-arp-table.c |  6 ++--
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/gateway_client.c        | 12 ++++----
 net/batman-adv/icmp_socket.c           |  2 +-
 net/batman-adv/main.c                  |  2 +-
 net/batman-adv/multicast.c             |  7 +++--
 net/batman-adv/network-coding.c        |  6 ++--
 net/batman-adv/originator.c            | 53 +++++++++++++++++++++++-----------
 net/batman-adv/originator.h            |  6 ++--
 net/batman-adv/routing.c               | 18 ++++++------
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/translation-table.c     | 18 ++++++------
 net/batman-adv/types.h                 |  2 +-
 15 files changed, 88 insertions(+), 68 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 95399c9..02d5ace 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -285,8 +285,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 
 free_orig_node:
 	/* free twice, as batadv_orig_node_new sets refcount to 2 */
-	batadv_orig_node_free_ref(orig_node);
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
+	batadv_orig_node_put(orig_node);
 
 	return NULL;
 }
@@ -1039,7 +1039,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 						     ethhdr->h_source,
 						     orig_node, orig_tmp);
 
-		batadv_orig_node_free_ref(orig_tmp);
+		batadv_orig_node_put(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1304,7 +1304,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
 	if (WARN_ON(!orig_ifinfo)) {
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 		return 0;
 	}
 
@@ -1365,7 +1365,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 	batadv_orig_ifinfo_put(orig_ifinfo);
 	return ret;
 }
@@ -1561,7 +1561,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
-		batadv_orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_put(orig_neigh_node);
 out:
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_put(router_ifinfo);
@@ -1695,7 +1695,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: originator packet from myself (via neighbor)\n");
-		batadv_orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_put(orig_neigh_node);
 		return;
 	}
 
@@ -1733,7 +1733,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	}
 	rcu_read_unlock();
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 }
 
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index e58bc6c..5370add 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -485,7 +485,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	if (orig_node) {
 		batadv_tt_global_del_orig(bat_priv, orig_node, vid,
 					  "became a backbone gateway");
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	}
 
 	if (own_backbone) {
@@ -964,7 +964,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 		bla_dst_own->group = bla_dst->group;
 	}
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 
 	return 2;
 }
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 782e80a..695cd52 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -542,12 +542,12 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 							  max_orig_node))
 				continue;
 
-			if (!atomic_inc_not_zero(&orig_node->refcount))
+			if (!kref_get_unless_zero(&orig_node->refcount))
 				continue;
 
 			max = tmp_max;
 			if (max_orig_node)
-				batadv_orig_node_free_ref(max_orig_node);
+				batadv_orig_node_put(max_orig_node);
 			max_orig_node = orig_node;
 		}
 		rcu_read_unlock();
@@ -676,7 +676,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 free_neigh:
 		batadv_neigh_node_put(neigh_node);
 free_orig:
-		batadv_orig_node_free_ref(cand[i].orig_node);
+		batadv_orig_node_put(cand[i].orig_node);
 	}
 
 out:
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 69edc0b..9a3f7af 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -385,7 +385,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 
 out:
 	if (orig_node_dst)
-		batadv_orig_node_free_ref(orig_node_dst);
+		batadv_orig_node_put(orig_node_dst);
 	if (neigh_node)
 		batadv_neigh_node_put(neigh_node);
 	return ret;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 33ddd7d..46c44b6 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -71,7 +71,7 @@ static void batadv_gw_node_release(struct kref *ref)
 
 	gw_node = container_of(ref, struct batadv_gw_node, refcount);
 
-	batadv_orig_node_free_ref(gw_node->orig_node);
+	batadv_orig_node_put(gw_node->orig_node);
 	kfree_rcu(gw_node, rcu);
 }
 
@@ -117,7 +117,7 @@ batadv_gw_get_selected_orig(struct batadv_priv *bat_priv)
 	if (!orig_node)
 		goto unlock;
 
-	if (!atomic_inc_not_zero(&orig_node->refcount))
+	if (!kref_get_unless_zero(&orig_node->refcount))
 		orig_node = NULL;
 
 unlock:
@@ -414,7 +414,7 @@ reselect:
 	batadv_gw_reselect(bat_priv);
 out:
 	if (curr_gw_orig)
-		batadv_orig_node_free_ref(curr_gw_orig);
+		batadv_orig_node_put(curr_gw_orig);
 	if (router_gw)
 		batadv_neigh_node_put(router_gw);
 	if (router_orig)
@@ -440,12 +440,12 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (gateway->bandwidth_down == 0)
 		return;
 
-	if (!atomic_inc_not_zero(&orig_node->refcount))
+	if (!kref_get_unless_zero(&orig_node->refcount))
 		return;
 
 	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
 	if (!gw_node) {
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 		return;
 	}
 
@@ -877,7 +877,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_dst_node)
-		batadv_orig_node_free_ref(orig_dst_node);
+		batadv_orig_node_put(orig_dst_node);
 	if (curr_gw)
 		batadv_gw_node_put(curr_gw);
 	if (gw_node)
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 27be960..5b6d415 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -292,7 +292,7 @@ out:
 	if (neigh_node)
 		batadv_neigh_node_put(neigh_node);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return len;
 }
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 33ac461..19ad0bb 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1207,7 +1207,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) == NET_XMIT_DROP)
 		kfree_skb(skb);
 out:
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 }
 
 /**
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8abf488..288844f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -30,6 +30,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -447,7 +448,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv4_list,
 				 mcast_want_all_ipv4_node) {
-		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
+		if (!kref_get_unless_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
@@ -474,7 +475,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv6_list,
 				 mcast_want_all_ipv6_node) {
-		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
+		if (!kref_get_unless_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
@@ -525,7 +526,7 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_unsnoopables_list,
 				 mcast_want_all_unsnoopables_node) {
-		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
+		if (!kref_get_unless_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 96e1390..fc3a729 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -218,7 +218,7 @@ static void batadv_nc_node_release(struct kref *ref)
 
 	nc_node = container_of(ref, struct batadv_nc_node, refcount);
 
-	batadv_orig_node_free_ref(nc_node->orig_node);
+	batadv_orig_node_put(nc_node->orig_node);
 	kfree_rcu(nc_node, rcu);
 }
 
@@ -858,7 +858,7 @@ static struct batadv_nc_node
 	if (!nc_node)
 		return NULL;
 
-	if (!atomic_inc_not_zero(&orig_neigh_node->refcount))
+	if (!kref_get_unless_zero(&orig_neigh_node->refcount))
 		goto free;
 
 	/* Initialize nc_node */
@@ -1372,7 +1372,7 @@ batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
 	}
 	rcu_read_unlock();
 
-	batadv_orig_node_free_ref(orig_node);
+	batadv_orig_node_put(orig_node);
 	return nc_packet;
 }
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a7b70b5..86ae44a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -18,6 +18,7 @@
 #include "originator.h"
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
@@ -750,14 +751,40 @@ void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo)
 	kref_put(&orig_ifinfo->refcount, batadv_orig_ifinfo_release);
 }
 
+/**
+ * batadv_orig_node_free_rcu - free the orig_node
+ * @rcu: rcu pointer of the orig_node
+ */
 static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
+	struct batadv_orig_node *orig_node;
+
+	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
+
+	batadv_mcast_purge_orig(orig_node);
+
+	batadv_frag_purge_orig(orig_node, NULL);
+
+	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
+		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
+
+	kfree(orig_node->tt_buff);
+	kfree(orig_node);
+}
+
+/**
+ * batadv_orig_node_release - release orig_node from lists and queue for
+ *  free after rcu grace period
+ * @ref: kref pointer of the orig_node
+ */
+static void batadv_orig_node_release(struct kref *ref)
+{
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 
-	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
+	orig_node = container_of(ref, struct batadv_orig_node, refcount);
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -775,29 +802,20 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
-	batadv_mcast_purge_orig(orig_node);
-
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
-	batadv_frag_purge_orig(orig_node, NULL);
-
-	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
-		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
-
-	kfree(orig_node->tt_buff);
-	kfree(orig_node);
+	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
 /**
- * batadv_orig_node_free_ref - decrement the orig node refcounter and possibly
+ * batadv_orig_node_put - decrement the orig node refcounter and possibly
  * schedule an rcu callback for freeing it
  * @orig_node: the orig node to free
  */
-void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
+void batadv_orig_node_put(struct batadv_orig_node *orig_node)
 {
-	if (atomic_dec_and_test(&orig_node->refcount))
-		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
+	kref_put(&orig_node->refcount, batadv_orig_node_release);
 }
 
 void batadv_originator_free(struct batadv_priv *bat_priv)
@@ -824,7 +842,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 		hlist_for_each_entry_safe(orig_node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(&orig_node->hash_entry);
-			batadv_orig_node_free_ref(orig_node);
+			batadv_orig_node_put(orig_node);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -869,7 +887,8 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	batadv_nc_init_orig(orig_node);
 
 	/* extra reference for return */
-	atomic_set(&orig_node->refcount, 2);
+	kref_init(&orig_node->refcount);
+	kref_get(&orig_node->refcount);
 
 	orig_node->bat_priv = bat_priv;
 	ether_addr_copy(orig_node->orig, addr);
@@ -1184,7 +1203,7 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 				batadv_tt_global_del_orig(orig_node->bat_priv,
 							  orig_node, -1,
 							  "originator timed out");
-				batadv_orig_node_free_ref(orig_node);
+				batadv_orig_node_put(orig_node);
 				continue;
 			}
 
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 0bad6cc..b67a6bc 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -20,10 +20,10 @@
 
 #include "main.h"
 
-#include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/if_ether.h>
 #include <linux/jhash.h>
+#include <linux/kref.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/stddef.h>
@@ -37,7 +37,7 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2);
 int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
-void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
+void batadv_orig_node_put(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr);
 struct batadv_hardif_neigh_node *
@@ -115,7 +115,7 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 		if (!batadv_compare_eth(orig_node, data))
 			continue;
 
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!kref_get_unless_zero(&orig_node->refcount))
 			continue;
 
 		orig_node_tmp = orig_node;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 43b5875..0aa9eb1 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -271,7 +271,7 @@ out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -319,7 +319,7 @@ out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -403,7 +403,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -649,7 +649,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
 
@@ -704,7 +704,7 @@ out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 
 	return ret;
 }
@@ -768,7 +768,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 			return 0;
 
 		curr_ttvn = (u8)atomic_read(&orig_node->last_ttvn);
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	}
 
 	/* check if the TTVN contained in the packet is fresher than what the
@@ -908,7 +908,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 rx_success:
 		if (orig_node)
-			batadv_orig_node_free_ref(orig_node);
+			batadv_orig_node_put(orig_node);
 
 		return NET_RX_SUCCESS;
 	}
@@ -1019,7 +1019,7 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 
 out:
 	if (orig_node_src)
-		batadv_orig_node_free_ref(orig_node_src);
+		batadv_orig_node_put(orig_node_src);
 
 	return ret;
 }
@@ -1124,6 +1124,6 @@ spin_unlock:
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return ret;
 }
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index be8011c..b8e2d0e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -317,7 +317,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	if (ret == NET_XMIT_DROP)
 		kfree_skb(skb);
 	return ret;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ac66771..dad9060 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -356,7 +356,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 	orig_entry = container_of(ref, struct batadv_tt_orig_list_entry,
 				  refcount);
 
-	batadv_orig_node_free_ref(orig_entry->orig_node);
+	batadv_orig_node_put(orig_entry->orig_node);
 	kfree_rcu(orig_entry, rcu);
 }
 
@@ -1334,7 +1334,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 		goto out;
 
 	INIT_HLIST_NODE(&orig_entry->list);
-	atomic_inc(&orig_node->refcount);
+	kref_get(&orig_node->refcount);
 	batadv_tt_global_size_inc(orig_node, tt_global->common.vid);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
@@ -2097,7 +2097,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	/* found anything? */
 	if (best_entry)
 		orig_node = best_entry->orig_node;
-	if (orig_node && !atomic_inc_not_zero(&orig_node->refcount))
+	if (orig_node && !kref_get_unless_zero(&orig_node->refcount))
 		orig_node = NULL;
 	rcu_read_unlock();
 
@@ -2738,9 +2738,9 @@ unlock:
 
 out:
 	if (res_dst_orig_node)
-		batadv_orig_node_free_ref(res_dst_orig_node);
+		batadv_orig_node_put(res_dst_orig_node);
 	if (req_dst_orig_node)
-		batadv_orig_node_free_ref(req_dst_orig_node);
+		batadv_orig_node_put(req_dst_orig_node);
 	kfree(tvlv_tt_data);
 	return ret;
 }
@@ -2855,7 +2855,7 @@ unlock:
 out:
 	spin_unlock_bh(&bat_priv->tt.commit_lock);
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	kfree(tvlv_tt_data);
@@ -2943,7 +2943,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 }
 
 static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
@@ -3049,7 +3049,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 }
 
 static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
@@ -3764,7 +3764,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 out:
 	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+		batadv_orig_node_put(orig_node);
 	return NET_RX_SUCCESS;
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 441ebd9..c8c7ab8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -299,7 +299,7 @@ struct batadv_orig_node {
 	struct batadv_priv *bat_priv;
 	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
 	spinlock_t bcast_seqno_lock;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 #ifdef CONFIG_BATMAN_ADV_NC
 	struct list_head in_coding_list;
-- 
2.6.4

