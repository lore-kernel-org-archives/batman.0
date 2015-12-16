Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 16 Dec 2015 15:49:31 +0800
Message-Id: <1450252173-20949-11-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
References: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/12] batman-adv: Use chain pointer when
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The chain pointer was already created in batadv_frag_purge_orig to make the
checks more readable. Just use the chain pointer everywhere instead of
having the same dereference + array access in the most lines of this
function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/fragmentation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 700c96c..20d9282 100644
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
2.6.4

