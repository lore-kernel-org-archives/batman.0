Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 23 Mar 2013 16:28:01 +0100
Message-Id: <1364052481-10915-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: make the routing API more generic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The current routing API exports bat_ogm_emit() and
bat_ogm_schedule() which are strictly related to the way
B.A.T.M.A.N. IV was implemented. Moreover they are invoked
like "callbacks" and not like real APIs.

Implementing a new algorithm which behaves differently using
this schema is difficult or probably impossible at all.

Remove bat_ogm_emit() and bat_ogm_schedule(), which can be
directly handled inside the routing code and add
bat_iface_activate() which is invoked when the interface is
ready to send packets. This new function is used by the
routing code to start any sending mechanism or periodic
work

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c     | 47 +++++++++++++++++++++++++++++++++++++++++++----
 hard-interface.c | 10 +++++++---
 main.c           |  3 +--
 send.c           | 56 +-------------------------------------------------------
 send.h           |  1 +
 types.h          |  7 +++----
 6 files changed, 56 insertions(+), 68 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 071f288..5d6cc79 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -376,6 +376,8 @@ out:
 	return res;
 }
 
+static void batadv_iv_ogm_send_outstanding(struct work_struct *work);
+
 /* create a new aggregated packet and add this packet to it */
 static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					int packet_len, unsigned long send_time,
@@ -447,7 +449,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
-			  batadv_send_outstanding_bat_ogm_packet);
+			  batadv_iv_ogm_send_outstanding);
 	queue_delayed_work(batadv_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
@@ -601,6 +603,9 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	uint32_t seqno;
 	uint8_t bandwidth;
 
+	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+		return;
+
 	vis_server = atomic_read(&bat_priv->vis_mode);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
@@ -643,6 +648,40 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 		batadv_hardif_free_ref(primary_if);
 }
 
+static void batadv_iv_ogm_send_outstanding(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_forw_packet *forw_packet;
+	struct batadv_priv *bat_priv;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
+				   delayed_work);
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	hlist_del(&forw_packet->list);
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+		goto out;
+
+	batadv_iv_ogm_emit(forw_packet);
+
+	/* we have to have at least one packet in the queue
+	 * to determine the queues wake up time unless we are
+	 * shutting down
+	 */
+	if (forw_packet->own)
+		batadv_iv_ogm_schedule(forw_packet->if_incoming);
+
+out:
+	/* don't count own packet */
+	if (!forw_packet->own)
+		atomic_inc(&bat_priv->batman_queue_left);
+
+	batadv_forw_packet_free(forw_packet);
+}
+
 static void
 batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
@@ -1280,7 +1319,8 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	/* did we receive a B.A.T.M.A.N. IV OGM packet on an interface
 	 * that does not have B.A.T.M.A.N. IV enabled ?
 	 */
-	if (bat_priv->bat_algo_ops->bat_ogm_emit != batadv_iv_ogm_emit)
+	if (bat_priv->bat_algo_ops->bat_iface_activate !=
+	    batadv_iv_ogm_schedule)
 		return NET_RX_DROP;
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_RX);
@@ -1317,8 +1357,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_iface_disable = batadv_iv_ogm_iface_disable,
 	.bat_iface_update_mac = batadv_iv_ogm_iface_update_mac,
 	.bat_primary_iface_set = batadv_iv_ogm_primary_iface_set,
-	.bat_ogm_schedule = batadv_iv_ogm_schedule,
-	.bat_ogm_emit = batadv_iv_ogm_emit,
+	.bat_iface_activate = batadv_iv_ogm_schedule,
 };
 
 int __init batadv_iv_init(void)
diff --git a/hard-interface.c b/hard-interface.c
index d55213c..8e57693 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -339,6 +339,13 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	batadv_update_min_mtu(hard_iface->soft_iface);
 
