Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 30 Mar 2012 19:11:59 +0300
Message-Id: <1333123919-11176-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: make tt_changes_buff API
	consistent
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

The changes buff is not used in a consistent way right now. During the OGM
preparation, first the buffer size is read and then it is copied, without any
locking mechanism at all. This could obviously raise a race condition.
This patch changes the API a little bit and adds a proper locking mechanism in
order to avoid such problem.

At the same time, the new API proposed in this patch is also more suitable to
make the OGM packet preparation independent from the TT code.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

@Marek: this patch is different from the one I sent you before



 send.c              |   36 ++------------
 translation-table.c |  135 +++++++++++++++++++++++++++++++++------------------
 translation-table.h |    7 ++-
 types.h             |    3 +
 4 files changed, 99 insertions(+), 82 deletions(-)

diff --git a/send.c b/send.c
index 20f6e89..40313b3 100644
--- a/send.c
+++ b/send.c
@@ -78,48 +78,20 @@ send_skb_err:
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
 /* when calling this function (hard_iface == primary_if) has to be true */
 static int prepare_packet_buffer(struct bat_priv *bat_priv,
 				  struct hard_iface *hard_iface)
 {
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
+	int tt_changes = 0;
 
 	atomic_set(&bat_priv->tt_crc, tt_local_crc(bat_priv));
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
 
-	return tt_changes_fill_buffer(bat_priv,
-				      hard_iface->packet_buff + BATMAN_OGM_HLEN,
-				      hard_iface->packet_len - BATMAN_OGM_HLEN);
+	tt_changes = tt_alloc_buffer(bat_priv, hard_iface, BATMAN_OGM_HLEN);
+
+	return tt_changes;
 }
 
 static int reset_packet_buffer(struct bat_priv *bat_priv,
diff --git a/translation-table.c b/translation-table.c
index 934900d..3454879 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -273,53 +273,6 @@ out:
 		tt_global_entry_free_ref(tt_global_entry);
 }
 
-int tt_changes_fill_buffer(struct bat_priv *bat_priv,
-			   unsigned char *buff, int buff_len)
-{
-	int count = 0, tot_changes = 0;
-	struct tt_change_node *entry, *safe;
-
-	if (buff_len > 0)
-		tot_changes = buff_len / tt_len(1);
-
-	spin_lock_bh(&bat_priv->tt_changes_list_lock);
-	atomic_set(&bat_priv->tt_local_changes, 0);
-
-	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
-				 list) {
-		if (count < tot_changes) {
-			memcpy(buff + tt_len(count),
-			       &entry->change, sizeof(struct tt_change));
-			count++;
-		}
-		list_del(&entry->list);
-		kfree(entry);
-	}
-	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
-
-	/* Keep the buffer for possible tt_request */
-	spin_lock_bh(&bat_priv->tt_buff_lock);
-	kfree(bat_priv->tt_buff);
-	bat_priv->tt_buff_len = 0;
-	bat_priv->tt_buff = NULL;
-	/* We check whether this new OGM has no changes due to size
-	 * problems */
-	if (buff_len > 0) {
-		/**
-		 * if kmalloc() fails we will reply with the full table
-		 * instead of providing the diff
-		 */
-		bat_priv->tt_buff = kmalloc(buff_len, GFP_ATOMIC);
-		if (bat_priv->tt_buff) {
-			memcpy(bat_priv->tt_buff, buff, buff_len);
-			bat_priv->tt_buff_len = buff_len;
-		}
-	}
-	spin_unlock_bh(&bat_priv->tt_buff_lock);
-
-	return tot_changes;
-}
-
 int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -2005,10 +1958,98 @@ static void tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 
 }
 
