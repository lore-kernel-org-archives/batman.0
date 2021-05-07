Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v2 1/2] batctl: Add generic JSON interface
Date: Fri,  7 May 2021 19:14:14 +0200
Message-Id: <20210507171414.369399-1-asarmanow@gmail.com>
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
There are multiple callback functions created, most of them are straight
forward. The nljson_print_ttflags() needed more logic behind it, because
of its dependency with the last_seen_msecs entry and whether local or
global table is requested.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 backbonetable.c |   2 +-
 claimtable.c    |   2 +-
 dat_cache.c     |   2 +-
 gateways.c      |   2 +-
 main.h          |   2 +
 mcast_flags.c   |   2 +-
 neighbors.c     |   2 +-
 netlink.c       | 282 +++++++++++++++++++++++++++++++++++++++++++++++-
 netlink.h       |  37 ++++++-
 originators.c   |   2 +-
 transglobal.c   |   2 +-
 translocal.c    |   2 +-
 12 files changed, 328 insertions(+), 11 deletions(-)

diff --git a/backbonetable.c b/backbonetable.c
index 17fbd1d..11cec32 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -98,7 +98,7 @@ static int netlink_print_bla_backbone(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "Originator           VID   last seen (CRC   )\n",
 				    BATADV_CMD_GET_BLA_BACKBONE,
-				    bla_backbone_callback);
+				    bla_backbone_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_backbonetable = {
diff --git a/claimtable.c b/claimtable.c
index b6bf9f5..0bf017d 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -103,7 +103,7 @@ static int netlink_print_bla_claim(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "Client               VID      Originator        [o] (CRC   )\n",
 				    BATADV_CMD_GET_BLA_CLAIM,
-				    bla_claim_callback);
+				    bla_claim_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_claimtable = {
diff --git a/dat_cache.c b/dat_cache.c
index 8d47171..109e553 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -116,7 +116,7 @@ static int netlink_print_dat_cache(struct state *state, char *orig_iface,
 	ret = netlink_print_common(state, orig_iface, read_opts,
 				   orig_timeout, watch_interval, header,
 				   BATADV_CMD_GET_DAT_CACHE,
-				   dat_cache_callback);
+				   dat_cache_callback, 0);
 
 	free(header);
 	return ret;
diff --git a/gateways.c b/gateways.c
index 7625bd8..867c882 100644
--- a/gateways.c
+++ b/gateways.c
@@ -141,7 +141,7 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    header,
 				    BATADV_CMD_GET_GATEWAYS,
-				    gateways_callback);
+				    gateways_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_gateways = {
diff --git a/main.h b/main.h
index 81b7a27..b1ff050 100644
--- a/main.h
+++ b/main.h
@@ -44,6 +44,8 @@ extern char module_ver_path[];
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 
+#define BOOL_STRING(x) (x ? "true" : "false")
+
 #ifndef container_of
 #define container_of(ptr, type, member) __extension__ ({ \
 	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
diff --git a/mcast_flags.c b/mcast_flags.c
index 721f549..cb6e89d 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -147,7 +147,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 	ret = netlink_print_common(state, orig_iface, read_opts,
 				   orig_timeout, watch_interval, header,
 				   BATADV_CMD_GET_MCAST_FLAGS,
-				   mcast_flags_callback);
+				   mcast_flags_callback, 0);
 
 	free(header);
 	return ret;
diff --git a/neighbors.c b/neighbors.c
index af76d0f..2a50e78 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -114,7 +114,7 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "IF             Neighbor              last-seen\n",
 				    BATADV_CMD_GET_NEIGHBORS,
-				    neighbors_callback);
+				    neighbors_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_neighbors = {
diff --git a/netlink.c b/netlink.c
index 31c9b01..26ae5ef 100644
--- a/netlink.c
+++ b/netlink.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <ctype.h>
 #include <errno.h>
 #include <net/ethernet.h>
 #include <net/if.h>
@@ -116,6 +117,50 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 };
 
