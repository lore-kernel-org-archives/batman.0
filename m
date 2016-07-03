Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 13:35:07 +0200
Message-Id: <1467545714-20722-2-git-send-email-sven@narfation.org>
In-Reply-To: <1467545714-20722-1-git-send-email-sven@narfation.org>
References: <1467545714-20722-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v10 1/8] batctl: Use netlink to replace some
	of debugfs
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

From: Andrew Lunn <andrew@lunn.ch>

The kernel has gained support for exporting some information via
netlink.  Use this when available, rather than debugfs.

If netlink is not available, or the information is not yet available
via netlink, batctl will fall back to debugfs.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[sven@narfation.org: Add missing local TTVN in transtable_global, add
missing local group id to claim table, fix use-after-free of algo_name, fix
alignment of the originator entries]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
[sw@simonwunderlich.de: fix claimtable output format, fix name of mandatory
claim table attributes, fix printing of VIDs]
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 batman_adv.h |   92 +++++
 debug.c      |   22 +-
 debug.h      |    4 +-
 functions.c  |   11 +
 functions.h  |    2 +
 netlink.c    | 1064 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 netlink.h    |   18 +-
 packet.h     |   36 --
 8 files changed, 1208 insertions(+), 41 deletions(-)

diff --git a/batman_adv.h b/batman_adv.h
index acb72f8..778e238 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -23,6 +23,42 @@
 #define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
 
 /**
+ * enum batadv_tt_client_flags - TT client specific flags
+ * @BATADV_TT_CLIENT_DEL: the client has to be deleted from the table
+ * @BATADV_TT_CLIENT_ROAM: the client roamed to/from another node and the new
+ *  update telling its new real location has not been received/sent yet
+ * @BATADV_TT_CLIENT_WIFI: this client is connected through a wifi interface.
+ *  This information is used by the "AP Isolation" feature
+ * @BATADV_TT_CLIENT_ISOLA: this client is considered "isolated". This
+ *  information is used by the Extended Isolation feature
+ * @BATADV_TT_CLIENT_NOPURGE: this client should never be removed from the table
+ * @BATADV_TT_CLIENT_NEW: this client has been added to the local table but has
+ *  not been announced yet
+ * @BATADV_TT_CLIENT_PENDING: this client is marked for removal but it is kept
+ *  in the table for one more originator interval for consistency purposes
+ * @BATADV_TT_CLIENT_TEMP: this global client has been detected to be part of
+ *  the network but no nnode has already announced it
+ *
+ * Bits from 0 to 7 are called _remote flags_ because they are sent on the wire.
+ * Bits from 8 to 15 are called _local flags_ because they are used for local
+ * computations only.
+ *
+ * Bits from 4 to 7 - a subset of remote flags - are ensured to be in sync with
+ * the other nodes in the network. To achieve this goal these flags are included
+ * in the TT CRC computation.
+ */
+enum batadv_tt_client_flags {
+	BATADV_TT_CLIENT_DEL     = (1 << 0),
+	BATADV_TT_CLIENT_ROAM    = (1 << 1),
+	BATADV_TT_CLIENT_WIFI    = (1 << 4),
+	BATADV_TT_CLIENT_ISOLA	 = (1 << 5),
+	BATADV_TT_CLIENT_NOPURGE = (1 << 8),
+	BATADV_TT_CLIENT_NEW     = (1 << 9),
+	BATADV_TT_CLIENT_PENDING = (1 << 10),
+	BATADV_TT_CLIENT_TEMP	 = (1 << 11),
+};
+
+/**
  * enum batadv_nl_attrs - batman-adv netlink attributes
  *
  * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
@@ -40,6 +76,26 @@
  * @BATADV_ATTR_TPMETER_BYTES: amount of acked bytes during run
  * @BATADV_ATTR_TPMETER_COOKIE: session cookie to match tp_meter session
  * @BATADV_ATTR_PAD: attribute used for padding for 64-bit alignment
+ * @BATADV_ATTR_ACTIVE: Flag indicating if the hard interface is active
+ * @BATADV_ATTR_TT_ADDRESS: Client MAC address
+ * @BATADV_ATTR_TT_TTVN: Translation table version
+ * @BATADV_ATTR_TT_LAST_TTVN: Previous translation table version
+ * @BATADV_ATTR_TT_CRC32: CRC32 over translation table
+ * @BATADV_ATTR_TT_VID: VLAN ID
+ * @BATADV_ATTR_TT_FLAGS: Translation table client flags
+ * @BATADV_ATTR_FLAG_BEST: Flags indicating entry is the best
+ * @BATADV_ATTR_LAST_SEEN_MSECS: Time in milliseconds since last seen
+ * @BATADV_ATTR_NEIGH_ADDRESS: Neighbour MAC address
+ * @BATADV_ATTR_TQ: TQ to neighbour
+ * @BATADV_ATTR_THROUGHPUT: Estimated throughput to Neighbour
+ * @BATADV_ATTR_BANDWIDTH_UP: Reported uplink bandwidth
+ * @BATADV_ATTR_BANDWIDTH_DOWN: Reported downlink bandwidth
+ * @BATADV_ATTR_ROUTER: Gateway router MAC address
+ * @BATADV_ATTR_BLA_OWN: Flag indicating own originator
+ * @BATADV_ATTR_BLA_ADDRESS: Bridge loop avoidance claim MAC address
+ * @BATADV_ATTR_BLA_VID: BLA VLAN ID
+ * @BATADV_ATTR_BLA_BACKBONE: BLA gateway originator MAC address
+ * @BATADV_ATTR_BLA_CRC: BLA CRC
  * @__BATADV_ATTR_AFTER_LAST: internal use
  * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
  * @BATADV_ATTR_MAX: highest attribute number currently defined
@@ -60,6 +116,26 @@ enum batadv_nl_attrs {
 	BATADV_ATTR_TPMETER_BYTES,
 	BATADV_ATTR_TPMETER_COOKIE,
 	BATADV_ATTR_PAD,
+	BATADV_ATTR_ACTIVE,
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_TT_TTVN,
+	BATADV_ATTR_TT_LAST_TTVN,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_FLAGS,
+	BATADV_ATTR_FLAG_BEST,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_TQ,
+	BATADV_ATTR_THROUGHPUT,
+	BATADV_ATTR_BANDWIDTH_UP,
+	BATADV_ATTR_BANDWIDTH_DOWN,
+	BATADV_ATTR_ROUTER,
+	BATADV_ATTR_BLA_OWN,
+	BATADV_ATTR_BLA_ADDRESS,
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
 	/* add attributes above here, update the policy in netlink.c */
 	__BATADV_ATTR_AFTER_LAST,
 	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
