Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:46 +0100
Message-Id: <1417519009-20699-29-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 28/31] batman-adv: Remove unnecessary ret
	variable
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

We can avoid this indirect return variable by directly returning the
error values.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/main.c b/main.c
index d5c79ae1db6f..2e2ad071a085 100644
--- a/main.c
+++ b/main.c
@@ -532,14 +532,12 @@ static struct batadv_algo_ops *batadv_algo_get(char *name)
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 {
 	struct batadv_algo_ops *bat_algo_ops_tmp;
-	int ret;
 
 	bat_algo_ops_tmp = batadv_algo_get(bat_algo_ops->name);
 	if (bat_algo_ops_tmp) {
 		pr_info("Trying to register already registered routing algorithm: %s\n",
 			bat_algo_ops->name);
-		ret = -EEXIST;
-		goto out;
+		return -EEXIST;
 	}
 
 	/* all algorithms must implement all ops (for now) */
@@ -553,16 +551,13 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_neigh_is_equiv_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	INIT_HLIST_NODE(&bat_algo_ops->list);
 	hlist_add_head(&bat_algo_ops->list, &batadv_algo_list);
-	ret = 0;
 
-out:
-	return ret;
+	return 0;
 }
 
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
-- 
2.1.3

