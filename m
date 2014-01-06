Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  6 Jan 2014 20:37:24 +0100
Message-Id: <1389037044-27530-3-git-send-email-sven@narfation.org>
In-Reply-To: <1389037044-27530-1-git-send-email-sven@narfation.org>
References: <6312194.LhI8hzXjyH@bentobox>
 <1389037044-27530-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: Use libnl to implement vlan
	parent device resolver
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

It is not necessary to have code duplicated which is already available in
libraries like libnl-3.0 or libnl-tiny. This is done to reduce maintenance and
security risks.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 274 ++++++++++++++++++++++++------------------------------------
 1 file changed, 110 insertions(+), 164 deletions(-)

diff --git a/functions.c b/functions.c
index c21431c..36804bd 100644
--- a/functions.c
+++ b/functions.c
@@ -461,50 +461,6 @@ static int resolve_l3addr(int ai_family, const char *asc, void *l3addr)
 	return ret;
 }
 
-/**
- * batadv_rtnl_open - open a socket to rtnl and send a request
- * @nh: the header of the request to send
- * @protocol: the protocol to use when opening the socket
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int batadv_rtnl_open(void *req, int protocol)
-{
-	static uint32_t nr_call = 0;
-	uint32_t pid = (++nr_call + getpid()) & 0x3FFFFF;
-	struct sockaddr_nl addrnl;
-	struct nlmsghdr *nh;
-	int socknl;
-	int ret;
-
-	memset(&addrnl, 0, sizeof(addrnl));
-	addrnl.nl_family = AF_NETLINK;
-	addrnl.nl_pid = pid;
-	addrnl.nl_groups = 0;
-
-	socknl = socket(AF_NETLINK, SOCK_RAW, protocol);
-	if (socknl < 0)
-		goto out;
-
-	ret = bind(socknl, (struct sockaddr*)&addrnl, sizeof(addrnl));
-	if (ret < 0)
-		goto outclose;
-
-	/* the nlmsghdr object must always be the first member in the req
-	 * structure
-	 */
-	nh = (struct nlmsghdr *)req;
-
-	ret = send(socknl, nh, nh->nlmsg_len, 0);
-	if (ret < 0)
-		goto outclose;
-out:
-	return socknl;
-outclose:
-	close(socknl);
-	return ret;
-}
-
 static void request_mac_resolve(int ai_family, const void *l3addr)
 {
 	const struct sockaddr *sockaddr;
@@ -722,125 +678,95 @@ out:
 	return mac_result;
 }
 
+struct vlan_get_link_nl_arg {
+	char *iface;
+	int vid;
+};
+
+static struct nla_policy info_data_link_policy[IFLA_MAX + 1] = {
+	[IFLA_LINKINFO]	= { .type = NLA_NESTED },
+	[IFLA_LINK]	= { .type = NLA_U32 },
+};
+
+static struct nla_policy info_data_link_info_policy[IFLA_INFO_MAX + 1] = {
+	[IFLA_INFO_DATA]	= { .type = NLA_NESTED },
+};
+
+static struct nla_policy vlan_policy[IFLA_VLAN_MAX + 1] = {
+	[IFLA_VLAN_ID]		= { .type = NLA_U16 },
+};
+
 /**
  * vlan_get_link_parse - parse a get_link rtnl message and extract the important
  *  data
- * @nh: the reply header
- * @iface: pointer to the buffer where the link interface has to be stored (it
- *  is allocated by this function)
+ * @msg: the reply msg
+ * @arg: pointer to the buffer which will store the return values
  *
- * Return the vid in case of success or -1 otherwise
+ * Saves the vid  in arg::vid in case of success or -1 otherwise
  */
