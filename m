Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat, 21 May 2016 20:17:55 +0800
Message-Id: <20160521121756.27450-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove useless forward
	declarations
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
Cc: Antonio Quartulli <a@unstable.cc>

If main.h is included, the batman-adv private forward declarations are
not needed anymore. Remove them.

Cc: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/gateway_client.h | 1 -
 net/batman-adv/icmp_socket.h    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 582dd8c..c74aca5 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -22,7 +22,6 @@
 
 #include <linux/types.h>
 
-struct batadv_tvlv_gateway_data;
 struct seq_file;
 struct sk_buff;
 
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 618d5de..ce3ed25 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -22,8 +22,6 @@
 
 #include <linux/types.h>
 
-struct batadv_icmp_header;
-
 #define BATADV_ICMP_SOCKET "socket"
 
 void batadv_socket_init(void);
-- 
2.8.3

