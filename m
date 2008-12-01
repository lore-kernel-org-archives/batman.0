From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 20:14:14 +0100
Message-Id: <1228158854-30405-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200812012005.27477.sven.eckelmann@gmx.de>
References: <200812012005.27477.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] Remove unused parameter of
	use_gateway_module
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/os.h         |    2 +-
 batman/posix/init.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman/os.h b/batman/os.h
index 76525bf..5531bae 100644
--- a/batman/os.h
+++ b/batman/os.h
@@ -70,7 +70,7 @@ int32_t get_send_redirects( char *dev );
 void set_forwarding( int32_t state );
 int32_t get_forwarding( void );
 int8_t bind_to_iface( int32_t sock, char *dev );
-int8_t use_gateway_module();
+int8_t use_gateway_module(void);
 
 /* posix.c */
 void print_animation( void );
diff --git a/batman/posix/init.c b/batman/posix/init.c
index 79d5a3b..9ad06f9 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -1152,7 +1152,7 @@ void init_interface_gw (void) {
 	struct batman_if *batman_if = (struct batman_if *)if_list.next;
 
 
-	if ( ( batman_if->udp_tunnel_sock = use_gateway_module( batman_if->dev ) ) < 0 ) {
+	if ( ( batman_if->udp_tunnel_sock = use_gateway_module() ) < 0 ) {
 
 		batman_if->addr.sin_port = htons(GW_PORT);
 
-- 
1.6.0.4

