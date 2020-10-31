Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/3] batctl: Switch active routing algo list to netlink
Date: Sat, 31 Oct 2020 19:40:48 +0100
Message-Id: <20201031184051.118630-1-sven@narfation.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

The sysfs support is disabled by default in batman-adv since a while and
will be removed in 2021. The generic netlink interface should be used
instead. But the list of active routing algorithms was only available when
batman-adv was build with sysfs support.

Instead of walking through (not existing) sysfs entries, query the list of
batadv interfaces via rtnl and use the already existing helpers to get the
routing algorithm.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing_algo.c | 172 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 122 insertions(+), 50 deletions(-)

diff --git a/routing_algo.c b/routing_algo.c
index 7171c52..5fa360b 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -6,7 +6,6 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
-#include <dirent.h>
 #include <errno.h>
 #include <getopt.h>
 #include <netinet/if_ether.h>
@@ -159,14 +158,130 @@ static int print_routing_algos(void)
 	return err;
 }
 
+static struct nla_policy link_policy[IFLA_MAX + 1] = {
+	[IFLA_IFNAME] = { .type = NLA_STRING, .maxlen = IFNAMSIZ },
+};
+
+struct print_ra_interfaces_rtnl_arg {
+	uint8_t header_shown:1;
+};
+
+static int print_ra_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
+{
+	struct print_ra_interfaces_rtnl_arg *print_arg = arg;
+	struct nlattr *attrs[IFLA_MAX + 1];
+	char algoname[256];
+	struct ifinfomsg *ifm;
+	char *mesh_iface;
+	int ret;
+
+	ifm = nlmsg_data(nlmsg_hdr(msg));
+	ret = nlmsg_parse(nlmsg_hdr(msg), sizeof(*ifm), attrs, IFLA_MAX,
+			  link_policy);
+	if (ret < 0)
+		goto err;
+
+	if (!attrs[IFLA_IFNAME])
+		goto err;
+
+	mesh_iface = nla_get_string(attrs[IFLA_IFNAME]);
+
+	ret = get_algoname_netlink(mesh_iface, algoname, sizeof(algoname));
+	if (ret < 0)
+		goto err;
+
+	if(!print_arg->header_shown) {
+		print_arg->header_shown = true;
+		printf("Active routing protocol configuration:\n");
+	}
+
+	printf(" * %s: %s\n", mesh_iface, algoname);
+
+err:
+	return NL_OK;
+}
+
+static int print_ra_interfaces(void)
+{
+	struct print_ra_interfaces_rtnl_arg print_arg = {};
+
+	struct ifinfomsg rt_hdr = {
+		.ifi_family = IFLA_UNSPEC,
+	};
+	struct nlattr *linkinfo;
+	struct nl_sock *sock;
+	struct nl_msg *msg;
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
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_ra_interfaces_rtnl_parse,
+		 &print_arg);
+
+	msg = nlmsg_alloc_simple(RTM_GETLINK, NLM_F_REQUEST | NLM_F_DUMP);
+	if (!msg) {
+		err = -ENOMEM;
+		goto err_free_cb;
+	}
+
+	ret = nlmsg_append(msg, &rt_hdr, sizeof(rt_hdr), NLMSG_ALIGNTO);
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
+	nla_nest_end(msg, linkinfo);
+
+	ret = nl_send_auto_complete(sock, msg);
+	if (ret < 0)
+		goto err_free_msg;
+
+	nl_recvmsgs(sock, cb);
+
+	if (print_arg.header_shown)
+		printf("\n");
+
+err_free_msg:
+	nlmsg_free(msg);
+err_free_cb:
+	nl_cb_put(cb);
+err_free_sock:
+	nl_socket_free(sock);
+
+	return err;
+}
+
 static int routing_algo(struct state *state __maybe_unused, int argc, char **argv)
 {
-	DIR *iface_base_dir;
-	struct dirent *iface_dir;
 	int optchar;
-	char *path_buff;
 	int res = EXIT_FAILURE;
-	int first_iface = 1;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -183,48 +298,10 @@ static int routing_algo(struct state *state __maybe_unused, int argc, char **arg
 
 	if (argc == 2) {
 		res = write_file(SYS_SELECTED_RA_PATH, "", argv[1], NULL);
-		goto out;
-	}
-
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
-		goto out;
-	}
-
-	iface_base_dir = opendir(SYS_IFACE_PATH);
-	if (!iface_base_dir) {
-		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
-			SYS_IFACE_PATH, strerror(errno));
-		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
-		goto free_buff;
-	}
-
-	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-		if (res != EXIT_SUCCESS)
-			continue;
-
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
-
-		if (first_iface) {
-			first_iface = 0;
-			printf("Active routing protocol configuration:\n");
-		}
-
-		printf(" * %s: %s\n", iface_dir->d_name, line_ptr);
-
-		free(line_ptr);
-		line_ptr = NULL;
+		return EXIT_FAILURE;
 	}
 
-	closedir(iface_base_dir);
-	free(path_buff);
-
-	if (!first_iface)
-		printf("\n");
+	print_ra_interfaces();
 
 	res = read_file("", SYS_SELECTED_RA_PATH, USE_READ_BUFF, 0, 0, 0);
 	if (res != EXIT_SUCCESS)
@@ -237,11 +314,6 @@ static int routing_algo(struct state *state __maybe_unused, int argc, char **arg
 
 	print_routing_algos();
 	return EXIT_SUCCESS;
-
-free_buff:
-	free(path_buff);
-out:
-	return res;
 }
 
 COMMAND(SUBCOMMAND, routing_algo, "ra", 0, NULL,
-- 
2.28.0

