Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 00:28:24 +0200
Message-Id: <1277504905-27672-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] Staging: batman-adv: Add include guards
	to all header files
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

We include different header files indirectly to the same source file.
This creates weird compiler errors from time to time. Include guards
should prefend that functions/variables/... gets redefined by itself.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.h       |    5 +++++
 drivers/staging/batman-adv/bat_debugfs.h       |    6 +++---
 drivers/staging/batman-adv/bat_sysfs.h         |    6 +++---
 drivers/staging/batman-adv/bitarray.h          |    4 ++++
 drivers/staging/batman-adv/hard-interface.h    |    5 +++++
 drivers/staging/batman-adv/hash.h              |    8 +++++---
 drivers/staging/batman-adv/icmp_socket.h       |    5 +++++
 drivers/staging/batman-adv/main.h              |    5 +++++
 drivers/staging/batman-adv/originator.h        |    5 +++++
 drivers/staging/batman-adv/packet.h            |    5 +++++
 drivers/staging/batman-adv/ring_buffer.h       |    5 +++++
 drivers/staging/batman-adv/routing.h           |    5 +++++
 drivers/staging/batman-adv/send.h              |    5 +++++
 drivers/staging/batman-adv/soft-interface.h    |    5 +++++
 drivers/staging/batman-adv/translation-table.h |    5 +++++
 drivers/staging/batman-adv/types.h             |    6 +++---
 drivers/staging/batman-adv/vis.h               |    5 +++++
 17 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.h b/drivers/staging/batman-adv/aggregation.h
index 84401ca..71a91b3 100644
--- a/drivers/staging/batman-adv/aggregation.h
+++ b/drivers/staging/batman-adv/aggregation.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_AGGREGATION_H_
+#define _NET_BATMAN_ADV_AGGREGATION_H_
+
 #include "main.h"
 
 /* is there another aggregated packet here? */
@@ -36,3 +39,5 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 			    unsigned long send_time);
 void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 			     int packet_len, struct batman_if *if_incoming);
+
+#endif /* _NET_BATMAN_ADV_AGGREGATION_H_ */
diff --git a/drivers/staging/batman-adv/bat_debugfs.h b/drivers/staging/batman-adv/bat_debugfs.h
index 5cdd332..72df532 100644
--- a/drivers/staging/batman-adv/bat_debugfs.h
+++ b/drivers/staging/batman-adv/bat_debugfs.h
@@ -20,8 +20,8 @@
  */
 
 
-#ifndef BAT_DEBUGFS_H
-#define BAT_DEBUGFS_H
+#ifndef _NET_BATMAN_ADV_DEBUGFS_H_
+#define _NET_BATMAN_ADV_DEBUGFS_H_
 
 #define DEBUGFS_BAT_SUBDIR "batman_adv"
 
@@ -30,4 +30,4 @@ void debugfs_destroy(void);
 int debugfs_add_meshif(struct net_device *dev);
 void debugfs_del_meshif(struct net_device *dev);
 
-#endif
+#endif /* _NET_BATMAN_ADV_DEBUGFS_H_ */
diff --git a/drivers/staging/batman-adv/bat_sysfs.h b/drivers/staging/batman-adv/bat_sysfs.h
index cb45a91..7f186c0 100644
--- a/drivers/staging/batman-adv/bat_sysfs.h
+++ b/drivers/staging/batman-adv/bat_sysfs.h
@@ -20,8 +20,8 @@
  */
 
 
-#ifndef BAT_SYSFS_H
-#define BAT_SYSFS_H
+#ifndef _NET_BATMAN_ADV_SYSFS_H_
+#define _NET_BATMAN_ADV_SYSFS_H_
 
 #define SYSFS_IF_MESH_SUBDIR "mesh"
 #define SYSFS_IF_BAT_SUBDIR "batman_adv"
@@ -39,4 +39,4 @@ void sysfs_del_meshif(struct net_device *dev);
 int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev);
 void sysfs_del_hardif(struct kobject **hardif_obj);
 
