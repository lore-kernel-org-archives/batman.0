Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 19 Aug 2012 20:10:09 +0200
Message-Id: <1345399809-9177-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: don't allow ECTP traffic on
	batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

We have seen this to break networks when used with bridge loop
avoidance. As we can't see any benefit from sending these ancient frames
via our mesh, we just drop them.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 soft-interface.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 1aee7db..f04a605 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -143,8 +143,10 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	struct batadv_bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
 	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
-	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00,
-						   0x00};
+	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
+						   0x00, 0x00};
+	static const uint8_t ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
+						    0x00, 0x00};
 	unsigned int header_len = 0;
 	int data_len = skb->len, ret;
 	short vid __maybe_unused = -1;
@@ -177,10 +179,16 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
+	 *
+	 * The same goes for ECTP sent at least by some Cisco Switches,
+	 * it might confuse the mesh when used with bridge loop avoidance.
 	 */
 	if (batadv_compare_eth(ethhdr->h_dest, stp_addr))
 		goto dropped;
 
+	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
+		goto dropped;
+
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		do_bcast = true;
 
-- 
1.7.10

