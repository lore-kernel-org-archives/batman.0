From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 20 May 2009 18:25:56 +0200
Message-Id: <1242836756-2491-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1242819232-614-3-git-send-email-sven.eckelmann@gmx.de>
References: <1242819232-614-3-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH2/2v2] [batman] Don't add size for netlink
	header twice in netlink request
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

The parameter len of NLMSG_LENGTH is only the size of the payload of
the request. If we use this function to calculate the size of the buffer
we send to the kernel we would add (sizeof(nlmsghdr)+padding) and the
size of our own structure which also has a nlmsghdr included. We must
split the req structure into a header part and the payload to calculate
the correct size of our buffer and having the payload always start at
the correct address.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/route.c |   56 +++++++++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/batman/linux/route.c b/batman/linux/route.c
index 3ddce2e..99c295f 100644
--- a/batman/linux/route.c
+++ b/batman/linux/route.c
@@ -183,7 +183,6 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	struct msghdr msg;
 	struct nlmsghdr *nh;
 	struct req_s {
-		struct nlmsghdr nlh;
 		struct rtmsg rtm;
 		char buff[4 * (sizeof(struct rtattr) + 4)];
 	} *req;
@@ -228,9 +227,10 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	}
 
 
-	req = (struct req_s*)req_buf;
+	nh = (struct nlmsghdr *)req_buf;
+	req = (struct req_s*)NLMSG_DATA(req_buf);
 	memset(&nladdr, 0, sizeof(struct sockaddr_nl));
-	memset(req, 0, NLMSG_LENGTH(sizeof(struct req_s)));
+	memset(req_buf, 0, NLMSG_LENGTH(sizeof(struct req_s)));
 	memset(&msg, 0, sizeof(struct msghdr));
 
 	nladdr.nl_family = AF_NETLINK;
@@ -244,22 +244,22 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 	if (src_ip != 0)
 		len += sizeof(struct rtattr) + 4;
 
-	req->nlh.nlmsg_len = NLMSG_LENGTH(len);
-	req->nlh.nlmsg_pid = getpid();
+	nh->nlmsg_len = NLMSG_LENGTH(len);
+	nh->nlmsg_pid = getpid();
 	req->rtm.rtm_family = AF_INET;
 	req->rtm.rtm_table = rt_table;
 	req->rtm.rtm_dst_len = netmask;
 
 	if (route_action == ROUTE_DEL) {
 
-		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
-		req->nlh.nlmsg_type = RTM_DELROUTE;
+		nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+		nh->nlmsg_type = RTM_DELROUTE;
 		req->rtm.rtm_scope = RT_SCOPE_NOWHERE;
 
 	} else {
 
-		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_APPEND;
-		req->nlh.nlmsg_type = RTM_NEWROUTE;
+		nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_APPEND;
+		nh->nlmsg_type = RTM_NEWROUTE;
 
 		if (route_type == ROUTE_TYPE_UNICAST && my_router == 0 && src_ip != 0)
 			req->rtm.rtm_scope = RT_SCOPE_LINK;
@@ -317,7 +317,7 @@ void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t src
 
 	}
 
