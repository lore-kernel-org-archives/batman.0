Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  1 Jun 2017 08:26:30 +0200
Message-Id: <20170601062632.4239-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] alfred: Check if tg hash was really
 initialized
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

The return value check after the tg_hash_new call must actually check the
return value and not some other datastructure.

Fixes: a7bc3d9a2b3f ("alfred: Cache the global translation table entries")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server.c b/server.c
index 1e358cf..9774281 100644
--- a/server.c
+++ b/server.c
@@ -232,7 +232,7 @@ static void update_server_info(struct globals *globals)
 
 	if (strcmp(globals->mesh_iface, "none") != 0) {
 		tg_hash = tg_hash_new(globals->mesh_iface);
-		if (!globals->data_hash) {
+		if (!tg_hash) {
 			fprintf(stderr, "Failed to create translation hash\n");
 			return;
 		}
-- 
2.11.0

