Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  4 Nov 2010 18:20:59 +0100
Message-Id: <1288891265-16035-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011041820.44518.lindner_marek@yahoo.de>
References: <201011041820.44518.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: gateways silently drop DHCP
	requests
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/gateway_client.c |   31 +++++++++++++++++--------------
 batman-adv/gateway_client.h |    2 +-
 batman-adv/soft-interface.c |   16 ++++++++++------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index e10dc90..2e05dd4 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -399,54 +399,57 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 {
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
 	struct udphdr *udphdr;
 	unsigned int header_len = 0;
 
-	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
-		return false;
-
-	if (!bat_priv->curr_gw)
-		return false;
+	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_OFF)
+		return 0;
 
 	/* check for ethernet header */
 	if (!pskb_may_pull(skb, header_len + ETH_HLEN))
-		return false;
+		return 0;
 	ethhdr = (struct ethhdr *)skb->data;
 	header_len += ETH_HLEN;
 
 	/* check for initial vlan header */
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
 		if (!pskb_may_pull(skb, header_len + VLAN_HLEN))
-			return false;
+			return 0;
 		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
 		header_len += VLAN_HLEN;
 	}
 
 	/* check for ip header */
 	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
-		return false;
+		return 0;
 
 	if (!pskb_may_pull(skb, header_len + sizeof(struct iphdr)))
-		return false;
+		return 0;
 	iphdr = (struct iphdr *)(skb->data + header_len);
 	header_len += iphdr->ihl * 4;
 
 	/* check for udp header */
 	if (iphdr->protocol != IPPROTO_UDP)
-		return false;
+		return 0;
 
 	if (!pskb_may_pull(skb, header_len + sizeof(struct udphdr)))
-		return false;
+		return 0;
 	udphdr = (struct udphdr *)(skb->data + header_len);
 	header_len += sizeof(struct udphdr);
 
 	/* check for bootp port */
 	if (ntohs(udphdr->dest) != 67)
-		return false;
+		return 0;
+
+	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER)
+		return -1;
+
+	if (!bat_priv->curr_gw)
+		return 0;
 
-	return true;
+	return 1;
 }
diff --git a/batman-adv/gateway_client.h b/batman-adv/gateway_client.h
index 38699ba..4585e65 100644
--- a/batman-adv/gateway_client.h
+++ b/batman-adv/gateway_client.h
@@ -31,6 +31,6 @@ void gw_node_update(struct bat_priv *bat_priv,
 void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_purge(struct bat_priv *bat_priv);
 int gw_client_seq_print_text(struct seq_file *seq, void *offset);
-bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
+int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index e16c61b..836c452 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -347,7 +347,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct vlan_ethhdr *vhdr;
 	int data_len = skb->len, ret;
 	short vid = -1;
-	bool bcast_dst = false, do_bcast = true;
+	bool do_bcast = false;
 
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
@@ -378,14 +378,18 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* TODO: check this for locks */
 	hna_local_add(soft_iface, ethhdr->h_source);
 
-	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
-		bcast_dst = true;
+	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
+		ret = gw_is_target(bat_priv, skb);
 
-	if ((bcast_dst) && gw_is_target(bat_priv, skb))
-		do_bcast = false;
+		if (ret < 0)
+			goto dropped;
+
+		if (ret == 0)
+			do_bcast = true;
+	}
 
 	/* ethernet packet should be broadcasted */
-	if (bcast_dst && do_bcast) {
+	if (do_bcast) {
 		if (!bat_priv->primary_if)
 			goto dropped;
 
-- 
1.7.1

