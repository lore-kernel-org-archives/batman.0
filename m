Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Nov 2012 12:58:28 +0100
Message-Id: <1353931112-17392-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/5] batman-adv: Use common Jenkins Hash
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

Only the DAT code must use the old implementation because it is used as
distributed hash function which has to be common for all nodes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Removed special choose_tt function and instead also use jhash

 bridge_loop_avoidance.c |   20 ++++++--------------
 hash.h                  |   22 ----------------------
 main.h                  |    1 +
 originator.h            |   15 ++-------------
 vis.c                   |   15 ++-------------
 5 files changed, 11 insertions(+), 62 deletions(-)

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

