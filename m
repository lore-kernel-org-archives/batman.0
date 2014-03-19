Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Mar 2014 11:33:03 +0100
Message-Id: <1395225186-18597-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1395225186-18597-1-git-send-email-sw@simonwunderlich.de>
References: <1395225186-18597-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint 1/3] batman-adv: fix neigh_ifinfo
	imbalance
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The neigh_ifinfo object must be freed if it has been used in
batadv_iv_ogm_process_per_outif().

This is a regression introduced by
9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv: split tq
information in neigh_node struct")

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8323bce..d074d06 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
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
1.7.10.4

