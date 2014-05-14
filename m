Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 14 May 2014 14:23:15 +0200
Message-Id: <1400070195-26148-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typ0 in kerneldoc and comment
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by 9b9cdbe28e2b9c8bdf9c761f22ba9655963d13d4
("batman-adv: fix removing neigh_ifinfo")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 originator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/originator.c b/originator.c
index 9ebc40e..abf612d 100644
--- a/originator.c
+++ b/originator.c
@@ -704,7 +704,7 @@ free_orig_node:
 /**
  * batadv_purge_neigh_ifinfo - purge obsolete ifinfo entries from neighbor
  * @bat_priv: the bat priv with all the soft interface information
- * @neigh_node: orig node which is to be checked
+ * @neigh: orig node which is to be checked
  */
 static void
 batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
@@ -842,7 +842,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			hlist_del_rcu(&neigh_node->list);
 			batadv_neigh_node_free_ref(neigh_node);
 		} else {
-			/* only neccesary if not the whole neighbor is to be
+			/* only necessary if not the whole neighbor is to be
 			 * deleted, but some interface has been removed.
 			 */
 			batadv_purge_neigh_ifinfo(bat_priv, neigh_node);
-- 
1.8.5.5

