Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2018 20:33:14 +0100
Message-Id: <20181104193314.18104-3-sven@narfation.org>
In-Reply-To: <20181104193314.18104-1-sven@narfation.org>
References: <20181104193314.18104-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Convert existing sysfs options
 to netlink
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
Cc: Jiri Pirko <jiri@mellanox.com>, Sven Eckelmann <sven@narfation.org>

The current netlink options are only available via sysfs. While the new
netlink interface could only be used for new options, it is easier for the
userspace to have a unified interface which works for new and old options.

Most options in sysfs are already simple values and their sysfs filenames
can be used as key for the new netlink configuration interface. But the
multi-value files like gw_bandwidth and isolation_mark can be split to
better fit in their batadv internal representation:

* isolation_mark
   - isolation_mask
   - isolation_mark
* gw_bandwidth
  - gw_bandwidth_down
  - gw_bandwidth_up

TODO add more description here.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink_cfg.c | 1045 ++++++++++++++++++++++++++++++++++
 1 file changed, 1045 insertions(+)

diff --git a/net/batman-adv/netlink_cfg.c b/net/batman-adv/netlink_cfg.c
index 6e4229f1..7f8a41e1 100644
--- a/net/batman-adv/netlink_cfg.c
+++ b/net/batman-adv/netlink_cfg.c
@@ -19,6 +19,7 @@
 #include "netlink_cfg.h"
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/genetlink.h>
 #include <linux/gfp.h>
@@ -35,17 +36,1061 @@
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "bridge_loop_avoidance.h"
+#include "distributed-arp-table.h"
+#include "gateway_client.h"
+#include "gateway_common.h"
 #include "hard-interface.h"
+#include "log.h"
 #include "netlink.h"
 #include "soft-interface.h"
 
