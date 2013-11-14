Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 14 Nov 2013 07:26:05 +0100
Message-Id: <1384410369-7437-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1384410369-7437-1-git-send-email-linus.luessing@web.de>
References: <1384410369-7437-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv11 2/6] batman-adv: introduce capability
	initialization bitfield
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

The new bitfield allows us to keep track whether capability subsets of
an originator have gone through their initialization phase yet.

The translation table is the only user right now, but a new one will be
added soon.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 originator.c        |    1 -
 translation-table.c |   12 +++++++-----
 types.h             |    7 ++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/originator.c b/originator.c
index 0134534..f08f04d 100644
--- a/originator.c
+++ b/originator.c
@@ -335,7 +335,6 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	/* extra reference for return */
 	atomic_set(&orig_node->refcount, 2);
 
-	orig_node->tt_initialised = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	batadv_dat_init_orig_node_addr(orig_node);
diff --git a/translation-table.c b/translation-table.c
index e3d16be..b36c9bb 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1748,7 +1748,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		}
 		spin_unlock_bh(list_lock);
 	}
-	orig_node->tt_initialised = false;
+	orig_node->capa_initialized &= ~BATADV_ORIG_CAPA_HAS_TT;
 }
 
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
@@ -2702,7 +2702,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				return;
 		}
 	}
-	orig_node->tt_initialised = true;
+	orig_node->capa_initialized |= BATADV_ORIG_CAPA_HAS_TT;
 }
 
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
@@ -3192,13 +3192,15 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
+	bool has_tt_init;
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)tt_buff;
+	has_tt_init = orig_node->capa_initialized & BATADV_ORIG_CAPA_HAS_TT;
+
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
 	 * increased by one -> we can apply the attached changes
 	 */
-	if ((!orig_node->tt_initialised && ttvn == 1) ||
-	    ttvn - orig_ttvn == 1) {
+	if ((!has_tt_init && ttvn == 1) || ttvn - orig_ttvn == 1) {
 		/* the OGM could not contain the changes due to their size or
 		 * because they have already been sent BATADV_TT_OGM_APPEND_MAX
 		 * times.
@@ -3239,7 +3241,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data
 		 */
-		if (!orig_node->tt_initialised || ttvn != orig_ttvn ||
+		if (!has_tt_init || ttvn != orig_ttvn ||
 		    !batadv_tt_global_check_crc(orig_node, tt_vlan,
 						tt_num_vlan)) {
 request_table:
diff --git a/types.h b/types.h
index 2d87376..a87bc10 100644
--- a/types.h
+++ b/types.h
@@ -178,13 +178,12 @@ struct batadv_orig_bat_iv {
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @batman_seqno_reset: time when the batman seqno window was reset
  * @capabilities: announced capabilities of this originator
+ * @capa_initialized: bitfield to remember whether a capability was initialized
  * @last_ttvn: last seen translation table version number
  * @tt_buff: last tt changeset this node received from the orig node
  * @tt_buff_len: length of the last tt changeset this node received from the
  *  orig node
  * @tt_buff_lock: lock that protects tt_buff and tt_buff_len
- * @tt_initialised: bool keeping track of whether or not this node have received
- *  any translation table information from the orig node yet
  * @tt_lock: prevents from updating the table while reading it. Table update is
  *  made up by two operations (data structure update and metdata -CRC/TTVN-
  *  recalculation) and they have to be executed atomically in order to avoid
@@ -225,11 +224,11 @@ struct batadv_orig_node {
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
 	uint8_t capabilities;
+	uint8_t capa_initialized;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
-	bool tt_initialised;
 	/* prevents from changing the table while reading it */
 	spinlock_t tt_lock;
 	uint32_t last_real_seqno;
@@ -263,10 +262,12 @@ struct batadv_orig_node {
  * enum batadv_orig_capabilities - orig node capabilities
  * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
  * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
+ * @BATADV_ORIG_CAPA_HAS_TT: orig node has tt capability
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
 	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
+	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
 };
 
 /**
-- 
1.7.10.4

