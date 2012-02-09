Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 10 Feb 2012 00:41:37 +0100
Message-Id: <1328830902-11574-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-1-git-send-email-ordex@autistici.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 4/9] batman-adv: Distributed ARP Table -
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
 distributed-arp-table.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |   12 ++++++++++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 4c4e064..95b9934 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -30,6 +30,22 @@
 #include "types.h"
 #include "unicast.h"
 
+static inline void bat_dbg_arp(struct bat_priv *bat_priv,
+			       struct sk_buff *skb, uint16_t type) {
+	char buf[30];
+	const char *type_str[] = { "REQUEST", "REPLY", "RREQUEST", "RREPLY",
+				      "InREQUEST", "InREPLY", "NAK" };
+
+	if (type >= 1 && type <= ARRAY_SIZE(type_str))
+		scnprintf(buf, sizeof(buf), "%s", type_str[type - 1]);
+	else
+		scnprintf(buf, sizeof(buf), "UNKNOWN (%hu)", type);
+
+	bat_dbg(DBG_ARP, bat_priv, "ARP message of type %s recognised "
+		"[src: %pM-%pI4 dst: %pM-%pI4]\n", buf, ARP_HW_SRC(skb),
+		&ARP_IP_SRC(skb), ARP_HW_DST(skb), &ARP_IP_DST(skb));
+}
+
 /* Given a key, selects the candidates which the DHT message has to be sent to.
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (but not greater) then the hash value of the key.
@@ -180,3 +196,43 @@ out:
 	kfree(cand);
 	return ret;
 }
+
+/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
+ * returns 0 */
+static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb)
+{
+	struct arphdr *arphdr;
+	struct ethhdr *ethhdr;
+	uint16_t type = 0;
+
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+		goto out;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	if (ethhdr->h_proto != htons(ETH_P_ARP))
+		goto out;
+
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN + arp_hdr_len(skb->dev))))
+		goto out;
+
+	arphdr = (struct arphdr *)(skb->data + sizeof(struct ethhdr));
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
+	type = ntohs(arphdr->ar_op);
+out:
+	return type;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index cca5c6a..3e0f5c6 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -22,6 +22,12 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#include "main.h"
+
+#include <linux/if_arp.h>
+
+struct bat_priv;
+
 /*
  * dat_addr_t is the type used for all DHT indexes. If it is changed,
  * DAT_ADDR_MAX is changed as well.
@@ -31,6 +37,12 @@
 #define dat_addr_t uint16_t
 #define DAT_ADDR_MAX biggest_unsigned_int(dat_addr_t)
 
+#define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) + \
+			sizeof(struct arphdr))
+#define ARP_IP_SRC(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN))
+#define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
+#define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + 4))
+
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
-- 
1.7.3.4

