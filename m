Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 23 Apr 2012 16:32:55 +0800
Message-Id: <1335169975-6485-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: return added entries instead of
	number of possibly added entries
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 translation-table.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index f8f207a..88c62f1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -319,7 +319,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	}
 	spin_unlock_bh(&bat_priv->tt_buff_lock);
 
-	return tot_changes;
+	return count;
 }
 
 int tt_local_seq_print_text(struct seq_file *seq, void *offset)
-- 
1.7.9.1

