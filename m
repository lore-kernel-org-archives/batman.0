Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 24 Aug 2012 17:54:07 +0200
Message-Id: <1345823647-27198-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: properly store the roaming time
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

in case of a new global entry added because of roaming, the roam_at field must
be properly initiated with the current time. This value will be later use to
purge this entry out on time out (if nobody claims it). Instead roam_at field
is now set to zero in this situation leading to an immediate purging of the
related entry.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/translation-table.c b/translation-table.c
index cacf7b7..ce3bf00 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -744,6 +744,12 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		common->flags = flags;
 		tt_global_entry->roam_at = 0;
+		/* node must store current time in case of roaming. This is
+		 * needed to purge this entry out on timeout (if nobody claims
+		 * it)
+		 */
+		if (flags & BATADV_TT_CLIENT_ROAM)
+			tt_global_entry->roam_at = jiffies;
 		atomic_set(&common->refcount, 2);
 		common->added_at = jiffies;
 
-- 
1.7.9.4