+	/* the interface gets activated here to avoid race conditions when the
+	 * originator mac has not properly set yet
+	 */
+	hard_iface->if_status = BATADV_IF_ACTIVE;
+
+	bat_priv->bat_algo_ops->bat_iface_activate(hard_iface);
+
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
@@ -453,9 +460,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			   "Not using interface %s (retrying later): interface not active\n",
 			   hard_iface->net_dev->name);
 
-	/* begin scheduling originator messages on that interface */
-	batadv_schedule_bat_ogm(hard_iface);
-
 out:
 	return 0;
 
diff --git a/main.c b/main.c
index 62b1f89..31f71b6 100644
--- a/main.c
+++ b/main.c
@@ -383,8 +383,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_iface_disable ||
 	    !bat_algo_ops->bat_iface_update_mac ||
 	    !bat_algo_ops->bat_primary_iface_set ||
-	    !bat_algo_ops->bat_ogm_schedule ||
-	    !bat_algo_ops->bat_ogm_emit) {
+	    !bat_algo_ops->bat_iface_activate) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/send.c b/send.c
index eb16b04..0642756 100644
--- a/send.c
+++ b/send.c
@@ -118,27 +118,7 @@ bool batadv_send_skb_to_orig(struct sk_buff *skb,
 	return true;
 }
 
-void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
-{
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-
-	if ((hard_iface->if_status == BATADV_IF_NOT_IN_USE) ||
-	    (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED))
-		return;
-
-	/* the interface gets activated here to avoid race conditions between
-	 * the moment of activating the interface in
-	 * hardif_activate_interface() where the originator mac is set and
-	 * outdated packets (especially uninitialized mac addresses) in the
-	 * packet queue
-	 */
-	if (hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED)
-		hard_iface->if_status = BATADV_IF_ACTIVE;
-
-	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface);
-}
-
-static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
+void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
 	if (forw_packet->skb)
 		kfree_skb(forw_packet->skb);
@@ -285,40 +265,6 @@ out:
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
-void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
-{
-	struct delayed_work *delayed_work;
-	struct batadv_forw_packet *forw_packet;
-	struct batadv_priv *bat_priv;
-
-	delayed_work = container_of(work, struct delayed_work, work);
-	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
-				   delayed_work);
-	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
-	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	hlist_del(&forw_packet->list);
-	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
-
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
-		goto out;
-
-	bat_priv->bat_algo_ops->bat_ogm_emit(forw_packet);
-
-	/* we have to have at least one packet in the queue
-	 * to determine the queues wake up time unless we are
-	 * shutting down
-	 */
-	if (forw_packet->own)
-		batadv_schedule_bat_ogm(forw_packet->if_incoming);
-
-out:
-	/* don't count own packet */
-	if (!forw_packet->own)
-		atomic_inc(&bat_priv->batman_queue_left);
-
-	batadv_forw_packet_free(forw_packet);
-}
-
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface)
diff --git a/send.h b/send.h
index 38e662f..0a966e6 100644
--- a/send.h
+++ b/send.h
@@ -34,5 +34,6 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work);
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface);
+void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet);
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/types.h b/types.h
index 5f542bd..8466a85 100644
--- a/types.h
+++ b/types.h
@@ -946,8 +946,8 @@ struct batadv_vis_if_list_entry {
  * @bat_iface_update_mac: (re-)init mac addresses of the protocol information
  *  belonging to this hard-interface
  * @bat_primary_iface_set: called when primary interface is selected / changed
- * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
- * @bat_ogm_emit: send scheduled OGM
+ * @bat_iface_activate: called when the interface is activated and can be used
+ *  for transmissions
  */
 struct batadv_algo_ops {
 	struct hlist_node list;
@@ -956,8 +956,7 @@ struct batadv_algo_ops {
 	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
 	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);
 	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
-	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
-	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
+	void (*bat_iface_activate)(struct batadv_hard_iface *hard_iface);
 };
 
 /**
-- 
1.8.1.5

