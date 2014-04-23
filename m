Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 24 Apr 2014 03:46:30 +0800
Message-Id: <1398282390-4677-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix indirect hard_iface
	NULL dereference
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

If hard_iface is NULL and goto out is made batadv_hardif_free_ref()
doesn't check for NULL before dereferencing it to get to refcount.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 originator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/originator.c b/originator.c
index aa2468b..35b42f8 100644
--- a/originator.c
+++ b/originator.c
@@ -1074,7 +1074,8 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, hard_iface);
 
 out:
-	batadv_hardif_free_ref(hard_iface);
+	if (hard_iface)
+		batadv_hardif_free_ref(hard_iface);
 	return 0;
 }
 
-- 
2.0.0.rc0

