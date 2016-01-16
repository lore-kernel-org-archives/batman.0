Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:40:09 +0800
Message-Id: <1452933619-6712-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 02/12] batman-adv: ELP - adding basic
	infrastructure
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Linus Luessing <linus.luessing@web.de>

The B.A.T.M.A.N. protocol originally only used a single
message type (called OGM) to determine the link qualities to
the direct neighbors and spreading these link quality
information through the whole mesh. This procedure is
summarized on the BATMAN concept page and explained in
details in the RFC draft published in 2008.

This approach was chosen for its simplicity during the
protocol design phase and the implementation. However, it
also bears some drawbacks:

 *  Wireless interfaces usually come with some packet loss,
    therefore a higher broadcast rate is desirable to allow
    a fast reaction on flaky connections.
    Other interfaces of the same host might be connected to
    Ethernet LANs / VPNs / etc which rarely exhibit packet
    loss would benefit from a lower broadcast rate to reduce
    overhead.
 *  It generally is more desirable to detect local link
    quality changes at a faster rate than propagating all
    these changes through the entire mesh (the far end of
    the mesh does not need to care about local link quality
    changes that much). Other optimizations strategies, like
    reducing overhead, might be possible if OGMs weren't
    used for all tasks in the mesh at the same time.

As a result detecting local link qualities shall be handled
by an independent message type, ELP, whereas the OGM message
type remains responsible for flooding the mesh with these
link quality information and determining the overall path
transmit qualities.

Developed by Linus during a 6 months trainee study period in
Ascom (Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 Makefile                   |   3 +
 README.external            |   1 +
 gen-compat-autoconf.sh     |   1 +
 net/batman-adv/Kconfig     |  14 ++++
 net/batman-adv/Makefile    |   2 +
 net/batman-adv/bat_algo.h  |  15 +++-
 net/batman-adv/bat_v.c     |  74 +++++++++++++++++
 net/batman-adv/bat_v_elp.c | 193 +++++++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v_elp.h |  27 +++++++
 net/batman-adv/main.c      |   1 +
 net/batman-adv/packet.h    |  20 +++++
 net/batman-adv/types.h     |  18 +++++
 12 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 net/batman-adv/bat_v.c
 create mode 100644 net/batman-adv/bat_v_elp.c
 create mode 100644 net/batman-adv/bat_v_elp.h

diff --git a/Makefile b/Makefile
index 5865f89..5d2c058 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,8 @@ export CONFIG_BATMAN_ADV_DAT=y
 export CONFIG_BATMAN_ADV_NC=n
 # B.A.T.M.A.N. multicast optimizations:
 export CONFIG_BATMAN_ADV_MCAST=y
+# B.A.T.M.A.N. V routing algorithm (experimental):
+export CONFIG_BATMAN_ADV_BATMAN_V=n
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
@@ -58,6 +60,7 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_DAT=$(CONFIG_BATMAN_ADV_DAT) \
 	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
 	CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
+	CONFIG_BATMAN_ADV_BATMAN_V=$(CONFIG_BATMAN_ADV_BATMAN_V) \
 	INSTALL_MOD_DIR=updates/net/batman-adv/
 
 all: config
diff --git a/README.external b/README.external
index 9793c11..963343e 100644
--- a/README.external
+++ b/README.external
@@ -40,6 +40,7 @@ module).  Available  options  and  their    possible   values are
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
  * CONFIG_BATMAN_ADV_MCAST=[y*|n] (B.A.T.M.A.N. multicast optimizations)
  * CONFIG_BATMAN_ADV_NC=[y|n*] (B.A.T.M.A.N. Network Coding)
+ * CONFIG_BATMAN_ADV_BATMAN_V=[y|n*] (B.A.T.M.A.N. V routing algorithm)
 
 e.g., debugging can be enabled by
 
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 5a9a4e4..396357a 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -41,6 +41,7 @@ gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 2dd40e5..5c148a8 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -15,6 +15,20 @@ config BATMAN_ADV
           https://www.open-mesh.org/ for more information and user space
           tools.
 
