Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Nov 2012 19:23:27 +0100
Message-Id: <1353867811-8452-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Use common Jenkins Hash
	implementation
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

An unoptimized version of the Jenkins one-at-a-time hash function is copied all
over the code wherever an hashtable is used. Instead the optimized version
shared between the whole kernel should be used to reduce code duplication and
keep bugs at a single point.

Only the TT and DAT code must use the old implementation to guarantee the same
distribution of the elements in the hash. The TT code needs it because the CRC
exchanged between the mesh nodes is computed over the entries in the hash. The
order depends on the buckets chosen by the hash. The DAT code needs it because
it is used as distributed hash function which has to be common for all nodes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   20 ++++++--------------
 hash.h                  |   22 ----------------------
 main.h                  |    1 +
 originator.h            |   15 ++-------------
 translation-table.c     |   32 ++++++++++++++++++++++++++++----
 vis.c                   |   15 ++-------------
 6 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index ec12c79..1400274 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -41,14 +41,10 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 {
 	struct batadv_claim *claim = (struct batadv_claim *)data;
-	uint32_t hash = 0;
+	uint32_t hash;
 
-	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
-	hash = batadv_hash_bytes(hash, &claim->vid, sizeof(claim->vid));
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&claim->addr, sizeof(claim->addr), 0);
+	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
 
 	return hash % size;
 }
@@ -58,14 +54,10 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 						 uint32_t size)
 {
 	struct batadv_claim *claim = (struct batadv_claim *)data;
-	uint32_t hash = 0;
+	uint32_t hash;
 
-	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
-	hash = batadv_hash_bytes(hash, &claim->vid, sizeof(claim->vid));
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&claim->addr, sizeof(claim->addr), 0);
+	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
 
 	return hash % size;
 }
diff --git a/hash.h b/hash.h
index e053339..977de9c 100644
--- a/hash.h
+++ b/hash.h
@@ -82,28 +82,6 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 }
 
 /**
- *	batadv_hash_bytes - hash some bytes and add them to the previous hash
- *	@hash: previous hash value
- *	@data: data to be hashed
- *	@size: number of bytes to be hashed
- *
- *	Returns the new hash value.
- */
-static inline uint32_t batadv_hash_bytes(uint32_t hash, void *data,
-					 uint32_t size)
-{
-	const unsigned char *key = data;
-	int i;
-
-	for (i = 0; i < size; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-	return hash;
-}
-
-/**
  *	batadv_hash_add - adds data to the hashtable
  *	@hash: storage hash table
  *	@compare: callback to determine if 2 hash elements are identical
diff --git a/main.h b/main.h
index 2032de2..f58e373 100644
--- a/main.h
+++ b/main.h
@@ -147,6 +147,7 @@ enum batadv_uev_type {
 #include <linux/workqueue.h>	/* workqueue */
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/jhash.h>
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
diff --git a/originator.h b/originator.h
index 9778e65..1311d39 100644
--- a/originator.h
+++ b/originator.h
@@ -46,20 +46,9 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
  */
 static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 {
-	const unsigned char *key = data;
-	uint32_t hash = 0;
-	size_t i;
-
-	for (i = 0; i < 6; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	uint32_t hash;
 
+	hash = jhash(data, ETH_ALEN, 0);
 	return hash % size;
 }
 
diff --git a/translation-table.c b/translation-table.c
index 1335294..86f8f82 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -48,6 +48,30 @@ static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
+/**
+ * batadv_choose_tt - Calculate hash value for a translation table entry
+ * @data: translation table entry
+ * @size: size of the translation table hash
+ */
+static uint32_t batadv_choose_tt(const void *data, uint32_t size)
+{
+	const unsigned char *key = data;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 0; i < 6; i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
 static void batadv_tt_start_timer(struct batadv_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->tt.work, batadv_tt_purge);
@@ -67,7 +91,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, hash->size);
+	index = batadv_choose_tt(data, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -247,7 +271,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr, message);
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
-			   batadv_choose_orig, tt_global->common.addr);
+			   batadv_choose_tt, tt_global->common.addr);
 	batadv_tt_global_entry_free_ref(tt_global);
 
 }
@@ -321,7 +345,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_orig, &tt_local->common,
+				     batadv_choose_tt, &tt_local->common,
 				     &tt_local->common.hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -840,7 +864,7 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
 					     batadv_compare_tt,
-					     batadv_choose_orig, common,
+					     batadv_choose_tt, common,
 					     &common->hash_entry);
 
 		if (unlikely(hash_added != 0)) {
diff --git a/vis.c b/vis.c
index 0f65a9d..2eb6878 100644
--- a/vis.c
+++ b/vis.c
@@ -72,21 +72,10 @@ static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
 {
 	const struct batadv_vis_info *vis_info = data;
 	const struct batadv_vis_packet *packet;
-	const unsigned char *key;
-	uint32_t hash = 0;
-	size_t i;
+	uint32_t hash;
 
 	packet = (struct batadv_vis_packet *)vis_info->skb_packet->data;
-	key = packet->vis_orig;
-	for (i = 0; i < ETH_ALEN; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&packet->vis_orig, sizeof(packet->vis_orig), 0);
 
 	return hash % size;
 }
-- 
1.7.10.4

