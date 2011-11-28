Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 00:28:36 +0800
Message-Id: <1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: convert batman iv algorithm
	to use dynamic infrastructure
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c     |   21 +++++++++++++--------
 bat_ogm.h        |   35 -----------------------------------
 hard-interface.c |   16 ++++++++++------
 routing.c        |    7 +++++--
 send.c           |    8 +++++---
 types.h          |   10 +++++++++-
 6 files changed, 42 insertions(+), 55 deletions(-)
 delete mode 100644 bat_ogm.h

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a2b25ad..8e4c81f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -20,7 +20,6 @@
  */
 
 #include "main.h"
-#include "bat_ogm.h"
 #include "translation-table.h"
 #include "ring_buffer.h"
 #include "originator.h"
@@ -30,7 +29,7 @@
 #include "hard-interface.h"
 #include "send.h"
 
-void bat_ogm_init(struct hard_iface *hard_iface)
+static void bat_ogm_init(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
@@ -47,7 +46,7 @@ void bat_ogm_init(struct hard_iface *hard_iface)
 	batman_ogm_packet->ttvn = 0;
 }
 
-void bat_ogm_init_primary(struct hard_iface *hard_iface)
+static void bat_ogm_init_primary(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
@@ -56,7 +55,7 @@ void bat_ogm_init_primary(struct hard_iface *hard_iface)
 	batman_ogm_packet->header.ttl = TTL;
 }
 
-void bat_ogm_update_mac(struct hard_iface *hard_iface)
+static void bat_ogm_update_mac(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 
@@ -157,7 +156,7 @@ static void bat_ogm_send_to_if(struct forw_packet *forw_packet,
 }
 
 /* send a batman ogm packet */
-void bat_ogm_emit(struct forw_packet *forw_packet)
+static void bat_ogm_emit(struct forw_packet *forw_packet)
 {
 	struct hard_iface *hard_iface;
 	struct net_device *soft_iface;
@@ -528,7 +527,7 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 			  if_incoming, 0, bat_ogm_fwd_send_time());
 }
 
-void bat_ogm_schedule(struct hard_iface *hard_iface, int tt_num_changes)
+static void bat_ogm_schedule(struct hard_iface *hard_iface, int tt_num_changes)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batman_ogm_packet *batman_ogm_packet;
@@ -1140,7 +1139,7 @@ out:
 	orig_node_free_ref(orig_node);
 }
 
-void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
+static void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
 		     int packet_len, struct hard_iface *if_incoming)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
@@ -1170,8 +1169,14 @@ void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
 				     batman_ogm_packet->tt_num_changes));
 }
 
-static struct bat_algo bat_algo_iv = {
+static struct bat_algo bat_algo_iv __read_mostly = {
 	.name = "BATMAN IV",
+	.bat_ogm_init = bat_ogm_init,
+	.bat_ogm_init_primary = bat_ogm_init_primary,
+	.bat_ogm_update_mac = bat_ogm_update_mac,
+	.bat_ogm_schedule = bat_ogm_schedule,
+	.bat_ogm_emit = bat_ogm_emit,
+	.bat_ogm_receive = bat_ogm_receive,
 };
 
 int __init bat_iv_init(void)
diff --git a/bat_ogm.h b/bat_ogm.h
deleted file mode 100644
index 69329c1..0000000
--- a/bat_ogm.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#ifndef _NET_BATMAN_ADV_OGM_H_
-#define _NET_BATMAN_ADV_OGM_H_
-
-#include "main.h"
-
-void bat_ogm_init(struct hard_iface *hard_iface);
-void bat_ogm_init_primary(struct hard_iface *hard_iface);
-void bat_ogm_update_mac(struct hard_iface *hard_iface);
-void bat_ogm_schedule(struct hard_iface *hard_iface, int tt_num_changes);
-void bat_ogm_emit(struct forw_packet *forw_packet);
-void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
-		     int packet_len, struct hard_iface *if_incoming);
-
-#endif /* _NET_BATMAN_ADV_OGM_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index d3e0e32..f4bc753 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -28,7 +28,6 @@
 #include "bat_sysfs.h"
 #include "originator.h"
 #include "hash.h"
-#include "bat_ogm.h"
 
 #include <linux/if_arp.h>
 
