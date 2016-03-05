Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:16 +0100
Message-Id: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Check hard_iface refcnt
	before calling function
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

The batadv_hardif_list list is checked in many situations and the items
in this list are given to specialized functions to modify the routing
behavior. At the moment each of these called functions has to check
itself whether the received batadv_hard_iface has a refcount > 0 before
it can increase the reference counter and use it in other objects.

This can easily lead to problems because it is not easily visible where
all callers of a function got the batadv_hard_iface object from and
whether they already hold a valid reference.

Checking the reference counter directly before calling a subfunction
with a pointer from the batadv_hardif_list avoids this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 11 +++++++++++
 net/batman-adv/bat_v_ogm.c  | 14 +++++++++++++-
 net/batman-adv/originator.c |  5 +++++
 net/batman-adv/send.c       |  6 ++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 2c65668..b390ff9 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -985,9 +985,15 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list, list) {
 		if (tmp_hard_iface->soft_iface != hard_iface->soft_iface)
 			continue;
+
+		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
+			continue;
+
 		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
 					*ogm_buff_len, hard_iface,
 					tmp_hard_iface, 1, send_time);
+
+		batadv_hardif_put(tmp_hard_iface);
 	}
 	rcu_read_unlock();
 
@@ -1767,8 +1773,13 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (hard_iface->soft_iface != bat_priv->soft_iface)
 			continue;
 
+		if (!kref_get_unless_zero(&hard_iface->refcount))
+			continue;
+
 		batadv_iv_ogm_process_per_outif(skb, ogm_offset, orig_node,
 						if_incoming, hard_iface);
+
+		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 4155fa5..473ebb9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -26,6 +26,7 @@
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
@@ -176,6 +177,9 @@ static void batadv_v_ogm_send(struct work_struct *work)
 		if (hard_iface->soft_iface != bat_priv->soft_iface)
 			continue;
 
+		if (!kref_get_unless_zero(&hard_iface->refcount))
+			continue;
+
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Sending own OGM2 packet (originator %pM, seqno %u, throughput %u, TTL %d) on interface %s [%pM]\n",
 			   ogm_packet->orig, ntohl(ogm_packet->seqno),
@@ -185,10 +189,13 @@ static void batadv_v_ogm_send(struct work_struct *work)
 
 		/* this skb gets consumed by batadv_v_ogm_send_to_if() */
 		skb_tmp = skb_clone(skb, GFP_ATOMIC);
-		if (!skb_tmp)
+		if (!skb_tmp) {
+			batadv_hardif_put(hard_iface);
 			break;
+		}
 
 		batadv_v_ogm_send_to_if(skb_tmp, hard_iface);
+		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
 
@@ -704,9 +711,14 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (hard_iface->soft_iface != bat_priv->soft_iface)
 			continue;
 
+		if (!kref_get_unless_zero(&hard_iface->refcount))
+			continue;
+
 		batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm_packet,
 					       orig_node, neigh_node,
 					       if_incoming, hard_iface);
+
+		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
 out:
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e63d6a5..44c508a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1165,6 +1165,9 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 		if (hard_iface->soft_iface != bat_priv->soft_iface)
 			continue;
 
+		if (!kref_get_unless_zero(&hard_iface->refcount))
+			continue;
+
 		best_neigh_node = batadv_find_best_neighbor(bat_priv,
 							    orig_node,
 							    hard_iface);
@@ -1172,6 +1175,8 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				    best_neigh_node);
 		if (best_neigh_node)
 			batadv_neigh_node_put(best_neigh_node);
+
+		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 3ce06e0..43a950e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -26,6 +26,7 @@
 #include <linux/if.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
@@ -577,10 +578,15 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (forw_packet->num_packets >= hard_iface->num_bcasts)
 			continue;
 
+		if (!kref_get_unless_zero(&hard_iface->refcount))
+			continue;
+
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
 			batadv_send_broadcast_skb(skb1, hard_iface);
+
+		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
 
-- 
2.7.0

