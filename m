Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  2 Jul 2015 06:30:30 +0200
Message-Id: <1435811430-6949-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix broken capability
	checks
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

The introduction of set_bit() and clear_bit() calls in batman-adv
wrongly passed bitmasks and not the bit numbers to these functions.
This leads to broken capability checks in the according features.

Fixing this by making the capability enum a non-bitmasked one and by
that passing non-masked values to set_bit()/clear_bit() while explicitly
masking with BIT() for testing capability presence.

Fixes: bfd0fbaef270 ("batman-adv: Make DAT capability changes atomic")
Fixes: 586df9e2537b ("batman-adv: Make NC capability changes atomic")
Fixes: a51fa16ecf3f ("batman-adv: Make TT capability changes atomic")
Fixes: 201a54ba710a ("batman-adv: Make MCAST capability changes atomic")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Maybe wait for a desired "Reported-by" name/email in #219.

 distributed-arp-table.c |    2 +-
 multicast.c             |   16 ++++++++--------
 network-coding.c        |    2 +-
 translation-table.c     |    3 ++-
 types.h                 |    8 ++++----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b2cc19b..c663201 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -422,7 +422,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	int j;
 
 	/* check if orig node candidate is running DAT */
-	if (!(candidate->capabilities & BATADV_ORIG_CAPA_HAS_DAT))
+	if (!(candidate->capabilities & BIT(BATADV_ORIG_CAPA_HAS_DAT)))
 		goto out;
 
 	/* Check if this node has already been selected... */
diff --git a/multicast.c b/multicast.c
index b75bcc3..5b6a679 100644
--- a/multicast.c
+++ b/multicast.c
@@ -702,22 +702,22 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 {
 	bool orig_mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	uint8_t mcast_flags = BATADV_NO_FLAGS;
-	bool orig_initialized;
+	bool initialized;
 
 	if (orig_mcast_enabled && tvlv_value &&
 	    (tvlv_value_len >= sizeof(mcast_flags)))
 		mcast_flags = *(uint8_t *)tvlv_value;
 
 	spin_lock_bh(&orig->mcast_handler_lock);
-	orig_initialized = orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST;
+	initialized = orig->capa_initialized & BIT(BATADV_ORIG_CAPA_HAS_MCAST);
 
 	/* If mcast support is turned on decrease the disabled mcast node
 	 * counter only if we had increased it for this node before. If this
 	 * is a completely new orig_node no need to decrease the counter.
 	 */
 	if (orig_mcast_enabled &&
-	    !(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST)) {
-		if (orig_initialized)
+	    !(orig->capabilities & BIT(BATADV_ORIG_CAPA_HAS_MCAST))) {
+		if (initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
 		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	/* If mcast support is being switched off or if this is an initial
@@ -725,8 +725,8 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	 * node counter.
 	 */
 	} else if (!orig_mcast_enabled &&
-		   (orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST ||
-		    !orig_initialized)) {
+		   (orig->capabilities & BIT(BATADV_ORIG_CAPA_HAS_MCAST) ||
+		    !initialized)) {
 		atomic_inc(&bat_priv->mcast.num_disabled);
 		clear_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
 	}
@@ -774,8 +774,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 
 	spin_lock_bh(&orig->mcast_handler_lock);
 
-	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) &&
-	    orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST)
+	if (!(orig->capabilities & BIT(BATADV_ORIG_CAPA_HAS_MCAST)) &&
+	    orig->capa_initialized & BIT(BATADV_ORIG_CAPA_HAS_MCAST))
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
diff --git a/network-coding.c b/network-coding.c
index 3ce493e..3690606 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -871,7 +871,7 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* check if orig node is network coding enabled */
-	if (!(orig_node->capabilities & BATADV_ORIG_CAPA_HAS_NC))
+	if (!(orig_node->capabilities & BIT(BATADV_ORIG_CAPA_HAS_NC)))
 		goto out;
 
 	/* accept ogms from 'good' neighbors and single hop neighbors */
diff --git a/translation-table.c b/translation-table.c
index b6c0f52..8de5df4 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -3319,11 +3319,12 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 {
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
+	unsigned long capa_initialized = orig_node->capa_initialized;
 	bool full_table = true;
 	bool has_tt_init;
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)tt_buff;
-	has_tt_init = orig_node->capa_initialized & BATADV_ORIG_CAPA_HAS_TT;
+	has_tt_init = capa_initialized & BIT(BATADV_ORIG_CAPA_HAS_TT);
 
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
 	 * increased by one -> we can apply the attached changes
diff --git a/types.h b/types.h
index 65dc6bf..3baf595 100644
--- a/types.h
+++ b/types.h
@@ -299,10 +299,10 @@ struct batadv_orig_node {
  *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
  */
 enum batadv_orig_capabilities {
-	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
-	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
-	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
-	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
+	BATADV_ORIG_CAPA_HAS_DAT,
+	BATADV_ORIG_CAPA_HAS_NC,
+	BATADV_ORIG_CAPA_HAS_TT,
+	BATADV_ORIG_CAPA_HAS_MCAST,
 };
 
 /**
-- 
1.7.10.4

