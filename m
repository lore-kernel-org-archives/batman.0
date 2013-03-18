Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 18 Mar 2013 06:09:56 +0100
Message-Id: <1363583397-4800-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1363583397-4800-1-git-send-email-linus.luessing@web.de>
References: <201303071427.27817.lindner_marek@yahoo.de>
 <1363583397-4800-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Fix a potential bcast/ogm
	qeueue purging race condition (2)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

- Avoid rearmed bcast packet being missed by cancel_delayed_work_sync().

When a scheduled broadcast packet sending work executes and removes
itself from the broadcast queue, it becomes invisible for the purging
methods until it re-arms.

This means a to be re-armed broadcast work might slip through a
cancel_delayed_work_sync() between the removal from and readdition to
the broadcast queue.

To avoid this we perform the removal and readdition in one atomic step.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 send.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/send.c b/send.c
index 1ddfae7..34c54e9 100644
--- a/send.c
+++ b/send.c
@@ -217,12 +217,9 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet,
 				 unsigned long send_time)
 {
-	/* add new packet to packet list and start its timer */
-	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
 	queue_delayed_work(batadv_event_workqueue, &forw_packet->delayed_work,
 			   send_time);
-	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 }
 
 /* add a broadcast packet to the queue and setup timers. broadcast packets
@@ -272,7 +269,10 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  batadv_send_outstanding_bcast_packet);
 
+	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	_batadv_add_bcast_packet_to_list(bat_priv, forw_packet, delay);
+	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
+
 	return NETDEV_TX_OK;
 
 packet_free:
@@ -296,10 +296,6 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
 
-	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-	hlist_del(&forw_packet->list);
-	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
@@ -327,12 +323,21 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 	/* if we still have some more bcasts to send */
 	if (forw_packet->num_packets < BATADV_NUM_BCASTS_MAX) {
+		spin_lock_bh(&bat_priv->forw_bcast_list_lock);
+		hlist_del(&forw_packet->list);
+
 		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
 						 msecs_to_jiffies(5));
+		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
+
 		return;
 	}
 
 out:
+	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
+	hlist_del(&forw_packet->list);
+	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
+
 	batadv_forw_packet_free(forw_packet);
 }
 
-- 
1.7.10.4

