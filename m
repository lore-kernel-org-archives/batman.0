Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  3 Apr 2019 20:01:18 +0200
Message-Id: <20190403180119.26800-3-sven@narfation.org>
In-Reply-To: <20190403180119.26800-1-sven@narfation.org>
References: <20190403180119.26800-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Reimplement VLAN translation
 using helper
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

The functionality to translate VLAN interfaces to mesh interfaces and VID
is using NETLINK_ROUTE like the query_rtnl_link_single helper function.
Only minimal changes are required to also provide the link to the
underlying device and the VID.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 229 ++++++++++++++++------------------------------------
 1 file changed, 71 insertions(+), 158 deletions(-)

diff --git a/functions.c b/functions.c
index b52db08..bb7f517 100644
--- a/functions.c
+++ b/functions.c
@@ -760,149 +760,6 @@ struct ether_addr *resolve_mac(const char *asc)
 	return mac_result;
 }
 
-struct vlan_get_link_nl_arg {
-	char *iface;
-	int vid;
-};
-
-static struct nla_policy info_data_link_policy[IFLA_MAX + 1] = {
-	[IFLA_LINKINFO]	= { .type = NLA_NESTED },
-	[IFLA_LINK]	= { .type = NLA_U32 },
-};
-
-static struct nla_policy info_data_link_info_policy[IFLA_INFO_MAX + 1] = {
-	[IFLA_INFO_DATA]	= { .type = NLA_NESTED },
-};
-
-static struct nla_policy vlan_policy[IFLA_VLAN_MAX + 1] = {
-	[IFLA_VLAN_ID]		= { .type = NLA_U16 },
-};
-
-/**
- * vlan_get_link_parse - parse a get_link rtnl message and extract the important
- *  data
- * @msg: the reply msg
- * @arg: pointer to the buffer which will store the return values
- *
- * Saves the vid  in arg::vid in case of success or -1 otherwise
- */
-static int vlan_get_link_parse(struct nl_msg *msg, void *arg)
-{
-	struct vlan_get_link_nl_arg *nl_arg = arg;
-	struct nlmsghdr *n = nlmsg_hdr(msg);
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct nlattr *li[IFLA_INFO_MAX + 1];
-	struct nlattr *vi[IFLA_VLAN_MAX + 1];
-	int ret;
-	int idx;
-
-	if (!nlmsg_valid_hdr(n, sizeof(struct ifinfomsg)))
-		return -NLE_MSG_TOOSHORT;
-
-	ret = nlmsg_parse(n, sizeof(struct ifinfomsg), tb, IFLA_MAX,
-			  info_data_link_policy);
-	if (ret < 0)
-		return ret;
-
-	if (!tb[IFLA_LINK])
-		return -NLE_MISSING_ATTR;
-
-	/* parse subattributes linkinfo */
-	if (!tb[IFLA_LINKINFO])
-		return -NLE_MISSING_ATTR;
-
-	ret = nla_parse_nested(li, IFLA_INFO_MAX, tb[IFLA_LINKINFO],
-			       info_data_link_info_policy);
-	if (ret < 0)
-		return ret;
-
-	if (!li[IFLA_INFO_KIND])
-		return -NLE_MISSING_ATTR;
-
-	if (strcmp(nla_data(li[IFLA_INFO_KIND]), "vlan") != 0)
-		goto err;
-
-	/* parse subattributes info_data for vlan */
-	if (!li[IFLA_INFO_DATA])
-		return -NLE_MISSING_ATTR;
-
-	ret = nla_parse_nested(vi, IFLA_VLAN_MAX, li[IFLA_INFO_DATA],
-			       vlan_policy);
-	if (ret < 0)
-		return ret;
-
-	if (!vi[IFLA_VLAN_ID])
-		return -NLE_MISSING_ATTR;
-
-	/* get parent link name */
-	idx = *(int *)nla_data(tb[IFLA_LINK]);
-
-	if (!if_indextoname(idx, nl_arg->iface))
-		goto err;
-
-	/* get the corresponding vid */
-	nl_arg->vid = *(int *)nla_data(vi[IFLA_VLAN_ID]);
-
-err:
-	if (nl_arg->vid >= 0)
-		return NL_STOP;
-	else
-		return NL_OK;
-}
-
-/**
- * vlan_get_link - convert a VLAN interface into its parent one
- * @ifname: the interface to convert
- * @parent: buffer where the parent interface name will be written
- *  (minimum IF_NAMESIZE)
- *
- * Returns the vlan identifier on success or -1 on error
- */
-static int vlan_get_link(const char *ifname, char *parent)
-{
-	struct nl_sock *sock;
-	int ret;
-	struct ifinfomsg ifinfo = {
-		.ifi_family = AF_UNSPEC,
-		.ifi_index = if_nametoindex(ifname),
-	};
-	struct nl_cb *cb = NULL;
-	struct vlan_get_link_nl_arg arg = {
-		.iface = parent,
-		.vid = -1,
-	};
-
-	sock = nl_socket_alloc();
-	if (!sock)
-		goto err;
-
-	ret = nl_connect(sock, NETLINK_ROUTE);
-	if (ret < 0)
-		goto err;
-
-	ret = nl_send_simple(sock, RTM_GETLINK, NLM_F_REQUEST,
-			     &ifinfo, sizeof(ifinfo));
-	if (ret < 0)
-		goto err;
-
-	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	if (!cb)
-		goto err;
-
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, vlan_get_link_parse, &arg);
-	ret = nl_recvmsgs(sock, cb);
-	if (ret < 0)
-		goto err;
-
-err:
-	if (cb)
-		nl_cb_put(cb);
-	if (sock)
-		nl_socket_free(sock);
-
-	return arg.vid;
-}
-
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg)
 {
 	struct ifinfomsg rt_hdr = {
@@ -1025,25 +882,15 @@ int netlink_simple_request(struct nl_msg *msg)
 	return err;
 }
 
-int translate_mesh_iface(struct state *state)
-{
-	state->vid = vlan_get_link(state->arg_iface, state->mesh_iface);
-	if (state->vid < 0) {
-		/* if there is no iface then the argument must be the
-		 * mesh interface
-		 */
-		snprintf(state->mesh_iface, sizeof(state->mesh_iface), "%s",
-			 state->arg_iface);
-	}
-
-	return 0;
-}
-
 struct rtnl_link_iface_data {
 	uint8_t kind_found:1;
 	uint8_t master_found:1;
+	uint8_t link_found:1;
+	uint8_t vid_found:1;
 	char kind[IF_NAMESIZE];
 	unsigned int master;
+	unsigned int link;
+	uint16_t vid;
 };
 
 static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
@@ -1051,13 +898,19 @@ static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
 	static struct nla_policy link_policy[IFLA_MAX + 1] = {
 		[IFLA_LINKINFO] = { .type = NLA_NESTED },
 		[IFLA_MASTER] = { .type = NLA_U32 },
+		[IFLA_LINK] = { .type = NLA_U32 },
 	};
 	static struct nla_policy link_info_policy[IFLA_INFO_MAX + 1] = {
 		[IFLA_INFO_KIND] = { .type = NLA_STRING },
+		[IFLA_INFO_DATA] = { .type = NLA_NESTED },
+	};
+	static struct nla_policy vlan_policy[IFLA_VLAN_MAX + 1] = {
+		[IFLA_VLAN_ID] = { .type = NLA_U16 },
 	};
 
 	struct rtnl_link_iface_data *link_data = arg;
 	struct nlattr *li[IFLA_INFO_MAX + 1];
+	struct nlattr *vi[IFLA_VLAN_MAX + 1];
 	struct nlmsghdr *n = nlmsg_hdr(msg);
 	struct nlattr *tb[IFLA_MAX + 1];
 	char *type;
@@ -1076,6 +929,11 @@ static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
 		link_data->master_found = true;
 	}
 
