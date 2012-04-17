Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 00:27:21 +0200
Message-Id: <1334701645-25862-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334701645-25862-1-git-send-email-ordex@autistici.org>
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: don't delay OGM information
	announcement
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

In the current implementation the OGM is built and filled at the moment it is
scheduled (1 originator interval before its sending). In this way, all the TT
changes happening between OGM(seqno=X) and OGM(seqno=X+1) will be attached to
OGM(seqno=X+2) (because when changes happened OGM(seqno=X+1) was already built).

The result of this strategy is that TT changes are not sent within the
very next OGM, but they are sent within the second OGM since they happened.
This mechanism will introduce a delay for table resync which could lead to
wrong state in case of multiple roamings.

This patch delays all the operations so that the OGM is filled and ultimated
just before being sent.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 send.c       |   75 ++--------------------------------------
 types.h      |    6 ++--
 3 files changed, 99 insertions(+), 90 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index ed743a4..377ee04 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -558,28 +558,97 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
 			     if_incoming, 0, bat_iv_ogm_fwd_send_time());
 }
 
-static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
-				int tt_num_changes)
+static void realloc_packet_buffer(struct hard_iface *hard_iface,
+				  int new_len)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	unsigned char *new_buff;
+
+	new_buff = kmalloc(new_len, GFP_ATOMIC);
+
+	/* keep old buffer if kmalloc should fail */
+	if (new_buff) {
+		memcpy(new_buff, hard_iface->packet_buff,
+		       BATMAN_OGM_HLEN);
+
+		kfree(hard_iface->packet_buff);
+		hard_iface->packet_buff = new_buff;
+		hard_iface->packet_len = new_len;
+	}
+}
+
+/* when calling this function (hard_iface == primary_if) has to be true */
+static int prepare_packet_buffer(struct bat_priv *bat_priv,
+				  struct hard_iface *hard_iface)
+{
+	int new_len;
+
+	new_len = BATMAN_OGM_HLEN +
+		  tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
+
+	/* if we have too many changes for one packet don't send any
+	 * and wait for the tt table request which will be fragmented */
+	if (new_len > hard_iface->soft_iface->mtu)
+		new_len = BATMAN_OGM_HLEN;
+
+	realloc_packet_buffer(hard_iface, new_len);
+
+	bat_priv->tt_crc = tt_local_crc(bat_priv);
+
+	/* reset the sending counter */
+	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
+
+	return tt_changes_fill_buffer(bat_priv,
+				      hard_iface->packet_buff + BATMAN_OGM_HLEN,
+				      hard_iface->packet_len - BATMAN_OGM_HLEN);
+}
+
+static int reset_packet_buffer(struct bat_priv *bat_priv,
+				struct hard_iface *hard_iface)
+{
+	realloc_packet_buffer(hard_iface, BATMAN_OGM_HLEN);
+	return 0;
+}
+
+static void bat_iv_fill_ogm(struct bat_priv *bat_priv,
+			    struct forw_packet *forw_packet)
+{
+	struct hard_iface *primary_if, *hard_iface;
 	struct batman_ogm_packet *batman_ogm_packet;
-	struct hard_iface *primary_if;
-	int vis_server;
+	int vis_server, tt_num_changes = -1;
 
-	vis_server = atomic_read(&bat_priv->vis_mode);
+	hard_iface = forw_packet->if_incoming;
 	primary_if = primary_if_get_selected(bat_priv);
-
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
 
+	if (forw_packet->own && forw_packet->if_incoming == primary_if) {
+		/* if at least one change happened */
+		if (atomic_read(&bat_priv->tt_local_changes) > 0) {
+			tt_commit_changes(bat_priv);
+			tt_num_changes = prepare_packet_buffer(bat_priv,
+							       hard_iface);
+		}
+
+		/* if the changes have been sent often enough */
+		if (!atomic_dec_not_zero(&bat_priv->tt_ogm_append_cnt))
+			tt_num_changes = reset_packet_buffer(bat_priv,
+							     hard_iface);
+
+		batman_ogm_packet =
+			(struct batman_ogm_packet *)hard_iface->packet_buff;
+
+		if (tt_num_changes >= 0)
+			batman_ogm_packet->tt_num_changes = tt_num_changes;
+		batman_ogm_packet->ttvn = atomic_read(&bat_priv->ttvn);
+		batman_ogm_packet->tt_crc = htons(bat_priv->tt_crc);
+	}
+
+	vis_server = atomic_read(&bat_priv->vis_mode);
+	primary_if = primary_if_get_selected(bat_priv);
+
 	/* change sequence number to network order */
 	batman_ogm_packet->seqno =
 			htonl((uint32_t)atomic_read(&hard_iface->seqno));
 
-	batman_ogm_packet->ttvn = atomic_read(&bat_priv->ttvn);
-	batman_ogm_packet->tt_crc = htons(bat_priv->tt_crc);
-	if (tt_num_changes >= 0)
-		batman_ogm_packet->tt_num_changes = tt_num_changes;
-
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
 		batman_ogm_packet->flags |= VIS_SERVER;
 	else
@@ -592,15 +661,23 @@ static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
 	else
 		batman_ogm_packet->gw_flags = NO_FLAGS;
 
+	if (primary_if)
+		hardif_free_ref(primary_if);
+}
+
+static void bat_iv_ogm_schedule(struct hard_iface *hard_iface)
+{
+	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batman_ogm_packet *batman_ogm_packet;
+
+	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
+
 	atomic_inc(&hard_iface->seqno);
 
 	slide_own_bcast_window(hard_iface);
 	bat_iv_ogm_queue_add(bat_priv, hard_iface->packet_buff,
 			     hard_iface->packet_len, hard_iface, 1,
 			     bat_iv_ogm_emit_send_time(bat_priv));
-
-	if (primary_if)
-		hardif_free_ref(primary_if);
 }
 
 static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
