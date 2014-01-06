Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  6 Jan 2014 20:37:23 +0100
Message-Id: <1389037044-27530-2-git-send-email-sven@narfation.org>
In-Reply-To: <1389037044-27530-1-git-send-email-sven@narfation.org>
References: <6312194.LhI8hzXjyH@bentobox>
 <1389037044-27530-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Use libnl to implement mac
	resolver
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
 Makefile    |  18 ++++
 functions.c | 312 +++++++++++++++++++++++++-----------------------------------
 2 files changed, 149 insertions(+), 181 deletions(-)

diff --git a/Makefile b/Makefile
index fc0925d..0eb71a1 100755
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,24 @@ ifndef V
 endif
 endif
 
+ifeq ($(origin PKG_CONFIG), undefined)
+  PKG_CONFIG = pkg-config
+  ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null),)
+    $(error $(PKG_CONFIG) not found)
+  endif
+endif
+
+ifeq ($(origin LIBNL_CFLAGS) $(origin LIBNL_LDLIBS), undefined undefined)
+  LIBNL_NAME ?= libnl-3.0
+  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_NAME) 2>/dev/null),)
+    $(error No $(LIBNL_NAME) development libraries found!)
+  endif
+  LIBNL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_NAME))
+  LIBNL_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBNL_NAME))
+endif
+CFLAGS += $(LIBNL_CFLAGS)
+LDLIBS += $(LIBNL_LDLIBS)
+
 # standard build tools
 ifeq ($(CONFIG_BATCTL_BISECT),y)
 OBJ += $(OBJ_BISECT)
diff --git a/functions.c b/functions.c
index 10a7f86..c21431c 100644
--- a/functions.c
+++ b/functions.c
@@ -38,9 +38,13 @@
 #include <net/ethernet.h>
 #include <linux/rtnetlink.h>
 #include <linux/neighbour.h>
-#include <sys/uio.h>
 #include <errno.h>
 #include <net/if.h>
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <netlink/handlers.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
 
 #include "main.h"
 #include "functions.h"
@@ -457,47 +461,6 @@ static int resolve_l3addr(int ai_family, const char *asc, void *l3addr)
 	return ret;
 }
 
