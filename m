Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 01:03:59 +0200
Message-Id: <1275779039-22946-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-trunk] batman-adv: Mark locally used symbols
	as static
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

Functions and variables which are used only inside one object file can
be declared as static. This helped to find unused functions/variables

 * mainIfAddr_default
 * main_if_was_up

and functions with declarations but missing definitions

 * hash_debug
 * orig_find
 * send_own_packet_work

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/bitarray.c          |    2 +-
 batman-adv-kernelland/bitarray.h          |    3 -
 batman-adv-kernelland/hard-interface.c    |    2 +-
 batman-adv-kernelland/hash.c              |    2 +-
 batman-adv-kernelland/hash.h              |    6 --
 batman-adv-kernelland/originator.c        |   32 +++++-----
 batman-adv-kernelland/originator.h        |    2 -
 batman-adv-kernelland/routing.c           |    2 +-
 batman-adv-kernelland/routing.h           |    2 -
 batman-adv-kernelland/send.c              |    4 +-
 batman-adv-kernelland/send.h              |    2 -
 batman-adv-kernelland/soft-interface.c    |  104 ++++++++++++++---------------
 batman-adv-kernelland/soft-interface.h    |    6 --
 batman-adv-kernelland/translation-table.c |    9 ++-
 batman-adv-kernelland/translation-table.h |    3 -
 batman-adv-kernelland/vis.c               |    4 +-
 batman-adv-kernelland/vis.h               |    3 -
 17 files changed, 80 insertions(+), 108 deletions(-)

diff --git a/batman-adv-kernelland/bitarray.c b/batman-adv-kernelland/bitarray.c
index a607827..c10fe03 100644
--- a/batman-adv-kernelland/bitarray.c
+++ b/batman-adv-kernelland/bitarray.c
@@ -63,7 +63,7 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n)
 }
 
 /* shift the packet array by n places. */
-void bit_shift(TYPE_OF_WORD *seq_bits, int32_t n)
+static void bit_shift(TYPE_OF_WORD *seq_bits, int32_t n)
 {
 	int32_t word_offset, word_num;
 	int32_t i;
diff --git a/batman-adv-kernelland/bitarray.h b/batman-adv-kernelland/bitarray.h
index 4c351eb..dad13bf 100644
--- a/batman-adv-kernelland/bitarray.h
+++ b/batman-adv-kernelland/bitarray.h
@@ -32,9 +32,6 @@ uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
 /* turn corresponding bit on, so we can remember that we got the packet */
 void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n);
 
-/* shift the packet array by n places. */
-void bit_shift(TYPE_OF_WORD *seq_bits, int32_t n);
-
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index ad2e496..70fd314 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -435,7 +435,7 @@ out:
 	return NOTIFY_DONE;
 }
 
-int batman_skb_recv_finish(struct sk_buff *skb)
+static int batman_skb_recv_finish(struct sk_buff *skb)
 {
 	return NF_ACCEPT;
 }
diff --git a/batman-adv-kernelland/hash.c b/batman-adv-kernelland/hash.c
index d4a4adc..1286f8f 100644
--- a/batman-adv-kernelland/hash.c
+++ b/batman-adv-kernelland/hash.c
@@ -23,7 +23,7 @@
 #include "hash.h"
 
 /* clears the hash */
-void hash_init(struct hashtable_t *hash)
+static void hash_init(struct hashtable_t *hash)
 {
 	int i;
 
diff --git a/batman-adv-kernelland/hash.h b/batman-adv-kernelland/hash.h
index ea6d21e..0505595 100644
--- a/batman-adv-kernelland/hash.h
+++ b/batman-adv-kernelland/hash.h
@@ -56,9 +56,6 @@ struct hashtable_t {
 				     * argument and the size the second */
 };
 
-/* clears the hash */
-void hash_init(struct hashtable_t *hash);
-
 /* allocates and clears the hash */
 struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
 			     hashdata_choose_cb choose);
@@ -98,7 +95,4 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size);
  * the returned iterator to access the elements until hash_it_t returns NULL. */
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			       struct hash_it_t *iter_in);
-
-/* print the hash table for debugging */
-void hash_debug(struct hashtable_t *hash);
 #endif
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 28e35b6..89b7cca 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -58,21 +58,6 @@ err:
 	return 0;
 }
 
