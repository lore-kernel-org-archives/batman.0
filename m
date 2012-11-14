Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 14 Nov 2012 10:53:48 +0100
Message-Id: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: pass value in batadv_hash_bytes
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Passing the hash value by reference creates unneeded overhead. Pass by
value instead.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |    8 ++++----
 hash.h                  |   12 ++++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index b6da6ae..fc56ea2 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -43,8 +43,8 @@ static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 	struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash = 0;
 
-	batadv_hash_bytes(&hash, &claim->addr, sizeof(claim->addr));
-	batadv_hash_bytes(&hash, &claim->vid, sizeof(claim->vid));
+	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
+	hash = batadv_hash_bytes(hash, &claim->vid, sizeof(claim->vid));
 
 	hash += (hash << 3);
 	hash ^= (hash >> 11);
@@ -60,8 +60,8 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 	struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash = 0;
 
-	batadv_hash_bytes(&hash, &claim->addr, sizeof(claim->addr));
-	batadv_hash_bytes(&hash, &claim->vid, sizeof(claim->vid));
+	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
+	hash = batadv_hash_bytes(hash, &claim->vid, sizeof(claim->vid));
 
 	hash += (hash << 3);
 	hash ^= (hash >> 11);
diff --git a/hash.h b/hash.h
index f173427..e053339 100644
--- a/hash.h
+++ b/hash.h
@@ -86,17 +86,21 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	@hash: previous hash value
  *	@data: data to be hashed
  *	@size: number of bytes to be hashed
+ *
+ *	Returns the new hash value.
  */
-static inline void batadv_hash_bytes(uint32_t *hash, void *data, uint32_t size)
+static inline uint32_t batadv_hash_bytes(uint32_t hash, void *data,
+					 uint32_t size)
 {
 	const unsigned char *key = data;
 	int i;
 
 	for (i = 0; i < size; i++) {
-		*hash += key[i];
-		*hash += (*hash << 10);
-		*hash ^= (*hash >> 6);
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
 	}
+	return hash;
 }
 
 /**
-- 
1.7.10

