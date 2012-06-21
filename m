Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 21 Jun 2012 23:15:45 +0200
Message-Id: <1340313345-19347-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: prepend BATADV_ in front of the
	TT_OGM_APPEND_MAX in comments
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

patch based on top of next


 translation-table.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index b6931d0..ab7618a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2292,7 +2292,8 @@ void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 	if ((!orig_node->tt_initialised && ttvn == 1) ||
 	    ttvn - orig_ttvn == 1) {
 		/* the OGM could not contain the changes due to their size or
-		 * because they have already been sent TT_OGM_APPEND_MAX times.
+		 * because they have already been sent BATADV_TT_OGM_APPEND_MAX
+		 * times.
 		 * In this case send a tt request
 		 */
 		if (!tt_num_changes) {
-- 
1.7.9.4

