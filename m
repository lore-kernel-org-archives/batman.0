Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 23:45:25 +0200
Message-Id: <1366753527-17171-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366753527-17171-1-git-send-email-ordex@autistici.org>
References: <1366753527-17171-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: invoke dev_get_by_index()
	outside of is_wifi_iface()
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Changes that are going to be introduced later will need to
perform other checks on the incoming net_device struct.

To avoid performing the dev_get_by_index() each and every
time, it is better to move it outside of the is_wifi_iface()
function and then pass the obtained pointer to all the
checking routines.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 hard-interface.c    | 33 ++++-----------------------------
 hard-interface.h    |  2 +-
 translation-table.c |  8 +++++++-
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index c343aa8..179f74a 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -124,8 +124,11 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
  *
  * Returns true if the net device is a 802.11 wireless device, false otherwise.
  */
-static bool batadv_is_wifi_netdev(struct net_device *net_device)
+bool batadv_is_wifi_netdev(struct net_device *net_device)
 {
+	if (!net_device)
+		return false;
+
 #ifdef CONFIG_WIRELESS_EXT
 	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
 	 * check for wireless_handlers != NULL
@@ -141,34 +144,6 @@ static bool batadv_is_wifi_netdev(struct net_device *net_device)
 	return false;
 }
 
-/**
- * batadv_is_wifi_iface - check if the given interface represented by ifindex
- *  is a wifi interface
- * @ifindex: interface index to check
- *
- * Returns true if the interface represented by ifindex is a 802.11 wireless
- * device, false otherwise.
- */
-bool batadv_is_wifi_iface(int ifindex)
-{
-	struct net_device *net_device = NULL;
-	bool ret = false;
-
-	if (ifindex == BATADV_NULL_IFINDEX)
-		goto out;
-
-	net_device = dev_get_by_index(&init_net, ifindex);
-	if (!net_device)
-		goto out;
-
-	ret = batadv_is_wifi_netdev(net_device);
-
-out:
-	if (net_device)
-		dev_put(net_device);
-	return ret;
-}
-
 static struct batadv_hard_iface *
 batadv_hardif_get_active(const struct net_device *soft_iface)
 {
diff --git a/hard-interface.h b/hard-interface.h
index 4989288..2d3488a 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -51,7 +51,7 @@ void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_free_rcu(struct rcu_head *rcu);
-bool batadv_is_wifi_iface(int ifindex);
+bool batadv_is_wifi_netdev(struct net_device *net_device);
 
 static inline void
 batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
diff --git a/translation-table.c b/translation-table.c
index 87c4a44..0543b1a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -346,11 +346,15 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global;
+	struct net_device *in_dev = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added;
 	bool roamed_back = false;
 
+	if (ifindex != BATADV_NULL_IFINDEX)
+		in_dev = dev_get_by_index(&init_net, ifindex);
+
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
@@ -400,7 +404,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	 */
 	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
 	tt_local->common.vid = vid;
-	if (batadv_is_wifi_iface(ifindex))
+	if (batadv_is_wifi_netdev(in_dev))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	atomic_set(&tt_local->common.refcount, 2);
 	tt_local->last_seen = jiffies;
@@ -451,6 +455,8 @@ check_roaming:
 	}
 
 out:
+	if (in_dev)
+		dev_put(in_dev);
 	if (tt_local)
 		batadv_tt_local_entry_free_ref(tt_local);
 	if (tt_global)
-- 
1.8.1.5

