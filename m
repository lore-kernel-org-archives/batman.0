Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:25 +0100
Message-Id: <1297789948-16948-11-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/13] batman-adv: Adding redundant bonding
	mode transmission
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

With this feature unicast packets can be send in a redundancy bonding
instead of throughput bonding mode on all interfaces available towards
a common node. This shall increase the robustness of unicast data
transfer / decrease packet loss in cases where bursty packet loss on
only one channel, which batman-adv's link quality measurements cannot
detect, is to be expected or where batman-adv's metric adaptation is
expected to be too slow for certain scenarios.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 main.h           |    5 ++
 packet.h         |    8 ++++
 routing.c        |  117 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 routing.h        |    3 +-
 soft-interface.c |    8 +++-
 types.h          |    1 +
 unicast.c        |   10 +++--
 unicast.h        |    2 +-
 8 files changed, 135 insertions(+), 19 deletions(-)

diff --git a/batman-adv/main.h b/batman-adv/main.h
index bd8470d..862643a 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -97,6 +97,11 @@
  *  Vis
  */
 
+/* Bonding modes */
+#define THROUGHPUT_BONDING	1
+#define REDUNDANT_BONDING	2
+
+
 /*
  * Kernel headers
  */
diff --git a/batman-adv/packet.h b/batman-adv/packet.h
index ae7a0ce..e5a897c 100644
--- a/batman-adv/packet.h
+++ b/batman-adv/packet.h
@@ -30,6 +30,7 @@
 #define BAT_BCAST        0x04
 #define BAT_VIS          0x05
 #define BAT_UNICAST_FRAG 0x06
+#define BAT_UNICAST_SAFE 0x07
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 12
@@ -101,6 +102,13 @@ struct unicast_packet {
 	uint8_t  dest[6];
 } __packed;
 
+struct unicast_packet_safe {
+	struct   batman_header header;
+	uint8_t  dest[6];
+	uint8_t  orig[6];
+	uint32_t seqno;
+} __packed;
+
 struct unicast_frag_packet {
 	struct   batman_header header;
 	uint8_t  dest[6];
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 3fceca0..0797ab5 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1017,10 +1017,77 @@ out:
 	return ret;
 }
 
