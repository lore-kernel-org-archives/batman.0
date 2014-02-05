Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  5 Feb 2014 13:02:48 +0100
Message-Id: <1391601768-6792-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix potential orig_node
	reference leak
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

Since batadv_orig_node_new() does not add the originator into the orig
hash, it should only return the created orig_node object with a refcount
of one (for the object return). Otherwise batadv_iv_ogm_orig_get() will
not free the orig_node correctly when allocating its private structures
or adding to the hash fails (refcount will just be decreased to one) and
eventually leak it.

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 bat_iv_ogm.c |    8 +++++++-
 originator.c |    3 +--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7cf26bc..10acd39 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -243,11 +243,17 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 	if (!orig_node->bat_iv.bcast_own_sum)
 		goto free_bcast_own;
 
+	/* increase refcount for the hash reference */
+	if (atomic_inc_not_zero(&orig_node->refcount))
+		goto free_bcast_own;
+
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
-	if (hash_added != 0)
+	if (hash_added != 0) {
+		batadv_orig_node_free_ref(orig_node);
 		goto free_bcast_own;
+	}
 
 	return orig_node;
 
diff --git a/originator.c b/originator.c
index c4d16e5..c308367 100644
--- a/originator.c
+++ b/originator.c
@@ -625,8 +625,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 
 	batadv_nc_init_orig(orig_node);
 
-	/* extra reference for return */
-	atomic_set(&orig_node->refcount, 2);
+	atomic_set(&orig_node->refcount, 1);
 
 	orig_node->tt_initialised = false;
 	orig_node->bat_priv = bat_priv;
-- 
1.7.10.4

