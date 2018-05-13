Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 May 2018 06:38:49 +0800
Message-Id: <20180513223849.14636-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: disable ethtool link speed
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

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
---
v2:
 * added ethtool compat code for Linux < 4.6
 * additional explanation text in the commit msg & code

 compat-include/linux/ethtool.h |  2 ++
 net/batman-adv/bat_v_elp.c     | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index df9844d9..caa70071 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -33,6 +33,7 @@ struct batadv_ethtool_link_ksettings {
 	struct {
 		__u32	speed;
 		__u8	duplex;
+		__u8	autoneg;
 	} base;
 };
 
@@ -53,6 +54,7 @@ batadv_ethtool_get_link_ksettings(struct net_device *dev,
 		return ret;
 
 	link_ksettings->base.duplex = cmd.duplex;
+	link_ksettings->base.autoneg = cmd.autoneg;
 	link_ksettings->base.speed = ethtool_cmd_speed(&cmd);
 
 	return 0;
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 28687493..71c20c1d 100644
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
2.17.0

