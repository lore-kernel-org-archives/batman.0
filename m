From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri,  6 Feb 2009 19:00:25 +0100
Message-Id: <1233943226-24592-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200901140236.58441.sven.eckelmann@gmx.de>
References: <200901140236.58441.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Introduce get_tunneled_(protocol|udpdest)
	for better portability
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

FreeBSD has different definition of udp and ip headers then systems with
glibc. To support both a two new static functions were introduced.

 * get_tunneled_protocol - get protocol of inside the tunneled ip packet
 * get_tunneled_udpdest - get udp port of tunneled udp/ip packet

New systems can easily introduced in that way without changing the real
code.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/posix/tunnel.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/batman/posix/tunnel.c b/batman/posix/tunnel.c
index a576bb9..44a4ff0 100644
--- a/batman/posix/tunnel.c
+++ b/batman/posix/tunnel.c
@@ -28,6 +28,7 @@
 #include <arpa/inet.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <netinet/in_systm.h>
 #include <netinet/ip.h>
 #include <netinet/udp.h>
 #include <netinet/tcp.h>
@@ -70,6 +71,28 @@ void init_bh_ports(void)
 
 
 
+static uint8_t get_tunneled_protocol(const unsigned char *buff)
+{
+#if defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__Darwin__)
+	return ((struct ip *)(buff + 1))->ip_p;
+#else
+	return ((struct iphdr *)(buff + 1))->protocol;
+#endif
+}
+
+
+
+static uint16_t get_tunneled_udpdest(const unsigned char *buff)
+{
+#if defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__Darwin__)
+	return ((struct udphdr *)(buff + 1 + ((struct ip *)(buff + 1))->ip_hl*4))->uh_dport;
+#else
+	return ((struct udphdr *)(buff + 1 + ((struct iphdr *)(buff + 1))->ihl*4))->dest;
+#endif
+}
+
+
+
 static int8_t get_tun_ip(struct sockaddr_in *gw_addr, int32_t udp_sock, uint32_t *tun_addr)
 {
 	struct sockaddr_in sender_addr;
@@ -257,7 +280,7 @@ void *client_to_gw_tun(void *arg)
 					if (write(tun_fd, buff + 1, buff_len - 1) < 0)
 						debug_output(0, "Error - can't write packet: %s\n", strerror(errno));
 
-					if (((struct iphdr *)(buff + 1))->protocol != IPPROTO_ICMP) {
+					if (get_tunneled_protocol(buff) != IPPROTO_ICMP) {
 						gw_state = GW_STATE_VERIFIED;
 						gw_state_time = current_time;
 					}
@@ -305,11 +328,11 @@ void *client_to_gw_tun(void *arg)
 
 				ignore_packet = 0;
 
-				if (((struct iphdr *)(buff + 1))->protocol == IPPROTO_UDP) {
+				if (get_tunneled_protocol(buff) == IPPROTO_UDP) {
 
 					for (i = 0; i < (int)(sizeof(bh_udp_ports)/sizeof(short)); i++) {
 
-						if (((struct udphdr *)(buff + 1 + ((struct iphdr *)(buff + 1))->ihl*4))->dest == bh_udp_ports[i]) {
+						if (get_tunneled_udpdest(buff) == bh_udp_ports[i]) {
 
 							ignore_packet = 1;
 							break;
@@ -318,7 +341,7 @@ void *client_to_gw_tun(void *arg)
 
 					}
 
-				} else if (((struct iphdr *)(buff + 1))->protocol == IPPROTO_ICMP) {
+				} else if (get_tunneled_protocol(buff) == IPPROTO_ICMP) {
 
 					ignore_packet = 1;
 
-- 
1.6.0.6

