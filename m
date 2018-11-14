Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 14:46:18 +0100
Message-Id: <20181114134618.17557-3-sw@simonwunderlich.de>
In-Reply-To: <20181114134618.17557-1-sw@simonwunderlich.de>
References: <20181114134618.17557-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Expand merged fragment
 buffer for full packet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The complete size ("total_size") of the fragmented packet is stored in the
fragment header and in the size of the fragment chain. When the fragments
are ready for merge, the skbuff's tail of the first fragment is expanded to
have enough room after the data pointer for at least total_size. This means
that it gets expanded by total_size - first_skb->len.

But this is ignoring the fact that after expanding the buffer, the fragment
header is pulled by from this buffer. Assuming that the tailroom of the
buffer was already 0, the buffer after the data pointer of the skbuff is
now only total_size - len(fragment_header) large. When the merge function
is then processing the remaining fragments, the code to copy the data over
to the merged skbuff will cause an skb_over_panic when it tries to actually
put enough data to fill the total_size bytes of the packet.

The size of the skb_pull must therefore also be taken into account when the
buffer's tailroom is expanded.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Reported-by: Martin Weinelt <martin@darmstadt.freifunk.net>
Co-authored-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 0fddc17106bd..5b71a289d04f 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -275,7 +275,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	kfree(entry);
 
 	packet = (struct batadv_frag_packet *)skb_out->data;
-	size = ntohs(packet->total_size);
+	size = ntohs(packet->total_size) + hdr_size;
 
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
-- 
2.11.0

