Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:52 +0100
Message-Id: <1426333379-17777-8-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/14] alfred: Remove else and break after
	return
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hash.c | 3 +--
 main.c | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hash.c b/hash.c
index a53bb9c..87588cd 100644
--- a/hash.c
+++ b/hash.c
@@ -142,10 +142,9 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 					iter->bucket = (*iter->first_bucket);
 					iter->first_bucket = &hash->table[iter->index];
 					return iter;
-				} else {
-					iter->bucket = NULL;
 				}
 
+				iter->bucket = NULL;
 			}
 
 		} else if (iter->prev_bucket != NULL) {
diff --git a/main.c b/main.c
index 7ad4625..02553c0 100644
--- a/main.c
+++ b/main.c
@@ -265,19 +265,14 @@ int main(int argc, char *argv[])
 	switch (globals->clientmode) {
 	case CLIENT_NONE:
 		return alfred_server(globals);
-		break;
 	case CLIENT_REQUEST_DATA:
 		return alfred_client_request_data(globals);
-		break;
 	case CLIENT_SET_DATA:
 		return alfred_client_set_data(globals);
-		break;
 	case CLIENT_MODESWITCH:
 		return alfred_client_modeswitch(globals);
-		break;
 	case CLIENT_CHANGE_INTERFACE:
 		return alfred_client_change_interface(globals);
-		break;
 	}
 
 	return 0;
-- 
2.1.4

