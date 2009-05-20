From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 20 May 2009 13:33:51 +0200
Message-Id: <1242819232-614-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1242819232-614-1-git-send-email-sven.eckelmann@gmx.de>
References: <1242819232-614-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] [batman] Reserve enough space for
	aligned netlink requests
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

We are currently telling the kernel that our netlink request has a
special aligned size due to the usage of NLMSG_LENGTH. We don't
provide enough space to send this data to the kernel and thus create
invalid reads by the kernel when calling the sendto. The alignment is
currently small enough that we cannot create page faults which makes
these invalid reads alone a nonfatal problem.
We should provide a buffer with the exact amount of data we write in
nlh.nlmsg_len or even more.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/route.c |  138 ++++++++++++++++++++++++++------------------------
 1 files changed, 72 insertions(+), 66 deletions(-)

diff --git a/batman/linux/route.c b/batman/linux/route.c
index 8fe6015..3ddce2e 100644
--- a/batman/linux/route.c
+++ b/batman/linux/route.c
@@ -182,11 +182,12 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	struct iovec iov;
 	struct msghdr msg;
 	struct nlmsghdr *nh;
-	struct {
+	struct req_s {
 		struct nlmsghdr nlh;
 		struct rtmsg rtm;
 		char buff[4 * (sizeof(struct rtattr) + 4)];
-	} req;
+	} *req;
+	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
 
 	iov.iov_base = buf;
 	iov.iov_len  = sizeof(buf);
@@ -227,8 +228,9 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	}
 
 
+	req = (struct req_s*)req_buf;
 	memset(&nladdr, 0, sizeof(struct sockaddr_nl));
-	memset(&req, 0, sizeof(req));
+	memset(req, 0, NLMSG_LENGTH(sizeof(struct req_s)));
 	memset(&msg, 0, sizeof(struct msghdr));
 
 	nladdr.nl_family = AF_NETLINK;
@@ -242,39 +244,39 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	if (src_ip != 0)
 		len += sizeof(struct rtattr) + 4;
 
-	req.nlh.nlmsg_len = NLMSG_LENGTH(len);
-	req.nlh.nlmsg_pid = getpid();
-	req.rtm.rtm_family = AF_INET;
-	req.rtm.rtm_table = rt_table;
-	req.rtm.rtm_dst_len = netmask;
+	req->nlh.nlmsg_len = NLMSG_LENGTH(len);
+	req->nlh.nlmsg_pid = getpid();
+	req->rtm.rtm_family = AF_INET;
+	req->rtm.rtm_table = rt_table;
+	req->rtm.rtm_dst_len = netmask;
 
 	if (route_action == ROUTE_DEL) {
 
-		req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
-		req.nlh.nlmsg_type = RTM_DELROUTE;
-		req.rtm.rtm_scope = RT_SCOPE_NOWHERE;
+		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+		req->nlh.nlmsg_type = RTM_DELROUTE;
+		req->rtm.rtm_scope = RT_SCOPE_NOWHERE;
 
 	} else {
 
-		req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_APPEND;
-		req.nlh.nlmsg_type = RTM_NEWROUTE;
+		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_APPEND;
+		req->nlh.nlmsg_type = RTM_NEWROUTE;
 
 		if (route_type == ROUTE_TYPE_UNICAST && my_router == 0 && src_ip != 0)
-			req.rtm.rtm_scope = RT_SCOPE_LINK;
+			req->rtm.rtm_scope = RT_SCOPE_LINK;
 		else
-			req.rtm.rtm_scope = RT_SCOPE_UNIVERSE;
+			req->rtm.rtm_scope = RT_SCOPE_UNIVERSE;
 
-		req.rtm.rtm_protocol = RTPROT_STATIC; /* may be changed to some batman specific value - see <linux/rtnetlink.h> */
+		req->rtm.rtm_protocol = RTPROT_STATIC; /* may be changed to some batman specific value - see <linux/rtnetlink.h> */
 
 		switch(route_type) {
 		case ROUTE_TYPE_UNICAST:
-			req.rtm.rtm_type = RTN_UNICAST;
+			req->rtm.rtm_type = RTN_UNICAST;
 			break;
 		case ROUTE_TYPE_THROW:
-			req.rtm.rtm_type = RTN_THROW;
+			req->rtm.rtm_type = RTN_THROW;
 			break;
 		case ROUTE_TYPE_UNREACHABLE:
-			req.rtm.rtm_type = RTN_UNREACHABLE;
+			req->rtm.rtm_type = RTN_UNREACHABLE;
 			break;
 		default:
 			debug_output(0, "Error - unknown route type (add_del_route): %i\n", route_type);
@@ -282,28 +284,28 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 		}
 	}
 
-	rta = (struct rtattr *)req.buff;
+	rta = (struct rtattr *)req->buff;
 	rta->rta_type = RTA_DST;
 	rta->rta_len = sizeof(struct rtattr) + 4;