+struct nla_policy_json batadv_netlink_policy_json[NUM_BATADV_ATTR] = {
+	[BATADV_ATTR_VERSION]			= { .name = "version",
+						    .cb = nljson_print_str },
+	[BATADV_ATTR_ALGO_NAME]			= { .name = "algo",
+						    .cb = nljson_print_str },
+	[BATADV_ATTR_MESH_IFINDEX]		= { .name = "mesh_if_idx",
+						    .cb = nljson_print_ifname_by_ifindex },
+	[BATADV_ATTR_MESH_IFNAME]		= { .name = "mesh_if",
+						    .cb = nljson_print_str },
+	[BATADV_ATTR_MESH_ADDRESS]		= { .name = "mesh_address",
+						    .cb = nljson_print_mac},
+	[BATADV_ATTR_ORIG_ADDRESS]		= { .name = "originator",
+						    .cb = nljson_print_mac },
+	[BATADV_ATTR_HARD_IFINDEX]		= { .name = "hard_if_idx",
+						    .cb = nljson_print_ifname_by_ifindex },
+	[BATADV_ATTR_HARD_IFNAME]		= { .name = "hard_if",
+						    .cb = nljson_print_str },
+	[BATADV_ATTR_HARD_ADDRESS]		= { .name = "hard_addr",
+						    .cb = nljson_print_mac },
+	[BATADV_ATTR_TT_ADDRESS]		= { .name = "client",
+						    .cb = nljson_print_mac },
+	[BATADV_ATTR_TT_TTVN]			= { .name = "ttvn",
+						    .cb = nljson_print_uint8_t },
+	[BATADV_ATTR_TT_LAST_TTVN]		= { .name = "last_ttvn",
+						    .cb = nljson_print_uint8_t },
+	[BATADV_ATTR_TT_CRC32]			= { .name = "crc32",
+						    .cb = nljson_print_crc32 },
+	[BATADV_ATTR_TT_VID]			= { .name = "vid",
+						    .cb = nljson_print_vid },
+	[BATADV_ATTR_TT_FLAGS]			= { .name = "flags",
+						    .cb = nljson_print_ttflags },
+	[BATADV_ATTR_FLAG_BEST]			= { .name = "best",
+						    .cb = nljson_print_bool},
+	[BATADV_ATTR_LAST_SEEN_MSECS]		= { .name = "last_seen",
+						    .cb = nljson_print_int},
+	[BATADV_ATTR_NEIGH_ADDRESS]		= { .name = "neighbor",
+						    .cb = nljson_print_mac },
+	[BATADV_ATTR_TQ]			= { .name = "tq",
+						    .cb = nljson_print_uint8_t },
+	[BATADV_ATTR_THROUGHPUT]		= { .name = "throughput",
+						    .cb = nljson_print_unsigned },
+	[BATADV_ATTR_BLA_CRC]			= { .name = "bla_crc",},
+};
+
 int netlink_create(struct state *state)
 {
 	int ret;
@@ -419,7 +464,7 @@ int netlink_print_common_cb(struct nl_msg *msg, void *arg)
 int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
-			 nl_recvmsg_msg_cb_t callback)
+			 nl_recvmsg_msg_cb_t callback, uint8_t is_json)
 {
 	struct print_opts opts = {
 		.read_opt = read_opt,
@@ -427,6 +472,9 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		.watch_interval = watch_interval,
 		.remaining_header = NULL,
 		.callback = callback,
+		.nl_cmd = nl_cmd,
+		.is_json = is_json,
+		.is_first = 1,
 	};
 	int hardifindex = 0;
 	struct nl_msg *msg;
@@ -495,6 +543,238 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 	return last_err;
 }
 
