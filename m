Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:59 +0200
Message-Id: <20180524120300.15829-8-sw@simonwunderlich.de>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] batman-adv: disable ethtool link speed
 detection when auto negotiation off
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Marek Lindner <mareklindner@neomailbox.ch>

Virtual interface drivers such as tun / tap interfaces, VLAN, etc tend
to initialize the interface throughput with some value for the sake of
having a throughput number to export via ethtool. This exported
throughput leaves batman-adv to conclude the interface throughput is
genuine (reflecting reality), thus no measurements are necessary.

Based on the observation that those interface types also tend to set
the link auto-negotiation to 'off', batman-adv shall check this
setting to differentiate between genuine link throughput information
and placeholders installed by virtual interfaces.

The "default throughput" setting exported via sysfs still allows to
configure the batman-adv throughput for the interface, thus disabling
the measurements.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 28687493599f..71c20c1d4002 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -127,7 +127,20 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
-	if (ret == 0) {
+
+	/* Virtual interface drivers such as tun / tap interfaces, VLAN, etc
+	 * tend to initialize the interface throughput with some value for the
+	 * sake of having a throughput number to export via ethtool. This
+	 * exported throughput leaves batman-adv to conclude the interface
+	 * throughput is genuine (reflecting reality), thus no measurements
+	 * are necessary.
+	 *
+	 * Based on the observation that those interface types also tend to set
+	 * the link auto-negotiation to 'off', batman-adv shall check this
+	 * setting to differentiate between genuine link throughput information
+	 * and placeholders installed by virtual interfaces.
+	 */
+	if (ret == 0 && link_settings.base.autoneg == AUTONEG_ENABLE) {
 		/* link characteristics might change over time */
 		if (link_settings.base.duplex == DUPLEX_FULL)
 			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
-- 
2.11.0

