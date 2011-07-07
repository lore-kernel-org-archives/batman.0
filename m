Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri,  8 Jul 2011 00:33:42 +0200
Message-Id: <1310078023-28958-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1310078023-28958-1-git-send-email-lindner_marek@yahoo.de>
References: <1310078023-28958-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: keep global table
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Antonio Quartulli <ordex@autistici.org>

To keep consistency of other originator tables, new clients detected as
roamed, are kept in the global table but are marked as TT_CLIENT_PENDING
They are purged only when the new ttvn is received by the corresponding
originator. Moreover they need to be considered as removed in case of global
transtable lookup.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7cc67c0..fb6931d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
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
@@ -787,6 +788,11 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
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
1.7.5.3

