Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  7 Jul 2011 01:40:59 +0200
Message-Id: <1309995659-19126-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1309995659-19126-1-git-send-email-ordex@autistici.org>
References: <1309995659-19126-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: keep global table
	consistency in case of roaming
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

To keep consistency of other originator tables, new clients detected as
roamed, are kept in the global table but are marked as TT_CLIENT_PENDING
They are purged only when the new ttvn is received by the corresponding
originator. Moreover they need to be considered as removed in case of global
transtable lookup.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 3267ca2..dfab867 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -230,8 +230,9 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (tt_global_entry) {
 		/* This node is probably going to update its tt table */
 		tt_global_entry->orig_node->tt_poss_change = true;
-		_tt_global_del(bat_priv, tt_global_entry,
-			       "local tt received");
+		/* The global entry has to be marked as PENDING and has to be
+		 * kept for consistency purpose */
+		tt_global_entry->flags |= TT_CLIENT_PENDING;
 		send_roam_adv(bat_priv, tt_global_entry->addr,
 			      tt_global_entry->orig_node);
 	}
@@ -780,6 +781,11 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
 		goto free_tt;
 
+	/* A global client marked as PENDING has already moved from that
+	 * originator */
+	if (tt_global_entry->flags & TT_CLIENT_PENDING)
+		goto free_tt;
+
 	orig_node = tt_global_entry->orig_node;
 
 free_tt:
-- 
1.7.3.4

