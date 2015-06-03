Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:14:07 +0200
Message-Id: <1433340848-1682-12-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
References: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 11/12] batman-adv: Remove unnecessary ret
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Markus Pargmann <mpa@pengutronix.de>

We can avoid this indirect return variable by directly returning the
error values.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a22247a..49f07e1 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -513,14 +513,12 @@ static struct batadv_algo_ops *batadv_algo_get(char *name)
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
@@ -534,16 +532,13 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
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
2.4.2

