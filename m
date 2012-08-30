Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 30 Aug 2012 18:22:27 +0200
Message-Id: <1346343747-4010-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't rely on positions in
	struct for hashing
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

The hash functions in the bridge loop avoidance code expects the
VLAN vid to be right after the mac address, but this is not guaranteed.

Fix this by explicitly hashing over the right fields of the struct.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0921509..7e62c79 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -37,18 +37,26 @@ static void batadv_bla_periodic_work(struct work_struct *work);
 static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 				     struct batadv_backbone_gw *backbone_gw);
 
+static inline void hash_bytes(uint32_t *hash, void *data, uint32_t size)
+{
+	const unsigned char *key = data;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		*hash += key[i];
+		*hash += (*hash << 10);
+		*hash ^= (*hash >> 6);
+	}
+}
+
 /* return the index of the claim */
 static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 {
-	const unsigned char *key = data;
+	struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash = 0;
-	size_t i;
 
-	for (i = 0; i < ETH_ALEN + sizeof(short); i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
+	hash_bytes(&hash, &claim->addr, sizeof(claim->addr));
+	hash_bytes(&hash, &claim->vid, sizeof(claim->vid));
 
 	hash += (hash << 3);
 	hash ^= (hash >> 11);
@@ -61,15 +69,11 @@ static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 static inline uint32_t batadv_choose_backbone_gw(const void *data,
 						 uint32_t size)
 {
-	const unsigned char *key = data;
+	struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash = 0;
-	size_t i;
 
-	for (i = 0; i < ETH_ALEN + sizeof(short); i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
+	hash_bytes(&hash, &claim->addr, sizeof(claim->addr));
+	hash_bytes(&hash, &claim->vid, sizeof(claim->vid));
 
 	hash += (hash << 3);
 	hash ^= (hash >> 11);
-- 
1.7.10

