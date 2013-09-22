Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Sep 2013 16:42:25 +0200
Message-Id: <1379860946-32669-3-git-send-email-sven@narfation.org>
In-Reply-To: <1379860946-32669-1-git-send-email-sven@narfation.org>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batctl: Replace /proc/net/arp based
	resolver with rtnl
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

The /proc/net/arp based solution to resolve mac addresses from IP adresses is
limited to IPv4 addresses. The table for IPv6 addresses to MAC addresses is
only available through rtnetlink. rtnetlink also provides the IPv4 neighbor
table and should therefore should be prefered over the /proc/net/arp solution
to build an infrastructure for further work on the resolver.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 215 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 155 insertions(+), 60 deletions(-)

diff --git a/functions.c b/functions.c
index e4aeb72..e56479d 100644
--- a/functions.c
+++ b/functions.c
@@ -21,7 +21,6 @@
 
 
 #include <netinet/ether.h>
-#include <arpa/inet.h>
 #include <sys/socket.h>
 #include <netdb.h>
 #include <sys/types.h>
@@ -35,6 +34,11 @@
 #include <sys/time.h>
 #include <netinet/in.h>
 #include <stdint.h>
+#include <linux/netlink.h>
+#include <net/ethernet.h>
+#include <linux/rtnetlink.h>
+#include <linux/neighbour.h> 
+#include <sys/uio.h>
 
 #include "main.h"
 #include "functions.h"
@@ -476,78 +480,169 @@ static void request_mac_resolve(int ai_family, const void *l3addr)
 	close(sock);
 }
 
