Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  5 Nov 2012 16:34:34 +0100
Message-Id: <1352129674-11080-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix ROAM flag de-selection
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
To: b.a.t.m.a.n@lists.open-mesh.org

In tt_global_add() the ROAM flag is improperly unset. This makes the
next check fail and so preventing emptying the old originator_list for
the involved tt_global_entry

This was introduced by ("batman-adv: roaming handling mechanism redesign")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch should go to next so that it can be squashed with the one introducing
the "broken" change.


 translation-table.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 6fecb94..f30360c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -860,14 +860,6 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 */
 		common->flags &= ~BATADV_TT_CLIENT_TEMP;
 
-		/* if this is a normal add, possibly unset the ROAM flag. This
-		 * flag could have been set before because the client was
-		 * roaming, but now that the node got the ADD event, the flag
-		 * can be unset
-		 */
-		if (!(flags & BATADV_TT_CLIENT_ROAM))
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
 		 * delete + roaming change for this originator.
-- 
1.8.0

