Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Sep 2016 17:58:00 +0200
Message-Id: <20160924155806.9115-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/7] batctl: Use rtnl to query list of
	softif devices
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

The normal way of network related programs to query the state of interfaces
is to use the rtnetlink. Most of these data can also be queried via sysfs
but it is easier to use the same way for both retrieving the list of
interfaces and modifying the list of interfaces.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - no change

 functions.c |  64 +++++++++++++++++++++++++++++++++++
 functions.h |   5 ++-
 sys.c       | 111 +++++++++++++++++++++++++++++++++---------------------------
 3 files changed, 129 insertions(+), 51 deletions(-)

diff --git a/functions.c b/functions.c
index d236d64..327ef18 100644
--- a/functions.c
+++ b/functions.c
@@ -37,6 +37,7 @@
 #include <stdint.h>
 #include <linux/netlink.h>
 #include <net/ethernet.h>
+#include <linux/if_link.h>
 #include <linux/rtnetlink.h>
 #include <linux/neighbour.h>
 #include <errno.h>
@@ -889,3 +890,66 @@ int print_routing_algos(void)
 		err = debug_print_routing_algos();
 	return err;
 }
+
+int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg)
+{
+	struct ifinfomsg rt_hdr = {
+		.ifi_family = IFLA_UNSPEC,
+	};
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
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, func, arg);
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
+	ret = nla_put_u32(msg, IFLA_MASTER, ifindex);
+	if (ret < 0) {
+		err = -ENOMEM;
+		goto err_free_msg;
+	}
+
+	ret = nl_send_auto_complete(sock, msg);
+	if (ret < 0)
+		goto err_free_msg;
+
+	nl_recvmsgs(sock, cb);
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
diff --git a/functions.h b/functions.h
index e24dea0..a6090b6 100644
--- a/functions.h
+++ b/functions.h
@@ -23,6 +23,8 @@
 #define _BATCTL_FUNCTIONS_H
 
 #include <net/ethernet.h>
+#include <netlink/netlink.h>
+#include <netlink/handlers.h>
 #include <stddef.h>
 
 
@@ -43,7 +45,8 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
-int vlan_get_link(const char *ifname, char **parent);
+int vlan_get_link(const char *ifname, char **parent);\
+int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
 
 int print_routing_algos(void);
 extern char *line_ptr;
diff --git a/sys.c b/sys.c
index ca837f6..0140b28 100644
--- a/sys.c
+++ b/sys.c
@@ -26,6 +26,11 @@
 #include <string.h>
 #include <errno.h>
 #include <dirent.h>
+#include <net/if.h>
+#include <linux/if_link.h>
+#include <netlink/netlink.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
 
 #include "main.h"
 #include "sys.h"
@@ -119,72 +124,78 @@ static void interface_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-static int print_interfaces(char *mesh_iface)
-{
-	DIR *iface_base_dir;
-	struct dirent *iface_dir;
-	char *path_buff;
-	int res;
+static struct nla_policy link_policy[IFLA_MAX + 1] = {
+	[IFLA_IFNAME]           = { .type = NLA_STRING, .maxlen = IFNAMSIZ },
+	[IFLA_MASTER]         = { .type = NLA_U32 },
+};
 
-	if (!file_exists(module_ver_path)) {
-		fprintf(stderr, "Error - batman-adv module has not been loaded\n");
+struct print_interfaces_rtnl_arg {
+	int ifindex;
+};
+
+static int print_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
+{
+	struct print_interfaces_rtnl_arg *print_arg = arg;
+	struct nlattr *attrs[IFLA_MAX + 1];
+	char path_buff[PATH_BUFF_LEN];
+	struct ifinfomsg *ifm;
+	char *ifname;
+	int ret;
+	const char *status;
+	int master;
+
+	ifm = nlmsg_data(nlmsg_hdr(msg));
+	ret = nlmsg_parse(nlmsg_hdr(msg), sizeof(*ifm), attrs, IFLA_MAX,
+			  link_policy);
+	if (ret < 0)
 		goto err;
-	}
 
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+	if (!attrs[IFLA_IFNAME])
 		goto err;
-	}
 
-	iface_base_dir = opendir(SYS_IFACE_PATH);
-	if (!iface_base_dir) {
-		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
-		       SYS_IFACE_PATH, strerror(errno));
-		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
-		goto err_buff;
-	}
+	if (!attrs[IFLA_MASTER])
+		goto err;
 
-	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-		if (res != EXIT_SUCCESS)
-			continue;
+	ifname = nla_get_string(attrs[IFLA_IFNAME]);
+	master = nla_get_u32(attrs[IFLA_MASTER]);
 
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
+	/* required on older kernels which don't prefilter the results */
+	if (master != print_arg->ifindex)
+		goto err;
 
-		if (strcmp(line_ptr, "none") == 0)
-			goto free_line;
+	snprintf(path_buff, sizeof(path_buff), SYS_IFACE_STATUS_FMT, ifname);
+	ret = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	if (ret != EXIT_SUCCESS)
+		status = "<error reading status>\n";
+	else
+		status = line_ptr;
 
-		if (strcmp(line_ptr, mesh_iface) != 0)
-			goto free_line;
+	printf("%s: %s", ifname, status);
 
-		free(line_ptr);
-		line_ptr = NULL;
+	free(line_ptr);
+	line_ptr = NULL;
 
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-		if (res != EXIT_SUCCESS) {
-			fprintf(stderr, "<error reading status>\n");
-			continue;
-		}
+err:
+	return NL_OK;
+}
 
-		printf("%s: %s", iface_dir->d_name, line_ptr);
+static int print_interfaces(char *mesh_iface)
+{
+	struct print_interfaces_rtnl_arg print_arg;
 
-free_line:
-		free(line_ptr);
-		line_ptr = NULL;
+	if (!file_exists(module_ver_path)) {
+		fprintf(stderr, "Error - batman-adv module has not been loaded\n");
+		return EXIT_FAILURE;
 	}
 
-	free(path_buff);
-	closedir(iface_base_dir);
-	return EXIT_SUCCESS;
+	print_arg.ifindex = if_nametoindex(mesh_iface);
+	if (!print_arg.ifindex)
+		return EXIT_FAILURE;
 
-err_buff:
-	free(path_buff);
-err:
-	return EXIT_FAILURE;
+	query_rtnl_link(print_arg.ifindex, print_interfaces_rtnl_parse,
+			&print_arg);
+
+	return EXIT_SUCCESS;
 }
 
 int interface(char *mesh_iface, int argc, char **argv)
-- 
2.9.3

