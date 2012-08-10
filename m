Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 10 Aug 2012 23:09:26 +0200
Message-Id: <1344632966-24233-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: return proper value in case of
	hash_add failure
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

In case of hash_add failure tt_global_add() must return 0 (which means on entry
insertion).

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch is based on master. This bug exists since "a bit" but nobody actually
found it because this bug should have been triggered in the unlikely case of hash
adding failure. Therefore I do not think it is a crucial bug and it is not worth
sending this patch to stable.

Cheers,


 Makefile            |    2 +-
 translation-table.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bd8d30c..12aebe5 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@
 
 # changing the CONFIG_* line to 'y' enables the related feature
 # B.A.T.M.A.N. debugging:
-export CONFIG_BATMAN_ADV_DEBUG=n
+export CONFIG_BATMAN_ADV_DEBUG=y
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
 
diff --git a/translation-table.c b/translation-table.c
index 112edd3..eb352db 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -788,13 +788,13 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (via %pM)\n",
 		   tt_global_entry->common.addr, orig_node->orig);
+	ret = 1;
 
 out_remove:
 	/* remove address from local hash if present */
 	batadv_tt_local_remove(bat_priv, tt_global_entry->common.addr,
 			       "global tt received",
 			       flags & BATADV_TT_CLIENT_ROAM);
-	ret = 1;
 out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
-- 
1.7.9.4