@@ -73,6 +149,14 @@ enum batadv_nl_attrs {
  * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
  * @BATADV_CMD_TP_METER: Start a tp meter session
  * @BATADV_CMD_TP_METER_CANCEL: Cancel a tp meter session
+ * @BATADV_CMD_GET_ROUTING_ALGOS: Query the list of routing algorithms.
+ * @BATADV_CMD_GET_HARDIFS: Query list of hard interfaces
+ * @BATADV_CMD_GET_TRANSTABLE_LOCAL: Query list of local translations
+ * @BATADV_CMD_GET_TRANSTABLE_GLOBAL Query list of global translations
+ * @BATADV_CMD_GET_ORIGINATORS: Query list of originators
+ * @BATADV_CMD_GET_NEIGHBORS: Query list of neighbours
+ * @BATADV_CMD_GET_GATEWAYS: Query list of gateways
+ * @BATADV_CMD_GET_BLA_CLAIM: Query list of bridge loop avoidance claims
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
@@ -81,6 +165,14 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_MESH_INFO,
 	BATADV_CMD_TP_METER,
 	BATADV_CMD_TP_METER_CANCEL,
+	BATADV_CMD_GET_ROUTING_ALGOS,
+	BATADV_CMD_GET_HARDIFS,
+	BATADV_CMD_GET_TRANSTABLE_LOCAL,
+	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+	BATADV_CMD_GET_ORIGINATORS,
+	BATADV_CMD_GET_NEIGHBORS,
+	BATADV_CMD_GET_GATEWAYS,
+	BATADV_CMD_GET_BLA_CLAIM,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
diff --git a/debug.c b/debug.c
index 5b280cb..46f03da 100644
--- a/debug.c
+++ b/debug.c
@@ -23,10 +23,12 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <errno.h>
 
 #include "debug.h"
 #include "debugfs.h"
 #include "functions.h"
+#include "netlink.h"
 #include "sys.h"
 
 const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
@@ -35,36 +37,42 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_short = "n",
 		.debugfs_name = "neighbors",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_neighbors,
 	},
 	{
 		.opt_long = "originators",
 		.opt_short = "o",
 		.debugfs_name = "originators",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_originators,
 	},
 	{
 		.opt_long = "gateways",
 		.opt_short = "gwl",
 		.debugfs_name = "gateways",
 		.header_lines = 1,
+		.netlink_fn = netlink_print_gateways,
 	},
 	{
 		.opt_long = "translocal",
 		.opt_short = "tl",
 		.debugfs_name = "transtable_local",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_translocal,
 	},
 	{
 		.opt_long = "transglobal",
 		.opt_short = "tg",
 		.debugfs_name = "transtable_global",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_transglobal,
 	},
 	{
 		.opt_long = "claimtable",
 		.opt_short = "cl",
 		.debugfs_name = "bla_claim_table",
 		.header_lines = 2,
+		.netlink_fn = netlink_print_bla_claim,
 	},
 	{
 		.opt_long = "backbonetable",
@@ -121,7 +129,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	char *orig_iface = NULL;
 	float orig_timeout = 0.0f;
 	float watch_interval = 1;
-	opterr = 0;
+	int err;
 
 	while ((optchar = getopt(argc, argv, "hnw:t:Humi:")) != -1) {
 		switch (optchar) {
@@ -222,16 +230,26 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	if (batctl_debug_tables[debug_table].netlink_fn) {
+		err = batctl_debug_tables[debug_table].netlink_fn(
+			mesh_iface, orig_iface, read_opt, orig_timeout,
+			watch_interval);
+		if (err != -EOPNOTSUPP)
+			return err;
+	}
+
 	if (orig_iface)
 		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface, full_path, sizeof(full_path));
 	else
 		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
+
 	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
 			 read_opt, orig_timeout, watch_interval,
 			 batctl_debug_tables[debug_table].header_lines);
 }
 
