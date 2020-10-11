Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batctl: Allow to configure routing_algo during interface creation
Date: Sun, 11 Oct 2020 13:09:50 +0200
Message-Id: <20201011110950.304698-1-sven@narfation.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Annika Wickert <annika.wickert@exaring.de>

A batadv net_device is associated to a B.A.T.M.A.N. routing algorithm. This
algorithm has to be selected before the interface is initialized and cannot
be changed after that. The only way to select this algorithm was a module
parameter which specifies the default algorithm used during the creation of
the net_device.

This module parameter is writeable over
/sys/module/batman_adv/parameters/routing_algo and thus allows switching of
the routing algorithm:

1. change routing_algo parameter
2. create new batadv net_device

But this is not race free because another process can be scheduled between
1 + 2 and in that time frame change the routing_algo parameter again.

It is much cleaner to directly provide this information inside the
rtnetlink's RTM_NEWLINK message. The two processes would be (in regards of
the creation parameter of their batadv interfaces) be isolated.

This can now be done (with a compatible kernel module) using the
routing_algo parameter of interface create:

  $ batctl meshif bat0 interface create routing_algo BATMAN_IV
  or
  $ batctl meshif bat0 interface create routing_algo BATMAN_V

Cc: Annika Wickert <annika.wickert@exaring.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This version uses a parameter like ip-link. Another option to implement it
would be to use some kind of --routing_algo option like the -M option which
already exists. Maybe some people have a preference how the commandline
interface should look like.


 batman_adv.h | 26 ++++++++++++++++++++
 interface.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++----
 man/batctl.8 |  8 +++---
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/batman_adv.h b/batman_adv.h
index bb0ae94..bdb317f 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -675,4 +675,30 @@ enum batadv_tp_meter_reason {
 	BATADV_TP_REASON_TOO_MANY		= 133,
 };
 
+/**
+ * enum batadv_ifla_attrs - batman-adv ifla nested attributes
+ */
+enum batadv_ifla_attrs {
+	/**
+	 * @IFLA_BATADV_UNSPEC: unspecified attribute which is not parsed by
+	 *  rtnetlink
+	 */
+	IFLA_BATADV_UNSPEC,
+
+	/**
+	 * @IFLA_BATADV_ALGO_NAME: routing algorithm (name) which should be
+	 *  used by the newly registered batadv net_device.
+	 */
+	IFLA_BATADV_ALGO_NAME,
+
+	/* add attributes above here, update the policy in soft-interface.c */
+
+	/**
+	 * @__IFLA_BATADV_MAX: internal use
+	 */
+	__IFLA_BATADV_MAX,
+};
+
+#define IFLA_BATADV_MAX (__IFLA_BATADV_MAX - 1)
+
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/interface.c b/interface.c
index d0d9435..73720e3 100644
--- a/interface.c
+++ b/interface.c
@@ -29,7 +29,8 @@
 static void interface_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
-	fprintf(stderr, "       batctl [options] interface [parameters] [create|destroy]\n");
+	fprintf(stderr, "       batctl [options] interface [parameters] create [routing_algo|ra RA_NAME]\n");
+	fprintf(stderr, "       batctl [options] interface [parameters] destroy\n");
 	fprintf(stderr, "parameters:\n");
 	fprintf(stderr, " \t -M disable automatic creation of batman-adv interface\n");
 	fprintf(stderr, " \t -h print this help\n");
@@ -256,12 +257,47 @@ static unsigned int count_interfaces(char *mesh_iface)
 	return count_arg.count;
 }
 
