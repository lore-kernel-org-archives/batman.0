Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 18:33:58 +0200
Message-Id: <1336840447-6580-9-git-send-email-sven@narfation.org>
In-Reply-To: <1336840447-6580-1-git-send-email-sven@narfation.org>
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/18] batman-adv: Prefix hash local static
	functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hash.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hash.c b/hash.c
index 42466c2..4ab46d4 100644
--- a/hash.c
+++ b/hash.c
@@ -21,7 +21,7 @@
 #include "hash.h"
 
 /* clears the hash */
-static void hash_init(struct hashtable_t *hash)
+static void batadv_hash_init(struct hashtable_t *hash)
 {
 	uint32_t i;
 
@@ -58,7 +58,7 @@ struct hashtable_t *batadv_hash_new(uint32_t size)
 		goto free_table;
 
 	hash->size = size;
-	hash_init(hash);
+	batadv_hash_init(hash);
 	return hash;
 
 free_table:
-- 
1.7.10

