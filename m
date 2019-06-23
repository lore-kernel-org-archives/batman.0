Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 5/6] batctl: Replace '-m meshif' option with selector prefix
Date: Sun, 23 Jun 2019 15:07:08 +0200
Message-Id: <20190623130709.24751-6-sven@narfation.org>
In-Reply-To: <20190623130709.24751-1-sven@narfation.org>
References: <20190623130709.24751-1-sven@narfation.org>
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

The '-m meshif' option doesn't follow the prefix style which is used for
VLANs/hard interfaces. It is also not clear for a user which command
understands the '-m' option and which is actually operating on a
global/non-meshif specific scope. To clean this up, an additional command
prefix called meshif is implemented:

  $ batctl meshif bat0 ...

Alternative form is to use the prefix selector "dev"

  $ batctl dev bat0 ...

This can be omitted when it would be "meshif bat0". And when it is
specified, all non-meshif specific subcommands will be rejected.

The old option '-m meshif' option is still available to avoid breaking
existing scripts. It will will show an error message but continues to work
for now. Users of batctl should still transition to the new format.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 aggregation.c           |  2 +-
 ap_isolation.c          |  2 +-
 bonding.c               |  2 +-
 bridge_loop_avoidance.c |  2 +-
 distributed_arp_table.c |  2 +-
 fragmentation.c         |  2 +-
 gw_mode.c               |  2 +-
 hop_penalty.c           |  2 +-
 interface.c             |  2 +-
 isolation_mark.c        |  2 +-
 loglevel.c              |  2 +-
 main.c                  | 34 +++++++++++++++++++++++++------
 main.h                  |  2 ++
 man/batctl.8            | 44 ++++++++++++++++++++---------------------
 multicast_fanout.c      |  2 +-
 multicast_forceflood.c  |  2 +-
 multicast_mode.c        |  2 +-
 network_coding.c        |  2 +-
 orig_interval.c         |  2 +-
 ping.c                  |  2 +-
 statistics.c            |  2 +-
 sys.c                   | 10 +++++++++-
 throughputmeter.c       |  2 +-
 traceroute.c            |  2 +-
 translate.c             |  2 +-
 25 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 18e19d8..b9edd94 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -55,7 +55,7 @@ static struct settings_data batctl_settings_aggregation = {
 	.netlink_set = set_aggregated_ogms,
 };
 
-COMMAND_NAMED(SUBCOMMAND, aggregation, "ag", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, aggregation, "ag", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_aggregation,
 	      "[0|1]             \tdisplay or modify aggregation setting");
diff --git a/ap_isolation.c b/ap_isolation.c
index 36fd4d6..66f8340 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -77,7 +77,7 @@ static struct settings_data batctl_settings_ap_isolation = {
 	.netlink_set = set_ap_isolation,
 };
 
-COMMAND_NAMED(SUBCOMMAND, ap_isolation, "ap", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, ap_isolation, "ap", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_ap_isolation,
 	      "[0|1]             \tdisplay or modify ap_isolation setting");
diff --git a/bonding.c b/bonding.c
index fd95e8d..e41379c 100644
--- a/bonding.c
+++ b/bonding.c
@@ -54,7 +54,7 @@ static struct settings_data batctl_settings_bonding = {
 	.netlink_set = set_bonding,
 };
 
-COMMAND_NAMED(SUBCOMMAND, bonding, "b", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, bonding, "b", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_bonding,
 	      "[0|1]             \tdisplay or modify bonding setting");
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 37acaa7..2994d2e 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -55,7 +55,7 @@ static struct settings_data batctl_settings_bridge_loop_avoidance = {
 	.netlink_set = set_bridge_loop_avoidance,
 };
 
-COMMAND_NAMED(SUBCOMMAND, bridge_loop_avoidance, "bl", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, bridge_loop_avoidance, "bl", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_bridge_loop_avoidance,
 	      "[0|1]             \tdisplay or modify bridge_loop_avoidance setting");
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index cbfb296..ad88d43 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -55,7 +55,7 @@ static struct settings_data batctl_settings_distributed_arp_table = {
 	.netlink_set = set_distributed_arp_table,
 };
 
