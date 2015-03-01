Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Mar 2015 09:46:18 +0100
Message-Id: <1425199578-6392-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Use common Jenkins Hash
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
Cc: Sven Eckelmann <sven@narfation.org>

An unoptimized version of the Jenkins one-at-a-time hash function is used and
partially copied all over the code wherever an hashtable is used. Instead the
optimized version shared between the whole kernel should be used to reduce code
duplication and use better optimized code.

Only the DAT code must use the old implementation because it is used as
distributed hash function which has to be common for all nodes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3: rebased on top of current master

 bridge_loop_avoidance.c | 16 ++++------------
 distributed-arp-table.c | 17 +++++++++++++++--
 hash.h                  | 22 ----------------------
 main.h                  |  1 +
 network-coding.c        | 10 ++--------
 originator.h            | 13 +------------
 translation-table.c     |  8 ++------
 7 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index ac4b96e..6927589 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -42,12 +42,8 @@ static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 	struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
 	uint32_t hash = 0;
 
-	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
-	hash = batadv_hash_bytes(hash, &claim->vid, sizeof(claim->vid));
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&claim->addr, sizeof(claim->addr), hash);
+	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
 
 	return hash % size;
 }
@@ -59,12 +55,8 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 	const struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
 	uint32_t hash = 0;
 
-	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
-	hash = batadv_hash_bytes(hash, &claim->vid, sizeof(claim->vid));
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&claim->addr, sizeof(claim->addr), hash);
+	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
 
 	return hash % size;
 }
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index aad022d..107ad62 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -206,9 +206,22 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
 {
 	uint32_t hash = 0;
 	const struct batadv_dat_entry *dat = data;
+	const unsigned char *key;
+	uint32_t i;
+
+	key = (const unsigned char *)&dat->ip;
+	for (i = 0; i < sizeof(dat->ip); i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
 
-	hash = batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
-	hash = batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));
+	key = (const unsigned char *)&dat->vid;
+	for (i = 0; i < sizeof(dat->vid); i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
 
 	hash += (hash << 3);
 	hash ^= (hash >> 11);
diff --git a/hash.h b/hash.h
index 539fc12..a1d0980 100644
--- a/hash.h
+++ b/hash.h
@@ -80,28 +80,6 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 }
 
 /**
- *	batadv_hash_bytes - hash some bytes and add them to the previous hash
- *	@hash: previous hash value
- *	@data: data to be hashed
- *	@size: number of bytes to be hashed
- *
- *	Returns the new hash value.
- */
-static inline uint32_t batadv_hash_bytes(uint32_t hash, const void *data,
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
index b6c9ece..4deacfd 100644
--- a/main.h
+++ b/main.h
@@ -174,6 +174,7 @@ enum batadv_uev_type {
 #include <linux/workqueue.h>	/* workqueue */
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/jhash.h>
 #include <net/sock.h>		/* struct sock */
 #include <net/addrconf.h>	/* ipv6 address stuff */
 #include <linux/ip.h>
diff --git a/network-coding.c b/network-coding.c
index 358e58c..d128c3b 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -453,14 +453,8 @@ static uint32_t batadv_nc_hash_choose(const void *data, uint32_t size)
 	const struct batadv_nc_path *nc_path = data;
 	uint32_t hash = 0;
 
-	hash = batadv_hash_bytes(hash, &nc_path->prev_hop,
-				 sizeof(nc_path->prev_hop));
-	hash = batadv_hash_bytes(hash, &nc_path->next_hop,
-				 sizeof(nc_path->next_hop));
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&nc_path->prev_hop, sizeof(nc_path->prev_hop), hash);
+	hash = jhash(&nc_path->next_hop, sizeof(nc_path->next_hop), hash);
 
 	return hash % size;
 }
diff --git a/originator.h b/originator.h
index aa4a436..a179c03 100644
--- a/originator.h
+++ b/originator.h
@@ -75,20 +75,9 @@ void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan);
  */
 static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 {
-	const unsigned char *key = data;
 	uint32_t hash = 0;
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
 
+	hash = jhash(data, ETH_ALEN, hash);
 	return hash % size;
 }
 
diff --git a/translation-table.c b/translation-table.c
index 07b263a..b20812b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -67,12 +67,8 @@ static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)
 	uint32_t hash = 0;
 
 	tt = (struct batadv_tt_common_entry *)data;
-	hash = batadv_hash_bytes(hash, &tt->addr, ETH_ALEN);
-	hash = batadv_hash_bytes(hash, &tt->vid, sizeof(tt->vid));
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
+	hash = jhash(&tt->addr, ETH_ALEN, hash);
+	hash = jhash(&tt->vid, sizeof(tt->vid), hash);
 
 	return hash % size;
 }
-- 
2.1.4

