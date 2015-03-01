Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Mar 2015 16:56:26 +0100
Message-Id: <1425225386-19712-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unnecessary check for
	orig_ifinfo == NULL
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
Cc: Sven Eckelmann <sven@narfation.org>

orig_ifinfo is dereferenced multiple times in batadv_iv_ogm_update_seqnos
before the check for NULL is done. The function also exists at the beginning
when orig_ifinfo would have been NULL. This makes the check at the end
unnecessary and only confuses the reader/code analyzers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 554e0e0..04bd220 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1357,8 +1357,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	batadv_orig_node_free_ref(orig_node);
-	if (orig_ifinfo)
-		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	batadv_orig_ifinfo_free_ref(orig_ifinfo);
 	return ret;
 }
 
-- 
2.1.4

