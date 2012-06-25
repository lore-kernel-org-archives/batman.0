Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Jun 2012 08:54:42 +0200
Message-Id: <1340607284-29950-19-git-send-email-ordex@autistici.org>
In-Reply-To: <1340607284-29950-1-git-send-email-ordex@autistici.org>
References: <1340607284-29950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 18/20] batman-adv: Prefix send local static
	functions with batadv_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/send.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 47c3a41..1842cbc 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -27,7 +27,7 @@
 #include "gateway_common.h"
 #include "originator.h"
 
-static void send_outstanding_bcast_packet(struct work_struct *work);
+static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
  * specified batman interface
@@ -96,7 +96,7 @@ void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
 	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface);
 }
 
-static void forw_packet_free(struct forw_packet *forw_packet)
+static void batadv_forw_packet_free(struct forw_packet *forw_packet)
 {
 	if (forw_packet->skb)
 		kfree_skb(forw_packet->skb);
@@ -105,9 +105,9 @@ static void forw_packet_free(struct forw_packet *forw_packet)
 	kfree(forw_packet);
 }
 
-static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
-				      struct forw_packet *forw_packet,
-				      unsigned long send_time)
+static void _batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+					     struct forw_packet *forw_packet,
+					     unsigned long send_time)
 {
 	INIT_HLIST_NODE(&forw_packet->list);
 
@@ -118,7 +118,7 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
-			  send_outstanding_bcast_packet);
+			  batadv_send_outstanding_bcast_packet);
 	queue_delayed_work(batadv_event_workqueue, &forw_packet->delayed_work,
 			   send_time);
 }
@@ -171,7 +171,7 @@ int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
 
-	_add_bcast_packet_to_list(bat_priv, forw_packet, delay);
+	_batadv_add_bcast_packet_to_list(bat_priv, forw_packet, delay);
 	return NETDEV_TX_OK;
 
 packet_free:
@@ -184,7 +184,7 @@ out:
 	return NETDEV_TX_BUSY;
 }
 
-static void send_outstanding_bcast_packet(struct work_struct *work)
+static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 {
 	struct hard_iface *hard_iface;
 	struct delayed_work *delayed_work =
@@ -220,13 +220,13 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 
 	/* if we still have some more bcasts to send */
 	if (forw_packet->num_packets < 3) {
-		_add_bcast_packet_to_list(bat_priv, forw_packet,
-					  msecs_to_jiffies(5));
+		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
+						 msecs_to_jiffies(5));
 		return;
 	}
 
 out:
-	forw_packet_free(forw_packet);
+	batadv_forw_packet_free(forw_packet);
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
@@ -260,7 +260,7 @@ out:
 	if (!forw_packet->own)
 		atomic_inc(&bat_priv->batman_queue_left);
 
-	forw_packet_free(forw_packet);
+	batadv_forw_packet_free(forw_packet);
 }
 
 void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
@@ -292,7 +292,7 @@ void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
 
 		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
-		/* send_outstanding_bcast_packet() will lock the list to
+		/* batadv_send_outstanding_bcast_packet() will lock the list to
 		 * delete the item from the list
 		 */
 		pending = cancel_delayed_work_sync(&forw_packet->delayed_work);
@@ -300,7 +300,7 @@ void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			forw_packet_free(forw_packet);
+			batadv_forw_packet_free(forw_packet);
 		}
 	}
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
@@ -327,7 +327,7 @@ void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			forw_packet_free(forw_packet);
+			batadv_forw_packet_free(forw_packet);
 		}
 	}
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
-- 
1.7.9.4

