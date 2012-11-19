Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 19 Nov 2012 14:21:59 +0100
Message-Id: <b5f675c75c4dffa2454e635c19c73f7912eb7e74.1353331252.git.martin@hundeboll.net>
In-Reply-To: <cover.1353331252.git.martin@hundeboll.net>
References: <cover.1353331252.git.martin@hundeboll.net>
In-Reply-To: <cover.1353331252.git.martin@hundeboll.net>
References: <cover.1353331252.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Add the initial code for
	network coding.
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Network coding exploits the 802.11 shared medium to allow multiple
packets to be send in a single transmission. In brief, a relay can XOR
two packets, and send the coded packet to two destinations. The
receivers can decode one of the original packets by XOR'ing the coded
packet with the other original packet. This will lead to increased
throughput in topologies where two packets cross one relay.

In a simple topology with three nodes, it takes four transmissions
without network coding to get one packet from Node A to Node B and one
from Node B to Node A:

 1.  Node A  ---- p1 --->  Node R                Node B
 2.  Node A                Node R  <--- p2 ----  Node B
 3.  Node A  <--- p2 ----  Node R                Node B
 4.  Node A                Node R  ---- p1 --->  Node B

With network coding, the relay only needs one transmission, which saves
us one slot of valuable airtime:

 1.  Node A  ---- p1 --->  Node R                Node B
 2.  Node A                Node R  <--- p2 ----  Node B
 3.  Node A  <- p1 x p2 -  Node R  - p1 x p2 ->  Node B

The same principle holds for a topology including five nodes. Here the
packets from Node A and Node B are overheard by Node C and Node D,
respectively. This allows Node R to send a network coded packet to save
one transmission:

   Node A                  Node B

    |     \              /    |
    |      p1          p2     |
    |       \          /      |
    p1       > Node R <       p2
    |                         |
    |         /      \        |
    |    p1 x p2    p1 x p2   |
    v       /          \      v
           /            \
   Node C <              > Node D

More information is available on the open-mesh.org wiki[1].

This patch adds the initial code to support network coding in
batman-adv. It sets up a worker thread to do house keeping and adds a
sysfs file to enable/disable network coding. The feature is disabled by
default, as it requires a wifi-driver with working promiscuous mode, and
also because it adds a small delay at each hop.

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Catwoman

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 Makefile               |  2 ++
 Makefile.kbuild        |  1 +
 gen-compat-autoconf.sh |  1 +
 main.c                 |  6 ++++
 main.h                 |  4 ++-
 network-coding.c       | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h       | 47 +++++++++++++++++++++++++++++
 soft-interface.c       |  3 ++
 sysfs-class-net-mesh   |  8 +++++
 sysfs.c                |  6 ++++
 types.h                | 17 +++++++++++
 11 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 network-coding.c
 create mode 100644 network-coding.h

diff --git a/Makefile b/Makefile
index 4d70e40..d41f947 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,8 @@ export CONFIG_BATMAN_ADV_DEBUG=n
 export CONFIG_BATMAN_ADV_BLA=y
 # B.A.T.M.A.N. distributed ARP table:
 export CONFIG_BATMAN_ADV_DAT=y
+# B.A.T.M.A.N network coding (catwoman):
+export CONFIG_BATMAN_ADV_NC=n
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index e45e3b4..4b8f192 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -30,6 +30,7 @@ batman-adv-y += hard-interface.o
 batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
+batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += ring_buffer.o
 batman-adv-y += routing.o
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7ea42aa..78573e4 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -39,6 +39,7 @@ gen_config() {
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/main.c b/main.c
index 253e240..7971214 100644
--- a/main.c
+++ b/main.c
@@ -35,6 +35,7 @@
 #include "vis.h"
 #include "hash.h"
 #include "bat_algo.h"
+#include "network-coding.h"
 
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
@@ -135,6 +136,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
+	ret = batadv_network_coding_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	atomic_set(&bat_priv->gw.reselect, 0);
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
@@ -157,6 +162,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_gw_node_purge(bat_priv);
 	batadv_originator_free(bat_priv);
+	batadv_network_coding_free(bat_priv);
 
 	batadv_tt_free(bat_priv);
 
diff --git a/main.h b/main.h
index bfae503..1b0cd41 100644
--- a/main.h
+++ b/main.h
@@ -186,6 +186,7 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
  * @BATADV_DBG_TT: translation table messages
  * @BATADV_DBG_BLA: bridge loop avoidance messages
  * @BATADV_DBG_DAT: ARP snooping and DAT related messages
+ * @BATADV_DBG_NC: network coding related messages
  * @BATADV_DBG_ALL: the union of all the above log levels
  */
 enum batadv_dbg_level {
@@ -194,7 +195,8 @@ enum batadv_dbg_level {
 	BATADV_DBG_TT	  = BIT(2),
 	BATADV_DBG_BLA    = BIT(3),
 	BATADV_DBG_DAT    = BIT(4),
-	BATADV_DBG_ALL    = 31,
+	BATADV_DBG_NC	  = BIT(5),
+	BATADV_DBG_ALL    = 63,
 };
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
diff --git a/network-coding.c b/network-coding.c
new file mode 100644
index 0000000..8d930e7
--- /dev/null
+++ b/network-coding.c
@@ -0,0 +1,82 @@
+/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll, Jeppe Ledet-Pedersen
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
+ */
+
+#include "main.h"
+#include "network-coding.h"
+
+static void batadv_nc_worker(struct work_struct *work);
+
+/**
+ * batadv_nc_start_timer - initialise the nc periodic worker
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
+{
+	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->nc.work,
+			   msecs_to_jiffies(10));
+}
+
+/**
+ * batadv_network_coding_init - initialise coding hash table and start
+ *  house keeping
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+int batadv_network_coding_init(struct batadv_priv *bat_priv)
+{
+	batadv_nc_start_timer(bat_priv);
+
+	return 0;
+}
+
+/**
+ * batadv_nc_init_bat_priv - initialise the nc specific bat_priv variables
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
+{
+	atomic_set(&bat_priv->network_coding, 1);
+}
+
+/**
+ * batadv_nc_worker - periodic task for house keeping related to network coding
+ * @work: kernel work struct
+ */
+static void batadv_nc_worker(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_priv_nc *priv_nc;
+	struct batadv_priv *bat_priv;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	priv_nc = container_of(delayed_work, struct batadv_priv_nc, work);
+	bat_priv = container_of(priv_nc, struct batadv_priv, nc);
+
+	/* Schedule a new check */
+	batadv_nc_start_timer(bat_priv);
+}
+
+/**
+ * batadv_network_coding_free - clean up network coding memory
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_network_coding_free(struct batadv_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->nc.work);
+}
diff --git a/network-coding.h b/network-coding.h
new file mode 100644
index 0000000..7151b49
--- /dev/null
+++ b/network-coding.h
@@ -0,0 +1,47 @@
+/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll, Jeppe Ledet-Pedersen
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
+ */
+
+#ifndef _NET_BATMAN_ADV_NETWORK_CODING_H
+#define _NET_BATMAN_ADV_NETWORK_CODING_H
+
+#ifdef CONFIG_BATMAN_ADV_NC
+int batadv_network_coding_init(struct batadv_priv *bat_priv);
+void batadv_network_coding_free(struct batadv_priv *bat_priv);
+void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
+
+#else /* ifdef CONFIG_BATMAN_ADV_NC */
+
+static inline int batadv_network_coding_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline void batadv_network_coding_free(struct batadv_priv *bat_priv)
+{
+	return;
+}
+
+static inline void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
+{
+	return;
+}
+
+#endif /* ifdef CONFIG_BATMAN_ADV_NC */
+
+#endif /* _NET_BATMAN_ADV_NETWORK_CODING_H */
diff --git a/soft-interface.c b/soft-interface.c
index 8000639..8733558 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -36,6 +36,7 @@
 #include <linux/if_vlan.h>
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
+#include "network-coding.h"
 
 
 static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
@@ -514,6 +515,8 @@ struct net_device *batadv_softif_create(const char *name)
 	if (ret < 0)
 		goto unreg_soft_iface;
 
+	batadv_nc_init_bat_priv(bat_priv);
+
 	ret = batadv_sysfs_add_meshif(soft_iface);
 	if (ret < 0)
 		goto unreg_soft_iface;
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index bc41da6..c75e594 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -74,6 +74,14 @@ Description:
                 Defines the interval in milliseconds in which batman
                 sends its protocol messages.
 
+What:           /sys/class/net/<mesh_iface>/mesh/network_coding
+Date:           Nov 2012
+Contact:        Martin Hundeboll <martin@hundeboll.net>
+Description:
+                Controls whether Network Coding (using some magic
+                to send fewer wifi packets but still the same
+                content) is enabled or not.
+
 What:           /sys/class/net/<mesh_iface>/mesh/routing_algo
 Date:           Dec 2011
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
diff --git a/sysfs.c b/sysfs.c
index 84a55cb..e48a62b 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -442,6 +442,9 @@ static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
+#ifdef CONFIG_BATMAN_ADV_NC
+BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR, NULL);
+#endif
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_aggregated_ogms,
@@ -464,6 +467,9 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&batadv_attr_log_level,
 #endif
+#ifdef CONFIG_BATMAN_ADV_NC
+	&batadv_attr_network_coding,
+#endif
 	NULL,
 };
 
diff --git a/types.h b/types.h
index ae9ac9a..5451fc8 100644
--- a/types.h
+++ b/types.h
@@ -265,6 +265,19 @@ struct batadv_priv_dat {
 };
 #endif
 
+/**
+ * struct batadv_priv_nc - per mesh interface network coding private data
+ * @work: work queue callback item for cleanup
+ */
+struct batadv_priv_nc {
+	struct delayed_work work;
+};
+
+/**
+ * struct batadv_priv - per mesh interface private data
+ * @network_coding: enable/disable network coding
+ * @batadv_priv_nc: network coding private data
+ */
 struct batadv_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
@@ -308,6 +321,10 @@ struct batadv_priv {
 #ifdef CONFIG_BATMAN_ADV_DAT
 	struct batadv_priv_dat dat;
 #endif
+#ifdef CONFIG_BATMAN_ADV_NC
+	atomic_t network_coding; /* boolean */
+	struct batadv_priv_nc nc;
+#endif /* CONFIG_BATMAN_ADV_NC */
 };
 
 struct batadv_socket_client {
-- 
1.8.0

