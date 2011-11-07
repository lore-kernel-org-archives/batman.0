Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  7 Nov 2011 16:36:40 +0100
Message-Id: <1320680200-32024-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add tt_initialised flag to the
	orig_node struct
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

(ttvn == 0) is currently used as initial condition. However this is not a good
idea because ttvn gets the vale zero each time after reaching the maximum value
(wrap around). For this reason a new flag is added in order to define whether a
node has an initialised table or not. Moreover, after invoking
tt_global_del_orig(), tt_initialised has to be set to false

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 originator.c        |    1 +
 translation-table.c |   11 ++++++++---
 types.h             |    1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/originator.c b/originator.c
index 0bc2045..847ff7e 100644
--- a/originator.c
+++ b/originator.c
@@ -219,6 +219,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	/* extra reference for return */
 	atomic_set(&orig_node->refcount, 2);
 
+	orig_node->tt_initialised = false;
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
diff --git a/translation-table.c b/translation-table.c
index 3726f33..e5f1c4e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -704,6 +704,7 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 		spin_unlock_bh(list_lock);
 	}
 	atomic_set(&orig_node->tt_size, 0);
+	orig_node->tt_initialised = false;
 }
 
 static void tt_global_roam_purge(struct bat_priv *bat_priv)
@@ -1463,6 +1464,7 @@ static void tt_update_changes(struct bat_priv *bat_priv,
 	tt_save_orig_buffer(bat_priv, orig_node, (unsigned char *)tt_change,
 			    tt_num_changes);
 	atomic_set(&orig_node->last_ttvn, ttvn);
+	orig_node->tt_initialised = true;
 }
 
 bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
@@ -1823,8 +1825,10 @@ void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	bool full_table = true;
 
-	/* the ttvn increased by one -> we can apply the attached changes */
-	if (ttvn - orig_ttvn == 1) {
+	/* {orig table not initialised AND first diff is in the OGM} OR the ttvn
+	 * increased by one -> we can apply the attached changes */
+	if ((!orig_node->tt_initialised && ttvn == 1) ||
+	    ttvn - orig_ttvn == 1) {
 		/* the OGM could not contain the changes due to their size or
 		 * because they have already been sent TT_OGM_APPEND_MAX times.
 		 * In this case send a tt request */
@@ -1858,7 +1862,8 @@ void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	} else {
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data */
-		if (ttvn != orig_ttvn || orig_node->tt_crc != tt_crc) {
+		if (!orig_node->tt_initialised || ttvn != orig_ttvn ||
+		    orig_node->tt_crc != tt_crc) {
 request_table:
 			bat_dbg(DBG_TT, bat_priv, "TT inconsistency for %pM. "
 				"Need to retrieve the correct information "
diff --git a/types.h b/types.h
index e9eb043..35085f4 100644
--- a/types.h
+++ b/types.h
@@ -81,6 +81,7 @@ struct orig_node {
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff */
 	atomic_t tt_size;
+	bool tt_initialised;
 	/* The tt_poss_change flag is used to detect an ongoing roaming phase.
 	 * If true, then I sent a Roaming_adv to this orig_node and I have to
 	 * inspect every packet directed to it to check whether it is still
-- 
1.7.3.4