+config BATMAN_ADV_BATMAN_V
+	bool "B.A.T.M.A.N. V protocol (experimental)"
+	depends on BATMAN_ADV
+	default n
+	help
+	  This option enables the B.A.T.M.A.N. V protocol, the successor
+	  of the currently used B.A.T.M.A.N. IV protocol. The main
+	  changes include splitting of the OGM protocol into a neighbor
+	  discovery protocol (Echo Location Protocol, ELP) and a new OGM
+	  Protocol OGMv2 for flooding protocol information through the
+	  network, as well as a throughput based metric.
+	  B.A.T.M.A.N. V is currently considered experimental and not
+	  compatible to B.A.T.M.A.N. IV networks.
+
 config BATMAN_ADV_BLA
 	bool "Bridge Loop Avoidance"
 	depends on BATMAN_ADV && INET
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 207e2af..ca51686 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -18,6 +18,8 @@
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_iv_ogm.o
+batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v.o
+batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_elp.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-$(CONFIG_DEBUG_FS) += debugfs.o
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index a7485d6..a4e994e 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,6 +1,6 @@
 /* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
  *
- * Marek Lindner
+ * Marek Lindner, Linus Lüssing
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
@@ -20,4 +20,17 @@
 
 int batadv_iv_init(void);
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
+int batadv_v_init(void);
+
+#else
+
+static inline int batadv_v_init(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
new file mode 100644
index 0000000..01327f6
--- /dev/null
+++ b/net/batman-adv/bat_v.c
@@ -0,0 +1,74 @@
+/* Copyright (C) 2013-2016 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing, Marek Lindner
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "bat_algo.h"
+#include "main.h"
+
+#include <linux/cache.h>
+#include <linux/init.h>
+
+#include "bat_v_elp.h"
+
+static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
+{
+	return batadv_v_elp_iface_enable(hard_iface);
+}
+
+static void batadv_v_iface_disable(struct batadv_hard_iface *hard_iface)
+{
+	batadv_v_elp_iface_disable(hard_iface);
+}
+
+static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
+{
+}
+
+static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
+{
+	batadv_v_elp_primary_iface_set(hard_iface);
+}
+
+static void batadv_v_ogm_schedule(struct batadv_hard_iface *hard_iface)
+{
+}
+
+static void batadv_v_ogm_emit(struct batadv_forw_packet *forw_packet)
+{
+}
+
+static struct batadv_algo_ops batadv_batman_v __read_mostly = {
+	.name = "BATMAN_V",
+	.bat_iface_enable = batadv_v_iface_enable,
+	.bat_iface_disable = batadv_v_iface_disable,
+	.bat_iface_update_mac = batadv_v_iface_update_mac,
+	.bat_primary_iface_set = batadv_v_primary_iface_set,
+	.bat_ogm_emit = batadv_v_ogm_emit,
+	.bat_ogm_schedule = batadv_v_ogm_schedule,
+};
+
+/**
+ * batadv_v_init - B.A.T.M.A.N. V initialization function
+ *
+ * Description: Takes care of initializing all the subcomponents.
+ * It is invoked upon module load only.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int __init batadv_v_init(void)
+{
+	return batadv_algo_register(&batadv_batman_v);
+}
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
new file mode 100644
index 0000000..bc6e046
--- /dev/null
+++ b/net/batman-adv/bat_v_elp.c
@@ -0,0 +1,193 @@
+/* Copyright (C) 2011-2016 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing, Marek Lindner
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "bat_v_elp.h"
+#include "main.h"
+
+#include <linux/atomic.h>
+#include <linux/byteorder/generic.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/fs.h>
+#include <linux/if_ether.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/random.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "bat_algo.h"
+#include "hard-interface.h"
+#include "packet.h"
+#include "send.h"
+
+/**
+ * batadv_v_elp_start_timer - restart timer for ELP periodic work
+ * @hard_iface: the interface for which the timer has to be reset
+ */
+static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
+{
+	unsigned int msecs;
+
+	msecs = atomic_read(&hard_iface->bat_v.elp_interval) - BATADV_JITTER;
+	msecs += prandom_u32() % (2 * BATADV_JITTER);
+
+	queue_delayed_work(batadv_event_workqueue, &hard_iface->bat_v.elp_wq,
+			   msecs_to_jiffies(msecs));
+}
+
+/**
+ * batadv_v_elp_periodic_work - ELP periodic task per interface
+ * @work: work queue item
+ *
+ * Emits broadcast ELP message in regular intervals.
+ */
+static void batadv_v_elp_periodic_work(struct work_struct *work)
+{
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_hard_iface_bat_v *bat_v;
+	struct batadv_elp_packet *elp_packet;
+	struct batadv_priv *bat_priv;
+	struct sk_buff *skb;
+	u32 elp_interval;
+
+	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
+	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
+	bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+		goto out;
+
+	/* we are in the process of shutting this interface down */
+	if ((hard_iface->if_status == BATADV_IF_NOT_IN_USE) ||
+	    (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED))
+		goto out;
+
+	/* the interface was enabled but may not be ready yet */
+	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+		goto restart_timer;
+
+	skb = skb_copy(hard_iface->bat_v.elp_skb, GFP_ATOMIC);
+	if (!skb)
+		goto restart_timer;
+
+	elp_packet = (struct batadv_elp_packet *)skb->data;
+	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
+	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
+	elp_packet->elp_interval = htonl(elp_interval);
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Sending broadcast ELP packet on interface %s, seqno %u\n",
+		   hard_iface->net_dev->name,
+		   atomic_read(&hard_iface->bat_v.elp_seqno));
+
+	batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+
+	atomic_inc(&hard_iface->bat_v.elp_seqno);
+
+restart_timer:
+	batadv_v_elp_start_timer(hard_iface);
+out:
+	return;
+}
+
+/**
+ * batadv_v_elp_iface_enable - setup the ELP interface private resources
+ * @hard_iface: interface for which the data has to be prepared
+ *
+ * Return: 0 on success or a -ENOMEM in case of failure.
+ */
+int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_elp_packet *elp_packet;
+	unsigned char *elp_buff;
+	u32 random_seqno;
+	size_t size;
+	int res = -ENOMEM;
+
+	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
+	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
+	if (!hard_iface->bat_v.elp_skb)
+		goto out;
+
+	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
+	elp_buff = skb_push(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_packet = (struct batadv_elp_packet *)elp_buff;
+	memset(elp_packet, 0, BATADV_ELP_HLEN);
+
+	elp_packet->packet_type = BATADV_ELP;
+	elp_packet->version = BATADV_COMPAT_VERSION;
+
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&hard_iface->bat_v.elp_seqno, random_seqno);
+	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+
+	INIT_DELAYED_WORK(&hard_iface->bat_v.elp_wq,
+			  batadv_v_elp_periodic_work);
+	batadv_v_elp_start_timer(hard_iface);
+	res = 0;
+
+out:
+	return res;
+}
+
+/**
+ * batadv_v_elp_iface_disable - release ELP interface private resources
+ * @hard_iface: interface for which the resources have to be released
+ */
+void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
+{
+	cancel_delayed_work_sync(&hard_iface->bat_v.elp_wq);
+
+	dev_kfree_skb(hard_iface->bat_v.elp_skb);
+	hard_iface->bat_v.elp_skb = NULL;
+}
+
+/**
+ * batadv_v_elp_primary_iface_set - change internal data to reflect the new
+ *  primary interface
+ * @primary_iface: the new primary interface
+ */
+void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
+{
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_elp_packet *elp_packet;
+	struct sk_buff *skb;
+
+	/* update orig field of every elp iface belonging to this mesh */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (primary_iface->soft_iface != hard_iface->soft_iface)
+			continue;
+
+		if (!hard_iface->bat_v.elp_skb)
+			continue;
+
+		skb = hard_iface->bat_v.elp_skb;
+		elp_packet = (struct batadv_elp_packet *)skb->data;
+		ether_addr_copy(elp_packet->orig,
+				primary_iface->net_dev->dev_addr);
+	}
+	rcu_read_unlock();
+}
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
new file mode 100644
index 0000000..7a584d1
--- /dev/null
+++ b/net/batman-adv/bat_v_elp.h
@@ -0,0 +1,27 @@
+/* Copyright (C) 2013-2016 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing, Marek Lindner
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "main.h"
+
+#ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
+#define _NET_BATMAN_ADV_BAT_V_ELP_H_
+
+int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
+void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
+void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
+
+#endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e3d7051..2160572 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -87,6 +87,7 @@ static int __init batadv_init(void)
 
 	batadv_recv_handler_init();
 
+	batadv_v_init();
 	batadv_iv_init();
 	batadv_nc_init();
 
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index e7f9151..c698b64 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -26,6 +26,7 @@
  * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
  * @BATADV_BCAST: broadcast packets carrying broadcast payload
  * @BATADV_CODED: network coded packets
+ * @BATADV_ELP: echo location packets for B.A.T.M.A.N. V
  *
  * @BATADV_UNICAST: unicast packets carrying unicast payload traffic
  * @BATADV_UNICAST_FRAG: unicast packets carrying a fragment of the original
@@ -40,6 +41,7 @@ enum batadv_packettype {
 	BATADV_IV_OGM           = 0x00,
 	BATADV_BCAST            = 0x01,
 	BATADV_CODED            = 0x02,
+	BATADV_ELP		= 0x03,
 	/* 0x40 - 0x7f: unicast */
 #define BATADV_UNICAST_MIN     0x40
 	BATADV_UNICAST          = 0x40,
