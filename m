Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:18 +0800
Message-Id: <1452345621-15908-14-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 13/16] batman-adv: Fix kernel-doc parsing of
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

kernel-doc is not able to skip an #ifdef between the kernel documentation
block and the start of the struct. Moving the #ifdef before the kernel doc
block avoids this problem

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7c386dbb75f0..876ac336c61e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -423,13 +423,14 @@ struct batadv_neigh_ifinfo {
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
@@ -571,6 +572,8 @@ struct batadv_priv_tt {
 	struct delayed_work work;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
  * @num_requests; number of bla requests in flight
@@ -583,7 +586,6 @@ struct batadv_priv_tt {
  * @claim_dest: local claim data (e.g. claim group)
  * @work: work queue callback item for cleanups & bla announcements
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
 	struct batadv_hashtable *claim_hash;
@@ -597,6 +599,8 @@ struct batadv_priv_bla {
 };
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
 /**
  * struct batadv_priv_debug_log - debug logging data
  * @log_buff: buffer holding the logs (ring bufer)
@@ -605,7 +609,6 @@ struct batadv_priv_bla {
  * @lock: lock protecting log_buff, log_start & log_end
  * @queue_wait: log reader's wait queue
  */
-#ifdef CONFIG_BATMAN_ADV_DEBUG
 struct batadv_priv_debug_log {
 	char log_buff[BATADV_LOG_BUF_LEN];
 	unsigned long log_start;
@@ -647,13 +650,14 @@ struct batadv_priv_tvlv {
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
@@ -893,6 +897,8 @@ struct batadv_socket_packet {
 	u8 icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  * @orig: originator address of backbone node (mac address of primary iface)
@@ -910,7 +916,6 @@ struct batadv_socket_packet {
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bla_backbone_gw {
 	u8 orig[ETH_ALEN];
 	unsigned short vid;
-- 
2.7.0

