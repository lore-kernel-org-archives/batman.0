Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jun 2012 16:21:43 +0200
Message-Id: <1339942903-27681-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove space before semicolon
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
This one is for next... thx

 hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hash.c b/hash.c
index 2b16381..0759c70 100644
--- a/hash.c
+++ b/hash.c
@@ -73,6 +73,6 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 {
 	uint32_t i;
 
-	for (i = 0 ; i < hash->size; i++)
+	for (i = 0; i < hash->size; i++)
 		lockdep_set_class(&hash->list_locks[i], key);
 }
-- 
1.7.10