-#endif
+#endif /* _NET_BATMAN_ADV_SYSFS_H_ */
diff --git a/drivers/staging/batman-adv/bitarray.h b/drivers/staging/batman-adv/bitarray.h
index dad13bf..01897d6 100644
--- a/drivers/staging/batman-adv/bitarray.h
+++ b/drivers/staging/batman-adv/bitarray.h
@@ -19,6 +19,8 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_BITARRAY_H_
+#define _NET_BATMAN_ADV_BITARRAY_H_
 
 /* you should choose something big, if you don't want to waste cpu */
 #define TYPE_OF_WORD unsigned long
@@ -40,3 +42,5 @@ char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 
 /* count the hamming weight, how many good packets did we receive? */
 int  bit_packet_count(TYPE_OF_WORD *seq_bits);
+
+#endif /* _NET_BATMAN_ADV_BITARRAY_H_ */
diff --git a/drivers/staging/batman-adv/hard-interface.h b/drivers/staging/batman-adv/hard-interface.h
index 1e5fc3e..d5640b0 100644
--- a/drivers/staging/batman-adv/hard-interface.h
+++ b/drivers/staging/batman-adv/hard-interface.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
+#define _NET_BATMAN_ADV_HARD_INTERFACE_H_
+
 #define IF_NOT_IN_USE 0
 #define IF_TO_BE_REMOVED 1
 #define IF_INACTIVE 2
@@ -38,3 +41,5 @@ int batman_skb_recv(struct sk_buff *skb,
 				struct net_device *orig_dev);
 int hardif_min_mtu(void);
 void update_min_mtu(void);
+
+#endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index 0505595..c483e11 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -19,8 +19,9 @@
  *
  */
 
-#ifndef _BATMAN_HASH_H
-#define _BATMAN_HASH_H
+#ifndef _NET_BATMAN_ADV_HASH_H_
+#define _NET_BATMAN_ADV_HASH_H_
+
 #define HASHIT(name) struct hash_it_t name = { \
 		.index = -1, .bucket = NULL, \
 		.prev_bucket = NULL, \
@@ -95,4 +96,5 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size);
  * the returned iterator to access the elements until hash_it_t returns NULL. */
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 			       struct hash_it_t *iter_in);
-#endif
+
+#endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/drivers/staging/batman-adv/icmp_socket.h b/drivers/staging/batman-adv/icmp_socket.h
index 2dc954a..bf9b348 100644
--- a/drivers/staging/batman-adv/icmp_socket.h
+++ b/drivers/staging/batman-adv/icmp_socket.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
+#define _NET_BATMAN_ADV_ICMP_SOCKET_H_
+
 #include "types.h"
 
 #define ICMP_SOCKET "socket"
@@ -27,3 +30,5 @@ void bat_socket_init(void);
 int bat_socket_setup(struct bat_priv *bat_priv);
 void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
 			       size_t icmp_len);
+
+#endif /* _NET_BATMAN_ADV_ICMP_SOCKET_H_ */
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index f6a1c04..e308673 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_MAIN_H_
+#define _NET_BATMAN_ADV_MAIN_H_
+
 /* Kernel Programming */
 #define LINUX
 
@@ -162,3 +165,5 @@ int choose_orig(void *data, int32_t size);
 int is_my_mac(uint8_t *addr);
 int is_bcast(uint8_t *addr);
 int is_mcast(uint8_t *addr);
+
+#endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index 6632538..e88411d 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_ORIGINATOR_H_
+#define _NET_BATMAN_ADV_ORIGINATOR_H_
+
 int originator_init(void);
 void originator_free(void);
 void purge_orig(struct work_struct *work);
