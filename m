Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:14:08 +0200
Message-Id: <1433340848-1682-13-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
References: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 12/12] batman-adv: Remove unnecessary ret
	variable in algo_register
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

From: Markus Pargmann <mpa@pengutronix.de>

Remove ret variable and all jumps.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 49f07e1..548e405 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -544,17 +544,14 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
 {
 	struct batadv_algo_ops *bat_algo_ops;
-	int ret = -EINVAL;
 
 	bat_algo_ops = batadv_algo_get(name);
 	if (!bat_algo_ops)
-		goto out;
+		return -EINVAL;
 
 	bat_priv->bat_algo_ops = bat_algo_ops;
-	ret = 0;
 
-out:
-	return ret;
+	return 0;
 }
 
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
-- 
2.4.2

