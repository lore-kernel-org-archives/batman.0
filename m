Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 May 2013 21:43:02 +0200
Message-Id: <1369683792-531-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1369683792-531-1-git-send-email-ordex@autistici.org>
References: <1369683792-531-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 02/12] batman-adv: make
	batadv_tt_save_orig_buffer() generic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index fdc640c..9989bd6 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1496,11 +1496,9 @@ static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 
 static void batadv_tt_save_orig_buffer(struct batadv_priv *bat_priv,
 				       struct batadv_orig_node *orig_node,
-				       const unsigned char *tt_buff,
-				       uint16_t tt_num_changes)
+				       const void *tt_buff,
+				       uint16_t tt_buff_len)
 {
-	uint16_t tt_buff_len = batadv_tt_len(tt_num_changes);
-
 	/* Replace the old buffer only if I received something in the
 	 * last OGM (the OGM could carry no changes)
 	 */
@@ -2037,8 +2035,8 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 	_batadv_tt_update_changes(bat_priv, orig_node, tt_change,
 				  tt_num_changes, ttvn);
 
-	batadv_tt_save_orig_buffer(bat_priv, orig_node,
-				   (unsigned char *)tt_change, tt_num_changes);
+	batadv_tt_save_orig_buffer(bat_priv, orig_node, tt_change,
+				   batadv_tt_len(tt_num_changes));
 	atomic_set(&orig_node->last_ttvn, ttvn);
 }
 
-- 
1.8.1.5

