Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:47 +0100
Message-Id: <1417519009-20699-30-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 29/31] batman-adv: Remove unnecessary ret
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Remove ret variable and all jumps.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/main.c b/main.c
index 2e2ad071a085..d67be132e5df 100644
--- a/main.c
+++ b/main.c
@@ -563,17 +563,14 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
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
2.1.3

