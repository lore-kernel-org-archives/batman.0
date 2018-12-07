Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:31:50 +0100
Message-Id: <20181207203209.22633-2-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 01/20] batctl: Add support for config mcast
 group in event monitor
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

The netlink set netlink messages issued by the config subcommands get as
reply a multicast message with the new value. The event monitor should show
these messages similar to the tp_meter results.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman_adv.h | 188 +++++++++++++++++++++++++++++++++++++++--
 event.c      | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c    |  20 +++++
 3 files changed, 437 insertions(+), 5 deletions(-)

diff --git a/batman_adv.h b/batman_adv.h
index 324a0e1..b5a245e 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -27,6 +27,7 @@
 
 #define BATADV_NL_NAME "batadv"
 
+#define BATADV_NL_MCAST_GROUP_CONFIG	"config"
 #define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
 
 /**
@@ -138,6 +139,20 @@ enum batadv_mcast_flags_priv {
 	BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING	= (1 << 4),
 };
 
+/**
+ * enum batadv_gw_modes - gateway mode of node
+ */
+enum batadv_gw_modes {
+	/** @BATADV_GW_MODE_OFF: gw mode disabled */
+	BATADV_GW_MODE_OFF,
+
+	/** @BATADV_GW_MODE_CLIENT: send DHCP requests to gw servers */
+	BATADV_GW_MODE_CLIENT,
+
+	/** @BATADV_GW_MODE_SERVER: announce itself as gatway server */
+	BATADV_GW_MODE_SERVER,
+};
+
 /**
  * enum batadv_nl_attrs - batman-adv netlink attributes
  */
@@ -344,6 +359,136 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MCAST_FLAGS_PRIV,
 
