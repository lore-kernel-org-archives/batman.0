Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:31:54 +0100
Message-Id: <20181207203209.22633-6-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 05/20] batctl: Parse the arguments for
 gw_mode
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
Cc: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

The generic netlink interface requires that the configuration settings are
parsed in userspace. But it can also be used to do a more fine grained
validation of the input data before it is written to the sysfs files.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Antonio Quartulli <a@unstable.cc>
---
 functions.c    |  92 ++++++++++++++++++++++++++
 functions.h    |  16 +++++
 gw_mode.c      | 171 +++++++++++++++++++++++++++++++++++++++----------
 netlink.c      |  76 ++++++++++++++++++++++
 netlink.h      |   2 +
 routing_algo.c |   1 -
 sys.c          |   7 --
 sys.h          |   2 +-
 8 files changed, 324 insertions(+), 43 deletions(-)

diff --git a/functions.c b/functions.c
index 600c29a..ead7e97 100644
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
@@ -1162,3 +1200,57 @@ void check_root_or_die(const char *cmd)
 		exit(EXIT_FAILURE);
 	}
 }
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
index ea3c307..4a6ab61 100644
--- a/functions.h
+++ b/functions.h
@@ -26,8 +26,20 @@
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
 
 #define ETH_STR_LEN 17
 #define BATMAN_ADV_TAG "batman-adv:"
@@ -53,12 +65,16 @@ struct ether_addr *resolve_mac(const char *asc);
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
 int netlink_simple_request(struct nl_msg *msg);
 int translate_mesh_iface(struct state *state);
+int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len);
 int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 void get_random_bytes(void *buf, size_t buflen);
 void check_root_or_die(const char *cmd);
 
+bool parse_throughput(char *buff, const char *description,
+		      uint32_t *throughput);
+
 extern char *line_ptr;
 
 enum {
diff --git a/gw_mode.c b/gw_mode.c
index 4093f89..167b777 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -20,23 +20,33 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <getopt.h>
+#include <stdbool.h>
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
@@ -45,11 +55,117 @@ static void gw_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
+static bool is_throughput_select_class(struct state *state)
+{
+	char algoname[32];
+	int ret;
+
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
+	}
+
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
+	}
+
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
+
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
 static int gw_mode(struct state *state, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff, gw_mode;
-	const char **ptr;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -80,20 +196,20 @@ static int gw_mode(struct state *state, int argc, char **argv)
 			line_ptr[strlen(line_ptr) - 1] = '\0';
 
 		if (strcmp(line_ptr, "client") == 0)
-			gw_mode = GW_MODE_CLIENT;
+			gw_mode = BATADV_GW_MODE_CLIENT;
 		else if (strcmp(line_ptr, "server") == 0)
-			gw_mode = GW_MODE_SERVER;
+			gw_mode = BATADV_GW_MODE_SERVER;
 		else
-			gw_mode = GW_MODE_OFF;
+			gw_mode = BATADV_GW_MODE_OFF;
 
 		free(line_ptr);
 		line_ptr = NULL;
 
 		switch (gw_mode) {
-		case GW_MODE_CLIENT:
+		case BATADV_GW_MODE_CLIENT:
 			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
 			break;
-		case GW_MODE_SERVER:
+		case BATADV_GW_MODE_SERVER:
 			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
 			break;
 		default:
@@ -108,10 +224,10 @@ static int gw_mode(struct state *state, int argc, char **argv)
 			line_ptr[strlen(line_ptr) - 1] = '\0';
 
 		switch (gw_mode) {
-		case GW_MODE_CLIENT:
+		case BATADV_GW_MODE_CLIENT:
 			printf("client (selection class: %s)\n", line_ptr);
 			break;
-		case GW_MODE_SERVER:
+		case BATADV_GW_MODE_SERVER:
 			printf("server (announced bw: %s)\n", line_ptr);
 			break;
 		default:
@@ -125,14 +241,11 @@ static int gw_mode(struct state *state, int argc, char **argv)
 
 	check_root_or_die("batctl gw_mode");
 
-	if (strcmp(argv[1], "client") == 0)
-		gw_mode = GW_MODE_CLIENT;
-	else if (strcmp(argv[1], "server") == 0)
-		gw_mode = GW_MODE_SERVER;
-	else if (strcmp(argv[1], "off") == 0)
-		gw_mode = GW_MODE_OFF;
-	else
-		goto opt_err;
+	res = parse_gw(state, argc, argv);
+	if (res < 0) {
+		res = EXIT_FAILURE;
+		goto out;
+	}
 
 	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
 	if (res != EXIT_SUCCESS)
@@ -141,27 +254,17 @@ static int gw_mode(struct state *state, int argc, char **argv)
 	if (argc == 2)
 		goto out;
 
-	switch (gw_mode) {
-	case GW_MODE_CLIENT:
+	switch (gw_globals.mode) {
+	case BATADV_GW_MODE_CLIENT:
 		res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
 		break;
-	case GW_MODE_SERVER:
+	case BATADV_GW_MODE_SERVER:
 		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
 		break;
 	}
 
 	goto out;
 
-opt_err:
-	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
-	fprintf(stderr, "The following values are allowed:\n");
-
-	ptr = sysfs_param_server;
-	while (*ptr) {
-		fprintf(stderr, " * %s\n", *ptr);
-		ptr++;
-	}
-
 out:
 	free(path_buff);
 	return res;
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
index e883369..482daed 100644
--- a/sys.c
+++ b/sys.c
@@ -47,13 +47,6 @@ const char *sysfs_param_enable[] = {
 	NULL,
 };
 
-const char *sysfs_param_server[] = {
-	"off",
-	"client",
-	"server",
-	NULL,
-};
-
 static void settings_usage(struct state *state)
 {
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters] %s\n",
diff --git a/sys.h b/sys.h
index cac2c53..1c8f23d 100644
--- a/sys.h
+++ b/sys.h
@@ -37,6 +37,7 @@
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT	SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
+#define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
 #define VLAN_ID_MAX_LEN		4
 
 struct settings_data {
@@ -49,7 +50,6 @@ struct settings_data {
 };
 
 extern const char *sysfs_param_enable[];
-extern const char *sysfs_param_server[];
 
 int handle_sys_setting(struct state *state, int argc, char **argv);
 
-- 
2.19.2

