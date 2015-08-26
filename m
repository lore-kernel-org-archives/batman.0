Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 26 Aug 2015 10:31:50 +0200
Message-Id: <1440577911-16107-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Use chain pointer when
	purging fragments
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

The chain pointer was already created in batadv_frag_purge_orig to make the
checks more readable. Just use the chain pointer everywhere instead of
having the same dereference + array access in the most lines of this
function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 700c96c82a15..20d9282f895b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -71,14 +71,14 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
 
 	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
 		chain = &orig_node->fragments[i];
-		spin_lock_bh(&orig_node->fragments[i].lock);
+		spin_lock_bh(&chain->lock);
 
 		if (!check_cb || check_cb(chain)) {
-			batadv_frag_clear_chain(&orig_node->fragments[i].head);
-			orig_node->fragments[i].size = 0;
+			batadv_frag_clear_chain(&chain->head);
+			chain->size = 0;
 		}
 
-		spin_unlock_bh(&orig_node->fragments[i].lock);
+		spin_unlock_bh(&chain->lock);
 	}
 }
 
-- 
2.5.0