-int print_routing_algos(void) {
+int debug_print_routing_algos(void)
+{
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
 
diff --git a/debug.h b/debug.h
index 46e8c3c..1c9374a 100644
--- a/debug.h
+++ b/debug.h
@@ -49,13 +49,15 @@ struct debug_table_data {
        const char opt_short[OPT_SHORT_MAX_LEN];
        const char debugfs_name[DEBUG_TABLE_PATH_MAX_LEN];
        size_t header_lines;
+       int (*netlink_fn)(char *mesh_iface, char *hard_iface, int read_opt,
+			 float orig_timeout, float watch_interval);
 };
 
 extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
 int log_print(char *mesh_iface, int argc, char **argv);
-int print_routing_algos(void);
+int debug_print_routing_algos(void);
 int print_vis_info(char *mesh_iface);
 
 #endif
diff --git a/functions.c b/functions.c
index 97a6dbd..5b76062 100644
--- a/functions.c
+++ b/functions.c
@@ -52,6 +52,7 @@
 #include "sys.h"
 #include "debug.h"
 #include "debugfs.h"
+#include "netlink.h"
 
 static struct timeval start_time;
 static char *host_name;
@@ -850,3 +851,13 @@ err:
 
 	return arg.vid;
 }
+
+int print_routing_algos(void)
+{
+	int err;
+
+	err = netlink_print_routing_algos();
+	if (err == -EOPNOTSUPP)
+		err = debug_print_routing_algos();
+	return err;
+}
diff --git a/functions.h b/functions.h
index d0b05b9..2d29d52 100644
--- a/functions.h
+++ b/functions.h
@@ -44,6 +44,7 @@ struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
 int vlan_get_link(const char *ifname, char **parent);
 
+int print_routing_algos(void);
 extern char *line_ptr;
 
 enum {
@@ -59,6 +60,7 @@ enum {
 	SKIP_HEADER = 0x100,
 	UNICAST_ONLY = 0x200,
 	MULTICAST_ONLY = 0x400,
+	PARSE_ONLY = 0x800,
 };
 
 #endif
diff --git a/netlink.c b/netlink.c
index 365cda1..c07ed55 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
@@ -22,9 +22,33 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
 #include <net/ethernet.h>
+#include <net/if.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 
+#include "bat-hosts.h"
 #include "batman_adv.h"
+#include "netlink.h"
+#include "functions.h"
+#include "main.h"
+#include "packet.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+struct print_opts {
+	int read_opt;
+	float orig_timeout;
+	float watch_interval;
+	uint8_t nl_cmd;
+};
 
 struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
@@ -49,4 +73,1042 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_TPMETER_BYTES]	= { .type = NLA_U64 },
 	[BATADV_ATTR_TPMETER_COOKIE]	= { .type = NLA_U32 },
 	[BATADV_ATTR_PAD]		= { .type = NLA_UNSPEC },
