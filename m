Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2018 21:57:18 +0100
Message-Id: <20181124205718.20148-5-sven@narfation.org>
In-Reply-To: <20181124205718.20148-1-sven@narfation.org>
References: <20181124205718.20148-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v3 4/4] batctl: Use netlink as new
 configuration interface
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

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing
settings subcommands were also reimplemented via generic netlink.

To still support older batman-adv versions, the old sysfs infrastructure is
still used in case that the generic netlink command returned an error.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 aggregation.c           |  45 ++++-
 ap_isolation.c          |  67 ++++++-
 bonding.c               |  45 ++++-
 bridge_loop_avoidance.c |  46 ++++-
 distributed_arp_table.c |  46 ++++-
 fragmentation.c         |  45 ++++-
 functions.c             | 109 +++++++++++
 functions.h             |  18 ++
 gw_mode.c               | 415 +++++++++++++++++++++++++++++++---------
 isolation_mark.c        | 123 +++++++++++-
 loglevel.c              | 138 ++++++++++---
 multicast_mode.c        |  45 ++++-
 netlink.c               |  76 ++++++++
 netlink.h               |   2 +
 network_coding.c        |  45 ++++-
 orig_interval.c         |  84 +++++++-
 routing_algo.c          |   1 -
 sys.c                   | 204 ++++++++++++++++----
 sys.h                   |  26 ++-
 19 files changed, 1400 insertions(+), 180 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 57c1dbb..673e0ca 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -21,13 +21,54 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data aggregated_ogms;
+
+static int print_aggregated_ogms(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_AGGREGATED_OGMS);
+}
+
+static int get_aggregated_ogms(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_aggregated_ogms);
+}
+
+static int set_attrs_aggregated_ogms(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_AGGREGATED_OGMS, data->val);
+
+	return 0;
+}
+
+static int set_aggregated_ogms(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_aggregated_ogms, NULL);
+}
+
 static struct settings_data batctl_settings_aggregation = {
 	.sysfs_name = "aggregated_ogms",
-	.params = sysfs_param_enable,
+	.data = &aggregated_ogms,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_aggregated_ogms,
+	.netlink_set = set_aggregated_ogms,
 };
 
 COMMAND_NAMED(SUBCOMMAND, aggregation, "ag", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_aggregation,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_aggregation,
 	      "[0|1]             \tdisplay or modify aggregation setting");
diff --git a/ap_isolation.c b/ap_isolation.c
index 2d16c68..4df46e5 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -21,13 +21,76 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data ap_isolation;
+
+static int print_ap_isolation(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_AP_ISOLATION);
+}
+
+static int get_attrs_ap_isolation(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+
+	if (state->vid >= 0)
+		nla_put_u16(msg, BATADV_ATTR_VLANID, state->vid);
+
+	return 0;
+}
+
+static int get_ap_isolation(struct state *state)
+{
+	enum batadv_nl_commands nl_cmd = BATADV_CMD_SET_MESH;
+
+	if (state->vid >= 0)
+		nl_cmd = BATADV_CMD_GET_VLAN;
+
+	return sys_simple_nlquery(state, nl_cmd, get_attrs_ap_isolation,
+				  print_ap_isolation);
+}
+
+static int set_attrs_ap_isolation(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION, data->val);
+
+	if (state->vid >= 0)
+		nla_put_u16(msg, BATADV_ATTR_VLANID, state->vid);
+
+	return 0;
+}
+
+static int set_ap_isolation(struct state *state)
+{
+	enum batadv_nl_commands nl_cmd = BATADV_CMD_SET_MESH;
+
+	if (state->vid >= 0)
+		nl_cmd = BATADV_CMD_SET_VLAN;
+
+	return sys_simple_nlquery(state, nl_cmd, set_attrs_ap_isolation, NULL);
+}
+
 static struct settings_data batctl_settings_ap_isolation = {
 	.sysfs_name = "ap_isolation",
-	.params = sysfs_param_enable,
+	.data = &ap_isolation,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_ap_isolation,
+	.netlink_set = set_ap_isolation,
 };
 
 COMMAND_NAMED(SUBCOMMAND, ap_isolation, "ap", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_ap_isolation,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_ap_isolation,
 	      "[0|1]             \tdisplay or modify ap_isolation setting");
diff --git a/bonding.c b/bonding.c
index f7105c9..591debd 100644
--- a/bonding.c
+++ b/bonding.c
@@ -21,13 +21,54 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data bonding;
+
+static int print_bonding(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_BONDING);
+}
+
+static int get_bonding(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_bonding);
+}
+
+static int set_attrs_bonding(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_BONDING, data->val);
+
+	return 0;
+}
+
+static int set_bonding(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_bonding, NULL);
+}
+
 static struct settings_data batctl_settings_bonding = {
 	.sysfs_name = "bonding",
-	.params = sysfs_param_enable,
+	.data = &bonding,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_bonding,
+	.netlink_set = set_bonding,
 };
 
 COMMAND_NAMED(SUBCOMMAND, bonding, "b", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bonding,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_bonding,
 	      "[0|1]             \tdisplay or modify bonding setting");
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0db49f2..948a6f1 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -21,13 +21,55 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data bridge_loop_avoidance;
+
+static int print_bridge_loop_avoidance(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg,
+					BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE);
+}
+
+static int get_bridge_loop_avoidance(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_bridge_loop_avoidance);
+}
+
+static int set_attrs_bridge_loop_avoidance(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE, data->val);
+
+	return 0;
+}
+
+static int set_bridge_loop_avoidance(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_bridge_loop_avoidance, NULL);
+}
+
 static struct settings_data batctl_settings_bridge_loop_avoidance = {
 	.sysfs_name = SYS_BLA,
-	.params = sysfs_param_enable,
+	.data = &bridge_loop_avoidance,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_bridge_loop_avoidance,
+	.netlink_set = set_bridge_loop_avoidance,
 };
 
 COMMAND_NAMED(SUBCOMMAND, bridge_loop_avoidance, "bl", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bridge_loop_avoidance,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_bridge_loop_avoidance,
 	      "[0|1]             \tdisplay or modify bridge_loop_avoidance setting");
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index ba6e5b7..ee09518 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -21,13 +21,55 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data distributed_arp_table;
+
+static int print_distributed_arp_table(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg,
+					BATADV_ATTR_DISTRIBUTED_ARP_TABLE);
+}
+
+static int get_distributed_arp_table(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_distributed_arp_table);
+}
+
+static int set_attrs_distributed_arp_table(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE, data->val);
+
+	return 0;
+}
+
+static int set_distributed_arp_table(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_distributed_arp_table, NULL);
+}
+
 static struct settings_data batctl_settings_distributed_arp_table = {
 	.sysfs_name = SYS_DAT,
-	.params = sysfs_param_enable,
+	.data = &distributed_arp_table,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_distributed_arp_table,
+	.netlink_set = set_distributed_arp_table,
 };
 
 COMMAND_NAMED(SUBCOMMAND, distributed_arp_table, "dat", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_distributed_arp_table,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_distributed_arp_table,
 	      "[0|1]             \tdisplay or modify distributed_arp_table setting");
