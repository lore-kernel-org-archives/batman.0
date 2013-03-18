Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 18 Mar 2013 06:09:57 +0100
Message-Id: <1363583397-4800-5-git-send-email-linus.luessing@web.de>
In-Reply-To: <1363583397-4800-1-git-send-email-linus.luessing@web.de>
References: <201303071427.27817.lindner_marek@yahoo.de>
 <1363583397-4800-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Fix a potential bcast/ogm
	queue purging race condition (3)
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

- Do not temporarily give up the spin_lock on bcast/ogm queue purging.

So far on purging broadcast and ogm queues we temporarily give up the
spin lock of these queues to be able to cancel any scheduled forwarding
work. However this is unsafe and can lead to a general protection error
in batadv_purge_outstanding_packets().

With this patch we split the queue purging into two steps: First
removing forward packets from those queues and signaling the
cancelation. Secondly, we are actively canceling any scheduled
forwarding, wait for any running forwarding to finish and only free a
forw_packet afterwards.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 send.c  |  140 ++++++++++++++++++++++++++++++++++++++++++---------------------
 types.h |    1 +
 2 files changed, 94 insertions(+), 47 deletions(-)

diff --git a/send.c b/send.c
index 34c54e9..3bb0b1a 100644
--- a/send.c
+++ b/send.c
@@ -324,6 +324,10 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	/* if we still have some more bcasts to send */
 	if (forw_packet->num_packets < BATADV_NUM_BCASTS_MAX) {
 		spin_lock_bh(&bat_priv->forw_bcast_list_lock);
+		if (hlist_unhashed(&forw_packet->list)) {
+			spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
+			return;
+		}
 		hlist_del(&forw_packet->list);
 
 		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
@@ -335,6 +339,10 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 out:
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
+	if (hlist_unhashed(&forw_packet->list)) {
+		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
+		return;
+	}
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
@@ -352,6 +360,10 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	if (hlist_unhashed(&forw_packet->list)) {
+		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+		return;
+	}
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
@@ -371,13 +383,87 @@ out:
 	batadv_forw_packet_free(forw_packet);
 }
 
+/**
+ * batadv_cancel_packets - Cancels a list of forward packets
+ * @forw_list:		The to be canceled forward packets
+ * @canceled_list:	The backup list
+ * @hard_iface:		The interface to cancel forward packets for
+ *
+ * This cancels any scheduled forwarding packet tasks in the provided
+ * forw_list for the given hard_iface. If hard_iface is NULL forwarding packets
+ * on all hard interfaces will be canceled.
+ *
+ * The packets are being moved from the forw_list to the canceled_list
+ * and the forward packet list pointer will be unhashed, allowing any already
+ * running task to notice the cancelation.
+ */
+static void batadv_cancel_packets(struct hlist_head *forw_list,
+				  struct hlist_head *canceled_list,
+				  const struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_forw_packet *forw_packet;
+	struct hlist_node *safe_tmp_node;
+
+	hlist_for_each_entry_safe(forw_packet, safe_tmp_node,
+				  forw_list, list) {
+		/* if purge_outstanding_packets() was called with an argument
+		 * we delete only packets belonging to the given interface
+		 */
+		if ((hard_iface) &&
+		    (forw_packet->if_incoming != hard_iface))
+			continue;
+
+		hlist_del_init(&forw_packet->list);
+		hlist_add_head(&forw_packet->canceled_list, canceled_list);
+	}
+}
+
+/**
+ * batadv_canceled_packets_free - Frees canceled forward packets
+ * @head:	A list of to be freed forw_packets
+ *
+ * This function canceles the scheduling of any packet in the provided list,
+ * waits for any possibly running packet forwarding thread to finish and
+ * finally, safely frees this forward packet.
+ *
+ * This function might sleep.
+ */
+static void batadv_canceled_packets_free(struct hlist_head *head)
+{
+	struct batadv_forw_packet *forw_packet;
+	struct hlist_node *safe_tmp_node;
+
+	hlist_for_each_entry_safe(forw_packet, safe_tmp_node, head,
+				  canceled_list) {
+		cancel_delayed_work_sync(&forw_packet->delayed_work);
+
+		hlist_del(&forw_packet->canceled_list);
+		batadv_forw_packet_free(forw_packet);
+	}
+}
+
+/**
+ * batadv_purge_outstanding_packets - Stops/purges scheduled bcast/ogm packets
+ * @bat_priv:	The mesh to cancel and purge bcast/ogm packets for
+ * @hard_iface:	The hard interface to cancel and purge bcast_ogm packets on
+ *
+ * This method cancels and purges any broadcast and ogm packet on the given
+ * hard_iface. If hard_iface is NULL, broadcast and ogm packets on all hard
+ * interfaces will be canceled and purged.
+ *
+ * Note that after this method bcast/ogm callbacks might still be running for
+ * a few instructions (use a flush_workqueue(batadv_event_workqueue) to
+ * wait for them to finish).
+ *
+ * This function might sleep.
+ */
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_forw_packet *forw_packet;
-	struct hlist_node *safe_tmp_node;
-	bool pending;
+	struct hlist_head head;
+
+	INIT_HLIST_HEAD(&head);
 
 	if (hard_iface)
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -389,53 +475,13 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 	/* free bcast list */
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-	hlist_for_each_entry_safe(forw_packet, safe_tmp_node,
-				  &bat_priv->forw_bcast_list, list) {
-		/* if purge_outstanding_packets() was called with an argument
-		 * we delete only packets belonging to the given interface
-		 */
-		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface))
-			continue;
-
-		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-
-		/* batadv_send_outstanding_bcast_packet() will lock the list to
-		 * delete the item from the list
-		 */
-		pending = cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-
-		if (pending) {
-			hlist_del(&forw_packet->list);
-			batadv_forw_packet_free(forw_packet);
-		}
-	}
+	batadv_cancel_packets(&bat_priv->forw_bcast_list, &head, hard_iface);
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
 	/* free batman packet list */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	hlist_for_each_entry_safe(forw_packet, safe_tmp_node,
-				  &bat_priv->forw_bat_list, list) {
-		/* if purge_outstanding_packets() was called with an argument
-		 * we delete only packets belonging to the given interface
-		 */
-		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface))
-			continue;
-
-		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
-
-		/* send_outstanding_bat_packet() will lock the list to
-		 * delete the item from the list
-		 */
-		pending = cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_bh(&bat_priv->forw_bat_list_lock);
-
-		if (pending) {
-			hlist_del(&forw_packet->list);
-			batadv_forw_packet_free(forw_packet);
-		}
-	}
+	batadv_cancel_packets(&bat_priv->forw_bat_list, &head, hard_iface);
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
+	batadv_canceled_packets_free(&head);
 }
diff --git a/types.h b/types.h
index 8c28142..d0d3c07 100644
--- a/types.h
+++ b/types.h
@@ -855,6 +855,7 @@ struct batadv_skb_cb {
  */
 struct batadv_forw_packet {
 	struct hlist_node list;
+	struct hlist_node canceled_list;
 	unsigned long send_time;
 	uint8_t own;
 	struct sk_buff *skb;
-- 
1.7.10.4

