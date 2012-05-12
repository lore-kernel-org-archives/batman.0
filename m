Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:21 +0200
Message-Id: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 01/23] batman-adv: Fix namespace for
	hash_set_lock_class
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

This function was introduced in 2c9aa3b4c37bd55148f5f25212c89e7bf5f28497
without a proper namespace prefix.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |    7 ++++---
 hash.c                  |    3 ++-
 hash.h                  |    3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 89e9721..314e37b 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1172,9 +1172,10 @@ int bla_init(struct bat_priv *bat_priv)
 	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
 		return -ENOMEM;
 
-	hash_set_lock_class(bat_priv->claim_hash, &claim_hash_lock_class_key);
-	hash_set_lock_class(bat_priv->backbone_hash,
-			    &backbone_hash_lock_class_key);
+	batadv_hash_set_lock_class(bat_priv->claim_hash,
+				   &claim_hash_lock_class_key);
+	batadv_hash_set_lock_class(bat_priv->backbone_hash,
+				   &backbone_hash_lock_class_key);
 
 	bat_dbg(DBG_BLA, bat_priv, "bla hashes initialized\n");
 
diff --git a/hash.c b/hash.c
index 4578c20..a7dcff0 100644
--- a/hash.c
+++ b/hash.c
@@ -70,7 +70,8 @@ free_hash:
 	return NULL;
 }
 
-void hash_set_lock_class(struct hashtable_t *hash, struct lock_class_key *key)
+void batadv_hash_set_lock_class(struct hashtable_t *hash,
+				struct lock_class_key *key)
 {
 	uint32_t i;
 
diff --git a/hash.h b/hash.h
index 2e0409a..3d67ce4 100644
--- a/hash.h
+++ b/hash.h
@@ -46,7 +46,8 @@ struct hashtable_t {
 struct hashtable_t *hash_new(uint32_t size);
 
 /* set class key for all locks */
-void hash_set_lock_class(struct hashtable_t *hash, struct lock_class_key *key);
+void batadv_hash_set_lock_class(struct hashtable_t *hash,
+				struct lock_class_key *key);
 
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash);
-- 
1.7.10

