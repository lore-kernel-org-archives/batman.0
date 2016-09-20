Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 20 Sep 2016 14:12:43 +0200
Message-Id: <20160920121245.593-2-linus.luessing@c0d3.blue>
In-Reply-To: <20160920121245.593-1-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Store and transmit own
	neighborhood hash
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

Adds a sha512 hash as a TVLV to an ELP packet. Hash is the "sum" of all
neighbors (ordered alphabetically, concatenated, binary) a node sees
on a specific interface.

Furthermore, the best and worst TX metric of all these neighbors on an
interface are added to the TVLV.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Note: This patch throws two checkpatch warnings which are faulty,
though.
---
 net/batman-adv/Kconfig      |   1 +
 net/batman-adv/bat_v.c      |  27 ++++++-
 net/batman-adv/bat_v.h      |   5 ++
 net/batman-adv/bat_v_elp.c  | 175 ++++++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v_elp.h  |   2 +
 net/batman-adv/log.c        |   4 +-
 net/batman-adv/main.c       |   1 +
 net/batman-adv/originator.c |  47 +++++++++++-
 net/batman-adv/packet.h     |  26 +++++++
 net/batman-adv/types.h      |   8 ++
 10 files changed, 289 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f20742c..35e220e 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -18,6 +18,7 @@ config BATMAN_ADV
 config BATMAN_ADV_BATMAN_V
 	bool "B.A.T.M.A.N. V protocol (experimental)"
 	depends on BATMAN_ADV && CFG80211=y || (CFG80211=m && BATMAN_ADV=m)
+	depends on CRYPTO_SHA512
 	default n
 	help
 	  This option enables the B.A.T.M.A.N. V protocol, the successor
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index e79f6f0..762b34c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1070,11 +1070,17 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
  */
 void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 {
+	struct batadv_hard_iface_bat_v *bat_v = &hard_iface->bat_v;
+
 	/* enable link throughput auto-detection by setting the throughput
 	 * override to zero
 	 */
-	atomic_set(&hard_iface->bat_v.throughput_override, 0);
-	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+	atomic_set(&bat_v->throughput_override, 0);
+	atomic_set(&bat_v->elp_interval, 500);
+
+	bat_v->min_throughput = 0;
+	bat_v->max_throughput = (~(u32)0);
+	memset(bat_v->neigh_hash, 0, sizeof(bat_v->neigh_hash));
 }
 
 /**
@@ -1108,6 +1114,14 @@ void batadv_v_mesh_free(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_v_free - free the B.A.T.M.A.N. V global, mesh independent resources
+ */
+void batadv_v_free(void)
+{
+	batadv_v_elp_free();
+}
+
+/**
  * batadv_v_init - B.A.T.M.A.N. V initialization function
  *
  * Description: Takes care of initializing all the subcomponents.
@@ -1119,11 +1133,15 @@ int __init batadv_v_init(void)
 {
 	int ret;
 
+	ret = batadv_v_elp_init();
+	if (ret < 0)
+		return ret;
+
 	/* B.A.T.M.A.N. V echo location protocol packet  */
 	ret = batadv_recv_handler_register(BATADV_ELP,
 					   batadv_v_elp_packet_recv);
 	if (ret < 0)
-		return ret;
+		goto elp_free;
 
 	ret = batadv_recv_handler_register(BATADV_OGM2,
 					   batadv_v_ogm_packet_recv);
@@ -1136,6 +1154,9 @@ int __init batadv_v_init(void)
 
 	return ret;
 
+elp_free:
+	batadv_v_elp_free();
+
 ogm_unregister:
 	batadv_recv_handler_unregister(BATADV_OGM2);
 
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index 83b7763..e2645b8 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -23,6 +23,7 @@
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 int batadv_v_init(void);
+void batadv_v_free(void);
 void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
 int batadv_v_mesh_init(struct batadv_priv *bat_priv);
 void batadv_v_mesh_free(struct batadv_priv *bat_priv);
@@ -34,6 +35,10 @@ static inline int batadv_v_init(void)
 	return 0;
 }
 
+static inline void batadv_v_free(void)
+{
+}
+
 static inline void batadv_v_hardif_init(struct batadv_hard_iface *hardif)
 {
 }
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ee08540..d4b5750 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -18,6 +18,8 @@
 #include "bat_v_elp.h"
 #include "main.h"
 
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
@@ -49,6 +51,8 @@
 #include "routing.h"
 #include "send.h"
 
