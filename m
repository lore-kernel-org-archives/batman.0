Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Sep 2013 16:43:03 +0200
Message-Id: <1379860983-32732-1-git-send-email-sven@narfation.org>
In-Reply-To: <1379860946-32669-1-git-send-email-sven@narfation.org>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batctl: Add support for IPv6 to address
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index e56479d..45c2120 100644
--- a/functions.c
+++ b/functions.c
@@ -426,6 +426,7 @@ static int resolve_l3addr(int ai_family, const char *asc, void *l3addr)
 	struct addrinfo hints;
 	struct addrinfo *res;
 	struct sockaddr_in *inet4;
+	struct sockaddr_in6 *inet6;
 
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = ai_family;
@@ -440,6 +441,11 @@ static int resolve_l3addr(int ai_family, const char *asc, void *l3addr)
 			memcpy(l3addr, &inet4->sin_addr.s_addr,
 			       sizeof(inet4->sin_addr.s_addr));
 			break;
+		case AF_INET6:
+			inet6 = (struct sockaddr_in6 *)res->ai_addr;
+			memcpy(l3addr, &inet6->sin6_addr.s6_addr,
+			       sizeof(inet6->sin6_addr.s6_addr));
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -453,6 +459,7 @@ static void request_mac_resolve(int ai_family, const void *l3addr)
 {
 	const struct sockaddr *sockaddr;
 	struct sockaddr_in inet4;
+	struct sockaddr_in6 inet6;
 	size_t sockaddr_len;
 	int sock;
 	char t = 0;
@@ -471,6 +478,15 @@ static void request_mac_resolve(int ai_family, const void *l3addr)
 		sockaddr = (const struct sockaddr *)&inet4;
 		sockaddr_len = sizeof(inet4);
 		break;
+	case AF_INET6:
+		memset(&inet6, 0, sizeof(inet6));
+		inet6.sin6_family = ai_family;
+		inet6.sin6_port = htons(9);
+		memcpy(&inet6.sin6_addr.s6_addr, l3addr,
+		       sizeof(inet6.sin6_addr.s6_addr));
+		sockaddr = (const struct sockaddr *)&inet6;
+		sockaddr_len = sizeof(inet6);
+		break;
 	default:
 		close(sock);
 		return;
@@ -597,6 +613,9 @@ static struct ether_addr *resolve_mac_from_cache(int ai_family,
 	case AF_INET:
 		l3_len = 4;
 		break;
+	case AF_INET6:
+		l3_len = 16;
+		break;
 	default:
 		l3_len = 0;
 	}
@@ -649,6 +668,7 @@ out:
 static struct ether_addr *resolve_mac_from_addr(int ai_family, const char *asc)
 {
 	uint8_t ipv4_addr[4];
+	uint8_t ipv6_addr[16];
 	void *l3addr;
 	int ret;
 	int retries = 5;
@@ -658,6 +678,9 @@ static struct ether_addr *resolve_mac_from_addr(int ai_family, const char *asc)
 	case AF_INET:
 		l3addr = ipv4_addr;
 		break;
+	case AF_INET6:
+		l3addr = ipv6_addr;
+		break;
 	default:
 		return NULL;
 	}
@@ -680,7 +703,7 @@ static struct ether_addr *resolve_mac_from_addr(int ai_family, const char *asc)
 struct ether_addr *resolve_mac(const char *asc)
 {
 	struct ether_addr *mac_result = NULL;
-	static const int ai_families[] = {AF_INET};
+	static const int ai_families[] = {AF_INET, AF_INET6};
 	size_t i;
 
 	mac_result = ether_aton(asc);
-- 
1.8.4.rc3