@@ -147,7 +146,8 @@ static void primary_if_select(struct bat_priv *bat_priv,
 	if (!new_hard_iface)
 		return;
 
-	bat_ogm_init_primary(new_hard_iface);
+	if (bat_priv->bat_algo->bat_ogm_init_primary)
+		bat_priv->bat_algo->bat_ogm_init_primary(new_hard_iface);
 	primary_if_update_addr(bat_priv);
 }
 
@@ -233,7 +233,8 @@ static void hardif_activate_interface(struct hard_iface *hard_iface)
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_ogm_update_mac(hard_iface);
+	if (bat_priv->bat_algo->bat_ogm_update_mac)
+		bat_priv->bat_algo->bat_ogm_update_mac(hard_iface);
 	hard_iface->if_status = IF_TO_BE_ACTIVATED;
 
 	/**
@@ -307,7 +308,8 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_ogm_init(hard_iface);
+	if (bat_priv->bat_algo->bat_ogm_init)
+		bat_priv->bat_algo->bat_ogm_init(hard_iface);
 
 	if (!hard_iface->packet_buff) {
 		bat_err(hard_iface->soft_iface, "Can't add interface packet "
@@ -527,9 +529,11 @@ static int hard_if_event(struct notifier_block *this,
 			goto hardif_put;
 
 		check_known_mac_addr(hard_iface->net_dev);
-		bat_ogm_update_mac(hard_iface);
-
 		bat_priv = netdev_priv(hard_iface->soft_iface);
+
+		if (bat_priv->bat_algo->bat_ogm_update_mac)
+			bat_priv->bat_algo->bat_ogm_update_mac(hard_iface);
+
 		primary_if = primary_if_get_selected(bat_priv);
 		if (!primary_if)
 			goto hardif_put;
diff --git a/routing.c b/routing.c
index d5ddbd1..478b121 100644
--- a/routing.c
+++ b/routing.c
@@ -29,7 +29,6 @@
 #include "originator.h"
 #include "vis.h"
 #include "unicast.h"
-#include "bat_ogm.h"
 
 void slide_own_bcast_window(struct hard_iface *hard_iface)
 {
@@ -248,6 +247,7 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 
 int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
 {
+	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
@@ -274,7 +274,10 @@ int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	bat_ogm_receive(ethhdr, skb->data, skb_headlen(skb), hard_iface);
+	if (bat_priv->bat_algo->bat_ogm_receive)
+		bat_priv->bat_algo->bat_ogm_receive(ethhdr, skb->data,
+						    skb_headlen(skb),
+						    hard_iface);
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
diff --git a/send.c b/send.c
index b00a0f5..a8a7fc9 100644
--- a/send.c
+++ b/send.c
@@ -28,7 +28,6 @@
 #include "vis.h"
 #include "gateway_common.h"
 #include "originator.h"
-#include "bat_ogm.h"
 
 static void send_outstanding_bcast_packet(struct work_struct *work);
 
@@ -168,7 +167,9 @@ void schedule_bat_ogm(struct hard_iface *hard_iface)
 	if (primary_if)
 		hardif_free_ref(primary_if);
 
-	bat_ogm_schedule(hard_iface, tt_num_changes);
+	if (bat_priv->bat_algo->bat_ogm_schedule)
+		bat_priv->bat_algo->bat_ogm_schedule(hard_iface,
+						     tt_num_changes);
 }
 
 static void forw_packet_free(struct forw_packet *forw_packet)
@@ -318,7 +319,8 @@ void send_outstanding_bat_ogm_packet(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
-	bat_ogm_emit(forw_packet);
+	if (bat_priv->bat_algo->bat_ogm_emit)
+		bat_priv->bat_algo->bat_ogm_emit(forw_packet);
 
 	/**
 	 * we have to have at least one packet in the queue
diff --git a/types.h b/types.h
index cfb0cc2..e3bdb85 100644
--- a/types.h
+++ b/types.h
@@ -345,10 +345,18 @@ struct softif_neigh {
 	struct rcu_head rcu;
 };
 
-
 struct bat_algo {
 	struct hlist_node list;
 	char name[20];
+	void (*bat_ogm_init)(struct hard_iface *hard_iface);
+	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
+	void (*bat_ogm_update_mac)(struct hard_iface *hard_iface);
+	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
+				 int tt_num_changes);
+	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
+	void (*bat_ogm_receive)(const struct ethhdr *ethhdr,
+				unsigned char *packet_buff, int packet_len,
+				struct hard_iface *if_incoming);
 };
 
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.5.4

