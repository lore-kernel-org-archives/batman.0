Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 18 Feb 2012 17:38:50 +0100
Message-Id: <1329583133-11681-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1329583133-11681-1-git-send-email-ordex@autistici.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 4/7] batman-adv: Distributed ARP Table -
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
 distributed-arp-table.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++-
 distributed-arp-table.h |   10 ++++
 packet.h                |    5 ++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f36b85c..84e4630 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -30,6 +30,70 @@
 #include "types.h"
 #include "unicast.h"
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
+static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
+			uint16_t type, int hdr_size, char *msg) {
+	struct unicast_4addr_packet *unicast_4addr_packet;
+
+	if (msg)
+		bat_dbg(DBG_ARP, bat_priv, "%s\n", msg);
+
+	bat_dbg(DBG_ARP, bat_priv, "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
+		ARP_HW_SRC(skb, hdr_size), &ARP_IP_SRC(skb, hdr_size),
+		ARP_HW_DST(skb, hdr_size), &ARP_IP_DST(skb, hdr_size));
+
+	if (hdr_size == 0)
+		return;
+
+	/* if the AP packet is encapsulated in a batman packet, let's print some
+	 * debug messages */
+	unicast_4addr_packet = (struct unicast_4addr_packet *)skb->data;
+
+	switch (unicast_4addr_packet->u.header.packet_type) {
+	case BAT_UNICAST:
+		bat_dbg(DBG_ARP, bat_priv, "* encapsulated within a UNICAST "
+			"packet\n");
+		break;
+	case BAT_UNICAST_4ADDR:
+		bat_dbg(DBG_ARP, bat_priv, "* encapsulated within a "
+			"UNICAST_4ADDR packet (src: %pM)\n",
+			unicast_4addr_packet->src);
+		switch (unicast_4addr_packet->subtype) {
+		case BAT_P_DAT_DHT_PUT:
+			bat_dbg(DBG_ARP, bat_priv, "* type: DAT_DHT_PUT\n");
+			break;
+		case BAT_P_DAT_DHT_GET:
+			bat_dbg(DBG_ARP, bat_priv, "* type: DAT_DHT_GET\n");
+			break;
+		case BAT_P_DAT_CACHE_REPLY:
+			bat_dbg(DBG_ARP, bat_priv, "* type: DAT_CACHE_REPLY\n");
+			break;
+		case BAT_P_DATA:
+			bat_dbg(DBG_ARP, bat_priv, "* type: DATA\n");
+			break;
+		default:
+			bat_dbg(DBG_ARP, bat_priv, "* type: Unknown!\n");
+		}
+		break;
+	case BAT_BCAST:
+		bat_dbg(DBG_ARP, bat_priv, "* encapsulated within a BCAST "
+			"packet (src: %pM)\n",
+			((struct bcast_packet *)unicast_4addr_packet)->orig);
+		break;
+	default:
+		bat_dbg(DBG_ARP, bat_priv, "* encapsulated within an unknown "
+			"packet type (0x%x)\n",
+			unicast_4addr_packet->u.header.packet_type);
+	}
+}
+
+#else
+
+#define bat_dbg_arp(...)
+
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 static bool is_orig_node_eligible(struct dht_candidate *res, int select,
 				  dat_addr_t tmp_max, dat_addr_t max,
 				  dat_addr_t last_max,
@@ -64,7 +128,6 @@ out:
 	return ret;
 }
 
-
 /* Given a key, selects the candidates which the DHT message has to be sent to.
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
@@ -212,3 +275,55 @@ out:
 	kfree(cand);
 	return ret;
 }
+
+/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
+ * returns 0 */
+static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
+			     int hdr_size)
+{
+	struct arphdr *arphdr;
+	struct ethhdr *ethhdr;
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
+	 * IP information */
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
+	 * will simply ignore it */
+	if (ipv4_is_loopback(ARP_IP_SRC(skb, hdr_size)) ||
+	    ipv4_is_multicast(ARP_IP_SRC(skb, hdr_size)) ||
+	    ipv4_is_loopback(ARP_IP_DST(skb, hdr_size)) ||
+	    ipv4_is_multicast(ARP_IP_DST(skb, hdr_size)))
+		goto out;
+
+	type = ntohs(arphdr->ar_op);
+out:
+	return type;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 89d52c8..b5bf2d1 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -25,8 +25,18 @@
 #include "types.h"
 #include "originator.h"
 
+#include <linux/if_arp.h>
+
 #define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
 
+#define ARP_HW_SRC(skb, hdr_size) ((uint8_t *)(skb->data + hdr_size) + \
+				   ETH_HLEN + sizeof(struct arphdr))
+#define ARP_IP_SRC(skb, hdr_size) (*(uint32_t *)(ARP_HW_SRC(skb, hdr_size) + \
+				   ETH_ALEN))
+#define ARP_HW_DST(skb, hdr_size) (ARP_HW_SRC(skb, hdr_size) + ETH_ALEN + 4)
+#define ARP_IP_DST(skb, hdr_size) (*(uint32_t *)(ARP_HW_SRC(skb, hdr_size) + \
+				   ETH_ALEN * 2 + 4))
+
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
diff --git a/packet.h b/packet.h
index f704c51..02b0c87 100644
--- a/packet.h
+++ b/packet.h
@@ -37,7 +37,10 @@ enum bat_packettype {
 };
 
 enum bat_subtype {
-	BAT_P_DATA		= 0x01
+	BAT_P_DATA		= 0x01,
+	BAT_P_DAT_DHT_GET	= 0x02,
+	BAT_P_DAT_DHT_PUT	= 0x03,
+	BAT_P_DAT_CACHE_REPLY	= 0x04
 };
 
 /* this file is included by batctl which needs these defines */
-- 
1.7.3.4