+	/**
+	 * @BATADV_ATTR_VLANID: VLAN id on top of soft interface
+	 */
+	BATADV_ATTR_VLANID,
+
+	/**
+	 * @BATADV_ATTR_AGGREGATED_OGMS: whether the batman protocol messages
+	 *  of the mesh mesh interface shall be aggregated or not.
+	 */
+	BATADV_ATTR_AGGREGATED_OGMS,
+
+	/**
+	 * @BATADV_ATTR_AP_ISOLATION: whether the data traffic going from a
+	 *  wireless client to another wireless client will be silently dropped.
+	 */
+	BATADV_ATTR_AP_ISOLATION,
+
+	/**
+	 * @BATADV_ATTR_ISOLATION_MARK: the isolation mark which is used to
+	 *  classify clients as "isolated" by the Extended Isolation feature.
+	 */
+	BATADV_ATTR_ISOLATION_MARK,
+
+	/**
+	 * @BATADV_ATTR_ISOLATION_MASK: the isolation (bit)mask which is used to
+	 *  classify clients as "isolated" by the Extended Isolation feature.
+	 */
+	BATADV_ATTR_ISOLATION_MASK,
+
+	/**
+	 * @BATADV_ATTR_BONDING: whether the data traffic going through the
+	 *  mesh will be sent using multiple interfaces at the same time.
+	 */
+	BATADV_ATTR_BONDING,
+
+	/**
+	 * @BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE: whether the bridge loop avoidance
+	 *  feature is enabled. This feature detects and avoids loops between
+	 *  the mesh and devices bridged with the soft interface
+	 */
+	BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE,
+
+	/**
+	 * @BATADV_ATTR_DISTRIBUTED_ARP_TABLE: whether the distributed arp table
+	 *  feature is enabled. This feature uses a distributed hash table to
+	 *  answer ARP requests without flooding the request through the whole
+	 *  mesh.
+	 */
+	BATADV_ATTR_DISTRIBUTED_ARP_TABLE,
+
+	/**
+	 * @BATADV_ATTR_FRAGMENTATION: whether the data traffic going through
+	 *  the mesh will be fragmented or silently discarded if the packet size
+	 *  exceeds the outgoing interface MTU.
+	 */
+	BATADV_ATTR_FRAGMENTATION,
+
+	/**
+	 * @BATADV_ATTR_GW_BANDWIDTH_DOWN: defines the download bandwidth which
+	 *  is propagated by this node if %BATADV_ATTR_GW_BANDWIDTH_MODE was set
+	 *  to 'server'.
+	 */
+	BATADV_ATTR_GW_BANDWIDTH_DOWN,
+
+	/**
+	 * @BATADV_ATTR_GW_BANDWIDTH_UP: defines the upload bandwidth which
+	 *  is propagated by this node if %BATADV_ATTR_GW_BANDWIDTH_MODE was set
+	 *  to 'server'.
+	 */
+	BATADV_ATTR_GW_BANDWIDTH_UP,
+
+	/**
+	 * @BATADV_ATTR_GW_MODE: defines the state of the gateway features.
+	 * Possible values are specified in enum batadv_gw_modes
+	 */
+	BATADV_ATTR_GW_MODE,
+
+	/**
+	 * @BATADV_ATTR_GW_SEL_CLASS: defines the selection criteria this node
+	 *  will use to choose a gateway if gw_mode was set to 'client'.
+	 */
+	BATADV_ATTR_GW_SEL_CLASS,
+
+	/**
+	 * @BATADV_ATTR_HOP_PENALTY: defines the penalty which will be applied
+	 *  to an originator message's tq-field on every hop.
+	 */
+	BATADV_ATTR_HOP_PENALTY,
+
+	/**
+	 * @BATADV_ATTR_LOG_LEVEL: bitmask with to define which debug messages
+	 *  should be send to the debug log/trace ring buffer
+	 */
+	BATADV_ATTR_LOG_LEVEL,
+
+	/**
+	 * @BATADV_ATTR_MULTICAST_MODE: whether multicast optimizations are
+	 *  enabled or disabled. If set to zero then all nodes in the mesh are
+	 *  going to use classic flooding for any multicast packet with no
+	 *  optimizations.
+	 */
+	BATADV_ATTR_MULTICAST_MODE,
+
+	/**
+	 * @BATADV_ATTR_NETWORK_CODING: whether Network Coding (using some magic
+	 *  to send fewer wifi packets but still the same content) is enabled or
+	 *  not.
+	 */
+	BATADV_ATTR_NETWORK_CODING,
+
+	/**
+	 * @BATADV_ATTR_ORIG_INTERVAL: defines the interval in milliseconds in
+	 *  which batman sends its protocol messages.
+	 */
+	BATADV_ATTR_ORIG_INTERVAL,
+
+	/**
+	 * @BATADV_ATTR_ELP_INTERVAL: defines the interval in milliseconds in
+	 *  which batman emits probing packets for neighbor sensing (ELP).
+	 */
+	BATADV_ATTR_ELP_INTERVAL,
+
+	/**
+	 * @BATADV_ATTR_THROUGHPUT_OVERRIDE: defines the throughput value to be
+	 *  used by B.A.T.M.A.N. V when estimating the link throughput using
+	 *  this interface. If the value is set to 0 then batman-adv will try to
+	 *  estimate the throughput by itself.
+	 */
+	BATADV_ATTR_THROUGHPUT_OVERRIDE,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -372,10 +517,14 @@ enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
 
 	/**
-	 * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv
-	 * device
+	 * @BATADV_CMD_GET_MESH: Get attributes from softif/mesh
+	 */
+	BATADV_CMD_GET_MESH,
+
+	/**
+	 * @BATADV_CMD_GET_MESH_INFO: Alias for @BATADV_CMD_GET_MESH
 	 */
-	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_MESH_INFO = BATADV_CMD_GET_MESH,
 
 	/**
 	 * @BATADV_CMD_TP_METER: Start a tp meter session
@@ -393,9 +542,15 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_ROUTING_ALGOS,
 
 	/**
-	 * @BATADV_CMD_GET_HARDIFS: Query list of hard interfaces
+	 * @BATADV_CMD_GET_HARDIF: Get attributes from a hardif of the
+	 *  current softif
 	 */
