Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Jun 2012 08:54:38 +0200
Message-Id: <1340607284-29950-15-git-send-email-ordex@autistici.org>
In-Reply-To: <1340607284-29950-1-git-send-email-ordex@autistici.org>
References: <1340607284-29950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 14/20] batman-adv: Prefix hash local static
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hash.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index e39f8f4..1fb961c 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
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
1.7.9.4

