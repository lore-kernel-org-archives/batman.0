Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  1 Jun 2017 08:26:32 +0200
Message-Id: <20170601062632.4239-3-sven@narfation.org>
In-Reply-To: <20170601062632.4239-1-sven@narfation.org>
References: <20170601062632.4239-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] alfred: Always initialize translation
 cache hash pointer
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

The initialization of the cache can be disabled when mesh interface is
"none". We must therefore make sure that the remaining code is not
accessing the uninitialized pointer to the translation cache.

Fixes: a7bc3d9a2b3f ("alfred: Cache the global translation table entries")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server.c b/server.c
index e7f691c..b6f0812 100644
--- a/server.c
+++ b/server.c
@@ -223,7 +223,7 @@ static void update_server_info(struct globals *globals)
 	struct hash_it_t *hashit = NULL;
 	struct interface *interface;
 	struct ether_addr *macaddr;
-	struct hashtable_t *tg_hash;
+	struct hashtable_t *tg_hash = NULL;
 	struct hashtable_t *orig_hash = NULL;
 
 	/* TQ is not used for master sync mode */
-- 
2.11.0

