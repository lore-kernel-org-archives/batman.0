Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:24 +0200
Message-Id: <1283644718-653-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/21] Staging: batman-adv: refactoring
	unicast payload code
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/Makefile         |    2 +-
 drivers/staging/batman-adv/soft-interface.c |   74 ++++-------------------
 drivers/staging/batman-adv/unicast.c        |   87 +++++++++++++++++++++++++++
 drivers/staging/batman-adv/unicast.h        |   27 ++++++++
 4 files changed, 128 insertions(+), 62 deletions(-)
 create mode 100644 drivers/staging/batman-adv/unicast.c
 create mode 100644 drivers/staging/batman-adv/unicast.h

diff --git a/drivers/staging/batman-adv/Makefile b/drivers/staging/batman-adv/Makefile
index e9817b5..4b5c434 100644
--- a/drivers/staging/batman-adv/Makefile
+++ b/drivers/staging/batman-adv/Makefile
@@ -19,4 +19,4 @@
 #
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
-batman-adv-objs := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o
+batman-adv-objs := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o unicast.o
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 6f22e6e..315fdeb 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -22,14 +22,12 @@
 #include "main.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
-#include "routing.h"
-#include "send.h"
 #include "translation-table.h"
-#include "types.h"
-#include "hash.h"
+#include "send.h"
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
+#include "unicast.h"
 
 static uint32_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 				  * broadcast storms */
@@ -127,24 +125,14 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 
 int interface_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct unicast_packet *unicast_packet;
-	struct bcast_packet *bcast_packet;
-	struct orig_node *orig_node;
-	struct neigh_node *router;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-	struct bat_priv *priv = netdev_priv(dev);
-	struct batman_if *batman_if;
-	struct bat_priv *bat_priv;
-	uint8_t dstaddr[6];
-	int data_len = skb->len;
-	unsigned long flags;
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct bcast_packet *bcast_packet;
+	int data_len = skb->len, ret;
 
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dropped;
 
-	/* FIXME: each batman_if will be attached to a softif */
-	bat_priv = netdev_priv(soft_device);
-
 	dev->trans_start = jiffies;
 	/* TODO: check this for locks */
 	hna_local_add(ethhdr->h_source);
@@ -179,55 +167,19 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 
 	/* unicast packet */
 	} else {
-		spin_lock_irqsave(&orig_hash_lock, flags);
-		/* get routing information */
-		orig_node = ((struct orig_node *)hash_find(orig_hash,
-							   ethhdr->h_dest));
-
-		/* check for hna host */
-		if (!orig_node)
-			orig_node = transtable_search(ethhdr->h_dest);
-
-		router = find_router(orig_node, NULL);
-
-		if (!router)
-			goto unlock;
-
-		/* don't lock while sending the packets ... we therefore
-		 * copy the required data before sending */
-
-		batman_if = router->if_incoming;
-		memcpy(dstaddr, router->addr, ETH_ALEN);
-
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
-
-		if (batman_if->if_status != IF_ACTIVE)
-			goto dropped;
-
-		if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
-			goto dropped;
-
-		unicast_packet = (struct unicast_packet *)skb->data;
-
-		unicast_packet->version = COMPAT_VERSION;
-		/* batman packet type: unicast */
-		unicast_packet->packet_type = BAT_UNICAST;
-		/* set unicast ttl */
-		unicast_packet->ttl = TTL;
-		/* copy the destination for faster routing */
-		memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-
-		send_skb_packet(skb, batman_if, dstaddr);
+		ret = unicast_send_skb(skb, bat_priv);
+		if (ret != 0) {
+			bat_priv->stats.tx_dropped++;
+			goto end;
+		}
 	}
 
-	priv->stats.tx_packets++;
-	priv->stats.tx_bytes += data_len;
+	bat_priv->stats.tx_packets++;
+	bat_priv->stats.tx_bytes += data_len;
 	goto end;
 
-unlock:
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
 dropped:
-	priv->stats.tx_dropped++;
+	bat_priv->stats.tx_dropped++;
 	kfree_skb(skb);
 end:
 	return NETDEV_TX_OK;
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
new file mode 100644
index 0000000..27c4abb
--- /dev/null
+++ b/drivers/staging/batman-adv/unicast.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
+ *
+ * Andreas Langer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "unicast.h"
+#include "send.h"
+#include "soft-interface.h"
+#include "hash.h"
+#include "translation-table.h"
+#include "routing.h"
+#include "hard-interface.h"
+
+int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct unicast_packet *unicast_packet;
+	struct orig_node *orig_node;
+	struct batman_if *batman_if;
+	struct neigh_node *router;
+	uint8_t dstaddr[6];
+	unsigned long flags;
+
+	spin_lock_irqsave(&orig_hash_lock, flags);
+
+	/* get routing information */
+	orig_node = ((struct orig_node *)hash_find(orig_hash, ethhdr->h_dest));
+
+	/* check for hna host */
+	if (!orig_node)
+		orig_node = transtable_search(ethhdr->h_dest);
+
+	router = find_router(orig_node, NULL);
+
+	if (!router)
+		goto unlock;
+
+	/* don't lock while sending the packets ... we therefore
+		* copy the required data before sending */
+
+	batman_if = router->if_incoming;
+	memcpy(dstaddr, router->addr, ETH_ALEN);
+
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	if (batman_if->if_status != IF_ACTIVE)
+		goto dropped;
+
+	if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
+		goto dropped;
+
+	unicast_packet = (struct unicast_packet *)skb->data;
+
+	unicast_packet->version = COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->packet_type = BAT_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->ttl = TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+
+	send_skb_packet(skb, batman_if, dstaddr);
+	return 0;
+
+unlock:
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+dropped:
+	kfree_skb(skb);
+	return 1;
+}
diff --git a/drivers/staging/batman-adv/unicast.h b/drivers/staging/batman-adv/unicast.h
new file mode 100644
index 0000000..dd00703
--- /dev/null
+++ b/drivers/staging/batman-adv/unicast.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
+ *
+ * Andreas Langer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _NET_BATMAN_ADV_UNICAST_H_
+#define _NET_BATMAN_ADV_UNICAST_H_
+
+int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
+
+#endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.1