+	[BATADV_ATTR_ACTIVE]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_TT_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_TT_TTVN]		= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_LAST_TTVN]	= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_CRC32]		= { .type = NLA_U32 },
+	[BATADV_ATTR_TT_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_TT_FLAGS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_FLAG_BEST]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_LAST_SEEN_MSECS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_TQ]		= { .type = NLA_U8 },
+	[BATADV_ATTR_THROUGHPUT]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_UP]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_DOWN]	= { .type = NLA_U32 },
+	[BATADV_ATTR_ROUTER]		= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_BLA_OWN]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_BLA_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_BLA_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_BLA_BACKBONE]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_BLA_CRC]		= { .type = NLA_U16 },
+};
+
+static int last_err;
+static char algo_name_buf[256] = "";
+
+static int missing_mandatory_attrs(struct nlattr *attrs[],
+				   const int mandatory[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		if (!attrs[mandatory[i]])
+			return -EINVAL;
+
+	return 0;
+}
+
+static int print_error(struct sockaddr_nl *nla __unused,
+		       struct nlmsgerr *nlerr,
+		       void *arg __unused)
+{
+	if (nlerr->error != -EOPNOTSUPP)
+		fprintf(stderr, "Error received: %s\n",
+			strerror(-nlerr->error));
+
+	last_err = -nlerr->error;
+
+	return NL_STOP;
+}
+
+static int stop_callback(struct nl_msg *msg, void *arg __unused)
+{
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int *error = nlmsg_data(nlh);
+
+	if (*error)
+		fprintf(stderr, "Error received: %s\n", strerror(-*error));
+
+	return NL_STOP;
+}
+
+static const int info_mandatory[] = {
+	BATADV_ATTR_MESH_IFINDEX,
+	BATADV_ATTR_MESH_IFNAME,
+};
+
+static const int info_hard_mandatory[] = {
+	BATADV_ATTR_VERSION,
+	BATADV_ATTR_ALGO_NAME,
+	BATADV_ATTR_HARD_IFNAME,
+	BATADV_ATTR_HARD_ADDRESS,
+};
+
+static int info_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	const uint8_t *primary_mac;
+	struct genlmsghdr *ghdr;
+	const uint8_t *mesh_mac;
+	const char *primary_if;
+	const char *mesh_name;
+	const char *version;
+	char *extra_info = NULL;
+	uint8_t ttvn = 0;
+	uint16_t bla_group_id = 0;
+	const char *algo_name;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_MESH_INFO)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, info_mandatory,
+				    ARRAY_SIZE(info_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	mesh_name = nla_get_string(attrs[BATADV_ATTR_MESH_IFNAME]);
+	mesh_mac = nla_data(attrs[BATADV_ATTR_MESH_ADDRESS]);
+
+	if (attrs[BATADV_ATTR_HARD_IFNAME]) {
+		if (missing_mandatory_attrs(attrs, info_hard_mandatory,
+					    ARRAY_SIZE(info_hard_mandatory))) {
+			fputs("Missing attributes from kernel\n",
+			      stderr);
+			exit(1);
+		}
+
+		version = nla_get_string(attrs[BATADV_ATTR_VERSION]);
+		algo_name = nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);
+		primary_if = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
+		primary_mac = nla_data(attrs[BATADV_ATTR_HARD_ADDRESS]);
+
+		snprintf(algo_name_buf, sizeof(algo_name_buf), algo_name);
+
+		if (attrs[BATADV_ATTR_TT_TTVN])
+			ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
+
+		if (attrs[BATADV_ATTR_BLA_CRC])
+			bla_group_id = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
+
+		if (!(opts->read_opt & PARSE_ONLY)) {
+			switch (opts->nl_cmd) {
+			case BATADV_CMD_GET_TRANSTABLE_LOCAL:
+				asprintf(&extra_info, ", TTVN: %u", ttvn);
+				break;
+			case BATADV_CMD_GET_BLA_CLAIM:
+				asprintf(&extra_info, ", group id: 0x%04x",
+					 bla_group_id);
+				break;
+			default:
+				extra_info = strdup("");
+				break;
+			}
+
+			printf("[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n",
+			       version, primary_if,
+			       primary_mac[0], primary_mac[1], primary_mac[2],
+			       primary_mac[3], primary_mac[4], primary_mac[5],
+			       mesh_name,
+			       mesh_mac[0], mesh_mac[1], mesh_mac[2],
+			       mesh_mac[3], mesh_mac[4], mesh_mac[5],
+			       algo_name, extra_info);
+
+			if (extra_info)
+				free(extra_info);
+		}
+	} else {
+		if (!(opts->read_opt & PARSE_ONLY))
+			printf("BATMAN mesh %s disabled\n", mesh_name);
+	}
+
+	return NL_STOP;
+}
+
+static void netlink_print_info(int ifindex, uint8_t nl_cmd, int read_opt)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int family;
+	struct print_opts opts = {
+		.read_opt = read_opt,
+		.nl_cmd = nl_cmd,
+	};
+
+	sock = nl_socket_alloc();
+	genl_connect(sock);
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0)
+		return;
+
+	msg = nlmsg_alloc();
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, 0,
+		    BATADV_CMD_GET_MESH_INFO, 1);
+
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+
+	nl_send_auto_complete(sock, msg);
+
+	nlmsg_free(msg);
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, info_callback, &opts);
+	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
+
+	nl_recvmsgs(sock, cb);
+
+	nl_socket_free(sock);
+}
+
+static const int routing_algos_mandatory[] = {
+	BATADV_ATTR_ALGO_NAME,
+};
+
+static int routing_algos_callback(struct nl_msg *msg, void *arg __unused)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	const char *algo_name;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_ROUTING_ALGOS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, routing_algos_mandatory,
+				    ARRAY_SIZE(routing_algos_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	algo_name = nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);
+
+	printf(" * %s\n", algo_name);
+
+	return NL_OK;
+}
+
+int netlink_print_routing_algos(void)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int family;
+
+	sock = nl_socket_alloc();
+	genl_connect(sock);
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0)
+		return -EOPNOTSUPP;
+
+	msg = nlmsg_alloc();
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP,
+		    BATADV_CMD_GET_ROUTING_ALGOS, 1);
+
+	nl_send_auto_complete(sock, msg);
+
+	nlmsg_free(msg);
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, routing_algos_callback,
+		  NULL);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
+	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
+
+	printf("Available routing algorithms:\n");
+
+	nl_recvmsgs(sock, cb);
+
+	nl_socket_free(sock);
+
+	return 0;
+}
+
+static const int originators_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int originators_callback(struct nl_msg *msg, void *arg)
+{
+	unsigned throughput_mbits, throughput_kbits;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs, last_seen_secs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char ifname[IF_NAMESIZE];
+	float last_seen;
+	uint8_t *neigh;
+	uint8_t *orig;
+	char c = ' ';
+	uint8_t tq;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_ORIGINATORS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, originators_mandatory,
+				       ARRAY_SIZE(originators_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
+
+	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
+			    ifname))
+		ifname[0] = '\0';
+
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = '*';
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen = (float)last_seen_msecs / 1000.0;
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
+
+	/* skip timed out originators */
+	if (opts->read_opt & NO_OLD_ORIGS)
+		if (last_seen > opts->orig_timeout)
+			return NL_OK;
+
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		throughput_mbits = throughput_kbits / 1000;
+		throughput_kbits = throughput_kbits % 1000;
+
+		if (!(opts->read_opt & USE_BAT_HOSTS)) {
+			printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is (%9u.%1u) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",
+			       c,
+			       orig[0], orig[1], orig[2],
+			       orig[3], orig[4], orig[5],
+			       last_seen_secs, last_seen_msecs,
+			       throughput_mbits, throughput_kbits / 100,
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5],
+			       ifname);
+		} else {
+			bat_host = bat_hosts_find_by_mac((char *)orig);
+			if (bat_host)
+				printf(" %c %17s ", c, bat_host->name);
+			else
+				printf(" %c %02x:%02x:%02x:%02x:%02x:%02x ",
+				       c,
+				       orig[0], orig[1], orig[2],
+				       orig[3], orig[4], orig[5]);
+			printf("%4i.%03is (%9u.%1u) ",
+			       last_seen_secs, last_seen_msecs,
+			       throughput_mbits, throughput_kbits / 100);
+			bat_host = bat_hosts_find_by_mac((char *)neigh);
+			if (bat_host)
+				printf(" %c %17s ", c, bat_host->name);
+			else
+				printf(" %02x:%02x:%02x:%02x:%02x:%02x ",
+				       neigh[0], neigh[1], neigh[2],
+				       neigh[3], neigh[4], neigh[5]);
+			printf("[%10s]\n", ifname);
+		}
+	}
+	if (attrs[BATADV_ATTR_TQ]) {
+		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+
+		if (!(opts->read_opt & USE_BAT_HOSTS)) {
+			printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is   (%3i) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",
+			       c,
+			       orig[0], orig[1], orig[2],
+			       orig[3], orig[4], orig[5],
+			       last_seen_secs, last_seen_msecs, tq,
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5],
+			       ifname);
+		} else {
+			bat_host = bat_hosts_find_by_mac((char *)orig);
+			if (bat_host)
+				printf(" %c %17s ", c, bat_host->name);
+			else
+				printf(" %c %02x:%02x:%02x:%02x:%02x:%02x ",
+				       c,
+				       orig[0], orig[1], orig[2],
+				       orig[3], orig[4], orig[5]);
+			printf("%4i.%03is   (%3i) ",
+			       last_seen_secs, last_seen_msecs, tq);
+			bat_host = bat_hosts_find_by_mac((char *)neigh);
+			if (bat_host)
+				printf("%17s ", bat_host->name);
+			else
+				printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+				       neigh[0], neigh[1], neigh[2],
+				       neigh[3], neigh[4], neigh[5]);
+			printf("[%10s]\n", ifname);
+		}
+	}
+
+	return NL_OK;
+}
+
+static const int neighbors_mandatory[] = {
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_LAST_SEEN_MSECS,
 };
