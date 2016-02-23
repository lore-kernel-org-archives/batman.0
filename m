Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 23 Feb 2016 14:08:12 +0800
Message-Id: <1456207703-903-10-git-send-email-a@unstable.cc>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 09/20] batman-adv: Rename batadv_claim
	*_free_ref function to *_put
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

The batman-adv source code is the only place in the kernel which uses the
*_free_ref naming scheme for the *_put functions. Changing it to *_put
makes it more consistent and makes it easier to understand the connection
to the *_get functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bridge_loop_avoidance.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ce2d0701fb59..0a6c8b824a00 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -184,11 +184,11 @@ static void batadv_claim_release(struct kref *ref)
 }
 
 /**
- * batadv_claim_free_ref - decrement the claim refcounter and possibly
+ * batadv_claim_put - decrement the claim refcounter and possibly
  *  release it
  * @claim: claim to be free'd
  */
-static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
+static void batadv_claim_put(struct batadv_bla_claim *claim)
 {
 	kref_put(&claim->refcount, batadv_claim_release);
 }
@@ -304,7 +304,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_free_ref(claim);
+			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
 		}
 		spin_unlock_bh(list_lock);
@@ -693,7 +693,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	backbone_gw->lasttime = jiffies;
 
 claim_free_ref:
-	batadv_claim_free_ref(claim);
+	batadv_claim_put(claim);
 }
 
 /**
@@ -718,14 +718,14 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
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
@@ -1693,7 +1693,7 @@ out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	if (claim)
-		batadv_claim_free_ref(claim);
+		batadv_claim_put(claim);
 	return ret;
 }
 
@@ -1782,7 +1782,7 @@ out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 	if (claim)
-		batadv_claim_free_ref(claim);
+		batadv_claim_put(claim);
 	return ret;
 }
 
-- 
2.7.1

