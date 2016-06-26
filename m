Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Jun 2016 00:55:21 +0200
Message-Id: <1466981721-3202-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Remove orig_node reference
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

This is confusing and can lead to problems in the reference handling in the
caller function. This breaks for example the reference counting in
batadv_interface_tx when an DHCP packet (BATADV_DHCP_TO_SERVER)  is
detected in a multicast (not broadcast) packet which is later detected by
the multicast code as BATADV_FORW_SINGLE. The multicast code then assumes
that it will send it and acquires the originator to the destination. But in
reality, the DHCP forwarding code takes precedence and as result the
reference counter is not decreased anymore.

Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multicast packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/send.c           | 22 ++++++++++++++++------
 net/batman-adv/soft-interface.c |  3 +++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 729deec..44be408 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -362,8 +362,6 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 		ret = NET_XMIT_SUCCESS;
 
 out:
-	if (orig_node)
-		batadv_orig_node_put(orig_node);
 	if (ret == NET_XMIT_DROP)
 		kfree_skb(skb);
 	return ret;
@@ -395,6 +393,7 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_orig_node *orig_node;
 	u8 *src, *dst;
+	int ret;
 
 	src = ethhdr->h_source;
 	dst = ethhdr->h_dest;
@@ -406,8 +405,13 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
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
@@ -425,10 +429,16 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
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