-	memcpy(((char *)&req.buff) + sizeof(struct rtattr), (char *)&dest, 4);
+	memcpy(((char *)req->buff) + sizeof(struct rtattr), (char *)&dest, 4);
 
 	if (route_type == ROUTE_TYPE_UNICAST) {
 
-		rta = (struct rtattr *)(req.buff + sizeof(struct rtattr) + 4);
+		rta = (struct rtattr *)(req->buff + sizeof(struct rtattr) + 4);
 		rta->rta_type = RTA_GATEWAY;
 		rta->rta_len = sizeof(struct rtattr) + 4;
-		memcpy(((char *)&req.buff) + 2 * sizeof(struct rtattr) + 4, (char *)&my_router, 4);
+		memcpy(((char *)req->buff) + 2 * sizeof(struct rtattr) + 4, (char *)&my_router, 4);
 
-		rta = (struct rtattr *)(req.buff + 2 * sizeof(struct rtattr) + 8);
+		rta = (struct rtattr *)(req->buff + 2 * sizeof(struct rtattr) + 8);
 		rta->rta_type = RTA_OIF;
 		rta->rta_len = sizeof(struct rtattr) + 4;
-		memcpy(((char *)&req.buff) + 3 * sizeof(struct rtattr) + 8, (char *)&ifi, 4);
+		memcpy(((char *)req->buff) + 3 * sizeof(struct rtattr) + 8, (char *)&ifi, 4);
 
 		if (src_ip != 0) {
-			rta = (struct rtattr *)(req.buff + 3 * sizeof(struct rtattr) + 12);
+			rta = (struct rtattr *)(req->buff + 3 * sizeof(struct rtattr) + 12);
 			rta->rta_type = RTA_PREFSRC;
 			rta->rta_len = sizeof(struct rtattr) + 4;
-			memcpy(((char *)&req.buff) + 4 * sizeof(struct rtattr) + 12, (char *)&src_ip, 4);
+			memcpy(((char *)req->buff) + 4 * sizeof(struct rtattr) + 12, (char *)&src_ip, 4);
 		}
 
 	}
@@ -315,7 +317,7 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 
 	}
 
