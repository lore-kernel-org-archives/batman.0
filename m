From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 14 Jan 2009 01:59:39 +0100
Message-Id: <1231894779-29325-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200901140145.34127.sven.eckelmann@gmx.de>
References: <200901140145.34127.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Sync definitions in bsd/* with definitions
	in os.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/bsd/kernel.c |    9 ++-------
 batman/bsd/tun.c    |    6 +++---
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/batman/bsd/kernel.c b/batman/bsd/kernel.c
index 505f551..0a126d4 100644
--- a/batman/bsd/kernel.c
+++ b/batman/bsd/kernel.c
@@ -35,7 +35,7 @@
 #include "../os.h"
 #include "../batman.h"
 
-void set_forwarding(int state)
+void set_forwarding(int32_t state)
 {
 	int mib[4];
 
@@ -56,7 +56,7 @@ void set_forwarding(int state)
 		err(1, "Cannot change net.inet.ip.forwarding");
 }
 
-int get_forwarding(void)
+int32_t get_forwarding(void)
 {
 	int state;
 	size_t len;
@@ -138,11 +138,6 @@ int8_t bind_to_iface( int32_t udp_recv_sock, char *dev )
 	return 1;
 }
 
-int8_t use_kernel_module( char *dev )
-{
-	return -1;
-}
-
 int32_t use_gateway_module(void)
 {
 	return -1;
diff --git a/batman/bsd/tun.c b/batman/bsd/tun.c
index d38b954..7d4c79c 100644
--- a/batman/bsd/tun.c
+++ b/batman/bsd/tun.c
@@ -51,7 +51,7 @@
  * this string is assumed to be dev_name_size bytes large.
  */
 #if defined(__OpenBSD__) || defined(__Darwin__)
-int open_tun_any(char *dev_name, size_t dev_name_size)
+static int open_tun_any(char *dev_name, size_t dev_name_size)
 {
 	int i;
 	int fd;
@@ -72,7 +72,7 @@ int open_tun_any(char *dev_name, size_t dev_name_size)
 	return -1;
 }
 #elif defined(__FreeBSD__)
-int open_tun_any(char *dev_name, size_t dev_name_size)
+static int open_tun_any(char *dev_name, size_t dev_name_size)
 {
 	int fd;
 	struct stat buf;
@@ -90,7 +90,7 @@ int open_tun_any(char *dev_name, size_t dev_name_size)
 #endif
 
 /* Probe for tun interface availability */
-int8_t probe_tun()
+int8_t probe_tun(uint8_t print_to_stderr)
 {
 	int fd;
 	fd = open_tun_any(NULL, 0);
-- 
1.6.0.6

