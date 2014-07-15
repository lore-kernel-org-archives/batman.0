Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 15 Jul 2014 09:41:17 +0200
Message-Id: <1405410077-28764-13-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
References: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 13/13] batman-adv: kernel doc fixes for
	types.h
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

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 types.h | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/types.h b/types.h
index 8854c05..4018479 100644
--- a/types.h
+++ b/types.h
@@ -24,9 +24,8 @@
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 
-/**
- * batadv_dat_addr_t - it is the type used for all DHT addresses. If it is
- *  changed, BATADV_DAT_ADDR_MAX is changed as well.
+/* batadv_dat_addr_t - it is the type used for all DHT addresses. If it is
+ * changed, BATADV_DAT_ADDR_MAX is changed as well.
  *
  * *Please be careful: batadv_dat_addr_t must be UNSIGNED*
  */
@@ -46,15 +45,13 @@ enum batadv_dhcp_recipient {
 	BATADV_DHCP_TO_CLIENT,
 };
 
-/**
- * BATADV_TT_REMOTE_MASK - bitmask selecting the flags that are sent over the
- *  wire only
+/* BATADV_TT_REMOTE_MASK - bitmask selecting the flags that are sent over the
+ * wire only
  */
 #define BATADV_TT_REMOTE_MASK	0x00FF
 
-/**
- * BATADV_TT_SYNC_MASK - bitmask of the flags that need to be kept in sync
- *  among the nodes. These flags are used to compute the global/local CRC
+/* BATADV_TT_SYNC_MASK - bitmask of the flags that need to be kept in sync
+ * among the nodes. These flags are used to compute the global/local CRC
  */
 #define BATADV_TT_SYNC_MASK	0x00F0
 
@@ -202,11 +199,11 @@ struct batadv_orig_bat_iv {
  * @primary_addr: hosts primary interface address
  * @ifinfo_list: list for routers per outgoing interface
  * @last_bonding_candidate: pointer to last ifinfo of last used router
- * @batadv_dat_addr_t:  address of the orig node in the distributed hash
+ * @dat_addr: address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @mcast_flags: multicast flags announced by the orig node
- * @mcast_want_all_unsnoop_node: a list node for the
+ * @mcast_want_all_unsnoopables_node: a list node for the
  *  mcast.want_all_unsnoopables list
  * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 list
  * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 list
@@ -333,9 +330,8 @@ struct batadv_gw_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
- * @last_ttl: last received ttl from this neigh node
+ * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_neigh_node {
 	struct hlist_node list;
@@ -385,13 +381,13 @@ struct batadv_neigh_ifinfo {
 	struct rcu_head rcu;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
- * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
+ * @orig: mac address of orig node orginating the broadcast
  * @crc: crc32 checksum of broadcast payload
  * @entrytime: time when the broadcast packet was received
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bcast_duplist_entry {
 	uint8_t orig[ETH_ALEN];
 	__be32 crc;
@@ -533,9 +529,10 @@ struct batadv_priv_tt {
 	struct delayed_work work;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
- * @num_requests; number of bla requests in flight
+ * @num_requests: number of bla requests in flight
  * @claim_hash: hash table containing mesh nodes this host has claimed
  * @backbone_hash: hash table containing all detected backbone gateways
  * @bcast_duplist: recently received broadcast packets array (for broadcast
@@ -545,7 +542,6 @@ struct batadv_priv_tt {
  * @claim_dest: local claim data (e.g. claim group)
  * @work: work queue callback item for cleanups & bla announcements
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
 	struct batadv_hashtable *claim_hash;
@@ -559,6 +555,7 @@ struct batadv_priv_bla {
 };
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
 /**
  * struct batadv_priv_debug_log - debug logging data
  * @log_buff: buffer holding the logs (ring bufer)
@@ -567,7 +564,6 @@ struct batadv_priv_bla {
  * @lock: lock protecting log_buff, log_start & log_end
  * @queue_wait: log reader's wait queue
  */
-#ifdef CONFIG_BATMAN_ADV_DEBUG
 struct batadv_priv_debug_log {
 	char log_buff[BATADV_LOG_BUF_LEN];
 	unsigned long log_start;
@@ -609,13 +605,13 @@ struct batadv_priv_tvlv {
 	spinlock_t handler_list_lock; /* protects handler_list */
 };
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 /**
  * struct batadv_priv_dat - per mesh interface DAT private data
  * @addr: node DAT address
  * @hash: hashtable representing the local ARP cache
  * @work: work queue callback item for cache purging
  */
-#ifdef CONFIG_BATMAN_ADV_DAT
 struct batadv_priv_dat {
 	batadv_dat_addr_t addr;
 	struct batadv_hashtable *hash;
@@ -730,6 +726,8 @@ struct batadv_softif_vlan {
  * @orig_interval: OGM broadcast interval in milliseconds
  * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
  * @log_level: configured log level (see batadv_dbg_level)
+ * @isolation_mark: mark to use in ap isolation when filtering packets
+ * @isolation_mark_mask: mask of bits to check when filtering packets
  * @bcast_seqno: last sent broadcast packet sequence number
  * @bcast_queue_left: number of remaining buffered broadcast packet slots
  * @batman_queue_left: number of remaining OGM packet slots
@@ -757,7 +755,7 @@ struct batadv_softif_vlan {
  * @dat: distributed arp table data
  * @mcast: multicast data
  * @network_coding: bool indicating whether network coding is enabled
- * @batadv_priv_nc: network coding data
+ * @nc: network coding data
  */
 struct batadv_priv {
 	atomic_t mesh_state;
@@ -855,6 +853,7 @@ struct batadv_socket_packet {
 	uint8_t icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  * @orig: originator address of backbone node (mac address of primary iface)
@@ -871,7 +870,6 @@ struct batadv_socket_packet {
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bla_backbone_gw {
 	uint8_t orig[ETH_ALEN];
 	unsigned short vid;
@@ -889,7 +887,7 @@ struct batadv_bla_backbone_gw {
  * struct batadv_bla_claim - claimed non-mesh client structure
  * @addr: mac address of claimed non-mesh client
  * @vid: vlan id this client was detected on
- * @batadv_bla_backbone_gw: pointer to backbone gw claiming this client
+ * @backbone_gw: pointer to backbone gw claiming this client
  * @lasttime: last time we heard of claim (locals only)
  * @hash_entry: hlist node for batadv_priv_bla::claim_hash
  * @refcount: number of contexts the object is used
@@ -1204,9 +1202,7 @@ struct batadv_dat_candidate {
  * struct batadv_tvlv_container - container for tvlv appended to OGMs
  * @list: hlist node for batadv_priv_tvlv::container_list
  * @tvlv_hdr: tvlv header information needed to construct the tvlv
- * @value_len: length of the buffer following this struct which contains
- *  the actual tvlv payload
- * @refcount: number of contexts the object is used
+ * @refcount: number of contexts the object is used in
  */
 struct batadv_tvlv_container {
 	struct hlist_node list;
-- 
2.0.1

