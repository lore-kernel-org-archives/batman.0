Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 23 Apr 2012 16:35:12 +0800
Message-Id: <1335170112-6610-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: turn tt commit code into routing
	protocol agnostic API
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Prior to this patch the translation table code made assumptions about how
the routing protocol works and where its buffers are stored (to directly
modify them).
Each protocol now calls the tt code with the relevant pointers, thereby
abstracting the code.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c        |   21 +++++++---
 send.c              |   74 +----------------------------------
 translation-table.c |  110 +++++++++++++++++++++++++++++++++++++++++++++------
 translation-table.h |    6 +-
 types.h             |    3 +-
 5 files changed, 117 insertions(+), 97 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2b48b82..a833640 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -562,13 +562,12 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
 			     if_incoming, 0, bat_iv_ogm_fwd_send_time());
 }
 
-static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
-				int tt_num_changes)
+static void bat_iv_ogm_schedule(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batman_ogm_packet *batman_ogm_packet;
 	struct hard_iface *primary_if;
-	int vis_server;
+	int vis_server, tt_num_changes = 0;
 
 	vis_server = atomic_read(&bat_priv->vis_mode);
 	primary_if = primary_if_get_selected(bat_priv);
@@ -579,10 +578,7 @@ static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
 	batman_ogm_packet->seqno =
 			htonl((uint32_t)atomic_read(&hard_iface->seqno));
 
-	batman_ogm_packet->ttvn = atomic_read(&bat_priv->ttvn);
 	batman_ogm_packet->tt_crc = htons(bat_priv->tt_crc);
-	if (tt_num_changes >= 0)
-		batman_ogm_packet->tt_num_changes = tt_num_changes;
 
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
 		batman_ogm_packet->flags |= VIS_SERVER;
@@ -598,6 +594,19 @@ static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
 
 	atomic_inc(&hard_iface->seqno);
 
+	if (hard_iface == primary_if)
+		tt_num_changes = tt_append_changes(bat_priv,
+						   &hard_iface->packet_buff,
+						   &hard_iface->packet_len,
+						   BATMAN_OGM_HLEN);
+
+	if (tt_num_changes > 0)
+		batman_ogm_packet->tt_num_changes = tt_num_changes;
+	else
+		batman_ogm_packet->tt_num_changes = 0;
+
+	batman_ogm_packet->ttvn = atomic_read(&bat_priv->ttvn);
+
 	slide_own_bcast_window(hard_iface);
 	bat_iv_ogm_queue_add(bat_priv, hard_iface->packet_buff,
 			     hard_iface->packet_len, hard_iface, 1,
diff --git a/send.c b/send.c
index cebc14a..836b70d 100644
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
diff --git a/translation-table.c b/translation-table.c
index 88c62f1..b032087 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -275,14 +275,63 @@ out:
 		tt_global_entry_free_ref(tt_global_entry);
 }
 
-int tt_changes_fill_buffer(struct bat_priv *bat_priv,
-			   unsigned char *buff, int buff_len)
+static void tt_realloc_packet_buff(unsigned char **packet_buff,
+				   int *packet_buff_len, int min_packet_len,
+				   int new_packet_len)
+{
+	unsigned char *new_buff;
+
+	new_buff = kmalloc(new_packet_len, GFP_ATOMIC);
+
+	/* keep old buffer if kmalloc should fail */
+	if (new_buff) {
+		memcpy(new_buff, *packet_buff, min_packet_len);
+		kfree(*packet_buff);
+		*packet_buff = new_buff;
+		*packet_buff_len = new_packet_len;
+	}
+}
+
+static void tt_prepare_packet_buff(struct bat_priv *bat_priv,
+				   unsigned char **packet_buff,
+				   int *packet_buff_len, int min_packet_len)
+{
+	struct hard_iface *primary_if;
+	int req_len;
+
+	primary_if = primary_if_get_selected(bat_priv);
+
+	req_len = min_packet_len;
+	req_len += tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
+
+	/* if we have too many changes for one packet don't send any
+	 * and wait for the tt table request which will be fragmented */
+	if ((!primary_if) || (req_len > primary_if->soft_iface->mtu))
+		req_len = min_packet_len;
+
+	tt_realloc_packet_buff(packet_buff, packet_buff_len,
+			       min_packet_len, req_len);
+
+	if (primary_if)
+		hardif_free_ref(primary_if);
+}
+
+static int tt_changes_fill_buff(struct bat_priv *bat_priv,
+				unsigned char **packet_buff,
+				int *packet_buff_len, int min_packet_len)
 {
-	int count = 0, tot_changes = 0;
 	struct tt_change_node *entry, *safe;
+	int count = 0, tot_changes = 0, new_len;
+	unsigned char *tt_buff;
+
+	tt_prepare_packet_buff(bat_priv, packet_buff,
+			       packet_buff_len, min_packet_len);
 
-	if (buff_len > 0)
-		tot_changes = buff_len / tt_len(1);
+	new_len = *packet_buff_len - min_packet_len;
+	tt_buff = *packet_buff + min_packet_len;
+
+	if (new_len > 0)
+		tot_changes = new_len / tt_len(1);
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
 	atomic_set(&bat_priv->tt_local_changes, 0);
@@ -290,7 +339,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
 				 list) {
 		if (count < tot_changes) {
-			memcpy(buff + tt_len(count),
+			memcpy(tt_buff + tt_len(count),
 			       &entry->change, sizeof(struct tt_change));
 			count++;
 		}
@@ -306,15 +355,15 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	bat_priv->tt_buff = NULL;
 	/* We check whether this new OGM has no changes due to size
 	 * problems */
-	if (buff_len > 0) {
+	if (new_len > 0) {
 		/**
 		 * if kmalloc() fails we will reply with the full table
 		 * instead of providing the diff
 		 */
-		bat_priv->tt_buff = kmalloc(buff_len, GFP_ATOMIC);
+		bat_priv->tt_buff = kmalloc(new_len, GFP_ATOMIC);
 		if (bat_priv->tt_buff) {
-			memcpy(bat_priv->tt_buff, buff, buff_len);
-			bat_priv->tt_buff_len = buff_len;
+			memcpy(bat_priv->tt_buff, tt_buff, new_len);
+			bat_priv->tt_buff_len = new_len;
 		}
 	}
 	spin_unlock_bh(&bat_priv->tt_buff_lock);
@@ -2019,20 +2068,55 @@ static void tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 
 }
 
-void tt_commit_changes(struct bat_priv *bat_priv)
+static int tt_commit_changes(struct bat_priv *bat_priv,
+			     unsigned char **packet_buff, int *packet_buff_len,
+			     int packet_min_len)
 {
-	uint16_t changed_num = tt_set_flags(bat_priv->tt_local_hash,
-					    TT_CLIENT_NEW, false);
+	uint16_t changed_num = 0;
+
+	if (atomic_read(&bat_priv->tt_local_changes) < 1)
+		return 0;
+
+	changed_num = tt_set_flags(bat_priv->tt_local_hash,
+				   TT_CLIENT_NEW, false);
+
 	/* all the reset entries have now to be effectively counted as local
 	 * entries */
 	atomic_add(changed_num, &bat_priv->num_local_tt);
 	tt_local_purge_pending_clients(bat_priv);
+	bat_priv->tt_crc = tt_local_crc(bat_priv);
 
 	/* Increment the TTVN only once per OGM interval */
 	atomic_inc(&bat_priv->ttvn);
 	bat_dbg(DBG_TT, bat_priv, "Local changes committed, updating to ttvn %u\n",
 		(uint8_t)atomic_read(&bat_priv->ttvn));
 	bat_priv->tt_poss_change = false;
+
+	/* reset the sending counter */
+	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
+
+	return tt_changes_fill_buff(bat_priv, packet_buff,
+				    packet_buff_len, packet_min_len);
+}
+
+/* when calling this function (hard_iface == primary_if) has to be true */
+int tt_append_changes(struct bat_priv *bat_priv,
+		      unsigned char **packet_buff, int *packet_buff_len,
+		      int packet_min_len)
+{
+	int tt_num_changes;
+
+	/* if at least one change happened */
+	tt_num_changes = tt_commit_changes(bat_priv, packet_buff,
+					   packet_buff_len, packet_min_len);
+
+	/* if the changes have been sent often enough */
+	if ((tt_num_changes == 0) &&
+	    (!atomic_dec_not_zero(&bat_priv->tt_ogm_append_cnt)))
+		tt_realloc_packet_buff(packet_buff, packet_buff_len,
+				       packet_min_len, packet_min_len);
+
+	return tt_num_changes;
 }
 
 bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
diff --git a/translation-table.h b/translation-table.h
index c43374d..58d9aae 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -23,8 +23,6 @@
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
 int tt_len(int changes_num);
-int tt_changes_fill_buffer(struct bat_priv *bat_priv,
-			   unsigned char *buff, int buff_len);
 int tt_init(struct bat_priv *bat_priv);
 void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		  int ifindex);
@@ -48,11 +46,13 @@ bool send_tt_response(struct bat_priv *bat_priv,
 bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr);
 void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
-void tt_commit_changes(struct bat_priv *bat_priv);
 bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
 void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		    const unsigned char *tt_buff, uint8_t tt_num_changes,
 		    uint8_t ttvn, uint16_t tt_crc);
+int tt_append_changes(struct bat_priv *bat_priv,
+		      unsigned char **packet_buff, int *packet_buff_len,
+		      int packet_min_len);
 bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr);
 
 
diff --git a/types.h b/types.h
index 2944f77..9bde13d 100644
--- a/types.h
+++ b/types.h
@@ -427,8 +427,7 @@ struct bat_algo_ops {
 	/* called when primary interface is selected / changed */
 	void (*bat_primary_iface_set)(struct hard_iface *hard_iface);
 	/* prepare a new outgoing OGM for the send queue */
-	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
-				 int tt_num_changes);
+	void (*bat_ogm_schedule)(struct hard_iface *hard_iface);
 	/* send scheduled OGM */
 	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
 };
-- 
1.7.9.1

