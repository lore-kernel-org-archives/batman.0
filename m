Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri,  1 Jul 2016 08:47:57 +0200
Message-Id: <1467355678-32269-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1467355678-32269-1-git-send-email-linus.luessing@c0d3.blue>
References: <1467355678-32269-1-git-send-email-linus.luessing@c0d3.blue>
Subject: [B.A.T.M.A.N.] [RFC PATCH 1/2] batman-adv: Add wrapper for ARP
	reply creation
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

---
 net/batman-adv/distributed-arp-table.c | 47 +++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fa76465..fa36196 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -947,6 +947,27 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 	return vid;
 }
 
+static struct sk_buff *
+batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
+			    __be32 ip_dst, u8 *hw_src, u8 *hw_dst,
+			    unsigned short vid)
+{
+	struct sk_buff *skb;
+
+	skb = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_dst, bat_priv->soft_iface,
+			 ip_src, hw_dst, hw_src, hw_dst);
+	if (!skb)
+		return NULL;
+
+	if (vid & BATADV_VLAN_HAS_TAG)
+		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q),
+				      vid & VLAN_VID_MASK);
+
+	skb_reset_mac_header(skb);
+
+	return skb;
+}
+
 /**
  * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try to
  * answer using DAT
@@ -1005,17 +1026,12 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 			goto out;
 		}
 
-		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-				     bat_priv->soft_iface, ip_dst, hw_src,
-				     dat_entry->mac_addr, hw_src);
+		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
+						      dat_entry->mac_addr,
+						      hw_src, vid);
 		if (!skb_new)
 			goto out;
 
-		if (vid & BATADV_VLAN_HAS_TAG)
-			skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
-						  vid & VLAN_VID_MASK);
-
-		skb_reset_mac_header(skb_new);
 		skb_new->protocol = eth_type_trans(skb_new,
 						   bat_priv->soft_iface);
 		bat_priv->stats.rx_packets++;
@@ -1079,22 +1095,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!dat_entry)
 		goto out;
 
-	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-			     bat_priv->soft_iface, ip_dst, hw_src,
-			     dat_entry->mac_addr, hw_src);
-
+	skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
+					      dat_entry->mac_addr, hw_src, vid);
 	if (!skb_new)
 		goto out;
 
-	/* the rest of the TX path assumes that the mac_header offset pointing
-	 * to the inner Ethernet header has been set, therefore reset it now.
-	 */
-	skb_reset_mac_header(skb_new);
-
-	if (vid & BATADV_VLAN_HAS_TAG)
-		skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
-					  vid & VLAN_VID_MASK);
-
 	/* To preserve backwards compatibility, the node has choose the outgoing
 	 * format based on the incoming request packet type. The assumption is
 	 * that a node not using the 4addr packet format doesn't support it.
-- 
2.1.4

