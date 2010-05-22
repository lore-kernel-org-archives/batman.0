Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:48:44 +0200
Message-Id: <1274543327-2258-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005221748.17663.sven.eckelmann@gmx.de>
References: <201005221748.17663.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] Staging: batman-adv: fix rogue packets
	on shutdown
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
To: gregkh@suse.de
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

On module shutdown batman-adv would purge the internal packet
queue by sending all remaining packets which could confuse
other nodes. Now, the packets are silently discarded.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/send.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index d8536e2..ac69ed8 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -440,6 +440,9 @@ void send_outstanding_bcast_packet(struct work_struct *work)
 	hlist_del(&forw_packet->list);
 	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
 
+	if (atomic_read(&module_state) == MODULE_DEACTIVATING)
+		goto out;
+
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
@@ -453,15 +456,15 @@ void send_outstanding_bcast_packet(struct work_struct *work)
 
 	forw_packet->num_packets++;
 
-	/* if we still have some more bcasts to send and we are not shutting
-	 * down */
-	if ((forw_packet->num_packets < 3) &&
-	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
+	/* if we still have some more bcasts to send */
+	if (forw_packet->num_packets < 3) {
 		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
-	else {
-		forw_packet_free(forw_packet);
-		atomic_inc(&bcast_queue_left);
+		return;
 	}
+
+out:
+	forw_packet_free(forw_packet);
+	atomic_inc(&bcast_queue_left);
 }
 
 void send_outstanding_bat_packet(struct work_struct *work)
@@ -476,6 +479,9 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	hlist_del(&forw_packet->list);
 	spin_unlock_irqrestore(&forw_bat_list_lock, flags);
 
+	if (atomic_read(&module_state) == MODULE_DEACTIVATING)
+		goto out;
+
 	send_packet(forw_packet);
 
 	/**
@@ -483,10 +489,10 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	 * to determine the queues wake up time unless we are
 	 * shutting down
 	 */
-	if ((forw_packet->own) &&
-	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
+	if (forw_packet->own)
 		schedule_own_packet(forw_packet->if_incoming);
 
+out:
 	/* don't count own packet */
 	if (!forw_packet->own)
 		atomic_inc(&batman_queue_left);
-- 
1.7.1