-void originator_free(void)
-{
-	unsigned long flags;
-
-	if (!orig_hash)
-		return;
-
-	cancel_delayed_work_sync(&purge_orig_wq);
-
-	spin_lock_irqsave(&orig_hash_lock, flags);
-	hash_delete(orig_hash, free_orig_node);
-	orig_hash = NULL;
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
-}
-
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming)
@@ -95,7 +80,7 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 	return neigh_node;
 }
 
-void free_orig_node(void *data)
+static void free_orig_node(void *data)
 {
 	struct list_head *list_pos, *list_pos_tmp;
 	struct neigh_node *neigh_node;
@@ -116,6 +101,21 @@ void free_orig_node(void *data)
 	kfree(orig_node);
 }
 
+void originator_free(void)
+{
+	unsigned long flags;
+
+	if (!orig_hash)
+		return;
+
+	cancel_delayed_work_sync(&purge_orig_wq);
+
+	spin_lock_irqsave(&orig_hash_lock, flags);
+	hash_delete(orig_hash, free_orig_node);
+	orig_hash = NULL;
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+}
+
 /* this function finds or creates an originator entry for the given
  * address if it does not exits */
 struct orig_node *get_orig_node(uint8_t *addr)
diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/originator.h
index e91e8a1..6632538 100644
--- a/batman-adv-kernelland/originator.h
+++ b/batman-adv-kernelland/originator.h
@@ -20,10 +20,8 @@
  */
 
 int originator_init(void);
-void free_orig_node(void *data);
 void originator_free(void);
 void purge_orig(struct work_struct *work);
-struct orig_node *orig_find(char *mac);
 struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index b906f79..8800257 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -35,7 +35,7 @@
 #include "compat.h"
 #include "gateway_client.h"
 
-DECLARE_WAIT_QUEUE_HEAD(thread_wait);
+static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
diff --git a/batman-adv-kernelland/routing.h b/batman-adv-kernelland/routing.h
index d14c405..43387a2 100644
--- a/batman-adv-kernelland/routing.h
+++ b/batman-adv-kernelland/routing.h
@@ -21,8 +21,6 @@
 
 #include "types.h"
 
-extern wait_queue_head_t thread_wait;
-
 void slide_own_bcast_window(struct batman_if *batman_if);
 void receive_bat_packet(struct ethhdr *ethhdr,
 				struct batman_packet *batman_packet,
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 8df44a6..7db86c2 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -33,6 +33,8 @@
 
 #include "compat.h"
 
+static void send_outstanding_bcast_packet(struct work_struct *work);
+
 /* apply hop penalty for a normal link */
 static uint8_t hop_penalty(const uint8_t tq)
 {
@@ -448,7 +450,7 @@ out:
 	return NETDEV_TX_BUSY;
 }
 
-void send_outstanding_bcast_packet(struct work_struct *work)
+static void send_outstanding_bcast_packet(struct work_struct *work)
 {
 	struct batman_if *batman_if;
 	struct delayed_work *delayed_work =
diff --git a/batman-adv-kernelland/send.h b/batman-adv-kernelland/send.h
index feaa2fc..0a0990d 100644
--- a/batman-adv-kernelland/send.h
+++ b/batman-adv-kernelland/send.h
@@ -21,7 +21,6 @@
 
 #include "types.h"
 
-void send_own_packet_work(struct work_struct *work);
 int send_skb_packet(struct sk_buff *skb,
 				struct batman_if *batman_if,
 				uint8_t *dst_addr);
@@ -34,6 +33,5 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
 int  add_bcast_packet_to_list(struct sk_buff *skb);
-void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct batman_if *batman_if);
diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index cfa40b6..6d8cab7 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -39,7 +39,6 @@ static int32_t skb_packets;
 static int32_t skb_bad_packets;
 
 unsigned char mainIfAddr[ETH_ALEN];
-static unsigned char mainIfAddr_default[ETH_ALEN];
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void bat_get_drvinfo(struct net_device *dev,
 			    struct ethtool_drvinfo *info);
@@ -64,11 +63,6 @@ void set_main_if_addr(uint8_t *addr)
 	memcpy(mainIfAddr, addr, ETH_ALEN);
 }
 
