Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:23 +0200
Message-Id: <1283644718-653-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/21] Staging: batman-adv: move queue
	counters into bat_priv
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

to support multiple mesh devices later, we need to move global variables
like the queues into corresponding private structs bat_priv of the soft
devices.

Note that this patch still has a lot of FIXMEs and depends on the global
soft_device variable. This should be resolved later, e.g. by referencing
the parent soft device in batman_if.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c |    6 +++---
 drivers/staging/batman-adv/bat_sysfs.c   |    2 ++
 drivers/staging/batman-adv/main.c        |    6 ------
 drivers/staging/batman-adv/main.h        |    2 --
 drivers/staging/batman-adv/send.c        |   12 ++++++++----
 drivers/staging/batman-adv/types.h       |    2 ++
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index 9862d16..d738b7a 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -111,7 +111,7 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 
 	/* own packet should always be scheduled */
 	if (!own_packet) {
-		if (!atomic_dec_not_zero(&batman_queue_left)) {
+		if (!atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"batman packet queue full\n");
 			return;
@@ -121,7 +121,7 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 	forw_packet_aggr = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
 	if (!forw_packet_aggr) {
 		if (!own_packet)
-			atomic_inc(&batman_queue_left);
+			atomic_inc(&bat_priv->batman_queue_left);
 		return;
 	}
 
@@ -129,7 +129,7 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 						GFP_ATOMIC);
 	if (!forw_packet_aggr->packet_buff) {
 		if (!own_packet)
-			atomic_inc(&batman_queue_left);
+			atomic_inc(&bat_priv->batman_queue_left);
 		kfree(forw_packet_aggr);
 		return;
 	}
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 05ca15a..d49adde 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -311,6 +311,8 @@ int sysfs_add_meshif(struct net_device *dev)
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->log_level, 0);
+	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
+	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index ef7c20a..c0a3373 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -42,9 +42,6 @@ DEFINE_SPINLOCK(orig_hash_lock);
 DEFINE_SPINLOCK(forw_bat_list_lock);
 DEFINE_SPINLOCK(forw_bcast_list_lock);
 
-atomic_t bcast_queue_left;
-atomic_t batman_queue_left;
-
 int16_t num_hna;
 
 struct net_device *soft_device;
@@ -69,9 +66,6 @@ static int __init batman_init(void)
 
 	atomic_set(&module_state, MODULE_INACTIVE);
 
-	atomic_set(&bcast_queue_left, BCAST_QUEUE_LEN);
-	atomic_set(&batman_queue_left, BATMAN_QUEUE_LEN);
-
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
 	bat_event_workqueue = create_singlethread_workqueue("bat_events");
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 9b30eef..2d364e0 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -136,8 +136,6 @@ extern spinlock_t orig_hash_lock;
 extern spinlock_t forw_bat_list_lock;
 extern spinlock_t forw_bcast_list_lock;
 
-extern atomic_t bcast_queue_left;
-extern atomic_t batman_queue_left;
 extern int16_t num_hna;
 
 extern struct net_device *soft_device;
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index da3c82e..e874cae 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -404,7 +404,7 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 	/* FIXME: each batman_if will be attached to a softif */
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
-	if (!atomic_dec_not_zero(&bcast_queue_left)) {
+	if (!atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
 		bat_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
 		goto out;
 	}
@@ -436,7 +436,7 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 packet_free:
 	kfree(forw_packet);
 out_and_inc:
-	atomic_inc(&bcast_queue_left);
+	atomic_inc(&bat_priv->bcast_queue_left);
 out:
 	return NETDEV_TX_BUSY;
 }
@@ -450,6 +450,8 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
 	struct sk_buff *skb1;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -479,7 +481,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 
 out:
 	forw_packet_free(forw_packet);
-	atomic_inc(&bcast_queue_left);
+	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
 void send_outstanding_bat_packet(struct work_struct *work)
@@ -489,6 +491,8 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	struct forw_packet *forw_packet =
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	spin_lock_irqsave(&forw_bat_list_lock, flags);
 	hlist_del(&forw_packet->list);
@@ -510,7 +514,7 @@ void send_outstanding_bat_packet(struct work_struct *work)
 out:
 	/* don't count own packet */
 	if (!forw_packet->own)
-		atomic_inc(&batman_queue_left);
+		atomic_inc(&bat_priv->batman_queue_left);
 
 	forw_packet_free(forw_packet);
 }
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 9aa9d36..67bf4db 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -113,6 +113,8 @@ struct bat_priv {
 	atomic_t vis_mode;
 	atomic_t orig_interval;
 	atomic_t log_level;
+	atomic_t bcast_queue_left;
+	atomic_t batman_queue_left;
 	char num_ifaces;
 	struct debug_log *debug_log;
 	struct batman_if *primary_if;
-- 
1.7.1

