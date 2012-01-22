Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 22 Jan 2012 19:40:40 +0100
Message-Id: <1327257640-13530-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <201201230026.09036.lindner_marek@yahoo.de>
References: <201201230026.09036.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix initialised flag for tt
	request/responses
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
To: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

When receiving a tt_response, we first delete the old entries and
set the initialised flag to false, then add the new received entries,
but forgot to set the initialised flag to true again. This may lead to
endless loops of requests/responses, as a request is always issued
if the initialised flag is not set.

This is a regression introduced by
8ef201e01c57e3bfbcb7f6db69405ff259c2b907.

Fix this by moving initialised = true from tt_update_changes() to
_tt_update_changes().

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 translation-table.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 27753a0..9a6f315 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1434,6 +1434,7 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 				 */
 				return;
 	}
+	orig_node->tt_initialised = true;
 }
 
 static void tt_fill_gtable(struct bat_priv *bat_priv,
@@ -1476,7 +1477,6 @@ static void tt_update_changes(struct bat_priv *bat_priv,
 	tt_save_orig_buffer(bat_priv, orig_node, (unsigned char *)tt_change,
 			    tt_num_changes);
 	atomic_set(&orig_node->last_ttvn, ttvn);
-	orig_node->tt_initialised = true;
 }
 
 bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
-- 
1.7.8.3

