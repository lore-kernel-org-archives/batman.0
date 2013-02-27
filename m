Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 27 Feb 2013 10:58:16 +0100
Message-Id: <1361959096-30522-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1361959096-30522-1-git-send-email-linus.luessing@web.de>
References: <1361959096-30522-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix another,
	potential broadcast+ogm purging race condition
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

We need to perform the addition of to be forwarded packets into our ogm
and broadcast queues and starting of the forward packet timer in one
atomic step. Otherwise we might potentially get a segmentation fault
when trying to start the timer of a forw_packet because the queue
purging routines might have freed the forw_packet already within the
short opportunity between the queue list addition and the
queue_delayed_work() call.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_iv_ogm.c |   12 ++++++------
 send.c       |    8 ++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7654b76..ee0b11f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -440,17 +440,17 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
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
 
 	return;
 out:
diff --git a/send.c b/send.c
index f93476b..4bd0c00 100644
--- a/send.c
+++ b/send.c
@@ -152,16 +152,12 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet,
 				 unsigned long send_time)
 {
-	INIT_HLIST_NODE(&forw_packet->list);
-
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

