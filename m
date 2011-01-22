Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:32 +0100
Message-Id: <1295659302-7171-10-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 09/19] batman-adv: Route multicast tracker
	packets
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

This commit adds the ability to also forward a received multicast
tracker packet (if necessary). It also makes use of the same splitting
methods introduced with one of the previous commits, in case of multiple
next hop destinations.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 hard-interface.c |    5 +++++
 routing.c        |   19 +++++++++++++++++++
 routing.h        |    1 +
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 2bae3e4..f478c4b 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -624,6 +624,11 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		ret = recv_bcast_packet(skb, batman_if);
 		break;
 
+		/* multicast tracker packet */
+	case BAT_MCAST_TRACKER:
+		ret = recv_mcast_tracker_packet(skb, batman_if);
+		break;
+
 		/* vis packet */
 	case BAT_VIS:
 		ret = recv_vis_packet(skb, batman_if);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 4f55715..944dc94 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -35,6 +35,7 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "unicast.h"
+#include "multicast.h"
 
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
@@ -1500,6 +1501,24 @@ out:
 	return ret;
 }
 
+int recv_mcast_tracker_packet(struct sk_buff *skb, struct batman_if *recv_if)
+{
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct mcast_tracker_packet *tracker_packet;
+	int hdr_size = sizeof(struct mcast_tracker_packet);
+
+	if (check_unicast_packet(skb, hdr_size) < 0)
+		return NET_RX_DROP;
+
+	tracker_packet = (struct mcast_tracker_packet *)skb->data;
+
+	route_mcast_tracker_packet(tracker_packet, skb->len, bat_priv);
+
+	dev_kfree_skb(skb);
+
+	return NET_RX_SUCCESS;
+}
+
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct vis_packet *vis_packet;
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index bf508e6..0fad12a 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -38,6 +38,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_mcast_tracker_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
-- 
1.7.2.3

