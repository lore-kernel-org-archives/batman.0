Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Feb 2019 15:09:04 +0100
Message-Id: <20190223140906.28979-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-adv: Reduce claim hash refcnt only for
 removed entry
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

The batadv_hash_remove is a function which searches the hashtable for an
entry using a needle, a hashtable bucket selection function and a compare
function. It will lock the bucket list and delete an entry when the compare
function matches it with the needle. It returns the pointer to the
hlist_node which matches or NULL when no entry matches the needle.

The batadv_bla_del_claim is not itself protected in anyway to avoid that
any other function is modifying the hashtable between the search for the
entry and the call to batadv_hash_remove. It can therefore happen that the
entry either doesn't exist anymore or an entry was deleted which is not the
same object as the needle. In such an situation, the reference counter (for
the reference stored in the hashtable) must not be reduced for the needle.
Instead the reference counter of the actually removed entry has to be
reduced.

Otherwise the reference counter will underflow and the object might be
freed before all its references were dropped. The kref helpers reported
this problem as:

  refcount_t: underflow; use-after-free.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Simon Wunderlich <sw@simonwunderlich.de>

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ef39aabdb69435f384ae2ebef26d4d31367f427c..4fb01108e5f534b8a055edface0717f950ccdacc 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -803,6 +803,8 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 				 const u8 *mac, const unsigned short vid)
 {
 	struct batadv_bla_claim search_claim, *claim;
+	struct batadv_bla_claim *claim_removed_entry;
+	struct hlist_node *claim_removed_node;
 
 	ether_addr_copy(search_claim.addr, mac);
 	search_claim.vid = vid;
@@ -813,10 +815,18 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "%s(): %pM, vid %d\n", __func__,
 		   mac, batadv_print_vid(vid));
 
-	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
-			   batadv_choose_claim, claim);
-	batadv_claim_put(claim); /* reference from the hash is gone */
+	claim_removed_node = batadv_hash_remove(bat_priv->bla.claim_hash,
+						batadv_compare_claim,
+						batadv_choose_claim, claim);
+	if (!claim_removed_node)
+		goto free_claim;
 
+	/* reference from the hash is gone */
+	claim_removed_entry = hlist_entry(claim_removed_node,
+					  struct batadv_bla_claim, hash_entry);
+	batadv_claim_put(claim_removed_entry);
+
+free_claim:
 	/* don't need the reference from hash_find() anymore */
 	batadv_claim_put(claim);
 }
