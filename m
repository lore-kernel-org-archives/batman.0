Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:32 +0100
Message-Id: <1451992006-13191-17-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 17/31] batman-adv: Convert
	batadv_bla_claim to kref
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

batman-adv uses a self-written reference implementation which is just based
on atomic_t. This is less obvious when reading the code than kref and
therefore increases the change that the reference counting will be missed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/bridge_loop_avoidance.c | 16 ++++++++++------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 2b2d03d..2988890 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -172,10 +172,14 @@ batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 /**
  * batadv_claim_release - release claim from lists and queue for free after rcu
  *  grace period
- * @claim: claim to be free'd
+ * @ref: kref pointer of the claim
  */
-static void batadv_claim_release(struct batadv_bla_claim *claim)
+static void batadv_claim_release(struct kref *ref)
 {
+	struct batadv_bla_claim *claim;
+
+	claim = container_of(ref, struct batadv_bla_claim, refcount);
+
 	batadv_backbone_gw_free_ref(claim->backbone_gw);
 	kfree_rcu(claim, rcu);
 }
@@ -187,8 +191,7 @@ static void batadv_claim_release(struct batadv_bla_claim *claim)
  */
 static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 {
-	if (atomic_dec_and_test(&claim->refcount))
-		batadv_claim_release(claim);
+	kref_put(&claim->refcount, batadv_claim_release);
 }
 
 /**
@@ -219,7 +222,7 @@ static struct batadv_bla_claim
 		if (!batadv_compare_claim(&claim->hash_entry, data))
 			continue;
 
-		if (!atomic_inc_not_zero(&claim->refcount))
+		if (!kref_get_unless_zero(&claim->refcount))
 			continue;
 
 		claim_tmp = claim;
@@ -651,7 +654,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		claim->lasttime = jiffies;
 		claim->backbone_gw = backbone_gw;
 
-		atomic_set(&claim->refcount, 2);
+		kref_init(&claim->refcount);
+		kref_get(&claim->refcount);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, BATADV_PRINT_VID(vid));
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

