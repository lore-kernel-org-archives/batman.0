Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 11 May 2011 20:59:06 +0200
Message-Id: <1305140346-10563-1-git-send-email-sven@narfation.org>
In-Reply-To: <1305117877-31345-1-git-send-email-sven@narfation.org>
References: <1305117877-31345-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC PATCHv2] batman-adv: Add missing
	hardif_free_ref in forw_packet_free
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

add_bcast_packet_to_list increases the refcount for if_incoming but the
reference count is never decreased. The reference count must be
increased for all kinds of forwarded packets which have the primary
interface stored and forw_packet_free must decrease them. Also
purge_outstanding_packets has to invoke forw_packet_free when a work
item was really cancelled.

This was a regression introduced by
89079aec4c0c2c60a3a2561afcce62538cebd71d.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
I will leave the hard work to someone else (cleanup, fixing commit
message, ...)

 aggregation.c |   14 +++++++++++---
 send.c        |   10 +++++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 9b94590..a8c3203 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -23,6 +23,7 @@
 #include "aggregation.h"
 #include "send.h"
 #include "routing.h"
+#include "hard-interface.h"
 
 /* calculate the size of the tt information for a given packet */
 static int tt_len(struct batman_packet *batman_packet)
@@ -105,12 +106,15 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 	struct forw_packet *forw_packet_aggr;
 	unsigned char *skb_buff;
 
+	if (!atomic_inc_not_zero(&if_incoming->refcount))
+		return;
+
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"batman packet queue full\n");
-			return;
+			goto out;
 		}
 	}
 
@@ -118,7 +122,7 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 	if (!forw_packet_aggr) {
 		if (!own_packet)
 			atomic_inc(&bat_priv->batman_queue_left);
-		return;
+		goto out;
 	}
 
 	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
@@ -133,7 +137,7 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 		if (!own_packet)
 			atomic_inc(&bat_priv->batman_queue_left);
 		kfree(forw_packet_aggr);
-		return;
+		goto out;
 	}
 	skb_reserve(forw_packet_aggr->skb, sizeof(struct ethhdr));
 
@@ -164,6 +168,10 @@ static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 	queue_delayed_work(bat_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
+
+	return;
+out:
+	hardif_free_ref(if_incoming);
 }
 
 /* aggregate a new packet into the existing aggregation */
diff --git a/send.c b/send.c
index f30d0c6..76f70c7 100644
--- a/send.c
+++ b/send.c
@@ -377,6 +377,8 @@ static void forw_packet_free(struct forw_packet *forw_packet)
 {
 	if (forw_packet->skb)
 		kfree_skb(forw_packet->skb);
+	if (forw_packet->if_incoming)
+		hardif_free_ref(forw_packet->if_incoming);
 	kfree(forw_packet);
 }
 
@@ -539,6 +541,7 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 {
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
+	bool pending;
 
 	if (hard_iface)
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -591,8 +594,13 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 		 * send_outstanding_bat_packet() will lock the list to
 		 * delete the item from the list
 		 */
-		cancel_delayed_work_sync(&forw_packet->delayed_work);
+		pending = cancel_delayed_work_sync(&forw_packet->delayed_work);
 		spin_lock_bh(&bat_priv->forw_bat_list_lock);
+
+		if (pending) {
+			hlist_del(&forw_packet->list);
+			forw_packet_free(forw_packet);
+		}
 	}
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 }
-- 
1.7.5.1

