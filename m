Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 12 Nov 2012 20:48:21 +0100
Message-Id: <1352749701-19288-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove useless !! when
	converting to bool
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

In C standard any expression different from 0 will be converted to
'true' when casting to bool (whatever is the length of the value).
Therefore the "!!" conversion can be removed.

This was introduced by 3fbd7ac8c71b3778c5751b3d096ea36f96ef534e
("batman-adv: substitute tt_poss_change with a per-tt_entry flag")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index cb0281a..39ae6b0 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2545,7 +2545,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 	if (!tt_local_entry)
 		goto out;
 
-	ret = !!(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM);
+	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_free_ref(tt_local_entry);
 out:
 	return ret;
-- 
1.8.0