-	BATADV_CMD_GET_HARDIFS,
+	BATADV_CMD_GET_HARDIF,
+
+	/**
+	 * @BATADV_CMD_GET_HARDIFS: Alias for @BATADV_CMD_GET_HARDIF
+	 */
+	BATADV_CMD_GET_HARDIFS = BATADV_CMD_GET_HARDIF,
 
 	/**
 	 * @BATADV_CMD_GET_TRANSTABLE_LOCAL: Query list of local translations
@@ -443,6 +598,29 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_MCAST_FLAGS,
 
+	/**
+	 * @BATADV_CMD_SET_MESH: Set attributes for softif/mesh
+	 */
+	BATADV_CMD_SET_MESH,
+
+	/**
+	 * @BATADV_CMD_SET_HARDIF: Set attributes for hardif of the
+	 *  current softif
+	 */
+	BATADV_CMD_SET_HARDIF,
+
+	/**
+	 * @BATADV_CMD_GET_VLAN: Get attributes from a VLAN of the
+	 *  current softif
+	 */
+	BATADV_CMD_GET_VLAN,
+
+	/**
+	 * @BATADV_CMD_SET_VLAN: Set attributes for VLAN of the
+	 *  current softif
+	 */
+	BATADV_CMD_SET_VLAN,
+
 	/* add new commands above here */
 
 	/**
diff --git a/event.c b/event.c
index 8eda269..28a5205 100644
--- a/event.c
+++ b/event.c
@@ -22,6 +22,7 @@
 
 #include <errno.h>
 #include <getopt.h>
+#include <net/if.h>
 #include <netinet/if_ether.h>
 #include <netlink/netlink.h>
 #include <netlink/genl/genl.h>
@@ -51,6 +52,14 @@ struct event_args {
 	struct timeval tv;
 };
 
+static const char *u8_to_boolstr(struct nlattr *attrs)
+{
+	if (nla_get_u8(attrs))
+		return "true";
+	else
+		return "false";
+}
+
 static void event_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] event [parameters]\n");
@@ -87,6 +96,25 @@ static int event_prepare(struct state *state)
 
 skip_tp_meter:
 
+	mcid = nl_get_multicast_id(state->sock, BATADV_NL_NAME,
+				   BATADV_NL_MCAST_GROUP_CONFIG);
+	if (mcid < 0) {
+		fprintf(stderr, "Failed to resolve batadv config multicast group: %d\n",
+			mcid);
+		/* ignore error for now */
+		goto skip_config;
+	}
+
+	ret = nl_socket_add_membership(state->sock, mcid);
+	if (ret) {
+		fprintf(stderr, "Failed to join batadv config multicast group: %d\n",
+			ret);
+		/* ignore error for now */
+		goto skip_config;
+	}
+
+skip_config:
+
 	return 0;
 }
 
@@ -145,6 +173,203 @@ static void event_parse_tp_meter(struct nlattr **attrs)
 	printf("tp_meter 0x%08x: %s\n", cookie, result_str);
 }
 