-static int vlan_get_link_parse(struct nlmsghdr *nh, char **iface)
+static int vlan_get_link_parse(struct nl_msg *msg, void *arg)
 {
-	struct ifinfomsg *ifi = NLMSG_DATA(nh);
-	size_t vlan_len, info_len, len = nh->nlmsg_len;
-	struct rtattr *rta, *info, *vlan;
-	int idx = -1, vid = -1;
-
-	*iface = NULL;
-
-	rta = IFLA_RTA(ifi);
-	while (RTA_OK(rta, len)) {
-		/* check if the interface is a vlan */
-		if (rta->rta_type == IFLA_LINKINFO) {
-			info = RTA_DATA(rta);
-			info_len = RTA_PAYLOAD(rta);
-
-			while (RTA_OK(info, info_len)) {
-				if (info->rta_type == IFLA_INFO_KIND &&
-				    strcmp(RTA_DATA(info), "vlan"))
-					goto err;
-
-				if (info->rta_type == IFLA_INFO_DATA) {
-					vlan = RTA_DATA(info);
-					vlan_len = RTA_PAYLOAD(info);
-
-					while (RTA_OK(vlan, vlan_len)) {
-						if (vlan->rta_type == IFLA_VLAN_ID)
-							vid = *(int *)RTA_DATA(vlan);
-						vlan = RTA_NEXT(vlan, vlan_len);
-					}
-				}
-				info = RTA_NEXT(info, info_len);
-			}
-		}
+	struct vlan_get_link_nl_arg *nl_arg = arg;
+	struct nlmsghdr *n = nlmsg_hdr(msg);
+	struct nlattr *tb[IFLA_MAX + 1];
+	struct nlattr *li[IFLA_INFO_MAX + 1];
+	struct nlattr *vi[IFLA_VLAN_MAX + 1];
+	int ret;
+	int idx;
 
-		/* extract the name of the "link" interface */
-		if (rta->rta_type == IFLA_LINK) {
-			idx = *(int *)RTA_DATA(rta);
+	if (!nlmsg_valid_hdr(n, sizeof(struct ifinfomsg)))
+		return -NLE_MSG_TOOSHORT;
 
-			*iface = malloc(IFNAMSIZ + 1);
-			if (!if_indextoname(idx, *iface))
-				goto err;
-		}
-		rta = RTA_NEXT(rta, len);
-	}
+	ret = nlmsg_parse(n, sizeof(struct ifinfomsg), tb, IFLA_MAX,
+			  info_data_link_policy);
+	if (ret < 0)
+		return ret;
 
-	if (vid == -1)
-		goto err;
+	if (!tb[IFLA_LINK])
+		return -NLE_MISSING_ATTR;
 
-	if (idx <= 0)
-		goto err;
+	/* parse subattributes linkinfo */
+	if (!tb[IFLA_LINKINFO])
+		return -NLE_MISSING_ATTR;
 
-	return vid;
-err:
-	free(*iface);
-	return -1;
-}
+	ret = nla_parse_nested(li, IFLA_INFO_MAX, tb[IFLA_LINKINFO],
+			       info_data_link_info_policy);
+	if (ret < 0)
+		return ret;
 
-/**
- * vlan_get_link_dump - receive and dump a get_link rtnl reply
- * @sock: the socket to listen for the reply on
- * @buf: buffer where the reply has to be dumped to
- * @buflen: length of the buffer
- *
- * Returns the amount of dumped bytes
- */
-static ssize_t vlan_get_link_dump(int sock, void *buf, size_t buflen)
-{
-	struct sockaddr_nl nladdr;
-	struct msghdr msg;
-	struct iovec iov;
+	if (!li[IFLA_INFO_KIND])
+		return -NLE_MISSING_ATTR;
 
-	memset(&msg, 0, sizeof(msg));
-	memset(&iov, 0, sizeof(iov));
+	if (strcmp(nla_data(li[IFLA_INFO_KIND]), "vlan") != 0)
+		goto err;
 
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-	msg.msg_controllen = 0;
-	msg.msg_control = NULL;
-	msg.msg_flags = 0;
-	msg.msg_name = &nladdr;
-	msg.msg_namelen = sizeof(nladdr);
+	/* parse subattributes info_data for vlan */
+	if (!li[IFLA_INFO_DATA])
+		return -NLE_MISSING_ATTR;
 
-	iov.iov_len = buflen;
-	iov.iov_base = buf;
+	ret = nla_parse_nested(vi, IFLA_VLAN_MAX, li[IFLA_INFO_DATA],
+			       vlan_policy);
+	if (ret < 0)
+		return ret;
 
-	return recvmsg(sock, &msg, 0);
-}
+	if (!vi[IFLA_VLAN_ID])
+		return -NLE_MISSING_ATTR;
 
