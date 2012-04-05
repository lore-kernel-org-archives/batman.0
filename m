Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  5 Apr 2012 12:39:00 +0200
Message-Id: <1333622342-6128-15-git-send-email-ordex@autistici.org>
In-Reply-To: <1333622342-6128-1-git-send-email-ordex@autistici.org>
References: <1333622342-6128-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 14/16] batman-adv: drop STP over batman
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/soft-interface.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9a21e9f..7585029 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -130,6 +130,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct hard_iface *primary_if = NULL;
 	struct bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
+	uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
 	unsigned int header_len = 0;
 	int data_len = skb->len, ret;
 	short vid = -1;
@@ -159,6 +160,11 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* Register the client MAC in the transtable */
 	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
+	/* don't accept stp packets. STP does not help in meshes.
+	 * better use the bridge loop avoidance ... */
+	if (compare_eth(ethhdr->h_dest, stp_addr))
+		goto dropped;
+
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		do_bcast = true;
 
-- 
1.7.9.4

