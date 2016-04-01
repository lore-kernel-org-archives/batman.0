Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Apr 2016 19:22:35 +0200
Message-Id: <1459531356-8361-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Check for invalid mac in EUI64
	address
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

The ipv6_to_mac function currently only checks if the EUI64 markers are
present but not if the mac address is valid for a host. This has to be done
to avoid invalid data in the alfred data storage.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h       |  2 ++
 batadv_query.c |  4 ++++
 util.c         | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/alfred.h b/alfred.h
index 7e5db16..8ed1ef0 100644
--- a/alfred.h
+++ b/alfred.h
@@ -26,6 +26,7 @@
 #include <net/ethernet.h>
 #include <netinet/in.h>
 #include <netinet/udp.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <time.h>
 #include <sys/select.h>
@@ -196,3 +197,4 @@ int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff);
 void time_random_seed(void);
 uint16_t get_random_id(void);
+bool is_valid_ether_addr(uint8_t *addr);
diff --git a/batadv_query.c b/batadv_query.c
index 2604503..6dc2cf4 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include "alfred.h"
 #include "batadv_query.h"
 #include <errno.h>
 #include <net/ethernet.h>
@@ -85,6 +86,9 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 	mac->ether_addr_octet[4] = addr->s6_addr[14];
 	mac->ether_addr_octet[5] = addr->s6_addr[15];
 
+	if (!is_valid_ether_addr(mac->ether_addr_octet))
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/util.c b/util.c
index db6ec96..c7e11cc 100644
--- a/util.c
+++ b/util.c
@@ -19,6 +19,8 @@
  *
  */
 
+#include <netinet/ether.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <stdlib.h>
@@ -60,3 +62,16 @@ uint16_t get_random_id(void)
 {
 	return random();
 }
+
+bool is_valid_ether_addr(uint8_t addr[ETH_ALEN])
+{
+	/* multicast address */
+	if (addr[0] & 0x01)
+		return false;
+
+	/* 00:00:00:00:00:00 */
+	if ((addr[0] | addr[1] | addr[2] | addr[3] | addr[4] | addr[5]) == 0)
+		return false;
+
+	return true;
+}
-- 
2.8.0.rc3

