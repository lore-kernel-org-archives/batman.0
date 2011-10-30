Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 30 Oct 2011 09:56:00 +0100
Message-Id: <1319964962-5092-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1319964962-5092-1-git-send-email-ordex@autistici.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Distributed ARP Table - add
	ARP parsing functions
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
 arp.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 arp.h |    7 +++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arp.c b/arp.c
index 39043b8..ea7cc1e 100644
--- a/arp.c
+++ b/arp.c
@@ -183,3 +183,46 @@ out:
 	kfree(cand);
 	return ret;
 }
+
+/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwise
+ * returns 0 */
+uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb)
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
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN + arp_hdr_len(skb->dev) + 8 + 12)))
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
+	bat_dbg(DBG_ARP, bat_priv, "ARP message of type %d recognised "
+		"[%pM-%pI4 %pM-%pI4]\n", type, ARP_HW_SRC(skb),
+		&ARP_IP_SRC(skb), ARP_HW_DST(skb), &ARP_IP_DST(skb));
+out:
+	return type;
+}
diff --git a/arp.h b/arp.h
index ee1a8b3..56b0a0a 100644
--- a/arp.h
+++ b/arp.h
@@ -22,6 +22,13 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) + sizeof(struct arphdr))
+#define ARP_IP_SRC(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN))
+#define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
+#define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + 4))
+
+uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb);
+
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
-- 
1.7.3.4

