Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 10 Feb 2012 00:41:41 +0100
Message-Id: <1328830902-11574-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-1-git-send-email-ordex@autistici.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 8/9] batman-adv: add UNICAST_4ADDR packet
	type
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

The current unicast packet type does not contain the orig source address. This
patches add a new unicast packet (called UNICAST_4ADDR) which provide two new
fields: the originator source address and the subtype (the type of the data
contained in the packet payload). The former is useful to identify the node
which injected the packet into the network and the latter is useful to avoid
creating new unicast packet types in the future: a macro defining a new subtype
will be enough.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c |    1 +
 packet.h         |   29 ++++++++++++----
 routing.c        |   10 ++++-
 unicast.c        |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 unicast.h        |    4 ++
 5 files changed, 131 insertions(+), 10 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 9ad30b8..31dcce0 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -632,6 +632,7 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 		/* unicast packet */
 	case BAT_UNICAST:
+	case BAT_UNICAST_4ADDR:
 		ret = recv_unicast_packet(skb, hard_iface);
 		break;
 
diff --git a/packet.h b/packet.h
index caa12fe..c59256b 100644
--- a/packet.h
+++ b/packet.h
@@ -25,14 +25,21 @@
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 enum bat_packettype {
-	BAT_OGM		 = 0x01,
-	BAT_ICMP	 = 0x02,
-	BAT_UNICAST	 = 0x03,
-	BAT_BCAST	 = 0x04,
-	BAT_VIS		 = 0x05,
-	BAT_UNICAST_FRAG = 0x06,
-	BAT_TT_QUERY	 = 0x07,
-	BAT_ROAM_ADV	 = 0x08
+	BAT_OGM		  = 0x01,
+	BAT_ICMP	  = 0x02,
+	BAT_UNICAST	  = 0x03,
+	BAT_BCAST	  = 0x04,
+	BAT_VIS		  = 0x05,
+	BAT_UNICAST_FRAG  = 0x06,
+	BAT_TT_QUERY	  = 0x07,
+	BAT_ROAM_ADV	  = 0x08,
+	BAT_UNICAST_4ADDR = 0x09
+};
+
+enum bat_subtype {
+	BAT_P_DATA       = 0x01,
+	BAT_P_DHT_GET    = 0x02,
+	BAT_P_DHT_PUT    = 0x03
 };
 
 /* this file is included by batctl which needs these defines */
@@ -158,6 +165,12 @@ struct unicast_packet {
 	uint8_t  dest[ETH_ALEN];
 } __packed;
 
+struct unicast_4addr_packet {
+	struct unicast_packet u;
+	uint8_t src[ETH_ALEN];
+	uint8_t subtype;
+} __packed;
+
 struct unicast_frag_packet {
 	struct batman_header header;
 	uint8_t  ttvn; /* destination translation table version number */
diff --git a/routing.c b/routing.c
index 7b7fcbe..e3c9e5b 100644
--- a/routing.c
+++ b/routing.c
@@ -960,14 +960,20 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 
+	unicast_packet = (struct unicast_packet *)skb->data;
+
+	/* the caller function should have already pulled 2 bytes */
+	if (unicast_packet->header.packet_type == BAT_UNICAST)
+		hdr_size = sizeof(struct unicast_packet);
+	else if (unicast_packet->header.packet_type == BAT_UNICAST_4ADDR)
+		hdr_size = sizeof(struct unicast_4addr_packet);
+
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	if (!check_unicast_ttvn(bat_priv, skb))
 		return NET_RX_DROP;
 
-	unicast_packet = (struct unicast_packet *)skb->data;
-
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
diff --git a/unicast.c b/unicast.c
index 887342b..feaf195 100644
--- a/unicast.c
+++ b/unicast.c
@@ -306,6 +306,42 @@ bool prepare_unicast_packet(struct sk_buff *skb, struct orig_node *orig_node)
 	return true;
 }
 
+bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+				  struct sk_buff *skb,
+				  struct orig_node *orig_node)
+{
+	struct hard_iface *primary_if;
+	struct unicast_4addr_packet *unicast_4addr_packet;
+	bool ret = false;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	if (my_skb_head_push(skb, sizeof(*unicast_4addr_packet)) < 0)
+		goto out;
+
+	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
+
+	unicast_4addr_packet->u.header.version = COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_4addr_packet->u.header.packet_type = BAT_UNICAST_4ADDR;
+	/* set unicast ttl */
+	unicast_4addr_packet->u.header.ttl = TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_4addr_packet->u.dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_4addr_packet->u.ttvn =
+		(uint8_t)atomic_read(&orig_node->last_ttvn);
+	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
+	       ETH_ALEN);
+	ret = true;
+out:
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	return ret;
+}
+
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
@@ -366,3 +402,64 @@ out:
 		kfree_skb(skb);
 	return ret;
 }
+
+int unicast_4addr_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct unicast_4addr_packet *unicast_4addr_packet;
+	struct orig_node *orig_node;
+	struct neigh_node *neigh_node;
+	int data_len = skb->len;
+	int ret = 1;
+
+	/* get routing information */
+	if (is_multicast_ether_addr(ethhdr->h_dest)) {
+		orig_node = gw_get_selected_orig(bat_priv);
+		if (orig_node)
+			goto find_router;
+	}
+
+	/* check for tt host - increases orig_node refcount.
+	 * returns NULL in case of AP isolation */
+	orig_node = transtable_search(bat_priv, ethhdr->h_source,
+				      ethhdr->h_dest);
+
+find_router:
+	/**
+	 * find_router():
+	 *  - if orig_node is NULL it returns NULL
+	 *  - increases neigh_nodes refcount if found.
+	 */
+	neigh_node = find_router(bat_priv, orig_node, NULL);
+
+	if (!neigh_node)
+		goto out;
+
+	if (!prepare_unicast_4addr_packet(bat_priv, skb, orig_node))
+		goto out;
+
+	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
+
+	if (atomic_read(&bat_priv->fragmentation) &&
+	    data_len + sizeof(*unicast_4addr_packet) >
+				neigh_node->if_incoming->net_dev->mtu) {
+		/* send frag skb decreases ttl */
+		unicast_4addr_packet->u.header.ttl++;
+		ret = frag_send_skb(skb, bat_priv,
+				    neigh_node->if_incoming, neigh_node->addr);
+		goto out;
+	}
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = 0;
+	goto out;
+
+out:
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+	if (orig_node)
+		orig_node_free_ref(orig_node);
+	if (ret == 1)
+		kfree_skb(skb);
+	return ret;
+}
diff --git a/unicast.h b/unicast.h
index c51ad3d..1a7bf0a 100644
--- a/unicast.h
+++ b/unicast.h
@@ -31,9 +31,13 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
+int unicast_4addr_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
 bool prepare_unicast_packet(struct sk_buff *skb, struct orig_node *orig_node);
+bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+				  struct sk_buff *skb,
+				  struct orig_node *orig_node);
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
-- 
1.7.3.4

