Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 13:35:55 +0200
Message-Id: <1433072160-3260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] alfred: Reduce MAX_PAYLOAD by the size
	of the UDP header
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

The len field in the UDP header is 16 bit long. It can therefore store a
value of up to (2 ** 16 - 1). This value is currently used for MAX_PAYLOAD.
But the UDP len field not only stores the payload length but also the udp
header itself. Thus the length of MAX_PAYLOAD has to be reduced by the
size of udphdr to make sure that the payload can still be sent.

Reported-by: Hans-Werner Hilse <hwhilse@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index 8fc8ab1..7c308e5 100644
--- a/alfred.h
+++ b/alfred.h
@@ -26,4 +26,5 @@
 #include <net/ethernet.h>
 #include <netinet/in.h>
+#include <netinet/udp.h>
 #include <stdint.h>
 #include <time.h>
@@ -138,5 +139,5 @@ struct globals {
 #define debugFree(ptr, num)	free(ptr)
 
-#define MAX_PAYLOAD ((1 << 16) - 1)
+#define MAX_PAYLOAD ((1 << 16) - 1 - sizeof(struct udphdr))
 
 extern const struct in6_addr in6addr_localmcast;
-- 
2.1.4

