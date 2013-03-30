Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 30 Mar 2013 15:49:27 +0100
Message-Id: <1364654967-25455-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: do not silently ignore wrong
	condition
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

Only one neigh_node per orig_node should match a given
neighbor address, therefore, if more than one matching
neigh_node is found, a WARNING has to be triggered to let
the user know that something is wrong in the originator
state instead of silently skipping the error.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 38183dc..9fbf588 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -669,7 +669,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
 		    tmp_neigh_node->if_incoming == if_incoming &&
 		    atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
-			if (neigh_node)
+			if (WARN(neigh_node, "too many matching neigh_nodes")
 				batadv_neigh_node_free_ref(neigh_node);
 			neigh_node = tmp_neigh_node;
 			continue;
-- 
1.8.1.5

