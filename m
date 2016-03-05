Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:23 +0100
Message-Id: <1457190564-11419-8-git-send-email-sven@narfation.org>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Use kref_get for
	batadv_gw_node_add
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

batadv_gw_node_add requires that the caller already has a valid reference
for orig_node. It is therefore not possible that it has an reference
counter of 0 and was still given to this function

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index bb1c4f3..5839c56 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -440,15 +440,11 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (gateway->bandwidth_down == 0)
 		return;
 
-	if (!kref_get_unless_zero(&orig_node->refcount))
-		return;
-
 	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
-	if (!gw_node) {
-		batadv_orig_node_put(orig_node);
+	if (!gw_node)
 		return;
-	}
 
+	kref_get(&orig_node->refcount);
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
-- 
2.7.0

