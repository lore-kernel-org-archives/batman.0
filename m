Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Mar 2012 22:51:11 +0100
Message-Id: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201203222250.31309.lindner_marek@yahoo.de>
References: <201203222250.31309.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BRFC_1/5=5D_batman-adv=3A_ELP_-_adding?=
	=?utf-8?q?_basic_infrastructure?=
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

From: Linus Luessing <linus.luessing@web.de>

The B.A.T.M.A.N. protocol originally only used a single message type (called
OGM) to determine the link qualities to the direct neighbors and spreading these
link quality information through the whole mesh. This procedure is summarized on
the BATMAN concept page and explained in details in the RFC draft published in
2008.

This approach was chosen for its simplicity during the protocol design phase and
the implementation. However, it also bears some drawbacks:

 *  Wireless interfaces usually come with some packet loss, therefore a higher
    broadcast rate is desirable to allow a fast reaction on flaky connections.
    Other interfaces of the same host might be connected to Ethernet LANs / VPNs
    / etc which rarely exhibit packet loss would benefit from a lower broadcast
    rate to reduce overhead.
 *  It generally is more desirable to detect local link quality changes at a
    faster rate than propagating all these changes through the entire mesh (the
    far end of the mesh does not need to care about local link quality changes
    that much). Other optimizations strategies, like reducing overhead, might be
    possible if OGMs weren't used for all tasks in the mesh at the same time.

As a result detecting local link qualities shall be handled by an independent
message type, ELP, whereas the OGM message type remains responsible for flooding
the mesh with these link quality information and determining the overall path
transmit qualities.

Developed by Linus during a 6 months trainee study period in Ascom (Switzerland)
AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 README.external        |    1 +
 bat_algo.h             |    6 ++
 bat_v_elp.c            |  175 ++++++++++++++++++++++++++++++++++++++++++++++++
 gen-compat-autoconf.sh |    1 +
 hard-interface.c       |    6 ++
 main.c                 |    1 +
 packet.h               |   14 ++++-
 types.h                |    6 ++
 10 files changed, 212 insertions(+), 1 deletions(-)
 create mode 100644 bat_v_elp.c

diff --git a/Makefile b/Makefile
index ac84fba..3d08354 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,8 @@ export CONFIG_BATMAN_ADV_DEBUG=n
 export CONFIG_BATMAN_ADV_BLA=y
 # B.A.T.M.A.N. distributed ARP table:
 export CONFIG_BATMAN_ADV_DAT=y
+# B.A.T.M.A.N. V routing algorithm (experimental):
+# export CONFIG_BATMAN_ADV_BATMAN_V=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index ad002cd..dcffb7f 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -21,6 +21,7 @@
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
+batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_elp.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
diff --git a/README.external b/README.external
index 95a7eb4..f1ec46a 100644
--- a/README.external
+++ b/README.external
@@ -38,6 +38,7 @@ module).  Available  options  and  their    possible   values are
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
+ * CONFIG_BATMAN_ADV_BATMAN_V=[y|n*] (B.A.T.M.A.N. V routing algorithm)
 
 e.g., debugging can be enabled by
 