diff --git a/fragmentation.c b/fragmentation.c
index e159bdd..2dee1b8 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -21,13 +21,54 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data fragmentation;
+
+static int print_fragmentation(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_FRAGMENTATION);
+}
+
+static int get_fragmentation(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_fragmentation);
+}
+
+static int set_attrs_fragmentation(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION, data->val);
+
+	return 0;
+}
+
+static int set_fragmentation(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_fragmentation, NULL);
+}
+
 static struct settings_data batctl_settings_fragmentation = {
 	.sysfs_name = "fragmentation",
-	.params = sysfs_param_enable,
+	.data = &fragmentation,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_fragmentation,
+	.netlink_set = set_fragmentation,
 };
 
 COMMAND_NAMED(SUBCOMMAND, fragmentation, "f", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_fragmentation,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_fragmentation,
 	      "[0|1]             \tdisplay or modify fragmentation setting");
diff --git a/functions.c b/functions.c
index 600c29a..bb6dc31 100644
--- a/functions.c
+++ b/functions.c
@@ -499,6 +499,44 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	return mac_result;
 }
 
+int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len)
+{
+	char *path_buff;
+	int ret;
+
+	ret = get_algoname_netlink(mesh_iface, algoname, algoname_len);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return -ENOMEM;
+	}
+
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, mesh_iface);
+	ret = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	if (ret != EXIT_SUCCESS) {
+		ret = -ENOENT;
+		goto free_path_buf;
+	}
+
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	strncpy(algoname, line_ptr, algoname_len);
+	if (algoname_len > 0)
+		algoname[algoname_len - 1] = '\0';
+
+free_path_buf:
+	free(path_buff);
+
+	free(line_ptr);
+	line_ptr = NULL;
+
+	return ret;
+}
+
 static int resolve_l3addr(int ai_family, const char *asc, void *l3addr)
 {
 	int ret;
@@ -1162,3 +1200,74 @@ void check_root_or_die(const char *cmd)
 		exit(EXIT_FAILURE);
 	}
 }
+
+int parse_bool(const char *val, bool *res)
+{
+	if (strcasecmp(val, "0") == 0 ||
+	    strcasecmp(val, "disable") == 0 ||
+	    strcasecmp(val, "disabled") == 0) {
+		*res = false;
+		return 0;
+	} else if (strcasecmp(val, "1") == 0 ||
+		   strcasecmp(val, "enable") == 0 ||
+		   strcasecmp(val, "enabled") == 0) {
+		*res = true;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+bool parse_throughput(char *buff, const char *description, uint32_t *throughput)
+{
+	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
+	uint64_t lthroughput;
+	char *tmp_ptr;
+	char *endptr;
+
+	if (strlen(buff) > 4) {
+		tmp_ptr = buff + strlen(buff) - 4;
+
+		if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
+			bw_unit_type = BATADV_BW_UNIT_MBIT;
+
+		if (strncasecmp(tmp_ptr, "kbit", 4) == 0 ||
+		    bw_unit_type == BATADV_BW_UNIT_MBIT)
+			*tmp_ptr = '\0';
+	}
+
+	lthroughput = strtoull(buff, &endptr, 10);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Invalid throughput speed for %s: %s\n",
+			description, buff);
+		return false;
+	}
+
+	switch (bw_unit_type) {
+	case BATADV_BW_UNIT_MBIT:
+		/* prevent overflow */
+		if (UINT64_MAX / 10 < lthroughput) {
+			fprintf(stderr,
+				"Throughput speed for %s too large: %s\n",
+				description, buff);
+			return false;
+		}
+
+		lthroughput *= 10;
+		break;
+	case BATADV_BW_UNIT_KBIT:
+	default:
+		lthroughput = lthroughput / 100;
+		break;
+	}
+
+	if (lthroughput > UINT32_MAX) {
+		fprintf(stderr, "Throughput speed for %s too large: %s\n",
+			description, buff);
+		return false;
+	}
+
+	*throughput = lthroughput;
+
+	return true;
+}
diff --git a/functions.h b/functions.h
index ea3c307..0331c8b 100644
--- a/functions.h
+++ b/functions.h
@@ -26,9 +26,22 @@
 #include <net/ethernet.h>
 #include <netlink/netlink.h>
 #include <netlink/handlers.h>
+#include <stdbool.h>
 #include <stddef.h>
+#include <stdint.h>
 
 
+/**
+ * enum batadv_bandwidth_units - bandwidth unit types
+ */
+enum batadv_bandwidth_units {
+	/** @BATADV_BW_UNIT_KBIT: unit type kbit */
+	BATADV_BW_UNIT_KBIT,
+
+	/** @BATADV_BW_UNIT_MBIT: unit type mbit */
+	BATADV_BW_UNIT_MBIT,
+};
+
 #define ETH_STR_LEN 17
 #define BATMAN_ADV_TAG "batman-adv:"
 
