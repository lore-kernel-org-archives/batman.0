Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:23 +0100
Message-Id: <1297789948-16948-9-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 08/13] batman-adv: Use packet lists for
	unicast packet sending
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

Instead of branching the code paths and having several possible methods
doing the final preparation and sending of an skb, depending on whether
a packet needs to be fragmented or not, this commit now decouples the
sending procedure from the fragmentation methods: The fragmentation
methods are only manipulating a packet_list and packet_list_entries now
so that the fragmentation process becomes transparent for
route_unicast_packet().

This further allows easier integration of future extensions that send
copies of multiple (modified) unicast packets to several next hop
neighbours.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 routing.c        |   76 +++++++++++++++-----------------------
 routing.h        |    4 +--
 send.c           |   14 +++++++
 send.h           |    7 ++++
 soft-interface.c |    3 +-
 unicast.c        |  107 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 unicast.h        |   25 +------------
 7 files changed, 153 insertions(+), 83 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 4899649..3fceca0 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1020,21 +1020,24 @@ out:
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
-struct neigh_node *find_router(struct orig_node *orig_node,
-			       struct batman_if *recv_if)
+static void find_router(struct orig_node *orig_node,
+			struct batman_if *recv_if,
+			struct sk_buff *skb,
+			struct hlist_head *packet_list)
 {
 	struct bat_priv *bat_priv;
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
 	struct neigh_node *router, *first_candidate, *tmp_neigh_node;
+	struct packet_list_entry *entry;
 	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 	int bonding_enabled;
 
 	if (!orig_node)
-		return NULL;
+		return;
 
 	if (!orig_node->router)
-		return NULL;
+		return;
 
 	bat_priv = orig_node->bat_priv;
 
@@ -1048,7 +1051,7 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 	router_orig = orig_node->router->orig_node;
 	if (!router_orig || !atomic_inc_not_zero(&router->refcount)) {
 		rcu_read_unlock();
-		return NULL;
+		return;
 	}
 
 	if ((!recv_if) && (!bonding_enabled))
@@ -1110,7 +1113,7 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 
 		if (!router) {
 			rcu_read_unlock();
-			return NULL;
+			return;
 		}
 
 		/* selected should point to the next element
@@ -1162,7 +1165,16 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 	}
 return_router:
 	rcu_read_unlock();
-	return router;
+
+	entry = kmalloc(sizeof(struct packet_list_entry), GFP_ATOMIC);
+	if (!entry) {
+		kfree_skb(skb);
+		return;
+	}
+
+	entry->skb = skb;
+	entry->neigh_node = router;
+	hlist_add_head(&entry->list, packet_list);
 }
 
 static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
@@ -1191,55 +1203,29 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 }
 
 int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
-			 struct orig_node *orig_node, uint8_t packet_type)
+			 struct orig_node *orig_node)
 {
-	struct neigh_node *neigh_node = NULL;
 	int ret = NET_RX_DROP;
-	struct sk_buff *new_skb;
+	struct hlist_head packet_list;
 
-	/* find_router() increases neigh_nodes refcount if found. */
-	neigh_node = find_router(orig_node, recv_if);
-
-	if (!neigh_node)
-		goto out;
+	INIT_HLIST_HEAD(&packet_list);
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
 		goto out;
 
-	if (packet_type == BAT_UNICAST &&
-	    atomic_read(&orig_node->bat_priv->fragmentation) &&
-	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
-		ret = frag_send_skb(skb, orig_node->bat_priv,
-				    neigh_node->if_incoming, neigh_node->addr);
-		goto out;
-	}
+	/* creates the (initial) packet list */
+	find_router(orig_node, recv_if, skb, &packet_list);
 
-	if (packet_type == BAT_UNICAST_FRAG &&
-	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
+	/* split packets that won't fit or maybe buffer fragments */
+	frag_packet_list(orig_node->bat_priv, &packet_list);
 
-		ret = frag_reassemble_skb(skb, orig_node->bat_priv, &new_skb);
-
-		if (ret == NET_RX_DROP)
-			goto out;
-
-		/* packet was buffered for late merge */
-		if (!new_skb) {
-			ret = NET_RX_SUCCESS;
-			goto out;
-		}
-
-		skb = new_skb;
-	}
-
-	/* route it */
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	/* route them */
+	send_packet_list(&packet_list);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
 out:
-	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
@@ -1264,8 +1250,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	}
 
 	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
