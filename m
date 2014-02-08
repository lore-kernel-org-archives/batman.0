Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat,  8 Feb 2014 16:45:06 +0100
Message-Id: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential orig_node
	reference leak
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

Since batadv_orig_node_new() sets the refcount to two, assuming that
the calling function will use a reference for putting the orig_node into
a hash or similar, both references must be freed if initialization of
the orig_node fails. Otherwise that object may be leaked in that error
case.

Reported-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 bat_iv_ogm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 6f4fcdc..6000337 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -256,6 +256,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 free_bcast_own:
 	kfree(orig_node->bat_iv.bcast_own);
 free_orig_node:
+	/* free twice, as batadv_orig_node_new set refcount to 2 */
+	batadv_orig_node_free_ref(orig_node);
 	batadv_orig_node_free_ref(orig_node);
 
 	return NULL;
-- 
1.7.10.4

