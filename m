Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Reserve needed_*room for fragments
Date: Thu, 26 Nov 2020 16:31:20 +0100
Message-Id: <20201126153120.1053700-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The batadv net_device is trying to propagate the needed_headroom and
needed_tailroom from the lower devices. This is needed to avoid cost
intensive reallocations using pskb_expand_head during the transmission.

But the fragmentation code splitted the skb's without adding extra room at
the end/beginning of the various fragments. This reduced the performance of
transmissions over complex scenarios (batadv on vxlan on wireguard) because
the lower devices had to perform the reallocations at least once.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v1:
- added commit message
- added tailroom

 net/batman-adv/fragmentation.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 97220e19..8a73804d 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -391,6 +391,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 
 /**
  * batadv_frag_create() - create a fragment from skb
+ * @net_dev: outgoing device for fragment
  * @skb: skb to create fragment from
  * @frag_head: header to use in new fragment
  * @fragment_size: size of new fragment
@@ -401,22 +402,25 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
  *
  * Return: the new fragment, NULL on error.
  */
-static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
+static struct sk_buff *batadv_frag_create(struct net_device *net_dev,
+					  struct sk_buff *skb,
 					  struct batadv_frag_packet *frag_head,
 					  unsigned int fragment_size)
 {
+	unsigned int ll_reserved = LL_RESERVED_SPACE(net_dev);
+	unsigned int tailroom = net_dev->needed_tailroom;
 	struct sk_buff *skb_fragment;
 	unsigned int header_size = sizeof(*frag_head);
 	unsigned int mtu = fragment_size + header_size;
 
-	skb_fragment = netdev_alloc_skb(NULL, mtu + ETH_HLEN);
+	skb_fragment = dev_alloc_skb(ll_reserved + mtu + tailroom);
 	if (!skb_fragment)
 		goto err;
 
 	skb_fragment->priority = skb->priority;
 
 	/* Eat the last mtu-bytes of the skb */
-	skb_reserve(skb_fragment, header_size + ETH_HLEN);
+	skb_reserve(skb_fragment, ll_reserved + header_size);
 	skb_split(skb, skb_fragment, skb->len - fragment_size);
 
 	/* Add the header */
@@ -439,11 +443,12 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
 			    struct batadv_neigh_node *neigh_node)
 {
+	struct net_device *net_dev = neigh_node->if_incoming->net_dev;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_frag_packet frag_header;
 	struct sk_buff *skb_fragment;
-	unsigned int mtu = neigh_node->if_incoming->net_dev->mtu;
+	unsigned int mtu = net_dev->mtu;
 	unsigned int header_size = sizeof(frag_header);
 	unsigned int max_fragment_size, num_fragments;
 	int ret;
@@ -503,7 +508,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 			goto put_primary_if;
 		}
 
-		skb_fragment = batadv_frag_create(skb, &frag_header,
+		skb_fragment = batadv_frag_create(net_dev, skb, &frag_header,
 						  max_fragment_size);
 		if (!skb_fragment) {
 			ret = -ENOMEM;
-- 
2.29.2

