Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  1 Jun 2017 08:26:31 +0200
Message-Id: <20170601062632.4239-2-sven@narfation.org>
In-Reply-To: <20170601062632.4239-1-sven@narfation.org>
References: <20170601062632.4239-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] alfred: Always initialize orig cache
 hash pointer
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
accessing the uninitialized pointer to the originator cache.

Fixes: e50d18c39f92 ("alfred: Cache the TQ values for each originator")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server.c b/server.c
index 9774281..e7f691c 100644
--- a/server.c
+++ b/server.c
@@ -224,7 +224,7 @@ static void update_server_info(struct globals *globals)
 	struct interface *interface;
 	struct ether_addr *macaddr;
 	struct hashtable_t *tg_hash;
-	struct hashtable_t *orig_hash;
+	struct hashtable_t *orig_hash = NULL;
 
 	/* TQ is not used for master sync mode */
 	if (globals->opmode == OPMODE_MASTER)
-- 
2.11.0