+static void event_parse_set_mesh(struct nlattr **attrs)
+{
+	static const int mesh_mandatory[] = {
+		BATADV_ATTR_MESH_IFINDEX,
+		BATADV_ATTR_ALGO_NAME,
+	};
+	char meshif_buf[IF_NAMESIZE];
+	char *meshif_name;
+	uint32_t mesh_ifindex;
+
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, mesh_mandatory,
+				    ARRAY_SIZE(mesh_mandatory)))
+		return;
+
+	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+	if (!meshif_name)
+		return;
+
+	printf("%s: set mesh:\n", meshif_name);
+
+	if (attrs[BATADV_ATTR_AGGREGATED_OGMS])
+		printf("* aggregated_ogms %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_AGGREGATED_OGMS]));
+
+	if (attrs[BATADV_ATTR_AP_ISOLATION])
+		printf("* ap_isolation %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_AP_ISOLATION]));
+
+	if (attrs[BATADV_ATTR_ISOLATION_MARK])
+		printf("* isolation_mark 0x%08x\n",
+		       nla_get_u32(attrs[BATADV_ATTR_ISOLATION_MARK]));
+
+	if (attrs[BATADV_ATTR_ISOLATION_MASK])
+		printf("* isolation_mask 0x%08x\n",
+		       nla_get_u32(attrs[BATADV_ATTR_ISOLATION_MASK]));
+
+	if (attrs[BATADV_ATTR_BONDING])
+		printf("* bonding %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_BONDING]));
+
+	if (attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE])
+		printf("* bridge_loop_avoidance %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE]));
+
+	if (attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE])
+		printf("* distributed_arp_table %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE]));
+
+	if (attrs[BATADV_ATTR_FRAGMENTATION])
+		printf("* fragmentation %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_FRAGMENTATION]));
+
+	if (attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {
+		uint32_t val;
+
+		val = nla_get_u32(attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]);
+		printf("* gw_bandwidth_down %u.%01u MBit/s\n", val / 10,
+		       val % 10);
+	}
+
+	if (attrs[BATADV_ATTR_GW_BANDWIDTH_UP]) {
+		uint32_t val;
+
+		val = nla_get_u32(attrs[BATADV_ATTR_GW_BANDWIDTH_UP]);
+		printf("* gw_bandwidth_up %u.%01u MBit/s\n", val / 10,
+		       val % 10);
+	}
+
+	if (attrs[BATADV_ATTR_GW_MODE]) {
+		uint8_t val = nla_get_u8(attrs[BATADV_ATTR_GW_MODE]);
+		const char *valstr;
+
+		switch (val) {
+		case BATADV_GW_MODE_OFF:
+			valstr = "off";
+			break;
+		case BATADV_GW_MODE_CLIENT:
+			valstr = "client";
+			break;
+		case BATADV_GW_MODE_SERVER:
+			valstr = "server";
+			break;
+		default:
+			valstr = "unknown";
+			break;
+		}
+
+		printf("* gw_mode %s\n", valstr);
+	}
+
+	if (attrs[BATADV_ATTR_GW_SEL_CLASS]) {
+		uint32_t val = nla_get_u32(attrs[BATADV_ATTR_GW_SEL_CLASS]);
+		const char *algo = nla_data(attrs[BATADV_ATTR_ALGO_NAME]);
+
+		if (strcmp(algo, "BATMAN_V") == 0)
+			printf("* gw_sel_class %u.%01u MBit/s\n", val / 10,
+			       val % 10);
+		else
+			printf("* gw_sel_class %u\n", val);
+	}
+
+	if (attrs[BATADV_ATTR_HOP_PENALTY])
+		printf("* hop_penalty %u\n",
+		       nla_get_u8(attrs[BATADV_ATTR_HOP_PENALTY]));
+
+	if (attrs[BATADV_ATTR_LOG_LEVEL])
+		printf("* log_level 0x%08x\n",
+		       nla_get_u32(attrs[BATADV_ATTR_LOG_LEVEL]));
+
+	if (attrs[BATADV_ATTR_MULTICAST_MODE])
+		printf("* multicast_mode %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_MULTICAST_MODE]));
+
+	if (attrs[BATADV_ATTR_NETWORK_CODING])
+		printf("* network_coding %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_NETWORK_CODING]));
+
+	if (attrs[BATADV_ATTR_ORIG_INTERVAL])
+		printf("* orig_interval %u ms\n",
+		       nla_get_u32(attrs[BATADV_ATTR_ORIG_INTERVAL]));
+}
+
+static void event_parse_set_hardif(struct nlattr **attrs)
+{
+	static const int hardif_mandatory[] = {
+		BATADV_ATTR_MESH_IFINDEX,
+		BATADV_ATTR_HARD_IFINDEX,
+	};
+	char meshif_buf[IF_NAMESIZE];
+	char hardif_buf[IF_NAMESIZE];
+	char *meshif_name;
+	char *hardif_name;
+	uint32_t hardif_ifindex;
+	uint32_t mesh_ifindex;
+
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, hardif_mandatory,
+				    ARRAY_SIZE(hardif_mandatory)))
+		return;
+
+	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+	if (!meshif_name)
+		return;
+
+	hardif_ifindex = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
+	hardif_name = if_indextoname(hardif_ifindex, hardif_buf);
+	if (!hardif_name)
+		return;
+
+	printf("%s (%s): set hardif:\n", meshif_name, hardif_name);
+
+	if (attrs[BATADV_ATTR_ELP_INTERVAL])
+		printf("* elp_interval %u ms\n",
+		       nla_get_u32(attrs[BATADV_ATTR_ELP_INTERVAL]));
+
+	if (attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {
+		uint32_t val;
+
+		val = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]);
+		printf("* throughput_override %u.%01u MBit/s\n", val / 10,
+		       val % 10);
+	}
+}
+
+static void event_parse_set_vlan(struct nlattr **attrs)
+{
+	static const int vlan_mandatory[] = {
+		BATADV_ATTR_MESH_IFINDEX,
+		BATADV_ATTR_VLANID,
+	};
+	char meshif_buf[IF_NAMESIZE];
+	char *meshif_name;
+	uint32_t mesh_ifindex;
+	uint16_t vid;
+
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, vlan_mandatory,
+				    ARRAY_SIZE(vlan_mandatory)))
+		return;
+
+	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+	if (!meshif_name)
+		return;
+
+	vid = nla_get_u16(attrs[BATADV_ATTR_VLANID]);
+
+	printf("%s (vid %u): set vlan:\n", meshif_name, vid);
+
+	if (attrs[BATADV_ATTR_AP_ISOLATION])
+		printf("* ap_isolation %s\n",
+		       u8_to_boolstr(attrs[BATADV_ATTR_AP_ISOLATION]));
+}
+
 static unsigned long long get_timestamp(struct event_args *event_args)
 {
 	unsigned long long prevtime = 0;
@@ -190,6 +415,15 @@ static int event_parse(struct nl_msg *msg, void *arg)
 	case BATADV_CMD_TP_METER:
 		event_parse_tp_meter(attrs);
 		break;
+	case BATADV_CMD_SET_MESH:
+		event_parse_set_mesh(attrs);
+		break;
+	case BATADV_CMD_SET_HARDIF:
+		event_parse_set_hardif(attrs);
+		break;
+	case BATADV_CMD_SET_VLAN:
+		event_parse_set_vlan(attrs);
+		break;
 	default:
 		printf("Received unknown event %u\n", ghdr->cmd);
 		break;
diff --git a/netlink.c b/netlink.c
index 5285759..1829544 100644
--- a/netlink.c
+++ b/netlink.c
@@ -107,6 +107,26 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
 	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
+	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_AGGREGATED_OGMS]		= { .type = NLA_U8 },
+	[BATADV_ATTR_AP_ISOLATION]		= { .type = NLA_U8 },
+	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BONDING]			= { .type = NLA_U8 },
+	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE]	= { .type = NLA_U8 },
+	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE]	= { .type = NLA_U8 },
+	[BATADV_ATTR_FRAGMENTATION]		= { .type = NLA_U8 },
+	[BATADV_ATTR_GW_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
+	[BATADV_ATTR_GW_BANDWIDTH_UP]		= { .type = NLA_U32 },
+	[BATADV_ATTR_GW_MODE]			= { .type = NLA_U8 },
+	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
+	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
+	[BATADV_ATTR_MULTICAST_MODE]		= { .type = NLA_U8 },
+	[BATADV_ATTR_NETWORK_CODING]		= { .type = NLA_U8 },
+	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
+	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
 };
 
 int netlink_create(struct state *state)
-- 
2.19.2