@@ -53,12 +66,17 @@ struct ether_addr *resolve_mac(const char *asc);
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
 int netlink_simple_request(struct nl_msg *msg);
 int translate_mesh_iface(struct state *state);
+int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len);
 int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 void get_random_bytes(void *buf, size_t buflen);
 void check_root_or_die(const char *cmd);
 
+int parse_bool(const char *val, bool *res);
+bool parse_throughput(char *buff, const char *description,
+		      uint32_t *throughput);
+
 extern char *line_ptr;
 
 enum {
diff --git a/gw_mode.c b/gw_mode.c
index 4093f89..5b7d92b 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -20,23 +20,32 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <getopt.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 
+#include "batman_adv.h"
 #include "functions.h"
+#include "main.h"
+#include "netlink.h"
 #include "sys.h"
 
 #define SYS_GW_MODE		"gw_mode"
 #define SYS_GW_SEL		"gw_sel_class"
 #define SYS_GW_BW		"gw_bandwidth"
 
-enum gw_modes {
-	GW_MODE_OFF,
-	GW_MODE_CLIENT,
-	GW_MODE_SERVER,
-};
+static struct gw_data {
+	uint8_t bandwidth_down_found:1;
+	uint8_t bandwidth_up_found:1;
+	uint8_t sel_class_found:1;
+	uint8_t mode;
+	uint32_t bandwidth_down;
+	uint32_t bandwidth_up;
+	uint32_t sel_class;
+} gw_globals;
 
 static void gw_mode_usage(void)
 {
@@ -45,127 +54,357 @@ static void gw_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-static int gw_mode(struct state *state, int argc, char **argv)
+static bool is_throughput_select_class(struct state *state)
 {
-	int optchar, res = EXIT_FAILURE;
-	char *path_buff, gw_mode;
-	const char **ptr;
+	char algoname[32];
+	int ret;
 
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			gw_mode_usage();
-			return EXIT_SUCCESS;
-		default:
-			gw_mode_usage();
-			return EXIT_FAILURE;
-		}
+	ret = get_algoname(state->mesh_iface, algoname, sizeof(algoname));
+
+	/* no algo name -> assume that it is a pre-B.A.T.M.A.N. V version */
+	if (ret < 0)
+		return false;
+
+	if (strcmp(algoname, "BATMAN_V") == 0)
+		return true;
+
+	return false;
+}
+static int parse_gw_limit(char *buff)
+{
+	char *slash_ptr;
+	bool ret;
+
+	slash_ptr = strchr(buff, '/');
+	if (slash_ptr)
+		*slash_ptr = 0;
+
+	ret = parse_throughput(buff, "download gateway speed",
+				&gw_globals.bandwidth_down);
+	if (!ret)
+		return -EINVAL;
+
+	gw_globals.bandwidth_down_found = 1;
+
+	/* we also got some upload info */
+	if (slash_ptr) {
+		ret = parse_throughput(slash_ptr + 1, "upload gateway speed",
+				       &gw_globals.bandwidth_up);
+		if (!ret)
+			return -EINVAL;
+
+		gw_globals.bandwidth_up_found = 1;
 	}
 
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
-		return EXIT_FAILURE;
+	return 0;
+}
+
+static int parse_gw(struct state *state, int argc, char *argv[])
+{
+	char buff[256];
+	char *endptr;
+	int ret;
+
+	if (argc != 2 && argc != 3) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1/2)\n");
+		return -EINVAL;
 	}
 
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
+	if (strcmp(argv[1], "client") == 0) {
+		gw_globals.mode = BATADV_GW_MODE_CLIENT;
+	} else if (strcmp(argv[1], "server") == 0) {
+		gw_globals.mode = BATADV_GW_MODE_SERVER;
+	} else if (strcmp(argv[1], "off") == 0) {
+		gw_globals.mode = BATADV_GW_MODE_OFF;
+	} else {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		fprintf(stderr, "The following values are allowed:\n");
+		fprintf(stderr, " * off\n");
+		fprintf(stderr, " * client\n");
+		fprintf(stderr, " * server\n");
 
-	if (argc == 1) {
-		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
+		return -EINVAL;
+	}
+
+	if (argc <= 2)
+		return 0;
+
+	strncpy(buff, argv[2], sizeof(buff));
+	buff[sizeof(buff) - 1] = '\0';
+
+	switch (gw_globals.mode) {
+	case  BATADV_GW_MODE_OFF:
+		fprintf(stderr, "Error - unexpected argument for mode \"off\": %s\n", argv[2]);
+		return -EINVAL;
+	case BATADV_GW_MODE_CLIENT:
+		if (is_throughput_select_class(state)) {
+			if (!parse_throughput(buff, "sel_class",
+					      &gw_globals.sel_class))
+				return -EINVAL;
+		} else {
+			gw_globals.sel_class = strtoul(buff, &endptr, 0);
+			if (!endptr || *endptr != '\0') {
+				fprintf(stderr, "Error - unexpected argument for mode \"client\": %s\n", buff);
+				return -EINVAL;
+			}
+		}
+
+		gw_globals.sel_class_found = 1;
+		break;
+	case BATADV_GW_MODE_SERVER:
+		ret = parse_gw_limit(buff);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+
+	return 0;
+}
+
+static int print_gw(struct nl_msg *msg, void *arg)
+{
+	static const int mandatory[] = {
+		BATADV_ATTR_GW_MODE,
+	};
+	static const int mandatory_client[] = {
+		BATADV_ATTR_ALGO_NAME,
+		BATADV_ATTR_GW_SEL_CLASS,
+	};
+	static const int mandatory_server[] = {
+		BATADV_ATTR_GW_BANDWIDTH_DOWN,
+		BATADV_ATTR_GW_BANDWIDTH_UP,
+	};
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+	const char *algo;
+	uint8_t gw_mode;
+	uint32_t val;
+	uint32_t down;
+	uint32_t up;
 
-		if (res != EXIT_SUCCESS)
-			goto out;
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
 
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
+	ghdr = nlmsg_data(nlh);
 
-		if (strcmp(line_ptr, "client") == 0)
-			gw_mode = GW_MODE_CLIENT;
-		else if (strcmp(line_ptr, "server") == 0)
-			gw_mode = GW_MODE_SERVER;
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, mandatory, ARRAY_SIZE(mandatory)))
+		return NL_OK;
+
+	gw_mode = nla_get_u8(attrs[BATADV_ATTR_GW_MODE]);
+	switch (gw_mode) {
+	case BATADV_GW_MODE_OFF:
+		printf("off\n");
+		break;
+	case BATADV_GW_MODE_CLIENT:
+		if (missing_mandatory_attrs(attrs, mandatory_client,
+		    ARRAY_SIZE(mandatory_client)))
+			return NL_OK;
+
+		algo = nla_data(attrs[BATADV_ATTR_ALGO_NAME]);
+		val = nla_get_u32(attrs[BATADV_ATTR_GW_SEL_CLASS]);
+
+		if (strcmp(algo, "BATMAN_V") == 0)
+			printf("client (selection class: %u.%01u MBit)\n",
+			       val / 10, val % 10);
 		else
-			gw_mode = GW_MODE_OFF;
+			printf("client (selection class: %u)\n", val);
+		break;
+	case BATADV_GW_MODE_SERVER:
+		if (missing_mandatory_attrs(attrs, mandatory_server,
+		    ARRAY_SIZE(mandatory_server)))
+			return NL_OK;
 
-		free(line_ptr);
-		line_ptr = NULL;
+		down = nla_get_u32(attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]);
+		up = nla_get_u32(attrs[BATADV_ATTR_GW_BANDWIDTH_UP]);
 