-	if (sendto(netlink_sock, &req, req.nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
+	if (sendto(netlink_sock, req, req->nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
 
 		debug_output(0, "Error - can't send message to kernel via netlink socket for routing table manipulation: %s\n", strerror(errno));
 		close(netlink_sock);
@@ -364,11 +366,12 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	struct iovec iov;
 	struct msghdr msg;
 	struct nlmsghdr *nh;
-	struct {
+	struct req_s {
 		struct nlmsghdr nlh;
 		struct rtmsg rtm;
 		char buff[2 * (sizeof(struct rtattr) + 4)];
-	} req;
+	} *req;
+	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
 
 	iov.iov_base = buf;
 	iov.iov_len  = sizeof(buf);
@@ -382,8 +385,9 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	}
 
 
+	req = (struct req_s*)req_buf;
 	memset(&nladdr, 0, sizeof(struct sockaddr_nl));
-	memset(&req, 0, sizeof(req));
+	memset(req, 0, NLMSG_LENGTH(sizeof(struct req_s)));
 	memset(&msg, 0, sizeof(struct msghdr));
 
 	nladdr.nl_family = AF_NETLINK;
@@ -393,53 +397,53 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	if (prio != 0)
 		len += sizeof(struct rtattr) + 4;
 
-	req.nlh.nlmsg_len = NLMSG_LENGTH(len);
-	req.nlh.nlmsg_pid = getpid();
-	req.rtm.rtm_family = AF_INET;
-	req.rtm.rtm_table = rt_table;
+	req->nlh.nlmsg_len = NLMSG_LENGTH(len);
+	req->nlh.nlmsg_pid = getpid();
+	req->rtm.rtm_family = AF_INET;
+	req->rtm.rtm_table = rt_table;
 
 
 	if (rule_action == RULE_DEL) {
 
-		req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
-		req.nlh.nlmsg_type = RTM_DELRULE;
-		req.rtm.rtm_scope = RT_SCOPE_NOWHERE;
+		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+		req->nlh.nlmsg_type = RTM_DELRULE;
+		req->rtm.rtm_scope = RT_SCOPE_NOWHERE;
 
 	} else {
 
-		req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
-		req.nlh.nlmsg_type = RTM_NEWRULE;
-		req.rtm.rtm_scope = RT_SCOPE_UNIVERSE;
-		req.rtm.rtm_protocol = RTPROT_STATIC;
-		req.rtm.rtm_type = RTN_UNICAST;
+		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
+		req->nlh.nlmsg_type = RTM_NEWRULE;
+		req->rtm.rtm_scope = RT_SCOPE_UNIVERSE;
+		req->rtm.rtm_protocol = RTPROT_STATIC;
+		req->rtm.rtm_type = RTN_UNICAST;
 
 	}
 
 	switch(rule_type) {
 	case RULE_TYPE_SRC:
-		rta = (struct rtattr *)req.buff;
+		rta = (struct rtattr *)req->buff;
 		rta->rta_type = RTA_SRC;
-		req.rtm.rtm_src_len = netmask;
+		req->rtm.rtm_src_len = netmask;
 		rta->rta_len = sizeof(struct rtattr) + 4;
-		memcpy(((char *)&req.buff) + sizeof(struct rtattr), (char *)&network, 4);
+		memcpy(((char *)req->buff) + sizeof(struct rtattr), (char *)&network, 4);
 		break;
 	case RULE_TYPE_DST:
-		rta = (struct rtattr *)req.buff;
+		rta = (struct rtattr *)req->buff;
 		rta->rta_type = RTA_DST;
-		req.rtm.rtm_dst_len = netmask;
+		req->rtm.rtm_dst_len = netmask;
 		rta->rta_len = sizeof(struct rtattr) + 4;
-		memcpy(((char *)&req.buff) + sizeof(struct rtattr), (char *)&network, 4);
+		memcpy(((char *)req->buff) + sizeof(struct rtattr), (char *)&network, 4);
 		break;
 	case RULE_TYPE_IIF:
-		rta = (struct rtattr *)req.buff;
+		rta = (struct rtattr *)req->buff;
 		rta->rta_len = sizeof(struct rtattr) + 4;
 
 		if (rule_action == RULE_DEL) {
 			rta->rta_type = RTA_SRC;
-			memcpy(((char *)&req.buff) + sizeof(struct rtattr), (char *)&network, 4);
+			memcpy(((char *)req->buff) + sizeof(struct rtattr), (char *)&network, 4);
 		} else {
 			rta->rta_type = RTA_IIF;
-			memcpy(((char *)&req.buff) + sizeof(struct rtattr), iif, 4);
+			memcpy(((char *)req->buff) + sizeof(struct rtattr), iif, 4);
 		}
 		break;
 	default:
@@ -448,10 +452,10 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	}
 
 	if (prio != 0) {
-		rta = (struct rtattr *)(req.buff + sizeof(struct rtattr) + 4);
+		rta = (struct rtattr *)(req->buff + sizeof(struct rtattr) + 4);
 		rta->rta_type = RTA_PRIORITY;
 		rta->rta_len = sizeof(struct rtattr) + 4;
-		memcpy(((char *)&req.buff) + 2 * sizeof(struct rtattr) + 4, (char *)&prio, 4);
+		memcpy(((char *)req->buff) + 2 * sizeof(struct rtattr) + 4, (char *)&prio, 4);
 	}
 
 
@@ -463,7 +467,7 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	}
 
 
-	if (sendto(netlink_sock, &req, req.nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0)  {
+	if (sendto(netlink_sock, req, req->nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0)  {
 
 		debug_output( 0, "Error - can't send message to kernel via netlink socket for routing rule manipulation: %s\n", strerror(errno));
 		close(netlink_sock);
@@ -628,29 +632,31 @@ int flush_routes_rules(int8_t is_rule)
 	struct msghdr msg;
 	struct nlmsghdr *nh;
 	struct rtmsg *rtm;
-	struct {
+	struct req_s {
 		struct nlmsghdr nlh;
 		struct rtmsg rtm;
-	} req;
+	} *req;
+	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
+
 	struct rtattr *rtap;
 
 	iov.iov_base = buf;
 	iov.iov_len  = sizeof(buf);
 
-
+	req = (struct req_s*)req_buf;
 	memset(&nladdr, 0, sizeof(struct sockaddr_nl));
-	memset(&req, 0, sizeof(req));
+	memset(req, 0, NLMSG_LENGTH(sizeof(struct req_s)));
 	memset(&msg, 0, sizeof(struct msghdr));
 
 	nladdr.nl_family = AF_NETLINK;
 
-	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req));
-	req.nlh.nlmsg_pid = getpid();
-	req.rtm.rtm_family = AF_INET;
+	req->nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct req_s));
+	req->nlh.nlmsg_pid = getpid();
+	req->rtm.rtm_family = AF_INET;
 
-	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	req.nlh.nlmsg_type = (is_rule ? RTM_GETRULE : RTM_GETROUTE);
-	req.rtm.rtm_scope = RTN_UNICAST;
+	req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	req->nlh.nlmsg_type = (is_rule ? RTM_GETRULE : RTM_GETROUTE);
+	req->rtm.rtm_scope = RTN_UNICAST;
 
 	if ((netlink_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE)) < 0) {
 
@@ -660,7 +666,7 @@ int flush_routes_rules(int8_t is_rule)
 	}
 
 
-	if (sendto(netlink_sock, &req, req.nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
+	if (sendto(netlink_sock, req, req->nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
 
 		debug_output(0, "Error - can't send message to kernel via netlink socket for flushing the routing table: %s\n", strerror(errno));
 		close(netlink_sock);
-- 
1.6.3.1