-	return route_unicast_packet(skb, recv_if, orig_node,
-				    unicast_packet->header.packet_type);
+	return route_unicast_packet(skb, recv_if, orig_node);
 }
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
@@ -1300,8 +1285,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	}
 
 	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
-	return route_unicast_packet(skb, recv_if, orig_node,
-				    unicast_packet->header.packet_type);
+	return route_unicast_packet(skb, recv_if, orig_node);
 }
 
 
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 3c04bb0..43a2609 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -31,15 +31,13 @@ void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
 int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
-			 struct orig_node *orig_node, uint8_t packet_type);
+			 struct orig_node *orig_node);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
-struct neigh_node *find_router(struct orig_node *orig_node,
-			       struct batman_if *recv_if);
 void bonding_candidate_del(struct orig_node *orig_node,
 			   struct neigh_node *neigh_node);
 
diff --git a/batman-adv/send.c b/batman-adv/send.c
index df4cd34..20476b0 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -196,6 +196,20 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
+void send_packet_list(struct hlist_head *packet_list)
+{
+	struct packet_list_entry *entry;
+	struct hlist_node *pos, *tmp;
+
+	hlist_for_each_entry_safe(entry, pos, tmp, packet_list, list) {
+		send_skb_packet(entry->skb, entry->neigh_node->if_incoming,
+				entry->neigh_node->addr);
+		neigh_node_free_ref(entry->neigh_node);
+		hlist_del(&entry->list);
+		kfree(entry);
+	}
+}
+
 /* Send a packet to a given interface */
 static void send_packet_to_if(struct forw_packet *forw_packet,
 			      struct batman_if *batman_if)
diff --git a/batman-adv/send.h b/batman-adv/send.h
index b68c272..fc7780f 100644
--- a/batman-adv/send.h
+++ b/batman-adv/send.h
@@ -22,9 +22,16 @@
 #ifndef _NET_BATMAN_ADV_SEND_H_
 #define _NET_BATMAN_ADV_SEND_H_
 
+struct packet_list_entry {
+	struct hlist_node list;
+	struct sk_buff *skb;
+	struct neigh_node *neigh_node;
+};
+
 int send_skb_packet(struct sk_buff *skb,
 				struct batman_if *batman_if,
 				uint8_t *dst_addr);
+void send_packet_list(struct hlist_head *packet_list);
 void schedule_own_packet(struct batman_if *batman_if);
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 7225764..f3c7141 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -485,8 +485,7 @@ void interface_rx(struct net_device *soft_iface,
 		       bat_priv->softif_neigh->addr, ETH_ALEN);
 
 		orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
-		ret = route_unicast_packet(skb, recv_if, orig_node,
-					   unicast_packet->header.packet_type);
+		ret = route_unicast_packet(skb, recv_if, orig_node);
 		if (ret == NET_RX_DROP)
 			goto dropped;
 
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 7262a22..b824315 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -217,17 +217,43 @@ out:
 	return ret;
 }
 