+void netlink_print_json_entries(struct nlattr *attrs[], int selected_attrs[],
+				int arr_len, struct print_opts *opts)
+{
+	const char *name;
+	uint8_t first_valid_attr = 1;
+	int idx, i;
+	struct json_opts json_opts = {
+		.use_alt_int_val = 0,
+		.alt_int_val = 0,
+	};
+
+
+	if (!opts->is_first)
+		printf(",");
+
+	for (i = 0; i < arr_len; i++) {
+		idx = selected_attrs[i];
+
+		if (attrs[idx] && batadv_netlink_policy_json[idx].cb) {
+			if (!first_valid_attr)
+				printf(",");
+			else
+				printf("{");
+
+			create_json_print_string(batadv_netlink_policy_json[idx].name,
+						 &name);
+			sanitize_string(name, strlen(name));
+			printf(":");
+			batadv_netlink_policy_json[idx].cb(&json_opts, opts,
+							   attrs, idx);
+
+			first_valid_attr = 0;
+		}
+	}
+	if (!first_valid_attr)
+		printf("}");
+}
+
+void nljson_print_str(struct json_opts *json_opts, struct print_opts *opts,
+		      struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	const char *value;
+	const char *value_print;
+
+	value = nla_get_string(attrs[idx]);
+
+	create_json_print_string(value, &value_print);
+	sanitize_string(value_print, strlen(value_print));
+}
+
+void nljson_print_ifname_by_ifindex(struct json_opts *json_opts,
+				    struct print_opts *opts, struct nlattr *attrs[],
+				    int idx)
+{
+	(void) opts;
+	(void) json_opts;
+	char value[IF_NAMESIZE];
+	const char *value_buf;
+
+	if (!if_indextoname(nla_get_u32(attrs[idx]), value))
+		value[0] = '\0';
+
+	create_json_print_string(value, &value_buf);
+	sanitize_string(value_buf, strlen(value_buf));
+}
+
+void nljson_print_int(struct json_opts *json_opts, struct print_opts *opts,
+		      struct nlattr *attrs[], int idx)
+{
+	(void) opts;
+	int value;
+
+	if (json_opts->use_alt_int_val) {
+		json_opts->use_alt_int_val = 0;
+		value = json_opts->alt_int_val;
+	} else {
+		value = nla_get_u32(attrs[idx]);
+	}
+
+	printf("%d", value);
+}
+
+void nljson_print_unsigned(struct json_opts *json_opts, struct print_opts *opts,
+			   struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	unsigned value = nla_get_u32(attrs[idx]);
+	printf("%u", value);
+}
+
+void nljson_print_uint8_t(struct json_opts *json_opts, struct print_opts *opts,
+			  struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	uint8_t value = nla_get_u8(attrs[idx]);
+	printf("%u", value);
+}
+
+void nljson_print_mac(struct json_opts *json_opts, struct print_opts *opts,
+		      struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	uint8_t *value = nla_data(attrs[idx]);
+	printf("\"%02x:%02x:%02x:%02x:%02x:%02x\"",
+		value[0], value[1], value[2], value[3], value[4], value[5]);
+}
+
+void nljson_print_bool(struct json_opts *json_opts, struct print_opts *opts,
+		       struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	bool value = nla_get_flag(attrs[idx]);
+	printf("%s", BOOL_STRING(value));
+}
+
+void nljson_print_vid(struct json_opts *json_opts, struct print_opts *opts,
+		      struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	int16_t value = nla_get_u16(attrs[idx]);
+	printf("%i", BATADV_PRINT_VID(value));
+}
+
+void nljson_print_crc32(struct json_opts *json_opts, struct print_opts *opts,
+		      struct nlattr *attrs[], int idx)
+{
+	(void) json_opts;
+	(void) opts;
+	int32_t value = nla_get_u32(attrs[idx]);
+	printf("\"0x%.8x\"", value);
+}
+
+void nljson_print_ttflags(struct json_opts *json_opts, struct print_opts *opts,
+			  struct nlattr *attrs[], int idx)
+{
+	const char *key_ls;
+	uint32_t flags;
+	char r, n, x, w, i, p, t;
+
+	flags = nla_get_u32(attrs[idx]);
+
+	r = '.', p = '.', n = '.', x = '.', w = '.', i = '.', t = '.';
+
+	if (opts->nl_cmd == BATADV_CMD_GET_TRANSTABLE_LOCAL) {
+		// last_seen = 0 when flags are set
+		json_opts->use_alt_int_val = 0;
+		json_opts->alt_int_val = 0;
+
+		if (flags & BATADV_TT_CLIENT_ROAM)
+			r = 'R';
+		if (flags & BATADV_TT_CLIENT_NEW)
+			n = 'N';
+		if (flags & BATADV_TT_CLIENT_PENDING)
+			x = 'X';
+		if (flags & BATADV_TT_CLIENT_WIFI)
+			w = 'W';
+		if (flags & BATADV_TT_CLIENT_ISOLA)
+			i = 'I';
+		if (flags & BATADV_TT_CLIENT_NOPURGE)  {
+			p = 'P';
+		} else {
+			if (!attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
+				fputs("Received invalid data from kernel.\n", stderr);
+				exit(1);
+			}
+			goto print_local_table;
+		}
+
+		json_opts->use_alt_int_val = 1;
+		goto print_local_table;
+	} else {
+		if (flags & BATADV_TT_CLIENT_ROAM)
+			r = 'R';
+		if (flags & BATADV_TT_CLIENT_WIFI)
+			w = 'W';
+		if (flags & BATADV_TT_CLIENT_ISOLA)
+			i = 'I';
+		if (flags & BATADV_TT_CLIENT_TEMP)
+			t = 'T';
+
+		goto print_global_table;
+	}
+
+print_local_table:
+	printf("\"%c%c%c%c%c%c\"", r, n, x, w, i, p);
+
+	printf(",");
+	create_json_print_string(batadv_netlink_policy_json[BATADV_ATTR_LAST_SEEN_MSECS].name,
+				 &key_ls);
+	sanitize_string(key_ls, strlen(key_ls));
+	printf(":");
+	nljson_print_int(json_opts, opts, attrs, BATADV_ATTR_LAST_SEEN_MSECS);
+
+	return;
+
+print_global_table:
+	printf("\"%c%c%c%c\"", r, w, i, t);
+}
+
+void create_json_print_string(const char *str, const char **str_ret)
+{
+	size_t needed = snprintf(NULL, 0, "\"%s\"", str);
+	char  *str_buf = malloc(needed+1);
+
+	sprintf(str_buf, "\"%s\"", str);
+
+	*str_ret = str_buf;
+}
+
+void sanitize_string(const char *str, int str_len)
+{
+	int i;
+
+	for (i = 0; i < str_len; i++) {
+		if (str[i] == '"')
+			printf("\"");
+		else if (str[i] == '\\')
+			printf("\\\\");
+		else if (!isprint(str[i]))
+			printf("\\x%02x", str[i]);
+		else
+			printf("%c", str[i]);
+	}
+}
+
 static int nlquery_error_cb(struct sockaddr_nl *nla __maybe_unused,
 			    struct nlmsgerr *nlerr, void *arg)
 {
diff --git a/netlink.h b/netlink.h
index 4ee2f39..c766741 100644
--- a/netlink.h
+++ b/netlink.h
@@ -21,8 +21,22 @@ struct print_opts {
 	float watch_interval;
 	nl_recvmsg_msg_cb_t callback;
 	char *remaining_header;
+	char *remaining_entry;
 	const char *static_header;
 	uint8_t nl_cmd;
+	uint8_t is_json;
+	uint8_t is_first;
+};
+
+struct json_opts {
+	uint8_t use_alt_int_val;
+	int alt_int_val;
+};
+
+struct nla_policy_json {
+	const char *name;
+	void (*cb)(struct json_opts *json_opts, struct print_opts *opts,
+		   struct nlattr *attrs[], int idx);
 };
 
 struct ether_addr;
@@ -40,13 +54,14 @@ int get_algoname_netlink(const char *mesh_iface, char *algoname,
 			 size_t algoname_len);
 
 extern struct nla_policy batadv_netlink_policy[];
+extern struct nla_policy_json batadv_netlink_policy_json[];
 
 int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
 			    int num);
 int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
