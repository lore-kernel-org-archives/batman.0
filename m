Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:07 +0100
Message-Id: <1392122903-805-8-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 07/23] batman-adv: OGMv2 - add basic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This is the initial implementation of the new OGM protocol
(version 2). It has been designed to work on top of the
newly added ELP.

In the previous version the OGM protocol was used to both
measure link qualities and flood the network with the metric
information. In this version the protocol is in charge of
the latter task only, leaving the former to ELP.

This means being able to decouple the interval used by the
neighbor discovery from the OGM broadcasting, which revealed
to be costly in dense networks and needed to be relaxed so
leading to a less responsive routing protocol.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 Makefile.kbuild |   1 +
 bat_algo.h      |  11 +++
 bat_v.c         |  36 ++++++++-
 bat_v_elp.c     |  11 ++-
 bat_v_ogm.c     | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat_v_ogm.h     |  32 ++++++++
 main.c          |  31 +++++++-
 main.h          |   1 +
 packet.h        |  25 ++++++
 types.h         |  15 ++++
 10 files changed, 385 insertions(+), 8 deletions(-)
 create mode 100644 bat_v_ogm.c
 create mode 100644 bat_v_ogm.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index ae9a6ca..8073940 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -20,6 +20,7 @@ obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v.o
 batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_elp.o
+batman-adv-$(CONFIG_BATMAN_ADV_BATMAN_V) += bat_v_ogm.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
 batman-adv-y += debugfs.o
diff --git a/bat_algo.h b/bat_algo.h
index 7289336..14cf89f 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -23,6 +23,8 @@ int batadv_iv_init(void);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 int batadv_v_init(void);
+int batadv_v_mesh_init(struct batadv_priv *bat_priv);
+void batadv_v_mesh_free(struct batadv_priv *bat_priv);
 
 #else
 
@@ -31,6 +33,15 @@ static inline int batadv_v_init(void)
 	return 0;
 }
 
+static inline int batadv_v_mesh_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline void batadv_v_mesh_free(struct batadv_priv *bat_priv)
+{
+}
+
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
 
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/bat_v.c b/bat_v.c
index bed5e00..b4214c5 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -20,10 +20,21 @@
 #include "main.h"
 #include "bat_algo.h"
 #include "bat_v_elp.h"
+#include "bat_v_ogm.h"
 
 static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 {
-	return batadv_v_elp_iface_enable(hard_iface);
+	int ret;
+
+	ret = batadv_v_elp_iface_enable(hard_iface);
+	if (ret < 0)
+		return ret;
+
+	ret = batadv_v_ogm_iface_enable(hard_iface);
+	if (ret < 0)
+		batadv_v_elp_iface_disable(hard_iface);
+
+	return ret;
 }
 
 static void batadv_v_iface_disable(struct batadv_hard_iface *hard_iface)
@@ -38,6 +49,7 @@ static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
 static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
 {
 	batadv_v_elp_primary_iface_set(hard_iface);
+	batadv_v_ogm_primary_iface_set(hard_iface);
 }
 
 static void batadv_v_ogm_schedule(struct batadv_hard_iface *hard_iface)
@@ -58,6 +70,15 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
 };
 
+int batadv_v_mesh_init(struct batadv_priv *bat_priv)
+{
+	return batadv_v_ogm_init(bat_priv);
+}
+
+void batadv_v_mesh_free(struct batadv_priv *bat_priv)
+{
+	batadv_v_ogm_free(bat_priv);
+}
 
 int __init batadv_v_init(void)
 {
@@ -67,15 +88,24 @@ int __init batadv_v_init(void)
 	ret = batadv_recv_handler_register(BATADV_ELP,
 					   batadv_v_elp_packet_recv);
 	if (ret < 0)
+		return ret;
+
+	ret = batadv_recv_handler_register(BATADV_OGM2,
+					   batadv_v_ogm_packet_recv);
+	if (ret < 0)
 		goto elp_unregister;
 
 	ret = batadv_algo_register(&batadv_batman_v);
+	if (ret < 0)
+		goto ogm_unregister;
 
 	return ret;
 
+ogm_unregister:
+	batadv_recv_handler_unregister(BATADV_OGM2);
+
 elp_unregister:
-	if (ret < 0)
-		batadv_recv_handler_unregister(BATADV_ELP);
+	batadv_recv_handler_unregister(BATADV_ELP);
 
 	return ret;
 }
diff --git a/bat_v_elp.c b/bat_v_elp.c
index 9c40415..1c23951 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -25,6 +25,7 @@
 #include "bat_v_elp.h"
 #include "originator.h"
 #include "routing.h"
