Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 26 May 2013 17:56:07 +0200
Message-Id: <1369583768-15280-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Add dummy soft-interface rx
	mode handler
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

We do not actually need to set any rx filters for the virtual batman
soft interface. However a dummy handler enables a user to set static
multicast listeners for instance.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
* Fixes issue #171

v2: added kernel doc

 soft-interface.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 2bad57f..54b3991 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -137,6 +137,18 @@ static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+/**
+ * batadv_interface_set_rx_mode - set the rx mode of a device
+ * @dev: registered network device to modify
+ *
+ * We do not actually need to set any rx filters for the virtual batman
+ * soft interface. However a dummy handler enables a user to set static
+ * multicast listeners for instance.
+ */
+static void batadv_interface_set_rx_mode(struct net_device *dev)
+{
+}
+
 static int batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
@@ -572,6 +584,7 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_get_stats = batadv_interface_stats,
 	.ndo_set_mac_address = batadv_interface_set_mac_addr,
 	.ndo_change_mtu = batadv_interface_change_mtu,
+	.ndo_set_rx_mode = batadv_interface_set_rx_mode,
 	.ndo_start_xmit = batadv_interface_tx,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_add_slave = batadv_softif_slave_add,
-- 
1.7.10.4

