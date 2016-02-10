Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 10 Feb 2016 23:57:14 +0800
Message-Id: <1455119847-5862-9-git-send-email-a@unstable.cc>
In-Reply-To: <1455119847-5862-1-git-send-email-a@unstable.cc>
References: <1455119847-5862-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 08/21] batman-adv: Convert batadv_bla_claim
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

batman-adv uses a self-written reference implementation which is just based
on atomic_t. This is less obvious when reading the code than kref and
therefore increases the change that the reference counting will be missed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bridge_loop_avoidance.c | 14 +++++++++-----
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 41116e4c2e34..7781f39c174d 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -174,8 +174,12 @@ batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
  *  grace period
  * @ref: kref pointer of the claim
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
index 595f52400b1f..34c13b65bec2 100644
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
2.7.1