+
+static int neighbors_callback(struct nl_msg *msg, void *arg)
+{
+	unsigned throughput_mbits, throughput_kbits;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs, last_seen_secs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	char ifname[IF_NAMESIZE];
+	struct genlmsghdr *ghdr;
+	uint8_t *neigh;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_NEIGHBORS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, neighbors_mandatory,
+				    ARRAY_SIZE(neighbors_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
+	bat_host = bat_hosts_find_by_mac((char *)neigh);
+
+	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
+			    ifname))
+		ifname[0] = '\0';
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
+
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		throughput_mbits = throughput_kbits / 1000;
+		throughput_kbits = throughput_kbits % 1000;
+
+		if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+			printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5]);
+		else
+			printf("%17s ", bat_host->name);
+
+		printf("%4i.%03is (%9u.%1u) [%10s]\n",
+		       last_seen_secs, last_seen_msecs,
+		       throughput_mbits, throughput_kbits / 100,
+		       ifname);
+	} else {
+		printf("   %10s	  ", ifname);
+
+		if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+			printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5]);
+		else
+			printf("%17s ", bat_host->name);
+
+		printf("%4i.%03is\n", last_seen_secs, last_seen_msecs);
+	}
+
+	return NL_OK;
+}
+
+static const int transglobal_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_TTVN,
+	BATADV_ATTR_TT_LAST_TTVN,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_FLAGS,
+};
+
+static int transglobal_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char c, r, w, i, t;
+	uint8_t last_ttvn;
+	uint32_t crc32;
+	uint32_t flags;
+	uint8_t *addr;
+	uint8_t *orig;
+	uint8_t ttvn;
+	int16_t vid;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, transglobal_mandatory,
+				    ARRAY_SIZE(transglobal_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
+	ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
+	last_ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_LAST_TTVN]);
+	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
+	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	c = ' ', r = '.', w = '.', i = '.', t = '.';
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = '*';
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		r = 'R';
+	if (flags & BATADV_TT_CLIENT_WIFI)
+		w = 'W';
+	if (flags & BATADV_TT_CLIENT_ISOLA)
+		i = 'I';
+	if (flags & BATADV_TT_CLIENT_TEMP)
+		t = 'T';
+
+	printf(" %c ", c);
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i [%c%c%c%c] (%3u) ",
+	       BATADV_PRINT_VID(vid), r, w, i, t, ttvn);
+
+	bat_host = bat_hosts_find_by_mac((char *)orig);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       orig[0], orig[1], orig[2],
+		       orig[3], orig[4], orig[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("(%3u) (0x%.8x)\n",
+	       last_ttvn, crc32);
+
+	return NL_OK;
+}
+
+static const int translocal_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_FLAGS,
+};
+
+static int translocal_callback(struct nl_msg *msg, void *arg)
+{
+	int last_seen_msecs = 0, last_seen_secs = 0;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char r, p, n, x, w, i;
+	uint8_t *addr;
+	int16_t vid;
+	uint32_t crc32;
+	uint32_t flags;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_LOCAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, translocal_mandatory,
+				    ARRAY_SIZE(translocal_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
+	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
+	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
+	last_seen_msecs = 0, last_seen_secs = 0;
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	r = '.', p = '.', n = '.', x = '.', w = '.', i = '.';
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		r = 'R';
+	if (flags & BATADV_TT_CLIENT_NEW)
+		n = 'N';
+	if (flags & BATADV_TT_CLIENT_PENDING)
+		x = 'X';
+	if (flags & BATADV_TT_CLIENT_WIFI)
+		w = 'W';
+	if (flags & BATADV_TT_CLIENT_ISOLA)
+		i = 'I';
+
+	if (flags & BATADV_TT_CLIENT_NOPURGE)  {
+		p = 'P';
+	} else {
+		if (!attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
+			fputs("Received invalid data from kernel.\n", stderr);
+			exit(1);
+		}
+
+		last_seen_msecs = nla_get_u32(
+			attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+		last_seen_secs = last_seen_msecs / 1000;
+		last_seen_msecs = last_seen_msecs % 1000;
+	}
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i [%c%c%c%c%c%c] %3u.%03u   (0x%.8x)\n",
+	       BATADV_PRINT_VID(vid), r, p, n, x, w, i,
+	       last_seen_secs, last_seen_msecs,
+	       crc32);
+
+	return NL_OK;
+}
+
+static const int gateways_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TQ,
+	BATADV_ATTR_ROUTER,
+	BATADV_ATTR_HARD_IFNAME,
+	BATADV_ATTR_BANDWIDTH_DOWN,
+	BATADV_ATTR_BANDWIDTH_UP,
+};
+
+static int gateways_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	const char *primary_if;
+	uint32_t bandwidth_down;
+	uint32_t bandwidth_up;
+	uint8_t *router;
+	uint8_t *orig;
+	char c = ' ';
+	uint8_t tq;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_GATEWAYS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, gateways_mandatory,
+				    ARRAY_SIZE(gateways_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = '*';
+
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+	router = nla_data(attrs[BATADV_ATTR_ROUTER]);
+	primary_if = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
+	bandwidth_down = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_DOWN]);
+	bandwidth_up = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_UP]);
+
+	printf("%c ", c);
+
+	bat_host = bat_hosts_find_by_mac((char *)orig);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       orig[0], orig[1], orig[2],
+		       orig[3], orig[4], orig[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("(%3i) ", tq);
+
+	bat_host = bat_hosts_find_by_mac((char *)router);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       router[0], router[1], router[2],
+		       router[3], router[4], router[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("[%10s]: %u.%u/%u.%u MBit\n",
+	       primary_if, bandwidth_down / 10, bandwidth_down % 10,
+	       bandwidth_up / 10, bandwidth_up % 10);
+
+	return NL_OK;
+}
+
+static const int bla_claim_mandatory[] = {
+	BATADV_ATTR_BLA_ADDRESS,
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
+};
+
+static int bla_claim_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	uint16_t backbone_crc;
+	uint8_t *backbone;
+	uint8_t *client;
+	uint16_t vid;
+	char c = ' ';
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_BLA_CLAIM)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, bla_claim_mandatory,
+				       ARRAY_SIZE(bla_claim_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	if (attrs[BATADV_ATTR_BLA_OWN])
+		c = '*';
+
+	client = nla_data(attrs[BATADV_ATTR_BLA_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_BLA_VID]);
+	backbone = nla_data(attrs[BATADV_ATTR_BLA_BACKBONE]);
+	backbone_crc = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
+
+	bat_host = bat_hosts_find_by_mac((char *)client);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       client[0], client[1], client[2],
+		       client[3], client[4], client[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("on %5d by ", BATADV_PRINT_VID(vid));
+
+	bat_host = bat_hosts_find_by_mac((char *)backbone);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       backbone[0], backbone[1], backbone[2],
+		       backbone[3], backbone[4], backbone[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("[%c] (0x%04x)\n", c, backbone_crc);
+
+	return NL_OK;
+}
+
+static int netlink_print_common(char *mesh_iface, char *orig_iface,
+				int read_opt, float orig_timeout,
+				float watch_interval, const char *header,
+				uint8_t nl_cmd, nl_recvmsg_msg_cb_t callback)
+{
+	struct print_opts opts = {
+		.read_opt = read_opt,
+		.orig_timeout = orig_timeout,
+		.watch_interval = watch_interval
+	};
+	int hardifindex = 0;
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ifindex;
+	int family;
+
+	sock = nl_socket_alloc();
+	genl_connect(sock);
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0)
+		return -EOPNOTSUPP;
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		return -ENODEV;
+	}
+
+	if (orig_iface) {
+		hardifindex = if_nametoindex(orig_iface);
+		if (!hardifindex) {
+			fprintf(stderr, "Interface %s is unknown\n",
+				orig_iface);
+			return -ENODEV;
+		}
+	}
+
+	bat_hosts_init(read_opt);
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, callback, &opts);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
+	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
+
+	do {
+		if (read_opt & CLR_CONT_READ)
+			/* clear screen, set cursor back to 0,0 */
+			printf("\033[2J\033[0;0f");
+
+		if (!(read_opt & SKIP_HEADER)) {
+			netlink_print_info(ifindex, nl_cmd, 0);
+			if (header)
+				printf("%s", header);
+		}
+
+		msg = nlmsg_alloc();
+		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
+			    NLM_F_DUMP, nl_cmd, 1);
+
+		nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+		if (hardifindex)
+			nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
+				    hardifindex);
+
+		nl_send_auto_complete(sock, msg);
+
+		nlmsg_free(msg);
+
+		last_err = 0;
+		nl_recvmsgs(sock, cb);
+		if (!last_err && read_opt & (CONT_READ|CLR_CONT_READ))
+			usleep(1000000 * watch_interval);
+
+	} while (!last_err && read_opt & (CONT_READ|CLR_CONT_READ));
+
+	bat_hosts_free();
+
+	nl_socket_free(sock);
+
+	return last_err;
+}
+
+int netlink_print_originators(char *mesh_iface, char *orig_iface,
+			      int read_opts, float orig_timeout,
+			      float watch_interval)
+{
+	char *header;
+	int ifindex;
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		return -ENODEV;
+	}
+
+	netlink_print_info(ifindex, BATADV_CMD_GET_ORIGINATORS, PARSE_ONLY);
+
+	if (strlen(algo_name_buf) == 0)
+		return -EINVAL;
+
+	if (!strcmp("BATMAN_IV", algo_name_buf))
+		header = "   Originator        last-seen (#/255) Nexthop           [outgoingIF]\n";
+	if (!strcmp("BATMAN_V", algo_name_buf))
+		header = "   Originator        last-seen ( throughput)  Nexthop           [outgoingIF]\n";
+
+	if (!header)
+		return -EINVAL;
+
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval, header,
+				    BATADV_CMD_GET_ORIGINATORS,
+				    originators_callback);
+}
+
+int netlink_print_neighbors(char *mesh_iface, char *orig_iface, int read_opts,
+			    float orig_timeout,
+			    float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "IF             Neighbor              last-seen\n",
+				    BATADV_CMD_GET_NEIGHBORS,
+				    neighbors_callback);
+}
+
+int netlink_print_transglobal(char *mesh_iface, char *orig_iface,
+			      int read_opts, float orig_timeout,
+			      float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )\n",
+				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				    transglobal_callback);
+}
+
+int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
+			     float orig_timeout,
+			     float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "Client             VID Flags    Last seen (CRC       )\n",
+				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
+				    translocal_callback);
+}
+
+int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
+			   float orig_timeout,
+			   float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "    Router           TQ      Next Hop        outgoingIf   Bandwidth\n",
+				    BATADV_CMD_GET_GATEWAYS,
+				    gateways_callback);
+}
+
+int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opts,
+			    float orig_timeout,
+			    float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "Client               VID      Originator        [o] (CRC   )\n",
+				    BATADV_CMD_GET_BLA_CLAIM,
+				    bla_claim_callback);
+}
diff --git a/netlink.h b/netlink.h
index 0a4d3dd..69f0958 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
- * Marek Lindner <mareklindner@neomailbox.ch>
+ * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
@@ -25,6 +25,22 @@
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
 
