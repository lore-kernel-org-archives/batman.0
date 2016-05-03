Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  4 May 2016 06:23:44 +0800
Message-Id: <1462314230-16257-10-git-send-email-a@unstable.cc>
In-Reply-To: <1462314230-16257-1-git-send-email-a@unstable.cc>
References: <1462314230-16257-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 09/15] batman-adv: Fix kerneldoc for
	batadv_compare_claim
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 20b2fd9b3d72..60d33232bd10 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -120,7 +120,7 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 }
 
 /**
- * batadv_compare_backbone_gw - compare address and vid of two claims
+ * batadv_compare_claim - compare address and vid of two claims
  * @node: list node of the first entry to compare
  * @data2: pointer to the second claims
  *
-- 
2.8.2