-			 nl_recvmsg_msg_cb_t callback);
+			 nl_recvmsg_msg_cb_t callback, uint8_t is_json);
 
 int netlink_print_common_cb(struct nl_msg *msg, void *arg);
 int netlink_stop_callback(struct nl_msg *msg, void *arg);
@@ -54,6 +69,26 @@ int netlink_print_error(struct sockaddr_nl *nla, struct nlmsgerr *nlerr,
 			void *arg);
 void netlink_print_remaining_header(struct print_opts *opts);
 
+void netlink_print_json_entries(struct nlattr *attrs[], int selected_attrs[],
+				int arr_len, struct print_opts *opts);
+void netlink_print_json_entry(struct nlattr *attrs[], int idx);
+void nljson_print_str(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
+void nljson_print_ifname_by_ifindex(struct json_opts *json_opts, struct print_opts *opts,
+				    struct nlattr *attrs[], int idx);
+void nljson_print_int(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
+void nljson_print_unsigned(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[],
+			   int idx);
+void nljson_print_uint8_t(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[],
+			  int idx);
+void nljson_print_vid(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
+void nljson_print_crc32(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
+void nljson_print_mac(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
+void nljson_print_bool(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
+void nljson_print_ttflags(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[],
+			  int idx);
+void create_json_print_string(const char *str, const char **str_ret);
+void sanitize_string(const char *str, int str_len);
+
 extern char algo_name_buf[256];
 extern int last_err;
 extern int64_t mcast_flags;
diff --git a/originators.c b/originators.c
index 8a29dd7..674656c 100644
--- a/originators.c
+++ b/originators.c
@@ -192,7 +192,7 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval, header,
 				    BATADV_CMD_GET_ORIGINATORS,
-				    originators_callback);
+				    originators_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_originators = {
diff --git a/transglobal.c b/transglobal.c
index 4eae95d..c9312c0 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -132,7 +132,7 @@ static int netlink_print_transglobal(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )\n",
 				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
-				    transglobal_callback);
+				    transglobal_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_transglobal = {
diff --git a/translocal.c b/translocal.c
index a3ad3da..7753010 100644
--- a/translocal.c
+++ b/translocal.c
@@ -128,7 +128,7 @@ static int netlink_print_translocal(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "Client             VID Flags    Last seen (CRC       )\n",
 				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
-				    translocal_callback);
+				    translocal_callback, 0);
 }
 
 static struct debug_table_data batctl_debug_table_translocal = {
-- 
2.25.1

