Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  3 Apr 2019 20:01:17 +0200
Message-Id: <20190403180119.26800-2-sven@narfation.org>
In-Reply-To: <20190403180119.26800-1-sven@narfation.org>
References: <20190403180119.26800-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Support checking of meshif
 without sysfs
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

batctl checks whether the supplied interface is a batadv interface. And for
hardif filters, whether this hardif is part of the selected meshif. This
was done traditionally using the sysfs files which batman-adv creates.

It is now possible to build the kernel module without sysfs support. These
checks must therefore also work when sysfs is not available. And since the
sysfs interface support was replaced in batctl by netlink commands, the
check should also be implemented using using NETLINK_ROUTE.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c     |   2 +-
 functions.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++-----
 functions.h |   2 +-
 3 files changed, 176 insertions(+), 20 deletions(-)

diff --git a/debug.c b/debug.c
index 4a3b6cb..597d59c 100644
--- a/debug.c
+++ b/debug.c
@@ -115,7 +115,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 
-			if (check_mesh_iface_ownership(state->mesh_iface, optarg) != EXIT_SUCCESS)
+			if (check_mesh_iface_ownership(state, optarg) != EXIT_SUCCESS)
 				return EXIT_FAILURE;
 
 			orig_iface = optarg;
diff --git a/functions.c b/functions.c
index 9720257..b52db08 100644
--- a/functions.c
+++ b/functions.c
@@ -1039,37 +1039,178 @@ int translate_mesh_iface(struct state *state)
 	return 0;
 }
 
-int check_mesh_iface(struct state *state)
+struct rtnl_link_iface_data {
+	uint8_t kind_found:1;
+	uint8_t master_found:1;
+	char kind[IF_NAMESIZE];
+	unsigned int master;
+};
+
+static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
+{
+	static struct nla_policy link_policy[IFLA_MAX + 1] = {
+		[IFLA_LINKINFO] = { .type = NLA_NESTED },
+		[IFLA_MASTER] = { .type = NLA_U32 },
+	};
+	static struct nla_policy link_info_policy[IFLA_INFO_MAX + 1] = {
+		[IFLA_INFO_KIND] = { .type = NLA_STRING },
+	};
+
+	struct rtnl_link_iface_data *link_data = arg;
+	struct nlattr *li[IFLA_INFO_MAX + 1];
+	struct nlmsghdr *n = nlmsg_hdr(msg);
+	struct nlattr *tb[IFLA_MAX + 1];
+	char *type;
+	int ret;
+
+	if (!nlmsg_valid_hdr(n, sizeof(struct ifinfomsg)))
+		return NL_OK;
+
+	ret = nlmsg_parse(n, sizeof(struct ifinfomsg), tb, IFLA_MAX,
+			  link_policy);
+	if (ret < 0)
+		return NL_OK;
+
+	if (tb[IFLA_MASTER]) {
+		link_data->master = nla_get_u32(tb[IFLA_MASTER]);
+		link_data->master_found = true;
+	}
+
+	/* parse subattributes linkinfo */
+	if (!tb[IFLA_LINKINFO])
+		return NL_OK;
+
+	ret = nla_parse_nested(li, IFLA_INFO_MAX, tb[IFLA_LINKINFO],
+			       link_info_policy);
+	if (ret < 0)
+		return NL_OK;
+
+	if (li[IFLA_INFO_KIND]) {
+		type = nla_get_string(li[IFLA_INFO_KIND]);
+		strncpy(link_data->kind, type, sizeof(link_data->kind));
+		link_data->kind[sizeof(link_data->kind) - 1] = '\0';
+
+		link_data->kind_found = true;
+	}
+
+	return NL_STOP;
+}
+
+static int query_rtnl_link_single(int mesh_ifindex,
+				  struct rtnl_link_iface_data *link_data)
+{
+	struct ifinfomsg ifinfo = {
+		.ifi_family = AF_UNSPEC,
+		.ifi_index = mesh_ifindex,
+	};
+	struct nl_cb *cb = NULL;
+	struct nl_sock *sock;
+	int ret;
+
+	link_data->kind_found = false;
+	link_data->master_found = false;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -1;
+
+	ret = nl_connect(sock, NETLINK_ROUTE);
+	if (ret < 0)
+		goto free_sock;
+
+	ret = nl_send_simple(sock, RTM_GETLINK, NLM_F_REQUEST,
+			     &ifinfo, sizeof(ifinfo));
+	if (ret < 0)
+		goto free_sock;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		goto free_sock;
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, query_rtnl_link_single_parse,
+		  link_data);
+	nl_recvmsgs(sock, cb);
+
+	nl_cb_put(cb);
+free_sock:
+	nl_socket_free(sock);
+
+	return 0;
+}
+
+int check_mesh_iface_netlink(struct state *state)
+{
+	struct rtnl_link_iface_data link_data;
+
+	query_rtnl_link_single(state->mesh_ifindex, &link_data);
+	if (!link_data.kind_found)
+		return -1;
+
+	if (strcmp(link_data.kind, "batadv") != 0)
+		return -1;
+
+	return 0;
+}
+
+static int check_mesh_iface_sysfs(struct state *state)
 {
 	char path_buff[PATH_BUFF_LEN];
-	int ret = -1;
 	DIR *dir;
 
-	/* use the parent interface if this is a VLAN */
-	if (state->vid >= 0)
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH,
-			 state->mesh_iface, state->vid);
-	else
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT,
-			 state->mesh_iface);
-
 	/* try to open the mesh sys directory */
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT,
+		 state->mesh_iface);
+
 	dir = opendir(path_buff);
 	if (!dir)
