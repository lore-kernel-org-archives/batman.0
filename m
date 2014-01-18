Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 18 Jan 2014 19:31:56 +0100
Message-Id: <1390069917-5411-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390069917-5411-1-git-send-email-linus.luessing@web.de>
References: <1390069917-5411-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 1/2] batman-adv: use eth_hdr() instead of
	skb->data in interface_tx path
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

Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on having
the skb ether header pointer set correctly since the following commit
present in kernels >= 3.9:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)

Therefore we can safely use eth_hdr() instead of skb->data now, which
spares us some ugly type casts.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.h         |   35 +++++++++++++++++++++++++++++++++++
 soft-interface.c |    6 +++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 57c9d96..8a0ccc5 100644
--- a/compat.h
+++ b/compat.h
@@ -332,6 +332,41 @@ static int __batadv_interface_set_mac_addr(x, y)
 	pos && ({ n = pos->member.next; 1; }); \
 	pos = hlist_entry_safe(n, typeof(*pos), member))
 
+#define BATADV_SET_ETHTOOL_OPS(netdev, ops) \
+	((netdev)->ethtool_ops = (ops))
+
+#define __batadv_interface_tx \
+	({ \
+		int func(struct sk_buff *skb, struct net_device *soft_iface) \
+		{ \
+			skb_reset_mac_header(skb); \
+			return batadv_interface_tx(skb, soft_iface); \
+		} \
+		&func; \
+	 })
+
+#undef SET_ETHTOOL_OPS
+#define SET_ETHTOOL_OPS(dev, batadv_ethtool_ops) \
+	({ \
+		const struct net_device_ops my_net_device_ops = { \
+			.ndo_init = batadv_softif_init_late, \
+			.ndo_open = batadv_interface_open, \
+			.ndo_stop = batadv_interface_release, \
+			.ndo_get_stats = batadv_interface_stats, \
+			.ndo_vlan_rx_add_vid = batadv_interface_add_vid, \
+			.ndo_vlan_rx_kill_vid = batadv_interface_kill_vid, \
+			.ndo_set_mac_address = batadv_interface_set_mac_addr, \
+			.ndo_change_mtu = batadv_interface_change_mtu, \
+			.ndo_set_rx_mode = batadv_interface_set_rx_mode, \
+			.ndo_start_xmit = __batadv_interface_tx, \
+			.ndo_validate_addr = eth_validate_addr, \
+			.ndo_add_slave = batadv_softif_slave_add, \
+			.ndo_del_slave = batadv_softif_slave_del, \
+		}; \
+		dev->netdev_ops = &my_net_device_ops; \
+		BATADV_SET_ETHTOOL_OPS(dev, batadv_ethtool_ops); \
+	 })
+
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
diff --git a/soft-interface.c b/soft-interface.c
index f82c267..66903a1 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -176,7 +176,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	soft_iface->trans_start = jiffies;
 	vid = batadv_get_vid(skb, 0);
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
@@ -194,7 +194,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* skb->data might have been reallocated by batadv_bla_tx() */
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source)) {
@@ -230,7 +230,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		/* skb->data may have been modified by
 		 * batadv_gw_dhcp_recipient_get()
 		 */
-		ethhdr = (struct ethhdr *)skb->data;
+		ethhdr = eth_hdr(skb);
 		/* if gw_mode is on, broadcast any non-DHCP message.
 		 * All the DHCP packets are going to be sent as unicast
 		 */
-- 
1.7.10.4

