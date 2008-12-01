From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 21:48:47 +0100
Message-Id: <1228164527-31652-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Don't truncate file descriptor in
	use_kernel_module
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

We should not truncate the file descriptor of /dev/batgat from int32_t
to int8_t (return type of use_kernel_module) when we save it as int32_t
in batman_if::udp_tunnel_sock.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/bsd/kernel.c   |    2 +-
 batman/linux/kernel.c |    2 +-
 batman/os.h           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/batman/bsd/kernel.c b/batman/bsd/kernel.c
index 90076e3..505f551 100644
--- a/batman/bsd/kernel.c
+++ b/batman/bsd/kernel.c
@@ -143,7 +143,7 @@ int8_t use_kernel_module( char *dev )
 	return -1;
 }
 
-int8_t use_gateway_module(void)
+int32_t use_gateway_module(void)
 {
 	return -1;
 }
diff --git a/batman/linux/kernel.c b/batman/linux/kernel.c
index 09c24da..da98197 100644
--- a/batman/linux/kernel.c
+++ b/batman/linux/kernel.c
@@ -193,7 +193,7 @@ int8_t bind_to_iface( int32_t sock, char *dev ) {
 
 
 
-int8_t use_gateway_module(void) {
+int32_t use_gateway_module(void) {
 
 	int32_t fd;
 
diff --git a/batman/os.h b/batman/os.h
index da61d18..ee5e536 100644
--- a/batman/os.h
+++ b/batman/os.h
@@ -70,7 +70,7 @@ int32_t get_send_redirects( char *dev );
 void set_forwarding( int32_t state );
 int32_t get_forwarding( void );
 int8_t bind_to_iface( int32_t sock, char *dev );
-int8_t use_gateway_module(void);
+int32_t use_gateway_module(void);
 
 /* posix.c */
 void print_animation( void );
-- 
1.6.0.4