-static void request_mac_resolve(int ai_family, const void *l3addr)
-{
-	const struct sockaddr *sockaddr;
-	struct sockaddr_in inet4;
-	struct sockaddr_in6 inet6;
-	size_t sockaddr_len;
-	int sock;
-	char t = 0;
-
-	sock = socket(ai_family, SOCK_DGRAM, IPPROTO_UDP);
-	if (sock < 0)
-		return;
-
-	switch (ai_family) {
-	case AF_INET:
-		memset(&inet4, 0, sizeof(inet4));
-		inet4.sin_family = ai_family;
-		inet4.sin_port = htons(9);
-		memcpy(&inet4.sin_addr.s_addr, l3addr,
-		       sizeof(inet4.sin_addr.s_addr));
-		sockaddr = (const struct sockaddr *)&inet4;
-		sockaddr_len = sizeof(inet4);
-		break;
-	case AF_INET6:
-		memset(&inet6, 0, sizeof(inet6));
-		inet6.sin6_family = ai_family;
-		inet6.sin6_port = htons(9);
-		memcpy(&inet6.sin6_addr.s6_addr, l3addr,
-		       sizeof(inet6.sin6_addr.s6_addr));
-		sockaddr = (const struct sockaddr *)&inet6;
-		sockaddr_len = sizeof(inet6);
-		break;
-	default:
-		close(sock);
-		return;
-	}
-
-	sendto(sock, &t, sizeof(t), 0, sockaddr, sockaddr_len);
-	close(sock);
-}
-
 /**
  * batadv_rtnl_open - open a socket to rtnl and send a request
  * @nh: the header of the request to send
@@ -542,178 +505,165 @@ outclose:
 	return ret;
 }
 
-static int resolve_mac_from_cache_open(int ai_family)
+static void request_mac_resolve(int ai_family, const void *l3addr)
 {
-	struct {
-		struct nlmsghdr hdr;
-		struct ndmsg msg;
-	} nlreq;
-
-	memset(&nlreq, 0, sizeof(nlreq));
-	nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.msg));
-	nlreq.hdr.nlmsg_type = RTM_GETNEIGH;
-	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
-	nlreq.msg.ndm_family = ai_family;
+	const struct sockaddr *sockaddr;
+	struct sockaddr_in inet4;
+	struct sockaddr_in6 inet6;
+	size_t sockaddr_len;
+	int sock;
+	char t = 0;
 
-	return batadv_rtnl_open(&nlreq, NETLINK_ROUTE);
-}
+	sock = socket(ai_family, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock < 0)
+		return;
 
-static ssize_t resolve_mac_from_cache_dump(int sock, void **buf, size_t *buflen)
-{
-	struct iovec iov;
-	struct msghdr msg;
-	ssize_t ret = -1;
-	int flags = MSG_PEEK | MSG_TRUNC;
+	switch (ai_family) {
+	case AF_INET:
+		memset(&inet4, 0, sizeof(inet4));
+		inet4.sin_family = ai_family;
+		inet4.sin_port = htons(9);
+		memcpy(&inet4.sin_addr.s_addr, l3addr,
+		       sizeof(inet4.sin_addr.s_addr));
+		sockaddr = (const struct sockaddr *)&inet4;
+		sockaddr_len = sizeof(inet4);
+		break;
+	case AF_INET6:
+		memset(&inet6, 0, sizeof(inet6));
+		inet6.sin6_family = ai_family;
+		inet6.sin6_port = htons(9);
+		memcpy(&inet6.sin6_addr.s6_addr, l3addr,
+		       sizeof(inet6.sin6_addr.s6_addr));
+		sockaddr = (const struct sockaddr *)&inet6;
+		sockaddr_len = sizeof(inet6);
+		break;
+	default:
+		close(sock);
+		return;
+	}
 
-	memset(&msg, 0, sizeof(msg));
-	memset(&iov, 0, sizeof(iov));
+	sendto(sock, &t, sizeof(t), 0, sockaddr, sockaddr_len);
+	close(sock);
+}
 
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-	msg.msg_controllen = 0;
-	msg.msg_control = NULL;
-	msg.msg_flags = 0;
+struct resolve_mac_nl_arg {
+	int ai_family;
+	const void *l3addr;
+	struct ether_addr *mac_result;
+	int found;
+};
 
-	iov.iov_len = *buflen;
-	iov.iov_base = *buf;
+static struct nla_policy neigh_policy[NDA_MAX+1] = {
+	[NDA_CACHEINFO] = { .minlen = sizeof(struct nda_cacheinfo) },
+	[NDA_PROBES]    = { .type = NLA_U32 },
+};
 
-	ret = recvmsg(sock, &msg, flags);
+static int resolve_mac_from_parse(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[NDA_MAX + 1];
+	struct ndmsg *nm;
+	int ret;
+	int l3_len;
+	struct resolve_mac_nl_arg *nl_arg = arg;
+	uint8_t *mac;
+	uint8_t *l3addr;
+
+	nm = nlmsg_data(nlmsg_hdr(msg));
+	ret = nlmsg_parse(nlmsg_hdr(msg), sizeof(*nm), tb, NDA_MAX,
+			  neigh_policy);
 	if (ret < 0)
 		goto err;
 
-	if (msg.msg_flags & MSG_TRUNC) {
-		if ((size_t)ret <= *buflen) {
-			ret = -ENOBUFS;
-			goto err;
-		}
-
-		while (*buflen <= (size_t)ret) {
-			if (*buflen == 0)
-				*buflen = 1;
-			*buflen *= 2;
-		}
+	if (nl_arg->ai_family != nm->ndm_family)
+		goto err;
 
-		*buf = realloc(*buf, *buflen);
-		if (!*buf) {
-			ret = -ENOMEM;
-			*buflen = 0;
-			goto err;
-		}
+	switch (nl_arg->ai_family) {
+	case AF_INET:
+		l3_len = 4;
+		break;
+	case AF_INET6:
+		l3_len = 16;
+		break;
+	default:
+		l3_len = 0;
 	}
-	flags = 0;
 
-	ret = recvmsg(sock, &msg, flags);
-	if (ret < 0)
+	if (l3_len == 0)
 		goto err;
 
-	return ret;
-err:
-	free(*buf);
-	*buf = NULL;
-	return ret;
-}
+	if (!tb[NDA_LLADDR] || !tb[NDA_DST])
+		goto err;
 
-static int resolve_mac_from_cache_parse(struct ndmsg *ndmsg, size_t len_payload,
-					struct ether_addr *mac_addr,
-					uint8_t *l3addr,
-					size_t l3_len)
-{
-	int l3found, llfound;
-	struct rtattr *rtattr;
-	struct ether_addr mac_empty;
-
-	l3found = 0;
-	llfound = 0;
-	memset(&mac_empty, 0, sizeof(mac_empty));
-
-	for (rtattr = RTM_RTA(ndmsg); RTA_OK(rtattr, len_payload);
-		rtattr = RTA_NEXT(rtattr, len_payload)) {
-		switch (rtattr->rta_type) {
-		case NDA_DST:
-			memcpy(l3addr, RTA_DATA(rtattr), l3_len);
-			l3found = 1;
-			break;
-		case NDA_LLADDR:
-			memcpy(mac_addr, RTA_DATA(rtattr), ETH_ALEN);
-			if (memcmp(mac_addr, &mac_empty,
-					sizeof(mac_empty)) == 0)
-				llfound = 0;
-			else
-				llfound = 1;
-			break;
-		}
+	if (nla_len(tb[NDA_LLADDR]) != ETH_ALEN)
+		goto err;
+
+	if (nla_len(tb[NDA_DST]) != l3_len)
+		goto err;
+
+	mac = nla_data(tb[NDA_LLADDR]);
+	l3addr = nla_data(tb[NDA_DST]);
+
+	if (memcmp(nl_arg->l3addr, l3addr, l3_len) == 0) {
+		memcpy(nl_arg->mac_result, mac, ETH_ALEN);
+		nl_arg->found = 1;
 	}
 
-	return l3found && llfound;
+err:
+	if (nl_arg->found)
+		return NL_STOP;
+	else
+		return NL_OK;
 }
 
 static struct ether_addr *resolve_mac_from_cache(int ai_family,
 						 const void *l3addr)
 {
-	uint8_t l3addr_tmp[16];
-	static struct ether_addr mac_tmp;
+	struct nl_sock *sock;
 	struct ether_addr *mac_result = NULL;
-	void *buf = NULL;
-	size_t buflen;
-	struct nlmsghdr *nh;
-	ssize_t len;
-	size_t l3_len, mlen;
-	int socknl;
-	int parsed;
-	int finished = 0;
-
-	switch (ai_family) {
-	case AF_INET:
-		l3_len = 4;
-		break;
-	case AF_INET6:
-		l3_len = 16;
-		break;
-	default:
-		l3_len = 0;
-	}
-
-	buflen = 8192;
-	buf = malloc(buflen);
-	if (!buf)
+	static struct ether_addr mac_tmp;
+	int ret;
+	struct rtgenmsg gmsg = {
+		.rtgen_family = ai_family,
+	};
+	struct nl_cb *cb = NULL;
+	struct resolve_mac_nl_arg arg = {
+		.ai_family = ai_family,
+		.l3addr = l3addr,
+		.mac_result = &mac_tmp,
+		.found = 0,
+	};
+
+	sock = nl_socket_alloc();
+	if (!sock)
 		goto err;
 
-	socknl = resolve_mac_from_cache_open(ai_family);
-	if (socknl < 0)
+	ret = nl_connect(sock, NETLINK_ROUTE);
+	if (ret < 0)
 		goto err;
 
+	ret = nl_send_simple(sock, RTM_GETNEIGH, NLM_F_REQUEST | NLM_F_DUMP,
+			     &gmsg, sizeof(gmsg));
+	if (ret < 0)
+		goto err;
 
-	while (!finished) {
-		len = resolve_mac_from_cache_dump(socknl, &buf, &buflen);
-		if (len < 0)
-			goto err_sock;
-		mlen = len;
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		goto err;
 
-		for (nh = buf; NLMSG_OK(nh, mlen); nh = NLMSG_NEXT(nh, mlen)) {
-			if (nh->nlmsg_type == NLMSG_DONE) {
-				finished = 1;
-				break;
-			}
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, resolve_mac_from_parse, &arg);
+	ret = nl_recvmsgs(sock, cb);
+	if (ret < 0)
+		goto err;
 
-			parsed = resolve_mac_from_cache_parse(NLMSG_DATA(nh),
-							      RTM_PAYLOAD(nh),
-							      &mac_tmp,
-							      l3addr_tmp,
-							      l3_len);
-			if (parsed) {
-				if (memcmp(&l3addr_tmp, l3addr, l3_len) == 0) {
-					mac_result = &mac_tmp;
-					finished = 1;
-					break;
-				}
-			}
-		}
-	}
+	if (arg.found)
+		mac_result = &mac_tmp;
 
-err_sock:
-	close(socknl);
 err:
-	free(buf);
+	if (cb)
+		nl_cb_put(cb);
+	if (sock)
+		nl_socket_free(sock);
+
 	return mac_result;
 }
 
-- 
1.8.5.2

