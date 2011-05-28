Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 29 May 2011 00:26:17 +0200
Message-Id: <1306621577-5494-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: correct !x & y in !(x & y)
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

This error was introduced with: 4dea0274b8edeab50bfeb6685ef33362e3ec9299

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
This error has been found using sparse

 translation-table.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 464569e..f0d8857 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -724,7 +724,7 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_global_entry, node, node_tmp,
 					  head, hash_entry) {
-			if (!tt_global_entry->flags & TT_GLOBAL_ROAM)
+			if (!(tt_global_entry->flags & TT_GLOBAL_ROAM))
 				continue;
 			if (!is_out_of_time(tt_global_entry->roam_at,
 					    TT_GLOBAL_ROAM_TIMEOUT * 1000))
-- 
1.7.3.4

