Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 22 Nov 2013 13:30:25 +0100
Message-Id: <1385123427-15460-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
References: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: silence uninitialized
	variable warning
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

sparse (at least the version of the build checker) is complaining about:

routing.c: In function 'batadv_find_router':
routing.c:431:28: warning: 'next_candidate_router' may be used
uninitialized in this function [-Wmaybe-uninitialized]

Although this is bogus, silencing is not expensive and is done by this
patch.

Introduced by 797edd9e87ac838711e03498a4ae795b600191af
("batman-adv: add bonding again")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 routing.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/routing.c b/routing.c
index 69620e0..23311f5 100644
--- a/routing.c
+++ b/routing.c
@@ -428,7 +428,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 {
 	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct batadv_neigh_node *first_candidate_router = NULL;
-	struct batadv_neigh_node *next_candidate_router;
+	struct batadv_neigh_node *next_candidate_router = NULL;
 	struct batadv_neigh_node *router, *cand_router = NULL;
 	struct batadv_orig_ifinfo *cand, *first_candidate = NULL;
 	struct batadv_orig_ifinfo *next_candidate = NULL;
-- 
1.7.10.4

