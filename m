Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:22 +0100
Message-Id: <1296362366-3852-15-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
References: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 14/18] batman-adv: Forward multicast data in
	proact_tracking mode
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

This patch enables the forwarding of multicast data and uses the same
methods for deciding to forward via broad- or unicast(s) as the local
packet encapsulation already did.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 multicast.c |    2 +-
 multicast.h |    1 +
 routing.c   |    4 ++++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/batman-adv/multicast.c b/batman-adv/multicast.c
index 685d3f3..24bc85a 100644
--- a/batman-adv/multicast.c
+++ b/batman-adv/multicast.c
@@ -1228,7 +1228,7 @@ static inline void nexthops_from_table(uint8_t *dest, uint8_t *orig,
 	}
 }
 
-static void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
+void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct sk_buff *skb1;
 	struct mcast_packet *mcast_packet;
diff --git a/batman-adv/multicast.h b/batman-adv/multicast.h
index 2fe9910..abd828e 100644
--- a/batman-adv/multicast.h
+++ b/batman-adv/multicast.h
@@ -31,6 +31,7 @@ void route_mcast_tracker_packet(struct sk_buff *tracker_packet,
 				struct bat_priv *bat_priv);
 void purge_mcast_forw_table(struct bat_priv *bat_priv);
 int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset);
+void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv);
 int mcast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 067545c..05482d4 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1508,6 +1508,7 @@ out:
 
 int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct ethhdr *ethhdr;
 	struct netdev_hw_addr *mc_entry;
 	int ret = 1;
@@ -1518,6 +1519,9 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	    check_broadcast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
+	/* forward multicast packet if necessary */
+	route_mcast_packet(skb, bat_priv);
+
 	ethhdr = (struct ethhdr *)(skb->data + sizeof(struct mcast_packet));
 
 	/* multicast for me? */
-- 
1.7.2.3