+	if (tb[IFLA_LINK]) {
+		link_data->link = nla_get_u32(tb[IFLA_LINK]);
+		link_data->link_found = true;
+	}
+
 	/* parse subattributes linkinfo */
 	if (!tb[IFLA_LINKINFO])
 		return NL_OK;
@@ -1093,6 +951,19 @@ static int query_rtnl_link_single_parse(struct nl_msg *msg, void *arg)
 		link_data->kind_found = true;
 	}
 
+	if (!li[IFLA_INFO_DATA])
+		return NL_OK;
+
+	ret = nla_parse_nested(vi, IFLA_VLAN_MAX, li[IFLA_INFO_DATA],
+			       vlan_policy);
+	if (ret < 0)
+		return NL_OK;
+
+	if (vi[IFLA_VLAN_ID]) {
+		link_data->vid = nla_get_u16(vi[IFLA_VLAN_ID]);
+		link_data->vid_found = true;
+	}
+
 	return NL_STOP;
 }
 
@@ -1109,6 +980,8 @@ static int query_rtnl_link_single(int mesh_ifindex,
 
 	link_data->kind_found = false;
 	link_data->master_found = false;
+	link_data->link_found = false;
+	link_data->vid_found = false;
 
 	sock = nl_socket_alloc();
 	if (!sock)
@@ -1138,7 +1011,47 @@ static int query_rtnl_link_single(int mesh_ifindex,
 	return 0;
 }
 
-int check_mesh_iface_netlink(struct state *state)
+int translate_mesh_iface(struct state *state)
+{
+	struct rtnl_link_iface_data link_data;
+	unsigned int arg_ifindex;
+
+	arg_ifindex = if_nametoindex(state->arg_iface);
+	if (arg_ifindex == 0)
+		goto fallback_meshif;
+
+	query_rtnl_link_single(arg_ifindex, &link_data);
+	if (!link_data.vid_found)
+		goto fallback_meshif;
+
+	if (!link_data.link_found)
+		goto fallback_meshif;
+
+	if (!link_data.kind_found)
+		goto fallback_meshif;
+
+	if (strcmp(link_data.kind, "vlan") != 0)
+		goto fallback_meshif;
+
+	if (!if_indextoname(link_data.link, state->mesh_iface))
+		goto fallback_meshif;
+
+	state->vid = link_data.vid;
+
+	return 0;
+
+fallback_meshif:
+	/* if there is no vid then the argument must be the
+	 * mesh interface
+	 */
+	snprintf(state->mesh_iface, sizeof(state->mesh_iface), "%s",
+		 state->arg_iface);
+	state->vid = -1;
+
+	return 0;
+}
+
+static int check_mesh_iface_netlink(struct state *state)
 {
 	struct rtnl_link_iface_data link_data;
 
-- 
2.20.1

