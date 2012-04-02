Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon,  2 Apr 2012 14:48:16 +0200
Message-Id: <1333370896-11295-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Increment stat counters on rx,
	tx, fwd
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Make actual use of the stat interface introduced in prev commit.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 routing.c        |    2 ++
 soft-interface.c |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/routing.c b/routing.c
index 795d3af..a119648 100644
--- a/routing.c
+++ b/routing.c
@@ -30,6 +30,7 @@
 #include "vis.h"
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
+#include "bat_stats.h"
 
 static int route_unicast_packet(struct sk_buff *skb,
 				struct hard_iface *recv_if);
@@ -870,6 +871,7 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	unicast_packet->header.ttl--;
 
 	/* route it */
+	bat_stats_update(bat_priv, BAT_STAT_FORWARD);
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
 
diff --git a/soft-interface.c b/soft-interface.c
index 92137af..774b412 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -38,6 +38,7 @@
 #include <linux/if_vlan.h>
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
+#include "bat_stats.h"
 
 
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
@@ -235,6 +236,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 		dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
+		bat_stats_update(bat_priv, BAT_STAT_XMIT);
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
 			goto dropped_freed;
@@ -302,6 +304,7 @@ void interface_rx(struct net_device *soft_iface,
 
 /*	skb->ip_summed = CHECKSUM_UNNECESSARY;*/
 
+	bat_stats_update(bat_priv, BAT_STAT_RECV);
 	bat_priv->stats.rx_packets++;
 	bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
 
-- 
1.7.9.5