+#include "translation-table.h"
 
 /**
  * batadv_v_elp_start_timer - restart timer for ELP periodic work
@@ -276,11 +277,15 @@ void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hard_iface *hard_iface_tmp;
 	struct batadv_elp_packet *elp_packet;
+	struct batadv_ogm2_packet *ogm2;
 	struct sk_buff *skb;
 
-	/* update orig field of every elp iface belonging to this mesh */
+	/* update orig field of every elp and ogm iface belonging to this
+	 * mesh
+	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface != hard_iface_tmp->soft_iface)
@@ -293,6 +298,9 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface)
 		elp_packet = (struct batadv_elp_packet *)skb->data;
 		memcpy(elp_packet->orig,
 		       hard_iface->net_dev->dev_addr, ETH_ALEN);
+
+		ogm2 = (struct batadv_ogm2_packet *)bat_priv->bat_v.ogm_buff;
+		memcpy(ogm2->orig, hard_iface->net_dev->dev_addr, ETH_ALEN);
 	}
 	rcu_read_unlock();
 }
@@ -311,6 +319,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 				      uint8_t *neigh_addr,
 				      struct batadv_hard_iface *if_incoming,
 				      struct batadv_elp_packet *elp_packet)
+
 {
 	struct batadv_elp_neigh_node *neigh;
 
diff --git a/bat_v_ogm.c b/bat_v_ogm.c
new file mode 100644
index 0000000..f66dc02
--- /dev/null
+++ b/bat_v_ogm.c
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2013 B.A.T.M.A.N. contributors:
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
+#include "bat_v_ogm.h"
+#include "hard-interface.h"
+#include "originator.h"
+#include "routing.h"
+#include "send.h"
+#include "translation-table.h"
+
+static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
+{
+	unsigned long msecs;
+	/* this function may be invoked in different contexts (ogm rescheduling
+	 * or hard_iface activation), but the work timer should not be reset
+	 */
+	if (delayed_work_pending(&bat_priv->bat_v.ogm_wq))
+		return;
+
+	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
+	msecs += prandom_u32() % (2 * BATADV_JITTER);
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.ogm_wq,
+			   msecs_to_jiffies(msecs));
+}
+
+/* send a batman ogm to a given interface */
+static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
+				    struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct sk_buff *tmp_skb;
+
+	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+		return;
+
+	tmp_skb = skb_clone(skb, GFP_ATOMIC);
+	if (!tmp_skb)
+		return;
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
+	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
+			   tmp_skb->len + ETH_HLEN);
+
+	batadv_send_skb_packet(tmp_skb, hard_iface, batadv_broadcast_addr);
+}
+
+static void batadv_v_ogm_send(struct work_struct *work)
+{
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv_bat_v *bat_v;
+	struct batadv_priv *bat_priv;
+	struct batadv_ogm2_packet *ogm2;
+	struct sk_buff *skb;
+	unsigned char *ogm_buff, *pkt_buff;
+	int ogm_buff_len;
+	uint16_t tvlv_len = 0;
+
+	bat_v = container_of(work, struct batadv_priv_bat_v, ogm_wq.work);
+	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
+
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
+		goto out;
+
+	ogm_buff = bat_priv->bat_v.ogm_buff;
+	ogm_buff_len = bat_priv->bat_v.ogm_buff_len;
+	/* tt changes have to be committed before the tvlv data is
+	 * appended as it may alter the tt tvlv container
+	 */
+	batadv_tt_local_commit_changes(bat_priv);
+	tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, &ogm_buff,
+						    &ogm_buff_len,
+						    BATADV_OGM2_HLEN);
+
+	bat_priv->bat_v.ogm_buff = ogm_buff;
+	bat_priv->bat_v.ogm_buff_len = ogm_buff_len;
+
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff_len);
+	if (!skb)
+		goto out;
+
+	skb_reserve(skb, ETH_HLEN);
+	pkt_buff = skb_put(skb, ogm_buff_len);
+	memcpy(pkt_buff, ogm_buff, ogm_buff_len);
+
+	ogm2 = (struct batadv_ogm2_packet *)skb->data;
+	ogm2->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
+	atomic_inc(&bat_priv->bat_v.ogm_seqno);
+	ogm2->tvlv_len = htons(tvlv_len);
+
+	/* broadcast on every interface */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Sending own OGM2 packet (originator %pM, seqno %u, metric %u, TTL %d) on interface %s [%pM]\n",
+			   ogm2->orig, ntohl(ogm2->seqno), ntohl(ogm2->metric),
+			   ogm2->ttl, hard_iface->net_dev->name,
+			   hard_iface->net_dev->dev_addr);
+
+		batadv_v_ogm_send_to_if(skb, hard_iface);
+	}
+	rcu_read_unlock();
+
+	consume_skb(skb);
+
+	batadv_v_ogm_start_timer(bat_priv);
+out:
+	return;
+}
+
+int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	batadv_v_ogm_start_timer(bat_priv);
+
+	return 0;
+}
+
+void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_hard_iface *hard_iface_tmp;
+	struct batadv_ogm2_packet *ogm2;
+
+	/* update orig field of every elp and ogm iface belonging to this
+	 * mesh
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != hard_iface_tmp->soft_iface)
+			continue;
+
+		if (!hard_iface_tmp->bat_v.elp_skb)
+			continue;
+
+		ogm2 = (struct batadv_ogm2_packet *)bat_priv->bat_v.ogm_buff;
+		memcpy(ogm2->orig, hard_iface->net_dev->dev_addr, ETH_ALEN);
+	}
+	rcu_read_unlock();
+}
+
+int batadv_v_ogm_packet_recv(struct sk_buff *skb,
+			      struct batadv_hard_iface *if_incoming)
+{	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct batadv_ogm2_packet *ogm2;
+
+	/* did we receive a OGM2 packet on an interface that does not have
+	 * B.A.T.M.A.N. V enabled ?
+	 */
+	if (strcmp(bat_priv->bat_algo_ops->name, "BATMAN_V") != 0)
+		return NET_RX_DROP;
+
+	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
+		return NET_RX_DROP;
+
+	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
+		return NET_RX_DROP;
+
+	ogm2 = (struct batadv_ogm2_packet *)skb->data;
+
+	if (batadv_is_my_mac(bat_priv, ogm2->orig))
+		return NET_RX_DROP;
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_RX_BYTES,
+			   skb->len + ETH_HLEN);
+
+	consume_skb(skb);
+	return NET_RX_SUCCESS;
+}
+
+int batadv_v_ogm_init(struct batadv_priv *bat_priv)
+{
+	struct batadv_ogm2_packet *ogm2;
+	unsigned char *ogm_buff;
+	uint32_t random_seqno;
+
+	bat_priv->bat_v.ogm_buff_len = BATADV_OGM2_HLEN;
+	ogm_buff = kmalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
+	if (!ogm_buff)
+		return -ENOMEM;
+
+	bat_priv->bat_v.ogm_buff = ogm_buff;
+	ogm2 = (struct batadv_ogm2_packet *)ogm_buff;
+	ogm2->packet_type = BATADV_OGM2;
+	ogm2->version = BATADV_COMPAT_VERSION;
+	ogm2->ttl = BATADV_TTL;
+	ogm2->flags = BATADV_NO_FLAGS;
+	ogm2->metric = htonl(BATADV_MAX_METRIC);
+
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&bat_priv->bat_v.ogm_seqno, random_seqno);
+	INIT_DELAYED_WORK(&bat_priv->bat_v.ogm_wq, batadv_v_ogm_send);
+
+	return 0;
+}
+
+void batadv_v_ogm_free(struct batadv_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->bat_v.ogm_wq);
+
+	kfree(bat_priv->bat_v.ogm_buff);
+	bat_priv->bat_v.ogm_buff = NULL;
+	bat_priv->bat_v.ogm_buff_len = 0;
+}
diff --git a/bat_v_ogm.h b/bat_v_ogm.h
new file mode 100644
index 0000000..7f7341e
--- /dev/null
+++ b/bat_v_ogm.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2013 B.A.T.M.A.N. contributors:
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
+#ifndef _BATAMAN_ADV_BATADV_V_OGM_H_
+#define _BATAMAN_ADV_BATADV_V_OGM_H_
+
+int batadv_v_ogm_init(struct batadv_priv *bat_priv);
+void batadv_v_ogm_free(struct batadv_priv *bat_priv);
+int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface);
+void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface);
+int batadv_v_ogm_packet_recv(struct sk_buff *skb,
+			      struct batadv_hard_iface *if_incoming);
+
+#endif /* _BATAMAN_ADV_BATADV_V_OGM_H_ */
diff --git a/main.c b/main.c
index b7d9996..424fa82 100644
--- a/main.c
+++ b/main.c
@@ -35,6 +35,7 @@
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "gateway_common.h"
+#include "hard-interface.h"
 #include "hash.h"
 #include "bat_algo.h"
 #include "network-coding.h"
