Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Feb 2012 19:32:24 +0800
Message-Id: <1330428748-23137-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330428748-23137-1-git-send-email-lindner_marek@yahoo.de>
References: <1330428748-23137-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: set TT_CLIENT_NEW flag
	before invoking hash_add()
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

In case of a new tt_local_entry, the TT_CLIENT_NEW flag has to be set before
adding such entry to the hash table. Otherwise, it opens a race condition
in which the entry can be found but the flag has not been set.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4dc5af3..9be9c41 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -210,6 +210,11 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (compare_eth(addr, soft_iface->dev_addr))
 		tt_local_entry->common.flags |= TT_CLIENT_NOPURGE;
 
+	/* The local entry has to be marked as NEW to avoid to send it in
+	 * a full table response going out before the next ttvn increment
+	 * (consistency check) */
+	tt_local_entry->common.flags |= TT_CLIENT_NEW;
+
 	hash_added = hash_add(bat_priv->tt_local_hash, compare_tt, choose_orig,
 			 &tt_local_entry->common,
 			 &tt_local_entry->common.hash_entry);
@@ -222,11 +227,6 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
 
-	/* The local entry has to be marked as NEW to avoid to send it in
-	 * a full table response going out before the next ttvn increment
-	 * (consistency check) */
-	tt_local_entry->common.flags |= TT_CLIENT_NEW;
-
 	/* remove address from global hash if present */
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 
-- 
1.7.9

