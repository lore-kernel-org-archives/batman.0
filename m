Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2018 20:34:08 +0100
Message-Id: <20181104193408.18253-3-sven@narfation.org>
In-Reply-To: <20181104193408.18253-1-sven@narfation.org>
References: <20181104193408.18253-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 2/2] batctl: Add support for config mcast group
 in event monitor
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
 event.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/event.c b/event.c
index 8eda269..de5306f 100644
--- a/event.c
+++ b/event.c
@@ -22,6 +22,7 @@
 
 #include <errno.h>
 #include <getopt.h>
+#include <net/if.h>
 #include <netinet/if_ether.h>
 #include <netlink/netlink.h>
 #include <netlink/genl/genl.h>
@@ -87,6 +88,25 @@ static int event_prepare(struct state *state)
 
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
 
@@ -145,6 +165,81 @@ static void event_parse_tp_meter(struct nlattr **attrs)
 	printf("tp_meter 0x%08x: %s\n", cookie, result_str);
 }
 
+static const int option_mandatory[] = {
+	BATADV_ATTR_MESH_IFINDEX,
+	BATADV_ATTR_OPTION_NAME,
+	BATADV_ATTR_OPTION_TYPE,
+	/* BATADV_ATTR_OPTION_VALUE, */
+};
+
+static void event_parse_option(struct nlattr **attrs)
+{
+	char meshif_buf[IF_NAMESIZE];
+	char hardif_buf[IF_NAMESIZE];
+	char extra_info[256];
+	char *meshif_name;
+	char *hardif_name;
+	uint32_t hardif_ifindex;
+	uint32_t mesh_ifindex;
+	const char *name;
+	uint16_t vid;
+	uint8_t type;
+
+	/* ignore entry when attributes are missing */
+	if (missing_mandatory_attrs(attrs, option_mandatory,
+				    ARRAY_SIZE(option_mandatory)))
+		return;
+
+	mesh_ifindex = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+	meshif_name = if_indextoname(mesh_ifindex, meshif_buf);
+	if (!meshif_name)
+		return;
+
+	if (attrs[BATADV_ATTR_HARD_IFINDEX]) {
+		hardif_ifindex = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
+		hardif_name = if_indextoname(hardif_ifindex, hardif_buf);
+		if (!hardif_name)
+			return;
+
+		snprintf(extra_info, sizeof(extra_info), " (%s)", hardif_name);
+	} else if (attrs[BATADV_ATTR_VLANID]) {
+		vid = nla_get_u16(attrs[BATADV_ATTR_VLANID]);
+
+		snprintf(extra_info, sizeof(extra_info), " (vid %u)", vid);
+	} else {
+		extra_info[0] = '\0';
+	}
+
+	name = nla_get_string(attrs[BATADV_ATTR_OPTION_NAME]);
+	type = nla_get_u8(attrs[BATADV_ATTR_OPTION_TYPE]);
+
+	if (type != NLA_FLAG && !attrs[BATADV_ATTR_OPTION_VALUE])
+		return;
+
+	switch (type) {
+	case NLA_U8:
+		printf("%s%s: %s u8 %u\n", meshif_name, extra_info, name,
+		       nla_get_u8(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_U16:
+		printf("%s%s: %s u16 %u\n", meshif_name, extra_info, name,
+		       nla_get_u16(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_U32:
+		printf("%s%s: %s u32 %u\n", meshif_name, extra_info, name,
+		       nla_get_u32(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_NUL_STRING:
+		printf("%s%s: %s string %s\n", meshif_name, extra_info, name,
+		       nla_get_string(attrs[BATADV_ATTR_OPTION_VALUE]));
+		break;
+	case NLA_FLAG:
+		printf("%s%s: %s bool %s\n", meshif_name, extra_info, name,
+		       attrs[BATADV_ATTR_OPTION_VALUE] ? "true" : "false");
+		break;
+	}
+}
+
 static unsigned long long get_timestamp(struct event_args *event_args)
 {
 	unsigned long long prevtime = 0;
@@ -190,6 +285,11 @@ static int event_parse(struct nl_msg *msg, void *arg)
 	case BATADV_CMD_TP_METER:
 		event_parse_tp_meter(attrs);
 		break;
+	case BATADV_CMD_SET_OPTION:
+	case BATADV_CMD_SET_OPTION_HARDIF:
+	case BATADV_CMD_SET_OPTION_VLAN:
+		event_parse_option(attrs);
+		break;
 	default:
 		printf("Received unknown event %u\n", ghdr->cmd);
 		break;
-- 
2.19.1

