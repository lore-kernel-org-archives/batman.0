Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:47 +0100
Message-Id: <1329583133-11681-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1329583133-11681-1-git-send-email-ordex@autistici.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 1/7] batman-adv: add UNICAST_4ADDR packet
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
patches add a new unicast packet (called UNICAST_4ADDR) which provides two new
fields: the originator source address and the subtype (the type of the data
contained in the packet payload). The former is useful to identify the node
which injected the packet into the network and the latter is useful to avoid
creating new unicast packet types in the future: a macro defining a new subtype
will be enough.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c |    1 +
 packet.h         |   27 ++++++++++----
 routing.c        |    8 +++-
 unicast.c        |  100 +++++++++++++++++++++++++++++++++++++++++++----------
 unicast.h        |   17 +++++++++-
 5 files changed, 123 insertions(+), 30 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index dfa948b..f18459c 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -627,6 +627,7 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 		/* unicast packet */
 	case BAT_UNICAST:
+	case BAT_UNICAST_4ADDR:
 		ret = recv_unicast_packet(skb, hard_iface);
 		break;
 
diff --git a/packet.h b/packet.h
index 7971a69..f704c51 100644
--- a/packet.h
+++ b/packet.h
@@ -25,14 +25,19 @@
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 enum bat_packettype {
-	BAT_IV_OGM	 = 0x01,
-	BAT_ICMP	 = 0x02,
-	BAT_UNICAST	 = 0x03,
-	BAT_BCAST	 = 0x04,
-	BAT_VIS		 = 0x05,
-	BAT_UNICAST_FRAG = 0x06,
-	BAT_TT_QUERY	 = 0x07,
-	BAT_ROAM_ADV	 = 0x08
+	BAT_IV_OGM		= 0x01,
+	BAT_ICMP		= 0x02,
+	BAT_UNICAST		= 0x03,
+	BAT_BCAST		= 0x04,
+	BAT_VIS			= 0x05,
+	BAT_UNICAST_FRAG	= 0x06,
+	BAT_TT_QUERY		= 0x07,
+	BAT_ROAM_ADV		= 0x08,
+	BAT_UNICAST_4ADDR	= 0x09
+};
+
+enum bat_subtype {
+	BAT_P_DATA		= 0x01
 };
 
 /* this file is included by batctl which needs these defines */
@@ -158,6 +163,12 @@ struct unicast_packet {
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
index a055386..f87b2ae 100644
--- a/routing.c
+++ b/routing.c
@@ -960,14 +960,18 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 
+	unicast_packet = (struct unicast_packet *)skb->data;
+
+	/* the caller function should have already pulled 2 bytes */
+	if (unicast_packet->header.packet_type == BAT_UNICAST_4ADDR)
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
index 0897dfa..18e5cfd 100644
--- a/unicast.c
+++ b/unicast.c
@@ -283,13 +283,77 @@ out:
 	return ret;
 }
 
-int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
+static bool pull_and_fill_unicast(struct sk_buff *skb, int hdr_size,
+				  struct orig_node *orig_node)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct unicast_packet *unicast_packet;
+
+	if (my_skb_head_push(skb, hdr_size) < 0)
+		return false;
+
+	unicast_packet = (struct unicast_packet *)skb->data;
+	unicast_packet->header.version = COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->header.packet_type = BAT_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->header.ttl = TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn =
+		(uint8_t)atomic_read(&orig_node->last_ttvn);
+
+	return true;
+}
+
+static bool prepare_unicast_packet(struct sk_buff *skb,
+				   struct orig_node *orig_node)
+{
+	return pull_and_fill_unicast(skb, sizeof(struct unicast_packet),
+				     orig_node);
+}
+
+static bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+					 struct sk_buff *skb,
+					 struct orig_node *orig_node,
+					 int packet_subtype)
+{
+	struct hard_iface *primary_if;
+	struct unicast_4addr_packet *unicast_4addr_packet;
+	bool ret = false;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	/* pull the header space and fill the unicast_packet substructure.
+	 * We can do that because the first member of the unicast_4addr_packet
+	 * is of type struct unicast_packet */
+	if (!pull_and_fill_unicast(skb, sizeof(*unicast_4addr_packet),
+				   orig_node))
+		goto out;
+
+	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
+	unicast_4addr_packet->u.header.packet_type = BAT_UNICAST_4ADDR;
+	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
+	       ETH_ALEN);
+	unicast_4addr_packet->subtype = packet_subtype;
+
+	ret = true;
+out:
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	return ret;
+}
+
+int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			     int packet_type, int packet_subtype)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int data_len = skb->len;
+	struct unicast_packet *unicast_packet;
 	int ret = 1;
 
 	/* get routing information */
@@ -303,7 +367,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	 * returns NULL in case of AP isolation */
 	orig_node = transtable_search(bat_priv, ethhdr->h_source,
 				      ethhdr->h_dest);
-
 find_router:
 	/**
 	 * find_router():
@@ -311,27 +374,27 @@ find_router:
 	 *  - increases neigh_nodes refcount if found.
 	 */
 	neigh_node = find_router(bat_priv, orig_node, NULL);
-
 	if (!neigh_node)
 		goto out;
 
-	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+	switch (packet_type) {
+	case BAT_UNICAST:
+		prepare_unicast_packet(skb, orig_node);
+		break;
+	case BAT_UNICAST_4ADDR:
+		prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
+					     packet_subtype);
+		break;
+	default:
+		/* this function supports UNICAST and UNICAST_4ADDR only. It
+		 * should never be invoked with any other packet type */
 		goto out;
+	}
 
 	unicast_packet = (struct unicast_packet *)skb->data;
-
-	unicast_packet->header.version = COMPAT_VERSION;
-	/* batman packet type: unicast */
-	unicast_packet->header.packet_type = BAT_UNICAST;
-	/* set unicast ttl */
-	unicast_packet->header.ttl = TTL;
-	/* copy the destination for faster routing */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	/* set the destination tt version number */
-	unicast_packet->ttvn =
-		(uint8_t)atomic_read(&orig_node->last_ttvn);
-
-	if (atomic_read(&bat_priv->fragmentation) &&
+	/* fragmentation mechanism only works for UNICAST (now) */
+	if (packet_type == BAT_UNICAST &&
+	    atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(*unicast_packet) >
 				neigh_node->if_incoming->net_dev->mtu) {
 		/* send frag skb decreases ttl */
@@ -343,7 +406,6 @@ find_router:
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
-	goto out;
 
 out:
 	if (neigh_node)
diff --git a/unicast.h b/unicast.h
index a9faf6b..ae9775b 100644
--- a/unicast.h
+++ b/unicast.h
@@ -30,9 +30,24 @@
 int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
-int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
+int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			     int packet_type, int packet_subtype);
+
+static inline int unicast_send_skb(struct sk_buff *skb,
+				   struct bat_priv *bat_priv)
+{
+	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
+}
+
+static inline int unicast_4addr_send_skb(struct sk_buff *skb,
+					 struct bat_priv *bat_priv,
+					 int packet_subtype)
+{
+	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
+					packet_subtype);
+}
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
-- 
1.7.3.4