-static int create_interface(const char *mesh_iface)
+struct interface_create_params {
+	const char *routing_algo;
+};
+
+static int
+interface_parse_create_params(int argc, char **argv,
+			      struct interface_create_params *create_params)
+{
+	int pos = 1;
+
+	while (pos < argc) {
+		if (strcmp(argv[pos], "routing_algo") == 0 ||
+		    strcmp(argv[pos], "ra") == 0) {
+			pos++;
+			if (pos >= argc) {
+				fprintf(stderr,
+					"Error - missing parameter for 'routing_algo'\n");
+				return -EINVAL;
+			}
+
+			create_params->routing_algo = argv[pos];
+			pos++;
+		} else {
+			fprintf(stderr,
+				"Error - unknown parameter '%s'\n",
+				argv[pos]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int create_interface(const char *mesh_iface,
+			    const struct interface_create_params *create_param)
 {
 	struct ifinfomsg rt_hdr = {
 		.ifi_family = IFLA_UNSPEC,
 	};
 	struct nlattr *linkinfo;
+	struct nlattr *linkdata;
 	struct nl_msg *msg;
 	int err = 0;
 	int ret;
@@ -296,6 +332,22 @@ static int create_interface(const char *mesh_iface)
 		goto err_free_msg;
 	}
 
+	linkdata = nla_nest_start(msg, IFLA_INFO_DATA);
+	if (!linkdata) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	if (create_param->routing_algo) {
+		ret = nla_put_string(msg, IFLA_BATADV_ALGO_NAME,
+				     create_param->routing_algo);
+		if (ret < 0) {
+			err = -ENOMEM;
+			goto err_free_msg;
+		}
+	}
+
+	nla_nest_end(msg, linkdata);
 	nla_nest_end(msg, linkinfo);
 
 	err = netlink_simple_request(msg);
@@ -382,6 +434,7 @@ static int set_master_interface(const char *iface, unsigned int ifmaster)
 
 static int interface(struct state *state, int argc, char **argv)
 {
+	struct interface_create_params create_params = {};
 	int i, optchar;
 	int ret;
 	unsigned int ifindex;
@@ -438,7 +491,6 @@ static int interface(struct state *state, int argc, char **argv)
 			goto err;
 		}
 		break;
-	case 'c':
 	case 'D':
 		if (rest_argc != 1) {
 			fprintf(stderr,
@@ -448,13 +500,20 @@ static int interface(struct state *state, int argc, char **argv)
 			goto err;
 		}
 		break;
+	case 'c':
+		ret = interface_parse_create_params(rest_argc, rest_argv,
+						    &create_params);
+		if (ret) {
+			interface_usage();
+			goto err;
+		}
 	default:
 		break;
 	}
 
 	switch (rest_argv[0][0]) {
 	case 'c':
-		ret = create_interface(state->mesh_iface);
+		ret = create_interface(state->mesh_iface, &create_params);
 		if (ret < 0) {
 			fprintf(stderr,
 				"Error - failed to add create batman-adv interface: %s\n",
@@ -478,7 +537,7 @@ static int interface(struct state *state, int argc, char **argv)
 	/* get index of batman-adv interface - or try to create it */
 	ifmaster = if_nametoindex(state->mesh_iface);
 	if (!manual_mode && !ifmaster && rest_argv[0][0] == 'a') {
-		ret = create_interface(state->mesh_iface);
+		ret = create_interface(state->mesh_iface, &create_params);
 		if (ret < 0) {
 			fprintf(stderr,
 				"Error - failed to create batman-adv interface: %s\n",
diff --git a/man/batctl.8 b/man/batctl.8
index 1737e17..de84ffc 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -60,9 +60,11 @@ In order to add or delete interfaces specify "add" or "del" as first argument an
 add or delete. Multiple interfaces can be specified.
 The "\-M" option tells batctl to not automatically create the batman-adv interface on "add". It can also be used to
 suppress the warning about the manual destruction when "del" removed all interfaces which belonged to it.
-.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fBcreate\fP|\fBdestroy\fP]"
-A batman-adv interface without attached interfaces can be created using "create". The parameter "destroy" can be used to
-free all attached interfaces and remove batman-adv interface.
+.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP \fBcreate\fP [\fBrouting_algo|ra RA_NAME\fP]"
+A batman-adv interface without attached interfaces can be created using "create". The parameter routing_algo
+can be used to overwrite the (default) routing algorithm.
+.IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP \fBdestroy\fP"
+Remove all attached interfaces and destroy the batman-adv interface.
 .br
 .IP "[\fBmeshif <netdev>\fP] \fBorig_interval\fP|\fBit\fP [\fBinterval\fP]"
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
-- 
2.28.0