@@ -125,6 +126,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
 	INIT_HLIST_HEAD(&bat_priv->softif_vlan_list);
 
+	ret = batadv_v_mesh_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	ret = batadv_originator_init(bat_priv);
 	if (ret < 0)
 		goto err;
@@ -165,6 +170,8 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 
+	batadv_v_mesh_free(bat_priv);
+
 	batadv_gw_node_purge(bat_priv);
 	batadv_nc_mesh_free(bat_priv);
 	batadv_dat_free(bat_priv);
@@ -835,21 +842,32 @@ uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_container *tvlv;
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	uint16_t tvlv_value_len;
+	uint16_t tvlv_value_len = 0;
 	void *tvlv_value;
 	bool ret;
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto end;
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_value_len = batadv_tvlv_container_list_size(bat_priv);
 
+	if (packet_min_len + tvlv_value_len > primary_if->net_dev->mtu) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "OGM size too big to fit the primary_if mtu\n");
+		goto unlock;
+	}
+
 	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
 					      packet_min_len, tvlv_value_len);
 
 	if (!ret)
-		goto end;
+		goto unlock;
 
 	if (!tvlv_value_len)
-		goto end;
+		goto unlock;
 
 	tvlv_value = (*packet_buff) + packet_min_len;
 
@@ -863,8 +881,13 @@ uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 		tvlv_value = (uint8_t *)tvlv_value + ntohs(tvlv->tvlv_hdr.len);
 	}
 
