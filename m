Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:41 +0100
Message-Id: <1262428252-26439-6-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-5-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
	<1262428252-26439-5-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 06/17] Staging: batman-adv: Use
	forw_bcast_list_lock always with disabled interrupts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Sven Eckelmann <sven.eckelmann@gmx.de>

forw_bcast_list_lock is spin_locked in both process and softirq context.
SoftIRQ calls the spinlock with disabled IRQ and normal process context
with enabled IRQs.

When process context is inside an spin_locked area protected by
forw_bcast_list_lock and gets interrupted by an IRQ, it could happen
that something tries to lock forw_bcast_list_lock again in SoftIRQ
context. It cannot proceed further since the lock is already taken
somewhere else, but no reschedule will happen inside the SoftIRQ
context. This leads to an complete kernel hang without any chance of
resurrection.

All functions called in process context must disable IRQs when they try
to get get that lock to to prevent any reschedule due to IRQs.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Acked-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/send.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index fc4953f..49b1534 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -338,12 +338,13 @@ static void forw_packet_free(struct forw_packet *forw_packet)
 static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
 				      unsigned long send_time)
 {
+	unsigned long flags;
 	INIT_HLIST_NODE(&forw_packet->list);
 
 	/* add new packet to packet list */
-	spin_lock(&forw_bcast_list_lock);
+	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_add_head(&forw_packet->list, &forw_bcast_list);
-	spin_unlock(&forw_bcast_list_lock);
+	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
@@ -382,10 +383,11 @@ void send_outstanding_bcast_packet(struct work_struct *work)
 		container_of(work, struct delayed_work, work);
 	struct forw_packet *forw_packet =
 		container_of(delayed_work, struct forw_packet, delayed_work);
+	unsigned long flags;
 
-	spin_lock(&forw_bcast_list_lock);
+	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
-	spin_unlock(&forw_bcast_list_lock);
+	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
 
 	/* rebroadcast packet */
 	rcu_read_lock();
@@ -436,24 +438,25 @@ void purge_outstanding_packets(void)
 {
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
+	unsigned long flags;
 
 	bat_dbg(DBG_BATMAN, "purge_outstanding_packets()\n");
 
 	/* free bcast list */
-	spin_lock(&forw_bcast_list_lock);
+	spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
 				  &forw_bcast_list, list) {
 
-		spin_unlock(&forw_bcast_list_lock);
+		spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
 
 		/**
 		 * send_outstanding_bcast_packet() will lock the list to
 		 * delete the item from the list
 		 */
 		cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock(&forw_bcast_list_lock);
+		spin_lock_irqsave(&forw_bcast_list_lock, flags);
 	}
-	spin_unlock(&forw_bcast_list_lock);
+	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
 
 	/* free batman packet list */
 	spin_lock(&forw_bat_list_lock);
-- 
1.6.5.7

