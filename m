Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Thu, 17 Apr 2014 13:19:31 +0200
Message-Id: <1397733571-1531-2-git-send-email-sven@open-mesh.com>
In-Reply-To: <1397733571-1531-1-git-send-email-sven@open-mesh.com>
References: <1397733571-1531-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Check for changed interface
	properties
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
Cc: Sven Eckelmann <sven@open-mesh.com>

The interface may have been recreated or the mac address was changed. In this
situations socket has to be recreated to avoid proplems with the link-local
IPv6 address and the scope_id (interface id).

These properties are polled and checked every 60 seconds and the appropriate
measures are taken when an error/change occurs.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h |  3 +++
 server.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/alfred.h b/alfred.h
index ba2e416..e3b6d86 100644
--- a/alfred.h
+++ b/alfred.h
@@ -31,6 +31,7 @@
 #include "packet.h"
 
 #define ALFRED_INTERVAL			10
+#define ALFRED_IF_CHECK_INTERVAL	60
 #define ALFRED_REQUEST_TIMEOUT		10
 #define ALFRED_SERVER_TIMEOUT		60
 #define ALFRED_DATA_TIMEOUT		600
@@ -102,6 +103,8 @@ struct globals {
 	int netsock;
 	int unix_sock;
 
+	struct timespec if_check;
+
 	struct hashtable_t *server_hash;
 	struct hashtable_t *data_hash;
 	struct hashtable_t *transaction_hash;
diff --git a/server.c b/server.c
index fd8572b..fdd97d4 100644
--- a/server.c
+++ b/server.c
@@ -20,14 +20,19 @@
  */
 
 #include <errno.h>
+#include <inttypes.h>
 #include <net/ethernet.h>
+#include <net/if.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/select.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
 #include <sys/time.h>
+#include <unistd.h>
 #include <time.h>
 #include "alfred.h"
 #include "batadv_query.h"
@@ -212,6 +217,64 @@ static int purge_data(struct globals *globals)
 	return 0;
 }
 
+static void check_if_socket(struct globals *globals)
+{
+	struct timespec now, diff;
+	int sock;
+	struct ifreq ifr;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	time_diff(&now, &globals->if_check, &diff);
+
+	if (diff.tv_sec < ALFRED_IF_CHECK_INTERVAL)
+		return;
+
+	globals->if_check = now;
+
+	if (globals->netsock < 0)
+		return;
+
+	sock = socket(PF_INET6, SOCK_DGRAM, 0);
+	if (sock < 0) {
+		fprintf(stderr, "can't open socket: %s\n", strerror(errno));
+		return;
+	}
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
+		fprintf(stderr, "can't get interface: %s, closing netsock\n",
+			strerror(errno));
+		goto close;
+	}
+
+	if (globals->scope_id != (uint32_t)ifr.ifr_ifindex) {
+		fprintf(stderr,
+			"iface index changed from %"PRIu32" to %d, closing netsock\n",
+			globals->scope_id, ifr.ifr_ifindex);
+		goto close;
+	}
+
+	if (ioctl(sock, SIOCGIFHWADDR, &ifr) == -1) {
+		fprintf(stderr, "can't get MAC address: %s, closing netsock\n",
+			strerror(errno));
+		goto close;
+	}
+
+	if (memcmp(&globals->hwaddr, &ifr.ifr_hwaddr.sa_data, 6) != 0) {
+		fprintf(stderr, "iface mac changed, closing netsock\n");
+		goto close;
+	}
+
+	close(sock);
+	return;
+
+close:
+	netsock_close(globals->netsock);
+	globals->netsock = -1;
+	close(sock);
+}
+
 int alfred_server(struct globals *globals)
 {
 	int maxsock, ret;
@@ -237,6 +300,7 @@ int alfred_server(struct globals *globals)
 		return -1;
 
 	clock_gettime(CLOCK_MONOTONIC, &last_check);
+	globals->if_check = last_check;
 
 	while (1) {
 		clock_gettime(CLOCK_MONOTONIC, &now);
@@ -297,6 +361,7 @@ int alfred_server(struct globals *globals)
 			push_local_data(globals);
 		}
 		purge_data(globals);
+		check_if_socket(globals);
 	}
 
 	if (globals->netsock >= 0)
-- 
1.9.2

