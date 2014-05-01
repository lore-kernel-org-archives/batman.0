Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri,  2 May 2014 00:16:05 +0200
Message-Id: <1398982565-21171-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: increase orig refcount
	when storing ref in gw_node
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

A pointer to the orig_node representing a bat-gateway is
stored in the gw_node->orig_node member, but the refcount
for such orig_node is never increased.
This leads to memory faults when gw_node->orig_node is accessed
and the originator has already been freed.

Fix this by increasing the refcount on gw_node creation
and decreasing it on gw_node free.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 gateway_client.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gateway_client.c b/gateway_client.c
index d7fafc1..cfaa2fc 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -42,8 +42,10 @@
 
 static void batadv_gw_node_free_ref(struct batadv_gw_node *gw_node)
 {
-	if (atomic_dec_and_test(&gw_node->refcount))
+	if (atomic_dec_and_test(&gw_node->refcount)) {
+		batadv_orig_node_free_ref(gw_node->orig_node);
 		kfree_rcu(gw_node, rcu);
+	}
 }
 
 static struct batadv_gw_node *
@@ -406,6 +408,9 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 	if (gateway->bandwidth_down == 0)
 		return;
 
+	if (!atomic_inc_not_zero(&orig_node->refcount))
+		return;
+
 	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
 	if (!gw_node)
 		return;
-- 
1.8.3.2

