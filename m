Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 00:27:24 +0200
Message-Id: <1334701645-25862-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1334701645-25862-1-git-send-email-ordex@autistici.org>
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: update ttvn in case of
	client reannouncement
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

in various scenarios it would be possible that a node receives an ADD event for
a client it already knows to belong to the advertiser. In this case the node has
to update the global entry ttvn with the one carried by the OGM.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index cd6c2dd..ab295ee 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -593,6 +593,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		  bool wifi)
 {
 	struct tt_global_entry *tt_global_entry = NULL;
+	struct tt_orig_list_entry *orig_entry;
 	int ret = 0;
 	int hash_added;
 
@@ -640,9 +641,17 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			tt_global_entry->roam_at = 0;
 		}
 
-		if (!tt_global_entry_has_orig(tt_global_entry, orig_node))
+		orig_entry = tt_global_entry_has_orig(tt_global_entry,
+						      orig_node);
+		if (!orig_entry)
 			tt_global_add_orig_entry(tt_global_entry, orig_node,
 						 ttvn);
+		else
+			/* if we are "adding" global entry, we may want to
+			 * update the ttvn anyway. Perhaps the global entry is
+			 * here with a wrong ttvn because it was temporary added
+			 * before */
+			orig_entry->ttvn = ttvn;
 	}
 
 	if (wifi)
-- 
1.7.9.4

