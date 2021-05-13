Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 2/2] batctl: genl_json: Add generic JSON interface
Date: Thu, 13 May 2021 16:02:34 +0200
Message-Id: <20210513140234.1624460-3-asarmanow@gmail.com>
In-Reply-To: <20210513140234.1624460-1-asarmanow@gmail.com>
References: <20210513140234.1624460-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

To print JSON strings in a generic way a second nla_policy is used, with
a name (dict key) and a callback function for each entry corresponding
to its formats.
There are multiple callback functions created, depending on the NLA
type.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile    |   1 +
 genl_json.c | 359 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 genl_json.h |  24 ++++
 netlink.h   |   6 +
 4 files changed, 390 insertions(+)
 create mode 100644 genl_json.c
 create mode 100644 genl_json.h

diff --git a/Makefile b/Makefile
index 98bf695..cee4f0c 100755
--- a/Makefile
+++ b/Makefile
@@ -16,6 +16,7 @@ obj-y += bat-hosts.o
 obj-y += debug.o
 obj-y += functions.o
 obj-y += genl.o
+obj-y += genl_json.o
 obj-y += hash.o
 obj-y += icmp_helper.o
 obj-y += main.o
diff --git a/genl_json.c b/genl_json.c
new file mode 100644
index 0000000..cff54d8
--- /dev/null
+++ b/genl_json.c
@@ -0,0 +1,359 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Alexander Sarmanow <asarmanow@gmail.com>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <netlink/netlink.h>
+#include <netlink/attr.h>
+
+#include "genl_json.h"
+#include "batman_adv.h"
+#include "netlink.h"
+#include "main.h"
+
+static void nljson_print_str(struct nlattr *attrs[], int idx)
+{
+	const char *value;
+
+	value = nla_get_string(attrs[idx]);
+
+	putc('"', stdout);
+	sanitize_string(value);
+	putc('"', stdout);
+}
+
+static void nljson_print_uint8_t(struct nlattr *attrs[], int idx)
+{
+	uint8_t value = nla_get_u8(attrs[idx]);
+
+	printf("%u", value);
+}
+
+static void nljson_print_uint16_t(struct nlattr *attrs[], int idx)
+{
+	uint16_t value = nla_get_u16(attrs[idx]);
+
+	printf("%u", value);
+}
+
+static void nljson_print_uint32_t(struct nlattr *attrs[], int idx)
+{
+	uint32_t value = nla_get_u32(attrs[idx]);
+
+	printf("%u", value);
+}
+
+static void nljson_print_uint64_t(struct nlattr *attrs[], int idx)
+{
+	uint64_t value = nla_get_u64(attrs[idx]);
+
+	printf("%llu", value);
+}
+
+static void nljson_print_mac(struct nlattr *attrs[], int idx)
+{
+	uint8_t *value = nla_data(attrs[idx]);
+
+	printf("\"%02x:%02x:%02x:%02x:%02x:%02x\"",
+		value[0], value[1], value[2], value[3], value[4], value[5]);
+}
+
+static void nljson_print_flag(struct nlattr *attrs[], int idx)
+{
+	if (nla_get_flag(attrs[idx]))
+		printf("true");
+}
+
+void sanitize_string(const char *str)
+{
+	while (*str) {
+		if (*str == '"' || *str == '\\') {
+			putchar('\\');
+			putchar(*str);
+		} else if (*str == '\\') {
+			printf("\\\\");
+		} else if (!isprint(*str)) {
+			printf("\\x%02x", *str);
+		} else {
+			printf("%c", *str);
+		}
+		str++;
+	}
+}
+
+void netlink_print_json_entries(struct nlattr *attrs[], struct json_opts *json_opts)
+{
+	bool first_valid_attr = true;
+	int i;
+
+	if (!json_opts->is_first)
+		printf(",");
+
+	printf("{");
+	for (i = 0; i < BATADV_ATTR_MAX + 1; i++) {
+		if (!attrs[i])
+			continue;
+
+		if (!batadv_netlink_policy_json[i].cb)
+			continue;
+
+		if (!first_valid_attr)
+			printf(",");
+
+		putc('"', stdout);
+		sanitize_string(batadv_netlink_policy_json[i].name);
+		printf("\":");
+		batadv_netlink_policy_json[i].cb(attrs, i);
+
+		first_valid_attr = false;
+	}
+	printf("}");
+}
+
+
+struct nla_policy_json batadv_netlink_policy_json[NUM_BATADV_ATTR] = {
+	[BATADV_ATTR_VERSION] = {
+		.name = "version",
+		.cb = nljson_print_str,
+	},
+	[BATADV_ATTR_ALGO_NAME] = {
+		.name = "algo_name",
+		.cb = nljson_print_str,
+	},
+	[BATADV_ATTR_MESH_IFINDEX] = {
+		.name = "mesh_ifindex",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_MESH_IFNAME] = {
+		.name = "mesh_ifname",
+		.cb = nljson_print_str,
+	},
+	[BATADV_ATTR_MESH_ADDRESS] = {
+		.name = "mesh_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_HARD_IFINDEX] = {
+		.name = "hard_ifindex",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_HARD_IFNAME] = {
+		.name = "hard_ifname",
+		.cb = nljson_print_str,
+	},
+	[BATADV_ATTR_HARD_ADDRESS] = {
+		.name = "hard_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_ORIG_ADDRESS] = {
+		.name = "orig_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_TPMETER_RESULT] = {
+		.name = "tpmeter_result",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_TPMETER_TEST_TIME] = {
+		.name = "tpmeter_test_time",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_TPMETER_BYTES] = {
+		.name = "tpmeter_bytes",
+		.cb = nljson_print_uint64_t
+	},
+	[BATADV_ATTR_TPMETER_COOKIE] = {
+		.name = "tpmeter_cookie",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_PAD] = {
+		.name = "pad",
+	},
+	[BATADV_ATTR_ACTIVE] = {
+		.name = "active",
+		.cb = nljson_print_flag,
+	},
+	[BATADV_ATTR_TT_ADDRESS] = {
+		.name = "tt_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_TT_TTVN] = {
+		.name = "tt_ttvn",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_TT_LAST_TTVN] = {
+		.name = "last_ttvn",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_TT_CRC32] = {
+		.name = "crc32",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_TT_VID] = {
+		.name = "tt_vid",
+		.cb = nljson_print_uint16_t,
+	},
+	[BATADV_ATTR_TT_FLAGS] = {
+		.name = "tt_flags",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_FLAG_BEST] = {
+		.name = "best",
+		.cb = nljson_print_flag,
+	},
+	[BATADV_ATTR_LAST_SEEN_MSECS] = {
+		.name = "last_seen_msecs",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_NEIGH_ADDRESS] = {
+		.name = "neigh_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_TQ] = {
+		.name = "tq",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_THROUGHPUT] = {
+		.name = "throughput",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_BANDWIDTH_UP] = {
+		.name = "bandwidth_up",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_BANDWIDTH_DOWN] = {
+		.name = "bandwidth_down",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_ROUTER] = {
+		.name = "router",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_BLA_OWN] = {
+		.name = "bla_own",
+		.cb = nljson_print_flag,
+	},
+	[BATADV_ATTR_BLA_ADDRESS] = {
+		.name = "bla_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_BLA_VID] = {
+		.name = "bla_vid",
+		.cb = nljson_print_uint16_t,
+	},
+	[BATADV_ATTR_BLA_BACKBONE] = {
+		.name = "bla_backbone",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_BLA_CRC] = {
+		.name = "bla_crc",
+		.cb = nljson_print_uint16_t,
+	},
+	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS] = {
+		.name = "dat_cache_ip4_address",
+	},
+	[BATADV_ATTR_DAT_CACHE_HWADDRESS] = {
+		.name = "dat_cache_hw_address",
+		.cb = nljson_print_mac,
+	},
+	[BATADV_ATTR_DAT_CACHE_VID] = {
+		.name = "dat_cache_vid",
+		.cb = nljson_print_uint16_t,
+	},
+	[BATADV_ATTR_MCAST_FLAGS] = {
+		.name = "mcast_flags",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_MCAST_FLAGS_PRIV] = {
+		.name = "mcast_flags_priv",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_VLANID] = {
+		.name = "vlan_id",
+		.cb = nljson_print_uint16_t,
+	},
+	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED] = {
+		.name = "aggregated_ogms_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_AP_ISOLATION_ENABLED] = {
+		.name = "ap_isolation_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_ISOLATION_MARK] = {
+		.name = "isolation_mark",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_ISOLATION_MASK] = {
+		.name = "isolation_mask",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_BONDING_ENABLED] = {
+		.name = "bonding_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED] = {
+		.name = "bridge_loop_avoidance_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED] = {
+		.name = "distributed_arp_table_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_FRAGMENTATION_ENABLED] = {
+		.name = "fragmented_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_GW_BANDWIDTH_DOWN] = {
+		.name = "bandwidth_down",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_GW_BANDWIDTH_UP] = {
+		.name = "bandwidth_up",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_GW_MODE] = {
+		.name = "gw_mode",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_GW_SEL_CLASS] = {
+		.name = "gw_sel_class",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_HOP_PENALTY] = {
+		.name = "hop_penalty",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_LOG_LEVEL] = {
+		.name = "log_level",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED] = {
+		.name = "multicast_forceflood_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_NETWORK_CODING_ENABLED] = {
+		.name = "network_coding_enabled",
+		.cb = nljson_print_uint8_t,
+	},
+	[BATADV_ATTR_ORIG_INTERVAL] = {
+		.name = "orig_interval",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_ELP_INTERVAL] = {
+		.name = "elp_interval",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_THROUGHPUT_OVERRIDE] = {
+		.name = "throughput_override",
+		.cb = nljson_print_uint32_t,
+	},
+	[BATADV_ATTR_MULTICAST_FANOUT] = {
+		.name = "multicast_fanout",
+		.cb = nljson_print_uint32_t,
+	},
+};
diff --git a/genl_json.h b/genl_json.h
new file mode 100644
index 0000000..0336b40
--- /dev/null
+++ b/genl_json.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Alexander Sarmanow <asarmanow@gmail.com>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#ifndef _BATCTL_GENLJSON_H
+#define _BATCTL_GENLJSON_H
+
+#include <stdint.h>
+
+#include "netlink.h"
+
+struct json_opts {
+	uint8_t is_first;
+	struct nlquery_opts query_opts;
+};
+
+void netlink_print_json_entries(struct nlattr *attrs[], struct json_opts *json_opts);
+void sanitize_string(const char *str);
+
+#endif /* _BATCTL_GENLJSON_H */
diff --git a/netlink.h b/netlink.h
index c93f500..d96935a 100644
--- a/netlink.h
+++ b/netlink.h
@@ -29,6 +29,11 @@ struct nlquery_opts {
 	int err;
 };
 
+struct nla_policy_json {
+	const char *name;
+	void (*cb)(struct nlattr *attrs[], int idx);
+};
+
 struct ether_addr;
 
 int netlink_create(struct state *state);
@@ -44,6 +49,7 @@ int get_algoname_netlink(struct state *state, unsigned int mesh_ifindex,
 			 char *algoname, size_t algoname_len);
 
 extern struct nla_policy batadv_netlink_policy[];
+extern struct nla_policy_json batadv_netlink_policy_json[];
 
 int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
 			    int num);
-- 
2.25.1

