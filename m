Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 18:55:38 +0100
Message-Id: <1395251747-27289-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 next 02/11] batman-adv: don't mess up with
	the netdev refcounting if not needed
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Looking for an interface and increasing its refcounter only
to check if it really exists is not really useful and makes
the code look more complex without a real gain.

Change batadv_mcast_has_bridge() accordingly and avoid to
use the pointer to the interface outside of the
rcu_read_lock/unlock context.

Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
("batman-adv: Multicast Listener Announcements via Translation Table")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 compat.h    | 19 ++++---------------
 multicast.c | 33 ++++-----------------------------
 2 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/compat.h b/compat.h
index e14c6bb..5eb5fe6 100644
--- a/compat.h
+++ b/compat.h
@@ -164,14 +164,8 @@ static inline int batadv_param_set_copystring(const char *val,
 #define NET_ADDR_RANDOM 0
 
 #define netdev_master_upper_dev_get_rcu(dev) \
-	upper; \
-	if (dev->br_port ? 1 : 0) { \
-		rcu_read_unlock(); \
-		dev_hold(dev); \
-		return dev; \
-	} else {\
-		dev = NULL; \
-	}
+	(dev->br_port ? dev : NULL); \
+	break;
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
@@ -375,13 +369,8 @@ static int __batadv_interface_tx(struct sk_buff *skb, \
 
 #ifndef netdev_master_upper_dev_get_rcu
 #define netdev_master_upper_dev_get_rcu(dev) \
-	upper; \
-	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
-		rcu_read_unlock(); \
-		dev_hold(dev); \
-		return dev; \
-	} else \
-		dev = NULL;
+	(dev->priv_flags & IFF_BRIDGE_PORT ? dev : NULL); \
+	break;
 
 #endif /* netdev_master_upper_dev_get_rcu */
 
diff --git a/multicast.c b/multicast.c
index d92de1e..edce295 100644
--- a/multicast.c
+++ b/multicast.c
@@ -156,51 +156,26 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_get_bridge - get the bridge interface on our soft interface
+ * batadv_mcast_has_bridge - check whether the soft-iface is bridged
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return the next bridge interface on top of our soft interface and increase
- * its refcount. If no such bridge interface exists, then return NULL.
+ * Check whether there is a bridge on top of our soft interface. Return
+ * true if so, false otherwise.
  */
-static struct net_device *
-batadv_mcast_get_bridge(struct batadv_priv *bat_priv)
+static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 {
 	struct net_device *upper = bat_priv->soft_iface;
 
 	rcu_read_lock();
-
 	do {
 		upper = netdev_master_upper_dev_get_rcu(upper);
 	} while (upper && !(upper->priv_flags & IFF_EBRIDGE));
-
-	if (upper)
-		dev_hold(upper);
-
 	rcu_read_unlock();
 
 	return upper;
 }
 
 /**
- * batadv_mcast_has_bridge - check whether the soft-iface is bridged
- * @bat_priv: the bat priv with all the soft interface information
- *
- * Check whether there is a bridge on top of our soft interface. Return
- * true if so, false otherwise.
- */
-static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
-{
-	struct net_device *bridge;
-
-	bridge = batadv_mcast_get_bridge(bat_priv);
-	if (!bridge)
-		return false;
-
-	dev_put(bridge);
-	return true;
-}
-
-/**
  * batadv_mcast_mla_tvlv_update - update multicast tvlv
  * @bat_priv: the bat priv with all the soft interface information
  *
-- 
1.8.3.2