-		switch (gw_mode) {
-		case GW_MODE_CLIENT:
-			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
-			break;
-		case GW_MODE_SERVER:
-			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
-			break;
-		default:
-			printf("off\n");
-			goto out;
-		}
+		printf("server (announced bw: %u.%01u/%u.%01u MBit)\n",
+		       down / 10, down % 10, up / 10, up % 10);
+		break;
+	default:
+		printf("unknown\n");
+		break;
+	}
 
-		if (res != EXIT_SUCCESS)
-			goto out;
+	*result = 0;
+	return NL_STOP;
+}
 
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
+static int get_gw(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH, NULL, print_gw);
+}
 
-		switch (gw_mode) {
-		case GW_MODE_CLIENT:
-			printf("client (selection class: %s)\n", line_ptr);
-			break;
-		case GW_MODE_SERVER:
-			printf("server (announced bw: %s)\n", line_ptr);
-			break;
-		default:
-			goto out;
-		}
+static int set_attrs_gw(struct nl_msg *msg, void *arg __maybe_unused)
+{
+	nla_put_u8(msg, BATADV_ATTR_GW_MODE, gw_globals.mode);
+
+	if (gw_globals.bandwidth_down_found)
+		nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_DOWN,
+			    gw_globals.bandwidth_down);
+
+	if (gw_globals.bandwidth_up_found)
+		nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_UP,
+			    gw_globals.bandwidth_up);
+
+	if (gw_globals.sel_class_found)
+		nla_put_u32(msg, BATADV_ATTR_GW_SEL_CLASS,
+			    gw_globals.sel_class);
 
