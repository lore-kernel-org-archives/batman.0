Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 27 Jan 2014 12:23:28 +0100
Message-Id: <1390821808-3855-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT-TVLV parsing on OGM
	reception
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

When accessing a TT-TVLV container in the OGM RX path
the variable pointing to the list of changes to apply is
altered by mistake.

This makes the TT component read data at the wrong position
in the OGM packet buffer.

Fix it by removing the bogus pointer alteration.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 097ca01..05c2a9b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -3208,7 +3208,6 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 
 		spin_lock_bh(&orig_node->tt_lock);
 
-		tt_change = (struct batadv_tvlv_tt_change *)tt_buff;
 		batadv_tt_update_changes(bat_priv, orig_node, tt_num_changes,
 					 ttvn, tt_change);
 
-- 
1.8.5.3