+/**
+ * batadv_option_get_aggregated_ogms() - Retrieve aggregated_ogms option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_aggregated_ogms(struct batadv_priv *bat_priv,
+					     void *ext_arg,
+					     union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->aggregated_ogms);
+	return 0;
+}
+
+/**
+ * batadv_option_set_aggregated_ogms() - Set aggregated_ogms option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_aggregated_ogms(struct batadv_priv *bat_priv, void *ext_arg,
+				  const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->aggregated_ogms, val->vbool);
+	return 0;
+}
+
+/**
+ * batadv_option_get_ap_isolation() - Retrieve ap_isolation option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_ap_isolation(struct batadv_priv *bat_priv,
+					  void *ext_arg,
+					  union batadv_config_value *val)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (!vlan)
+		return -ENOENT;
+
+	val->vbool = !!atomic_read(&vlan->ap_isolation);
+	batadv_softif_vlan_put(vlan);
+
+	return 0;
+}
+
+/**
+ * batadv_option_set_ap_isolation() - Set ap_isolation option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_ap_isolation(struct batadv_priv *bat_priv,
+					  void *ext_arg,
+					  const union batadv_config_value *val)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (!vlan)
+		return -ENOENT;
+
+	atomic_set(&vlan->ap_isolation, val->vbool);
+	batadv_softif_vlan_put(vlan);
+
+	return 0;
+}
+
+/**
+ * batadv_option_get_bonding() - Retrieve bonding option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_bonding(struct batadv_priv *bat_priv,
+				     void *ext_arg,
+				     union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->bonding);
+	return 0;
+}
+
+/**
+ * batadv_option_set_bonding() - Set bonding option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_bonding(struct batadv_priv *bat_priv,
+				     void *ext_arg,
+				     const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->bonding, val->vbool);
+	return 0;
+}
+
+#ifdef CONFIG_BATMAN_ADV_BLA
+
+/**
+ * batadv_option_get_bridge_loop_avoidance() - Retrieve bridge_loop_avoidance
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_get_bridge_loop_avoidance(struct batadv_priv *bat_priv,
+					void *ext_arg,
+					union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->bridge_loop_avoidance);
+	return 0;
+}
+
+/**
+ * batadv_option_set_bridge_loop_avoidance() - Set bridge_loop_avoidance option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_bridge_loop_avoidance(struct batadv_priv *bat_priv,
+					void *ext_arg,
+					const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->bridge_loop_avoidance, val->vbool);
+	batadv_bla_status_update(bat_priv->soft_iface);
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_BLA */
+
+#ifdef CONFIG_BATMAN_ADV_DAT
+
+/**
+ * batadv_option_get_distributed_arp_table() - Retrieve distributed_arp_table
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_get_distributed_arp_table(struct batadv_priv *bat_priv,
+					void *ext_arg,
+					union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->distributed_arp_table);
+	return 0;
+}
+
+/**
+ * batadv_option_set_distributed_arp_table() - Set distributed_arp_table option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_distributed_arp_table(struct batadv_priv *bat_priv,
+					void *ext_arg,
+					const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->distributed_arp_table, val->vbool);
+	batadv_dat_status_update(bat_priv->soft_iface);
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
+/**
+ * batadv_option_get_fragmentation() - Retrieve fragmentation
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_fragmentation(struct batadv_priv *bat_priv,
+					   void *ext_arg,
+					   union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->fragmentation);
+	return 0;
+}
+
+/**
+ * batadv_option_set_fragmentation() - Set fragmentation option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_fragmentation(struct batadv_priv *bat_priv,
+					   void *ext_arg,
+					   const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->fragmentation, val->vbool);
+	batadv_update_min_mtu(bat_priv->soft_iface);
+	return 0;
+}
+
+/**
+ * batadv_option_get_gw_bandwidth_down() - Retrieve gw_bandwidth_down
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_gw_bandwidth_down(struct batadv_priv *bat_priv,
+					       void *ext_arg,
+					       union batadv_config_value *val)
+{
+	val->vu32 = atomic_read(&bat_priv->gw.bandwidth_down);
+	return 0;
+}
+
+/**
+ * batadv_option_set_gw_bandwidth_down() - Set gw_bandwidth_down option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_gw_bandwidth_down(struct batadv_priv *bat_priv, void *ext_arg,
+				    const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->gw.bandwidth_down, val->vu32);
+	batadv_gw_tvlv_container_update(bat_priv);
+	return 0;
+}
+
+/**
+ * batadv_option_get_gw_bandwidth_up() - Retrieve gw_bandwidth_up
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_gw_bandwidth_up(struct batadv_priv *bat_priv,
+					     void *ext_arg,
+					     union batadv_config_value *val)
+{
+	val->vu32 = atomic_read(&bat_priv->gw.bandwidth_up);
+	return 0;
+}
+
+/**
+ * batadv_option_set_gw_bandwidth_up() - Set gw_bandwidth_up option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_gw_bandwidth_up(struct batadv_priv *bat_priv, void *ext_arg,
+				  const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->gw.bandwidth_up, val->vu32);
+	batadv_gw_tvlv_container_update(bat_priv);
+	return 0;
+}
+
+/**
+ * batadv_option_get_gw_mode() - Retrieve gw_mode
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save string
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_gw_mode(struct batadv_priv *bat_priv,
+				     void *ext_arg,
+				     union batadv_config_value *val)
+{
+	/* GW mode is not available if the routing algorithm in use does not
+	 * implement the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -EOPNOTSUPP;
+
+	switch (atomic_read(&bat_priv->gw.mode)) {
+	case BATADV_GW_MODE_CLIENT:
+		strlcpy(val->string, BATADV_GW_MODE_CLIENT_NAME,
+			sizeof(val->string));
+		break;
+	case BATADV_GW_MODE_SERVER:
+		strlcpy(val->string, BATADV_GW_MODE_SERVER_NAME,
+			sizeof(val->string));
+		break;
+	default:
+		strlcpy(val->string, BATADV_GW_MODE_OFF_NAME,
+			sizeof(val->string));
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * batadv_option_set_gw_mode() - Set gw_mode option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: string value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_gw_mode(struct batadv_priv *bat_priv,
+				     void *ext_arg,
+				     const union batadv_config_value *val)
+{
+	int gw_mode_tmp = BATADV_GW_MODE_OFF;
+
+	if (strcmp(val->string, BATADV_GW_MODE_OFF_NAME) == 0)
+		gw_mode_tmp = BATADV_GW_MODE_OFF;
+
+	if (strcmp(val->string, BATADV_GW_MODE_CLIENT_NAME) == 0)
+		gw_mode_tmp = BATADV_GW_MODE_CLIENT;
+
+	if (strcmp(val->string, BATADV_GW_MODE_SERVER_NAME) == 0)
+		gw_mode_tmp = BATADV_GW_MODE_SERVER;
+
+	/* Invoking batadv_gw_reselect() is not enough to really de-select the
+	 * current GW. It will only instruct the gateway client code to perform
+	 * a re-election the next time that this is needed.
+	 *
+	 * When gw client mode is being switched off the current GW must be
+	 * de-selected explicitly otherwise no GW_ADD uevent is thrown on
+	 * client mode re-activation. This is operation is performed in
+	 * batadv_gw_check_client_stop().
+	 */
+	batadv_gw_reselect(bat_priv);
+	/* always call batadv_gw_check_client_stop() before changing the gateway
+	 * state
+	 */
+	batadv_gw_check_client_stop(bat_priv);
+	atomic_set(&bat_priv->gw.mode, (unsigned int)gw_mode_tmp);
+	batadv_gw_tvlv_container_update(bat_priv);
+
+	return 0;
+}
+
+/**
+ * batadv_option_validate_gw_mode() - Validate gw_mode option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: string value of option to validate
+ * @extack: additional information about error
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_validate_gw_mode(struct batadv_priv *bat_priv,
+					  void *ext_arg,
+					  const union batadv_config_value *val,
+					  struct netlink_ext_ack *extack)
+{
+	const char *str = val->string;
+
+	if (strcmp(BATADV_GW_MODE_OFF_NAME, str) == 0)
+		return 0;
+
+	if (strcmp(BATADV_GW_MODE_CLIENT_NAME, str) == 0)
+		return 0;
+
+	if (strcmp(BATADV_GW_MODE_SERVER_NAME, str) == 0)
+		return 0;
+
+	return -EINVAL;
+}
+
+/**
+ * batadv_option_get_gw_sel_class() - Retrieve gw_sel_class
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_gw_sel_class(struct batadv_priv *bat_priv,
+					  void *ext_arg,
+					  union batadv_config_value *val)
+{
+	/* GW selection class is not available if the routing algorithm in use
+	 * does not implement the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -EOPNOTSUPP;
+
+	val->vu32 = atomic_read(&bat_priv->gw.sel_class);
+
+	return 0;
+}
+
+/**
+ * batadv_option_set_gw_sel_class() - Set gw_sel_class option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_gw_sel_class(struct batadv_priv *bat_priv,
+					  void *ext_arg,
+					  const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->gw.sel_class, val->vu32);
+	batadv_gw_reselect(bat_priv);
+	return 0;
+}
+
+/**
+ * batadv_option_validate_gw_sel_class() - Validate gw_sel_class option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to validate
+ * @extack: additional information about error
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_validate_gw_sel_class(struct batadv_priv *bat_priv, void *ext_arg,
+				    const union batadv_config_value *val,
+				    struct netlink_ext_ack *extack)
+{
+	u32 value = val->vu32;
+
+	/* setting the GW selection class is allowed only if the routing
+	 * algorithm in use implements the GW API
+	 */
+	if (!bat_priv->algo_ops->gw.get_best_gw_node ||
+	    !bat_priv->algo_ops->gw.is_eligible)
+		return -EOPNOTSUPP;
+
+	if (!bat_priv->algo_ops->gw.store_sel_class) {
+		if (value < 1 || value > BATADV_TQ_MAX_VALUE)
+			return -ERANGE;
+	}
+
+	return 0;
+}
+
+/**
+ * batadv_option_get_hop_penalty() - Retrieve hop_penalty
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_hop_penalty(struct batadv_priv *bat_priv,
+					 void *ext_arg,
+					 union batadv_config_value *val)
+{
+	val->vu32 = atomic_read(&bat_priv->hop_penalty);
+	return 0;
+}
+
+/**
+ * batadv_option_set_hop_penalty() - Set hop_penalty option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_hop_penalty(struct batadv_priv *bat_priv,
+					 void *ext_arg,
+					 const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->hop_penalty, val->vu32);
+	return 0;
+}
+
+/**
+ * batadv_option_validate_hop_penalty() - Validate hop_penalty option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to validate
+ * @extack: additional information about error
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_validate_hop_penalty(struct batadv_priv *bat_priv, void *ext_arg,
+				   const union batadv_config_value *val,
+				   struct netlink_ext_ack *extack)
+{
+	u32 value = val->vu32;
+
+	if (value > BATADV_TQ_MAX_VALUE)
+		return -ERANGE;
+
+	return 0;
+}
+
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
+/**
+ * batadv_option_get_log_level() - Retrieve log_level
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_log_level(struct batadv_priv *bat_priv,
+				       void *ext_arg,
+				       union batadv_config_value *val)
+{
+	val->vu32 = atomic_read(&bat_priv->log_level);
+	return 0;
+}
+
+/**
+ * batadv_option_set_log_level() - Set log_level option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_log_level(struct batadv_priv *bat_priv,
+				       void *ext_arg,
+				       const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->log_level, val->vu32);
+	return 0;
+}
+
+/**
+ * batadv_option_validate_log_level() - Validate log_level option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to validate
+ * @extack: additional information about error
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_validate_log_level(struct batadv_priv *bat_priv, void *ext_arg,
+				 const union batadv_config_value *val,
+				 struct netlink_ext_ack *extack)
+{
+	u32 value = val->vu32;
+
+	if (value > BATADV_DBG_ALL)
+		return -ERANGE;
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
+#ifdef CONFIG_BATMAN_ADV_MCAST
+
+/**
+ * batadv_option_get_multicast_mode() - Retrieve multicast_mode option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_multicast_mode(struct batadv_priv *bat_priv,
+					    void *ext_arg,
+					    union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->multicast_mode);
+	return 0;
+}
+
+/**
+ * batadv_option_set_multicast_mode() - Set multicast_mode option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_multicast_mode(struct batadv_priv *bat_priv, void *ext_arg,
+				 const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->multicast_mode, val->vbool);
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_MCAST */
+
+#ifdef CONFIG_BATMAN_ADV_NC
+
+/**
+ * batadv_option_get_network_coding() - Retrieve network_coding option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_network_coding(struct batadv_priv *bat_priv,
+					    void *ext_arg,
+					    union batadv_config_value *val)
+{
+	val->vbool = !!atomic_read(&bat_priv->network_coding);
+	return 0;
+}
+
+/**
+ * batadv_option_set_network_coding() - Set network_coding option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_network_coding(struct batadv_priv *bat_priv, void *ext_arg,
+				 const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->network_coding, val->vbool);
+	batadv_nc_status_update(bat_priv->soft_iface);
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_NC */
+
+/**
+ * batadv_option_get_isolation_mark() - Retrieve isolation_mark
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_isolation_mark(struct batadv_priv *bat_priv,
+					    void *ext_arg,
+					    union batadv_config_value *val)
+{
+	val->vu32 = bat_priv->isolation_mark;
+	return 0;
+}
+
+/**
+ * batadv_option_set_isolation_mark() - Set isolation_mark option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_isolation_mark(struct batadv_priv *bat_priv, void *ext_arg,
+				 const union batadv_config_value *val)
+{
+	bat_priv->isolation_mark = val->vu32;
+	return 0;
+}
+
+/**
+ * batadv_option_get_isolation_mask() - Retrieve isolation_mask
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_isolation_mask(struct batadv_priv *bat_priv,
+					    void *ext_arg,
+					    union batadv_config_value *val)
+{
+	val->vu32 = bat_priv->isolation_mark_mask;
+	return 0;
+}
+
+/**
+ * batadv_option_set_isolation_mask() - Set isolation_mask option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_set_isolation_mask(struct batadv_priv *bat_priv, void *ext_arg,
+				 const union batadv_config_value *val)
+{
+	bat_priv->isolation_mark_mask = val->vu32;
+	return 0;
+}
+
+/**
+ * batadv_option_get_orig_interval() - Retrieve orig_interval
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_get_orig_interval(struct batadv_priv *bat_priv,
+					   void *ext_arg,
+					   union batadv_config_value *val)
+{
+	val->vu32 = atomic_read(&bat_priv->orig_interval);
+	return 0;
+}
+
+/**
+ * batadv_option_set_orig_interval() - Set orig_interval option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_set_orig_interval(struct batadv_priv *bat_priv,
+					   void *ext_arg,
+					   const union batadv_config_value *val)
+{
+	atomic_set(&bat_priv->orig_interval, val->vu32);
+	return 0;
+}
+
+/**
+ * batadv_option_validate_orig_interval() - Validate orig_interval option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: Additional option element (unused)
+ * @val: u32 value of option to validate
+ * @extack: additional information about error
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_validate_orig_interval(struct batadv_priv *bat_priv,
+				     void *ext_arg,
+				     const union batadv_config_value *val,
+				     struct netlink_ext_ack *extack)
+{
+	u32 value = val->vu32;
+
+	if (value < 2 * BATADV_JITTER || value > INT_MAX)
+		return -ERANGE;
+
+	return 0;
+}
+
 static const struct batadv_option softif_options[] = {
+	{
+		.name = "aggregated_ogms",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_aggregated_ogms,
+		.set = batadv_option_set_aggregated_ogms,
+	},
+	{
+		.name = "ap_isolation",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_ap_isolation,
+		.set = batadv_option_set_ap_isolation,
+	},
+	{
+		.name = "bonding",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_bonding,
+		.set = batadv_option_set_bonding,
+	},
+#ifdef CONFIG_BATMAN_ADV_BLA
+	{
+		.name = "bridge_loop_avoidance",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_bridge_loop_avoidance,
+		.set = batadv_option_set_bridge_loop_avoidance,
+	},
+#endif /* CONFIG_BATMAN_ADV_BLA */
+#ifdef CONFIG_BATMAN_ADV_DAT
+	{
+		.name = "distributed_arp_table",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_distributed_arp_table,
+		.set = batadv_option_set_distributed_arp_table,
+	},
+#endif /* CONFIG_BATMAN_ADV_DAT */
+	{
+		.name = "fragmentation",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_fragmentation,
+		.set = batadv_option_set_fragmentation,
+	},
+	{
+		.name = "gw_bandwidth_down",
+		.type = NLA_U32,
+		.get = batadv_option_get_gw_bandwidth_down,
+		.set = batadv_option_set_gw_bandwidth_down,
+	},
+	{
+		.name = "gw_bandwidth_up",
+		.type = NLA_U32,
+		.get = batadv_option_get_gw_bandwidth_up,
+		.set = batadv_option_set_gw_bandwidth_up,
+	},
+	{
+		.name = "gw_mode",
+		.type = NLA_NUL_STRING,
+		.get = batadv_option_get_gw_mode,
+		.set = batadv_option_set_gw_mode,
+		.validate = batadv_option_validate_gw_mode,
+	},
+	{
+		.name = "gw_sel_class",
+		.type = NLA_U32,
+		.get = batadv_option_get_gw_sel_class,
+		.set = batadv_option_set_gw_sel_class,
+		.validate = batadv_option_validate_gw_sel_class,
+	},
+	{
+		.name = "hop_penalty",
+		.type = NLA_U32,
+		.get = batadv_option_get_hop_penalty,
+		.set = batadv_option_set_hop_penalty,
+		.validate = batadv_option_validate_hop_penalty,
+	},
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+	{
+		.name = "log_level",
+		.type = NLA_U32,
+		.get = batadv_option_get_log_level,
+		.set = batadv_option_set_log_level,
+		.validate = batadv_option_validate_log_level,
+	},
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	{
+		.name = "multicast_mode",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_multicast_mode,
+		.set = batadv_option_set_multicast_mode,
+	},
+#endif /* CONFIG_BATMAN_ADV_MCAST */
+#ifdef CONFIG_BATMAN_ADV_NC
+	{
+		.name = "network_coding",
+		.type = NLA_FLAG,
+		.get = batadv_option_get_network_coding,
+		.set = batadv_option_set_network_coding,
+	},
+#endif /* CONFIG_BATMAN_ADV_NC */
+	{
+		.name = "isolation_mark",
+		.type = NLA_U32,
+		.get = batadv_option_get_isolation_mark,
+		.set = batadv_option_set_isolation_mark,
+	},
+	{
+		.name = "isolation_mask",
+		.type = NLA_U32,
+		.get = batadv_option_get_isolation_mask,
+		.set = batadv_option_set_isolation_mask,
+	},
+	{
+		.name = "orig_interval",
+		.type = NLA_U32,
+		.get = batadv_option_get_orig_interval,
+		.set = batadv_option_set_orig_interval,
+		.validate = batadv_option_validate_orig_interval,
+	},
 };
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
+/**
+ * batadv_option_get_elp_interval() - Retrieve elp_interval
+ *  option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: hard interface object with option
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_hardif_get_elp_interval(struct batadv_priv *bat_priv,
+						 void *ext_arg,
+						 union batadv_config_value *val)
+{
+	struct batadv_hard_iface *hard_iface = ext_arg;
+
+	val->vu32 = atomic_read(&hard_iface->bat_v.elp_interval);
+	return 0;
+}
+
+/**
+ * batadv_option_set_elp_interval() - Set elp_interval option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: hard interface object to modify
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_hardif_set_elp_interval(struct batadv_priv *bat_priv,
+				      void *ext_arg,
+				      const union batadv_config_value *val)
+{
+	struct batadv_hard_iface *hard_iface = ext_arg;
+
+	atomic_set(&hard_iface->bat_v.elp_interval, val->vu32);
+	return 0;
+}
+
+/**
+ * batadv_option_hardif_get_tp_override() - Retrieve throughput_override option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: hard interface object with option
+ * @val: Target to save u32
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_hardif_get_tp_override(struct batadv_priv *bat_priv,
+						void *ext_arg,
+						union batadv_config_value *val)
+{
+	struct batadv_hard_iface *hard_iface = ext_arg;
+
+	val->vu32 = atomic_read(&hard_iface->bat_v.throughput_override);
+	return 0;
+}
+
+/**
+ * batadv_option_hardif_set_tp_override() - Set throughput_override option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: hard interface object to modify
+ * @val: u32 value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_hardif_set_tp_override(struct batadv_priv *bat_priv,
+				     void *ext_arg,
+				     const union batadv_config_value *val)
+{
+	struct batadv_hard_iface *hard_iface = ext_arg;
+
+	atomic_set(&hard_iface->bat_v.throughput_override, val->vu32);
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 static const struct batadv_option hardif_options[] = {
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	{
+		.name = "elp_interval",
+		.type = NLA_U32,
+		.get = batadv_option_hardif_get_elp_interval,
+		.set = batadv_option_hardif_set_elp_interval,
+	},
+	{
+		.name = "throughput_override",
+		.type = NLA_U32,
+		.get = batadv_option_hardif_get_tp_override,
+		.set = batadv_option_hardif_set_tp_override,
+	},
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 };
 
+/**
+ * batadv_option_get_ap_isolation() - Retrieve ap_isolation option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: vlan to modify
+ * @val: Target to save boolean
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_option_vlan_get_ap_isolation(struct batadv_priv *bat_priv,
+					       void *ext_arg,
+					       union batadv_config_value *val)
+{
+	struct batadv_softif_vlan *vlan = ext_arg;
+
+	val->vbool = !!atomic_read(&vlan->ap_isolation);
+
+	return 0;
+}
+
+/**
+ * batadv_option_set_ap_isolation() - Set ap_isolation option
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ext_arg: vlan to modify
+ * @val: Boolean value of option to set
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int
+batadv_option_vlan_set_ap_isolation(struct batadv_priv *bat_priv,
+				    void *ext_arg,
+				    const union batadv_config_value *val)
+{
+	struct batadv_softif_vlan *vlan = ext_arg;
+
+	atomic_set(&vlan->ap_isolation, val->vbool);
+
+	return 0;
+}
+
 static const struct batadv_option vlan_options[] = {
+	{
+		.name = "ap_isolation",
+		.type = NLA_FLAG,
+		.get = batadv_option_vlan_get_ap_isolation,
+		.set = batadv_option_vlan_set_ap_isolation,
+	},
 };
 
 /**
-- 
2.19.1

