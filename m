Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  4 Dec 2011 12:26:50 +0100
Message-Id: <1322998010-19221-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1322945658-25154-1-git-send-email-ordex@autistici.org>
References: <1322945658-25154-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: in case of roaming mark the
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

In case of a client roaming from node A to node B, the latter have to mark the
corresponding global entry with TT_CLIENT_ROAM (instead of TT_CLIENT_PENDING).

Marking a global entry with TT_CLIENT_PENDING will end up in keeping such entry
forever (because this flag is only meant to be used with local entries and it is
never checked on global ones).

In the worst case (all the clients roaming to the same node A) the local and the
global table will contain exactly the same clients. Batman-adv will continue to
work, but the memory usage is duplicated.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

* commit message improved

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

