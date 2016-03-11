Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 16:01:09 +0100
Message-Id: <1457708469-32047-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: init neigh node last seen
	field
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

From: Marek Lindner <mareklindner@neomailbox.ch>

Fixes: 58232977fbaf ("basic routing code complete (hases and ring buffer added) -> needs testing !")
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased patch

Patch was resurrected from https://patchwork.open-mesh.org/patch/4634/

I've requested an rebased version at
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014641.html
but done it myself because it was rather trivial.
---
 net/batman-adv/originator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e63d6a5..3ca98fc 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -663,6 +663,7 @@ batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
 	neigh_node->orig_node = orig_node;
+	neigh_node->last_seen = jiffies;
 
 	/* extra reference for return */
 	kref_init(&neigh_node->refcount);
-- 
2.7.0

