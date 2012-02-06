Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  6 Feb 2012 23:11:53 +0100
Message-Id: <1328566314-16721-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove declaration of only
	locally used functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The blaII code removed references to two functions outside of the own source
file. route_unicast_packet can be marked as static since
9c11509d3bbf914060be1bcb4448ea69d571fcb9 and tt_global_del since
7c5289cb52a5cecaeeddc719cd52b50bb17263dd

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing.c           |    5 ++++-
 routing.h           |    1 -
 translation-table.c |    7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/routing.c b/routing.c
index 4a0e265..7b7fcbe 100644
--- a/routing.c
+++ b/routing.c
@@ -31,6 +31,9 @@
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
 
+static int route_unicast_packet(struct sk_buff *skb,
+				struct hard_iface *recv_if);
+
 void slide_own_bcast_window(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
@@ -806,7 +809,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node = NULL;
diff --git a/routing.h b/routing.h
index 92ac100..3d729cb 100644
--- a/routing.h
+++ b/routing.h
@@ -25,7 +25,6 @@
 void slide_own_bcast_window(struct hard_iface *hard_iface);
 void update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		  struct neigh_node *neigh_node);
-int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if);
diff --git a/translation-table.c b/translation-table.c
index 295d4b3..9a07882 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -816,9 +816,10 @@ static void tt_global_del_roaming(struct bat_priv *bat_priv,
 
 
 
-void tt_global_del(struct bat_priv *bat_priv,
-		   struct orig_node *orig_node, const unsigned char *addr,
-		   const char *message, bool roaming)
+static void tt_global_del(struct bat_priv *bat_priv,
+			  struct orig_node *orig_node,
+			  const unsigned char *addr,
+			  const char *message, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry = NULL;
 	struct tt_local_entry *tt_local_entry = NULL;
-- 
1.7.8.3

