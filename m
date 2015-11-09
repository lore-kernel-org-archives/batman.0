Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  9 Nov 2015 16:20:52 +0100
Message-Id: <1447082453-13117-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
References: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: purge bridge loop avoidance
	when its disabled
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

When bridge loop avoidance is disabled through sysfs, the internal
datastructures are not disabled, but only BLA operations are disabled.
To be sure that they are removed, purge the data immediately. That is
especially useful if a firmwares network state is changed, and the BLA
wait periods should restart on the new network.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 net/batman-adv/bridge_loop_avoidance.c | 20 ++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  1 +
 net/batman-adv/sysfs.c                 |  4 +++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index e068ad9..d9b034a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1247,6 +1247,26 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_bla_status_update - purge bla interfaces if necessary
+ * @net_dev: the soft interface net device
+ */
+void batadv_bla_status_update(struct net_device *net_dev)
+{
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		return;
+
+	/* this function already purges everything when bla is disabled,
+	 * so just call that one.
+	 */
+	batadv_bla_update_orig_address(bat_priv, primary_if, primary_if);
+	batadv_hardif_free_ref(primary_if);
+}
+
+/**
  * batadv_bla_periodic_work - performs periodic bla work
  * @work: kernel work struct
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 025152b..db1aeb5 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -42,6 +42,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    struct batadv_hard_iface *oldif);
+void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 2bcc7f6..9569494 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -40,6 +40,7 @@
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
+#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "network-coding.h"
 #include "packet.h"
@@ -549,7 +550,8 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 BATADV_ATTR_SIF_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BATADV_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
-BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
+BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR,
+		     batadv_bla_status_update);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR,
-- 
2.6.2

