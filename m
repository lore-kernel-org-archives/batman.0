Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 11 May 2016 11:35:32 +0200
Message-Id: <1462959332-23410-4-git-send-email-sven@open-mesh.com>
In-Reply-To: <2757709.ryloMgzIDh@bentobox>
References: <2757709.ryloMgzIDh@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v8 2/2] batctl: introduce throughput meter
	support
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

From: Antonio Quartulli <antonio.quartulli@open-mesh.com>

Add command to launch the throughput meter test. The throughput meter is a
batman kernelspace tool for throughput measurements. The syntax is:

    batctl tp <MAC>

The test is interruptible with SIGINT or SIGTERM; if the test succeeds with
no error the throughput and the elapsed time are printed to stdout,
otherwise occurred an error message is displayed (on stdout) accordingly.

Based on a prototype from Edo Monticelli <montik@autistici.org>

Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v8:
 * rebase on current master
---
 Makefile     |   1 +
 batman_adv.h |  39 +++++
 main.c       |   6 +
 main.h       |   2 +
 man/batctl.8 |  24 ++-
 netlink.c    | 123 ++++++++++++++
 netlink.h    |   3 +
 packet.h     |  54 ++++++
 tcpdump.c    |  14 +-
 tp_meter.c   | 539 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tp_meter.h   |  22 +++
 11 files changed, 824 insertions(+), 3 deletions(-)
 create mode 100644 tp_meter.c
 create mode 100644 tp_meter.h

diff --git a/Makefile b/Makefile
index 3fa21f4..c8bec98 100755
--- a/Makefile
+++ b/Makefile
@@ -36,6 +36,7 @@ OBJ += netlink.o
 OBJ += ping.o
 OBJ += sys.o
 OBJ += tcpdump.o
+OBJ += tp_meter.o
 OBJ += traceroute.o
 OBJ += translate.o
 OBJ_BISECT = bisect_iv.o
diff --git a/batman_adv.h b/batman_adv.h
index a908140..5fc443f 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -20,6 +20,8 @@
 
 #define BATADV_NL_NAME "batadv"
 
+#define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
+
 /**
  * enum batadv_nl_attrs - batman-adv netlink attributes
  *
@@ -32,6 +34,11 @@
  * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
  * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
  * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
+ * @BATADV_ATTR_ORIG_ADDRESS: originator mac address
+ * @BATADV_ATTR_TPMETER_RESULT: result of run (see batadv_tp_meter_status)
+ * @BATADV_ATTR_TPMETER_TEST_TIME: time (msec) the run took
+ * @BATADV_ATTR_TPMETER_BYTES: amount of acked bytes during run
+ * @BATADV_ATTR_TPMETER_COOKIE: session cookie to match tp_meter session
  * @__BATADV_ATTR_AFTER_LAST: internal use
  * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
  * @BATADV_ATTR_MAX: highest attribute number currently defined
@@ -46,6 +53,11 @@ enum batadv_nl_attrs {
 	BATADV_ATTR_HARD_IFINDEX,
 	BATADV_ATTR_HARD_IFNAME,
 	BATADV_ATTR_HARD_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TPMETER_RESULT,
+	BATADV_ATTR_TPMETER_TEST_TIME,
+	BATADV_ATTR_TPMETER_BYTES,
+	BATADV_ATTR_TPMETER_COOKIE,
 	/* add attributes above here, update the policy in netlink.c */
 	__BATADV_ATTR_AFTER_LAST,
 	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
@@ -57,15 +69,42 @@ enum batadv_nl_attrs {
  *
  * @BATADV_CMD_UNSPEC: unspecified command to catch errors
  * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_TP_METER: Start a tp meter session
+ * @BATADV_CMD_TP_METER_CANCEL: Cancel a tp meter session
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
 enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
 	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_TP_METER,
+	BATADV_CMD_TP_METER_CANCEL,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
 };
 