-end:
+unlock:
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
+
+end:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+
 	return tvlv_value_len;
 }
 
diff --git a/main.h b/main.h
index 4ab3216..4badd01 100644
--- a/main.h
+++ b/main.h
@@ -30,6 +30,7 @@
 /* B.A.T.M.A.N. parameters */
 
 #define BATADV_TQ_MAX_VALUE 255
+#define BATADV_MAX_METRIC 0xFFFFFFFF
 #define BATADV_JITTER 20
 
 /* Time To Live of broadcast messages */
diff --git a/packet.h b/packet.h
index 71b1aeb..a985802 100644
--- a/packet.h
+++ b/packet.h
@@ -38,6 +38,7 @@ enum batadv_packettype {
 	BATADV_BCAST            = 0x01,
 	BATADV_CODED            = 0x02,
 	BATADV_ELP		= 0x03,
+	BATADV_OGM2		= 0x0d,
 	/* 0x40 - 0x7f: unicast */
 #define BATADV_UNICAST_MIN     0x40
 	BATADV_UNICAST          = 0x40,
@@ -193,6 +194,30 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
+ * struct batadv_ogm2_packet - ogm2 (routing protocol) packet
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the general header
+ * @ttl: time to live for this packet, part of the general header
+ * @flags:
+ * @seqno: sequence number
+ * @orig: originator mac address
+ * @tvlv_len: length of the appended tvlv buffer (in bytes)
+ * @metric: the currently flooded metric value
+ */
+struct batadv_ogm2_packet {
+	uint8_t  packet_type;
+	uint8_t  version;
+	uint8_t  ttl;
+	uint8_t flags;
+	__be32 seqno;
+	uint8_t orig[ETH_ALEN];
+	__be16 tvlv_len;
+	__be32 metric;
+};
+
+#define BATADV_OGM2_HLEN sizeof(struct batadv_ogm2_packet)
+
+/**
  * struct batadv_elp_packet - elp (neighbor discovery) packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
diff --git a/types.h b/types.h
index be230b6..e9149d1 100644
--- a/types.h
+++ b/types.h
@@ -728,6 +728,18 @@ struct batadv_softif_vlan {
 };
 
 /**
+ * struct batadv_priv_bat_v -
+ * @ogm_buff:
+ * @ogm_buff_len:
+ */
+struct batadv_priv_bat_v {
+	unsigned char *ogm_buff;
+	int ogm_buff_len;
+	struct delayed_work ogm_wq;
+	atomic_t ogm_seqno;
+};
+
+/**
  * struct batadv_priv - per mesh interface data
  * @mesh_state: current status of the mesh (inactive/active/deactivating)
  * @soft_iface: net device which holds this struct as private data
@@ -834,6 +846,9 @@ struct batadv_priv {
 	atomic_t network_coding;
 	struct batadv_priv_nc nc;
 #endif /* CONFIG_BATMAN_ADV_NC */
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_priv_bat_v bat_v;
+#endif
 };
 
 /**
-- 
1.8.5.3

