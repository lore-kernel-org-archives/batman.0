Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri,  3 Jul 2015 18:29:59 +0200
Message-Id: <1435940999-3829-5-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 maint 4/4] batman-adv: Fix broken MCAST
	capability check
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
This leads to broken capability checks.

Fixing this by making the capability enum a non-bitmasked one and by
that passing non-masked values to set_bit()/clear_bit().

Fixes: 201a54ba710a ("batman-adv: Make MCAST capability changes atomic")
Reported-by: Def <def@laposte.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast.c |   11 ++++++-----
 types.h     |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/multicast.c b/multicast.c
index b75bcc3..ee8317f 100644
--- a/multicast.c
+++ b/multicast.c
@@ -709,14 +709,15 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		mcast_flags = *(uint8_t *)tvlv_value;
 
 	spin_lock_bh(&orig->mcast_handler_lock);
-	orig_initialized = orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST;
+	orig_initialized = test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
+				    &orig->capa_initialized);
 
 	/* If mcast support is turned on decrease the disabled mcast node
 	 * counter only if we had increased it for this node before. If this
 	 * is a completely new orig_node no need to decrease the counter.
 	 */
 	if (orig_mcast_enabled &&
-	    !(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST)) {
+	    !(test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities))) {
 		if (orig_initialized)
 			atomic_dec(&bat_priv->mcast.num_disabled);
 		set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
@@ -725,7 +726,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	 * node counter.
 	 */
 	} else if (!orig_mcast_enabled &&
-		   (orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST ||
+		   (test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities) ||
 		    !orig_initialized)) {
 		atomic_inc(&bat_priv->mcast.num_disabled);
 		clear_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities);
@@ -774,8 +775,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 
 	spin_lock_bh(&orig->mcast_handler_lock);
 
-	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) &&
-	    orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST)
+	if (!(test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capabilities)) &&
+	    test_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized))
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
diff --git a/types.h b/types.h
index 6f4486c..3baf595 100644
--- a/types.h
+++ b/types.h
@@ -302,7 +302,7 @@ enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC,
 	BATADV_ORIG_CAPA_HAS_TT,
-	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
+	BATADV_ORIG_CAPA_HAS_MCAST,
 };
 
 /**
-- 
1.7.10.4

