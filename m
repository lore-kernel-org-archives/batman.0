Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 29 Mar 2012 12:34:45 +0200
Message-Id: <1333017286-17417-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Initialize lockdep class keys
	for hashes
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

The hash for claim and backbone hash in the bridge loop avoidance code receive
the same key because they are getting initialized by hash_new with the same
key. Lockdep will create a backtrace when they are used recursively. This can
be avoided by reinitializing the key directly after the hash_new.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   11 +++++++++++
 hash.c                  |    9 +++++++++
 hash.h                  |    3 +++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 8a17a78..c74d8a2 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1124,6 +1124,14 @@ out:
 	bla_start_timer(bat_priv);
 }
 
+/* The hash for claim and backbone hash receive the same key because they
+ * are getting initialized by hash_new with the same key. Reinitializing
+ * them with to different keys to allow nested locking without generating
+ * lockdep warnings
+ */
+static struct lock_class_key claim_hash_lock_class_key;
+static struct lock_class_key backbone_hash_lock_class_key;
+
 /* initialize all bla structures */
 int bla_init(struct bat_priv *bat_priv)
 {
@@ -1158,6 +1166,9 @@ int bla_init(struct bat_priv *bat_priv)
 	bat_priv->claim_hash = hash_new(128);
 	bat_priv->backbone_hash = hash_new(32);
 
+	hash_set_lock_class(bat_priv->claim_hash, &claim_hash_lock_class_key);
+	hash_set_lock_class(bat_priv->backbone_hash, &backbone_hash_lock_class_key);
+
 	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
 		return -1;
 
diff --git a/hash.c b/hash.c
index 117687b..13d4597 100644
--- a/hash.c
+++ b/hash.c
@@ -69,3 +69,12 @@ free_hash:
 	kfree(hash);
 	return NULL;
 }
+
+void hash_set_lock_class(struct hashtable_t *hash, struct lock_class_key *key)
+{
+	uint32_t i;
+
+	for (i = 0 ; i < hash->size; i++) {
+		lockdep_set_class(&hash->list_locks[i], key);
+	}
+}
diff --git a/hash.h b/hash.h
index d4bd786..7bcb98f 100644
--- a/hash.h
+++ b/hash.h
@@ -45,6 +45,9 @@ struct hashtable_t {
 /* allocates and clears the hash */
 struct hashtable_t *hash_new(uint32_t size);
 
+/* set class key for all locks */
+void hash_set_lock_class(struct hashtable_t *hash, struct lock_class_key *key);
+
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash);
 
-- 
1.7.9.1

