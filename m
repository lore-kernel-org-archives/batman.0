Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.4 3/3] batman-adv: Don't always reallocate the fragmentation
 skb head
Date: Sat, 20 Nov 2021 13:40:53 +0100
Message-Id: <20211120124053.261156-4-sven@narfation.org>
In-Reply-To: <20211120124053.261156-1-sven@narfation.org>
References: <20211120124053.261156-1-sven@narfation.org>
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
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

commit 992b03b88e36254e26e9a4977ab948683e21bd9f upstream.

When a packet is fragmented by batman-adv, the original batman-adv header
is not modified. Only a new fragmentation is inserted between the original
one and the ethernet header. The code must therefore make sure that it has
a writable region of this size in the skbuff head.

But it is not useful to always reallocate the skbuff by this size even when
there would be more than enough headroom still in the skb. The reallocation
is just to costly during in this codepath.

Fixes: ee75ed88879a ("batman-adv: Fragment and send skbs larger than mtu")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f1d202ff396c..0da90e73c79b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -527,13 +527,14 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		frag_header.no++;
 	}
 
-	/* Make room for the fragment header. */
-	if (batadv_skb_head_push(skb, header_size) < 0 ||
-	    pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0) {
-		ret = -ENOMEM;
+	/* make sure that there is at least enough head for the fragmentation
+	 * and ethernet headers
+	 */
+	ret = skb_cow_head(skb, ETH_HLEN + header_size);
+	if (ret < 0)
 		goto put_primary_if;
-	}
 
+	skb_push(skb, header_size);
 	memcpy(skb->data, &frag_header, header_size);
 
 	/* Send the last fragment */
-- 
2.30.2

