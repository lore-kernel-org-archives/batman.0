Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:33 +0100
Message-Id: <1419594103-10928-17-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 16/26] batman-adv: iv_ogm_orig_update,
	style, add missin brackets
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

CodingStyle describes that either none or both branches of a conditional
have to have brackets.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8e29772ad8ae..32640e0997ed 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
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
2.1.3

