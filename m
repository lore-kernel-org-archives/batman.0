Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/5] batman-adv: Drop unused function batadv_hardif_remove_interfaces()
Date: Mon, 24 Aug 2020 18:27:38 +0200
Message-Id: <20200824162741.880-3-sw@simonwunderlich.de>
In-Reply-To: <20200824162741.880-1-sw@simonwunderlich.de>
References: <20200824162741.880-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The function batadv_hardif_remove_interfaces was meant to remove all
interfaces which are currently in the list of known (compatible) hardifs
during module unload. But the function unregister_netdevice_notifier is
called in batadv_exit before batadv_hardif_remove_interfaces. This will
trigger NETDEV_UNREGISTER events for all available interfaces and in this
process remove all interfaces from batadv_hardif_list. And
batadv_hardif_remove_interfaces only operated on this (empty) list.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 17 -----------------
 net/batman-adv/hard-interface.h |  1 -
 net/batman-adv/main.c           |  1 -
 3 files changed, 19 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index fa06b51c0144..f95be90adaab 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -976,23 +976,6 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(hard_iface);
 }
 
-/**
- * batadv_hardif_remove_interfaces() - Remove all hard interfaces
- */
-void batadv_hardif_remove_interfaces(void)
-{
-	struct batadv_hard_iface *hard_iface, *hard_iface_tmp;
-
-	rtnl_lock();
-	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
-				 &batadv_hardif_list, list) {
-		list_del_rcu(&hard_iface->list);
-		batadv_hardif_generation++;
-		batadv_hardif_remove_interface(hard_iface);
-	}
-	rtnl_unlock();
-}
-
 /**
  * batadv_hard_if_event_softif() - Handle events for soft interfaces
  * @event: NETDEV_* event to handle
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index bad2e50135e8..b1855d9d0b06 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -100,7 +100,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   struct net *net, const char *iface_name);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 				     enum batadv_hard_if_cleanup autodel);
-void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_release(struct kref *ref);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 519c08c2cfba..70fee9b42e25 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -137,7 +137,6 @@ static void __exit batadv_exit(void)
 	batadv_netlink_unregister();
 	rtnl_link_unregister(&batadv_link_ops);
 	unregister_netdevice_notifier(&batadv_hard_if_notifier);
-	batadv_hardif_remove_interfaces();
 
 	flush_workqueue(batadv_event_workqueue);
 	destroy_workqueue(batadv_event_workqueue);
-- 
2.20.1

