Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  8 May 2011 09:39:55 +0200
Message-Id: <1304840395-8898-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix line over 80 characters
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

160dd1399c4d589c0c5678a759e8ac7a7eefe64e introduced a line over 80 and
can not be accepted according to the Linux Coding Style.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 translation-table.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 2bd6a31..7b72966 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -505,7 +505,8 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	seq_printf(seq, "Globally announced TT entries received via the mesh %s\n",
+	seq_printf(seq,
+		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
 
 	spin_lock_bh(&bat_priv->tt_ghash_lock);
-- 
1.7.5.1