+/**
+ * enum batadv_tp_meter_reason - reason of a a tp meter test run stop
+ * @BATADV_TP_COMPLETE: sender finished tp run
+ * @BATADV_TP_SIGINT: sender was stopped during run
+ * @BATADV_TP_DST_UNREACHABLE: receiver could not be reached or didn't answer
+ * @BATADV_TP_RESEND_LIMIT: (unused) sender retry reached limit
+ * @BATADV_TP_ALREADY_ONGOING: test to or from the same node already ongoing
+ * @BATADV_TP_MEMORY_ERROR: test was stopped due to low memory
+ * @BATADV_TP_CANT_SEND: failed to send via outgoing interface
+ * @BATADV_TP_TOO_MANY: too many ongoing sessions
+ */
+enum batadv_tp_meter_reason {
+	BATADV_TP_COMPLETE		= 3,
+	BATADV_TP_SIGINT		= 4,
+	/* error status >= 128 */
+	BATADV_TP_DST_UNREACHABLE	= 128,
+	BATADV_TP_RESEND_LIMIT		= 129,
+	BATADV_TP_ALREADY_ONGOING	= 130,
+	BATADV_TP_MEMORY_ERROR		= 131,
+	BATADV_TP_CANT_SEND		= 132,
+	BATADV_TP_TOO_MANY		= 133,
+};
+
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/main.c b/main.c
index a2cda5b..5e1ecc7 100644
--- a/main.c
+++ b/main.c
@@ -33,6 +33,7 @@
 #include "translate.h"
 #include "traceroute.h"
 #include "tcpdump.h"
+#include "tp_meter.h"
 #include "bisect_iv.h"
 #include "ioctl.h"
 #include "functions.h"
@@ -82,6 +83,7 @@ static void print_usage(void)
 	fprintf(stderr, " \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	fprintf(stderr, " \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	fprintf(stderr, " \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \tthroughputmeter|tp         <destination>     \tstart a throughput measurement\n");
 	fprintf(stderr, " \ttranslate|t                <destination>     \ttranslate a destination to the originator responsible for it\n");
 #ifdef BATCTL_BISECT
 	fprintf(stderr, " \tbisect_iv                  <file1> .. <fileN>\tanalyze given batman iv log files for routing stability\n");
@@ -162,6 +164,10 @@ int main(int argc, char **argv)
 
 		ret = ping(mesh_iface, argc - 1, argv + 1);
 
+	} else if ((strcmp(argv[1], "throughputmeter") == 0) || (strcmp(argv[1], "tp") == 0)) {
+
+		ret = tp_meter (mesh_iface, argc -1, argv + 1);
+
 	} else if ((strcmp(argv[1], "traceroute") == 0) || (strcmp(argv[1], "tr") == 0)) {
 
 		ret = traceroute(mesh_iface, argc - 1, argv + 1);
diff --git a/main.h b/main.h
index e94fc33..0e57f32 100644
--- a/main.h
+++ b/main.h
@@ -47,10 +47,12 @@
 #endif
 
 #define __packed __attribute((packed))   /* linux kernel compat */
+#define __unused __attribute__((unused))
 #define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
 
 typedef uint8_t u8; /* linux kernel compat */
 typedef uint16_t u16; /* linux kernel compat */
+typedef uint32_t u32; /* linux kernel compat */
 
 extern char module_ver_path[];
 
diff --git a/man/batctl.8 b/man/batctl.8
index e804a08..69a2537 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -36,9 +36,11 @@ B.A.T.M.A.N. advanced operates on layer 2. Thus all hosts participating in the v
 connected together for all protocols above layer 2. Therefore the common diagnosis tools do not work as expected. To
 overcome these problems batctl contains the commands \fBping\fP, \fBtraceroute\fP, \fBtcpdump\fP which provide similar
 functionality to the normal \fBping\fP(1), \fBtraceroute\fP(1), \fBtcpdump\fP(1) commands, but modified to layer 2
-behaviour or using the B.A.T.M.A.N. advanced protocol.
-.PP
+behaviour or using the B.A.T.M.A.N. advanced protocol. For similar reasons, \fBthroughputmeter\fP, a command to test network
+performances, is also included.
+
 .PP
+.Pp
 .SH OPTIONS
 .TP
 .I \fBoptions:
@@ -319,6 +321,24 @@ for routing loops. Use "\-t" to trace OGMs of a host throughout the network. Use
 nodes. The option "\-s" can be used to limit the output to a range of sequence numbers, between min and max, or to one
 specific sequence number, min. Furthermore using "\-o" you can filter the output to a specified originator. If "\-n" is
 given batctl will not replace the MAC addresses with bat\-host names in the output.
+.RE
+.br
+.IP "\fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP"
+This command starts a throughput test entirely controlled by batman module in
+kernel space: the computational resources needed to align memory and copy data
+between user and kernel space that are required by other user space tools may
+represent a bootleneck on some low profile device.
+
+The test consist of the transfer of 14 MB of data between the two nodes. The
+protocol used to transfer the data is somehow similar to TCP, but simpler: some
+TCP features are still missing, thus protocol performances could be worst. Since
+a fixed amount of data is transferred the experiment duration depends on the
+network conditions. The experiment can be interrupted with CTRL + C. At the end
+of a succesful experiment the throughput in KBytes per second is returned,
+togheter with the experiment duration in millisecond and the amount of bytes
+transferred. If too many packets are lost or the specified MAC address is not
+reachable, a message notifing the error is returned instead of the result.
+.RE
 .br
 .SH FILES
 .TP
diff --git a/netlink.c b/netlink.c
index 74d7566..b4c26b4 100644
--- a/netlink.c
+++ b/netlink.c
@@ -22,7 +22,14 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <errno.h>
 #include <net/ethernet.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include <linux/genetlink.h>
 
 #include "batman_adv.h"
 
@@ -41,4 +48,120 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_HARD_ADDRESS]	= { .type = NLA_UNSPEC,
 					    .minlen = ETH_ALEN,
 					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_ORIG_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_TPMETER_RESULT]	= { .type = NLA_U8 },
