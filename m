Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 Jan 2013 09:41:12 +1000
Message-Id: <1358120480-25960-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1358120480-25960-1-git-send-email-ordex@autistici.org>
References: <1358120480-25960-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/15] batman-adv: remove useless assignment
	in tt_local_add()
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

The flag field of the tt_local_entry->common structure in
tt_local_add() is first assigned NO_FLAGS and then TT_CLIENT_NEW so
nullifying the first operation. For this reason it is safe to remove
the first assignment.

This was introuduced by ("batman-adv: keep local table consistency for
further TT_RESPONSE")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/translation-table.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 40ef955..5f44232 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -305,7 +305,11 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		   (uint8_t)atomic_read(&bat_priv->tt.vn));
 
 	memcpy(tt_local->common.addr, addr, ETH_ALEN);
-	tt_local->common.flags = BATADV_NO_FLAGS;
+	/* The local entry has to be marked as NEW to avoid to send it in
+	 * a full table response going out before the next ttvn increment
+	 * (consistency check)
+	 */
+	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
 	if (batadv_is_wifi_iface(ifindex))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	atomic_set(&tt_local->common.refcount, 2);
@@ -316,12 +320,6 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (batadv_compare_eth(addr, soft_iface->dev_addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
-	/* The local entry has to be marked as NEW to avoid to send it in
-	 * a full table response going out before the next ttvn increment
-	 * (consistency check)
-	 */
-	tt_local->common.flags |= BATADV_TT_CLIENT_NEW;
-
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
 				     batadv_choose_orig, &tt_local->common,
 				     &tt_local->common.hash_entry);
-- 
1.8.0.2

