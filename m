Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Aug 2015 15:51:56 +0200
Message-Id: <1438955516-8986-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Add lower layer
	needed_(head|tail)room to own ones
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

The maximum of hard_header_len and maximum of all needed_(head|tail)room of
all slave interfaces of a batman-adv device must be used to define the
batman-adv device needed_(head|tail)room. This is required to avoid too
small buffer problems when these slave devices try to send the encapsulated
packet in a tx path without the possibility to resize the skbuff.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - set hard_header_len always to ETH_HLEN and only modify needed_headroom
   as done in mac80211/vxlan
 - do the same for needed_tailroom
v2:
 - based on patch "batman-adv: don't access unregistered net_device object"
 - remove the function call from batadv_update_min_mtu
 - instead use batadv_hardif_disable_interface +
   batadv_hardif_enable_interface
---
 net/batman-adv/hard-interface.c | 44 +++++++++++++++++++++++++++++++++++++++--
 net/batman-adv/soft-interface.c |  2 --
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 0565b20bfa6d..cd232ebe9941 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -252,6 +252,41 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 	rcu_read_unlock();
 }
 
+/**
+ * batadv_hardif_recalc_extra_skbroom() - Recalculate skbuff extra head/tailroom
+ * @soft_iface: netdev struct of the mesh interface
+ */
+static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
+{
+	const struct batadv_hard_iface *hard_iface;
+	unsigned short lower_header_len = ETH_HLEN;
+	unsigned short lower_headroom = 0;
+	unsigned short lower_tailroom = 0;
+	unsigned short needed_headroom;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != soft_iface)
+			continue;
+
+		lower_header_len = max_t(unsigned short, lower_header_len,
+					 hard_iface->net_dev->hard_header_len);
+
+		lower_headroom = max_t(unsigned short, lower_headroom,
+				       hard_iface->net_dev->needed_headroom);
+
+		lower_tailroom = max_t(unsigned short, lower_tailroom,
+				       hard_iface->net_dev->needed_tailroom);
+	}
+	rcu_read_unlock();
+
+	needed_headroom = lower_headroom + (lower_header_len - ETH_HLEN);
+	needed_headroom += batadv_max_header_len();
+
+	soft_iface->needed_headroom = needed_headroom;
+	soft_iface->needed_tailroom = lower_tailroom;
+}
+
 int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
@@ -474,6 +509,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			   "Not using interface %s (retrying later): interface not active\n",
 			   hard_iface->net_dev->name);
 
+	batadv_hardif_recalc_extra_skbroom(soft_iface);
+
 	/* begin scheduling originator messages on that interface */
 	batadv_schedule_bat_ogm(hard_iface);
 
@@ -495,6 +532,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
+	struct net_device *soft_iface;
 
 	if (hard_iface->if_status == BATADV_IF_ACTIVE)
 		batadv_hardif_deactivate_interface(hard_iface);
@@ -529,16 +567,18 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	dev_put(hard_iface->soft_iface);
 
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
+	soft_iface = hard_iface->soft_iface;
+	hard_iface->soft_iface = NULL;
+	batadv_hardif_recalc_extra_skbroom(soft_iface);
 
 	/* nobody uses this interface anymore */
 	if (!bat_priv->num_ifaces) {
 		batadv_gw_check_client_stop(bat_priv);
 
 		if (autodel == BATADV_IF_CLEANUP_AUTO)
-			batadv_softif_destroy_sysfs(hard_iface->soft_iface);
+			batadv_softif_destroy_sysfs(soft_iface);
 	}
 
-	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
 
 out:
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 36b23f31df2a..cce8e896d511 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -947,8 +947,6 @@ static void batadv_softif_init_early(struct net_device *dev)
 	 * have not been initialized yet
 	 */
 	dev->mtu = ETH_DATA_LEN;
-	/* reserve more space in the skbuff for our header */
-	dev->hard_header_len = batadv_max_header_len();
 
 	/* generate random address */
 	eth_hw_addr_random(dev);
-- 
2.5.0

