Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 20 Jun 2015 12:13:22 +0200
Message-Id: <1434795203-21947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Annotate deleting functions
	with external lock via lockdep
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

Functions which use (h)list_del* are requiring correct locking when they
operate on global lists. Most of the time the search in the list and the
delete are done in the same function. All other cases should have it
visible that they require a special lock to avoid race conditions.

Lockdep asserts can be used to check these problem during runtime when the
lockdep functionality is enabled.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c              | 11 ++++++++---
 net/batman-adv/multicast.c         | 13 +++++++++++--
 net/batman-adv/network-coding.c    |  4 ++++
 net/batman-adv/translation-table.c |  2 ++
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 40750cb..e71166a 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -30,6 +30,7 @@
 #include <linux/ipv6.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
@@ -737,13 +738,17 @@ static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 /**
  * batadv_tvlv_container_remove - remove tvlv container from the tvlv container
  *  list
+ * @bat_priv: the bat priv with all the soft interface information
  * @tvlv: the to be removed tvlv container
  *
  * Has to be called with the appropriate locks being acquired
  * (tvlv.container_list_lock).
  */
-static void batadv_tvlv_container_remove(struct batadv_tvlv_container *tvlv)
+static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
+					 struct batadv_tvlv_container *tvlv)
 {
+	lockdep_assert_held(&bat_priv->tvlv.handler_list_lock);
+
 	if (!tvlv)
 		return;
 
@@ -768,7 +773,7 @@ void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv = batadv_tvlv_container_get(bat_priv, type, version);
-	batadv_tvlv_container_remove(tvlv);
+	batadv_tvlv_container_remove(bat_priv, tvlv);
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
 }
 
@@ -807,7 +812,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
-	batadv_tvlv_container_remove(tvlv_old);
+	batadv_tvlv_container_remove(bat_priv, tvlv_old);
 	hlist_add_head(&tvlv_new->list, &bat_priv->tvlv.container_list);
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
 }
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index c64d9b1..f9190ad 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -31,6 +31,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -103,15 +104,19 @@ static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
 
 /**
  * batadv_mcast_mla_list_free - free a list of multicast addresses
+ * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: the list to free
  *
  * Removes and frees all items in the given mcast_list.
  */
-static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
+static void batadv_mcast_mla_list_free(struct batadv_priv *bat_priv,
+				       struct hlist_head *mcast_list)
 {
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
 	hlist_for_each_entry_safe(mcast_entry, tmp, mcast_list, list) {
 		hlist_del(&mcast_entry->list);
 		kfree(mcast_entry);
@@ -134,6 +139,8 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
 	hlist_for_each_entry_safe(mcast_entry, tmp, &bat_priv->mcast.mla_list,
 				  list) {
 		if (mcast_list &&
@@ -164,6 +171,8 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
 	if (!mcast_list)
 		return;
 
@@ -268,7 +277,7 @@ update:
 	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
 
 out:
-	batadv_mcast_mla_list_free(&mcast_list);
+	batadv_mcast_mla_list_free(bat_priv, &mcast_list);
 }
 
 /**
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 62defe0..9700223 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -586,6 +586,8 @@ static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
 	unsigned long timeout = bat_priv->nc.max_buffer_time;
 	bool res = false;
 
+	lockdep_assert_held(&nc_path->packet_list_lock);
+
 	/* Packets are added to tail, so the remaining packets did not time
 	 * out and we can stop processing the current queue
 	 */
@@ -622,6 +624,8 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
 {
 	unsigned long timeout = bat_priv->nc.max_fwd_delay;
 
+	lockdep_assert_held(&nc_path->packet_list_lock);
+
 	/* Packets are added to tail, so the remaining packets did not time
 	 * out and we can stop processing the current queue
 	 */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e96710c..7490006 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1669,6 +1669,8 @@ static void
 _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 				 struct batadv_tt_orig_list_entry *orig_entry)
 {
+	lockdep_assert_held(&tt_global_entry->list_lock);
+
 	batadv_tt_global_size_dec(orig_entry->orig_node,
 				  tt_global_entry->common.vid);
 	atomic_dec(&tt_global_entry->orig_list_count);
-- 
2.1.4

