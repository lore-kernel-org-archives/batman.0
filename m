Return-Path: <jhaws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Mon, 29 Oct 2018 11:57:59 -0600
Message-ID: <20181029175759.20637-1-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] [PATCH v3] alfred: Request MAC resolution for IPv4
 address not in ARP cache
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: guohuizou2000@sina.com, b.a.t.m.a.n@lists.open-mesh.org
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

When using IPv4, if the remote server is not yet in the ARP cache, the
MAC resolution will fail and data appear to not be shared via alfred.
Add a routine (modified from batctl sources) to request MAC resolution
by simply sending a datagram to the discard port (UDP/9). This adds the
remote MAC to the ARP cache, resulting in successful MAC resolution.

Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
---
 util.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/util.c b/util.c
index dd3f00f..0794792 100644
--- a/util.c
+++ b/util.c
@@ -30,6 +30,7 @@
 #include <sys/ioctl.h>
 #include <sys/time.h>
 #include <time.h>
+#include <unistd.h>
 #include "alfred.h"
 
 int time_diff(struct timespec *tv1, struct timespec *tv2,
@@ -80,11 +81,35 @@ bool is_valid_ether_addr(uint8_t addr[ETH_ALEN])
 	return true;
 }
 
+static void ipv4_request_mac_resolve(const alfred_addr *addr)
+{
+	const struct sockaddr *sockaddr;
+	struct sockaddr_in inet4;
+	size_t sockaddr_len;
+	int sock;
+	char t = 0;
+
+	sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock < 0)
+		return;
+
+	memset(&inet4, 0, sizeof(inet4));
+	inet4.sin_family = AF_INET;
+	inet4.sin_port = htons(9);
+	inet4.sin_addr.s_addr = addr->ipv4.s_addr;
+	sockaddr = (const struct sockaddr *)&inet4;
+	sockaddr_len = sizeof(inet4);
+
+	sendto(sock, &t, sizeof(t), 0, sockaddr, sockaddr_len);
+	close(sock);
+}
+
 int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
 		     struct ether_addr *mac)
 {
 	struct arpreq arpreq;
 	struct sockaddr_in *sin;
+	int retries = 1;
 
 	memset(&arpreq, 0, sizeof(arpreq));
 	memset(mac, 0, ETH_ALEN);
@@ -96,8 +121,13 @@ int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
 	strncpy(arpreq.arp_dev, interface->interface, sizeof(arpreq.arp_dev));
 	arpreq.arp_dev[sizeof(arpreq.arp_dev) - 1] = '\0';
 
-	if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
-		return -1;
+	while ((ioctl(interface->netsock, SIOCGARP, &arpreq) < 0) || !(arpreq.arp_flags & ATF_COM)) {
+		ipv4_request_mac_resolve(addr);
+		usleep(200000);
+
+		if (retries-- == 0)
+			break;
+	}
 
 	if (arpreq.arp_flags & ATF_COM) {
 		memcpy(mac, arpreq.arp_ha.sa_data, sizeof(*mac));
-- 
2.17.1