diff --git a/bat_algo.h b/bat_algo.h
index 9852a68..2932082 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -24,4 +24,10 @@
 
 int bat_iv_init(void);
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+int bat_v_init(void);
+#else
+#define bat_v_init(...)		{}
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/bat_v_elp.c b/bat_v_elp.c
new file mode 100644
index 0000000..c2dee5c
--- /dev/null
+++ b/bat_v_elp.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
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
+
+static void bat_v_elp_start_timer(struct hard_iface *hard_iface)
+{
+	unsigned long elp_interval;
+
+	elp_interval = msecs_to_jiffies(atomic_read(&hard_iface->elp_interval)
+					 - JITTER + (random32() % 2 * JITTER));
+
+	queue_delayed_work(bat_event_workqueue,
+			   &hard_iface->elp_wq, elp_interval);
+}
+
+static void bat_v_elp_send_outstanding(struct work_struct *work)
+{
+	struct hard_iface *hard_iface;
+	struct bat_priv *bat_priv;
+	struct batman_elp_packet *elp_packet;
+	struct sk_buff *skb;
+
+	hard_iface = container_of(work, struct hard_iface, elp_wq.work);
+	bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
+		goto out;
+
+	if ((hard_iface->if_status == IF_NOT_IN_USE) ||
+	    (hard_iface->if_status == IF_TO_BE_REMOVED))
+		goto out;
+
+	/* the interface was enabled but may not be ready yet */
+	if (hard_iface->if_status != IF_ACTIVE)
+		goto restart_timer;
+
+	skb = skb_copy(hard_iface->elp_skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+
+	elp_packet = (struct batman_elp_packet *)skb->data;
+	elp_packet->seqno = htonl(atomic_read(&hard_iface->elp_seqno));
+	elp_packet->num_neighbors = 0;
+
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Sending elp packet on interface %s, seqno %d\n",
+		hard_iface->net_dev->name, atomic_read(&hard_iface->elp_seqno));
+
+	send_skb_packet(skb, hard_iface, broadcast_addr);
+
+	atomic_inc(&hard_iface->elp_seqno);
+	bat_v_elp_start_timer(hard_iface);
+
+out:
+	return;
+}
+
+static int bat_v_elp_iface_enable(struct hard_iface *hard_iface)
+{
+	struct batman_elp_packet *elp_packet;
+	unsigned long random_seqno;
+	int res = -1;
+
+	INIT_HLIST_HEAD(&hard_iface->neigh_list);
+	spin_lock_init(&hard_iface->neigh_list_lock);
+
+	hard_iface->elp_skb = dev_alloc_skb(ETH_DATA_LEN + ETH_HLEN);
+	if (!hard_iface->elp_skb)
+		goto out;
+
+	skb_reserve(hard_iface->elp_skb, ETH_HLEN + BATMAN_ELP_HLEN);
+	elp_packet = (struct batman_elp_packet *)skb_push(hard_iface->elp_skb,
+							  BATMAN_ELP_HLEN);
+	memset(elp_packet, 0, BATMAN_ELP_HLEN);
+
+	elp_packet->header.packet_type = BAT_V_ELP;
+	elp_packet->header.version = COMPAT_VERSION;
+	elp_packet->header.ttl = 0;
+
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(unsigned long));
+	atomic_set(&hard_iface->elp_seqno, (uint32_t)random_seqno);
+
+	INIT_DELAYED_WORK(&hard_iface->elp_wq, bat_v_elp_send_outstanding);
+	bat_v_elp_start_timer(hard_iface);
+	res = 0;
+
+out:
+	return res;
+}
+
+static void bat_v_elp_iface_disable(struct hard_iface *hard_iface)
+{
+	cancel_delayed_work_sync(&hard_iface->elp_wq);
+
+	dev_kfree_skb(hard_iface->elp_skb);
+	hard_iface->elp_skb = NULL;
+}
+
+static void bat_v_elp_iface_update_mac(struct hard_iface *hard_iface)
+{
+	return;
+}
+
+static void bat_v_elp_primary_iface_set(struct hard_iface *hard_iface)
+{
+	struct hard_iface *hard_iface_tmp;
+	struct batman_elp_packet *elp_packet;
+	struct sk_buff *skb;
+
+	/* update orig field of every elp iface belonging to this mesh */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface_tmp, &hardif_list, list) {
+		if (hard_iface->soft_iface != hard_iface_tmp->soft_iface)
+			continue;
+
+		if (!hard_iface_tmp->elp_skb)
+			continue;
+
+		skb = hard_iface_tmp->elp_skb;
+		elp_packet = (struct batman_elp_packet *)skb->data;
+		memcpy(elp_packet->orig,
+		       hard_iface->net_dev->dev_addr, ETH_ALEN);
+	}
+	rcu_read_unlock();
+}
+
+static void bat_v_ogm_schedule(struct hard_iface *hard_iface,
+			       int tt_num_changes)
+{
+	return;
+}
+
+static void bat_v_ogm_emit(struct forw_packet *forw_packet)
+{
+	return;
+}
+
+
+static struct bat_algo_ops batman_v __read_mostly = {
+	.name = "BATMAN V",
+	.bat_iface_enable = bat_v_elp_iface_enable,
+	.bat_iface_disable = bat_v_elp_iface_disable,
+	.bat_iface_update_mac = bat_v_elp_iface_update_mac,
+	.bat_primary_iface_set = bat_v_elp_primary_iface_set,
+	.bat_ogm_schedule = bat_v_ogm_schedule,
+	.bat_ogm_emit = bat_v_ogm_emit,
+};
+
+int __init bat_v_init(void)
+{
+	return bat_algo_register(&batman_v);
+}
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7ea42aa..f6f32e7 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -39,6 +39,7 @@ gen_config() {
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/hard-interface.c b/hard-interface.c
index daa6adc..e53e143 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -450,6 +450,12 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	atomic_set(&hard_iface->seqno, 1);
 	hard_iface->packet_buff = NULL;
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	atomic_set(&hard_iface->elp_interval, 500);
+	atomic_set(&hard_iface->elp_seqno, 1);
+	hard_iface->elp_skb = NULL;
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 	return hard_iface;
 
 free_if:
diff --git a/main.c b/main.c
index 0757c2d..b83a693 100644
--- a/main.c
+++ b/main.c
@@ -56,6 +56,7 @@ static int __init batman_init(void)
 
 	recv_handler_init();
 
+	bat_v_init();
 	bat_iv_init();
 
 	/* the name should not be longer than 10 chars - see
diff --git a/packet.h b/packet.h
index 3c4c533..cf516dc 100644
--- a/packet.h
+++ b/packet.h
@@ -33,7 +33,8 @@ enum bat_packettype {
 	BAT_UNICAST_FRAG	= 0x06,
 	BAT_TT_QUERY		= 0x07,
 	BAT_ROAM_ADV		= 0x08,
-	BAT_UNICAST_4ADDR	= 0x09
+	BAT_UNICAST_4ADDR	= 0x09,
+	BAT_V_ELP		= 0x10
 };
 
 enum bat_subtype {
@@ -136,6 +137,17 @@ struct batman_ogm_packet {
 
 #define BATMAN_OGM_HLEN sizeof(struct batman_ogm_packet)
 
+/* echo location packet */
+struct batman_elp_packet {
+	struct batman_header header;
+	uint8_t  num_neighbors;
+	uint32_t seqno;
+	uint32_t elp_interval;
+	uint8_t  orig[ETH_ALEN];
+} __packed;
+
+#define BATMAN_ELP_HLEN sizeof(struct batman_elp_packet)
+
 struct icmp_packet {
 	struct batman_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
diff --git a/types.h b/types.h
index 15f538a..86f2250 100644
--- a/types.h
+++ b/types.h
@@ -58,6 +58,12 @@ struct hard_iface {
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	atomic_t elp_interval;
+	atomic_t elp_seqno;
+	struct sk_buff *elp_skb;
+	struct delayed_work elp_wq;
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 };
 
 /**
-- 
1.7.9.1

