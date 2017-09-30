Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Sep 2017 09:31:11 +0200
Message-Id: <20170930073111.8645-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add argument names for function
 ptr definitions
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

checkpatch started to report unnamed arguments in function pointer
definitions. Add the corresponding names to these definitions to avoid this
warning.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 033819ae..4daed7ad 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -73,8 +73,8 @@
  * list traversals just rcu-locked
  */
 struct list_head batadv_hardif_list;
-static int (*batadv_rx_handler[256])(struct sk_buff *,
-				     struct batadv_hard_iface *);
+static int (*batadv_rx_handler[256])(struct sk_buff *skb,
+				     struct batadv_hard_iface *recv_if);
 
 unsigned char batadv_broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -540,8 +540,8 @@ batadv_recv_handler_register(u8 packet_type,
 			     int (*recv_handler)(struct sk_buff *,
 						 struct batadv_hard_iface *))
 {
-	int (*curr)(struct sk_buff *,
-		    struct batadv_hard_iface *);
+	int (*curr)(struct sk_buff *skb,
+		    struct batadv_hard_iface *recv_if);
 	curr = batadv_rx_handler[packet_type];
 
 	if (curr != batadv_recv_unhandled_packet &&
-- 
2.11.0

