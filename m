Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 13:23:01 +0200
Message-Id: <1381663381-626-17-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
References: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: Add dummy soft-interface
	rx mode handler
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@meshcoding.com>

From: Linus Lüssing <linus.luessing@web.de>

We do not actually need to set any rx filters for the virtual batman
soft interface. However a dummy handler enables a user to set static
multicast listeners for instance.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/soft-interface.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 15c7237..e8a2bd6 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
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
@@ -583,6 +595,7 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_get_stats = batadv_interface_stats,
 	.ndo_set_mac_address = batadv_interface_set_mac_addr,
 	.ndo_change_mtu = batadv_interface_change_mtu,
+	.ndo_set_rx_mode = batadv_interface_set_rx_mode,
 	.ndo_start_xmit = batadv_interface_tx,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_add_slave = batadv_softif_slave_add,
-- 
1.8.3.2