+static int unicast_to_unicast_safe(struct sk_buff *skb,
+				   struct bat_priv *bat_priv)
+{
+	struct unicast_packet unicast_packet;
+	struct unicast_packet_safe *unicast_packet_safe;
+
+	memcpy(&unicast_packet, skb->data, sizeof(unicast_packet));
+	if (my_skb_head_push(skb, sizeof(struct unicast_packet_safe) -
+				sizeof(struct unicast_packet)) < 0)
+		return -1;
+
+	unicast_packet_safe = (struct unicast_packet_safe *) skb->data;
+	unicast_packet_safe->header = unicast_packet.header;
+	memcpy(unicast_packet_safe->dest, unicast_packet.dest, ETH_ALEN);
+	unicast_packet_safe->header.packet_type = BAT_UNICAST_SAFE;
+	memcpy(unicast_packet_safe->orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	unicast_packet_safe->seqno =
+				htonl(atomic_inc_return(&bat_priv->dup_seqno));
+
+	return 0;
+}
+
+static void red_bonding_copy(struct sk_buff *skb, struct list_head *bond_list,
+			     struct hlist_head *packet_list,
+			     struct bat_priv *bat_priv)
+{
+	struct neigh_node *neigh_node;
+	struct packet_list_entry *entry;
+	int num_entries = 0;
+	int packet_type = ((struct batman_header *) skb->data)->packet_type;
+
+	/* We only expect either BAT_UNICAST or BAT_UNICAST_SAFE here */
+	if (packet_type == BAT_UNICAST) {
+		if (unicast_to_unicast_safe(skb, bat_priv) < 0) {
+			kfree_skb(skb);
+			return;
+		}
+	}
+
+	list_for_each_entry_rcu(neigh_node, bond_list, bonding_list) {
+		entry = kmalloc(sizeof(struct packet_list_entry), GFP_ATOMIC);
+		if (!entry) {
+			kfree_skb(skb);
+			return;
+		}
+		if (!num_entries)
+			entry->skb = skb;
+		else {
+			entry->skb = skb_copy(skb, GFP_ATOMIC);
+			if (!entry->skb) {
+				kfree_skb(skb);
+				kfree(entry);
+				return;
+			}
+		}
+		entry->neigh_node = neigh_node;
+		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+			kfree_skb(entry->skb);
+			kfree(entry);
+			continue;
+		}
+		hlist_add_head(&entry->list, packet_list);
+		num_entries++;
+	}
+}
+
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
-static void find_router(struct orig_node *orig_node,
+static void find_router(int bonding_mode, struct orig_node *orig_node,
 			struct batman_if *recv_if,
 			struct sk_buff *skb,
 			struct hlist_head *packet_list)
@@ -1031,7 +1098,6 @@ static void find_router(struct orig_node *orig_node,
 	struct neigh_node *router, *first_candidate, *tmp_neigh_node;
 	struct packet_list_entry *entry;
 	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
-	int bonding_enabled;
 
 	if (!orig_node)
 		return;
@@ -1043,7 +1109,6 @@ static void find_router(struct orig_node *orig_node,
 
 	/* without bonding, the first node should
 	 * always choose the default router. */
-	bonding_enabled = atomic_read(&bat_priv->bonding);
 
 	rcu_read_lock();
 	/* select default router to output */
@@ -1054,7 +1119,7 @@ static void find_router(struct orig_node *orig_node,
 		return;
 	}
 
-	if ((!recv_if) && (!bonding_enabled))
+	if ((!recv_if) && (!bonding_mode))
 		goto return_router;
 
 	/* if we have something in the primary_addr, we can search
@@ -1090,7 +1155,7 @@ static void find_router(struct orig_node *orig_node,
 	first_candidate = NULL;
 	router = NULL;
 
-	if (bonding_enabled) {
+	if (bonding_mode == THROUGHPUT_BONDING) {
 		/* in the bonding case, send the packets in a round
 		 * robin fashion over the remaining interfaces. */
 
@@ -1126,6 +1191,11 @@ static void find_router(struct orig_node *orig_node,
 				&router->bonding_list);
 		spin_unlock_bh(&primary_orig_node->neigh_list_lock);
 
+	} else if (bonding_mode == REDUNDANT_BONDING) {
+		red_bonding_copy(skb, &primary_orig_node->bond_list,
+				 packet_list, bat_priv);
+		rcu_read_unlock();
+		return;
 	} else {
 		/* if bonding is disabled, use the best of the
 		 * remaining candidates which are not using
@@ -1202,12 +1272,16 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+int route_unicast_packet(int bonding_mode, struct sk_buff *skb,
+			 struct batman_if *recv_if,
 			 struct orig_node *orig_node)
 {
 	int ret = NET_RX_DROP;
 	struct hlist_head packet_list;
 
+	if (!orig_node)
+		goto out;
+
 	INIT_HLIST_HEAD(&packet_list);
 
 	/* create a copy of the skb, if needed, to modify it. */
@@ -1215,10 +1289,10 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 		goto out;
 
 	/* creates the (initial) packet list */
-	find_router(orig_node, recv_if, skb, &packet_list);
+	find_router(bonding_mode, orig_node, recv_if, skb, &packet_list);
 
 	/* split packets that won't fit or maybe buffer fragments */
-	frag_packet_list(orig_node->bat_priv, &packet_list);
+	frag_packet_list(bonding_mode, orig_node->bat_priv, &packet_list);
 
 	/* route them */
 	send_packet_list(&packet_list);
@@ -1237,6 +1311,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
 	int hdr_size = sizeof(struct unicast_packet);
+	int bonding_mode;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
@@ -1249,8 +1324,10 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
+	bonding_mode = atomic_read(&bat_priv->bonding) <<
+			atomic_read(&bat_priv->red_bonding);
 	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
-	return route_unicast_packet(skb, recv_if, orig_node);
+	return route_unicast_packet(bonding_mode, skb, recv_if, orig_node);
 }
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
@@ -1260,7 +1337,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct orig_node *orig_node;
 	int hdr_size = sizeof(struct unicast_frag_packet);
 	struct sk_buff *new_skb = NULL;
-	int ret;
+	int ret, bonding_mode;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
@@ -1284,8 +1361,26 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
+	/* The redundant bonding mode currently cannot handle fragmented
+	 * packets, therefore need to defrag them first */
+	bonding_mode = atomic_read(&bat_priv->bonding) <<
+			atomic_read(&bat_priv->red_bonding);
+
+	if (bonding_mode == REDUNDANT_BONDING) {
+		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+
+		if (ret == NET_RX_DROP)
+			return NET_RX_DROP;
+
+		/* packet was buffered for late merge */
+		if (!new_skb)
+			return NET_RX_SUCCESS;
+
+		skb = new_skb;
+	}
+
 	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
-	return route_unicast_packet(skb, recv_if, orig_node);
+	return route_unicast_packet(bonding_mode, skb, recv_if, orig_node);
 }
 
 
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 43a2609..01fab8d 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -30,7 +30,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
-int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+int route_unicast_packet(int bonding_mode, struct sk_buff *skb,
+			 struct batman_if *recv_if,
 			 struct orig_node *orig_node);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 25db300..c6035fe 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -443,7 +443,7 @@ void interface_rx(struct net_device *soft_iface,
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
 	short vid = -1;
-	int ret;
+	int ret, bonding_mode;
 
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size))
@@ -484,8 +484,11 @@ void interface_rx(struct net_device *soft_iface,
 		memcpy(unicast_packet->dest,
 		       bat_priv->softif_neigh->addr, ETH_ALEN);
 
+		bonding_mode = atomic_read(&bat_priv->bonding) <<
+				atomic_read(&bat_priv->red_bonding);
 		orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
-		ret = route_unicast_packet(skb, recv_if, orig_node);
+		ret = route_unicast_packet(bonding_mode, skb, recv_if,
+					   orig_node);
 		if (ret == NET_RX_DROP)
 			goto dropped;
 
@@ -604,6 +607,7 @@ struct net_device *softif_create(char *name)
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
+	atomic_set(&bat_priv->dup_seqno, 1);
 	atomic_set(&bat_priv->hna_local_changed, 0);
 
 	bat_priv->primary_if = NULL;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index c2ddd0a..5401498 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -141,6 +141,7 @@ struct bat_priv {
 	atomic_t hop_penalty;		/* uint */
 	atomic_t log_level;		/* uint */
 	atomic_t bcast_seqno;
+	atomic_t dup_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
 	char num_ifaces;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index b824315..aa46103 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -30,7 +30,6 @@
 #include "routing.h"
 #include "hard-interface.h"
 
-
 static struct sk_buff *frag_merge_packet(struct list_head *head,
 					 struct frag_packet_list_entry *tfp,
 					 struct sk_buff *skb)
@@ -333,7 +332,7 @@ static inline int frag_can_reassemble(struct sk_buff *skb, int mtu)
 	return merged_size <= mtu;
 }
 
-void frag_packet_list(struct bat_priv *bat_priv,
+void frag_packet_list(int bonding, struct bat_priv *bat_priv,
 		      struct hlist_head *packet_list)
 {
 	struct packet_list_entry *entry;
@@ -347,6 +346,7 @@ void frag_packet_list(struct bat_priv *bat_priv,
 		switch (packet_type) {
 		case BAT_UNICAST:
 			if (!atomic_read(&bat_priv->fragmentation) ||
+			    bonding == REDUNDANT_BONDING ||
 			    entry->skb->len <=
 			    entry->neigh_node->if_incoming->net_dev->mtu)
 				break;
@@ -372,7 +372,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
-	int ret = NET_RX_DROP;
+	int ret = NET_RX_DROP, bonding_mode;
 
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
@@ -398,7 +398,9 @@ route:
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
-	ret = route_unicast_packet(skb, NULL, orig_node);
+	bonding_mode = atomic_read(&bat_priv->bonding) <<
+			atomic_read(&bat_priv->red_bonding);
+	ret = route_unicast_packet(bonding_mode, skb, NULL, orig_node);
 
 out:
 	if (ret == NET_RX_DROP)
diff --git a/batman-adv/unicast.h b/batman-adv/unicast.h
index 1b4dbb0..e87597b 100644
--- a/batman-adv/unicast.h
+++ b/batman-adv/unicast.h
@@ -30,7 +30,7 @@
 int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
-void frag_packet_list(struct bat_priv *bat_priv,
+void frag_packet_list(int bonding, struct bat_priv *bat_priv,
 		      struct hlist_head *packet_list);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 
-- 
1.7.2.3

