Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Jun 2017 09:20:32 +0200
Message-Id: <20170618072032.23937-3-sven@narfation.org>
In-Reply-To: <20170618072032.23937-1-sven@narfation.org>
References: <20170618072032.23937-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: make skb_put & friends
 return void pointers
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

From: Johannes Berg <johannes.berg@intel.com>

It seems like a historic accident that these return unsigned char *,
and in many places that means casts are required, more often than not.

Make these functions (skb_put, __skb_put and pskb_put) return void *
and remove all the casts across the tree, adding a (u8 *) cast only
where the unsigned char pointer was used directly, all done with the
following spatch:

    @@
    expression SKB, LEN;
    typedef u8;
    identifier fn = { skb_put, __skb_put };
    @@
    - *(fn(SKB, LEN))
    + *(u8 *)fn(SKB, LEN)

    @@
    expression E, SKB, LEN;
    identifier fn = { skb_put, __skb_put };
    type T;
    @@
    - E = ((T *)(fn(SKB, LEN)))
    + E = fn(SKB, LEN)

which actually doesn't cover pskb_put since there are only three
users overall.

A handful of stragglers were converted manually, notably a macro in
drivers/isdn/i4l/isdn_bsdcomp.c and, oddly enough, one of the many
instances in net/bluetooth/hci_sock.c. In the former file, I also
had to fix one whitespace problem spatch introduced.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is already part of net-next. Only the compat code is new.

 compat-include/linux/skbuff.h | 6 ++++++
 net/batman-adv/icmp_socket.c  | 2 +-
 net/batman-adv/tp_meter.c     | 6 +++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 23677e27..03765c62 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -78,6 +78,12 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 13, 0)
 
+static inline void *batadv_skb_put(struct sk_buff *skb, unsigned int len)
+{
+	return (void *)skb_put(skb, len);
+}
+#define skb_put batadv_skb_put
+
 static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
 {
 	void *tmp = skb_put(skb, len);
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 6308c9f0..8ead2928 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -207,7 +207,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 
 	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, ETH_HLEN);
-	icmp_header = (struct batadv_icmp_header *)skb_put(skb, packet_len);
+	icmp_header = skb_put(skb, packet_len);
 
 	if (copy_from_user(icmp_header, buff, packet_len)) {
 		len = -EFAULT;
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e3e2585d..bfe8effe 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -595,7 +595,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 		return BATADV_TP_REASON_MEMORY_ERROR;
 
 	skb_reserve(skb, ETH_HLEN);
-	icmp = (struct batadv_icmp_tp_packet *)skb_put(skb, sizeof(*icmp));
+	icmp = skb_put(skb, sizeof(*icmp));
 
 	/* fill the icmp header */
 	ether_addr_copy(icmp->dst, orig_node->orig);
@@ -612,7 +612,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 	icmp->timestamp = htonl(timestamp);
 
 	data_len = len - sizeof(*icmp);
-	data = (u8 *)skb_put(skb, data_len);
+	data = skb_put(skb, data_len);
 	batadv_tp_fill_prerandom(tp_vars, data, data_len);
 
 	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
@@ -1190,7 +1190,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 	}
 
 	skb_reserve(skb, ETH_HLEN);
-	icmp = (struct batadv_icmp_tp_packet *)skb_put(skb, sizeof(*icmp));
+	icmp = skb_put(skb, sizeof(*icmp));
 	icmp->packet_type = BATADV_ICMP;
 	icmp->version = BATADV_COMPAT_VERSION;
 	icmp->ttl = BATADV_TTL;
-- 
2.11.0