-		free(line_ptr);
-		line_ptr = NULL;
+	return 0;
+}
+
+static int set_gw(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH, set_attrs_gw,
+				  NULL);
+}
+
+static int gw_read_setting(struct state *state, const char *path_buff)
+{
+	enum batadv_gw_modes gw_mode;
+	int res;
+
+	res = get_gw(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	/* fallback to sysfs */
+	res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
+	if (res != EXIT_SUCCESS)
 		goto out;
-	}
 
-	check_root_or_die("batctl gw_mode");
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
 
-	if (strcmp(argv[1], "client") == 0)
-		gw_mode = GW_MODE_CLIENT;
-	else if (strcmp(argv[1], "server") == 0)
-		gw_mode = GW_MODE_SERVER;
-	else if (strcmp(argv[1], "off") == 0)
-		gw_mode = GW_MODE_OFF;
+	if (strcmp(line_ptr, "client") == 0)
+		gw_mode = BATADV_GW_MODE_CLIENT;
+	else if (strcmp(line_ptr, "server") == 0)
+		gw_mode = BATADV_GW_MODE_SERVER;
 	else
-		goto opt_err;
+		gw_mode = BATADV_GW_MODE_OFF;
 
-	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
-	if (res != EXIT_SUCCESS)
+	free(line_ptr);
+	line_ptr = NULL;
+
+	switch (gw_mode) {
+	case BATADV_GW_MODE_CLIENT:
+		res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
+		break;
+	case BATADV_GW_MODE_SERVER:
+		res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
+		break;
+	default:
+		printf("off\n");
 		goto out;
+	}
 
-	if (argc == 2)
+	if (res != EXIT_SUCCESS)
 		goto out;
 
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
 	switch (gw_mode) {
-	case GW_MODE_CLIENT:
-		res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
+	case BATADV_GW_MODE_CLIENT:
+		printf("client (selection class: %s)\n", line_ptr);
 		break;
-	case GW_MODE_SERVER:
-		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
+	case BATADV_GW_MODE_SERVER:
+		printf("server (announced bw: %s)\n", line_ptr);
 		break;
+	default:
+		goto out;
+	}
+
+out:
+	free(line_ptr);
+	line_ptr = NULL;
+
+	return res;
+}
+
+static int gw_write_setting(struct state *state, const char *path_buff,
+			    int argc, char *argv[])
+{
+	int res = EXIT_FAILURE;
+
+	res = set_gw(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	/* sysfs fallback */
+	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
+	if (res != EXIT_SUCCESS)
+		return res;
+
+	if (argc > 2) {
+		switch (gw_globals.mode) {
+		case BATADV_GW_MODE_CLIENT:
+			res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
+			break;
+		case BATADV_GW_MODE_SERVER:
+			res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
+			break;
+		}
 	}
 
-	goto out;
+	return res;
+}
 
-opt_err:
-	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
-	fprintf(stderr, "The following values are allowed:\n");
+static int gw_mode(struct state *state, int argc, char **argv)
+{
+	int optchar, res = EXIT_FAILURE;
+	char *path_buff;
 
-	ptr = sysfs_param_server;
-	while (*ptr) {
-		fprintf(stderr, " * %s\n", *ptr);
-		ptr++;
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			gw_mode_usage();
+			return EXIT_SUCCESS;
+		default:
+			gw_mode_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
+
+	if (argc == 1) {
+		res = gw_read_setting(state, path_buff);
+		goto out;
+	}
+
+	check_root_or_die("batctl gw_mode");
+
+	res = parse_gw(state, argc, argv);
+	if (res < 0) {
+		res = EXIT_FAILURE;
+		goto out;
 	}
 
+	res = gw_write_setting(state, path_buff, argc, argv);
 out:
 	free(path_buff);
 	return res;
 }
 
-COMMAND(SUBCOMMAND, gw_mode, "gw", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, gw_mode, "gw",
+	COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK, NULL,
 	"[mode]            \tdisplay or modify the gateway mode");
diff --git a/isolation_mark.c b/isolation_mark.c
index 13ba869..e5f504f 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -20,16 +20,135 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <stddef.h>
+#include <stdint.h>
+#include <string.h>
 
 #include "main.h"
 #include "sys.h"
 
+static struct isolation_mark_data {
+	uint32_t isolation_mark;
+	uint32_t isolation_mask;
+} isolation_mark;
+
+static int parse_isolation_mark(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct isolation_mark_data *data = settings->data;
+	char *mask_ptr;
+	char buff[256];
+	uint32_t mark;
+	uint32_t mask;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	strncpy(buff, argv[1], sizeof(buff));
+	buff[sizeof(buff) - 1] = '\0';
+
+	/* parse the mask if it has been specified, otherwise assume the mask is
+	 * the biggest possible
+	 */
+	mask = 0xFFFFFFFF;
+	mask_ptr = strchr(buff, '/');
+	if (mask_ptr) {
+		*mask_ptr = '\0';
+		mask_ptr++;
+
+		/* the mask must be entered in hex base as it is going to be a
+		 * bitmask and not a prefix length
+		 */
+		mask = strtoul(mask_ptr, &endptr, 16);
+		if (!endptr || *endptr != '\0')
+			goto inval_format;
+	}
+
+	/* the mark can be entered in any base */
+	mark = strtoul(buff, &endptr, 0);
+	if (!endptr || *endptr != '\0')
+		goto inval_format;
+
+	data->isolation_mask = mask;
+	/* erase bits not covered by the mask */
+	data->isolation_mark = mark & mask;
+
+	return 0;
+
+inval_format:
+	fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+	fprintf(stderr, "The following formats for mark(/mask) are allowed:\n");
+	fprintf(stderr, " * 0x12345678\n");
+	fprintf(stderr, " * 0x12345678/0xabcdef09\n");
+	return -EINVAL;
+}
+
+static int print_isolation_mark(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_ISOLATION_MARK] ||
+	    !attrs[BATADV_ATTR_ISOLATION_MASK])
+		return NL_OK;
+
+	printf("0x%08x/0x%08x\n",
+	       nla_get_u32(attrs[BATADV_ATTR_ISOLATION_MARK]),
+	       nla_get_u32(attrs[BATADV_ATTR_ISOLATION_MASK]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_isolation_mark(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_isolation_mark);
+}
+
+static int set_attrs_isolation_mark(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct isolation_mark_data *data = settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_ISOLATION_MARK, data->isolation_mark);
+	nla_put_u32(msg, BATADV_ATTR_ISOLATION_MASK, data->isolation_mask);
+
+	return 0;
+}
+
+static int set_isolation_mark(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_isolation_mark, NULL);
+}
+
 static struct settings_data batctl_settings_isolation_mark = {
 	.sysfs_name = "isolation_mark",
-	.params = NULL,
+	.data = &isolation_mark,
+	.parse = parse_isolation_mark,
+	.netlink_get = get_isolation_mark,
+	.netlink_set = set_isolation_mark,
 };
 
 COMMAND_NAMED(SUBCOMMAND, isolation_mark, "mark", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_isolation_mark,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_isolation_mark,
 	      "[mark]            \tdisplay or modify isolation_mark setting");
diff --git a/loglevel.c b/loglevel.c
index fed70c8..fc5fc65 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -20,7 +20,9 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <getopt.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -29,6 +31,10 @@
 #include "main.h"
 #include "sys.h"
 
+static struct log_level_data {
+	uint32_t log_level;
+} log_level_globals;
+
 static void log_level_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
@@ -47,14 +53,93 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
 }
 
