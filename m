Date: Wed, 24 Sep 2008 23:59:39 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080924215939.GA9277@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Send TUNNEL_IP_REQUEST as response of
	TUNNEL_IP_REQUEST
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

Userspace gateway sends TUNNEL_IP_REQUEST when he receives TUNNEL_IP_REQUEST
and will not start to send new IP as TUNNEL_DATA
---
 batman/linux/modules/gateway.c   |    1 -
 batman/linux/modules/gateway24.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index 154497e..9411575 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -405,7 +405,6 @@ static int packet_recv_thread(void *data)
 
 				if(client_data != NULL) {
 
-					buffer[0] = TUNNEL_DATA;
 					memcpy( &buffer[1], &client_data->vip_addr, sizeof( client_data->vip_addr ) );
 
 					iov.iov_base = buffer;
diff --git a/batman/linux/modules/gateway24.c b/batman/linux/modules/gateway24.c
index 585fe85..9b60fe4 100644
--- a/batman/linux/modules/gateway24.c
+++ b/batman/linux/modules/gateway24.c
@@ -385,7 +385,6 @@ static int packet_recv_thread(void *data)
 
 				if(client_data != NULL) {
 
-					buffer[0] = TUNNEL_DATA;
 					memcpy( &buffer[1], &client_data->vip_addr, sizeof( client_data->vip_addr ) );
 
 					iov.iov_base = buffer;
-- 
1.6.0.1


