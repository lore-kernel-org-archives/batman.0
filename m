Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Jun 2015 18:53:19 +0200
Message-Id: <1434646404-19291-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: Remove batadv_ types forward
	declarations
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

main.h is included in every file and is the only way to access types.h.
This makes forward declarations for all types defined in types.h
unnecessary.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.h | 3 ---
 net/batman-adv/debugfs.h               | 1 -
 net/batman-adv/gateway_common.h        | 1 -
 net/batman-adv/icmp_socket.h           | 1 -
 net/batman-adv/multicast.h             | 2 --
 net/batman-adv/network-coding.h        | 4 ----
 net/batman-adv/routing.h               | 4 ----
 net/batman-adv/send.h                  | 3 ---
 net/batman-adv/soft-interface.h        | 4 ----
 net/batman-adv/sysfs.h                 | 2 --
 net/batman-adv/translation-table.h     | 2 --
 11 files changed, 27 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 449f2f1..025152b 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -22,9 +22,6 @@
 
 #include <linux/types.h>
 
-struct batadv_hard_iface;
-struct batadv_orig_node;
-struct batadv_priv;
 struct seq_file;
 struct sk_buff;
 
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 187acdc..80ab8d6 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -22,7 +22,6 @@
 
 #include <linux/kconfig.h>
 
-struct batadv_hard_iface;
 struct net_device;
 
 #define BATADV_DEBUGFS_SUBDIR "batman_adv"
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index bd5c812..ab893e3 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -22,7 +22,6 @@
 
 #include <linux/types.h>
 
-struct batadv_priv;
 struct net_device;
 
 enum batadv_gw_modes {
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 7de7fce..e937143 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -23,7 +23,6 @@
 #include <linux/types.h>
 
 struct batadv_icmp_header;
-struct batadv_priv;
 
 #define BATADV_ICMP_SOCKET "socket"
 
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index beb6e56..8f3cb04 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -20,8 +20,6 @@
 
 #include "main.h"
 
-struct batadv_orig_node;
-struct batadv_priv;
 struct sk_buff;
 
 /**
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index 5b79aa8..8f6d4ad 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -22,11 +22,7 @@
 
 #include <linux/types.h>
 
-struct batadv_nc_node;
-struct batadv_neigh_node;
 struct batadv_ogm_packet;
-struct batadv_orig_node;
-struct batadv_priv;
 struct net_device;
 struct seq_file;
 struct sk_buff;
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 3c185a1..204bbe4 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -22,10 +22,6 @@
 
 #include <linux/types.h>
 
-struct batadv_hard_iface;
-struct batadv_neigh_node;
-struct batadv_orig_node;
-struct batadv_priv;
 struct sk_buff;
 
 bool batadv_check_management_packet(struct sk_buff *skb,
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 33ef6fc..82059f2 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -25,9 +25,6 @@
 
 #include "packet.h"
 
-struct batadv_hard_iface;
-struct batadv_orig_node;
-struct batadv_priv;
 struct sk_buff;
 struct work_struct;
 
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 578e8a6..8e82176 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -22,10 +22,6 @@
 
 #include <net/rtnetlink.h>
 
-struct batadv_hard_iface;
-struct batadv_orig_node;
-struct batadv_priv;
-struct batadv_softif_vlan;
 struct net_device;
 struct sk_buff;
 
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 2294583..6197442 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -23,8 +23,6 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
-struct batadv_priv;
-struct batadv_softif_vlan;
 struct kobject;
 struct net_device;
 
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 9b82d5d..abd8e11 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -22,8 +22,6 @@
 
 #include <linux/types.h>
 
-struct batadv_orig_node;
-struct batadv_priv;
 struct net_device;
 struct seq_file;
 
-- 
2.1.4