+static int extract_log_level(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_LOG_LEVEL])
+		return NL_OK;
+
+	log_level_globals.log_level = nla_get_u32(attrs[BATADV_ATTR_LOG_LEVEL]);
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_log_level(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, extract_log_level);
+}
+
+static int set_attrs_log_level(struct nl_msg *msg, void *arg __maybe_unused)
+{
+	nla_put_u32(msg, BATADV_ATTR_LOG_LEVEL, log_level_globals.log_level);
+
+	return 0;
+}
+
+static int set_log_level(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_log_level, NULL);
+}
+
+static int log_level_read_setting(struct state *state, const char *path_buff)
+{
+	int res;
+
+	res = get_log_level(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
+	if (res != EXIT_SUCCESS)
+		return res;
+
+	log_level_globals.log_level = strtol(line_ptr, (char **) NULL, 10);
+
+	return res;
+}
+
+static int log_level_write_setting(struct state *state, const char *path_buff)
+{
+	int res;
+	char str[4];
+
+	res = set_log_level(state);
+	if (res < 0 && res != -EOPNOTSUPP)
+		return EXIT_FAILURE;
+	if (res >= 0)
+		return EXIT_SUCCESS;
+
+	snprintf(str, sizeof(str), "%i", log_level_globals.log_level);
+	return write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
+}
+
 static int loglevel(struct state *state, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
-	int log_level = 0;
 	char *path_buff;
-	char str[4];
 	int i;
 
+	log_level_globals.log_level = 0;
+
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
 		case 'h':
@@ -79,63 +164,59 @@ static int loglevel(struct state *state, int argc, char **argv)
 
 		for (i = 1; i < argc; i++) {
 			if (strcmp(argv[i], "none") == 0) {
-				log_level = 0;
+				log_level_globals.log_level = 0;
 				break;
 			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 255;
+				log_level_globals.log_level = 255;
 				break;
 			} else if (strcmp(argv[i], "batman") == 0)
-				log_level |= BIT(0);
+				log_level_globals.log_level |= BIT(0);
 			else if (strcmp(argv[i], "routes") == 0)
-				log_level |= BIT(1);
+				log_level_globals.log_level |= BIT(1);
 			else if (strcmp(argv[i], "tt") == 0)
-				log_level |= BIT(2);
+				log_level_globals.log_level |= BIT(2);
 			else if (strcmp(argv[i], "bla") == 0)
-				log_level |= BIT(3);
+				log_level_globals.log_level |= BIT(3);
 			else if (strcmp(argv[i], "dat") == 0)
-				log_level |= BIT(4);
+				log_level_globals.log_level |= BIT(4);
 			else if (strcmp(argv[i], "nc") == 0)
-				log_level |= BIT(5);
+				log_level_globals.log_level |= BIT(5);
 			else if (strcmp(argv[i], "mcast") == 0)
-				log_level |= BIT(6);
+				log_level_globals.log_level |= BIT(6);
 			else if (strcmp(argv[i], "tp") == 0)
-				log_level |= BIT(7);
+				log_level_globals.log_level |= BIT(7);
 			else {
 				log_level_usage();
 				goto out;
 			}
 		}
 
-		snprintf(str, sizeof(str), "%i", log_level);
-		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
+		log_level_write_setting(state, path_buff);
 		goto out;
 	}
 
-	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
-
+	res = log_level_read_setting(state, path_buff);
 	if (res != EXIT_SUCCESS)
 		goto out;
 
-	log_level = strtol(line_ptr, (char **) NULL, 10);
-
-	printf("[%c] %s (%s)\n", (!log_level) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (!log_level_globals.log_level) ? 'x' : ' ',
 	       "all debug output disabled", "none");
-	printf("[%c] %s (%s)\n", (log_level & BIT(0)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(0)) ? 'x' : ' ',
 	       "messages related to routing / flooding / broadcasting",
 	       "batman");
-	printf("[%c] %s (%s)\n", (log_level & BIT(1)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(1)) ? 'x' : ' ',
 	       "messages related to route added / changed / deleted", "routes");
-	printf("[%c] %s (%s)\n", (log_level & BIT(2)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(2)) ? 'x' : ' ',
 	       "messages related to translation table operations", "tt");
-	printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(3)) ? 'x' : ' ',
 	       "messages related to bridge loop avoidance", "bla");
-	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(4)) ? 'x' : ' ',
 	       "messages related to arp snooping and distributed arp table", "dat");
-	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(5)) ? 'x' : ' ',
 	       "messages related to network coding", "nc");
-	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(6)) ? 'x' : ' ',
 	       "messages related to multicast", "mcast");
-	printf("[%c] %s (%s)\n", (log_level & BIT(7)) ? 'x' : ' ',
+	printf("[%c] %s (%s)\n", (log_level_globals.log_level & BIT(7)) ? 'x' : ' ',
 	       "messages related to throughput meter", "tp");
 
 out:
@@ -143,5 +224,6 @@ static int loglevel(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND(SUBCOMMAND, loglevel, "ll", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND, loglevel, "ll",
+	COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK, NULL,
 	"[level]           \tdisplay or modify the log level");
diff --git a/multicast_mode.c b/multicast_mode.c
index 8542928..ef0da28 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -21,13 +21,54 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data multicast_mode;
+
+static int print_multicast_mode(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_MULTICAST_MODE);
+}
+
+static int get_multicast_mode(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_multicast_mode);
+}
+
+static int set_attrs_multicast_mode(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_MULTICAST_MODE, data->val);
+
+	return 0;
+}
+
+static int set_multicast_mode(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_multicast_mode, NULL);
+}
+
 static struct settings_data batctl_settings_multicast_mode = {
 	.sysfs_name = SYS_MULTICAST_MODE,
-	.params = sysfs_param_enable,
+	.data = &multicast_mode,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_multicast_mode,
+	.netlink_set = set_multicast_mode,
 };
 
 COMMAND_NAMED(SUBCOMMAND, multicast_mode, "mm", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_multicast_mode,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_multicast_mode,
 	      "[0|1]             \tdisplay or modify multicast_mode setting");
diff --git a/netlink.c b/netlink.c
index b0d57b1..9c29774 100644
--- a/netlink.c
+++ b/netlink.c
@@ -853,3 +853,79 @@ int get_primarymac_netlink(const char *mesh_iface, uint8_t *primarymac)
 
 	return 0;
 }