-int main_if_was_up(void)
-{
-	return (memcmp(mainIfAddr, mainIfAddr_default, ETH_ALEN) != 0 ? 1 : 0);
-}
-
 int my_skb_push(struct sk_buff *skb, unsigned int len)
 {
 	int result = 0;
@@ -86,69 +80,25 @@ int my_skb_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-#ifdef HAVE_NET_DEVICE_OPS
-static const struct net_device_ops bat_netdev_ops = {
-	.ndo_open = interface_open,
-	.ndo_stop = interface_release,
-	.ndo_get_stats = interface_stats,
-	.ndo_set_mac_address = interface_set_mac_addr,
-	.ndo_change_mtu = interface_change_mtu,
-	.ndo_start_xmit = interface_tx,
-	.ndo_validate_addr = eth_validate_addr
-};
-#endif
-
-void interface_setup(struct net_device *dev)
-{
-	struct bat_priv *priv = netdev_priv(dev);
-	char dev_addr[ETH_ALEN];
-
-	ether_setup(dev);
-
-#ifdef HAVE_NET_DEVICE_OPS
-	dev->netdev_ops = &bat_netdev_ops;
-#else
-	dev->open = interface_open;
-	dev->stop = interface_release;
-	dev->get_stats = interface_stats;
-	dev->set_mac_address = interface_set_mac_addr;
-	dev->change_mtu = interface_change_mtu;
-	dev->hard_start_xmit = interface_tx;
-#endif
-	dev->destructor = free_netdev;
-
-	dev->mtu = hardif_min_mtu();
-	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
-						* skbuff for our header */
-
-	/* generate random address */
-	random_ether_addr(dev_addr);
-	memcpy(dev->dev_addr, dev_addr, ETH_ALEN);
-
-	SET_ETHTOOL_OPS(dev, &bat_ethtool_ops);
-
-	memset(priv, 0, sizeof(struct bat_priv));
-}
-
-int interface_open(struct net_device *dev)
+static int interface_open(struct net_device *dev)
 {
 	netif_start_queue(dev);
 	return 0;
 }
 
-int interface_release(struct net_device *dev)
+static int interface_release(struct net_device *dev)
 {
 	netif_stop_queue(dev);
 	return 0;
 }
 
-struct net_device_stats *interface_stats(struct net_device *dev)
+static struct net_device_stats *interface_stats(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
 	return &priv->stats;
 }
 
-int interface_set_mac_addr(struct net_device *dev, void *p)
+static int interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr = p;
 
@@ -166,7 +116,7 @@ int interface_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
-int interface_change_mtu(struct net_device *dev, int new_mtu)
+static int interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
 	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu()))
@@ -328,6 +278,50 @@ void interface_rx(struct sk_buff *skb, int hdr_size)
 	netif_rx(skb);
 }
 
+#ifdef HAVE_NET_DEVICE_OPS
+static const struct net_device_ops bat_netdev_ops = {
+	.ndo_open = interface_open,
+	.ndo_stop = interface_release,
+	.ndo_get_stats = interface_stats,
+	.ndo_set_mac_address = interface_set_mac_addr,
+	.ndo_change_mtu = interface_change_mtu,
+	.ndo_start_xmit = interface_tx,
+	.ndo_validate_addr = eth_validate_addr
+};
+#endif
+
+void interface_setup(struct net_device *dev)
+{
+	struct bat_priv *priv = netdev_priv(dev);
+	char dev_addr[ETH_ALEN];
+
+	ether_setup(dev);
+
+#ifdef HAVE_NET_DEVICE_OPS
+	dev->netdev_ops = &bat_netdev_ops;
+#else
+	dev->open = interface_open;
+	dev->stop = interface_release;
+	dev->get_stats = interface_stats;
+	dev->set_mac_address = interface_set_mac_addr;
+	dev->change_mtu = interface_change_mtu;
+	dev->hard_start_xmit = interface_tx;
+#endif
+	dev->destructor = free_netdev;
+
+	dev->mtu = hardif_min_mtu();
+	dev->hard_header_len = BAT_HEADER_LEN; /* reserve more space in the
+						* skbuff for our header */
+
+	/* generate random address */
+	random_ether_addr(dev_addr);
+	memcpy(dev->dev_addr, dev_addr, ETH_ALEN);
+
+	SET_ETHTOOL_OPS(dev, &bat_ethtool_ops);
+
+	memset(priv, 0, sizeof(struct bat_priv));
+}
+
 /* ethtool */
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
diff --git a/batman-adv-kernelland/soft-interface.h b/batman-adv-kernelland/soft-interface.h
index e7f59af..3852c57 100644
--- a/batman-adv-kernelland/soft-interface.h
+++ b/batman-adv-kernelland/soft-interface.h
@@ -20,13 +20,7 @@
  */
 
 void set_main_if_addr(uint8_t *addr);
