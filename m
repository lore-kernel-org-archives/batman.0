Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:32 +0200
Message-Id: <1336781383-15649-12-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 12/23] batman-adv: Prefix hash non-static
	functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |    8 ++++----
 hash.c                  |    4 ++--
 hash.h                  |    6 +++---
 originator.c            |    4 ++--
 translation-table.c     |    8 ++++----
 vis.c                   |    2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index b0561e3..eb21789 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1166,8 +1166,8 @@ int batadv_bla_init(struct bat_priv *bat_priv)
 	if (bat_priv->claim_hash)
 		return 0;
 
-	bat_priv->claim_hash = hash_new(128);
-	bat_priv->backbone_hash = hash_new(32);
+	bat_priv->claim_hash = batadv_hash_new(128);
+	bat_priv->backbone_hash = batadv_hash_new(32);
 
 	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
 		return -ENOMEM;
@@ -1348,12 +1348,12 @@ void batadv_bla_free(struct bat_priv *bat_priv)
 
 	if (bat_priv->claim_hash) {
 		bla_purge_claims(bat_priv, primary_if, 1);
-		hash_destroy(bat_priv->claim_hash);
+		batadv_hash_destroy(bat_priv->claim_hash);
 		bat_priv->claim_hash = NULL;
 	}
 	if (bat_priv->backbone_hash) {
 		bla_purge_backbone_gw(bat_priv, 1);
-		hash_destroy(bat_priv->backbone_hash);
+		batadv_hash_destroy(bat_priv->backbone_hash);
 		bat_priv->backbone_hash = NULL;
 	}
 	if (primary_if)
diff --git a/hash.c b/hash.c
index a7dcff0..439f5d7 100644
--- a/hash.c
+++ b/hash.c
@@ -34,7 +34,7 @@ static void hash_init(struct hashtable_t *hash)
 }
 
 /* free only the hashtable and the hash itself. */
-void hash_destroy(struct hashtable_t *hash)
+void batadv_hash_destroy(struct hashtable_t *hash)
 {
 	kfree(hash->list_locks);
 	kfree(hash->table);
@@ -42,7 +42,7 @@ void hash_destroy(struct hashtable_t *hash)
 }
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(uint32_t size)
+struct hashtable_t *batadv_hash_new(uint32_t size)
 {
 	struct hashtable_t *hash;
 
diff --git a/hash.h b/hash.h
index 3d67ce4..e75df6b 100644
--- a/hash.h
+++ b/hash.h
@@ -43,14 +43,14 @@ struct hashtable_t {
 };
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(uint32_t size);
+struct hashtable_t *batadv_hash_new(uint32_t size);
 
 /* set class key for all locks */
 void batadv_hash_set_lock_class(struct hashtable_t *hash,
 				struct lock_class_key *key);
 
 /* free only the hashtable and the hash itself. */
-void hash_destroy(struct hashtable_t *hash);
+void batadv_hash_destroy(struct hashtable_t *hash);
 
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
@@ -77,7 +77,7 @@ static inline void hash_delete(struct hashtable_t *hash,
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 }
 
 /**
diff --git a/originator.c b/originator.c
index 5e2b4d4..4d00f0f 100644
--- a/originator.c
+++ b/originator.c
@@ -53,7 +53,7 @@ int originator_init(struct bat_priv *bat_priv)
 	if (bat_priv->orig_hash)
 		return 0;
 
-	bat_priv->orig_hash = hash_new(1024);
+	bat_priv->orig_hash = batadv_hash_new(1024);
 
 	if (!bat_priv->orig_hash)
 		goto err;
@@ -185,7 +185,7 @@ void originator_free(struct bat_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 }
 
 /* this function finds or creates an originator entry for the given
diff --git a/translation-table.c b/translation-table.c
index 60a2771..7ec2af5 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -183,7 +183,7 @@ static int tt_local_init(struct bat_priv *bat_priv)
 	if (bat_priv->tt_local_hash)
 		return 0;
 
-	bat_priv->tt_local_hash = hash_new(1024);
+	bat_priv->tt_local_hash = batadv_hash_new(1024);
 
 	if (!bat_priv->tt_local_hash)
 		return -ENOMEM;
@@ -531,7 +531,7 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 
 	bat_priv->tt_local_hash = NULL;
 }
@@ -541,7 +541,7 @@ static int tt_global_init(struct bat_priv *bat_priv)
 	if (bat_priv->tt_global_hash)
 		return 0;
 
-	bat_priv->tt_global_hash = hash_new(1024);
+	bat_priv->tt_global_hash = batadv_hash_new(1024);
 
 	if (!bat_priv->tt_global_hash)
 		return -ENOMEM;
@@ -1031,7 +1031,7 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 
 	bat_priv->tt_global_hash = NULL;
 }
diff --git a/vis.c b/vis.c
index 01d5da5..99f1931 100644
--- a/vis.c
+++ b/vis.c
@@ -889,7 +889,7 @@ int vis_init(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->vis_hash_lock);
 
-	bat_priv->vis_hash = hash_new(256);
+	bat_priv->vis_hash = batadv_hash_new(256);
 	if (!bat_priv->vis_hash) {
 		pr_err("Can't initialize vis_hash\n");
 		goto err;
-- 
1.7.10

