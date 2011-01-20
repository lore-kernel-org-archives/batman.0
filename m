Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 20 Jan 2011 06:22:55 +0100
Message-Id: <1295500975-3884-2-git-send-email-sven@narfation.org>
In-Reply-To: <1295500975-3884-1-git-send-email-sven@narfation.org>
References: <1295500975-3884-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Silence checkpatch warnings
	about spinlocks
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/hash.h       |    4 ++--
 batman-adv/originator.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index d47735c..a975e07 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -70,7 +70,7 @@ static inline void hash_delete(struct hashtable_t *hash,
 	struct hlist_head *head;
 	struct hlist_node *walk, *safe;
 	struct element_t *bucket;
-	spinlock_t *list_lock;
+	spinlock_t *list_lock; /* spinlock to protect write access */
 	int i;
 
 	for (i = 0; i < hash->size; i++) {
@@ -100,7 +100,7 @@ static inline int hash_add(struct hashtable_t *hash,
 	struct hlist_head *head;
 	struct hlist_node *walk, *safe;
 	struct element_t *bucket;
-	spinlock_t *list_lock;
+	spinlock_t *list_lock; /* spinlock to protect write access */
 
 	if (!hash)
 		goto err;
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 5a6745f..cf2ec37 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -150,7 +150,7 @@ void originator_free(struct bat_priv *bat_priv)
 	struct hlist_node *walk, *safe;
 	struct hlist_head *head;
 	struct element_t *bucket;
-	spinlock_t *list_lock;
+	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct orig_node *orig_node;
 	int i;
 
@@ -353,7 +353,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 	struct hlist_node *walk, *safe;
 	struct hlist_head *head;
 	struct element_t *bucket;
-	spinlock_t *list_lock;
+	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct orig_node *orig_node;
 	int i;
 
-- 
1.7.2.3