+static struct crypto_shash *tfm;
+
 /**
  * batadv_v_elp_start_timer - restart timer for ELP periodic work
  * @hard_iface: the interface for which the timer has to be reset
@@ -65,6 +69,133 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 }
 
 /**
+ * batadv_v_elp_update_neigh_hash - updates neighborhood hash related data
+ * @hard_iface: interface which the data has to be prepared for
+ *
+ * Firstly, this function updates the neighborhood hash of a hard interface.
+ * That is it resummarizes the present neighborhood into one compact hash
+ * representation.
+ *
+ * Secondly, minimum and maximum throughput values within this neighorhood are
+ * updated.
+ */
+static void batadv_v_elp_update_neigh_hash(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct ewma_throughput *ewma_throughput;
+	u8 *own_addr = hard_iface->net_dev->dev_addr;
+	u32 min_throughput = ~((u32)0), max_throughput = 0;
+	u32 throughput;
+	int ret;
+
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->flags = 0;
+	shash->tfm = tfm;
+
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto err;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(hardif_neigh,
+				 &hard_iface->neigh_list, list) {
+		/* insert own address at the right spot */
+		if (own_addr && (memcmp(own_addr, hardif_neigh->addr,
+					ETH_ALEN) < 0)) {
+			ret = crypto_shash_update(shash, own_addr, ETH_ALEN);
+			if (ret) {
+				rcu_read_unlock();
+				goto err;
+			}
+
+			own_addr = NULL;
+		}
+
+		ret = crypto_shash_update(shash, hardif_neigh->addr, ETH_ALEN);
+		if (ret) {
+			rcu_read_unlock();
+			goto err;
+		}
+
+		ewma_throughput = &hardif_neigh->bat_v.throughput;
+		throughput = ewma_throughput_read(ewma_throughput);
+
+		if (throughput < min_throughput)
+			min_throughput = throughput;
+
+		if (throughput > max_throughput)
+			max_throughput = throughput;
+	}
+	rcu_read_unlock();
+
+	if (own_addr) {
+		ret = crypto_shash_update(shash, own_addr, ETH_ALEN);
+		if (ret)
+			goto err;
+	}
+
+	ret = crypto_shash_final(shash, hard_iface->bat_v.neigh_hash);
+	if (ret)
+		goto err;
+
+	hard_iface->bat_v.min_throughput = min_throughput;
+	hard_iface->bat_v.max_throughput = max_throughput;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Updated neighbor hash on interface %s: %*phN, min_through: %u kbit/s, max_through: %u kbit/s\n",
+		   hard_iface->net_dev->name,
+		   (int)sizeof(hard_iface->bat_v.neigh_hash),
+		   hard_iface->bat_v.neigh_hash,
+		   hard_iface->bat_v.min_throughput * 100,
+		   hard_iface->bat_v.max_throughput * 100);
+
+	return;
+
+err:
+	memset(hard_iface->bat_v.neigh_hash, 0,
+	       sizeof(hard_iface->bat_v.neigh_hash));
+	hard_iface->bat_v.min_throughput = 0;
+	hard_iface->bat_v.max_throughput = ~((u32)0);
+
+	pr_warn_once("An error occurred while calculating neighbor hash for %s\n",
+		     hard_iface->net_dev->name);
+}
+
+/**
+ * batadv_v_elp_update_neigh_hash_tvlv - updates a neighborhood hash tvlv
+ * @hard_iface: interface which the tvlv is updated for
+ * @skb: the to be transmitted ELP packet containing the neighborhood tvlv
+ *
+ * Prepares the neighborhood hash tvlv of an ELP packet by updating its
+ * hash as well as minimum and maximum throughput values.
+ */
+static void
+batadv_v_elp_update_neigh_hash_tvlv(struct batadv_hard_iface *hard_iface,
+				    struct sk_buff *skb)
+{
+	struct batadv_hard_iface_bat_v *hard_iface_v = &hard_iface->bat_v;
+	struct batadv_elp_packet *elp_packet;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	struct batadv_tvlv_nhh_data *nhh_data;
+
+	elp_packet = (struct batadv_elp_packet *)skb_network_header(skb);
+	tvlv_hdr = (struct batadv_tvlv_hdr *)(elp_packet + 1);
+	nhh_data = (struct batadv_tvlv_nhh_data *)(tvlv_hdr + 1);
+
+	if (!hard_iface_v->min_throughput) {
+		elp_packet->tvlv_len = 0;
+		skb_trim(skb, skb->len - sizeof(*tvlv_hdr) - sizeof(*nhh_data));
+	} else {
+		nhh_data->min_throughput = htonl(hard_iface_v->min_throughput);
+		nhh_data->max_throughput = htonl(hard_iface_v->max_throughput);
+		memcpy(nhh_data->neigh_hash, hard_iface_v->neigh_hash,
+		       sizeof(hard_iface_v->neigh_hash));
+	}
+}
+
+/**
  * batadv_v_elp_get_throughput - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
  *
@@ -269,6 +400,9 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
 	elp_packet->elp_interval = htonl(elp_interval);
 
+	batadv_v_elp_update_neigh_hash(hard_iface);
+	batadv_v_elp_update_neigh_hash_tvlv(hard_iface, skb);
+
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Sending broadcast ELP packet on interface %s, seqno %u\n",
 		   hard_iface->net_dev->name,
@@ -324,23 +458,42 @@ out:
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_elp_packet *elp_packet;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	struct batadv_tvlv_nhh_data *nhh_data;
 	unsigned char *elp_buff;
 	u32 random_seqno;
 	size_t size;
 	int res = -ENOMEM;
 
 	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
+	size +=	sizeof(*nhh_data) + sizeof(*tvlv_hdr);
+
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
 	if (!hard_iface->bat_v.elp_skb)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reset_network_header(hard_iface->bat_v.elp_skb);
+
 	elp_buff = skb_put(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
 	elp_packet = (struct batadv_elp_packet *)elp_buff;
 	memset(elp_packet, 0, BATADV_ELP_HLEN);
 
 	elp_packet->packet_type = BATADV_ELP;
 	elp_packet->version = BATADV_COMPAT_VERSION;
+	elp_packet->tvlv_len = htons(sizeof(*nhh_data) + sizeof(*tvlv_hdr));
+
+	elp_buff = skb_put(hard_iface->bat_v.elp_skb, sizeof(*tvlv_hdr));
+	tvlv_hdr = (struct batadv_tvlv_hdr *)elp_buff;
+	tvlv_hdr->type = BATADV_TVLV_NHH;
+	tvlv_hdr->version = 1;
+	tvlv_hdr->len = htons(sizeof(*nhh_data));
+
+	size = sizeof(*nhh_data);
+	elp_buff = skb_put(hard_iface->bat_v.elp_skb, size);
+	nhh_data = (struct batadv_tvlv_nhh_data *)elp_buff;
+	nhh_data->min_throughput = htonl(0);
+	memset(nhh_data, 0, size);
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
@@ -527,3 +680,25 @@ out:
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 }
+
+/**
+ * batadv_v_elp_init - initialize global ELP structures
+ *
+ * Return: A negative value on error, zero on success.
+ */
+int batadv_v_elp_init(void)
+{
+	tfm = crypto_alloc_shash("sha512", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	return 0;
+}
+
+/**
+ * batadv_v_elp_free - free global ELP structures
+ */
+void batadv_v_elp_free(void)
+{
+	crypto_free_shash(tfm);
+}
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index be17c0b..ed5936c 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -23,6 +23,8 @@
 struct sk_buff;
 struct work_struct;
 
+int batadv_v_elp_init(void);
+void batadv_v_elp_free(void);
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 56dc532..099524e 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -66,7 +66,7 @@ static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
 			     const char *fmt, ...)
 {
 	va_list args;
-	static char debug_log_buf[256];
+	static char debug_log_buf[512];
 	char *p;
 
 	if (!debug_log)
@@ -90,7 +90,7 @@ static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
 int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 {
 	va_list args;
-	char tmp_log_buf[256];
+	char tmp_log_buf[512];
 
 	va_start(args, fmt);
 	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 2c017ab..2570463 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -135,6 +135,7 @@ static void __exit batadv_exit(void)
 	rcu_barrier();
 
 	batadv_tt_cache_destroy();
+	batadv_v_free();
 }
 
 int batadv_mesh_init(struct net_device *soft_iface)
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3f1c286..3a5612d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -509,6 +509,43 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 }
 
 /**
+ * batadv_hardif_neigh_get_pre - get the predecessor of a neighbor node
+ * @hard_iface: the interface this neighbour is connected to
+ * @neigh_addr: address of the neighbour to retrieve the predecessor for
+ *
+ * Tries to find the neighbor node which has an address closest to but
+ * smaller than the neigh_addr provided. In other words, tries to
+ * find a potential predecessor of a given MAC address.
+ *
+ * Return: The alphabetical predecessor of a neighbor node. Returns NULL
+ * if no such predecessor exists.
+ */
+static struct batadv_hardif_neigh_node *
+batadv_hardif_neigh_get_pre(struct batadv_hard_iface *hard_iface,
+			    const u8 *neigh_addr)
+{
+	struct batadv_hardif_neigh_node *tmp_hardif_neigh, *hardif_neigh = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_hardif_neigh, &hard_iface->neigh_list,
+				 list) {
+		if (memcmp(tmp_hardif_neigh->addr, neigh_addr, ETH_ALEN) >= 0)
+			break;
+
+		if (!kref_get_unless_zero(&tmp_hardif_neigh->refcount))
+			continue;
+
+		if (hardif_neigh)
+			batadv_hardif_neigh_put(hardif_neigh);
+
+		hardif_neigh = tmp_hardif_neigh;
+	}
+	rcu_read_unlock();
+
+	return hardif_neigh;
+}
+
+/**
  * batadv_hardif_neigh_create - create a hardif neighbour node
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
@@ -522,7 +559,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 			   struct batadv_orig_node *orig_node)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
+	struct batadv_hardif_neigh_node *hardif_neigh = NULL, *pre_neigh;
 
 	spin_lock_bh(&hard_iface->neigh_list_lock);
 
@@ -547,7 +584,13 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	if (bat_priv->algo_ops->neigh.hardif_init)
 		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
 
-	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
+	pre_neigh = batadv_hardif_neigh_get_pre(hard_iface, neigh_addr);
+	if (!pre_neigh) {
+		hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
+	} else {
+		hlist_add_behind(&hardif_neigh->list, &pre_neigh->list);
+		batadv_hardif_neigh_put(pre_neigh);
+	}
 
 out:
 	spin_unlock_bh(&hard_iface->neigh_list_lock);
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 6afc0b8..56f1f6f 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -19,6 +19,7 @@
 #define _NET_BATMAN_ADV_PACKET_H_
 
 #include <asm/byteorder.h>
+#include <crypto/sha.h>
 #include <linux/types.h>
 
 #define batadv_tp_is_error(n) ((u8)n > 127 ? 1 : 0)
@@ -163,6 +164,14 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_MCAST	= 0x06,
 };
 
+/**
+ * enum batadv_tvlv_elp_type - tvlv type definitions for ELP messages
+ * @BATADV_TVLV_NHH: neighborhood hash
+ */
+enum batadv_tvlv_elp_type {
+	BATADV_TVLV_NHH		= 0x01,
+};
+
 #pragma pack(2)
 /* the destination hardware field in the ARP frame is used to
  * transport the claim type and the group id
@@ -240,6 +249,8 @@ struct batadv_ogm2_packet {
  * @orig: originator mac address
  * @seqno: sequence number
  * @elp_interval: currently used ELP sending interval in ms
+ * @reserved: reserved bytes for alignment
+ * @tvlv_len: length of tvlv data following the elp header
  */
 struct batadv_elp_packet {
 	u8     packet_type;
@@ -247,6 +258,8 @@ struct batadv_elp_packet {
 	u8     orig[ETH_ALEN];
 	__be32 seqno;
 	__be32 elp_interval;
+	__be16 reserved;
+	__be16 tvlv_len;
 };
 
 #define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
@@ -628,4 +641,17 @@ struct batadv_tvlv_mcast_data {
 	u8 reserved[3];
 };
 
+/**
+ * batadv_tvlv_nhh_data - neighborhood hash data
+ * @min_throughput: worst of all TX throughputs this neighbor has to others
+ * @max_throughput: best of all TX throughputs this neighbor has to others
+ * @neigh_hash: a sha512 hash of all neighbors this neighbor sees
+ *  (hash over the alphabetically ordered, concatenated, binary representation)
+ */
+struct batadv_tvlv_nhh_data {
+	__be32 min_throughput;
+	__be32 max_throughput;
+	u8 neigh_hash[SHA512_DIGEST_SIZE];
+};
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b540cd3..731bdf5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -22,6 +22,7 @@
 #error only "main.h" can be included directly
 #endif
 
+#include <crypto/sha.h>
 #include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
@@ -108,6 +109,10 @@ enum batadv_v_hard_iface_flags {
  * @elp_wq: workqueue used to schedule ELP transmissions
  * @throughput_override: throughput override to disable link auto-detection
  * @flags: interface specific flags
+ * @min_throughput: worst of all TX throughputs this neighbor has to others
+ * @max_throughput: best of all TX throughputs this neighbor has to others
+ * @neigh_hash: a sha512 hash of all neighbors this neighbor sees
+ *  (hash over the alphabetically ordered, concatenated, binary representation)
  */
 struct batadv_hard_iface_bat_v {
 	atomic_t elp_interval;
@@ -116,6 +121,9 @@ struct batadv_hard_iface_bat_v {
 	struct delayed_work elp_wq;
 	atomic_t throughput_override;
 	u8 flags;
+	u32 min_throughput;
+	u32 max_throughput;
+	u8 neigh_hash[SHA512_DIGEST_SIZE];
 };
 
 /**
-- 
2.1.4