-	if (sendto(netlink_sock, req, req->nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
+	if (sendto(netlink_sock, req_buf, nh->nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
 
 		debug_output(0, "Error - can't send message to kernel via netlink socket for routing table manipulation: %s\n", strerror(errno));
 		close(netlink_sock);
@@ -367,7 +367,6 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	struct msghdr msg;
 	struct nlmsghdr *nh;
 	struct req_s {
-		struct nlmsghdr nlh;
 		struct rtmsg rtm;
 		char buff[2 * (sizeof(struct rtattr) + 4)];
 	} *req;
@@ -385,9 +384,10 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	}
 
 
-	req = (struct req_s*)req_buf;
+	nh = (struct nlmsghdr *)req_buf;
+	req = (struct req_s*)NLMSG_DATA(req_buf);
 	memset(&nladdr, 0, sizeof(struct sockaddr_nl));
-	memset(req, 0, NLMSG_LENGTH(sizeof(struct req_s)));
+	memset(req_buf, 0, NLMSG_LENGTH(sizeof(struct req_s)));
 	memset(&msg, 0, sizeof(struct msghdr));
 
 	nladdr.nl_family = AF_NETLINK;
@@ -397,22 +397,22 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	if (prio != 0)
 		len += sizeof(struct rtattr) + 4;
 
-	req->nlh.nlmsg_len = NLMSG_LENGTH(len);
-	req->nlh.nlmsg_pid = getpid();
+	nh->nlmsg_len = NLMSG_LENGTH(len);
+	nh->nlmsg_pid = getpid();
 	req->rtm.rtm_family = AF_INET;
 	req->rtm.rtm_table = rt_table;
 
 
 	if (rule_action == RULE_DEL) {
 
-		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
-		req->nlh.nlmsg_type = RTM_DELRULE;
+		nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+		nh->nlmsg_type = RTM_DELRULE;
 		req->rtm.rtm_scope = RT_SCOPE_NOWHERE;
 
 	} else {
 
-		req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
-		req->nlh.nlmsg_type = RTM_NEWRULE;
+		nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
+		nh->nlmsg_type = RTM_NEWRULE;
 		req->rtm.rtm_scope = RT_SCOPE_UNIVERSE;
 		req->rtm.rtm_protocol = RTPROT_STATIC;
 		req->rtm.rtm_type = RTN_UNICAST;
@@ -467,7 +467,7 @@ void add_del_rule(uint32_t network, uint8_t netmask, int8_t rt_table, uint32_t p
 	}
 
 
-	if (sendto(netlink_sock, req, req->nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0)  {
+	if (sendto(netlink_sock, req_buf, nh->nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0)  {
 
 		debug_output( 0, "Error - can't send message to kernel via netlink socket for routing rule manipulation: %s\n", strerror(errno));
 		close(netlink_sock);
@@ -633,7 +633,6 @@ int flush_routes_rules(int8_t is_rule)
 	struct nlmsghdr *nh;
 	struct rtmsg *rtm;
 	struct req_s {
-		struct nlmsghdr nlh;
 		struct rtmsg rtm;
 	} *req;
 	char req_buf[NLMSG_LENGTH(sizeof(struct req_s))];
@@ -643,19 +642,20 @@ int flush_routes_rules(int8_t is_rule)
 	iov.iov_base = buf;
 	iov.iov_len  = sizeof(buf);
 
-	req = (struct req_s*)req_buf;
+	nh = (struct nlmsghdr *)req_buf;
+	req = (struct req_s*)NLMSG_DATA(req_buf);
 	memset(&nladdr, 0, sizeof(struct sockaddr_nl));
-	memset(req, 0, NLMSG_LENGTH(sizeof(struct req_s)));
+	memset(req_buf, 0, NLMSG_LENGTH(sizeof(struct req_s)));
 	memset(&msg, 0, sizeof(struct msghdr));
 
 	nladdr.nl_family = AF_NETLINK;
 
-	req->nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct req_s));
-	req->nlh.nlmsg_pid = getpid();
+	nh->nlmsg_len = NLMSG_LENGTH(sizeof(struct req_s));
+	nh->nlmsg_pid = getpid();
 	req->rtm.rtm_family = AF_INET;
 
-	req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	req->nlh.nlmsg_type = (is_rule ? RTM_GETRULE : RTM_GETROUTE);
+	nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	nh->nlmsg_type = (is_rule ? RTM_GETRULE : RTM_GETROUTE);
 	req->rtm.rtm_scope = RTN_UNICAST;
 
 	if ((netlink_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE)) < 0) {
@@ -666,7 +666,7 @@ int flush_routes_rules(int8_t is_rule)
 	}
 
 
-	if (sendto(netlink_sock, req, req->nlh.nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
+	if (sendto(netlink_sock, req_buf, nh->nlmsg_len, 0, (struct sockaddr *)&nladdr, sizeof(struct sockaddr_nl)) < 0) {
 
 		debug_output(0, "Error - can't send message to kernel via netlink socket for flushing the routing table: %s\n", strerror(errno));
 		close(netlink_sock);
-- 
1.6.3.1

