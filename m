Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2011 11:17:40 +0200
Message-Id: <1305019060-26731-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use kzalloc rather than kmalloc
	followed by memset with 0
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateway_client.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 65f3953..e638841 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -281,11 +281,10 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	struct gw_node *gw_node;
 	int down, up;
 
-	gw_node = kmalloc(sizeof(struct gw_node), GFP_ATOMIC);
+	gw_node = kzalloc(sizeof(struct gw_node), GFP_ATOMIC);
 	if (!gw_node)
 		return;
 
-	memset(gw_node, 0, sizeof(struct gw_node));
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
 	atomic_set(&gw_node->refcount, 1);
-- 
1.7.5.1