+	[BATADV_ATTR_TPMETER_TEST_TIME]	= { .type = NLA_U32 },
+	[BATADV_ATTR_TPMETER_BYTES]	= { .type = NLA_U64 },
+	[BATADV_ATTR_TPMETER_COOKIE]	= { .type = NLA_U32 },
+};
+
+/*
+ * This ought to be provided by libnl - but was borrowed from iw/genl.c
+ */
+
+static int mcast_error_handler(struct sockaddr_nl *nla __unused,
+			       struct nlmsgerr *err, void *arg)
+{
+	int *ret = arg;
+	*ret = err->error;
+	return NL_STOP;
+}
+
+static int mcast_ack_handler(struct nl_msg *msg __unused, void *arg)
+{
+	int *ret = arg;
+	*ret = 0;
+	return NL_STOP;
+}
+
+struct mcast_handler_args {
+	const char *group;
+	int id;
 };
+
+static int mcast_family_handler(struct nl_msg *msg, void *arg)
+{
+	struct mcast_handler_args *grp = arg;
+	struct nlattr *tb[CTRL_ATTR_MAX + 1];
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *mcgrp;
+	int rem_mcgrp;
+
+	nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!tb[CTRL_ATTR_MCAST_GROUPS])
+		return NL_SKIP;
+
+	nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp) {
+		struct nlattr *tb_mcgrp[CTRL_ATTR_MCAST_GRP_MAX + 1];
+
+		nla_parse(tb_mcgrp, CTRL_ATTR_MCAST_GRP_MAX,
+			  nla_data(mcgrp), nla_len(mcgrp), NULL);
+
+		if (!tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME] ||
+		    !tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID])
+			continue;
+		if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),
+			    grp->group, nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])))
+			continue;
+		grp->id = nla_get_u32(tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID]);
+		break;
+	}
+
+	return NL_SKIP;
+}
+
+int nl_get_multicast_id(struct nl_sock *sock, const char *family,
+			const char *group)
+{
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret, ctrlid;
+	struct mcast_handler_args grp = {
+		.group = group,
+		.id = -ENOENT,
+	};
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return -ENOMEM;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		ret = -ENOMEM;
+		goto out_fail_cb;
+	}
+
+	ctrlid = genl_ctrl_resolve(sock, "nlctrl");
+
+	genlmsg_put(msg, 0, 0, ctrlid, 0,
+		    0, CTRL_CMD_GETFAMILY, 0);
+
+	ret = -ENOBUFS;
+	NLA_PUT_STRING(msg, CTRL_ATTR_FAMILY_NAME, family);
+
+	ret = nl_send_auto_complete(sock, msg);
+	if (ret < 0)
+		goto out;
+
+	ret = 1;
+
+	nl_cb_err(cb, NL_CB_CUSTOM, mcast_error_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, mcast_ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, mcast_family_handler, &grp);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+
+	if (ret == 0)
+		ret = grp.id;
+ nla_put_failure:
+ out:
+	nl_cb_put(cb);
+ out_fail_cb:
+	nlmsg_free(msg);
+	return ret;
+}
diff --git a/netlink.h b/netlink.h
index 0a4d3dd..f24ab5c 100644
--- a/netlink.h
+++ b/netlink.h
@@ -27,4 +27,7 @@
 
 extern struct nla_policy batadv_netlink_policy[];
 
