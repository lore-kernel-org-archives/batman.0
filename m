Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Sep 2016 17:58:01 +0200
Message-Id: <20160924155806.9115-2-sven@narfation.org>
In-Reply-To: <20160924155806.9115-1-sven@narfation.org>
References: <20160924155806.9115-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/7] batctl: Add command to create/destroy
	batman-adv interface
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

The command "create" can be used to create a batman-adv interface without
any interface attached. This is helpful when the interfaces should be
configured independently of the first attached interface.

The command "destroy" can be used to destroy a batman-adv interface without
going through all attached interfaces and delete them manually.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rename "new" command to "create" as requested by Linus Luessing and
   John Harrison

 functions.c  |  58 ++++++++++++++++++++++++
 functions.h  |   1 +
 man/batctl.8 |   3 ++
 sys.c        | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/functions.c b/functions.c
index 327ef18..962efcf 100644
--- a/functions.c
+++ b/functions.c
@@ -953,3 +953,61 @@ err_free_sock:
 
 	return err;
 }
+
+static int ack_errno_handler(struct sockaddr_nl *nla __unused,
+			     struct nlmsgerr *nlerr,
+			     void *arg)
+{
+	int *err = arg;
+
+	*err = nlerr->error;
+
+	return NL_STOP;
+}
+
+static int ack_wait_handler(struct nl_msg *msg __unused, void *arg __unused)
+{
+	return NL_STOP;
+}
+
+int netlink_simple_request(struct nl_msg *msg)
+{
+	struct nl_sock *sock;
+	struct nl_cb *cb;
+	int err = 0;
+	int ret;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
+	ret = nl_connect(sock, NETLINK_ROUTE);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_sock;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		err = -ENOMEM;
+		goto err_free_sock;
+	}
+
+	nl_cb_err(cb, NL_CB_CUSTOM, ack_errno_handler, &err);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_wait_handler, NULL);
+
+	ret = nl_send_auto_complete(sock, msg);
+	if (ret < 0)
+		goto err_free_cb;
+
+	// ack_errno_handler sets err on errors
+	err = 0;
+	nl_recvmsgs(sock, cb);
+
+err_free_cb:
+	nl_cb_put(cb);
+err_free_sock:
+	nl_socket_free(sock);
+
+	return err;
+}
diff --git a/functions.h b/functions.h
index a6090b6..7757731 100644
--- a/functions.h
+++ b/functions.h
@@ -47,6 +47,7 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 struct ether_addr *resolve_mac(const char *asc);
 int vlan_get_link(const char *ifname, char **parent);\
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
+int netlink_simple_request(struct nl_msg *msg);
 
 int print_routing_algos(void);
 extern char *line_ptr;
diff --git a/man/batctl.8 b/man/batctl.8
index 8bac727..a29d1fb 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -56,6 +56,9 @@ performances, is also included.
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
 In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
 add or delete. Multiple interfaces can be specified.
+.IP "\fBinterface\fP|\fBif\fP [\fBcreate\fP|\fBdestroy\fP]"
+A batman-adv interface without attached interfaces can be created using "create". The parameter "destroy" can be used to
+free all attached interfaces and remove batman-adv interface.
 .br
 .IP "\fBorig_interval\fP|\fBit\fP [\fBinterval\fP]"
 If no parameter is given the current originator interval setting is displayed otherwise the parameter is used to set the
diff --git a/sys.c b/sys.c
index 0140b28..c18c6b8 100644
--- a/sys.c
+++ b/sys.c
@@ -120,6 +120,7 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 static void interface_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
+	fprintf(stderr, "       batctl [options] interface [parameters] [create|destroy]\n");
 	fprintf(stderr, "parameters:\n");
 	fprintf(stderr, " \t -h print this help\n");
 }
@@ -198,10 +199,95 @@ static int print_interfaces(char *mesh_iface)
 	return EXIT_SUCCESS;
 }
 
