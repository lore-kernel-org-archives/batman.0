Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Jul 2012 19:15:41 +0200
Message-Id: <1342286144-24490-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1342286144-24490-1-git-send-email-ordex@autistici.org>
References: <1342286144-24490-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv10 5/8] batman-adv: Distributed ARP Table -
	add ARP parsing functions
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

ARP messages are now parsed to make it possible to trigger special actions
depending on their types (snooping).

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c |  201 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |    2 +
 packet.h                |    5 +-
 3 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 2ccd279..9cac8af 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -21,6 +21,7 @@
 #include <linux/if_arp.h>
 
 #include "main.h"
+#include "hash.h"
 #include "distributed-arp-table.h"
 #include "hard-interface.h"
 #include "originator.h"
@@ -112,6 +113,59 @@ static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
 }
 
 /**
+ * batadv_arp_hw_src - extract the hw_src field from an ARP packet
+ * @skb: ARP packet
+ * @hdr_size: size of the possible header before the ARP packet
+ *
+ * Returns the value of the hw_src field in the ARP packet
+ */
+static uint8_t *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
+{
+	uint8_t *addr;
+
+	addr = (uint8_t *)(skb->data + hdr_size);
+	addr += ETH_HLEN + sizeof(struct arphdr);
+
+	return addr;
+}
+
+/**
+ * batadv_arp_ip_src - extract the ip_src field from an ARP packet
+ * @skb: ARP packet
+ * @hdr_size: size of the possible header before the ARP packet
+ *
+ * Returns the value of the ip_src field in the ARP packet
+ */
+static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
+{
+	return *(__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
+}
+
+/**
+ * batadv_arp_hw_dst - extract the hw_dst field from an ARP packet
+ * @skb: ARP packet
+ * @hdr_size: size of the possible header before the ARP packet
+ *
+ * Returns the value of the hw_dst field in the ARP packet
+ */
+static uint8_t *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
+{
+	return batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN + 4;
+}
+
+/**
+ * batadv_arp_ip_dst - extract the ip_dst field from an ARP packet
+ * @skb: ARP packet
+ * @hdr_size: size of the possible header before the ARP packet
+ *
+ * Returns the value of the ip_dst field in the ARP packet
+ */
+static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
+{
+	return *(__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4);
+}
+
+/**
  * batadv_hash_dat_global - compute the hash value for the global DAT cache
  * @data: data to hash
  * @size: size of the hash table
@@ -258,6 +312,92 @@ out:
 		batadv_dat_entry_free_ref(dat_entry);
 }
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
+/**
+ * batadv_dbg_arp - print a debug message containing all the ARP packet details
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: ARP packet
+ * @type: ARP type
+ * @hdr_size: size of the possible header before the ARP packet
+ * @msg: message to print together with the debugging information
+ */
+static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			   uint16_t type, int hdr_size, char *msg)
+{
+	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+	struct batadv_bcast_packet *bcast_pkt;
+	uint8_t *orig_addr;
+	__be32 ip_src, ip_dst;
+
+	if (msg)
+		batadv_dbg(BATADV_DBG_DAT, bat_priv, "%s\n", msg);
+
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv,
+		   "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
+		   batadv_arp_hw_src(skb, hdr_size), &ip_src,
+		   batadv_arp_hw_dst(skb, hdr_size), &ip_dst);
+
+	if (hdr_size == 0)
+		return;
+
+	/* if the ARP packet is encapsulated in a batman packet, let's print
+	 * some debug messages
+	 */
+	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
+
+	switch (unicast_4addr_packet->u.header.packet_type) {
+	case BATADV_UNICAST:
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "* encapsulated within a UNICAST packet\n");
+		break;
+	case BATADV_UNICAST_4ADDR:
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "* encapsulated within a UNICAST_4ADDR packet (src: %pM)\n",
+			   unicast_4addr_packet->src);
+		switch (unicast_4addr_packet->subtype) {
+		case BATADV_P_DAT_DHT_PUT:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: DAT_DHT_PUT\n");
+			break;
+		case BATADV_P_DAT_DHT_GET:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: DAT_DHT_GET\n");
+			break;
+		case BATADV_P_DAT_CACHE_REPLY:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "* type: DAT_CACHE_REPLY\n");
+			break;
+		case BATADV_P_DATA:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: DATA\n");
+			break;
+		default:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown!\n");
+		}
+		break;
+	case BATADV_BCAST:
+		bcast_pkt = (struct batadv_bcast_packet *)unicast_4addr_packet;
+		orig_addr = bcast_pkt->orig;
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "* encapsulated within a BCAST packet (src: %pM)\n",
+			   orig_addr);
+		break;
+	default:
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "* encapsulated within an unknown packet type (0x%x)\n",
+			   unicast_4addr_packet->u.header.packet_type);
+	}
+}
+
+#else
+
+static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			   uint16_t type, int hdr_size, char *msg)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 /**
  * batadv_is_orig_node_eligible - check whether a node can be a DHT candidate
  * @res: the array with the already selected candidates
@@ -599,3 +739,64 @@ out:
 		batadv_hardif_free_ref(primary_if);
 	return ret;
 }
+
+/**
+ * batadv_arp_get_type - parse an ARP packet and gets the type
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to analyse
+ * @hdr_size: size of the possible header before the ARP packet in the skb
+ *
+ * Returns the ARP type if the skb contains a valid ARP packet, 0 otherwise
+ */
+static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size)
+{
+	struct arphdr *arphdr;
+	struct ethhdr *ethhdr;
+	__be32 ip_src, ip_dst;
+	uint16_t type = 0;
+
+	/* pull the ethernet header */
+	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN)))
+		goto out;
+
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
+
+	if (ethhdr->h_proto != htons(ETH_P_ARP))
+		goto out;
+
+	/* pull the ARP payload */
+	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
+				    arp_hdr_len(skb->dev))))
+		goto out;
+
+	arphdr = (struct arphdr *)(skb->data + hdr_size + ETH_HLEN);
+
+	/* Check whether the ARP packet carries a valid
+	 * IP information
+	 */
+	if (arphdr->ar_hrd != htons(ARPHRD_ETHER))
+		goto out;
+
+	if (arphdr->ar_pro != htons(ETH_P_IP))
+		goto out;
+
+	if (arphdr->ar_hln != ETH_ALEN)
+		goto out;
+
+	if (arphdr->ar_pln != 4)
+		goto out;
+
+	/* Check for bad reply/request. If the ARP message is not sane, DAT
+	 * will simply ignore it
+	 */
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
+	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst))
+		goto out;
+
+	type = ntohs(arphdr->ar_op);
+out:
+	return type;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 0014583..9096749 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -23,6 +23,8 @@
 #include "types.h"
 #include "originator.h"
 
+#include <linux/if_arp.h>
+
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
 
 static inline void
diff --git a/packet.h b/packet.h
index 0656df3..6d7a0a0 100644
--- a/packet.h
+++ b/packet.h
@@ -38,7 +38,10 @@ enum batadv_packettype {
  * enum batadv_subtype - packet subtype for unicast4addr
  */
 enum batadv_subtype {
-	BATADV_P_DATA		= 0x01,
+	BATADV_P_DATA			= 0x01,
+	BATADV_P_DAT_DHT_GET		= 0x02,
+	BATADV_P_DAT_DHT_PUT		= 0x03,
+	BATADV_P_DAT_CACHE_REPLY	= 0x04,
 };
 
 /* this file is included by batctl which needs these defines */
-- 
1.7.9.4