@@ -235,6 +237,24 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
+ * struct batadv_elp_packet - elp (neighbor discovery) packet
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the genereal header
+ * @orig: originator mac address
+ * @seqno: sequence number
+ * @elp_interval: currently used ELP sending interval in ms
+ */
+struct batadv_elp_packet {
+	u8     packet_type;
+	u8     version;
+	u8     orig[ETH_ALEN];
+	__be32 seqno;
+	__be32 elp_interval;
+};
+
+#define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
+
+/**
  * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 612de23..992d5fd 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -86,6 +86,20 @@ struct batadv_hard_iface_bat_iv {
 };
 
 /**
+ * struct batadv_hard_iface_bat_v - per hard-interface B.A.T.M.A.N. V data
+ * @elp_interval: time interval between two ELP transmissions
+ * @elp_seqno: current ELP sequence number
+ * @elp_skb: base skb containing the ELP message to send
+ * @elp_wq: workqueue used to schedule ELP transmissions
+ */
+struct batadv_hard_iface_bat_v {
+	atomic_t elp_interval;
+	atomic_t elp_seqno;
+	struct sk_buff *elp_skb;
+	struct delayed_work elp_wq;
+};
+
+/**
  * struct batadv_hard_iface - network device known to batman-adv
  * @list: list node for batadv_hardif_list
  * @if_num: identificator of the interface
@@ -99,6 +113,7 @@ struct batadv_hard_iface_bat_iv {
  * @soft_iface: the batman-adv interface which uses this network interface
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: per hard-interface B.A.T.M.A.N. IV data
+ * @bat_v: per hard-interface B.A.T.M.A.N. V data
  * @cleanup_work: work queue callback item for hard-interface deinit
  * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
  * @neigh_list: list of unique single hop neighbors via this interface
@@ -116,6 +131,9 @@ struct batadv_hard_iface {
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_hard_iface_bat_v bat_v;
+#endif
 	struct work_struct cleanup_work;
 	struct dentry *debug_dir;
 	struct hlist_head neigh_list;
-- 
2.7.0.rc3

