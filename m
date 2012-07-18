Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Jul 2012 09:07:07 +0200
Message-Id: <1342595227-8072-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix wrong multiline comment
	ending
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

This regression was introduced in 724d05c8215e4e8186097121595ef20b6ba601b7

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 translation-table.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 172d50b..37ae4a9 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -688,7 +688,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	orig_entry = batadv_tt_global_orig_entry_find(tt_global, orig_node);
 	if (orig_entry) {
 		/* refresh the ttvn: the current value could be a bogus one that
-		 * was added during a "temporary client detection" */
+		 * was added during a "temporary client detection"
+		 */
 		orig_entry->ttvn = ttvn;
 		goto out;
 	}
-- 
1.7.10.4

