Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:26 +0100
Message-Id: <1291761150-29818-16-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 16/20] batman-adv: Forward multicast data in
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

diff --git a/multicast.c b/multicast.c
index 72249ef..042d392 100644
--- a/multicast.c
+++ b/multicast.c
@@ -1059,7 +1059,7 @@ int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
+void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct sk_buff *skb1;
 	struct mcast_packet *mcast_packet;
diff --git a/multicast.h b/multicast.h
index 06dd398..6dcf537 100644
--- a/multicast.h
+++ b/multicast.h
@@ -32,6 +32,7 @@ void route_mcast_tracker_packet(
 			int tracker_packet_len, struct bat_priv *bat_priv);
 void purge_mcast_forw_table(struct bat_priv *bat_priv);
 int mcast_forw_table_seq_print_text(struct seq_file *seq, void *offset);
+void route_mcast_packet(struct sk_buff *skb, struct bat_priv *bat_priv);
 int mcast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int mcast_init(struct bat_priv *bat_priv);
 void mcast_free(struct bat_priv *bat_priv);
diff --git a/routing.c b/routing.c
index b1aad26..f9582be 100644
--- a/routing.c
+++ b/routing.c
@@ -1390,6 +1390,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct ethhdr *ethhdr;
 	MC_LIST *mc_entry;
 	unsigned long flags;
@@ -1401,6 +1402,9 @@ int recv_mcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	    check_broadcast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
+	/* forward multicast packet if necessary */
+	route_mcast_packet(skb, bat_priv);
+
 	ethhdr = (struct ethhdr *)(skb->data + sizeof(struct mcast_packet));
 
 	/* multicast for me? */
-- 
1.7.1

