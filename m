Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 27 Jan 2017 15:10:44 +0100
Message-Id: <20170127141044.5317-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Avoid buffer overflow while querying
	ARP cache
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

The arpreq.arp_dev is a limited buffer (16 bytes). Avoid that more bytes
from the interface name are copied into this buffer by switching from
strcpy to strncpy.

Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util.c b/util.c
index 84ab3af..ed83895 100644
--- a/util.c
+++ b/util.c
@@ -92,7 +92,9 @@ int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
 	sin->sin_family = AF_INET;
 	sin->sin_addr.s_addr = addr->ipv4.s_addr;
 
-	strcpy(arpreq.arp_dev, interface->interface);
+	strncpy(arpreq.arp_dev, interface->interface, sizeof(arpreq.arp_dev));
+	arpreq.arp_dev[sizeof(arpreq.arp_dev) - 1] = '\0';
+
 	if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
 		return -1;
 
-- 
2.11.0

