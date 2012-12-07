Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  7 Dec 2012 14:35:36 +0100
Message-Id: <1354887336-17257-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use the const qualifier in hash
	functions
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The data argument in each hash function should carry the
"const" qualifier as it is never modified.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bridge_loop_avoidance.c | 2 +-
 hash.h                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 724adf0..5e834c1 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -57,7 +57,7 @@ static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 static inline uint32_t batadv_choose_backbone_gw(const void *data,
 						 uint32_t size)
 {
-	struct batadv_claim *claim = (struct batadv_claim *)data;
+	const struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash = 0;
 
 	hash = batadv_hash_bytes(hash, &claim->addr, sizeof(claim->addr));
diff --git a/hash.h b/hash.h
index e053339..ea02148 100644
--- a/hash.h
+++ b/hash.h
@@ -89,7 +89,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *
  *	Returns the new hash value.
  */
-static inline uint32_t batadv_hash_bytes(uint32_t hash, void *data,
+static inline uint32_t batadv_hash_bytes(uint32_t hash, const void *data,
 					 uint32_t size)
 {
 	const unsigned char *key = data;
-- 
1.8.0