@@ -29,3 +32,5 @@ create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
+
+#endif /* _NET_BATMAN_ADV_ORIGINATOR_H_ */
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index 8a04418..abb5e46 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_PACKET_H_
+#define _NET_BATMAN_ADV_PACKET_H_
+
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 #define BAT_PACKET    0x01
@@ -113,3 +116,5 @@ struct vis_packet {
 	uint8_t  target_orig[6]; /* who should receive this packet */
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __attribute__((packed));
+
+#endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/drivers/staging/batman-adv/ring_buffer.h b/drivers/staging/batman-adv/ring_buffer.h
index b8c9456..6b0cb9a 100644
--- a/drivers/staging/batman-adv/ring_buffer.h
+++ b/drivers/staging/batman-adv/ring_buffer.h
@@ -19,5 +19,10 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_RING_BUFFER_H_
+#define _NET_BATMAN_ADV_RING_BUFFER_H_
+
 void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value);
 uint8_t ring_buffer_avg(uint8_t lq_recv[]);
+
+#endif /* _NET_BATMAN_ADV_RING_BUFFER_H_ */
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index 43387a2..3eac64e 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_ROUTING_H_
+#define _NET_BATMAN_ADV_ROUTING_H_
+
 #include "types.h"
 
 void slide_own_bcast_window(struct batman_if *batman_if);
@@ -39,3 +42,5 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 		struct batman_if *recv_if);
 void update_bonding_candidates(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node);
+
+#endif /* _NET_BATMAN_ADV_ROUTING_H_ */
diff --git a/drivers/staging/batman-adv/send.h b/drivers/staging/batman-adv/send.h
index 0a0990d..b64c627 100644
--- a/drivers/staging/batman-adv/send.h
+++ b/drivers/staging/batman-adv/send.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_SEND_H_
+#define _NET_BATMAN_ADV_SEND_H_
+
 #include "types.h"
 
 int send_skb_packet(struct sk_buff *skb,
@@ -35,3 +38,5 @@ void schedule_forward_packet(struct orig_node *orig_node,
 int  add_bcast_packet_to_list(struct sk_buff *skb);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct batman_if *batman_if);
+
+#endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/drivers/staging/batman-adv/soft-interface.h b/drivers/staging/batman-adv/soft-interface.h
index 0847e42..6364854 100644
--- a/drivers/staging/batman-adv/soft-interface.h
+++ b/drivers/staging/batman-adv/soft-interface.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
+#define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
+
 void set_main_if_addr(uint8_t *addr);
 void interface_setup(struct net_device *dev);
 int interface_tx(struct sk_buff *skb, struct net_device *dev);
@@ -26,3 +29,5 @@ void interface_rx(struct sk_buff *skb, int hdr_size);
 int my_skb_push(struct sk_buff *skb, unsigned int len);
 
 extern unsigned char main_if_addr[];
+
+#endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
diff --git a/drivers/staging/batman-adv/translation-table.h b/drivers/staging/batman-adv/translation-table.h
index 232208f..fa93e37 100644
--- a/drivers/staging/batman-adv/translation-table.h
+++ b/drivers/staging/batman-adv/translation-table.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
+#define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
+
 #include "types.h"
 
 int hna_local_init(void);
@@ -38,3 +41,5 @@ struct orig_node *transtable_search(uint8_t *addr);
 extern spinlock_t hna_local_hash_lock;
 extern struct hashtable_t *hna_local_hash;
 extern atomic_t hna_local_changed;
+
+#endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index e1fc460..82602d0 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -23,8 +23,8 @@
 
 
 
-#ifndef TYPES_H
-#define TYPES_H
+#ifndef _NET_BATMAN_ADV_TYPES_H_
+#define _NET_BATMAN_ADV_TYPES_H_
 
 #include "packet.h"
 #include "bitarray.h"
@@ -172,4 +172,4 @@ struct if_list_entry {
 	struct hlist_node list;
 };
 
-#endif
+#endif /* _NET_BATMAN_ADV_TYPES_H_ */
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index e152cd7..bb13bf1 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_VIS_H_
+#define _NET_BATMAN_ADV_VIS_H_
+
 #define VIS_TIMEOUT		200	/* timeout of vis packets in seconds */
 
 struct vis_info {
@@ -53,3 +56,5 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 				  int vis_info_len);
 int vis_init(void);
 void vis_quit(void);
+
+#endif /* _NET_BATMAN_ADV_VIS_H_ */
-- 
1.7.1

