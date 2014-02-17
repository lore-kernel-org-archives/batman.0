Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:48 +0100
Message-Id: <1392670129-2498-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] batman-adv: avoid double free when
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

In the failure path of the orig_node initialization routine
the orig_node->bat_iv.bcast_own field is free'd twice: first
in batadv_iv_ogm_orig_get() and then later in
batadv_orig_node_free_rcu().

Fix it by removing the kfree in batadv_iv_ogm_orig_get().

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 42cbc0a..8323bce 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -241,18 +241,16 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
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

