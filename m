Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:51:37 +0100
Message-Id: <20180302175142.11838-3-sw@simonwunderlich.de>
In-Reply-To: <20180302175142.11838-1-sw@simonwunderlich.de>
References: <20180302175142.11838-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: invalidate checksum on
 fragment reassembly
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Matthias Schiffer <mschiffer@universe-factory.net>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Matthias Schiffer <mschiffer@universe-factory.net>

A more sophisticated implementation could try to combine fragment checksums
when all fragments have CHECKSUM_COMPLETE and are split at even offsets.
For now, we just set ip_summed to CHECKSUM_NONE to avoid "hw csum failure"
warnings in the kernel log when fragmented frames are received. In
consequence, skb_pull_rcsum() can be replaced with skb_pull().

Note that in usual setups, packets don't reach batman-adv with
CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
batadv's ethtype?), which is why the log messages do not occur on every
system using batman-adv. I could reproduce this issue by stacking
batman-adv on top of a VXLAN interface.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Tested-by: Maximilian Wilhelm <max@sdn.clinic>
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 22dde42fd80e..5afe641ee4b0 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -288,7 +288,8 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	/* Move the existing MAC header to just before the payload. (Override
 	 * the fragment header.)
 	 */
-	skb_pull_rcsum(skb_out, hdr_size);
+	skb_pull(skb_out, hdr_size);
+	skb_out->ip_summed = CHECKSUM_NONE;
 	memmove(skb_out->data - ETH_HLEN, skb_mac_header(skb_out), ETH_HLEN);
 	skb_set_mac_header(skb_out, -ETH_HLEN);
 	skb_reset_network_header(skb_out);
-- 
2.11.0

