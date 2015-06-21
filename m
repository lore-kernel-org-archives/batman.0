Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2015 14:45:15 +0200
Message-Id: <1434890715-14370-2-git-send-email-sven@narfation.org>
In-Reply-To: <1434890715-14370-1-git-send-email-sven@narfation.org>
References: <1434890715-14370-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Add lockdep_asserts for
	documented external locks
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

Some functions already have documentation about looks they require inside
their kerneldoc header. These can be directly tested during runtime using
the lockdep asserts.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 * add missing header linux/lockdep.h in fragmentation.c

 net/batman-adv/fragmentation.c     | 3 +++
 net/batman-adv/multicast.c         | 6 ++++++
 net/batman-adv/translation-table.c | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index ec5f7bc..700c96c 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -25,6 +25,7 @@
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_sched.h>
 #include <linux/skbuff.h>
@@ -112,6 +113,8 @@ static int batadv_frag_size_limit(void)
 static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
 				   u16 seqno)
 {
+	lockdep_assert_held(&chain->lock);
+
 	if (chain->seqno == seqno)
 		return false;
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index f9190ad..cd8eaca 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -609,6 +609,8 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_unsnoopables_list;
 
+	lockdep_assert_held(&orig->mcast_handler_lock);
+
 	/* switched from flag unset to set */
 	if (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
 	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES)) {
@@ -652,6 +654,8 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv4_list;
 
+	lockdep_assert_held(&orig->mcast_handler_lock);
+
 	/* switched from flag unset to set */
 	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4 &&
 	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4)) {
@@ -695,6 +699,8 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
 	struct hlist_head *head = &bat_priv->mcast.want_all_ipv6_list;
 
+	lockdep_assert_held(&orig->mcast_handler_lock);
+
 	/* switched from flag unset to set */
 	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6 &&
 	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6)) {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7490006..a919b5d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3264,6 +3264,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
+	lockdep_assert_held(&bat_priv->tt.commit_lock);
+
 	/* Update multicast addresses in local translation table */
 	batadv_mcast_mla_update(bat_priv);
 
-- 
2.1.4

