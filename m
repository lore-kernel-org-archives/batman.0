Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 18 Mar 2013 06:09:55 +0100
Message-Id: <1363583397-4800-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1363583397-4800-1-git-send-email-linus.luessing@web.de>
References: <201303071427.27817.lindner_marek@yahoo.de>
 <1363583397-4800-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Fix a potential bcast/ogm
	queue purging race condition (1)
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

- Perform queue list addition and work queueing atomically.

Otherwise we might potentially miss waiting for the re-armed task on
interface removal, leading to freeing packets with the re-armed tasks
trying to process them afterwards, therefore causing segmentation
faults.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_iv_ogm.c |   12 ++++++------
 send.c       |    6 ++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 77568ba..de3a4c1 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -422,17 +422,17 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (direct_link)
 		forw_packet_aggr->direct_link_flags |= 1;
 
-	/* add new packet to packet list */
-	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	hlist_add_head(&forw_packet_aggr->list, &bat_priv->forw_bat_list);
-	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
-
-	/* start timer for this packet */
+	/* initialize job for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
 			  batadv_send_outstanding_bat_ogm_packet);
+
+	/* add new packet to packet list and start its timer */
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	hlist_add_head(&forw_packet_aggr->list, &bat_priv->forw_bat_list);
 	queue_delayed_work(batadv_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 }
 
 /* aggregate a new packet into the existing ogm packet */
diff --git a/send.c b/send.c
index c151982..1ddfae7 100644
--- a/send.c
+++ b/send.c
@@ -217,14 +217,12 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet,
 				 unsigned long send_time)
 {
-	/* add new packet to packet list */
+	/* add new packet to packet list and start its timer */
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
-	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-
-	/* start timer for this packet */
 	queue_delayed_work(batadv_event_workqueue, &forw_packet->delayed_work,
 			   send_time);
+	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 }
 
 /* add a broadcast packet to the queue and setup timers. broadcast packets
-- 
1.7.10.4