+
+struct get_algoname_netlink_opts {
+	char *algoname;
+	size_t algoname_len;
+	bool found;
+	struct nlquery_opts query_opts;
+};
+
+static int get_algoname_netlink_cb(struct nl_msg *msg, void *arg)
+{
+	static const int mandatory[] = {
+		BATADV_ATTR_ALGO_NAME,
+	};
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct get_algoname_netlink_opts *opts;
+	struct genlmsghdr *ghdr;
+	const char *algoname;
+
+	opts = container_of(query_opts, struct get_algoname_netlink_opts,
+			    query_opts);
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_MESH)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (missing_mandatory_attrs(attrs, mandatory, ARRAY_SIZE(mandatory)))
+		return NL_OK;
+
+	algoname = nla_data(attrs[BATADV_ATTR_ALGO_NAME]);
+
+	/* save result */
+	strncpy(opts->algoname, algoname, opts->algoname_len);
+	if (opts->algoname_len > 0)
+		opts->algoname[opts->algoname_len - 1] = '\0';
+
+	opts->found = true;
+	opts->query_opts.err = 0;
+
+	return NL_STOP;
+}
+
+int get_algoname_netlink(const char *mesh_iface, char *algoname,
+			 size_t algoname_len)
+{
+	struct get_algoname_netlink_opts opts = {
+		.algoname = algoname,
+		.algoname_len = algoname_len,
+		.found = false,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+	int ret;
+
+	ret = netlink_query_common(mesh_iface, BATADV_CMD_GET_MESH,
+			           get_algoname_netlink_cb, 0,
+				   &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	if (!opts.found)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
diff --git a/netlink.h b/netlink.h
index b91ca10..9be49cd 100644
--- a/netlink.h
+++ b/netlink.h
@@ -50,6 +50,8 @@ int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 int get_nexthop_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			uint8_t *nexthop, char *ifname);
 int get_primarymac_netlink(const char *mesh_iface, uint8_t *primarymac);
+int get_algoname_netlink(const char *mesh_iface, char *algoname,
+			 size_t algoname_len);
 
 extern struct nla_policy batadv_netlink_policy[];
 
diff --git a/network_coding.c b/network_coding.c
index a4c4296..7fc8d36 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -21,13 +21,54 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data network_coding;
+
+static int print_network_coding(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_NETWORK_CODING);
+}
+
+static int get_network_coding(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_network_coding);
+}
+
+static int set_attrs_network_coding(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_NETWORK_CODING, data->val);
+
+	return 0;
+}
+
+static int set_network_coding(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_network_coding, NULL);
+}
+
 static struct settings_data batctl_settings_network_coding = {
 	.sysfs_name = SYS_NETWORK_CODING,
-	.params = sysfs_param_enable,
+	.data = &network_coding,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_network_coding,
+	.netlink_set = set_network_coding,
 };
 
 COMMAND_NAMED(SUBCOMMAND, network_coding, "nc", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_network_coding,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_network_coding,
 	      "[0|1]             \tdisplay or modify network_coding setting");
diff --git a/orig_interval.c b/orig_interval.c
index d308ea2..eb11d95 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -20,16 +20,96 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <stddef.h>
+#include <stdint.h>
+#include <string.h>
 
 #include "main.h"
 #include "sys.h"
 
+static struct orig_interval_data {
+	uint32_t orig_interval;
+} orig_interval;
+
+static int parse_orig_interval(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct orig_interval_data *data = settings->data;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	data->orig_interval = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_orig_interval(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_ORIG_INTERVAL])
+		return NL_OK;
+
+	printf("%u\n", nla_get_u32(attrs[BATADV_ATTR_ORIG_INTERVAL]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_orig_interval(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_orig_interval);
+}
+
+static int set_attrs_orig_interval(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct orig_interval_data *data = settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL, data->orig_interval);
+
+	return 0;
+}
+
+static int set_orig_interval(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_orig_interval, NULL);
+}
+
 static struct settings_data batctl_settings_orig_interval = {
 	.sysfs_name = "orig_interval",
-	.params = NULL,
+	.data = &orig_interval,
+	.parse = parse_orig_interval,
+	.netlink_get = get_orig_interval,
+	.netlink_set = set_orig_interval,
 };
 
 COMMAND_NAMED(SUBCOMMAND, orig_interval, "it", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_orig_interval,
+	      COMMAND_FLAG_MESH_IFACE| COMMAND_FLAG_NETLINK,
+	      &batctl_settings_orig_interval,
 	      "[interval]        \tdisplay or modify orig_interval setting");
diff --git a/routing_algo.c b/routing_algo.c
index 18d9ef7..69eac34 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -41,7 +41,6 @@
 #include "sys.h"
 
 #define SYS_SELECTED_RA_PATH	"/sys/module/batman_adv/parameters/routing_algo"
