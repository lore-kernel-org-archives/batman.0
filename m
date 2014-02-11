Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 20:00:35 +0100
Message-Id: <1392145235-3914-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: avoid double free when
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
a double free is hit because orig_node->bat_iv.bcast_own is
not set to NULL after being free'd.

Fix it by setting bcast_own to NULL after having free'd it.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 bat_iv_ogm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index c07e59f..cb4c18a 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -255,6 +255,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 
 free_bcast_own:
 	kfree(orig_node->bat_iv.bcast_own);
+	/* make it NULL to avoid second free in batadv_iv_ogm_orig_free() */
+	orig_node->bat_iv.bcast_own = NULL;
 free_orig_node:
 	/* free twice, as batadv_orig_node_new sets refcount to 2 */
 	batadv_orig_node_free_ref(orig_node);
-- 
1.8.5.3

