Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Apr 2013 23:26:31 +0800
Message-Id: <1366125995-18034-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
References: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: tvlv - add distributed arp
	table container
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Create DAT container to announce DAT capabilities (if enabled).

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 distributed-arp-table.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |    5 ++++
 packet.h                |    2 ++
 sysfs.c                 |    3 ++-
 types.h                 |   10 ++++++++
 5 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3a3e1d8..3a4b577 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -419,6 +419,10 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	bool ret = false;
 	int j;
 
+	/* check if orig node candidate is running DAT */
+	if (!(candidate->capabilities & BATADV_ORIG_CAPA_HAS_DAT))
+		goto out;
+
 	/* Check if this node has already been selected... */
 	for (j = 0; j < select; j++)
 		if (res[j].orig_node == candidate)
@@ -626,6 +630,59 @@ out:
 }
 
 /**
+ * batadv_dat_tvlv_container_update - update the dat tvlv container after dat
+ *  setting change
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
+{
+	char dat_mode;
+
+	dat_mode = atomic_read(&bat_priv->distributed_arp_table);
+
+	switch (dat_mode) {
+	case 0:
+		batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
+		break;
+	case 1:
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_DAT, 1,
+					       NULL, 0);
+		break;
+	}
+}
+
+/**
+ * batadv_dat_status_update - update the dat tvlv container after dat
+ *  setting change
+ * @net_dev: the soft interface net device
+ */
+void batadv_dat_status_update(struct net_device *net_dev)
+{
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	batadv_dat_tvlv_container_update(bat_priv);
+}
+
+/**
+ * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node of the ogm
+ * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
+ * @tvlv_value: tvlv buffer containing the gateway data
+ * @tvlv_value_len: tvlv buffer length
+ */
+static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
+					   struct batadv_orig_node *orig,
+					   uint8_t flags,
+					   void *tvlv_value,
+					   uint16_t tvlv_value_len)
+{
+	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
+		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_DAT;
+	else
+		orig->capabilities |= BATADV_ORIG_CAPA_HAS_DAT;
+}
+
+/**
  * batadv_dat_hash_free - free the local DAT hash table
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -657,6 +714,10 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 
 	batadv_dat_start_timer(bat_priv);
 
+	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
+				     NULL, BATADV_TVLV_DAT, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	batadv_dat_tvlv_container_update(bat_priv);
 	return 0;
 }
 
@@ -666,6 +727,9 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
  */
 void batadv_dat_free(struct batadv_priv *bat_priv)
 {
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_DAT, 1);
+
 	cancel_delayed_work_sync(&bat_priv->dat.work);
 
 	batadv_dat_hash_free(bat_priv);
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 125c8c6..60d853b 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -29,6 +29,7 @@
 
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
 
+void batadv_dat_status_update(struct net_device *net_dev);
 bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
@@ -98,6 +99,10 @@ static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
 
 #else
 
+static inline void batadv_dat_status_update(struct net_device *net_dev)
+{
+}
+
 static inline bool
 batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb)
diff --git a/packet.h b/packet.h
index a5bd6ee..fec0102 100644
--- a/packet.h
+++ b/packet.h
@@ -121,9 +121,11 @@ enum batadv_bla_claimframe {
 /**
  * enum batadv_tvlv_type - tvlv type definitions
  * @BATADV_TVLV_GW: gateway tvlv
+ * @BATADV_TVLV_DAT: distributed arp table tvlv
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
+	BATADV_TVLV_DAT		= 0x02,
 };
 
 /* the destination hardware field in the ARP frame is used to
diff --git a/sysfs.c b/sysfs.c
index db38f79..02ea795 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -423,7 +423,8 @@ BATADV_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
-BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR, NULL);
+BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR,
+		     batadv_dat_status_update);
 #endif
 BATADV_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
 BATADV_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
diff --git a/types.h b/types.h
index ce84cc5..ae47225 100644
--- a/types.h
+++ b/types.h
@@ -101,6 +101,7 @@ struct batadv_hard_iface {
  * @batman_seqno_reset: time when the batman seqno window was reset
  * @gw_flags: flags related to gateway class
  * @flags: for now only VIS_SERVER flag
+ * @capabilities: announced capabilities of this originator
  * @last_ttvn: last seen translation table version number
  * @tt_crc: CRC of the translation table
  * @tt_buff: last tt changeset this node received from the orig node
@@ -149,6 +150,7 @@ struct batadv_orig_node {
 	unsigned long batman_seqno_reset;
 	uint8_t gw_flags;
 	uint8_t flags;
+	uint8_t capabilities;
 	atomic_t last_ttvn;
 	uint16_t tt_crc;
 	unsigned char *tt_buff;
@@ -186,6 +188,14 @@ struct batadv_orig_node {
 };
 
 /**
+ * enum batadv_orig_capabilities - orig node capabilities
+ * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
+ */
+enum batadv_orig_capabilities {
+	BATADV_ORIG_CAPA_HAS_DAT = BIT(1),
+};
+
+/**
  * struct batadv_gw_node - structure for orig nodes announcing gw capabilities
  * @list: list node for batadv_priv_gw::list
  * @orig_node: pointer to corresponding orig node
-- 
1.7.10.4

