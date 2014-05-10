Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 10 May 2014 17:35:08 +0200
Message-Id: <1399736110-22333-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1399736110-22333-1-git-send-email-antonio@meshcoding.com>
References: <1399736110-22333-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: fix neigh reference imbalance
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, Simon Wunderlich <simon@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <simon@open-mesh.com>

When an interface is removed from batman-adv, the orig_ifinfo of a
orig_node may be removed without releasing the router first.
This will prevent the reference for the neighbor pointed at by the
orig_ifinfo->router to be released, and this leak may result in
reference leaks for the interface used by this neighbor. Fix that.

This is a regression introduced by
7351a4822d42827ba0110677c0cbad88a3d52585
("batman-adv: split out router from orig_node").

Reported-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/originator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ffd9dfb..a43da69 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -501,12 +501,17 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 {
 	struct batadv_orig_ifinfo *orig_ifinfo;
+	struct batadv_neigh_node *router;
 
 	orig_ifinfo = container_of(rcu, struct batadv_orig_ifinfo, rcu);
 
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
 		batadv_hardif_free_ref_now(orig_ifinfo->if_outgoing);
 
+	/* this is the last reference to this object */
+	router = rcu_dereference_protected(orig_ifinfo->router, true);
+	if (router)
+		batadv_neigh_node_free_ref_now(router);
 	kfree(orig_ifinfo);
 }
 
-- 
1.8.5.5

