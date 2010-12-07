Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue,  7 Dec 2010 15:39:38 +0100
Message-Id: <1291732778-27441-11-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: Use local tq values
	determined by NDP on OGMs
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

With this commit not the local transmit quality values determined
by the OGMs themselves are applied on received OGMs, but the local
transmit quality detemined by NDP instead. Usually the link quality
measurements of NDP are more up-to-date than the one of the OGMs, as NDP
is using a more frequent interval because NDP's packets are not being
flooded through the whole mesh.
---
 routing.c |   53 ++++++++++++++++++++++-------------------------------
 1 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/routing.c b/routing.c
index 1972bb8..8830129 100644
--- a/routing.c
+++ b/routing.c
@@ -136,7 +136,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
-	unsigned char total_count;
+	uint8_t local_tq = 0;
 
 	if (orig_node == orig_neigh_node) {
 		list_for_each_entry(tmp_neigh_node,
@@ -180,25 +180,19 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			return 0;
 	}
 
-	orig_node->last_valid = jiffies;
+	spin_lock_bh(&if_incoming->neigh_list_lock);
+	list_for_each_entry(neigh_node, &if_incoming->neigh_list, list) {
+		if (!compare_orig(neigh_node->addr, orig_neigh_node->orig))
+			continue;
 
-	/* pay attention to not get a value bigger than 100 % */
-	total_count = (orig_neigh_node->bcast_own_sum[if_incoming->if_num] >
-		       neigh_node->real_packet_count ?
-		       neigh_node->real_packet_count :
-		       orig_neigh_node->bcast_own_sum[if_incoming->if_num]);
+		orig_node->last_valid = jiffies;
+		local_tq = neigh_node->tq_avg;
+		break;
+	}
+	spin_unlock_bh(&if_incoming->neigh_list_lock);
 
-	/* if we have too few packets (too less data) we set tq_own to zero */
-	/* if we receive too few packets it is not considered bidirectional */
-	if ((total_count < TQ_LOCAL_BIDRECT_SEND_MINIMUM) ||
-	    (neigh_node->real_packet_count < TQ_LOCAL_BIDRECT_RECV_MINIMUM))
-		orig_neigh_node->tq_own = 0;
-	else
-		/* neigh_node->real_packet_count is never zero as we
-		 * only purge old information when getting new
-		 * information */
-		orig_neigh_node->tq_own = (TQ_MAX_VALUE * total_count) /
-			neigh_node->real_packet_count;
+	if (local_tq == 0)
+		return 0;
 
 	/*
 	 * 1 - ((1-x) ** 3), normalized to TQ_MAX_VALUE this does
@@ -209,25 +203,22 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	orig_neigh_node->tq_asym_penalty =
 		TQ_MAX_VALUE -
 		(TQ_MAX_VALUE *
-		 (TQ_LOCAL_WINDOW_SIZE - neigh_node->real_packet_count) *
-		 (TQ_LOCAL_WINDOW_SIZE - neigh_node->real_packet_count) *
-		 (TQ_LOCAL_WINDOW_SIZE - neigh_node->real_packet_count)) /
-		(TQ_LOCAL_WINDOW_SIZE *
-		 TQ_LOCAL_WINDOW_SIZE *
-		 TQ_LOCAL_WINDOW_SIZE);
+		 (TQ_MAX_VALUE - local_tq) *
+		 (TQ_MAX_VALUE - local_tq) *
+		 (TQ_MAX_VALUE - local_tq)) /
+		(TQ_MAX_VALUE *
+		 TQ_MAX_VALUE *
+		 TQ_MAX_VALUE);
 
 	batman_packet_ogm->tq = ((batman_packet_ogm->tq *
-			      orig_neigh_node->tq_own *
 			      orig_neigh_node->tq_asym_penalty) /
-			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
+			      TQ_MAX_VALUE);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"bidirectional: "
-		"orig = %-15pM neigh = %-15pM => own_bcast = %2i, "
-		"real recv = %2i, local tq: %3i, asym_penalty: %3i, "
-		"total tq: %3i\n",
-		orig_node->orig, orig_neigh_node->orig, total_count,
-		neigh_node->real_packet_count, orig_neigh_node->tq_own,
+		"orig = %-15pM neigh = %-15pM => real recv = %2i, "
+	        "local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
+		orig_node->orig, orig_neigh_node->orig, local_tq,
 		orig_neigh_node->tq_asym_penalty, batman_packet_ogm->tq);
 
 	/* if link has the minimum required transmission quality
-- 
1.7.1

