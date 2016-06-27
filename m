Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Jun 2016 08:15:42 +0200
Message-Id: <1467008142-3797-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Remove orig_node reference
	handling from send_skb_unicast
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

The function batadv_send_skb_unicast is not acquiring a reference for an
orig_node nor removing it from any datastructure. It still reduces the
reference counter for an object which is still in the hands of the caller.

This is confusing and can lead in the future to problems in the reference
handling of the caller function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - adjust commit message to sound less like an fix (thanks Linus)
 - Remove " and release a reference to this orig_node" from kerneldoc of
   batadv_send_skb_unicast (thanks Linus)
v2:
 - remove bogus multicast example
 - remove Fixes:
---
 net/batman-adv/send.c           | 25 +++++++++++++++++--------
 net/batman-adv/soft-interface.c |  3 +++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 729deec..b4294ac 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -307,8 +307,7 @@ out:
  *
  * Wrap the given skb into a batman-adv unicast or unicast-4addr header
  * depending on whether BATADV_UNICAST or BATADV_UNICAST_4ADDR was supplied
- * as packet_type. Then send this frame to the given orig_node and release a
- * reference to this orig_node.
+ * as packet_type. Then send this frame to the given orig_node.
  *
  * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
@@ -362,8 +361,6 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 		ret = NET_XMIT_SUCCESS;
 
 out:
-	if (orig_node)
-		batadv_orig_node_put(orig_node);
 	if (ret == NET_XMIT_DROP)
 		kfree_skb(skb);
 	return ret;
@@ -395,6 +392,7 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_orig_node *orig_node;
 	u8 *src, *dst;
+	int ret;
 
 	src = ethhdr->h_source;
 	dst = ethhdr->h_dest;
@@ -406,8 +404,13 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 	}
 	orig_node = batadv_transtable_search(bat_priv, src, dst, vid);
 
-	return batadv_send_skb_unicast(bat_priv, skb, packet_type,
-				       packet_subtype, orig_node, vid);
+	ret = batadv_send_skb_unicast(bat_priv, skb, packet_type,
+				      packet_subtype, orig_node, vid);
+
+	if (orig_node)
+		batadv_orig_node_put(orig_node);
+
+	return ret;
 }
 
 /**
@@ -425,10 +428,16 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			   unsigned short vid)
 {
 	struct batadv_orig_node *orig_node;
+	int ret;
 
 	orig_node = batadv_gw_get_selected_orig(bat_priv);
-	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
-				       orig_node, vid);
+	ret = batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
+				      orig_node, vid);
+
+	if (orig_node)
+		batadv_orig_node_put(orig_node);
+
+	return ret;
 }
 
 void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 216ac03..e508bf5 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -57,6 +57,7 @@
 #include "hard-interface.h"
 #include "multicast.h"
 #include "network-coding.h"
+#include "originator.h"
 #include "packet.h"
 #include "send.h"
 #include "sysfs.h"
@@ -377,6 +378,8 @@ dropped:
 dropped_freed:
 	batadv_inc_counter(bat_priv, BATADV_CNT_TX_DROPPED);
 end:
+	if (mcast_single_orig)
+		batadv_orig_node_put(mcast_single_orig);
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	return NETDEV_TX_OK;
-- 
2.8.1

