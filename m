Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:25 +0100
Message-Id: <1291761150-29818-15-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 15/20] batman-adv: Receive multicast data
	packets BAT_MCAST
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

This patch adds the forwarding of multicast data packets to the local
soft interface if this receiving node is a member of the same multicast
group as specified in the multicast packet.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 hard-interface.c |    5 +++++
 routing.c        |   30 ++++++++++++++++++++++++++++++
 routing.h        |    1 +
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 3b380e1..b668ae6 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -624,6 +624,11 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		ret = recv_bcast_packet(skb, batman_if);
 		break;
 
+		/* multicast packet */
+	case BAT_MCAST:
+		ret = recv_mcast_packet(skb, batman_if);
+		break;
+
 		/* multicast tracker packet */
 	case BAT_MCAST_TRACKER:
 		ret = recv_mcast_tracker_packet(skb, batman_if);
diff --git a/routing.c b/routing.c
index ff74bd1..b1aad26 100644
--- a/routing.c
+++ b/routing.c
@@ -1388,6 +1388,36 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	return NET_RX_SUCCESS;
 }
 
+int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
+{
+	struct ethhdr *ethhdr;
+	MC_LIST *mc_entry;
+	unsigned long flags;
+	int ret = 1;
+	int hdr_size = sizeof(struct mcast_packet);
+
+	/* multicast data packets might be received via unicast or broadcast */
+	if (check_unicast_packet(skb, hdr_size) < 0 &&
+	    check_broadcast_packet(skb, hdr_size) < 0)
+		return NET_RX_DROP;
+
+	ethhdr = (struct ethhdr *)(skb->data + sizeof(struct mcast_packet));
+
+	/* multicast for me? */
+	MC_LIST_LOCK(recv_if->soft_iface, flags);
+	netdev_for_each_mc_addr(mc_entry, recv_if->soft_iface) {
+		ret = memcmp(mc_entry->MC_LIST_ADDR, ethhdr->h_dest, ETH_ALEN);
+		if (!ret)
+			break;
+	}
+	MC_LIST_UNLOCK(recv_if->soft_iface, flags);
+
+	if (!ret)
+		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+
+	return NET_RX_SUCCESS;
+}
+
 int recv_mcast_tracker_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
diff --git a/routing.h b/routing.h
index ad3f054..6b45212 100644
--- a/routing.h
+++ b/routing.h
@@ -38,6 +38,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_mcast_tracker_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
-- 
1.7.1