+static int create_interface(const char *mesh_iface)
+{
+	struct ifinfomsg rt_hdr = {
+		.ifi_family = IFLA_UNSPEC,
+	};
+	struct nlattr *linkinfo;
+	struct nl_msg *msg;
+	int err = 0;
+	int ret;
+
+	msg = nlmsg_alloc_simple(RTM_NEWLINK,
+				 NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL | NLM_F_ACK);
+	if (!msg) {
+		return -ENOMEM;
+	}
+
+	ret = nlmsg_append(msg, &rt_hdr, sizeof(rt_hdr), NLMSG_ALIGNTO);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	ret = nla_put_string(msg, IFLA_IFNAME, mesh_iface);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	linkinfo = nla_nest_start(msg, IFLA_LINKINFO);
+	if (!linkinfo) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	ret = nla_put_string(msg, IFLA_INFO_KIND, "batadv");
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	nla_nest_end(msg, linkinfo);
+
+	err = netlink_simple_request(msg);
+
+err_free_msg:
+	nlmsg_free(msg);
+
+	return err;
+}
+
+static int destroy_interface(const char *mesh_iface)
+{
+	struct ifinfomsg rt_hdr = {
+		.ifi_family = IFLA_UNSPEC,
+	};
+	struct nl_msg *msg;
+	int err = 0;
+	int ret;
+
+	msg = nlmsg_alloc_simple(RTM_DELLINK, NLM_F_REQUEST | NLM_F_ACK);
+	if (!msg) {
+		return -ENOMEM;
+	}
+
+	ret = nlmsg_append(msg, &rt_hdr, sizeof(rt_hdr), NLMSG_ALIGNTO);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	ret = nla_put_string(msg, IFLA_IFNAME, mesh_iface);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	err = netlink_simple_request(msg);
+
+err_free_msg:
+	nlmsg_free(msg);
+
+	return err;
+}
+
 int interface(char *mesh_iface, int argc, char **argv)
 {
 	char *path_buff;
 	int i, res, optchar;
+	int ret;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -218,16 +304,63 @@ int interface(char *mesh_iface, int argc, char **argv)
 		return print_interfaces(mesh_iface);
 
 	if ((strcmp(argv[1], "add") != 0) && (strcmp(argv[1], "a") != 0) &&
-	    (strcmp(argv[1], "del") != 0) && (strcmp(argv[1], "d") != 0)) {
+	    (strcmp(argv[1], "del") != 0) && (strcmp(argv[1], "d") != 0) &&
+	    (strcmp(argv[1], "create") != 0) && (strcmp(argv[1], "c") != 0) &&
+	    (strcmp(argv[1], "destroy") != 0) && (strcmp(argv[1], "D") != 0)) {
 		fprintf(stderr, "Error - unknown argument specified: %s\n", argv[1]);
 		interface_usage();
 		goto err;
 	}
 
-	if (argc == 2) {
-		fprintf(stderr, "Error - missing interface name(s) after '%s'\n", argv[1]);
-		interface_usage();
-		goto err;
+	if (strcmp(argv[1], "destroy") == 0)
+		argv[1][0] = 'D';
+
+	switch (argv[1][0]) {
+	case 'a':
+	case 'd':
+		if (argc == 2) {
+			fprintf(stderr,
+				"Error - missing interface name(s) after '%s'\n",
+				argv[1]);
+			interface_usage();
+			goto err;
+		}
+		break;
+	case 'c':
+	case 'D':
+		if (argc != 2) {
+			fprintf(stderr,
+				"Error - extra parameter after '%s'\n",
+				argv[1]);
+			interface_usage();
+			goto err;
+		}
+		break;
+	default:
+		break;
+	}
+
+	switch (argv[1][0]) {
+	case 'c':
+		ret = create_interface(mesh_iface);
+		if (ret < 0) {
+			fprintf(stderr,
+				"Error - failed to create batman-adv interface: %s\n",
+				strerror(-ret));
+			goto err;
+		}
+		return EXIT_SUCCESS;
+	case 'D':
+		ret = destroy_interface(mesh_iface);
+		if (ret < 0) {
+			fprintf(stderr,
+				"Error - failed to destroy batman-adv interface: %s\n",
+				strerror(-ret));
+			goto err;
+		}
+		return EXIT_SUCCESS;
+	default:
+		break;
 	}
 
 	path_buff = malloc(PATH_BUFF_LEN);
-- 
2.9.3

