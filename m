Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  8 Nov 2011 12:34:19 +0100
Message-Id: <1320752062-21776-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1320752062-21776-1-git-send-email-ordex@autistici.org>
References: <1320752062-21776-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/7] batman-adv: Distributed ARP Table -
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

* now this patch is checkpatch --strict clean
* corrected use of arp_hdr_len()
* added print of ARP type as string (uses scnprintf())


 distributed-arp-table.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |    8 +++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 5bc3004..5fad513 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -179,3 +179,54 @@ out:
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
+	char buf[30], *type_str[] = { "REQUEST", "REPLY", "RREQUEST", "RREPLY",
+				      "InREQUEST", "InREPLY", "NAK" };
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
+
+	if (type >= 1 && type <= 10)
+		scnprintf(buf, 30, "%s", type_str[type - 1]);
+	else
+		scnprintf(buf, 30, "UNKNOWN (%hu)", type);
+
+	bat_dbg(DBG_ARP, bat_priv, "ARP message of type %s recognised "
+		"[%pM-%pI4 %pM-%pI4]\n", buf, ARP_HW_SRC(skb), &ARP_IP_SRC(skb),
+		ARP_HW_DST(skb), &ARP_IP_DST(skb));
+out:
+	return type;
+}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index ee1a8b3..439af22 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -22,6 +22,14 @@
 #ifndef _NET_BATMAN_ADV_ARP_H_
 #define _NET_BATMAN_ADV_ARP_H_
 
+#define ARP_HW_SRC(skb) ((uint8_t *)(skb->data) + sizeof(struct ethhdr) + \
+			sizeof(struct arphdr))
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