-int main_if_was_up(void);
 void interface_setup(struct net_device *dev);
-int interface_open(struct net_device *dev);
-int interface_release(struct net_device *dev);
-struct net_device_stats *interface_stats(struct net_device *dev);
-int interface_set_mac_addr(struct net_device *dev, void *addr);
-int interface_change_mtu(struct net_device *dev, int new_mtu);
 int interface_tx(struct sk_buff *skb, struct net_device *dev);
 void interface_rx(struct sk_buff *skb, int hdr_size);
 int my_skb_push(struct sk_buff *skb, unsigned int len);
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index 8edc175..619a9a8 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -33,7 +33,10 @@ atomic_t hna_local_changed;
 DEFINE_SPINLOCK(hna_local_hash_lock);
 static DEFINE_SPINLOCK(hna_global_hash_lock);
 
+static void hna_local_purge(struct work_struct *work);
 static DECLARE_DELAYED_WORK(hna_local_purge_wq, hna_local_purge);
+static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+				 char *message);
 
 static void hna_local_start_timer(void)
 {
@@ -243,7 +246,7 @@ void hna_local_remove(uint8_t *addr, char *message)
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
 }
 
-void hna_local_purge(struct work_struct *work)
+static void hna_local_purge(struct work_struct *work)
 {
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
@@ -424,8 +427,8 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
-			  char *message)
+static void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
+				 char *message)
 {
 	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s\n",
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
diff --git a/batman-adv-kernelland/translation-table.h b/batman-adv-kernelland/translation-table.h
index 8b3429e..232208f 100644
--- a/batman-adv-kernelland/translation-table.h
+++ b/batman-adv-kernelland/translation-table.h
@@ -26,14 +26,11 @@ void hna_local_add(uint8_t *addr);
 void hna_local_remove(uint8_t *addr, char *message);
 int hna_local_fill_buffer(unsigned char *buff, int buff_len);
 int hna_local_seq_print_text(struct seq_file *seq, void *offset);
-void hna_local_purge(struct work_struct *work);
 void hna_local_free(void);
 int hna_global_init(void);
 void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff,
 			 int hna_buff_len);
 int hna_global_seq_print_text(struct seq_file *seq, void *offset);
-void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
-			  char *orig_str);
 void hna_global_del_orig(struct orig_node *orig_node, char *message);
 void hna_global_free(void);
 struct orig_node *transtable_search(uint8_t *addr);
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index 68ee903..9e53462 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -44,8 +44,8 @@
 			_dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
-struct hashtable_t *vis_hash;
-DEFINE_SPINLOCK(vis_hash_lock);
+static struct hashtable_t *vis_hash;
+static DEFINE_SPINLOCK(vis_hash_lock);
 static DEFINE_SPINLOCK(recv_list_lock);
 static struct vis_info *my_vis_info;
 static struct list_head send_list;	/* always locked with vis_hash_lock */
diff --git a/batman-adv-kernelland/vis.h b/batman-adv-kernelland/vis.h
index 5dd6521..1cfadce 100644
--- a/batman-adv-kernelland/vis.h
+++ b/batman-adv-kernelland/vis.h
@@ -44,9 +44,6 @@ struct recvlist_node {
 	uint8_t mac[ETH_ALEN];
 };
 
-extern struct hashtable_t *vis_hash;
-extern spinlock_t vis_hash_lock;
-
 int vis_seq_print_text(struct seq_file *seq, void *offset);
 void receive_server_sync_packet(struct bat_priv *bat_priv,
 				struct vis_packet *vis_packet,
-- 
1.7.1

