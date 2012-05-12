Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:40 +0200
Message-Id: <1336781383-15649-20-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 20/23] batman-adv: Prefix unicast
	non-static functions with batadv_
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 distributed-arp-table.c |    6 +++---
 originator.c            |    4 ++--
 routing.c               |    9 +++++----
 unicast.c               |   34 ++++++++++++++++++----------------
 unicast.h               |   30 ++++++++++++++++--------------
 5 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 97e229d..6bc64f8 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -259,9 +259,9 @@ static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
 			goto free_orig;
 
 		tmp_skb = pskb_copy(skb, GFP_ATOMIC);
-		if (!prepare_unicast_4addr_packet(bat_priv, tmp_skb,
-						  cand[i].orig_node,
-						  packet_subtype)) {
+		if (!batadv_prepare_unicast_4addr_packet(bat_priv, tmp_skb,
+							 cand[i].orig_node,
+							 packet_subtype)) {
 			kfree_skb(tmp_skb);
 			goto free_neigh;
 		}
diff --git a/originator.c b/originator.c
index d560301..7decb40 100644
--- a/originator.c
+++ b/originator.c
@@ -139,7 +139,7 @@ static void orig_node_free_rcu(struct rcu_head *rcu)
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
-	frag_list_free(&orig_node->frag_list);
+	batadv_frag_list_free(&orig_node->frag_list);
 	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
 				  "originator timed out");
 
@@ -374,7 +374,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 
 			if (has_timed_out(orig_node->last_frag_packet,
 					  FRAG_TIMEOUT))
-				frag_list_free(&orig_node->frag_list);
+				batadv_frag_list_free(&orig_node->frag_list);
 		}
 		spin_unlock_bh(list_lock);
 	}
diff --git a/routing.c b/routing.c
index df32246..8c71b57 100644
--- a/routing.c
+++ b/routing.c
@@ -848,15 +848,16 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (unicast_packet->header.packet_type == BAT_UNICAST &&
 	    atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
-		ret = frag_send_skb(skb, bat_priv,
-				    neigh_node->if_incoming, neigh_node->addr);
+		ret = batadv_frag_send_skb(skb, bat_priv,
+					   neigh_node->if_incoming,
+					   neigh_node->addr);
 		goto out;
 	}
 
 	if (unicast_packet->header.packet_type == BAT_UNICAST_FRAG &&
 	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
 
-		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
 			goto out;
@@ -1013,7 +1014,7 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 
-		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
 			return NET_RX_DROP;
diff --git a/unicast.c b/unicast.c
index 136e80b..ae59a74 100644
--- a/unicast.c
+++ b/unicast.c
@@ -101,7 +101,7 @@ static int frag_create_buffer(struct list_head *head)
 	for (i = 0; i < FRAG_BUFFER_SIZE; i++) {
 		tfp = kmalloc(sizeof(*tfp), GFP_ATOMIC);
 		if (!tfp) {
-			frag_list_free(head);
+			batadv_frag_list_free(head);
 			return -ENOMEM;
 		}
 		tfp->skb = NULL;
@@ -151,7 +151,7 @@ mov_tail:
 	return NULL;
 }
 
-void frag_list_free(struct list_head *head)
+void batadv_frag_list_free(struct list_head *head)
 {
 	struct frag_packet_list_entry *pf, *tmp_pf;
 
@@ -172,8 +172,8 @@ void frag_list_free(struct list_head *head)
  * or the skb could be reassembled (skb_new will point to the new packet and
  * skb was freed)
  */
-int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			struct sk_buff **new_skb)
+int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			       struct sk_buff **new_skb)
 {
 	struct orig_node *orig_node;
 	struct frag_packet_list_entry *tmp_frag_entry;
@@ -216,8 +216,8 @@ out:
 	return ret;
 }
 
-int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-		  struct hard_iface *hard_iface, const uint8_t dstaddr[])
+int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			 struct hard_iface *hard_iface, const uint8_t dstaddr[])
 {
 	struct unicast_packet tmp_uc, *unicast_packet;
 	struct hard_iface *primary_if;
@@ -313,10 +313,10 @@ static bool prepare_unicast_packet(struct sk_buff *skb,
 				     orig_node);
 }
 
-bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-				  struct sk_buff *skb,
-				  struct orig_node *orig_node,
-				  int packet_subtype)
+bool batadv_prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+					 struct sk_buff *skb,
+					 struct orig_node *orig_node,
+					 int packet_subtype)
 {
 	struct hard_iface *primary_if;
 	struct unicast_4addr_packet *unicast_4addr_packet;
@@ -347,8 +347,9 @@ out:
 	return ret;
 }
 
-int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			     int packet_type, int packet_subtype)
+int batadv_unicast_generic_send_skb(struct sk_buff *skb,
+				    struct bat_priv *bat_priv,
+				    int packet_type, int packet_subtype)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct orig_node *orig_node;
@@ -383,8 +384,8 @@ find_router:
 		prepare_unicast_packet(skb, orig_node);
 		break;
 	case BAT_UNICAST_4ADDR:
-		prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
-					     packet_subtype);
+		batadv_prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
+						    packet_subtype);
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
@@ -409,8 +410,9 @@ find_router:
 				neigh_node->if_incoming->net_dev->mtu) {
 		/* send frag skb decreases ttl */
 		unicast_packet->header.ttl++;
-		ret = frag_send_skb(skb, bat_priv,
-				    neigh_node->if_incoming, neigh_node->addr);
+		ret = batadv_frag_send_skb(skb, bat_priv,
+					   neigh_node->if_incoming,
+					   neigh_node->addr);
 		goto out;
 	}
 
diff --git a/unicast.h b/unicast.h
index e15aa62..da402b1 100644
--- a/unicast.h
+++ b/unicast.h
@@ -27,30 +27,32 @@
 #define FRAG_TIMEOUT 10000	/* purge frag list entries after time in ms */
 #define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
 
-int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			struct sk_buff **new_skb);
-void frag_list_free(struct list_head *head);
-int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
-bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-				  struct sk_buff *skb,
-				  struct orig_node *orig_node,
-				  int packet_subtype);
-int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			     int packet_type, int packet_subtype);
+int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			       struct sk_buff **new_skb);
+void batadv_frag_list_free(struct list_head *head);
+int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			 struct hard_iface *hard_iface,
+			 const uint8_t dstaddr[]);
+bool batadv_prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+					 struct sk_buff *skb,
+					 struct orig_node *orig_node,
+					 int packet_subtype);
+int batadv_unicast_generic_send_skb(struct sk_buff *skb,
+				    struct bat_priv *bat_priv,
+				    int packet_type, int packet_subtype);
 
 static inline int unicast_send_skb(struct sk_buff *skb,
 				   struct bat_priv *bat_priv)
 {
-	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
+	return batadv_unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
 }
 
 static inline int unicast_4addr_send_skb(struct sk_buff *skb,
 					 struct bat_priv *bat_priv,
 					 int packet_subtype)
 {
-	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
-					packet_subtype);
+	return batadv_unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
+					       packet_subtype);
 }
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
-- 
1.7.10

