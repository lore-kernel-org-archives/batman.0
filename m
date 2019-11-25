Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Revert "disable ethtool link speed detection when
 auto negotiation off"
Date: Mon, 25 Nov 2019 10:46:50 +0100
Message-Id: <20191125094650.12435-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The commit d60b8fc69ef2 ("batman-adv: disable ethtool link speed detection
when auto negotiation off") disabled the usage of ethtool's link_ksetting
when auto negotation was enabled due to invalid values when used with
tun/tap virtual net_devices. According to the patch, automatic measurements
should be used for these kind of interfaces.

But there are major flaws with this argumentation:

* automatic measurements are not implemented
* auto negotiation has nothing to do with the validity of the retrieved
  values

The first point has to be fixed by a longer patch series. The "validity"
part of the second point must be addressed in the same patch series by
dropping the usage of ethtool's link_ksetting (thus always doing automatic
measurements over ethernet).

Drop the patch again to have more default values for various net_device
types/configurations. The user can still overwrite them using the
batadv_hardif's BATADV_ATTR_THROUGHPUT_OVERRIDE.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/ethtool.h |  2 --
 net/batman-adv/bat_v_elp.c     | 15 +--------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index e1f39c33..8dcbe02c 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -21,7 +21,6 @@ struct batadv_ethtool_link_ksettings {
 	struct {
 		__u32	speed;
 		__u8	duplex;
-		__u8	autoneg;
 	} base;
 };
 
@@ -42,7 +41,6 @@ batadv_ethtool_get_link_ksettings(struct net_device *dev,
 		return ret;
 
 	link_ksettings->base.duplex = cmd.duplex;
-	link_ksettings->base.autoneg = cmd.autoneg;
 	link_ksettings->base.speed = ethtool_cmd_speed(&cmd);
 
 	return 0;
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 2614a9ca..a39af0ee 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -120,20 +120,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
-
-	/* Virtual interface drivers such as tun / tap interfaces, VLAN, etc
-	 * tend to initialize the interface throughput with some value for the
-	 * sake of having a throughput number to export via ethtool. This
-	 * exported throughput leaves batman-adv to conclude the interface
-	 * throughput is genuine (reflecting reality), thus no measurements
-	 * are necessary.
-	 *
-	 * Based on the observation that those interface types also tend to set
-	 * the link auto-negotiation to 'off', batman-adv shall check this
-	 * setting to differentiate between genuine link throughput information
-	 * and placeholders installed by virtual interfaces.
-	 */
-	if (ret == 0 && link_settings.base.autoneg == AUTONEG_ENABLE) {
+	if (ret == 0) {
 		/* link characteristics might change over time */
 		if (link_settings.base.duplex == DUPLEX_FULL)
 			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
-- 
2.20.1

