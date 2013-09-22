Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Sep 2013 16:42:24 +0200
Message-Id: <1379860946-32669-2-git-send-email-sven@narfation.org>
In-Reply-To: <1379860946-32669-1-git-send-email-sven@narfation.org>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batctl: Reduce IPv4 focus of mac resolve
	functions
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

The first implementation of the IP translation functions in
cb75e019e74fc11f9547dadd51abbf3c9df2c5e7 ("batctl: Allow to use IPv4 addresses
for ping/traceroute") had is focus on implementing it only for IPv4. This is a
limitation when other layer 3 protocols are used.

For example, a port to IPv6 would either have to copy the functionality or do a
major refactoring when implementing the it resolv functionality. This is not
necessary when the functions already expect different layer 3 protocols in the
first place and make it easy to find the right place to modify them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 86 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/functions.c b/functions.c
index 1a33d6d..e4aeb72 100644
--- a/functions.c
+++ b/functions.c
@@ -416,49 +416,68 @@ out:
 	return mac_result;
 }
 
-static uint32_t resolve_ipv4(const char *asc)
+static int resolve_l3addr(int ai_family, const char *asc, void *l3addr)
 {
 	int ret;
 	struct addrinfo hints;
 	struct addrinfo *res;
 	struct sockaddr_in *inet4;
-	uint32_t addr = 0;
 
 	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_INET;
+	hints.ai_family = ai_family;
 	ret = getaddrinfo(asc, NULL, &hints, &res);
 	if (ret)
-		return 0;
+		return -EADDRNOTAVAIL;
 
 	if (res) {
-		inet4 = (struct sockaddr_in *)res->ai_addr;
-		addr = inet4->sin_addr.s_addr;
+		switch (ai_family) {
+		case AF_INET:
+			inet4 = (struct sockaddr_in *)res->ai_addr;
+			memcpy(l3addr, &inet4->sin_addr.s_addr,
+			       sizeof(inet4->sin_addr.s_addr));
+			break;
+		default:
+			ret = -EINVAL;
+		}
 	}
 
 	freeaddrinfo(res);
-	return addr;
+	return ret;
 }
 
-static void request_arp(uint32_t ipv4_addr)
+static void request_mac_resolve(int ai_family, const void *l3addr)
 {
+	const struct sockaddr *sockaddr;
 	struct sockaddr_in inet4;
+	size_t sockaddr_len;
 	int sock;
 	char t = 0;
 
-	memset(&inet4, 0, sizeof(inet4));
-	sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	sock = socket(ai_family, SOCK_DGRAM, IPPROTO_UDP);
 	if (sock < 0)
 		return;
 
-	inet4.sin_family = AF_INET;
-	inet4.sin_port = htons(9);
-	inet4.sin_addr.s_addr = ipv4_addr;
-	sendto(sock, &t, sizeof(t), 0, (const struct sockaddr *)&inet4,
-	       sizeof(inet4));
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
+	default:
+		close(sock);
+		return;
+	}
+
+	sendto(sock, &t, sizeof(t), 0, sockaddr, sockaddr_len);
 	close(sock);
 }
 
-static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
+static struct ether_addr *resolve_mac_from_cache(int ai_family,
+						 const void *l3addr)
 {
 	struct ether_addr mac_empty;
 	struct ether_addr *mac_result = NULL, *mac_tmp = NULL;
@@ -471,7 +490,12 @@ static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
 	size_t column;
 	char *token, *input, *saveptr;
 	int line_invalid;
+	uint32_t ipv4_addr;
 
+	if (ai_family != AF_INET)
+		return NULL;
+
+	memcpy(&ipv4_addr, l3addr, sizeof(ipv4_addr));
 	memset(&mac_empty, 0, sizeof(mac_empty));
 
 	f = fopen("/proc/net/arp", "r");
@@ -527,20 +551,30 @@ static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
 	return mac_result;
 }
 
-static struct ether_addr *resolve_mac_from_ipv4(const char *asc)
+static struct ether_addr *resolve_mac_from_addr(int ai_family, const char *asc)
 {
-	uint32_t ipv4_addr;
+	uint8_t ipv4_addr[4];
+	void *l3addr;
+	int ret;
 	int retries = 5;
 	struct ether_addr *mac_result = NULL;
 
-	ipv4_addr = resolve_ipv4(asc);
-	if (!ipv4_addr)
+	switch (ai_family) {
+	case AF_INET:
+		l3addr = ipv4_addr;
+		break;
+	default:
+		return NULL;
+	}
+
+	ret = resolve_l3addr(ai_family, asc, l3addr);
+	if (ret < 0)
 		return NULL;
 
 	while (retries-- && !mac_result) {
-		mac_result = resolve_mac_from_arp(ipv4_addr);
+		mac_result = resolve_mac_from_cache(ai_family, l3addr);
 		if (!mac_result) {
-			request_arp(ipv4_addr);
+			request_mac_resolve(ai_family, l3addr);
 			usleep(200000);
 		}
 	}
@@ -551,12 +585,18 @@ static struct ether_addr *resolve_mac_from_ipv4(const char *asc)
 struct ether_addr *resolve_mac(const char *asc)
 {
 	struct ether_addr *mac_result = NULL;
+	static const int ai_families[] = {AF_INET};
+	size_t i;
 
 	mac_result = ether_aton(asc);
 	if (mac_result)
 		goto out;
 
-	mac_result = resolve_mac_from_ipv4(asc);
+	for (i = 0; i < sizeof(ai_families) / sizeof(*ai_families); i++) {
+		mac_result = resolve_mac_from_addr(ai_families[i], asc);
+		if (mac_result)
+			goto out;
+	}
 
 out:
 	return mac_result;
-- 
1.8.4.rc3