-int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-		  struct batman_if *batman_if, uint8_t dstaddr[])
+static void frag_reassemble_packet(struct packet_list_entry *entry,
+			      struct bat_priv *bat_priv)
+{
+	struct sk_buff *new_skb = NULL;
+	int ret;
+
+	ret = frag_reassemble_skb(entry->skb, bat_priv, &new_skb);
+
+	/* Could reassemble packet, leave this new one in list */
+	if (new_skb) {
+		entry->skb = new_skb;
+		return;
+	}
+
+	/* merge failed */
+	if (ret == NET_RX_DROP)
+		kfree_skb(entry->skb);
+
+	/* merge failed or skb is buffered, remove from send list */
+	neigh_node_free_ref(entry->neigh_node);
+	hlist_del(&entry->list);
+	kfree(entry);
+}
+
+static void frag_skb(struct packet_list_entry *entry, struct bat_priv *bat_priv)
 {
 	struct unicast_packet tmp_uc, *unicast_packet;
 	struct sk_buff *frag_skb;
 	struct unicast_frag_packet *frag1, *frag2;
+	struct packet_list_entry *frag_entry;
 	int uc_hdr_len = sizeof(struct unicast_packet);
 	int ucf_hdr_len = sizeof(struct unicast_frag_packet);
-	int data_len = skb->len - uc_hdr_len;
+	int data_len = entry->skb->len - uc_hdr_len;
 	int large_tail = 0;
 	uint16_t seqno;
+	struct sk_buff *skb = entry->skb;
+	struct batman_if *batman_if = entry->neigh_node->if_incoming;
 
 	if (!bat_priv->primary_if)
 		goto dropped;
@@ -266,15 +292,79 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag1->seqno = htons(seqno - 1);
 	frag2->seqno = htons(seqno);
 
-	send_skb_packet(skb, batman_if, dstaddr);
-	send_skb_packet(frag_skb, batman_if, dstaddr);
-	return NET_RX_SUCCESS;
+	frag_entry = kmalloc(sizeof(struct packet_list_entry), GFP_ATOMIC);
+	if (!frag_entry)
+		goto drop_frag;
+
+	if (!atomic_inc_not_zero(&entry->neigh_node->refcount))
+		goto drop_frag;
+
+	frag_entry->skb = frag_skb;
+	frag_entry->neigh_node = entry->neigh_node;
+	hlist_add_before(&frag_entry->list, &entry->list);
 
 drop_frag:
 	kfree_skb(frag_skb);
 dropped:
 	kfree_skb(skb);
-	return NET_RX_DROP;
+	neigh_node_free_ref(entry->neigh_node);
+	hlist_del(&entry->list);
+	kfree(entry);
+}
+
+static inline int frag_can_reassemble(struct sk_buff *skb, int mtu)
+{
+	struct unicast_frag_packet *unicast_packet;
+	int uneven_correction = 0;
+	unsigned int merged_size;
+
+	unicast_packet = (struct unicast_frag_packet *)skb->data;
+
+	if (unicast_packet->flags & UNI_FRAG_LARGETAIL) {
+		if (unicast_packet->flags & UNI_FRAG_HEAD)
+			uneven_correction = 1;
+		else
+			uneven_correction = -1;
+	}
+
+	merged_size = (skb->len - 2 * sizeof(struct unicast_frag_packet));
+	merged_size += sizeof(struct unicast_packet) + uneven_correction;
+
+	return merged_size <= mtu;
+}
+
+void frag_packet_list(struct bat_priv *bat_priv,
+		      struct hlist_head *packet_list)
+{
+	struct packet_list_entry *entry;
+	struct hlist_node *pos, *tmp;
+	uint8_t packet_type;
+
+	hlist_for_each_entry_safe(entry, pos, tmp, packet_list, list) {
+		packet_type = ((struct batman_header *)
+				entry->skb->data)->packet_type;
+
+		switch (packet_type) {
+		case BAT_UNICAST:
+			if (!atomic_read(&bat_priv->fragmentation) ||
+			    entry->skb->len <=
+			    entry->neigh_node->if_incoming->net_dev->mtu)
+				break;
+
+			frag_skb(entry, bat_priv);
+			break;
+		case BAT_UNICAST_FRAG:
+			if (!frag_can_reassemble(entry->skb,
+			      entry->neigh_node->if_incoming->net_dev->mtu))
+				break;
+
+			frag_reassemble_packet(entry, bat_priv);
+			break;
+		default:
+			/* We should never be here... */
+			break;
+		}
+	}
 }
 
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
@@ -308,8 +398,7 @@ route:
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
-	ret = route_unicast_packet(skb, NULL, orig_node,
-				   unicast_packet->header.packet_type);
+	ret = route_unicast_packet(skb, NULL, orig_node);
 
 out:
 	if (ret == NET_RX_DROP)
diff --git a/batman-adv/unicast.h b/batman-adv/unicast.h
index 8897308..1b4dbb0 100644
--- a/batman-adv/unicast.h
+++ b/batman-adv/unicast.h
@@ -30,29 +30,8 @@
 int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
+void frag_packet_list(struct bat_priv *bat_priv,
+		      struct hlist_head *packet_list);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
-int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-		  struct batman_if *batman_if, uint8_t dstaddr[]);
-
-static inline int frag_can_reassemble(struct sk_buff *skb, int mtu)
-{
-	struct unicast_frag_packet *unicast_packet;
-	int uneven_correction = 0;
-	unsigned int merged_size;
-
-	unicast_packet = (struct unicast_frag_packet *)skb->data;
-
-	if (unicast_packet->flags & UNI_FRAG_LARGETAIL) {
-		if (unicast_packet->flags & UNI_FRAG_HEAD)
-			uneven_correction = 1;
-		else
-			uneven_correction = -1;
-	}
-
-	merged_size = (skb->len - sizeof(struct unicast_frag_packet)) * 2;
-	merged_size += sizeof(struct unicast_packet) + uneven_correction;
-
-	return merged_size <= mtu;
-}
 
 #endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.2.3

