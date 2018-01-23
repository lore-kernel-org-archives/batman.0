Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Tue, 23 Jan 2018 10:59:50 +0100
Message-Id: <3f5713999a5f61ed7221944276393b4ff40a9416.1516701590.git.mschiffer@universe-factory.net>
In-Reply-To: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
References: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
In-Reply-To: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
References: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint v2 2/2] batman-adv: invalidate checksum
 on fragment reassembly
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

A more sophisticated implementation could try to combine fragment checksums
when all fragments have CHECKSUM_COMPLETE and are split at even offsets.
For now, we just set ip_summed to CHECKSUM_NONE to avoid "hw csum failure"
warnings in the kernel log when fragmented frames are received. In
consequence, skb_pull_rcsum() can be replaced with skb_pull().

Note that in usual setups, packets don't reach batman-adv with
CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
batadv's ethtype?), which is why the log messages do nor occur on every
system using batman-adv. I could reproduce this issue by stacking
batman-adv on top of a VXLAN interface.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/fragmentation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index ebe6e389..1bb2b43f 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -287,7 +287,8 @@ batadv_frag_merge_packets(struct hlist_head *chain)
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
2.16.1

