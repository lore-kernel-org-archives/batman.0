Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Feb 2017 17:16:40 +0100
Message-Id: <20170222161642.22899-2-sven@narfation.org>
In-Reply-To: <82659786.7iirk8N2EY@bentobox>
References: <82659786.7iirk8N2EY@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/4] batman-adv: Fix unbalanced braces
	around else statement
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased patch on master

 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6077a87..a75f0a6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2253,12 +2253,13 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 		/* its the last one, mark for roaming. */
 		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
 		tt_global_entry->roam_at = jiffies;
-	} else
+	} else {
 		/* there is another entry, we can simply delete this
 		 * one and can still use the other one.
 		 */
 		batadv_tt_global_del_orig_node(bat_priv, tt_global_entry,
 					       orig_node, message);
+	}
 }
 
 /**
@@ -2314,10 +2315,11 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 		/* local entry exists, case 2: client roamed to us. */
 		batadv_tt_global_del_orig_list(tt_global_entry);
 		batadv_tt_global_free(bat_priv, tt_global_entry, message);
-	} else
+	} else {
 		/* no local entry exists, case 1: check for roaming */
 		batadv_tt_global_del_roaming(bat_priv, tt_global_entry,
 					     orig_node, message);
+	}
 
 out:
 	if (tt_global_entry)
-- 
2.11.0