+int nl_get_multicast_id(struct nl_sock *sock, const char *family,
+			const char *group);
+
 #endif /* _BATCTL_NETLINK_H */
diff --git a/packet.h b/packet.h
index 372128d..2df2c39 100644
--- a/packet.h
+++ b/packet.h
@@ -21,6 +21,8 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 
+#define batadv_tp_is_error(n) ((u8)n > 127 ? 1 : 0)
+
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
  * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
@@ -93,6 +95,7 @@ enum batadv_icmp_packettype {
 	BATADV_ECHO_REQUEST	       = 8,
 	BATADV_TTL_EXCEEDED	       = 11,
 	BATADV_PARAMETER_PROBLEM       = 12,
+	BATADV_TP		       = 15,
 };
 
 /**
@@ -285,6 +288,16 @@ struct batadv_elp_packet {
 #define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
 
 /**
+ * enum batadv_icmp_user_cmd_type - types for batman-adv icmp cmd modes
+ * @BATADV_TP_START: start a throughput meter run
+ * @BATADV_TP_STOP: stop a throughput meter run
+ */
+enum batadv_icmp_user_cmd_type {
+	BATADV_TP_START		= 0,
+	BATADV_TP_STOP		= 2,
+};
+
+/**
  * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
@@ -334,6 +347,47 @@ struct batadv_icmp_packet {
 	__be16 seqno;
 };
 
+/**
+ * struct batadv_icmp_tp_packet - ICMP TP Meter packet
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the genereal header
+ * @ttl: time to live for this packet, part of the genereal header
+ * @msg_type: ICMP packet type
+ * @dst: address of the destination node
+ * @orig: address of the source node
+ * @uid: local ICMP socket identifier
+ * @subtype: TP packet subtype (see batadv_icmp_tp_subtype)
+ * @session: TP session identifier
+ * @seqno: the TP sequence number
+ * @timestamp: time when the packet has been sent. This value is filled in a
+ *  TP_MSG and echoed back in the next TP_ACK so that the sender can compute the
+ *  RTT. Since it is read only by the host which wrote it, there is no need to
+ *  store it using network order
+ */
+struct batadv_icmp_tp_packet {
+	u8  packet_type;
+	u8  version;
+	u8  ttl;
+	u8  msg_type; /* see ICMP message types above */
+	u8  dst[ETH_ALEN];
+	u8  orig[ETH_ALEN];
+	u8  uid;
+	u8  subtype;
+	u8  session[2];
+	__be32 seqno;
+	__be32 timestamp;
+};
+
+/**
+ * enum batadv_icmp_tp_subtype - ICMP TP Meter packet subtypes
+ * @BATADV_TP_MSG: Msg from sender to receiver
+ * @BATADV_TP_ACK: acknowledgment from receiver to sender
+ */
+enum batadv_icmp_tp_subtype {
+	BATADV_TP_MSG	= 0,
+	BATADV_TP_ACK,
+};
+
 #define BATADV_RR_LEN 16
 
 /**
diff --git a/tcpdump.c b/tcpdump.c
index 363e9e4..be0c4f0 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -808,11 +808,14 @@ static void dump_batman_elp(unsigned char *packet_buff, ssize_t buff_len,
 static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct batadv_icmp_packet *icmp_packet;
+	struct batadv_icmp_tp_packet *tp;
+
 	char *name;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_icmp_packet), "BAT ICMP");
 
 	icmp_packet = (struct batadv_icmp_packet *)(packet_buff + sizeof(struct ether_header));
+	tp = (struct batadv_icmp_tp_packet *)icmp_packet;
 
 	if (!time_printed)
 		print_time();
@@ -820,7 +823,8 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)icmp_packet->orig, read_opt));
 
-	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst, read_opt);
+	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst,
+				    read_opt);
 
 	switch (icmp_packet->msg_type) {
 	case BATADV_ECHO_REPLY:
@@ -841,6 +845,14 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 			icmp_packet->ttl, icmp_packet->version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
+	case BATADV_TP:
+		printf("%s: ICMP TP type %s (%hhu), id %hhu, seq %u, ttl %2d, v %d, length %zu\n",
+		       name, tp->subtype == BATADV_TP_MSG ? "MSG" :
+			     tp->subtype == BATADV_TP_ACK ? "ACK" : "N/A",
+		       tp->subtype, tp->uid, ntohl(tp->seqno), tp->ttl,
+		       tp->version,
+		       (size_t)buff_len - sizeof(struct ether_header));
+		break;
 	default:
 		printf("%s: ICMP type %hhu, length %zu\n",
 			name, icmp_packet->msg_type,
diff --git a/tp_meter.c b/tp_meter.c
new file mode 100644
index 0000000..fd67723
--- /dev/null
+++ b/tp_meter.c
@@ -0,0 +1,539 @@
+/*
+ * Copyright (C) 2013-2016 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli <a@unstable.cc>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "tp_meter.h"
+
+#include <netinet/ether.h>
+#include <netinet/in.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <net/if.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "bat-hosts.h"
+#include "batman_adv.h"
+#include "functions.h"
+#include "netlink.h"
+#include "packet.h"
+#include "debugfs.h"
+
+static struct ether_addr *dst_mac;
+static char *tp_mesh_iface;
+
+struct tp_result {
+	int error;
+	bool found;
+	uint32_t cookie;
+	uint8_t return_value;
+	uint32_t test_time;
+	uint64_t total_bytes;
+};
+
+struct tp_cookie {
+	int error;
+	bool found;
+	uint32_t cookie;
+};
+
+static int tpmeter_nl_print_error(struct sockaddr_nl *nla __unused,
+				  struct nlmsgerr *nlerr,
+				  void *arg)
+{
+	struct tp_result *result = arg;
+
+	if (nlerr->error != -EOPNOTSUPP)
+		fprintf(stderr, "Error received: %s\n",
+			strerror(-nlerr->error));
+
+	result->error = nlerr->error;
+
+	return NL_STOP;
+}
+
+static int tp_meter_result_callback(struct nl_msg *msg, void *arg)
+{
+	struct tp_result *result = arg;
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlattr *attrs[NUM_BATADV_ATTR];
+	struct genlmsghdr *ghdr;
+	uint32_t cookie;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		result->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	ghdr = nlmsg_data(nlh);
+	if (ghdr->cmd != BATADV_CMD_TP_METER)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		result->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	if (!attrs[BATADV_ATTR_TPMETER_COOKIE]) {
+		result->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	if (!attrs[BATADV_ATTR_TPMETER_RESULT])
+		return NL_OK;
+
+	cookie = nla_get_u32(attrs[BATADV_ATTR_TPMETER_COOKIE]);
+	if (cookie != result->cookie)
+		return NL_OK;
+
+	result->found = true;
+
+	result->return_value = nla_get_u8(attrs[BATADV_ATTR_TPMETER_RESULT]);
+
+	if (attrs[BATADV_ATTR_TPMETER_TEST_TIME])
+		result->test_time = nla_get_u32(attrs[BATADV_ATTR_TPMETER_TEST_TIME]);
+
+	if (attrs[BATADV_ATTR_TPMETER_BYTES])
+		result->total_bytes = nla_get_u64(attrs[BATADV_ATTR_TPMETER_BYTES]);
+
+	return NL_OK;
+}
+
+static int tp_meter_cookie_callback(struct nl_msg *msg, void *arg)
+{
+	struct tp_cookie *cookie = arg;
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlattr *attrs[NUM_BATADV_ATTR];
+	struct genlmsghdr *ghdr;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		cookie->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	ghdr = nlmsg_data(nlh);
+	if (ghdr->cmd != BATADV_CMD_TP_METER) {
+		cookie->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		cookie->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	if (!attrs[BATADV_ATTR_TPMETER_COOKIE]) {
+		cookie->error = -EINVAL;
+		return NL_STOP;
+	}
+
+	cookie->cookie = nla_get_u32(attrs[BATADV_ATTR_TPMETER_COOKIE]);
+	cookie->found = true;
+
+	return NL_OK;
+}
+
+static int tp_meter_start(char *mesh_iface, struct ether_addr *dst_mac,
+			  uint32_t time, struct tp_cookie *cookie)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ifindex;
+	int family;
+	int ret;
+	int err = 0;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
+	ret = genl_connect(sock);
+	if (ret < 0) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		err = -ENODEV;
+		goto out;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, tp_meter_cookie_callback,
+		  cookie);
+	nl_cb_err(cb, NL_CB_CUSTOM, tpmeter_nl_print_error, cookie);
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
+		    0, BATADV_CMD_TP_METER, 1);
+
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN, dst_mac);
+	nla_put_u32(msg, BATADV_ATTR_TPMETER_TEST_TIME, time);
+
+	nl_send_auto_complete(sock, msg);
+	nlmsg_free(msg);
+
+	nl_recvmsgs(sock, cb);
+
+	nl_cb_put(cb);
+
+	if (cookie->error < 0)
+		err = cookie->error;
+	else if (!cookie->found)
+		err= -EINVAL;
+
+out:
+	nl_socket_free(sock);
+
+	return err;
+}
+
+static int no_seq_check(struct nl_msg *msg __unused, void *arg __unused)
+{
+	return NL_OK;
+}
+
+static int tp_recv_result(struct nl_sock *sock, struct tp_result *result)
+{
+	int err = 0;
+	struct nl_cb *cb;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM, no_seq_check, NULL);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, tp_meter_result_callback,
+		  result);
+	nl_cb_err(cb, NL_CB_CUSTOM, tpmeter_nl_print_error, result);
+
+	while (result->error == 0 && !result->found)
+		nl_recvmsgs(sock, cb);
+
+	nl_cb_put(cb);
+
+	if (result->error < 0)
+		err = result->error;
+	else if (!result->found)
+		err= -EINVAL;
+
+	return err;
+}
+
+static int tp_meter_stop(char *mesh_iface, struct ether_addr *dst_mac)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	int ifindex;
+	int family;
+	int ret;
+	int err = 0;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
+	ret = genl_connect(sock);
+	if (ret < 0) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		err = -ENODEV;
+		goto out;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
+		    0, BATADV_CMD_TP_METER_CANCEL, 1);
+
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN, dst_mac);
+
+	nl_send_auto_complete(sock, msg);
+	nlmsg_free(msg);
+
+out:
+	nl_socket_free(sock);
+
+	return err;
+}
+
+static struct nl_sock *tp_prepare_listening_sock(void)
+{
+	struct nl_sock *sock;
+	int family;
+	int ret;
+	int mcid;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return NULL;
+
+	ret = genl_connect(sock);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to connect to generic netlink: %d\n",
+			ret);
+		goto err;
+	}
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0) {
+		fprintf(stderr, "Failed to resolve batman-adv netlink: %d\n",
+			family);
+		goto err;
+	}
+
+	mcid = nl_get_multicast_id(sock, BATADV_NL_NAME,
+				   BATADV_NL_MCAST_GROUP_TPMETER);
+	if (mcid < 0) {
+		fprintf(stderr, "Failed to resolve batman-adv tpmeter multicast group: %d\n",
+			mcid);
+		goto err;
+	}
+
+	ret = nl_socket_add_membership(sock, mcid);
+	if (ret) {
+		fprintf(stderr, "Failed to join batman-adv tpmeter multicast group: %d\n",
+			ret);
+		goto err;
+	}
+
+	return sock;
+
+err:
+	nl_socket_free(sock);
+
+	return NULL;
+}
+
+void tp_sig_handler(int sig)
+{
+	switch (sig) {
+	case SIGINT:
+	case SIGTERM:
+		fflush(stdout);
+		tp_meter_stop(tp_mesh_iface, dst_mac);
+		break;
+	default:
+		break;
+	}
+}
+
+static void tp_meter_usage(void)
+{
+	fprintf(stderr, "Usage: batctl tp [parameters] <MAC>\n");
+	fprintf(stderr, "Parameters:\n");
+	fprintf(stderr, "\t -t <time> test length in milliseconds\n");
+	fprintf(stderr, "\t -n don't convert addresses to bat-host names\n");
+}
+
+int tp_meter(char *mesh_iface, int argc, char **argv)
+{
+	struct bat_host *bat_host;
+	uint64_t throughput;
+	char *dst_string;
+	int ret = EXIT_FAILURE;
+	int found_args = 1, read_opt = USE_BAT_HOSTS;
+	uint32_t time = 0;
+	char optchar;
+	struct nl_sock *listen_sock = NULL;
+	struct tp_result result = {
+		.error = 0,
+		.return_value = 0,
+		.test_time = 0,
+		.total_bytes =  0,
+		.found = false,
+	};
+	struct tp_cookie cookie = {
+		.error = 0,
+		.cookie = 0,
+		.found = false,
+	};
+
+	while ((optchar = getopt(argc, argv, "t:n")) != -1) {
+		switch (optchar) {
+		case 't':
+			found_args += 2;
+			time = strtoul(optarg, NULL, 10);
+			break;
+		case 'n':
+			read_opt &= ~USE_BAT_HOSTS;
+			found_args += 1;
+			break;
+		default:
+			tp_meter_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (argc <= found_args) {
+		tp_meter_usage();
+		return EXIT_FAILURE;
+	}
+
+	dst_string = argv[found_args];
+	bat_hosts_init(read_opt);
+	bat_host = bat_hosts_find_by_name(dst_string);
+
+	if (bat_host)
+		dst_mac = &bat_host->mac_addr;
+
+	if (!dst_mac) {
+		dst_mac = ether_aton(dst_string);
+
+		if (!dst_mac) {
+			printf("Error - the tp meter destination is not a mac address or bat-host name: %s\n",
+			       dst_string);
+			goto out;
+		}
+	}
+
+
+	if (bat_host && (read_opt & USE_BAT_HOSTS))
+		dst_string = bat_host->name;
+	else
+		dst_string = ether_ntoa_long(dst_mac);
+
+	/* for sighandler */
+	tp_mesh_iface = mesh_iface;
+	signal(SIGINT, tp_sig_handler);
+	signal(SIGTERM, tp_sig_handler);
+
+	listen_sock = tp_prepare_listening_sock();
+	if (!listen_sock)
+		goto out;
+
+	ret = tp_meter_start(mesh_iface, dst_mac, time, &cookie);
+	if (ret < 0) {
+		printf("Failed to send tp_meter request to kernel: %d\n", ret);
+		goto out;
+	}
+
+	result.cookie = cookie.cookie;
+	ret = tp_recv_result(listen_sock, &result);
+	if (ret < 0) {
+		printf("Failed to recv tp_meter result from kernel: %d\n", ret);
+		goto out;
+	}
+
+	switch (result.return_value) {
+	case BATADV_TP_DST_UNREACHABLE:
+		fprintf(stderr, "Destination unreachable\n");
+		break;
+	case BATADV_TP_RESEND_LIMIT:
+		fprintf(stderr,
+			"The number of retry for the same window exceeds the limit, test aborted\n");
+		break;
+	case BATADV_TP_ALREADY_ONGOING:
+		fprintf(stderr,
+			"Cannot run two test towards the same node\n");
+		break;
+	case BATADV_TP_MEMORY_ERROR:
+		fprintf(stderr,
+			"Kernel cannot allocate memory, aborted\n");
+		break;
+	case BATADV_TP_TOO_MANY:
+		fprintf(stderr, "Too many ongoing sessions\n");
+		break;
+	case BATADV_TP_SIGINT:
+		printf("SIGINT received: test aborted\n");
+		/* fall through and print the partial result */
+	case BATADV_TP_COMPLETE:
+		if (result.test_time > 0) {
+			throughput = result.total_bytes * 1000;
+			throughput /= result.test_time;
+		} else {
+			throughput = UINT64_MAX;
+		}
+
+		printf("Test duration %ums.\n", result.test_time);
+		printf("Sent %" PRIu64 " Bytes.\n", result.total_bytes);
+		printf("Throughput: ");
+		if (throughput == UINT64_MAX)
+			printf("inf\n");
+		else if (throughput > (1UL<<30))
+			printf("%.2f GB/s (%2.f Gbps)\n",
+				(float)throughput / (1<<30),
+				(float)throughput * 8 / 1000000000);
+		else if (throughput > (1UL<<20))
+			printf("%.2f MB/s (%.2f Mbps)\n",
+				(float)throughput / (1<<20),
+				(float)throughput * 8 / 1000000);
+		else if (throughput > (1UL<<10))
+			printf("%.2f KB/s (%.2f Kbps)\n",
+				(float)throughput / (1<<10),
+				(float)throughput * 8 / 1000);
+		else
+			printf("%lu Bytes/s (%lu Bps)\n",
+				throughput, throughput * 8);
+
+		ret = 0;
+		break;
+	default:
+		printf("Unrecognized return value %d\n", result.return_value);
+	}
+
+out:
+	nl_socket_free(listen_sock);
+	bat_hosts_free();
+	return ret;
+}
diff --git a/tp_meter.h b/tp_meter.h
new file mode 100644
index 0000000..59bca07
--- /dev/null
+++ b/tp_meter.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2013-2016 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli <a@unstable.cc>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+int tp_meter(char *mesh_iface, int argc, char **argv);
-- 
2.8.1

