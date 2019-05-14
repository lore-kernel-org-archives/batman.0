Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 2/3] batman-adv: allow broadcast packet type with unicast
 destination
Date: Tue, 14 May 2019 09:38:58 +0200
Message-Id: <20190514073859.2053-3-linus.luessing@c0d3.blue>
In-Reply-To: <20190514073859.2053-1-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

So far, only batman-adv broadcast packets are allowed if they have a
broadcast ethernet destination.

For the upcoming broadcast-via-unicasts feature it is necessary that a
neighboring node is capable of receiving a batman-adv broadcast packet
with a unicast ethernet destination, too.

Therefore this patch relaxes the ethernet destination check for
batman-adv broadcast packets and adds the necessary capability tracking
for later compatibility checking.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batadv_packet.h |  2 +
 net/batman-adv/bat_iv_ogm.c        |  6 ++-
 net/batman-adv/bat_v_elp.c         |  2 +
 net/batman-adv/hard-interface.c    |  1 +
 net/batman-adv/originator.c        | 65 ++++++++++++++++++++++++++++++
 net/batman-adv/originator.h        |  3 ++
 net/batman-adv/routing.c           |  7 +++-
 net/batman-adv/types.h             | 21 ++++++++++
 8 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 4ebc2135..2ec59e4a 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -164,6 +164,7 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
  * @BATADV_TVLV_MCAST: multicast capability tvlv
+ * @BATADV_TVLV_BCAST: broadcast capability tvlv
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
@@ -172,6 +173,7 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_TT		= 0x04,
 	BATADV_TVLV_ROAM	= 0x05,
 	BATADV_TVLV_MCAST	= 0x06,
+	BATADV_TVLV_BCAST	= 0x07,
 };
 
 #pragma pack(2)
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index bd4138dd..bcbebf10 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1310,8 +1310,12 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 	if (is_single_hop_neigh) {
 		hardif_neigh = batadv_hardif_neigh_get(if_incoming,
 						       ethhdr->h_source);
-		if (hardif_neigh)
+		if (hardif_neigh) {
 			hardif_neigh->last_seen = jiffies;
+
+			batadv_hardif_neigh_update_capa(orig_node,
+							hardif_neigh);
+		}
 	}
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 2614a9ca..d49b61c1 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -489,6 +489,8 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
+	batadv_hardif_neigh_update_capa(orig_neigh, hardif_neigh);
+
 hardif_free:
 	if (hardif_neigh)
 		batadv_hardif_neigh_put(hardif_neigh);
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 79d1731b..b71d8efc 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -936,6 +936,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
 	batadv_v_hardif_init(hard_iface);
+	atomic_set(&hard_iface->num_bcast_no_urcv, 0);
 
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 45db798a..73eacccf 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -42,6 +42,7 @@
 #include "routing.h"
 #include "soft-interface.h"
 #include "translation-table.h"
+#include "tvlv.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
@@ -196,6 +197,26 @@ void batadv_orig_node_vlan_put(struct batadv_orig_node_vlan *orig_vlan)
 	kref_put(&orig_vlan->refcount, batadv_orig_node_vlan_release);
 }
 