@@ -1238,6 +1315,7 @@ static struct bat_algo_ops batman_iv __read_mostly = {
 	.bat_iface_disable = bat_iv_ogm_iface_disable,
 	.bat_iface_update_mac = bat_iv_ogm_iface_update_mac,
 	.bat_primary_iface_set = bat_iv_ogm_primary_iface_set,
+	.bat_fill_ogm = bat_iv_fill_ogm,
 	.bat_ogm_schedule = bat_iv_ogm_schedule,
 	.bat_ogm_emit = bat_iv_ogm_emit,
 };
diff --git a/send.c b/send.c
index cebc14a..c79e0b3 100644
--- a/send.c
+++ b/send.c
@@ -78,62 +78,9 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
-static void realloc_packet_buffer(struct hard_iface *hard_iface,
-				  int new_len)
-{
-	unsigned char *new_buff;
-
-	new_buff = kmalloc(new_len, GFP_ATOMIC);
-
-	/* keep old buffer if kmalloc should fail */
-	if (new_buff) {
-		memcpy(new_buff, hard_iface->packet_buff,
-		       BATMAN_OGM_HLEN);
-
-		kfree(hard_iface->packet_buff);
-		hard_iface->packet_buff = new_buff;
-		hard_iface->packet_len = new_len;
-	}
-}
-
-/* when calling this function (hard_iface == primary_if) has to be true */
-static int prepare_packet_buffer(struct bat_priv *bat_priv,
-				  struct hard_iface *hard_iface)
-{
-	int new_len;
-
-	new_len = BATMAN_OGM_HLEN +
-		  tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
-
-	/* if we have too many changes for one packet don't send any
-	 * and wait for the tt table request which will be fragmented */
-	if (new_len > hard_iface->soft_iface->mtu)
-		new_len = BATMAN_OGM_HLEN;
-
-	realloc_packet_buffer(hard_iface, new_len);
-
-	bat_priv->tt_crc = tt_local_crc(bat_priv);
-
-	/* reset the sending counter */
-	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
-
-	return tt_changes_fill_buffer(bat_priv,
-				      hard_iface->packet_buff + BATMAN_OGM_HLEN,
-				      hard_iface->packet_len - BATMAN_OGM_HLEN);
-}
-
-static int reset_packet_buffer(struct bat_priv *bat_priv,
-				struct hard_iface *hard_iface)
-{
-	realloc_packet_buffer(hard_iface, BATMAN_OGM_HLEN);
-	return 0;
-}
-
 void schedule_bat_ogm(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct hard_iface *primary_if;
-	int tt_num_changes = -1;
 
 	if ((hard_iface->if_status == IF_NOT_IN_USE) ||
 	    (hard_iface->if_status == IF_TO_BE_REMOVED))
@@ -149,26 +96,7 @@ void schedule_bat_ogm(struct hard_iface *hard_iface)
 	if (hard_iface->if_status == IF_TO_BE_ACTIVATED)
 		hard_iface->if_status = IF_ACTIVE;
 
-	primary_if = primary_if_get_selected(bat_priv);
-
-	if (hard_iface == primary_if) {
-		/* if at least one change happened */
-		if (atomic_read(&bat_priv->tt_local_changes) > 0) {
-			tt_commit_changes(bat_priv);
-			tt_num_changes = prepare_packet_buffer(bat_priv,
-							       hard_iface);
-		}
-
-		/* if the changes have been sent often enough */
-		if (!atomic_dec_not_zero(&bat_priv->tt_ogm_append_cnt))
-			tt_num_changes = reset_packet_buffer(bat_priv,
-							     hard_iface);
-	}
-
-	if (primary_if)
-		hardif_free_ref(primary_if);
-
-	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface, tt_num_changes);
+	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface);
 }
 
 static void forw_packet_free(struct forw_packet *forw_packet)
@@ -321,6 +249,7 @@ void send_outstanding_bat_ogm_packet(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
+	bat_priv->bat_algo_ops->bat_fill_ogm(bat_priv, forw_packet);
 	bat_priv->bat_algo_ops->bat_ogm_emit(forw_packet);
 
 	/**
diff --git a/types.h b/types.h
index 995e910..c1fb193 100644
--- a/types.h
+++ b/types.h
@@ -404,8 +404,10 @@ struct bat_algo_ops {
 	/* called when primary interface is selected / changed */
 	void (*bat_primary_iface_set)(struct hard_iface *hard_iface);
 	/* prepare a new outgoing OGM for the send queue */
-	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
-				 int tt_num_changes);
+	void (*bat_ogm_schedule)(struct hard_iface *hard_iface);
+	/* fill the outgoing OGM */
+	void (*bat_fill_ogm)(struct bat_priv *bat_priv,
+			     struct forw_packet *forw_packet);
 	/* send scheduled OGM */
 	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
 };
-- 
1.7.9.4

