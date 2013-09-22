Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Sep 2013 19:09:31 +0200
Message-Id: <1379869771-17797-1-git-send-email-sven@narfation.org>
In-Reply-To: <1379860946-32669-3-git-send-email-sven@narfation.org>
References: <1379860946-32669-3-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batctl: Replace /proc/net/arp based
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
V2:
 * optimize for large ARP caches

 functions.c | 251 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 188 insertions(+), 63 deletions(-)

diff --git a/functions.c b/functions.c
index e4aeb72..697c217 100644
--- a/functions.c
+++ b/functions.c
@@ -21,7 +21,6 @@
 
 
 #include <netinet/ether.h>
-#include <arpa/inet.h>
 #include <sys/socket.h>
 #include <netdb.h>
 #include <sys/types.h>
@@ -35,6 +34,12 @@
 #include <sys/time.h>
 #include <netinet/in.h>
 #include <stdint.h>
+#include <linux/netlink.h>
+#include <net/ethernet.h>
+#include <linux/rtnetlink.h>
+#include <linux/neighbour.h>
+#include <sys/uio.h>
+#include <errno.h>
 
 #include "main.h"
 #include "functions.h"
@@ -476,78 +481,198 @@ static void request_mac_resolve(int ai_family, const void *l3addr)
 	close(sock);
 }
 
-static struct ether_addr *resolve_mac_from_cache(int ai_family,
-						 const void *l3addr)
+static int resolve_mac_from_cache_open(int ai_family)
 {
-	struct ether_addr mac_empty;
-	struct ether_addr *mac_result = NULL, *mac_tmp = NULL;
-	struct sockaddr_in inet4;
+	int socknl;
 	int ret;
-	FILE *f;
-	size_t len = 0;
-	char *line = NULL;
-	int skip_line = 1;
-	size_t column;
-	char *token, *input, *saveptr;
-	int line_invalid;
-	uint32_t ipv4_addr;
+	struct {
+		struct nlmsghdr hdr;
+		struct ndmsg msg;
+	} nlreq;
+	struct sockaddr_nl addrnl;
+	static uint32_t nr_call = 0;
+	uint32_t pid = (++nr_call + getpid()) & 0x3FFFFF;
 
-	if (ai_family != AF_INET)
-		return NULL;
+	memset(&addrnl, 0, sizeof(addrnl));
+	addrnl.nl_family = AF_NETLINK;
+	addrnl.nl_pid = pid;
+	addrnl.nl_groups = 0;
 
-	memcpy(&ipv4_addr, l3addr, sizeof(ipv4_addr));
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
+static ssize_t resolve_mac_from_cache_dump(int sock, void **buf, size_t *buflen)
+{
+	struct iovec iov;
+	struct msghdr msg;
+	ssize_t ret = -1;
+	int flags = MSG_PEEK | MSG_TRUNC;
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&iov, 0, sizeof(iov));
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_controllen = 0;
+	msg.msg_control = NULL;
+	msg.msg_flags = 0;
+
+	iov.iov_len = *buflen;
+	iov.iov_base = *buf;
+
+	ret = recvmsg(sock, &msg, flags);
+	if (ret < 0)
+		goto err;
+
+	if (msg.msg_flags & MSG_TRUNC) {
+		if ((size_t)ret <= *buflen) {
+			ret = -ENOBUFS;
+			goto err;
+		}
+
+		while (*buflen <= (size_t)ret) {
+			if (*buflen == 0)
+				*buflen = 1;
+			*buflen *= 2;
+		}
+
+		*buf = realloc(*buf, *buflen);
+		if (!*buf) {
+			ret = -ENOMEM;
+			*buflen = 0;
+			goto err;
+		}
+	}
+	flags = 0;
+
+	ret = recvmsg(sock, &msg, flags);
+	if (ret < 0)
+		goto err;
+
+	return ret;
+err:
+	free(*buf);
+	*buf = NULL;
+	return ret;
+}
+
+static int resolve_mac_from_cache_parse(struct ndmsg *ndmsg, size_t len_payload,
+					struct ether_addr *mac_addr,
+					uint8_t *l3addr,
+					size_t l3_len)
+{
+	int l3found, llfound;
+	struct rtattr *rtattr;
+	struct ether_addr mac_empty;
+
+	l3found = 0;
+	llfound = 0;
 	memset(&mac_empty, 0, sizeof(mac_empty));
 
-	f = fopen("/proc/net/arp", "r");
-	if (!f)
-		return NULL;
-
-	while (getline(&line, &len, f) != -1) {
-		if (skip_line) {
-			skip_line = 0;
-			continue;
-		}
-
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
+	for (rtattr = RTM_RTA(ndmsg); RTA_OK(rtattr, len_payload);
+		rtattr = RTA_NEXT(rtattr, len_payload)) {
+		switch (rtattr->rta_type) {
+		case NDA_DST:
+			memcpy(l3addr, RTA_DATA(rtattr), l3_len);
+			l3found = 1;
+			break;
+		case NDA_LLADDR:
+			memcpy(mac_addr, RTA_DATA(rtattr), ETH_ALEN);
+			if (memcmp(mac_addr, &mac_empty,
+					sizeof(mac_empty)) == 0)
+				llfound = 0;
+			else
+				llfound = 1;
 			break;
 		}
 	}
 
-	free(line);
-	fclose(f);
+	return l3found && llfound;
+}
+
+static struct ether_addr *resolve_mac_from_cache(int ai_family,
+						 const void *l3addr)
+{
+	static uint8_t l3addr_tmp[16];
+	struct ether_addr mac_tmp;
+	struct ether_addr *mac_result = NULL;
+	void *buf = NULL;
+	size_t buflen;
+	struct nlmsghdr *nh;
+	ssize_t len;
+	size_t l3_len;
+	int socknl;
+	int parsed;
+	int finished = 0;
+
+	switch (ai_family) {
+	case AF_INET:
+		l3_len = 4;
+		break;
+	default:
+		l3_len = 0;
+	}
+
+	buflen = 8192;
+	buf = malloc(buflen);
+	if (!buf)
+		goto err;
+
+	socknl = resolve_mac_from_cache_open(ai_family);
+	if (socknl < 0)
+		goto err;
+
+
+	while (!finished) {
+		len = resolve_mac_from_cache_dump(socknl, &buf, &buflen);
+		if (len < 0)
+			goto err_sock;
+
+		for (nh = buf; NLMSG_OK(nh, len); nh = NLMSG_NEXT(nh, len)) {
+			if (nh->nlmsg_type == NLMSG_DONE) {
+				finished = 1;
+				break;
+			}
+
+			parsed = resolve_mac_from_cache_parse(NLMSG_DATA(nh),
+							      RTM_PAYLOAD(nh),
+							      &mac_tmp,
+							      l3addr_tmp,
+							      l3_len);
+			if (parsed) {
+				if (memcmp(&l3addr_tmp, l3addr, l3_len) == 0) {
+					mac_result = &mac_tmp;
+					break;
+				}
+			}
+		}
+	}
+
+err_sock:
+	close(socknl);
+err:
+	free(buf);
 	return mac_result;
 }
 
-- 
1.8.4.rc3

