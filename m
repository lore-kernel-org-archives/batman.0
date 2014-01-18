Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 18 Jan 2014 03:57:13 +0100
Message-Id: <1390013833-9364-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use eth_hdr() instead of
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

Using eth_hdr() instead of skb->data avoids some ugly type casts.

I wasn't able to reproduce the skb ether header pointer mismatch
mentioned in batadv_bla_tx() on a 3.11 kernel with a vlan on top of
bat0 and therefore removed the according skb_reset_mac_header()
call, too. In fact, it looks like it became obsolete with the following
commit, included since 3.9:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
This unfortunately didn't work:
#define BATADV_SET_ETHTOOL_OPS(netdev, ops) SET_ETHTOOL_OPS(netdev, ops)

If anyone has an idea how to achieve that, just let me know.
So had to do a copy and paste of that dusty macro.


Changes for v3: removed skb_reset_mac_header() entirely in the general code,
but added it again for kernels < 3.9 via compat.h


 bridge_loop_avoidance.c |    3 ---
 compat.h                |   35 +++++++++++++++++++++++++++++++++++
 soft-interface.c        |    7 ++++---
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 5c0eda4..26ec489 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1535,9 +1535,6 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		goto allow;
 
-	/* in VLAN case, the mac header might not be set. */
-	skb_reset_mac_header(skb);
-
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
 		goto handled;
 
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
index f82c267..795224d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -176,7 +176,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	soft_iface->trans_start = jiffies;
 	vid = batadv_get_vid(skb, 0);
-	ethhdr = (struct ethhdr *)skb->data;
+
+	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
@@ -194,7 +195,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* skb->data might have been reallocated by batadv_bla_tx() */
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source)) {
@@ -230,7 +231,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
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

