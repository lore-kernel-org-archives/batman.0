Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  3 Dec 2011 21:54:18 +0100
Message-Id: <1322945658-25154-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: in case of roaming mark the
	client with TT_CLIENT_ROAM
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

Whenever we add a local client for which we already have a global entry, the
latter has to be marked with the TT_CLIENT_ROAM flag (instead of
TT_CLIENT_PENDING)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 7a7df4a..cf3e2c2 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -242,9 +242,11 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (tt_global_entry) {
 		/* This node is probably going to update its tt table */
 		tt_global_entry->orig_node->tt_poss_change = true;
-		/* The global entry has to be marked as PENDING and has to be
+		/* The global entry has to be marked as ROAMING and has to be
 		 * kept for consistency purpose */
-		tt_global_entry->common.flags |= TT_CLIENT_PENDING;
+		tt_global_entry->common.flags |= TT_CLIENT_ROAM;
+		tt_global_entry->roam_at = jiffies;
+
 		send_roam_adv(bat_priv, tt_global_entry->common.addr,
 			      tt_global_entry->orig_node);
 	}
-- 
1.7.3.4