-		goto out;
+		return -1;
 
 	closedir(dir);
 
+	return 0;
+}
+
+int check_mesh_iface(struct state *state)
+{
+	int ret;
+
 	state->mesh_ifindex = if_nametoindex(state->mesh_iface);
 	if (state->mesh_ifindex == 0)
-		goto out;
+		return -1;
 
-	ret = 0;
-out:
-	return ret;
+	ret = check_mesh_iface_netlink(state);
+	if (ret == 0)
+		return ret;
+
+	ret = check_mesh_iface_sysfs(state);
+	if (ret == 0)
+		return ret;
+
+	return -1;
 }
 
-int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
+static int check_mesh_iface_ownership_netlink(struct state *state,
+					      char *hard_iface)
+{
+	struct rtnl_link_iface_data link_data;
+	unsigned int hardif_index;
+
+	hardif_index = if_nametoindex(hard_iface);
+	if (hardif_index == 0)
+		return EXIT_FAILURE;
+
+	query_rtnl_link_single(hardif_index, &link_data);
+	if (!link_data.master_found)
+		return EXIT_FAILURE;
+
+	if (state->mesh_ifindex != link_data.master)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static int check_mesh_iface_ownership_sysfs(struct state *state,
+					    char *hard_iface)
 {
 	char path_buff[PATH_BUFF_LEN];
 	int res;
@@ -1087,15 +1228,30 @@ int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
 	if (line_ptr[strlen(line_ptr) - 1] == '\n')
 		line_ptr[strlen(line_ptr) - 1] = '\0';
 
-	if (strcmp(line_ptr, mesh_iface) != 0) {
+	if (strcmp(line_ptr, state->mesh_iface) != 0) {
 		fprintf(stderr, "Error - interface %s is part of batman network %s, not %s\n",
-			hard_iface, line_ptr, mesh_iface);
+			hard_iface, line_ptr, state->mesh_iface);
 		return EXIT_FAILURE;
 	}
 
 	return EXIT_SUCCESS;
 }
 
+int check_mesh_iface_ownership(struct state *state, char *hard_iface)
+{
+	int ret;
+
+	ret = check_mesh_iface_ownership_netlink(state, hard_iface);
+	if (ret == EXIT_SUCCESS)
+		return EXIT_SUCCESS;
+
+	ret = check_mesh_iface_ownership_sysfs(state, hard_iface);
+	if (ret == EXIT_SUCCESS)
+		return ret;
+
+	return EXIT_FAILURE;
+}
+
 static int get_random_bytes_syscall(void *buf __maybe_unused,
 				    size_t buflen __maybe_unused)
 {
diff --git a/functions.h b/functions.h
index 23186e5..02f7823 100644
--- a/functions.h
+++ b/functions.h
@@ -53,7 +53,7 @@ int netlink_simple_request(struct nl_msg *msg);
 int translate_mesh_iface(struct state *state);
 int get_algoname(const char *mesh_iface, char *algoname, size_t algoname_len);
 int check_mesh_iface(struct state *state);
-int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
+int check_mesh_iface_ownership(struct state *state, char *hard_iface);
 
 void get_random_bytes(void *buf, size_t buflen);
 void check_root_or_die(const char *cmd);
-- 
2.20.1

