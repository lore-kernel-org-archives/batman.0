Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Sep 2016 17:58:02 +0200
Message-Id: <20160924155806.9115-3-sven@narfation.org>
In-Reply-To: <20160924155806.9115-1-sven@narfation.org>
References: <20160924155806.9115-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 3/7] batctl: Use rtnl to add/remove
	interfaces
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

The sysfs interface to add/remove interfaces to/from a batman-adv
soft-interface was downgraded in batman-adv master to a second-class
citizen. This was done because it has conceptional problems (for example
locking of sysfs vs. locking of the network core code). The only direct way
to modify network interfaces is rtnetlink. sysfs still exists but has to
use workers which delay the actual add/del to a later point.

It is therefore prefered to use the modern rtnetlink. Only batman-adv
versions older than v2013.2.0 (Linux 3.10) will not yet support the
rtnl_link operations required for it to work.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rename "new" command to "create" as requested by Linus Luessing and
   John Harrison

 sys.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 145 insertions(+), 27 deletions(-)

diff --git a/sys.c b/sys.c
index c18c6b8..cefd53c 100644
--- a/sys.c
+++ b/sys.c
@@ -199,6 +199,58 @@ static int print_interfaces(char *mesh_iface)
 	return EXIT_SUCCESS;
 }
 
+struct count_interfaces_rtnl_arg {
+	int ifindex;
+	unsigned int count;
+};
+
+static int count_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
+{
+	struct count_interfaces_rtnl_arg *count_arg = arg;
+	struct nlattr *attrs[IFLA_MAX + 1];
+	struct ifinfomsg *ifm;
+	int ret;
+	int master;
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
+	if (!attrs[IFLA_MASTER])
+		goto err;
+
+	master = nla_get_u32(attrs[IFLA_MASTER]);
+
+	/* required on older kernels which don't prefilter the results */
+	if (master != count_arg->ifindex)
+		goto err;
+
+	count_arg->count++;
+
+err:
+	return NL_OK;
+}
+
+static unsigned int count_interfaces(char *mesh_iface)
+{
+	struct count_interfaces_rtnl_arg count_arg;
+
+	count_arg.count = 0;
+	count_arg.ifindex = if_nametoindex(mesh_iface);
+	if (!count_arg.ifindex)
+		return 0;
+
+	query_rtnl_link(count_arg.ifindex, count_interfaces_rtnl_parse,
+			&count_arg);
+
+	return count_arg.count;
+}
+
 static int create_interface(const char *mesh_iface)
 {
 	struct ifinfomsg rt_hdr = {
@@ -283,11 +335,54 @@ err_free_msg:
 	return err;
 }
 
+static int set_master_interface(const char *iface, unsigned int ifmaster)
+{
+	struct ifinfomsg rt_hdr = {
+		.ifi_family = IFLA_UNSPEC,
+	};
+	struct nl_msg *msg;
+	int err = 0;
+	int ret;
+
+	msg = nlmsg_alloc_simple(RTM_SETLINK, NLM_F_REQUEST | NLM_F_ACK);
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
+	ret = nla_put_string(msg, IFLA_IFNAME, iface);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	ret = nla_put_u32(msg, IFLA_MASTER, ifmaster);
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
-	char *path_buff;
-	int i, res, optchar;
+	int i, optchar;
 	int ret;
+	unsigned int ifindex;
+	unsigned int ifmaster;
+	const char *long_op;
+	unsigned int cnt;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -363,46 +458,69 @@ int interface(char *mesh_iface, int argc, char **argv)
 		break;
 	}
 
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
-		goto err;
-	}
+	/* get index of batman-adv interface - or try to create it */
+	ifmaster = if_nametoindex(mesh_iface);
+	if (!ifmaster && argv[1][0] == 'a') {
+		ret = create_interface(mesh_iface);
+		if (ret < 0) {
+			fprintf(stderr,
+				"Error - failed to create batman-adv interface: %s\n",
+				strerror(-ret));
+			goto err;
+		}
 
-	for (i = 2; i < argc; i++) {
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, argv[i]);
+		ifmaster = if_nametoindex(mesh_iface);
+	}
 
-		if (!file_exists(path_buff)) {
-			snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_DIR, argv[i]);
+	if (!ifmaster) {
+		ret = -ENODEV;
+		fprintf(stderr,
+			"Error - failed to find batman-adv interface: %s\n",
+			strerror(-ret));
+		goto err;
+	}
 
-			if (!file_exists(path_buff)) {
-				fprintf(stderr, "Error - interface does not exist: %s\n", argv[i]);
-				continue;
-			}
+	/* make sure that batman-adv is loaded or was loaded by create_interface */
+	if (!file_exists(module_ver_path)) {
+		fprintf(stderr, "Error - batman-adv module has not been loaded\n");
+		goto err;
+	}
 
-			if (!file_exists(module_ver_path)) {
-				fprintf(stderr, "Error - batman-adv module has not been loaded\n");
-				goto err_buff;
-			}
+	for (i = 2; i < argc; i++) {
+		ifindex = if_nametoindex(argv[i]);
 
-			fprintf(stderr, "Error - interface type not supported by batman-adv: %s\n", argv[i]);
+		if (!ifindex) {
+			fprintf(stderr, "Error - interface does not exist: %s\n", argv[i]);
 			continue;
 		}
 
 		if (argv[1][0] == 'a')
-			res = write_file("", path_buff, mesh_iface, NULL);
+			ifindex = ifmaster;
 		else
-			res = write_file("", path_buff, "none", NULL);
+			ifindex = 0;
 
-		if (res != EXIT_SUCCESS)
-			goto err_buff;
+		ret = set_master_interface(argv[i], ifindex);
+		if (ret < 0) {
+			if (argv[1][0] == 'a')
+				long_op = "add";
+			else
+				long_op = "delete";
+
+			fprintf(stderr, "Error - failed to %s interface %s: %s\n",
+				long_op, argv[i], strerror(-ret));
+			goto err;
+		}
+	}
+
+	/* check if there is no interface left and then destroy mesh_iface */
+	if (argv[1][0] == 'd') {
+		cnt = count_interfaces(mesh_iface);
+		if (cnt == 0)
+			destroy_interface(mesh_iface);
 	}
 
-	free(path_buff);
 	return EXIT_SUCCESS;
 
-err_buff:
-	free(path_buff);
 err:
 	return EXIT_FAILURE;
 }
-- 
2.9.3

