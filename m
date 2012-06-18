Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 22:39:12 +0200
Message-Id: <1340051963-14836-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/19] batman-adv: return added entries
	instead of number of possibly added entries
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/translation-table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ca53542..f9675b7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -319,7 +319,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	}
 	spin_unlock_bh(&bat_priv->tt_buff_lock);
 
-	return tot_changes;
+	return count;
 }
 
 int tt_local_seq_print_text(struct seq_file *seq, void *offset)
-- 
1.7.9.4

