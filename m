Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <20181029175759.20637-1-jhaws@sdl.usu.edu>
In-Reply-To: <20181029175759.20637-1-jhaws@sdl.usu.edu>
Date: Thu, 1 Nov 2018 09:30:53 +0800
Message-ID: <004001d47182$88620780$99261680$@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] alfred: Request MAC resolution for
 IPv4 address not in ARP cache
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Jonathan Haws' <jhaws@sdl.usu.edu>, b.a.t.m.a.n@lists.open-mesh.org


Tested-by: Gary Zou <guohuizou2000@sina.com>

-----Original Message-----
From: Jonathan Haws <jhaws@sdl.usu.edu>=20
Sent: 2018=C4=EA10=D4=C230=C8=D5 1:58
To: guohuizou2000@sina.com; b.a.t.m.a.n@lists.open-mesh.org
Cc: Jonathan Haws <jhaws@sdl.usu.edu>
Subject: [B.A.T.M.A.N.][PATCH v3] alfred: Request MAC resolution for =
IPv4
address not in ARP cache


When using IPv4, if the remote server is not yet in the ARP cache, the =
MAC
resolution will fail and data appear to not be shared via alfred.
Add a routine (modified from batctl sources) to request MAC resolution =
by
simply sending a datagram to the discard port (UDP/9). This adds the =
remote
MAC to the ARP cache, resulting in successful MAC resolution.

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
=20
 int time_diff(struct timespec *tv1, struct timespec *tv2, @@ -80,11 =
+81,35
@@ bool is_valid_ether_addr(uint8_t addr[ETH_ALEN])
 	return true;
 }
=20
+static void ipv4_request_mac_resolve(const alfred_addr *addr) {
+	const struct sockaddr *sockaddr;
+	struct sockaddr_in inet4;
+	size_t sockaddr_len;
+	int sock;
+	char t =3D 0;
+
+	sock =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (sock < 0)
+		return;
+
+	memset(&inet4, 0, sizeof(inet4));
+	inet4.sin_family =3D AF_INET;
+	inet4.sin_port =3D htons(9);
+	inet4.sin_addr.s_addr =3D addr->ipv4.s_addr;
+	sockaddr =3D (const struct sockaddr *)&inet4;
+	sockaddr_len =3D sizeof(inet4);
+
+	sendto(sock, &t, sizeof(t), 0, sockaddr, sockaddr_len);
+	close(sock);
+}
+
 int ipv4_arp_request(struct interface *interface, const alfred_addr =
*addr,
 		     struct ether_addr *mac)
 {
 	struct arpreq arpreq;
 	struct sockaddr_in *sin;
+	int retries =3D 1;
=20
 	memset(&arpreq, 0, sizeof(arpreq));
 	memset(mac, 0, ETH_ALEN);
@@ -96,8 +121,13 @@ int ipv4_arp_request(struct interface *interface, =
const
alfred_addr *addr,
 	strncpy(arpreq.arp_dev, interface->interface,
sizeof(arpreq.arp_dev));
 	arpreq.arp_dev[sizeof(arpreq.arp_dev) - 1] =3D '\0';
=20
-	if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
-		return -1;
+	while ((ioctl(interface->netsock, SIOCGARP, &arpreq) < 0) ||
!(arpreq.arp_flags & ATF_COM)) {
+		ipv4_request_mac_resolve(addr);
+		usleep(200000);
+
+		if (retries-- =3D=3D 0)
+			break;
+	}
=20
 	if (arpreq.arp_flags & ATF_COM) {
 		memcpy(mac, arpreq.arp_ha.sa_data, sizeof(*mac));
--
2.17.1




