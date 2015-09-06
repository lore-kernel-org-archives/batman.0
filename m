Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:45 +0200
Message-Id: <1441568333-15947-2-git-send-email-sven@narfation.org>
In-Reply-To: <1441568333-15947-1-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Fix kernel-doc parsing of
	main structs
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

kernel-doc is not able to skip an #ifdef between the kernel documentation
block and the start of the struct. Moving the #ifdef before the kernel doc
block avoids this problem

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d260efd..6e8515c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -401,13 +401,14 @@ struct batadv_neigh_ifinfo {
 	struct rcu_head rcu;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
  * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
  * @crc: crc32 checksum of broadcast payload
  * @entrytime: time when the broadcast packet was received
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bcast_duplist_entry {
 	u8 orig[ETH_ALEN];
 	__be32 crc;
@@ -549,6 +550,8 @@ struct batadv_priv_tt {
 	struct delayed_work work;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
  * @num_requests; number of bla requests in flight
@@ -561,7 +564,6 @@ struct batadv_priv_tt {
  * @claim_dest: local claim data (e.g. claim group)
  * @work: work queue callback item for cleanups & bla announcements
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
 	struct batadv_hashtable *claim_hash;
@@ -575,6 +577,8 @@ struct batadv_priv_bla {
 };
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
 /**
  * struct batadv_priv_debug_log - debug logging data
  * @log_buff: buffer holding the logs (ring bufer)
@@ -583,7 +587,6 @@ struct batadv_priv_bla {
  * @lock: lock protecting log_buff, log_start & log_end
  * @queue_wait: log reader's wait queue
  */
-#ifdef CONFIG_BATMAN_ADV_DEBUG
 struct batadv_priv_debug_log {
 	char log_buff[BATADV_LOG_BUF_LEN];
 	unsigned long log_start;
@@ -625,13 +628,14 @@ struct batadv_priv_tvlv {
 	spinlock_t handler_list_lock; /* protects handler_list */
 };
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
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
@@ -871,6 +875,8 @@ struct batadv_socket_packet {
 	u8 icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  * @orig: originator address of backbone node (mac address of primary iface)
@@ -887,7 +893,6 @@ struct batadv_socket_packet {
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bla_backbone_gw {
 	u8 orig[ETH_ALEN];
 	unsigned short vid;
-- 
2.5.1

