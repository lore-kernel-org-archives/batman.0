Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Mar 2014 11:33:04 +0100
Message-Id: <1395225186-18597-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1395225186-18597-1-git-send-email-sw@simonwunderlich.de>
References: <1395225186-18597-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint 2/3] batman-adv: fix neigh reference
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

When an interface is removed from batman-adv, the orig_ifinfo of a
orig_node may be removed without releasing the router first.
This will prevent the reference for the neighbor pointed at by the
orig_ifinfo->router to be released, and this leak may result in
reference leaks for the interface used by this neighbor. Fix that.

This is a regression introduced by
de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b ("batman-adv: split out router
from orig_node").

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 originator.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/originator.c b/originator.c
index 8539416..2fd6678 100644
--- a/originator.c
+++ b/originator.c
@@ -506,6 +506,8 @@ static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
 		batadv_hardif_free_ref_now(orig_ifinfo->if_outgoing);
 
+	if (orig_ifinfo->router)
+		batadv_neigh_node_free_ref_now(orig_ifinfo->router);
 	kfree(orig_ifinfo);
 }
 
-- 
1.7.10.4

