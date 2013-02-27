Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 27 Feb 2013 10:58:15 +0100
Message-Id: <1361959096-30522-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix broadcast+ogm queue
	purging race condition
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
To: b.a.t.m.a.n@lists.open-mesh.net

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
Fixes issue #168

 send.c  |  117 ++++++++++++++++++++++++++++++++++++++-------------------------
 types.h |    1 +
 2 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/send.c b/send.c
index 0a0bb45..f93476b 100644
--- a/send.c
+++ b/send.c
@@ -245,6 +245,10 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	bat_priv = netdev_priv(soft_iface);
 
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
+	if (hlist_unhashed(&forw_packet->list)) {
+		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
+		return;
+	}
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
@@ -293,6 +297,10 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	if (hlist_unhashed(&forw_packet->list)) {
+		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+		return;
+	}
 	hlist_del(&forw_packet->list);
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
@@ -316,13 +324,68 @@ out:
 	batadv_forw_packet_free(forw_packet);
 }
 
+/**
+ * batadv_cancel_packets - Cancels a list of forward packets
+ * @forw_list:		The to be canceled forward packets
+ * @canceled_list:	The backup list.
+ *
+ * This canceles any scheduled forwarding packet tasks in the provided
+ * forw_list. The packets are being moved from the forw_list to the
+ * canceled_list afterwards to unhash the forward packet list pointer,
+ * allowing any already running task to notice the cancelation.
+ */
+static void batadv_cancel_packets(struct hlist_head *forw_list,
+				  struct hlist_head *canceled_list,
+				  const struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_forw_packet *forw_packet;
+	struct hlist_node *tmp_node, *safe_tmp_node;
+
+	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
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
+	struct hlist_node *tmp_node, *safe_tmp_node;
+
+	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node, head,
+				  canceled_list) {
+		cancel_delayed_work_sync(&forw_packet->delayed_work);
+
+		hlist_del(&forw_packet->canceled_list);
+		batadv_forw_packet_free(forw_packet);
+	}
+}
+
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_forw_packet *forw_packet;
-	struct hlist_node *tmp_node, *safe_tmp_node;
-	bool pending;
+	struct hlist_head head;
+
+	INIT_HLIST_HEAD(&head);
 
 	if (hard_iface)
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -334,53 +397,13 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 	/* free bcast list */
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
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
-	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
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
index aba8364..f62a35f 100644
--- a/types.h
+++ b/types.h
@@ -853,6 +853,7 @@ struct batadv_skb_cb {
  */
 struct batadv_forw_packet {
 	struct hlist_node list;
+	struct hlist_node canceled_list;
 	unsigned long send_time;
 	uint8_t own;
 	struct sk_buff *skb;
-- 
1.7.10.4