-/**
- * vlan_get_link_open - send a get_link request
- * @ifname: the interface to query
- *
- * Returns 0 in case of success or a negative error code otherwise
- */
-static int vlan_get_link_open(const char *ifname)
-{
-	struct {
-		struct nlmsghdr hdr;
-		struct ifinfomsg ifi;
-	} nlreq;
-
-	memset(&nlreq, 0, sizeof(nlreq));
-	nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.ifi));
-	nlreq.hdr.nlmsg_type = RTM_GETLINK;
-	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST;
-	nlreq.ifi.ifi_family = AF_UNSPEC;
-	nlreq.ifi.ifi_index = if_nametoindex(ifname);
-
-	return batadv_rtnl_open(&nlreq, 0);
+	/* get parent link name */
+	idx = *(int *)nla_data(tb[IFLA_LINK]);
+	free(nl_arg->iface);
+	nl_arg->iface = malloc(IFNAMSIZ + 1);
+	if (!if_indextoname(idx, nl_arg->iface))
+		goto err;
+
+	/* get the corresponding vid */
+	nl_arg->vid = *(int *)nla_data(vi[IFLA_VLAN_ID]);
+
+err:
+	if (nl_arg->vid >= 0)
+		return NL_STOP;
+	else
+		return NL_OK;
 }
 
 /**
@@ -853,29 +779,49 @@ static int vlan_get_link_open(const char *ifname)
  */
 int vlan_get_link(const char *ifname, char **parent)
 {
-	int vid = -1, socknl;
-	void *buf = NULL;
-	size_t buflen;
-	ssize_t len;
-
-	buflen = 8192;
-	buf = malloc(buflen);
-	if (!buf)
+	struct nl_sock *sock;
+	int ret;
+	struct ifinfomsg ifinfo = {
+		.ifi_family = AF_UNSPEC,
+		.ifi_index = if_nametoindex(ifname),
+	};
+	struct nl_cb *cb = NULL;
+	struct vlan_get_link_nl_arg arg = {
+		.iface = NULL,
+		.vid = -1,
+	};
+
+	*parent = NULL;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		goto err;
+
+	ret = nl_connect(sock, NETLINK_ROUTE);
+	if (ret < 0)
+		goto err;
+
+	ret = nl_send_simple(sock, RTM_GETLINK, NLM_F_REQUEST,
+			     &ifinfo, sizeof(ifinfo));
+	if (ret < 0)
 		goto err;
 
-	socknl = vlan_get_link_open(ifname);
-	if (socknl < 0)
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
 		goto err;
 
-	len = vlan_get_link_dump(socknl, buf, buflen);
-	if (len < 0)
-		goto err_sock;
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, vlan_get_link_parse, &arg);
+	ret = nl_recvmsgs(sock, cb);
+	if (ret < 0)
+		goto err;
 
-	vid = vlan_get_link_parse(buf, parent);
+	*parent = arg.iface;
 
-err_sock:
-	close(socknl);
 err:
-	free(buf);
-	return vid;
+	if (cb)
+		nl_cb_put(cb);
+	if (sock)
+		nl_socket_free(sock);
+
+	return arg.vid;
 }
-- 
1.8.5.2