+static void tt_save_events_buff(struct bat_priv *bat_priv)
+{
+	int count = 0;
+	int tot_changes_size;
+	struct tt_change_node *entry, *safe;
+
+	spin_lock_bh(&bat_priv->tt_changes_list_lock);
+	spin_lock_bh(&bat_priv->tt_changes_tmp_lock);
+
+	bat_priv->tt_num_changes_tmp = atomic_read(&bat_priv->tt_local_changes);
+	atomic_set(&bat_priv->tt_local_changes, 0);
+
+	kfree(bat_priv->tt_changes_tmp);
+
+	tot_changes_size = tt_len(bat_priv->tt_num_changes_tmp);
+	bat_priv->tt_changes_tmp = kmalloc(tot_changes_size, GFP_ATOMIC);
+	if (!bat_priv->tt_changes_tmp)
+		goto out;
+
+	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
+				 list) {
+		if (count < bat_priv->tt_num_changes_tmp) {
+			memcpy(bat_priv->tt_changes_tmp + tt_len(count),
+			       &entry->change, sizeof(struct tt_change));
+			count++;
+		}
+		list_del(&entry->list);
+		kfree(entry);
+	}
+out:
+	spin_unlock_bh(&bat_priv->tt_changes_tmp_lock);
+	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
+}
+
+void realloc_packet_buffer(struct hard_iface *hard_iface,
+			   int new_len)
+{
+	unsigned char *new_buff;
+
+	/* if we have too many changes for one packet don't send any
+	 * and wait for the tt table request which will be fragmented */
+	if (new_len > hard_iface->soft_iface->mtu)
+		new_len = BATMAN_OGM_HLEN;
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
+uint16_t tt_alloc_buffer(struct bat_priv *bat_priv,
+			 struct hard_iface *hard_iface, int header_size)
+{
+	int size;
+	uint16_t tt_changes_num = 0;
+
+	spin_lock_bh(&bat_priv->tt_changes_tmp_lock);
+
+	size = header_size + tt_len(bat_priv->tt_num_changes_tmp);
+	if (size != hard_iface->packet_len)
+		realloc_packet_buffer(hard_iface, size);
+
+	/* check if we really allocated the requested amount of memory */
+	if (hard_iface->packet_len == size) {
+		memcpy(hard_iface->packet_buff + header_size,
+		       bat_priv->tt_changes_tmp,
+		       tt_len(bat_priv->tt_num_changes_tmp));
+		tt_changes_num = bat_priv->tt_num_changes_tmp;
+	}
+
+	kfree(bat_priv->tt_changes_tmp);
+
+	bat_priv->tt_changes_tmp = NULL;
+	bat_priv->tt_num_changes_tmp = 0;
+
+	spin_unlock_bh(&bat_priv->tt_changes_tmp_lock);
+
+	return tt_changes_num;
+}
+
 void tt_commit_changes(struct bat_priv *bat_priv)
 {
 	uint16_t changed_num = tt_set_flags(bat_priv->tt_local_hash,
 					    TT_CLIENT_NEW, false);
+	tt_save_events_buff(bat_priv);
 	/* all the reset entries have now to be effectively counted as local
 	 * entries */
 	atomic_add(changed_num, &bat_priv->num_local_tt);
diff --git a/translation-table.h b/translation-table.h
index c43374d..73279f6 100644
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
@@ -54,6 +52,9 @@ void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		    const unsigned char *tt_buff, uint8_t tt_num_changes,
 		    uint8_t ttvn, uint16_t tt_crc);
 bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr);
-
+uint16_t tt_alloc_buffer(struct bat_priv *bat_priv,
+			 struct hard_iface *hard_iface, int header_size);
+void realloc_packet_buffer(struct hard_iface *hard_iface,
+			   int new_len);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 15f538a..462ec7a 100644
--- a/types.h
+++ b/types.h
@@ -198,6 +198,8 @@ struct bat_priv {
 	struct hlist_head forw_bcast_list;
 	struct hlist_head gw_list;
 	struct list_head tt_changes_list; /* tracks changes in a OGM int */
+	unsigned char *tt_changes_tmp;
+	uint16_t tt_num_changes_tmp;
 	struct list_head vis_send_list;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *tt_local_hash;
@@ -217,6 +219,7 @@ struct bat_priv {
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t tt_changes_list_lock; /* protects tt_changes */
+	spinlock_t tt_changes_tmp_lock; /* protects tt_changes_tmp */
 	spinlock_t tt_req_list_lock; /* protects tt_req_list */
 	spinlock_t tt_roam_list_lock; /* protects tt_roam_list */
 	spinlock_t gw_list_lock; /* protects gw_list and curr_gw */
-- 
1.7.3.4

