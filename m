Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 15 Feb 2014 02:17:20 +0100
Message-Id: <1392427040-1614-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: avoid double free when
	orig_node initialization fails
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

In the failure path of the orig_node initialization routine
the orig_node->bat_iv.bcast_own field is free'd twice: first
in batadv_iv_ogm_orig_get() and then later in
batadv_orig_node_free_rcu().

Fix it by removing the kfree in batadv_iv_ogm_orig_get().

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

Change form v1:
- remove kfree from batadv_iv_ogm_orig_get() instead of setting
  orig_node->bat_iv.bcast_own to NULL


 bat_iv_ogm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index c07e59f..fdf4322 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -243,18 +243,16 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bat_iv.bcast_own_sum = kzalloc(size, GFP_ATOMIC);
 	if (!orig_node->bat_iv.bcast_own_sum)
-		goto free_bcast_own;
+		goto free_orig_node;
 
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
-		goto free_bcast_own;
+		goto free_orig_node;
 
 	return orig_node;
 
-free_bcast_own:
-	kfree(orig_node->bat_iv.bcast_own);
 free_orig_node:
 	/* free twice, as batadv_orig_node_new sets refcount to 2 */
 	batadv_orig_node_free_ref(orig_node);
-- 
1.8.5.3

