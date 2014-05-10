Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 10 May 2014 17:35:07 +0200
Message-Id: <1399736110-22333-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1399736110-22333-1-git-send-email-antonio@meshcoding.com>
References: <1399736110-22333-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: fix neigh_ifinfo imbalance
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

The neigh_ifinfo object must be freed if it has been used in
batadv_iv_ogm_process_per_outif().

This is a regression introduced by
89652331c00f43574515059ecbf262d26d885717
("batman-adv: split tq information in neigh_node struct")

Reported-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b3bd4ec..f04224c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1545,6 +1545,8 @@ out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
 		batadv_orig_node_free_ref(orig_neigh_node);
 out:
+	if (router_ifinfo)
+		batadv_neigh_ifinfo_free_ref(router_ifinfo);
 	if (router)
 		batadv_neigh_node_free_ref(router);
 	if (router_router)
-- 
1.8.5.5

