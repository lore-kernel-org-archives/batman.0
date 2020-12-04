Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 7/8] batman-adv: Drop legacy code for auto deleting mesh interfaces
Date: Fri,  4 Dec 2020 16:46:30 +0100
Message-Id: <20201204154631.21063-8-sw@simonwunderlich.de>
In-Reply-To: <20201204154631.21063-1-sw@simonwunderlich.de>
References: <20201204154631.21063-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The only way to automatically drop batadv mesh interfaces when all soft
interfaces were removed was dropped with the sysfs support. It is no longer
needed to have them handled by kernel anymore.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c |  8 ++------
 net/batman-adv/hard-interface.h | 19 +------------------
 net/batman-adv/soft-interface.c |  5 ++---
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bbedb9a422c0..0f186ddc15e3 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -845,11 +845,8 @@ static size_t batadv_hardif_cnt(const struct net_device *soft_iface)
 /**
  * batadv_hardif_disable_interface() - Remove hard interface from soft interface
  * @hard_iface: hard interface to be removed
- * @autodel: whether to delete soft interface when it doesn't contain any other
- *  slave interfaces
  */
-void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
-				     enum batadv_hard_if_cleanup autodel)
+void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
@@ -953,8 +950,7 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 
 	/* first deactivate interface */
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
-		batadv_hardif_disable_interface(hard_iface,
-						BATADV_IF_CLEANUP_KEEP);
+		batadv_hardif_disable_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		return;
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 1ee45b615399..f4b8e9efef19 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -67,22 +67,6 @@ enum batadv_hard_if_bcast {
 	BATADV_HARDIF_BCAST_DUPORIG,
 };
 
-/**
- * enum batadv_hard_if_cleanup - Cleanup modi for soft_iface after slave removal
- */
-enum batadv_hard_if_cleanup {
-	/**
-	 * @BATADV_IF_CLEANUP_KEEP: Don't automatically delete soft-interface
-	 */
-	BATADV_IF_CLEANUP_KEEP,
-
-	/**
-	 * @BATADV_IF_CLEANUP_AUTO: Delete soft-interface after last slave was
-	 *  removed
-	 */
-	BATADV_IF_CLEANUP_AUTO,
-};
-
 extern struct notifier_block batadv_hard_if_notifier;
 
 struct net_device *batadv_get_real_netdev(struct net_device *net_device);
@@ -92,8 +76,7 @@ struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   struct net *net, const char *iface_name);
-void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
-				     enum batadv_hard_if_cleanup autodel);
+void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_release(struct kref *ref);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 6c6a8c6bab17..97118efbe678 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -881,7 +881,7 @@ static int batadv_softif_slave_del(struct net_device *dev,
 	if (!hard_iface || hard_iface->soft_iface != dev)
 		goto out;
 
-	batadv_hardif_disable_interface(hard_iface, BATADV_IF_CLEANUP_KEEP);
+	batadv_hardif_disable_interface(hard_iface);
 	ret = 0;
 
 out:
@@ -1139,8 +1139,7 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface == soft_iface)
-			batadv_hardif_disable_interface(hard_iface,
-							BATADV_IF_CLEANUP_KEEP);
+			batadv_hardif_disable_interface(hard_iface);
 	}
 
 	/* destroy the "untagged" VLAN */
-- 
2.20.1

