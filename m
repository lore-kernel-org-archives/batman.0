Date: Thu, 25 Sep 2008 16:50:02 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080925145002.GA9344@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Allow unoptimized builds of batgat
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

Currently htons is a functions provided by userspace libraries and will only be
replaced by a special builtin functions of gcc when optimization is enabled.
Linux v2.6.27-rc2-497-gbc2aa80 will provide these function symbols as macros
for in-kernel usage.
---
 batman/linux/modules/gateway.c   |    4 ++--
 batman/linux/modules/gateway24.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 9411575..41d75b5 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -313,7 +313,7 @@ static int packet_recv_thread(void *data)
 
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_addr.s_addr = INADDR_ANY;
-	server_addr.sin_port = htons( (unsigned short) BATMAN_PORT );
+	server_addr.sin_port = __constant_htons( (unsigned short) BATMAN_PORT );
 
 	if ( ( sock_create_kern( PF_INET, SOCK_RAW, IPPROTO_RAW, &inet_sock ) ) < 0 ) {
 
@@ -551,7 +551,7 @@ static int bat_netdev_xmit( struct sk_buff *skb, struct net_device *dev )
 
 		sa.sin_family = AF_INET;
 		sa.sin_addr.s_addr = client_data->wip_addr;
-		sa.sin_port = htons( (unsigned short)BATMAN_PORT );
+		sa.sin_port = __constant_htons( (unsigned short)BATMAN_PORT );
 
 		msg.msg_flags = MSG_NOSIGNAL | MSG_DONTWAIT;
 		msg.msg_name = &sa;
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index 9b60fe4..dbd1f42 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -291,7 +291,7 @@ static int packet_recv_thread(void *data)
 
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_addr.s_addr = INADDR_ANY;
-	server_addr.sin_port = htons( (unsigned short) BATMAN_PORT );
+	server_addr.sin_port = __constant_htons( (unsigned short) BATMAN_PORT );
 
 	if ( ( sock_create( PF_INET, SOCK_RAW, IPPROTO_RAW, &inet_sock ) ) < 0 ) {
 
@@ -509,7 +509,7 @@ static int bat_netdev_xmit( struct sk_buff *skb, struct net_device *dev )
 
 		sa.sin_family = AF_INET;
 		sa.sin_addr.s_addr = client_data->wip_addr;
-		sa.sin_port = htons( (unsigned short)BATMAN_PORT );
+		sa.sin_port = __constant_htons( (unsigned short)BATMAN_PORT );
 
 		msg.msg_flags = MSG_NOSIGNAL | MSG_DONTWAIT;
 		msg.msg_name = &sa;
-- 
1.6.0.1


