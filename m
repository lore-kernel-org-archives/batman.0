Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Feb 2017 11:26:34 +0100
Message-Id: <20170212102634.6279-2-sven@narfation.org>
In-Reply-To: <20170212102634.6279-1-sven@narfation.org>
References: <20170212102634.6279-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Keep fragments equally sized
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

The batman-adv fragmentation packets have the design problem that they
cannot be refragmented. This often leads to problems when networks are
incorrectly configured and don't use a common MTU.

The sender could for example fragment a 1500 byte packet to fit in a 1280
bytes large MTU. This would create a 1280 large packet and a 284 bytes
large packet. But the next hop is then not able to transport 1280 bytes to
its next hop. The 1280 byte large packet will be dropped but the 284 bytes
large packet will still be forwarded to its destination.

This can partly being avoided by splitting packets more equally. In this
example, the two 782 bytes large packets could both potentially reach its
destination.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is meant to enter master together with
https://patchwork.open-mesh.org/patch/16933/

 net/batman-adv/fragmentation.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 7b523e6c..8655db03 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -404,7 +404,7 @@ out:
  * batadv_frag_create - create a fragment from skb
  * @skb: skb to create fragment from
  * @frag_head: header to use in new fragment
- * @mtu: size of new fragment
+ * @fragment_size: size of new fragment
  *
  * Split the passed skb into two fragments: A new one with size matching the
  * passed mtu and the old one with the rest. The new skb contains data from the
@@ -414,11 +414,11 @@ out:
  */
 static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 					  struct batadv_frag_packet *frag_head,
-					  unsigned int mtu)
+					  unsigned int fragment_size)
 {
 	struct sk_buff *skb_fragment;
 	unsigned int header_size = sizeof(*frag_head);
-	unsigned int fragment_size = mtu - header_size;
+	unsigned int mtu = fragment_size + header_size;
 
 	skb_fragment = netdev_alloc_skb(NULL, mtu + ETH_HLEN);
 	if (!skb_fragment)
@@ -456,7 +456,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	struct sk_buff *skb_fragment;
 	unsigned int mtu = neigh_node->if_incoming->net_dev->mtu;
 	unsigned int header_size = sizeof(frag_header);
-	unsigned int max_fragment_size, max_packet_size;
+	unsigned int max_fragment_size, num_fragments;
 	int ret;
 
 	/* To avoid merge and refragmentation at next-hops we never send
@@ -464,10 +464,15 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	 */
 	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
-	max_packet_size = max_fragment_size * BATADV_FRAG_MAX_FRAGMENTS;
+
+	if (skb->len == 0 || max_fragment_size == 0)
+		return -EINVAL;
+
+	num_fragments = (skb->len - 1) / max_fragment_size + 1;
+	max_fragment_size = (skb->len - 1) / num_fragments + 1;
 
 	/* Don't even try to fragment, if we need more than 16 fragments */
-	if (skb->len > max_packet_size) {
+	if (num_fragments > BATADV_FRAG_MAX_FRAGMENTS) {
 		ret = -EAGAIN;
 		goto free_skb;
 	}
@@ -501,7 +506,8 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 
 	/* Eat and send fragments from the tail of skb */
 	while (skb->len > max_fragment_size) {
-		skb_fragment = batadv_frag_create(skb, &frag_header, mtu);
+		skb_fragment = batadv_frag_create(skb, &frag_header,
+						  max_fragment_size);
 		if (!skb_fragment) {
 			ret = -ENOMEM;
 			goto put_primary_if;
-- 
2.11.0

