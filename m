Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jun 2012 16:27:22 +0200
Message-Id: <1339943242-29741-1-git-send-email-sven@narfation.org>
In-Reply-To: <1339942903-27681-1-git-send-email-sven@narfation.org>
References: <1339942903-27681-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Remove space before semicolon
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

This cleanup is for next

 bridge_loop_avoidance.c |    2 +-
 hash.c                  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 38aab1e..49e10d9 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1222,7 +1222,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	/* calculate the crc ... */
 	crc = crc16(0, content, length);
 
-	for (i = 0 ; i < BATADV_DUPLIST_SIZE; i++) {
+	for (i = 0; i < BATADV_DUPLIST_SIZE; i++) {
 		curr = (bat_priv->bcast_duplist_curr + i) % BATADV_DUPLIST_SIZE;
 		entry = &bat_priv->bcast_duplist[curr];
 
diff --git a/hash.c b/hash.c
index 2b16381..15a849c 100644
--- a/hash.c
+++ b/hash.c
@@ -25,7 +25,7 @@ static void batadv_hash_init(struct batadv_hashtable *hash)
 {
 	uint32_t i;
 
-	for (i = 0 ; i < hash->size; i++) {
+	for (i = 0; i < hash->size; i++) {
 		INIT_HLIST_HEAD(&hash->table[i]);
 		spin_lock_init(&hash->list_locks[i]);
 	}
@@ -73,6 +73,6 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 {
 	uint32_t i;
 
-	for (i = 0 ; i < hash->size; i++)
+	for (i = 0; i < hash->size; i++)
 		lockdep_set_class(&hash->list_locks[i], key);
 }
-- 
1.7.10