+/**
+ * batadv_orig_bcast_tvlv_ogm_handler() - process incoming broadcast tvlv
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node of the ogm
+ * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
+ * @tvlv_value: tvlv buffer containing the multicast data
+ * @tvlv_value_len: tvlv buffer length
+ */
+static void batadv_orig_bcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
+					       struct batadv_orig_node *orig,
+					       u8 flags,
+					       void *tvlv_value,
+					       u16 tvlv_value_len)
+{
+	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
+		clear_bit(BATADV_ORIG_CAPA_HAS_BCAST_URCV, &orig->capabilities);
+	else
+		set_bit(BATADV_ORIG_CAPA_HAS_BCAST_URCV, &orig->capabilities);
+}
+
 /**
  * batadv_originator_init() - Initialize all originator structures
  * @bat_priv: the bat priv with all the soft interface information
@@ -215,6 +236,12 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 	batadv_hash_set_lock_class(bat_priv->orig_hash,
 				   &batadv_orig_hash_lock_class_key);
 
+	batadv_tvlv_container_register(bat_priv, BATADV_TVLV_BCAST, 1, NULL, 0);
+	batadv_tvlv_handler_register(bat_priv,
+				     batadv_orig_bcast_tvlv_ogm_handler,
+				     NULL, BATADV_TVLV_BCAST, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+
 	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
 	queue_delayed_work(batadv_event_workqueue,
 			   &bat_priv->orig_work,
@@ -269,6 +296,9 @@ static void batadv_hardif_neigh_release(struct kref *ref)
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
+	if (!atomic_read(&hardif_neigh->bcast_has_urcv))
+		atomic_dec(&hardif_neigh->if_incoming->num_bcast_no_urcv);
+
 	batadv_hardif_put(hardif_neigh->if_incoming);
 	kfree_rcu(hardif_neigh, rcu);
 }
@@ -542,6 +572,34 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 	return res;
 }
 
+/**
+ * batadv_hardif_neigh_update_capa() - update hardif neighbor capabilities
+ * @orig_node: originator object representing the neighbour
+ * @hardif_neigh: the hardif neighbor to update
+ *
+ * Propagates neighbor node specific capabilities from an originator node onto a
+ * hardif neighbor node:
+ *
+ * This updates the broadcast-via-unicast reception capability flag of a
+ * neighbor node and updates the matching counter on the hard interfaces it
+ * belongs to.
+ */
+void
+batadv_hardif_neigh_update_capa(const struct batadv_orig_node *orig_node,
+				struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	struct batadv_hard_iface *hard_iface = hardif_neigh->if_incoming;
+
+	if (test_bit(BATADV_ORIG_CAPA_HAS_BCAST_URCV,
+		     &orig_node->capabilities)) {
+		if (atomic_add_unless(&hardif_neigh->bcast_has_urcv, 1, 1))
+			atomic_dec(&hard_iface->num_bcast_no_urcv);
+	} else {
+		if (atomic_add_unless(&hardif_neigh->bcast_has_urcv, -1, 0))
+			atomic_inc(&hard_iface->num_bcast_no_urcv);
+	}
+}
+
 /**
  * batadv_hardif_neigh_create() - create a hardif neighbour node
  * @hard_iface: the interface this neighbour is connected to
@@ -576,6 +634,10 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	hardif_neigh->if_incoming = hard_iface;
 	hardif_neigh->last_seen = jiffies;
 
+	atomic_set(&hardif_neigh->bcast_has_urcv, 0);
+	atomic_inc(&hardif_neigh->if_incoming->num_bcast_no_urcv);
+	batadv_hardif_neigh_update_capa(orig_node, hardif_neigh);
+
 	kref_init(&hardif_neigh->refcount);
 
 	if (bat_priv->algo_ops->neigh.hardif_init)
@@ -975,6 +1037,9 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_BCAST, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_BCAST, 1);
+
 	bat_priv->orig_hash = NULL;
 
 	for (i = 0; i < hash->size; i++) {
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 3829e26f..fb22161d 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -30,6 +30,9 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr);
 void
 batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh);
+void
+batadv_hardif_neigh_update_capa(const struct batadv_orig_node *orig_node,
+				struct batadv_hardif_neigh_node *hardif_neigh);
 struct batadv_neigh_node *
 batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
 				struct batadv_hard_iface *hard_iface,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 30fbd073..03b4e609 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1198,8 +1198,11 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	ethhdr = eth_hdr(skb);
 
-	/* packet with broadcast indication but unicast recipient */
-	if (!is_broadcast_ether_addr(ethhdr->h_dest))
+	/* packet with broadcast indication but unicast recipient
+	 * which is not us
+	 */
+	if (!is_broadcast_ether_addr(ethhdr->h_dest) &&
+	    !batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		goto free_skb;
 
 	/* packet with broadcast/multicast sender address */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 74b64473..877a2762 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -193,6 +193,13 @@ struct batadv_hard_iface {
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 
+	/**
+	 * @num_bcast_no_urcv: number of neighbor nodes on this interface which
+	 * do not support receiving batman-adv broadcast packets with a
+	 * unicast ethernet frame destination
+	 */
+	atomic_t num_bcast_no_urcv;
+
 	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;
 
@@ -528,6 +535,13 @@ enum batadv_orig_capabilities {
 	 *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
 	 */
 	BATADV_ORIG_CAPA_HAS_MCAST,
+
+	/**
+	 * BATADV_ORIG_CAPA_HAS_BCAST_URCV: orig node is able to receive
+	 * batman-adv broadcast packets with a unicast ethernet frame
+	 * destination
+	 */
+	BATADV_ORIG_CAPA_HAS_BCAST_URCV,
 };
 
 /**
@@ -600,6 +614,13 @@ struct batadv_hardif_neigh_node {
 	/** @last_seen: when last packet via this neighbor was received */
 	unsigned long last_seen;
 
+	/**
+	 * @bcast_has_urcv: a flag indicating whether this neighbor node
+	 * supports receiving batman-adv broadcast packets with a unicast
+	 * ethernet frame destination
+	 */
+	atomic_t bcast_has_urcv;
+
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	/** @bat_v: B.A.T.M.A.N. V private data */
 	struct batadv_hardif_neigh_node_bat_v bat_v;
-- 
2.20.1

