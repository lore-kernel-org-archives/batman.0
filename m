Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 25 Jun 2011 19:09:12 +0200
Message-Id: <1309021752-29697-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add_bcast_packet_to_list() takes
	the sending delay as parameter
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

In order to make possible to use the broadcast list for delayed sendings
the "delay" parameter is now provided instead of using 1 as hardcoded
value.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c        |    2 +-
 send.c           |    4 ++--
 send.h           |    2 +-
 soft-interface.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/routing.c b/routing.c
index 0ce090c..2cb98be 100644
--- a/routing.c
+++ b/routing.c
@@ -1677,7 +1677,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
 	/* rebroadcast packet */
-	add_bcast_packet_to_list(bat_priv, skb);
+	add_bcast_packet_to_list(bat_priv, skb, 1);
 
 	/* broadcast for me */
 	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
diff --git a/send.c b/send.c
index 9a4f20c..708f99c 100644
--- a/send.c
+++ b/send.c
@@ -455,7 +455,7 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
  * The skb is not consumed, so the caller should make sure that the
  * skb is freed. */
 int add_bcast_packet_to_list(struct bat_priv *bat_priv,
-			     const struct sk_buff *skb)
+			     const struct sk_buff *skb, unsigned long delay)
 {
 	struct hard_iface *primary_if = NULL;
 	struct forw_packet *forw_packet;
@@ -492,7 +492,7 @@ int add_bcast_packet_to_list(struct bat_priv *bat_priv,
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
 
-	_add_bcast_packet_to_list(bat_priv, forw_packet, 1);
+	_add_bcast_packet_to_list(bat_priv, forw_packet, delay);
 	return NETDEV_TX_OK;
 
 packet_free:
diff --git a/send.h b/send.h
index 633224a..1f2d1e8 100644
--- a/send.h
+++ b/send.h
@@ -31,7 +31,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     int directlink,
 			     struct hard_iface *if_outgoing);
 int add_bcast_packet_to_list(struct bat_priv *bat_priv,
-			     const struct sk_buff *skb);
+			     const struct sk_buff *skb, unsigned long delay);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct bat_priv *bat_priv,
 			       const struct hard_iface *hard_iface);
diff --git a/soft-interface.c b/soft-interface.c
index 2dcdbb7..3f20332 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -634,7 +634,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		bcast_packet->seqno =
 			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
 
-		add_bcast_packet_to_list(bat_priv, skb);
+		add_bcast_packet_to_list(bat_priv, skb, 1);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
-- 
1.7.3.4

