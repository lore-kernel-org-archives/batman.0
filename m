Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:03 +0100
Message-Id: <1392122903-805-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 03/23] batman-adv: ELP - adding basic
	infrastructure
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

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
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 Makefile               |   2 +
 Makefile.kbuild        |   2 +
 README.external        |   1 +
 bat_algo.h             |  15 ++++-
 bat_v.c                |  65 ++++++++++++++++++
 bat_v_elp.c            | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
 bat_v_elp.h            |  30 +++++++++
 gen-compat-autoconf.sh |   1 +
 main.c                 |   1 +
 packet.h               |  25 +++++++
 types.h                |  18 +++++
 11 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 bat_v.c
 create mode 100644 bat_v_elp.c
 create mode 100644 bat_v_elp.h

diff --git a/Makefile b/Makefile
index 9a7cbae..405175d 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,8 @@ export CONFIG_BATMAN_ADV_BLA=y
 export CONFIG_BATMAN_ADV_DAT=y
 # B.A.T.M.A.N network coding (catwoman):
 export CONFIG_BATMAN_ADV_NC=n
+# B.A.T.M.A.N. V routing algorithm (experimental):
+# export CONFIG_BATMAN_ADV_BATMAN_V=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 42df18f..ae9a6ca 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -18,6 +18,8 @@
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_iv_ogm.o
+batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v.o
+batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_elp.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += debugfs.o
diff --git a/README.external b/README.external
index c8eac1a..6f0d18b 100644
--- a/README.external
+++ b/README.external
@@ -39,6 +39,7 @@ module).  Available  options  and  their    possible   values are
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
  * CONFIG_BATMAN_ADV_NC=[y|n*] (B.A.T.M.A.N. Network Coding)
+ * CONFIG_BATMAN_ADV_BATMAN_V=[y|n*] (B.A.T.M.A.N. V routing algorithm)
 
 e.g., debugging can be enabled by
 