-COMMAND_NAMED(SUBCOMMAND, distributed_arp_table, "dat", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, distributed_arp_table, "dat", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_distributed_arp_table,
 	      "[0|1]             \tdisplay or modify distributed_arp_table setting");
diff --git a/fragmentation.c b/fragmentation.c
index d4b0f54..eea2a08 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -55,7 +55,7 @@ static struct settings_data batctl_settings_fragmentation = {
 	.netlink_set = set_fragmentation,
 };
 
-COMMAND_NAMED(SUBCOMMAND, fragmentation, "f", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, fragmentation, "f", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_fragmentation,
 	      "[0|1]             \tdisplay or modify fragmentation setting");
diff --git a/gw_mode.c b/gw_mode.c
index 7c17bee..97ea65f 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -392,6 +392,6 @@ static int gw_mode(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND(SUBCOMMAND, gw_mode, "gw",
+COMMAND(SUBCOMMAND_MIF, gw_mode, "gw",
 	COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK, NULL,
 	"[mode]            \tdisplay or modify the gateway mode");
diff --git a/hop_penalty.c b/hop_penalty.c
index 56e1168..5cfb51a 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -95,7 +95,7 @@ static struct settings_data batctl_settings_hop_penalty = {
 	.netlink_set = set_hop_penalty,
 };
 
-COMMAND_NAMED(SUBCOMMAND, hop_penalty, "hp", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, hop_penalty, "hp", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_hop_penalty,
 	      "[penalty]         \tdisplay or modify hop_penalty setting");
diff --git a/interface.c b/interface.c
index 5ff25a7..19e6670 100644
--- a/interface.c
+++ b/interface.c
@@ -534,5 +534,5 @@ static int interface(struct state *state, int argc, char **argv)
 	return EXIT_FAILURE;
 }
 
-COMMAND(SUBCOMMAND, interface, "if", 0, NULL,
+COMMAND(SUBCOMMAND_MIF, interface, "if", 0, NULL,
 	"[add|del iface(s)]\tdisplay or modify the interface settings");
diff --git a/isolation_mark.c b/isolation_mark.c
index 3686317..340f33d 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -134,7 +134,7 @@ static struct settings_data batctl_settings_isolation_mark = {
 	.netlink_set = set_isolation_mark,
 };
 
-COMMAND_NAMED(SUBCOMMAND, isolation_mark, "mark", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, isolation_mark, "mark", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_isolation_mark,
 	      "[mark]            \tdisplay or modify isolation_mark setting");
diff --git a/loglevel.c b/loglevel.c
index aff8b82..2e07edc 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -212,6 +212,6 @@ static int loglevel(struct state *state, int argc, char **argv)
 	return res;
 }
 
-COMMAND(SUBCOMMAND, loglevel, "ll",
+COMMAND(SUBCOMMAND_MIF, loglevel, "ll",
 	COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK, NULL,
 	"[level]           \tdisplay or modify the log level");
diff --git a/main.c b/main.c
index f81109b..eddc2ad 100644
--- a/main.c
+++ b/main.c
@@ -35,6 +35,7 @@ static void print_usage(void)
 		{
 			.label = "commands:\n",
 			.types = BIT(SUBCOMMAND) |
+				 BIT(SUBCOMMAND_MIF) |
 				 BIT(SUBCOMMAND_VID) |
 				 BIT(SUBCOMMAND_HIF),
 		},
@@ -47,9 +48,13 @@ static void print_usage(void)
 		"",
 		NULL,
 	};
+	const char *meshif_prefixes[] = {
+		"meshif <netdev> ",
+		NULL,
+	};
 	const char *vlan_prefixes[] = {
 		"vlan <vdev> ",
-		"vid <vid> ",
+		"meshif <netdev> vid <vid> ",
 		NULL,
 	};
 	const char *hardif_prefixes[] = {
@@ -64,7 +69,6 @@ static void print_usage(void)
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t-m mesh interface (default 'bat0')\n");
 	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
 
@@ -83,6 +87,10 @@ static void print_usage(void)
 				continue;
 
 			switch (cmd->type) {
+			case DEBUGTABLE:
+			case SUBCOMMAND_MIF:
+				prefixes = meshif_prefixes;
+				break;
 			case SUBCOMMAND_VID:
 				prefixes = vlan_prefixes;
 				break;
@@ -102,7 +110,7 @@ static void print_usage(void)
 					snprintf(buf, sizeof(buf), "%s%s|%s",
 						 *prefix, cmd->name, cmd->abbr);
 
-				fprintf(stderr, " \t%-35s%s\n", buf,
+				fprintf(stderr, " \t%-43s%s\n", buf,
 					cmd->usage);
 			}
 		}
@@ -155,8 +163,11 @@ static const struct command *find_command(struct state *state, const char *name)
 
 	switch (state->selector) {
 	case SP_NONE_OR_MESHIF:
-		types = BIT(SUBCOMMAND) |
-			BIT(DEBUGTABLE);
+		types = BIT(SUBCOMMAND);
+		/* fall through */
+	case SP_MESHIF:
+		types |= BIT(SUBCOMMAND_MIF) |
+			 BIT(DEBUGTABLE);
 		break;
 	case SP_VLAN:
 		types = BIT(SUBCOMMAND_VID);
@@ -179,7 +190,11 @@ static int detect_selector_prefix(int argc, char *argv[],
 		return -EINVAL;
 
 	/* only detect selector prefix which identifies meshif */
-	if (strcmp(argv[0], "vlan") == 0) {
+	if (strcmp(argv[0], "meshif") == 0 ||
+	    strcmp(argv[0], "dev") == 0) {
+		*selector = SP_MESHIF;
+		return 2;
+	} else if (strcmp(argv[0], "vlan") == 0) {
 		*selector = SP_VLAN;
 		return 2;
 	} else if (strcmp(argv[0], "hardif") == 0 ||
@@ -205,6 +220,11 @@ static int parse_meshif_args(struct state *state, int argc, char *argv[])
 	dev_arg = argv[parsed_args - 1];
 
 	switch (selector) {
+	case SP_MESHIF:
+		snprintf(state->mesh_iface, sizeof(state->mesh_iface), "%s",
+			 dev_arg);
+		state->selector = SP_MESHIF;
+		return parsed_args;
 	case SP_VLAN:
 		ret = translate_vlan_iface(state, dev_arg);
 		if (ret < 0) {
@@ -253,6 +273,7 @@ static int parse_dev_args(struct state *state, int argc, char *argv[])
 
 	switch (state->selector) {
 	case SP_NONE_OR_MESHIF:
+	case SP_MESHIF:
 		/* continue below */
 		break;
 	default:
@@ -298,6 +319,7 @@ int main(int argc, char **argv)
 					"Error - multiple mesh interfaces specified\n");
 				goto err;
 			}
+			fprintf(stderr, "Warning - option -m was deprecated in will be removed in the future\n");
 
 			state.arg_iface = argv[2];
 			break;
diff --git a/main.h b/main.h
index e3a95b5..8532bd1 100644
--- a/main.h
+++ b/main.h
@@ -58,12 +58,14 @@ enum command_flags {
 
 enum selector_prefix {
 	SP_NONE_OR_MESHIF,
+	SP_MESHIF,
 	SP_VLAN,
 	SP_HARDIF,
 };
 
 enum command_type {
 	SUBCOMMAND,
+	SUBCOMMAND_MIF,
 	SUBCOMMAND_VID,
 	SUBCOMMAND_HIF,
 	DEBUGTABLE,
diff --git a/man/batctl.8 b/man/batctl.8
index d42b682..6e75cdd 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -54,42 +54,42 @@ performances, is also included.
 .br
 .TP
 .I \fBcommands:
-.IP "\fBinterface\fP|\fBif\fP [\fB-M\fP] [\fBadd\fP|\fBdel iface(s)\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fB-M\fP] [\fBadd\fP|\fBdel iface(s)\fP]"
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
 In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
 add or delete. Multiple interfaces can be specified.
 The "\-M" option tells batctl to not automatically create the batman-adv interface on "add" or to destroy it when "del"
 removed all interfaces which belonged to it.
-.IP "\fBinterface\fP|\fBif\fP [\fBcreate\fP|\fBdestroy\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fBcreate\fP|\fBdestroy\fP]"
 A batman-adv interface without attached interfaces can be created using "create". The parameter "destroy" can be used to
 free all attached interfaces and remove batman-adv interface.
 .br
-.IP "\fBorig_interval\fP|\fBit\fP [\fBinterval\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBorig_interval\fP|\fBit\fP [\fBinterval\fP]"
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
 originator interval. The interval is in units of milliseconds.
 .br
-.IP "\fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
 disable ap isolation.
 .br
-.IP "<\fBvlan <vdev>\fP|\fBvid <vid>\fP> \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
+.IP "<\fBvlan <vdev>\fP|[\fBmeshif <netdev>\fP] \fBvid <vid>\fP> \fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current ap isolation setting for the specified VLAN is displayed. Otherwise the parameter is used to enable or
 disable ap isolation for the specified VLAN.
 .br
-.IP "\fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable
 or disable the bridge loop avoidance. Bridge loop avoidance support has to be enabled when compiling the module otherwise
 this option won't be available.
 .br
-.IP "\fBdistributed_arp_table\fP|\fBdat\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBdistributed_arp_table\fP|\fBdat\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current distributed arp table setting is displayed. Otherwise the parameter is used to
 enable or disable the distributed arp table.
 .br
-.IP "\fBaggregation\fP|\fBag\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBaggregation\fP|\fBag\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable
 OGM packet aggregation.
 .br
-.IP "\fBbonding\fP|\fBb\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBbonding\fP|\fBb\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable
 the bonding mode.
 .br
@@ -101,30 +101,30 @@ when parameter \fB\-t\fP is specified. Parameter \fB\-r\fP will do the same but
 If no parameter is given the current ELP interval setting of the hard interface is displayed otherwise the parameter is used to set the
 ELP interval. The interval is in units of milliseconds.
 .br
-.IP "\fBfragmentation\fP|\fBf\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBfragmentation\fP|\fBf\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
 disable fragmentation.
 .br
-.IP "\fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]"
 If no parameter is given the current hop penalty setting is displayed. Otherwise the parameter is used to set the
 hop penalty. The penalty is can be 0-255 (255 sets originator message's TQ to zero when forwarded by this hop).
 .br
-.IP "\fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
 disable network coding.
 .br
-.IP "\fBmulticast_forceflood\fP|\fBmff\fP [\fB0\fP|\fB1\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBmulticast_forceflood\fP|\fBmff\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current multicast forceflood setting is displayed. Otherwise the parameter is used to enable or
 disable multicast forceflood. This setting defines whether multicast optimizations should be replaced by simple broadcast-like
 flooding of multicast packets. If set to non-zero then all nodes in the mesh are going to use classic flooding for any
 multicast packet with no optimizations.
 .br
-.IP "\fBmulticast_fanout\fP|\fBmo\fP [\fBfanout\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBmulticast_fanout\fP|\fBmo\fP [\fBfanout\fP]"
 If no parameter is given the current multicast fanout setting is displayed. Otherwise the parameter is used to set
 the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
 multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
 .br
-.IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
+.IP "[\fBmeshif <netdev>\fP] \fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
 Level 'routes' enables messages related to routes being added / changed / deleted. Level 'tt' enables messages related to
@@ -135,7 +135,7 @@ Level 'all' enables all messages. The messages are sent to the batman-adv debug
 Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options
 won't be available.
 .br
-.IP "\fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBgw_mode|gw\fP [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
 If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The
 second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server'
 was the first argument). If the node is a server this parameter is used to inform other nodes in the network about
@@ -213,7 +213,7 @@ the parameter is used to set the throughput override for the specified hard
 interface.
 Just enter any number (optionally followed by "kbit" or "mbit").
 .br
-.IP "\fBisolation_mark\fP|\fBmark\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBisolation_mark\fP|\fBmark\fP"
 If no parameter is given the current isolation mark value is displayed.
 Otherwise the parameter is used to set or unset the isolation mark used by the
 Extended Isolation feature.
@@ -293,12 +293,12 @@ List of debug tables:
 .RE
 .RE
 .br
-.IP "\fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 
 Translates a destination (hostname, IP, MAC, bat_host-name) to the originator
 mac address responsible for it.
 .br
-.IP "\fBstatistics\fP|\fBs\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBstatistics\fP|\fBs\fP"
 Retrieve traffic counters from batman-adv kernel module. The output may vary depending on which features have been compiled
 into the kernel module.
 .br
@@ -313,7 +313,7 @@ tt - translation table counters
 All counters without a prefix concern payload (pure user data) traffic.
 .RE
 .br
-.IP "\fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBping\fP|\fBp\fP [\fB\-c count\fP][\fB\-i interval\fP][\fB\-t time\fP][\fB\-R\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to find the bat\-host name if the given parameter was
 not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
 the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
@@ -324,7 +324,7 @@ interval between pings and the timeout time for replies, both in seconds. When r
 messages will be recorded. With "\-T" you can disable the automatic translation of a client MAC address to the originator
 address which is responsible for this client.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBtraceroute\fP|\fBtr\fP [\fB\-n\fP][\fB\-T\fP] \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try to find the bat\-host name if the given parameter
 was not a MAC address. It can also try to guess the MAC address using an IPv4/IPv6 address or a hostname when
 the IPv4/IPv6 address was configured on top of the batman-adv interface of the destination device and both source and
@@ -376,7 +376,7 @@ specific sequence number, min. Furthermore using "\-o" you can filter the output
 given batctl will not replace the MAC addresses with bat\-host names in the output.
 .RE
 .br
-.IP "\fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP"
+.IP "[\fBmeshif <netdev>\fP] \fBthroughputmeter\fP|\fBtp\fP \fBMAC\fP"
 This command starts a throughput test entirely controlled by batman module in
 kernel space: the computational resources needed to align memory and copy data
 between user and kernel space that are required by other user space tools may
diff --git a/multicast_fanout.c b/multicast_fanout.c
index cec42a3..bea83c5 100644
--- a/multicast_fanout.c
+++ b/multicast_fanout.c
@@ -95,7 +95,7 @@ static struct settings_data batctl_settings_multicast_fanout = {
 	.netlink_set = set_multicast_fanout,
 };
 
-COMMAND_NAMED(SUBCOMMAND, multicast_fanout, "mo", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, multicast_fanout, "mo", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_multicast_fanout,
 	      "[fanout]        \tdisplay or modify multicast_fanout setting");
diff --git a/multicast_forceflood.c b/multicast_forceflood.c
index fdc5400..f15cc12 100644
--- a/multicast_forceflood.c
+++ b/multicast_forceflood.c
@@ -75,7 +75,7 @@ static struct settings_data batctl_settings_multicast_forceflood = {
 	.netlink_set = set_multicast_forceflood,
 };
 
-COMMAND_NAMED(SUBCOMMAND, multicast_forceflood, "mff", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, multicast_forceflood, "mff", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK | COMMAND_FLAG_INVERSE,
 	      &batctl_settings_multicast_forceflood,
 	      "[0|1]             \tdisplay or modify multicast_forceflood setting");
diff --git a/multicast_mode.c b/multicast_mode.c
index 063166e..e11d3af 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -75,6 +75,6 @@ static struct settings_data batctl_settings_multicast_mode = {
 	.netlink_set = set_multicast_mode,
 };
 
-COMMAND_NAMED(SUBCOMMAND, multicast_mode, "mm", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, multicast_mode, "mm", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_multicast_mode, NULL);
diff --git a/network_coding.c b/network_coding.c
index d22fab0..0fdcc78 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -55,7 +55,7 @@ static struct settings_data batctl_settings_network_coding = {
 	.netlink_set = set_network_coding,
 };
 
-COMMAND_NAMED(SUBCOMMAND, network_coding, "nc", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, network_coding, "nc", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_network_coding,
 	      "[0|1]             \tdisplay or modify network_coding setting");
diff --git a/orig_interval.c b/orig_interval.c
index a90ba27..f0e75c9 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -95,7 +95,7 @@ static struct settings_data batctl_settings_orig_interval = {
 	.netlink_set = set_orig_interval,
 };
 
-COMMAND_NAMED(SUBCOMMAND, orig_interval, "it", handle_sys_setting,
+COMMAND_NAMED(SUBCOMMAND_MIF, orig_interval, "it", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
 	      &batctl_settings_orig_interval,
 	      "[interval]        \tdisplay or modify orig_interval setting");
diff --git a/ping.c b/ping.c
index aa7cbc3..cc0ac0f 100644
--- a/ping.c
+++ b/ping.c
@@ -323,5 +323,5 @@ static int ping(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(SUBCOMMAND, ping, "p", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND_MIF, ping, "p", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \tping another batman adv host via layer 2");
diff --git a/statistics.c b/statistics.c
index 2a90a1d..c019d87 100644
--- a/statistics.c
+++ b/statistics.c
@@ -112,5 +112,5 @@ static int statistics(struct state *state, int argc __maybe_unused,
 	return ret;
 }
 
-COMMAND(SUBCOMMAND, statistics, "s", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND_MIF, statistics, "s", COMMAND_FLAG_MESH_IFACE, NULL,
 	"                  \tprint mesh statistics");
diff --git a/sys.c b/sys.c
index b9555ee..fe388fe 100644
--- a/sys.c
+++ b/sys.c
@@ -145,9 +145,13 @@ static void settings_usage(struct state *state)
 		"",
 		NULL,
 	};
+	const char *meshif_prefixes[] = {
+		"meshif <netdev> ",
+		NULL,
+	};
 	const char *vlan_prefixes[] = {
 		"vlan <vdev> ",
-		"vid <vid> ",
+		"meshif <netdev> vid <vid> ",
 		NULL,
 	};
 	const char *hardif_prefixes[] = {
@@ -159,6 +163,9 @@ static void settings_usage(struct state *state)
 	const char **prefix;
 
 	switch (state->cmd->type) {
+	case SUBCOMMAND_MIF:
+		prefixes = meshif_prefixes;
+		break;
 	case SUBCOMMAND_VID:
 		prefixes = vlan_prefixes;
 		break;
@@ -268,6 +275,7 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 
 	switch (state->selector) {
 	case SP_NONE_OR_MESHIF:
+	case SP_MESHIF:
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT,
 			 state->mesh_iface);
 		break;
diff --git a/throughputmeter.c b/throughputmeter.c
index f9d98cf..a46347d 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -529,5 +529,5 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(SUBCOMMAND, throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND_MIF, throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \tstart a throughput measurement");
diff --git a/traceroute.c b/traceroute.c
index d810122..07ba37f 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -209,5 +209,5 @@ static int traceroute(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(SUBCOMMAND, traceroute, "tr", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND_MIF, traceroute, "tr", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \ttraceroute another batman adv host via layer 2");
diff --git a/translate.c b/translate.c
index a59fc14..27d53e5 100644
--- a/translate.c
+++ b/translate.c
@@ -64,5 +64,5 @@ static int translate(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(SUBCOMMAND, translate, "t", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND_MIF, translate, "t", COMMAND_FLAG_MESH_IFACE, NULL,
 	"<destination>     \ttranslate a destination to the originator responsible for it");
-- 
2.20.1

