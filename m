Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 25 Aug 2015 13:02:39 +0200
Message-Id: <1440500559-28368-16-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
References: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 15/15] batman-adv: beautify supported routing
	algorithm list
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

From: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 50fc07b..e61c5f3 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -584,7 +584,7 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 	seq_puts(seq, "Available routing algorithms:\n");
 
 	hlist_for_each_entry(bat_algo_ops, &batadv_algo_list, list) {
-		seq_printf(seq, "%s\n", bat_algo_ops->name);
+		seq_printf(seq, " * %s\n", bat_algo_ops->name);
 	}
 
 	return 0;
-- 
2.5.0