diff --git a/bat_algo.h b/bat_algo.h
index 4e49666..7289336 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -1,6 +1,6 @@
 /* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
  *
- * Marek Lindner
+ * Marek Lindner, Antonio Quartulli
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
diff --git a/bat_v.c b/bat_v.c
new file mode 100644
index 0000000..7247d7f
--- /dev/null
+++ b/bat_v.c
@@ -0,0 +1,65 @@
+/* Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli
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
+#include "bat_algo.h"
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
+
+int __init batadv_v_init(void)
+{
+	return batadv_algo_register(&batadv_batman_v);
+}
diff --git a/bat_v_elp.c b/bat_v_elp.c
new file mode 100644
index 0000000..45b082b
--- /dev/null
+++ b/bat_v_elp.c
@@ -0,0 +1,179 @@
+/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing, Marek Lindner, Antonio Quartulli
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
+#include "hard-interface.h"
+#include "send.h"
+#include "bat_algo.h"
+#include "bat_v_elp.h"
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
+ * batadv_v_elp_send_outstanding - ELP periodic broadcast sending
+ * @work: work queue item
+ *
+ * Sends a broadcast ELP message over the interface that this work item belongs
+ * to.
+ */
+static void batadv_v_elp_send_outstanding(struct work_struct *work)
+{
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_hard_iface_bat_v *bat_v;
+	struct batadv_priv *bat_priv;
+	struct batadv_elp_packet *elp_packet;
+	uint32_t elp_interval;
+	struct sk_buff *skb;
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
+		goto out;
+
+	elp_packet = (struct batadv_elp_packet *)skb->data;
+	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
+	elp_packet->num_neighbors = 0;
+	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
+	elp_packet->elp_interval = htonl(elp_interval);
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Sending ELP packet on interface %s, seqno %u\n",
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
+ * Returns 0 on success or a -ENOMEM in case of failure.
+ */
+int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_elp_packet *elp_packet;
+	unsigned char *elp_buff;
+	uint32_t random_seqno;
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
+	elp_packet->ttl = 0;
+
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&hard_iface->bat_v.elp_seqno, random_seqno);
+	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+
+	INIT_DELAYED_WORK(&hard_iface->bat_v.elp_wq,
+			  batadv_v_elp_send_outstanding);
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
+ * @hard_iface: the new primary interface
+ */
+void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_hard_iface *hard_iface_tmp;
+	struct batadv_elp_packet *elp_packet;
+	struct sk_buff *skb;
+
+	/* update orig field of every elp iface belonging to this mesh */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != hard_iface_tmp->soft_iface)
+			continue;
+
+		if (!hard_iface_tmp->bat_v.elp_skb)
+			continue;
+
+		skb = hard_iface_tmp->bat_v.elp_skb;
+		elp_packet = (struct batadv_elp_packet *)skb->data;
+		memcpy(elp_packet->orig,
+		       hard_iface->net_dev->dev_addr, ETH_ALEN);
+	}
+	rcu_read_unlock();
+}
diff --git a/bat_v_elp.h b/bat_v_elp.h
new file mode 100644
index 0000000..06d2cb1
--- /dev/null
+++ b/bat_v_elp.h
@@ -0,0 +1,30 @@
+/* Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+ *
+ * Antonio Quartulli
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
+
+#ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
+#define _NET_BATMAN_ADV_BAT_V_ELP_H_
+
+int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
+void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
+void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface);
+
+#endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 78573e4..001707f 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -40,6 +40,7 @@ gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/main.c b/main.c
index fbeaebd..b7d9996 100644
--- a/main.c
+++ b/main.c
@@ -63,6 +63,7 @@ static int __init batadv_init(void)
 
 	batadv_recv_handler_init();
 
+	batadv_v_init();
 	batadv_iv_init();
 	batadv_nc_init();
 
diff --git a/packet.h b/packet.h
index 0a381d1..71b1aeb 100644
--- a/packet.h
+++ b/packet.h
@@ -37,6 +37,7 @@ enum batadv_packettype {
 	BATADV_IV_OGM           = 0x00,
 	BATADV_BCAST            = 0x01,
 	BATADV_CODED            = 0x02,
+	BATADV_ELP		= 0x03,
 	/* 0x40 - 0x7f: unicast */
 #define BATADV_UNICAST_MIN     0x40
 	BATADV_UNICAST          = 0x40,
@@ -192,6 +193,30 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
+ * struct batadv_elp_packet - elp (neighbor discovery) packet
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the genereal header
+ * @ttl: time to live for this packet, part of the genereal header
+ * @num_neighbors: number of already discovered neighbors
+ * @seqno: sequence number
+ * @elp_interval: currently used ELP sending interval
+ * @orig: originator mac address
+ * @align: not used - useful for alignment purposes only
+ */
+struct batadv_elp_packet {
+	uint8_t  packet_type;
+	uint8_t  version;
+	uint8_t  ttl;
+	uint8_t  num_neighbors;
+	__be32	 seqno;
+	__be32	 elp_interval;
+	uint8_t  orig[ETH_ALEN];
+	uint8_t  align[2];
+};
+
+#define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
+
+/**
  * batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
diff --git a/types.h b/types.h
index 9f52517..518fa81 100644
--- a/types.h
+++ b/types.h
@@ -70,6 +70,20 @@ struct batadv_hard_iface_bat_iv {
 };
 
 /**
+ * struct batadv_hard_iface_bat_v - per hard interface B.A.T.M.A.N. V data
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
@@ -83,6 +97,7 @@ struct batadv_hard_iface_bat_iv {
  * @soft_iface: the batman-adv interface which uses this network interface
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: BATMAN IV specific per hard interface data
+ * @bat_v: BATMAN V specific per hard interface data
  * @cleanup_work: work queue callback item for hard interface deinit
  * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
  */
@@ -98,6 +113,9 @@ struct batadv_hard_iface {
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_hard_iface_bat_v bat_v;
+#endif
 	struct work_struct cleanup_work;
 	struct dentry *debug_dir;
 };
-- 
1.8.5.3

