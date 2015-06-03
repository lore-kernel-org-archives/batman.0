Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:13:59 +0200
Message-Id: <1433340848-1682-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
References: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 03/12] batman-adv: iv_ogm_orig_update, style,
	add missing brackets
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

CodingStyle describes that either none or both branches of a conditional
have to have brackets.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 159f30a..66ac9e8 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1032,9 +1032,10 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		batadv_orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
-	} else
+	} else {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Updating existing last-hop neighbor of originator\n");
+	}
 
 	rcu_read_unlock();
 	neigh_ifinfo = batadv_neigh_ifinfo_new(neigh_node, if_outgoing);
-- 
2.4.2