-#define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
 
 static void ra_mode_usage(void)
 {
diff --git a/sys.c b/sys.c
index be20be7..dc88268 100644
--- a/sys.c
+++ b/sys.c
@@ -39,20 +39,120 @@
 #include "functions.h"
 #include "debug.h"
 
-const char *sysfs_param_enable[] = {
-	"enable",
-	"disable",
-	"1",
-	"0",
-	NULL,
-};
-
-const char *sysfs_param_server[] = {
-	"off",
-	"client",
-	"server",
-	NULL,
-};
+int parse_simple_boolean(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+	int ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	ret = parse_bool(argv[1], &data->val);
+	if (ret < 0) {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		fprintf(stderr, "The following values are allowed:\n");
+		fprintf(stderr, " * 0\n");
+		fprintf(stderr, " * disable\n");
+		fprintf(stderr, " * disabled\n");
+		fprintf(stderr, " * 1\n");
+		fprintf(stderr, " * enable\n");
+		fprintf(stderr, " * enabled\n");
+
+		return ret;
+	}
+
+	return 0;
+}
+
+
+static int sys_simple_nlerror(struct sockaddr_nl *nla __maybe_unused,
+			      struct nlmsgerr *nlerr,	void *arg)
+{
+	int *result = arg;
+
+	if (nlerr->error != -EOPNOTSUPP)
+		fprintf(stderr, "Error received: %s\n",
+			strerror(-nlerr->error));
+
+	*result = nlerr->error;
+
+	return NL_STOP;
+}
+
+int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
+		       nl_recvmsg_msg_cb_t attribute_cb,
+		       nl_recvmsg_msg_cb_t callback)
+{
+	int result;
+	struct nl_msg *msg;
+	int ret;
+
+	if (!state->sock)
+		return -EOPNOTSUPP;
+
+	if (callback) {
+		result = -EOPNOTSUPP;
+		nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, callback,
+			  &result);
+	} else {
+		result = 0;
+	}
+
+	nl_cb_err(state->cb, NL_CB_CUSTOM, sys_simple_nlerror, &result);
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return -ENOMEM;
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0, 0,
+		    nl_cmd, 1);
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
+
+	if (attribute_cb) {
+		ret = attribute_cb(msg, state);
+		if (ret < 0) {
+			nlmsg_free(msg);
+			return -ENOMEM;
+		}
+	}
+
+	nl_send_auto_complete(state->sock, msg);
+	nlmsg_free(msg);
+
+	nl_recvmsgs(state->sock, state->cb);
+
+	return result;
+}
+
+int sys_simple_print_boolean(struct nl_msg *msg, void *arg,
+			     enum batadv_nl_attrs attr)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[attr])
+		return NL_OK;
+
+	printf("%s\n", nla_get_u8(attrs[attr]) ? "enabled" : "disabled");
+
+	*result = 0;
+	return NL_STOP;
+}
 
 static void settings_usage(struct state *state)
 {
@@ -63,12 +163,52 @@ static void settings_usage(struct state *state)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
+static int sys_read_setting(struct state *state, const char *path_buff,
+			    const char *sysfs_name)
+{
+	struct settings_data *settings = state->cmd->arg;
+	int res = EXIT_FAILURE;
+
+	if (settings->netlink_get) {
+		res = settings->netlink_get(state);
+		if (res < 0 && res != -EOPNOTSUPP)
+			return EXIT_FAILURE;
+		if (res >= 0)
+			return EXIT_SUCCESS;
+	}
+
+	if (sysfs_name)
+		res = read_file(path_buff, sysfs_name, NO_FLAGS, 0, 0, 0);
+
+	return res;
+}
+
+static int sys_write_setting(struct state *state, const char *path_buff,
+			    const char *sysfs_name, int argc, char **argv)
+{
+	struct settings_data *settings = state->cmd->arg;
+	int res = EXIT_FAILURE;
+
+	if (settings->netlink_set) {
+		res = settings->netlink_set(state);
+		if (res < 0 && res != -EOPNOTSUPP)
+			return EXIT_FAILURE;
+		if (res >= 0)
+			return EXIT_SUCCESS;
+	}
+
+	if (sysfs_name)
+		res = write_file(path_buff, sysfs_name,
+				 argv[1], argc > 2 ? argv[2] : NULL);
+
+	return res;
+}
+
 int handle_sys_setting(struct state *state, int argc, char **argv)
 {
 	struct settings_data *settings = state->cmd->arg;
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff;
-	const char **ptr;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -99,38 +239,22 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 			 state->mesh_iface);
 
 	if (argc == 1) {
-		res = read_file(path_buff, settings->sysfs_name,
-				NO_FLAGS, 0, 0, 0);
+		res = sys_read_setting(state, path_buff, settings->sysfs_name);
 		goto out;
 	}
 
 	check_root_or_die("batctl");
 
-	if (!settings->params)
-		goto write_file;
-
-	ptr = settings->params;
-	while (*ptr) {
-		if (strcmp(*ptr, argv[1]) == 0)
-			goto write_file;
-
-		ptr++;
-	}
-
-	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
-	fprintf(stderr, "The following values are allowed:\n");
-
-	ptr = settings->params;
-	while (*ptr) {
-		fprintf(stderr, " * %s\n", *ptr);
-		ptr++;
+	if (settings->parse) {
+		res = settings->parse(state, argc, argv);
+		if (res < 0) {
+			res = EXIT_FAILURE;
+			goto out;
+		}
 	}
 
-	goto out;
-
-write_file:
-	res = write_file(path_buff, settings->sysfs_name,
-			 argv[1], argc > 2 ? argv[2] : NULL);
+	res = sys_write_setting(state, path_buff, settings->sysfs_name, argc,
+				argv);
 
 out:
 	free(path_buff);
diff --git a/sys.h b/sys.h
index 20e1934..2eaa8be 100644
--- a/sys.h
+++ b/sys.h
@@ -25,6 +25,13 @@
 
 #include "main.h"
 
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+#include <stdbool.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
+
 #define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL		"log_level"
 #define SYS_LOG			"log"
@@ -37,16 +44,29 @@
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT	SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
+#define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
 #define VLAN_ID_MAX_LEN		4
 
 struct settings_data {
 	const char *sysfs_name;
-	const char **params;
+	void *data;
+	int (*parse)(struct state *state, int argc, char *argv[]);
+	int (*netlink_get)(struct state *state);
+	int (*netlink_set)(struct state *state);
 };
 
-extern const char *sysfs_param_enable[];
-extern const char *sysfs_param_server[];
+struct simple_boolean_data {
+	bool val;
+};
 
 int handle_sys_setting(struct state *state, int argc, char **argv);
+int parse_simple_boolean(struct state *state, int argc, char *argv[]);
+
+
+int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
+		       nl_recvmsg_msg_cb_t attribute_cb,
+		       nl_recvmsg_msg_cb_t callback);
+int sys_simple_print_boolean(struct nl_msg *msg, void *arg,
+			     enum batadv_nl_attrs attr);
 
 #endif
-- 
2.19.1