+static int resolve_mac_from_cache_open(int ai_family)
+{
+	int socknl;
+	int ret;
+	struct {
+		struct nlmsghdr hdr;
+		struct ndmsg msg;
+	} nlreq;
+	struct sockaddr_nl addrnl;
+	static uint32_t nr_call = 0;
+	uint32_t pid = (++nr_call + getpid()) & 0x3FFFFF;
+
+	memset(&addrnl, 0, sizeof(addrnl));
+	addrnl.nl_family = AF_NETLINK;
+	addrnl.nl_pid = pid;
+	addrnl.nl_groups = 0;
+
+	memset(&nlreq, 0, sizeof(nlreq));
+	nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.msg));
+	nlreq.hdr.nlmsg_type = RTM_GETNEIGH;
+	nlreq.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	nlreq.msg.ndm_family = ai_family;
+
+	socknl = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (socknl < 0)
+		goto out;
+
+	ret = bind(socknl, (struct sockaddr*)&addrnl, sizeof(addrnl));
+	if (ret < 0)
+		goto outclose;
+
+	ret = send(socknl, &nlreq, nlreq.hdr.nlmsg_len, 0);
+	if (ret < 0)
+		goto outclose;
+out:
+	return socknl;
+outclose:
+	close(socknl);
+	return ret;
+}
+
+static ssize_t resolve_mac_from_cache_dump(int ai_family, void **buf)
+{
+	struct iovec iov;
+	struct msghdr msg;
+	size_t buflen = 4096;
+	ssize_t ret = -1;
+	int socknl;
+
+	*buf = NULL;
+	memset(&msg, 0, sizeof(msg));
+	memset(&iov, 0, sizeof(iov));
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_controllen = 0;
+	msg.msg_control = NULL;
+	msg.msg_flags = 0;
+
+retry:
+	socknl = resolve_mac_from_cache_open(ai_family);
+	if (socknl < 0) {
+		ret = socknl;
+		free(*buf);
+		goto out;
+	}
+
+	*buf = realloc(*buf, buflen);
+	if (!*buf) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	iov.iov_len = buflen;
+	iov.iov_base = *buf;
+
+	ret = recvmsg(socknl, &msg, 0);
+	if (ret < 0)
+		goto err;
+
+	close(socknl);
+	if (msg.msg_flags & MSG_TRUNC) {
+		buflen *= 2;
+		goto retry;
+	}
+
+out:
+	return ret;
+err:
+	close(socknl);
+	free(*buf);
+	*buf = NULL;
+	return ret;
+}
+
 static struct ether_addr *resolve_mac_from_cache(int ai_family,
 						 const void *l3addr)
 {
+	static uint8_t l3addr_tmp[16];
+	int l3found, llfound;
 	struct ether_addr mac_empty;
-	struct ether_addr *mac_result = NULL, *mac_tmp = NULL;
-	struct sockaddr_in inet4;
-	int ret;
-	FILE *f;
-	size_t len = 0;
-	char *line = NULL;
-	int skip_line = 1;
-	size_t column;
-	char *token, *input, *saveptr;
-	int line_invalid;
-	uint32_t ipv4_addr;
+	struct ether_addr mac_tmp;
+	struct ether_addr *mac_result = NULL;
+	void *buf = NULL;
+	struct nlmsghdr *nh;
+	struct ndmsg *ndmsg;
+	struct rtattr *rtattr;
+	size_t len_payload;
+	ssize_t len;
+	size_t l3_len;
 
-	if (ai_family != AF_INET)
-		return NULL;
-
-	memcpy(&ipv4_addr, l3addr, sizeof(ipv4_addr));
 	memset(&mac_empty, 0, sizeof(mac_empty));
 
-	f = fopen("/proc/net/arp", "r");
-	if (!f)
-		return NULL;
+	switch (ai_family) {
+	case AF_INET:
+		l3_len = 4;
+		break;
+	default:
+		l3_len = 0;
+	}
 
-	while (getline(&line, &len, f) != -1) {
-		if (skip_line) {
-			skip_line = 0;
-			continue;
-		}
+	len = resolve_mac_from_cache_dump(ai_family, &buf);
+	if (len < 0)
+		goto out;
 
-		line_invalid = 0;
-		column = 0;
-		input = line;
-		while ((token = strtok_r(input, " \t", &saveptr))) {
-			input = NULL;
-
-			if (column == 0) {
-				ret = inet_pton(AF_INET, token, &inet4.sin_addr);
-				if (ret != 1) {
-					line_invalid = 1;
-					break;
-				}
-			}
-
-			if (column == 3) {
-				mac_tmp = ether_aton(token);
-				if (!mac_tmp || memcmp(mac_tmp, &mac_empty,
-						       sizeof(mac_empty)) == 0) {
-					line_invalid = 1;
-					break;
-				}
-			}
-
-			column++;
-		}
-
-		if (column < 4)
-			line_invalid = 1;
-
-		if (line_invalid)
-			continue;
-
-		if (ipv4_addr == inet4.sin_addr.s_addr) {
-			mac_result = mac_tmp;
+	for (nh = buf; NLMSG_OK(nh, len); nh = NLMSG_NEXT(nh, len)) {
+		if (nh->nlmsg_type == NLMSG_DONE)
 			break;
+
+		l3found = 0;
+		llfound = 0;
+		ndmsg = NLMSG_DATA(nh);
+		len_payload = RTM_PAYLOAD(nh);
+
+		for (rtattr = RTM_RTA(ndmsg); RTA_OK(rtattr, len_payload);
+		     rtattr = RTA_NEXT(rtattr, len_payload)) {
+			switch (rtattr->rta_type) {
+			case NDA_DST:
+				memcpy(&l3addr_tmp, RTA_DATA(rtattr), l3_len);
+				l3found = 1;
+				break;
+			case NDA_LLADDR:
+				memcpy(&mac_tmp, RTA_DATA(rtattr),
+					sizeof(mac_tmp));
+				if (memcmp(&mac_tmp, &mac_empty,
+					   sizeof(mac_empty)) == 0)
+					llfound = 0;
+				else
+					llfound = 1;
+				break;
+			}
+		}
+
+		if (llfound && l3found) {
+			if (memcmp(&l3addr_tmp, l3addr, l3_len) == 0) {
+				mac_result = &mac_tmp;
+				break;
+			}
 		}
 	}
 
-	free(line);
-	fclose(f);
+	free(buf);
+out:
 	return mac_result;
 }
 
-- 
1.8.4.rc3

