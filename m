Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 24 Apr 2014 03:41:26 +0800
Message-Id: <1398282086-3648-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2 next] batman-adv: fix NULL pointer
	dereferences
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---

Changes from v1:
- add next branch indication

 multicast.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/multicast.c b/multicast.c
index 8c7ca81..96b66fd 100644
--- a/multicast.c
+++ b/multicast.c
@@ -415,7 +415,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv4_list,
 				 mcast_want_all_ipv4_node) {
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
@@ -442,7 +442,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_ipv6_list,
 				 mcast_want_all_ipv6_node) {
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
@@ -493,7 +493,7 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_rcu(tmp_orig_node,
 				 &bat_priv->mcast.want_all_unsnoopables_list,
 				 mcast_want_all_unsnoopables_node) {
-		if (!atomic_inc_not_zero(&orig_node->refcount))
+		if (!atomic_inc_not_zero(&tmp_orig_node->refcount))
 			continue;
 
 		orig_node = tmp_orig_node;
-- 
2.0.0.rc0

