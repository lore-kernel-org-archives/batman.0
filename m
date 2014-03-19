Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Mar 2014 13:19:31 +0100
Message-Id: <1395231571-15746-1-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <53298849.5060104@meshcoding.com>
References: <53298849.5060104@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH-maintv2 3/3] batman-adv: always run
	purge_orig_neighbors
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

The current code will not execute batadv_purge_orig_neighbors() when an
orig_ifinfo has already been purged. However we need to run it in any
case. Fix that.

This is a regression introduced by
de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b ("batman-adv: split out router
from orig_node")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCHv1:

 * check two change variables separately
---
 originator.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/originator.c b/originator.c
index 2fd6678..9e29f02 100644
--- a/originator.c
+++ b/originator.c
@@ -854,7 +854,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
-	bool changed;
+	bool changed_ifinfo, changed_neigh;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -864,10 +864,10 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 			   jiffies_to_msecs(orig_node->last_seen));
 		return true;
 	}
-	changed = batadv_purge_orig_ifinfo(bat_priv, orig_node);
-	changed = changed || batadv_purge_orig_neighbors(bat_priv, orig_node);
+	changed_ifinfo = batadv_purge_orig_ifinfo(bat_priv, orig_node);
+	changed_neigh = batadv_purge_orig_neighbors(bat_priv, orig_node);
 
-	if (!changed)
+	if (!changed_ifinfo && !changed_neigh)
 		return false;
 
 	/* first for NULL ... */
-- 
1.7.10.4

