Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 17:39:22 +0200
Message-Id: <1468597173-25378-7-git-send-email-sven@narfation.org>
In-Reply-To: <1468597173-25378-1-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 07/18] batman-adv: Place kref_get for
	tt_local_entry near use
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

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems causedy incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patch based on type

 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 89d7b1d..d21b65c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -727,7 +727,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	if (batadv_is_wifi_netdev(in_dev))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	kref_init(&tt_local->common.refcount);
-	kref_get(&tt_local->common.refcount);
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 	tt_local->vlan = vlan;
@@ -739,6 +738,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
+	kref_get(&tt_local->common.refcount);
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
 				     batadv_choose_tt, &tt_local->common,
 				     &tt_local->common.hash_entry);
-- 
2.8.1

