Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:42 +0100
Message-Id: <1450222316-1764-9-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/23] batman-adv: Convert batadv_bla_claim
	to kref
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 36 ++++++++++++++++++----------------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 4e5538a..3315b27 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -169,27 +169,28 @@ static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_claim_free_rcu - finally deinitialize the claim
- * @rcu: rcu pointer within the claim structure
+ * batadv_claim_release - release claim from lists and queue for free after rcu
+ *  grace period
+ * * @ref: kref pointer of the claim
  */
-static void batadv_claim_free_rcu(struct rcu_head *rcu)
+static void batadv_claim_release(struct kref *ref)
 {
 	struct batadv_bla_claim *claim;
 
-	claim = container_of(rcu, struct batadv_bla_claim, rcu);
+	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
 	batadv_backbone_gw_put(claim->backbone_gw);
-	kfree(claim);
+	kfree_rcu(claim, rcu);
 }
 
 /**
- * batadv_claim_free_rcu - free a claim
+ * batadv_claim_put - decrement the claim refcounter and possibly
+ *  release it
  * @claim: claim to be free'd
  */
-static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
+static void batadv_claim_put(struct batadv_bla_claim *claim)
 {
-	if (atomic_dec_and_test(&claim->refcount))
-		call_rcu(&claim->rcu, batadv_claim_free_rcu);
+	kref_put(&claim->refcount, batadv_claim_release);
 }
 
 /**
@@ -220,7 +221,7 @@ static struct batadv_bla_claim
 		if (!batadv_compare_claim(&claim->hash_entry, data))
 			continue;
 
-		if (!atomic_inc_not_zero(&claim->refcount))
+		if (!kref_get_unless_zero(&claim->refcount))
 			continue;
 
 		claim_tmp = claim;
@@ -303,7 +304,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_free_ref(claim);
+			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
 		}
 		spin_unlock_bh(list_lock);
@@ -652,7 +653,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		claim->lasttime = jiffies;
 		claim->backbone_gw = backbone_gw;
 
-		atomic_set(&claim->refcount, 2);
+		kref_init(&claim->refcount);
+		kref_get(&claim->refcount);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, BATADV_PRINT_VID(vid));
@@ -691,7 +693,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	backbone_gw->lasttime = jiffies;
 
 claim_free_ref:
-	batadv_claim_free_ref(claim);
+	batadv_claim_put(claim);
 }
 
 /**
@@ -716,14 +718,14 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
 			   batadv_choose_claim, claim);
-	batadv_claim_free_ref(claim); /* reference from the hash is gone */
+	batadv_claim_put(claim); /* reference from the hash is gone */
 
 	spin_lock_bh(&claim->backbone_gw->crc_lock);
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&claim->backbone_gw->crc_lock);
 
 	/* don't need the reference from hash_find() anymore */
-	batadv_claim_free_ref(claim);
+	batadv_claim_put(claim);
 }
 
 /**
@@ -1691,7 +1693,7 @@ out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (claim)
-		batadv_claim_free_ref(claim);
+		batadv_claim_put(claim);
 	return ret;
 }
 
@@ -1780,7 +1782,7 @@ out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (claim)
-		batadv_claim_free_ref(claim);
+		batadv_claim_put(claim);
 	return ret;
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 098ec7f..c56b99c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -951,7 +951,7 @@ struct batadv_bla_claim {
 	unsigned long lasttime;
 	struct hlist_node hash_entry;
 	struct rcu_head rcu;
-	atomic_t refcount;
+	struct kref refcount;
 };
 #endif
 
-- 
2.6.4