+int netlink_print_routing_algos(void);
+int netlink_print_originators(char *mesh_iface, char *orig_iface, int read_opt,
+			      float orig_timeout, float watch_interval);
+int netlink_print_neighbors(char *mesh_iface, char *orig_iface, int read_opt,
+			    float orig_timeout, float watch_interval);
+int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
+			   float orig_timeout, float watch_interval);
+int netlink_print_transglobal(char *mesh_iface, char *orig_iface, int read_opt,
+			      float orig_timeout, float watch_interval);
+int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
+			     float orig_timeout, float watch_interval);
+int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
+			   float orig_timeout, float watch_interval);
+int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opt,
+			    float orig_timeout, float watch_interval);
+
 extern struct nla_policy batadv_netlink_policy[];
 
 #endif /* _BATCTL_NETLINK_H */
diff --git a/packet.h b/packet.h
index 6b011ff..6afc0b8 100644
--- a/packet.h
+++ b/packet.h
@@ -129,42 +129,6 @@ enum batadv_tt_data_flags {
 };
 
 /**
- * enum batadv_tt_client_flags - TT client specific flags
- * @BATADV_TT_CLIENT_DEL: the client has to be deleted from the table
- * @BATADV_TT_CLIENT_ROAM: the client roamed to/from another node and the new
- *  update telling its new real location has not been received/sent yet
- * @BATADV_TT_CLIENT_WIFI: this client is connected through a wifi interface.
- *  This information is used by the "AP Isolation" feature
- * @BATADV_TT_CLIENT_ISOLA: this client is considered "isolated". This
- *  information is used by the Extended Isolation feature
- * @BATADV_TT_CLIENT_NOPURGE: this client should never be removed from the table
- * @BATADV_TT_CLIENT_NEW: this client has been added to the local table but has
- *  not been announced yet
- * @BATADV_TT_CLIENT_PENDING: this client is marked for removal but it is kept
- *  in the table for one more originator interval for consistency purposes
- * @BATADV_TT_CLIENT_TEMP: this global client has been detected to be part of
- *  the network but no nnode has already announced it
- *
- * Bits from 0 to 7 are called _remote flags_ because they are sent on the wire.
- * Bits from 8 to 15 are called _local flags_ because they are used for local
- * computations only.
- *
- * Bits from 4 to 7 - a subset of remote flags - are ensured to be in sync with
- * the other nodes in the network. To achieve this goal these flags are included
- * in the TT CRC computation.
- */
-enum batadv_tt_client_flags {
-	BATADV_TT_CLIENT_DEL     = BIT(0),
-	BATADV_TT_CLIENT_ROAM    = BIT(1),
-	BATADV_TT_CLIENT_WIFI    = BIT(4),
-	BATADV_TT_CLIENT_ISOLA	 = BIT(5),
-	BATADV_TT_CLIENT_NOPURGE = BIT(8),
-	BATADV_TT_CLIENT_NEW     = BIT(9),
-	BATADV_TT_CLIENT_PENDING = BIT(10),
-	BATADV_TT_CLIENT_TEMP	 = BIT(11),
-};
-
-/**
  * enum batadv_vlan_flags - flags for the four MSB of any vlan ID field
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
-- 
2.8.1

