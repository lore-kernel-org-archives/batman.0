Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  2 Dec 2017 19:51:48 +0100
Message-Id: <20171202185153.552-4-sven@narfation.org>
In-Reply-To: <20171202185153.552-1-sven@narfation.org>
References: <20171202185153.552-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: Use inline kernel-doc for
 enum/struct
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

The inline kernel-doc comments make it easier to keep changes to the
struct/enum synchronized with the documentation of the it. And it makes it
easier for larger structures like struct batadv_priv to read the
documentation inside the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c     |   17 +-
 net/batman-adv/gateway_common.h |    5 +-
 net/batman-adv/hard-interface.h |   27 +-
 net/batman-adv/log.h            |   26 +-
 net/batman-adv/multicast.h      |   16 +-
 net/batman-adv/types.h          | 1989 +++++++++++++++++++++++++++------------
 6 files changed, 1444 insertions(+), 636 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6cbf9afb..7c603e4b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -72,16 +72,23 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work);
 
 /**
  * enum batadv_dup_status - duplicate status
- * @BATADV_NO_DUP: the packet is no duplicate
- * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for the
- *  neighbor)
- * @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor
- * @BATADV_PROTECTED: originator is currently protected (after reboot)
  */
 enum batadv_dup_status {
+	/** @BATADV_NO_DUP: the packet is no duplicate */
 	BATADV_NO_DUP = 0,
+
+	/**
+	 * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for
+	 *  the neighbor)
+	 */
 	BATADV_ORIG_DUP,
+
+	/** @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor */
 	BATADV_NEIGH_DUP,
+
+	/**
+	 * @BATADV_PROTECTED: originator is currently protected (after reboot)
+	 */
 	BATADV_PROTECTED,
 };
 
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 0a6a97d2..be586c26 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -32,11 +32,12 @@ enum batadv_gw_modes {
 
 /**
  * enum batadv_bandwidth_units - bandwidth unit types
- * @BATADV_BW_UNIT_KBIT: unit type kbit
- * @BATADV_BW_UNIT_MBIT: unit type mbit
  */
 enum batadv_bandwidth_units {
+	/** @BATADV_BW_UNIT_KBIT: unit type kbit */
 	BATADV_BW_UNIT_KBIT,
+
+	/** @BATADV_BW_UNIT_MBIT: unit type mbit */
 	BATADV_BW_UNIT_MBIT,
 };
 
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 82228fc3..ba4ba081 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -41,25 +41,40 @@ enum batadv_hard_if_state {
 
 /**
  * enum batadv_hard_if_bcast - broadcast avoidance options
- * @BATADV_HARDIF_BCAST_OK: Do broadcast on according hard interface
- * @BATADV_HARDIF_BCAST_NORECIPIENT: Broadcast not needed, there is no recipient
- * @BATADV_HARDIF_BCAST_DUPFWD: There is just the neighbor we got it from
- * @BATADV_HARDIF_BCAST_DUPORIG: There is just the originator
  */
 enum batadv_hard_if_bcast {
+	/** @BATADV_HARDIF_BCAST_OK: Do broadcast on according hard interface */
 	BATADV_HARDIF_BCAST_OK = 0,
+
+	/**
+	 * @BATADV_HARDIF_BCAST_NORECIPIENT: Broadcast not needed, there is no
+	 *  recipient
+	 */
 	BATADV_HARDIF_BCAST_NORECIPIENT,
+
+	/**
+	 * @BATADV_HARDIF_BCAST_DUPFWD: There is just the neighbor we got it
+	 *  from
+	 */
 	BATADV_HARDIF_BCAST_DUPFWD,
+
+	/** @BATADV_HARDIF_BCAST_DUPORIG: There is just the originator */
 	BATADV_HARDIF_BCAST_DUPORIG,
 };
 
 /**
  * enum batadv_hard_if_cleanup - Cleanup modi for soft_iface after slave removal
- * @BATADV_IF_CLEANUP_KEEP: Don't automatically delete soft-interface
- * @BATADV_IF_CLEANUP_AUTO: Delete soft-interface after last slave was removed
  */
 enum batadv_hard_if_cleanup {
+	/**
+	 * @BATADV_IF_CLEANUP_KEEP: Don't automatically delete soft-interface
+	 */
 	BATADV_IF_CLEANUP_KEEP,
+
+	/**
+	 * @BATADV_IF_CLEANUP_AUTO: Delete soft-interface after last slave was
+	 *  removed
+	 */
 	BATADV_IF_CLEANUP_AUTO,
 };
 
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 65ce97ef..4c48a89d 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -44,25 +44,33 @@ static inline void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 
 /**
  * enum batadv_dbg_level - available log levels
- * @BATADV_DBG_BATMAN: OGM and TQ computations related messages
- * @BATADV_DBG_ROUTES: route added / changed / deleted
- * @BATADV_DBG_TT: translation table messages
- * @BATADV_DBG_BLA: bridge loop avoidance messages
- * @BATADV_DBG_DAT: ARP snooping and DAT related messages
- * @BATADV_DBG_NC: network coding related messages
- * @BATADV_DBG_MCAST: multicast related messages
- * @BATADV_DBG_TP_METER: throughput meter messages
- * @BATADV_DBG_ALL: the union of all the above log levels
  */
 enum batadv_dbg_level {
+	/** @BATADV_DBG_BATMAN: OGM and TQ computations related messages */
 	BATADV_DBG_BATMAN	= BIT(0),
+
+	/** @BATADV_DBG_ROUTES: route added / changed / deleted */
 	BATADV_DBG_ROUTES	= BIT(1),
+
+	/** @BATADV_DBG_TT: translation table messages */
 	BATADV_DBG_TT		= BIT(2),
+
+	/** @BATADV_DBG_BLA: bridge loop avoidance messages */
 	BATADV_DBG_BLA		= BIT(3),
+
+	/** @BATADV_DBG_DAT: ARP snooping and DAT related messages */
 	BATADV_DBG_DAT		= BIT(4),
+
+	/** @BATADV_DBG_NC: network coding related messages */
 	BATADV_DBG_NC		= BIT(5),
+
+	/** @BATADV_DBG_MCAST: multicast related messages */
 	BATADV_DBG_MCAST	= BIT(6),
+
+	/** @BATADV_DBG_TP_METER: throughput meter messages */
 	BATADV_DBG_TP_METER	= BIT(7),
+
+	/** @BATADV_DBG_ALL: the union of all the above log levels */
 	BATADV_DBG_ALL		= 255,
 };
 
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 2a78cdda..2053a9f2 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -25,15 +25,21 @@ struct sk_buff;
 
 /**
  * enum batadv_forw_mode - the way a packet should be forwarded as
- * @BATADV_FORW_ALL: forward the packet to all nodes (currently via classic
- *  flooding)
- * @BATADV_FORW_SINGLE: forward the packet to a single node (currently via the
- *  BATMAN unicast routing protocol)
- * @BATADV_FORW_NONE: don't forward, drop it
  */
 enum batadv_forw_mode {
+	/**
+	 * @BATADV_FORW_ALL: forward the packet to all nodes (currently via
+	 *  classic flooding)
+	 */
 	BATADV_FORW_ALL,
+
+	/**
+	 * @BATADV_FORW_SINGLE: forward the packet to a single node (currently
+	 *  via the BATMAN unicast routing protocol)
+	 */
 	BATADV_FORW_SINGLE,
+
+	/** @BATADV_FORW_NONE: don't forward, drop it */
 	BATADV_FORW_NONE,
 };
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a6279586..5e7a6edc 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -54,13 +54,15 @@ struct seq_file;
 
 /**
  * enum batadv_dhcp_recipient - dhcp destination
- * @BATADV_DHCP_NO: packet is not a dhcp message
- * @BATADV_DHCP_TO_SERVER: dhcp message is directed to a server
- * @BATADV_DHCP_TO_CLIENT: dhcp message is directed to a client
  */
 enum batadv_dhcp_recipient {
+	/** @BATADV_DHCP_NO: packet is not a dhcp message */
 	BATADV_DHCP_NO = 0,
+
+	/** @BATADV_DHCP_TO_SERVER: dhcp message is directed to a server */
 	BATADV_DHCP_TO_SERVER,
+
+	/** @BATADV_DHCP_TO_CLIENT: dhcp message is directed to a client */
 	BATADV_DHCP_TO_CLIENT,
 };
 
@@ -78,196 +80,274 @@ enum batadv_dhcp_recipient {
 
 /**
  * struct batadv_hard_iface_bat_iv - per hard-interface B.A.T.M.A.N. IV data
- * @ogm_buff: buffer holding the OGM packet
- * @ogm_buff_len: length of the OGM packet buffer
- * @ogm_seqno: OGM sequence number - used to identify each OGM
  */
 struct batadv_hard_iface_bat_iv {
+	/** @ogm_buff: buffer holding the OGM packet */
 	unsigned char *ogm_buff;
+
+	/** @ogm_buff_len: length of the OGM packet buffer */
 	int ogm_buff_len;
+
+	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 };
 
 /**
  * enum batadv_v_hard_iface_flags - interface flags useful to B.A.T.M.A.N. V
- * @BATADV_FULL_DUPLEX: tells if the connection over this link is full-duplex
- * @BATADV_WARNING_DEFAULT: tells whether we have warned the user that no
- *  throughput data is available for this interface and that default values are
- *  assumed.
  */
 enum batadv_v_hard_iface_flags {
+	/**
+	 * @BATADV_FULL_DUPLEX: tells if the connection over this link is
+	 *  full-duplex
+	 */
 	BATADV_FULL_DUPLEX	= BIT(0),
+
+	/**
+	 * @BATADV_WARNING_DEFAULT: tells whether we have warned the user that
+	 *  no throughput data is available for this interface and that default
+	 *  values are assumed.
+	 */
 	BATADV_WARNING_DEFAULT	= BIT(1),
 };
 
 /**
  * struct batadv_hard_iface_bat_v - per hard-interface B.A.T.M.A.N. V data
- * @elp_interval: time interval between two ELP transmissions
- * @elp_seqno: current ELP sequence number
- * @elp_skb: base skb containing the ELP message to send
- * @elp_wq: workqueue used to schedule ELP transmissions
- * @throughput_override: throughput override to disable link auto-detection
- * @flags: interface specific flags
  */
 struct batadv_hard_iface_bat_v {
+	/** @elp_interval: time interval between two ELP transmissions */
 	atomic_t elp_interval;
+
+	/** @elp_seqno: current ELP sequence number */
 	atomic_t elp_seqno;
+
+	/** @elp_skb: base skb containing the ELP message to send */
 	struct sk_buff *elp_skb;
+
+	/** @elp_wq: workqueue used to schedule ELP transmissions */
 	struct delayed_work elp_wq;
+
+	/**
+	 * @throughput_override: throughput override to disable link
+	 *  auto-detection
+	 */
 	atomic_t throughput_override;
+
+	/** @flags: interface specific flags */
 	u8 flags;
 };
 
 /**
  * enum batadv_hard_iface_wifi_flags - Flags describing the wifi configuration
  *  of a batadv_hard_iface
- * @BATADV_HARDIF_WIFI_WEXT_DIRECT: it is a wext wifi device
- * @BATADV_HARDIF_WIFI_CFG80211_DIRECT: it is a cfg80211 wifi device
- * @BATADV_HARDIF_WIFI_WEXT_INDIRECT: link device is a wext wifi device
- * @BATADV_HARDIF_WIFI_CFG80211_INDIRECT: link device is a cfg80211 wifi device
  */
 enum batadv_hard_iface_wifi_flags {
+	/** @BATADV_HARDIF_WIFI_WEXT_DIRECT: it is a wext wifi device */
 	BATADV_HARDIF_WIFI_WEXT_DIRECT = BIT(0),
+
+	/** @BATADV_HARDIF_WIFI_CFG80211_DIRECT: it is a cfg80211 wifi device */
 	BATADV_HARDIF_WIFI_CFG80211_DIRECT = BIT(1),
+
+	/**
+	 * @BATADV_HARDIF_WIFI_WEXT_INDIRECT: link device is a wext wifi device
+	 */
 	BATADV_HARDIF_WIFI_WEXT_INDIRECT = BIT(2),
+
+	/**
+	 * @BATADV_HARDIF_WIFI_CFG80211_INDIRECT: link device is a cfg80211 wifi
+	 * device
+	 */
 	BATADV_HARDIF_WIFI_CFG80211_INDIRECT = BIT(3),
 };
 
 /**
  * struct batadv_hard_iface - network device known to batman-adv
- * @list: list node for batadv_hardif_list
- * @if_num: identificator of the interface
- * @if_status: status of the interface for batman-adv
- * @num_bcasts: number of payload re-broadcasts on this interface (ARQ)
- * @wifi_flags: flags whether this is (directly or indirectly) a wifi interface
- * @net_dev: pointer to the net_device
- * @hardif_obj: kobject of the per interface sysfs "mesh" directory
- * @refcount: number of contexts the object is used
- * @batman_adv_ptype: packet type describing packets that should be processed by
- *  batman-adv for this interface
- * @soft_iface: the batman-adv interface which uses this network interface
- * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: per hard-interface B.A.T.M.A.N. IV data
- * @bat_v: per hard-interface B.A.T.M.A.N. V data
- * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
- * @neigh_list: list of unique single hop neighbors via this interface
- * @neigh_list_lock: lock protecting neigh_list
  */
 struct batadv_hard_iface {
+	/** @list: list node for batadv_hardif_list */
 	struct list_head list;
+
+	/** @if_num: identificator of the interface */
 	s16 if_num;
+
+	/** @if_status: status of the interface for batman-adv */
 	char if_status;
+
+	/**
+	 * @num_bcasts: number of payload re-broadcasts on this interface (ARQ)
+	 */
 	u8 num_bcasts;
+
+	/**
+	 * @wifi_flags: flags whether this is (directly or indirectly) a wifi
+	 *  interface
+	 */
 	u32 wifi_flags;
+
+	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
+
+	/** @hardif_obj: kobject of the per interface sysfs "mesh" directory */
 	struct kobject *hardif_obj;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/**
+	 * @batman_adv_ptype: packet type describing packets that should be
+	 * processed by batman-adv for this interface
+	 */
 	struct packet_type batman_adv_ptype;
+
+	/**
+	 * @soft_iface: the batman-adv interface which uses this network
+	 *  interface
+	 */
 	struct net_device *soft_iface;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
+
+	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;
+
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/** @bat_v: per hard-interface B.A.T.M.A.N. V data */
 	struct batadv_hard_iface_bat_v bat_v;
 #endif
+
+	/**
+	 * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
+	 */
 	struct dentry *debug_dir;
+
+	/**
+	 * @neigh_list: list of unique single hop neighbors via this interface
+	 */
 	struct hlist_head neigh_list;
-	/* neigh_list_lock protects: neigh_list */
+
+	/** @neigh_list_lock: lock protecting neigh_list */
 	spinlock_t neigh_list_lock;
 };
 
 /**
  * struct batadv_orig_ifinfo - originator info per outgoing interface
- * @list: list node for orig_node::ifinfo_list
- * @if_outgoing: pointer to outgoing hard-interface
- * @router: router that should be used to reach this originator
- * @last_real_seqno: last and best known sequence number
- * @last_ttl: ttl of last received packet
- * @last_seqno_forwarded: seqno of the OGM which was forwarded last
- * @batman_seqno_reset: time when the batman seqno window was reset
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_orig_ifinfo {
+	/** @list: list node for orig_node::ifinfo_list */
 	struct hlist_node list;
+
+	/** @if_outgoing: pointer to outgoing hard-interface */
 	struct batadv_hard_iface *if_outgoing;
-	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+
+	/** @router: router that should be used to reach this originator */
+	struct batadv_neigh_node __rcu *router;
+
+	/** @last_real_seqno: last and best known sequence number */
 	u32 last_real_seqno;
+
+	/** @last_ttl: ttl of last received packet */
 	u8 last_ttl;
+
+	/** @last_seqno_forwarded: seqno of the OGM which was forwarded last */
 	u32 last_seqno_forwarded;
+
+	/** @batman_seqno_reset: time when the batman seqno window was reset */
 	unsigned long batman_seqno_reset;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_frag_table_entry - head in the fragment buffer table
- * @fragment_list: head of list with fragments
- * @lock: lock to protect the list of fragments
- * @timestamp: time (jiffie) of last received fragment
- * @seqno: sequence number of the fragments in the list
- * @size: accumulated size of packets in list
- * @total_size: expected size of the assembled packet
  */
 struct batadv_frag_table_entry {
+	/** @fragment_list: head of list with fragments */
 	struct hlist_head fragment_list;
-	spinlock_t lock; /* protects fragment_list */
+
+	/** @lock: lock to protect the list of fragments */
+	spinlock_t lock;
+
+	/** @timestamp: time (jiffie) of last received fragment */
 	unsigned long timestamp;
+
+	/** @seqno: sequence number of the fragments in the list */
 	u16 seqno;
+
+	/** @size: accumulated size of packets in list */
 	u16 size;
+
+	/** @total_size: expected size of the assembled packet */
 	u16 total_size;
 };
 
 /**
  * struct batadv_frag_list_entry - entry in a list of fragments
- * @list: list node information
- * @skb: fragment
- * @no: fragment number in the set
  */
 struct batadv_frag_list_entry {
+	/** @list: list node information */
 	struct hlist_node list;
+
+	/** @skb: fragment */
 	struct sk_buff *skb;
+
+	/** @no: fragment number in the set */
 	u8 no;
 };
 
 /**
  * struct batadv_vlan_tt - VLAN specific TT attributes
- * @crc: CRC32 checksum of the entries belonging to this vlan
- * @num_entries: number of TT entries for this VLAN
  */
 struct batadv_vlan_tt {
+	/** @crc: CRC32 checksum of the entries belonging to this vlan */
 	u32 crc;
+
+	/** @num_entries: number of TT entries for this VLAN */
 	atomic_t num_entries;
 };
 
 /**
  * struct batadv_orig_node_vlan - VLAN specific data per orig_node
- * @vid: the VLAN identifier
- * @tt: VLAN specific TT attributes
- * @list: list node for orig_node::vlan_list
- * @refcount: number of context where this object is currently in use
- * @rcu: struct used for freeing in a RCU-safe manner
  */
 struct batadv_orig_node_vlan {
+	/** @vid: the VLAN identifier */
 	unsigned short vid;
+
+	/** @tt: VLAN specific TT attributes */
 	struct batadv_vlan_tt tt;
+
+	/** @list: list node for orig_node::vlan_list */
 	struct hlist_node list;
+
+	/**
+	 * @refcount: number of context where this object is currently in use
+	 */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in a RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
- * @bcast_own: set of bitfields (one per hard-interface) where each one counts
- * the number of our OGMs this orig_node rebroadcasted "back" to us  (relative
- * to last_real_seqno). Every bitfield is BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
- * @bcast_own_sum: sum of bcast_own
- * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
- *  neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
  */
 struct batadv_orig_bat_iv {
+	/**
+	 * @bcast_own: set of bitfields (one per hard-interface) where each one
+	 * counts the number of our OGMs this orig_node rebroadcasted "back" to
+	 * us  (relative to last_real_seqno). Every bitfield is
+	 * BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
+	 */
 	unsigned long *bcast_own;
+
+	/** @bcast_own_sum: sum of bcast_own */
 	u8 *bcast_own_sum;
-	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
+
+	/**
+	 * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
 	 * neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
 	 */
 	spinlock_t ogm_cnt_lock;
@@ -275,130 +355,205 @@ struct batadv_orig_bat_iv {
 
 /**
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
- * @orig: originator ethernet address
- * @ifinfo_list: list for routers per outgoing interface
- * @last_bonding_candidate: pointer to last ifinfo of last used router
- * @dat_addr: address of the orig node in the distributed hash
- * @last_seen: time when last packet from this node was received
- * @bcast_seqno_reset: time when the broadcast seqno window was reset
- * @mcast_handler_lock: synchronizes mcast-capability and -flag changes
- * @mcast_flags: multicast flags announced by the orig node
- * @mcast_want_all_unsnoopables_node: a list node for the
- *  mcast.want_all_unsnoopables list
- * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 list
- * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 list
- * @capabilities: announced capabilities of this originator
- * @capa_initialized: bitfield to remember whether a capability was initialized
- * @last_ttvn: last seen translation table version number
- * @tt_buff: last tt changeset this node received from the orig node
- * @tt_buff_len: length of the last tt changeset this node received from the
- *  orig node
- * @tt_buff_lock: lock that protects tt_buff and tt_buff_len
- * @tt_lock: prevents from updating the table while reading it. Table update is
- *  made up by two operations (data structure update and metdata -CRC/TTVN-
- *  recalculation) and they have to be executed atomically in order to avoid
- *  another thread to read the table/metadata between those.
- * @bcast_bits: bitfield containing the info which payload broadcast originated
- *  from this orig node this host already has seen (relative to
- *  last_bcast_seqno)
- * @last_bcast_seqno: last broadcast sequence number received by this host
- * @neigh_list: list of potential next hop neighbor towards this orig node
- * @neigh_list_lock: lock protecting neigh_list and router
- * @hash_entry: hlist node for batadv_priv::orig_hash
- * @bat_priv: pointer to soft_iface this orig node belongs to
- * @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
- * @in_coding_list: list of nodes this orig can hear
- * @out_coding_list: list of nodes that can hear this orig
- * @in_coding_list_lock: protects in_coding_list
- * @out_coding_list_lock: protects out_coding_list
- * @fragments: array with heads for fragment chains
- * @vlan_list: a list of orig_node_vlan structs, one per VLAN served by the
- *  originator represented by this object
- * @vlan_list_lock: lock protecting vlan_list
- * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_orig_node {
+	/** @orig: originator ethernet address */
 	u8 orig[ETH_ALEN];
+
+	/** @ifinfo_list: list for routers per outgoing interface */
 	struct hlist_head ifinfo_list;
+
+	/**
+	 * @last_bonding_candidate: pointer to last ifinfo of last used router
+	 */
 	struct batadv_orig_ifinfo *last_bonding_candidate;
+
 #ifdef CONFIG_BATMAN_ADV_DAT
+	/** @dat_addr: address of the orig node in the distributed hash */
 	batadv_dat_addr_t dat_addr;
 #endif
+
+	/** @last_seen: time when last packet from this node was received */
 	unsigned long last_seen;
+
+	/**
+	 * @bcast_seqno_reset: time when the broadcast seqno window was reset
+	 */
 	unsigned long bcast_seqno_reset;
+
 #ifdef CONFIG_BATMAN_ADV_MCAST
-	/* synchronizes mcast tvlv specific orig changes */
+	/**
+	 * @mcast_handler_lock: synchronizes mcast-capability and -flag changes
+	 */
 	spinlock_t mcast_handler_lock;
+
+	/** @mcast_flags: multicast flags announced by the orig node */
 	u8 mcast_flags;
+
+	/**
+	 * @mcast_want_all_unsnoopables_node: a list node for the
+	 *  mcast.want_all_unsnoopables list
+	 */
 	struct hlist_node mcast_want_all_unsnoopables_node;
+
+	/**
+	 * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4
+	 *  list
+	 */
 	struct hlist_node mcast_want_all_ipv4_node;
+	/**
+	 * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6
+	 *  list
+	 */
 	struct hlist_node mcast_want_all_ipv6_node;
 #endif
+
+	/** @capabilities: announced capabilities of this originator */
 	unsigned long capabilities;
+
+	/**
+	 * @capa_initialized: bitfield to remember whether a capability was
+	 *  initialized
+	 */
 	unsigned long capa_initialized;
+
+	/** @last_ttvn: last seen translation table version number */
 	atomic_t last_ttvn;
+
+	/** @tt_buff: last tt changeset this node received from the orig node */
 	unsigned char *tt_buff;
+
+	/**
+	 * @tt_buff_len: length of the last tt changeset this node received
+	 *  from the orig node
+	 */
 	s16 tt_buff_len;
-	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
-	/* prevents from changing the table while reading it */
+
+	/** @tt_buff_lock: lock that protects tt_buff and tt_buff_len */
+	spinlock_t tt_buff_lock;
+
+	/**
+	 * @tt_lock: prevents from updating the table while reading it. Table
+	 *  update is made up by two operations (data structure update and
+	 *  metdata -CRC/TTVN-recalculation) and they have to be executed
+	 *  atomically in order to avoid another thread to read the
+	 *  table/metadata between those.
+	 */
 	spinlock_t tt_lock;
+
+	/**
+	 * @bcast_bits: bitfield containing the info which payload broadcast
+	 *  originated from this orig node this host already has seen (relative
+	 *  to last_bcast_seqno)
+	 */
 	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
+
+	/**
+	 * @last_bcast_seqno: last broadcast sequence number received by this
+	 *  host
+	 */
 	u32 last_bcast_seqno;
+
+	/**
+	 * @neigh_list: list of potential next hop neighbor towards this orig
+	 *  node
+	 */
 	struct hlist_head neigh_list;
-	/* neigh_list_lock protects: neigh_list, ifinfo_list,
-	 * last_bonding_candidate and router
+
+	/**
+	 * @neigh_list_lock: lock protecting neigh_list, ifinfo_list,
+	 *  last_bonding_candidate and router
 	 */
 	spinlock_t neigh_list_lock;
+
+	/** @hash_entry: hlist node for batadv_priv::orig_hash */
 	struct hlist_node hash_entry;
+
+	/** @bat_priv: pointer to soft_iface this orig node belongs to */
 	struct batadv_priv *bat_priv;
-	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
+
+	/** @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno */
 	spinlock_t bcast_seqno_lock;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
+
 #ifdef CONFIG_BATMAN_ADV_NC
+	/** @in_coding_list: list of nodes this orig can hear */
 	struct list_head in_coding_list;
+
+	/** @out_coding_list: list of nodes that can hear this orig */
 	struct list_head out_coding_list;
-	spinlock_t in_coding_list_lock; /* Protects in_coding_list */
-	spinlock_t out_coding_list_lock; /* Protects out_coding_list */
+
+	/** @in_coding_list_lock: protects in_coding_list */
+	spinlock_t in_coding_list_lock;
+
+	/** @out_coding_list_lock: protects out_coding_list */
+	spinlock_t out_coding_list_lock;
 #endif
+
+	/** @fragments: array with heads for fragment chains */
 	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
+
+	/**
+	 * @vlan_list: a list of orig_node_vlan structs, one per VLAN served by
+	 *  the originator represented by this object
+	 */
 	struct hlist_head vlan_list;
-	spinlock_t vlan_list_lock; /* protects vlan_list */
+
+	/** @vlan_list_lock: lock protecting vlan_list */
+	spinlock_t vlan_list_lock;
+
+	/** @bat_iv: B.A.T.M.A.N. IV private structure */
 	struct batadv_orig_bat_iv bat_iv;
 };
 
 /**
  * enum batadv_orig_capabilities - orig node capabilities
- * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
- * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
- * @BATADV_ORIG_CAPA_HAS_TT: orig node has tt capability
- * @BATADV_ORIG_CAPA_HAS_MCAST: orig node has some multicast capability
- *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
  */
 enum batadv_orig_capabilities {
+	/**
+	 * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table
+	 *  enabled
+	 */
 	BATADV_ORIG_CAPA_HAS_DAT,
+
+	/** @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled */
 	BATADV_ORIG_CAPA_HAS_NC,
+
+	/** @BATADV_ORIG_CAPA_HAS_TT: orig node has tt capability */
 	BATADV_ORIG_CAPA_HAS_TT,
+
+	/**
+	 * @BATADV_ORIG_CAPA_HAS_MCAST: orig node has some multicast capability
+	 *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
+	 */
 	BATADV_ORIG_CAPA_HAS_MCAST,
 };
 
 /**
  * struct batadv_gw_node - structure for orig nodes announcing gw capabilities
- * @list: list node for batadv_priv_gw::list
- * @orig_node: pointer to corresponding orig node
- * @bandwidth_down: advertised uplink download bandwidth
- * @bandwidth_up: advertised uplink upload bandwidth
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_gw_node {
+	/** @list: list node for batadv_priv_gw::list */
 	struct hlist_node list;
+
+	/** @orig_node: pointer to corresponding orig node */
 	struct batadv_orig_node *orig_node;
+
+	/** @bandwidth_down: advertised uplink download bandwidth */
 	u32 bandwidth_down;
+
+	/** @bandwidth_up: advertised uplink upload bandwidth */
 	u32 bandwidth_up;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
@@ -407,118 +562,161 @@ DECLARE_EWMA(throughput, 10, 8)
 /**
  * struct batadv_hardif_neigh_node_bat_v - B.A.T.M.A.N. V private neighbor
  *  information
- * @throughput: ewma link throughput towards this neighbor
- * @elp_interval: time interval between two ELP transmissions
- * @elp_latest_seqno: latest and best known ELP sequence number
- * @last_unicast_tx: when the last unicast packet has been sent to this neighbor
- * @metric_work: work queue callback item for metric update
  */
 struct batadv_hardif_neigh_node_bat_v {
+	/** @throughput: ewma link throughput towards this neighbor */
 	struct ewma_throughput throughput;
+
+	/** @elp_interval: time interval between two ELP transmissions */
 	u32 elp_interval;
+
+	/** @elp_latest_seqno: latest and best known ELP sequence number */
 	u32 elp_latest_seqno;
+
+	/**
+	 * @last_unicast_tx: when the last unicast packet has been sent to this
+	 *  neighbor
+	 */
 	unsigned long last_unicast_tx;
+
+	/** @metric_work: work queue callback item for metric update */
 	struct work_struct metric_work;
 };
 
 /**
  * struct batadv_hardif_neigh_node - unique neighbor per hard-interface
- * @list: list node for batadv_hard_iface::neigh_list
- * @addr: the MAC address of the neighboring interface
- * @orig: the address of the originator this neighbor node belongs to
- * @if_incoming: pointer to incoming hard-interface
- * @last_seen: when last packet via this neighbor was received
- * @bat_v: B.A.T.M.A.N. V private data
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in a RCU-safe manner
  */
 struct batadv_hardif_neigh_node {
+	/** @list: list node for batadv_hard_iface::neigh_list */
 	struct hlist_node list;
+
+	/** @addr: the MAC address of the neighboring interface */
 	u8 addr[ETH_ALEN];
+
+	/**
+	 * @orig: the address of the originator this neighbor node belongs to
+	 */
 	u8 orig[ETH_ALEN];
+
+	/** @if_incoming: pointer to incoming hard-interface */
 	struct batadv_hard_iface *if_incoming;
+
+	/** @last_seen: when last packet via this neighbor was received */
 	unsigned long last_seen;
+
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/** @bat_v: B.A.T.M.A.N. V private data */
 	struct batadv_hardif_neigh_node_bat_v bat_v;
 #endif
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in a RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_neigh_node - structure for single hops neighbors
- * @list: list node for batadv_orig_node::neigh_list
- * @orig_node: pointer to corresponding orig_node
- * @addr: the MAC address of the neighboring interface
- * @ifinfo_list: list for routing metrics per outgoing interface
- * @ifinfo_lock: lock protecting private ifinfo members and list
- * @if_incoming: pointer to incoming hard-interface
- * @last_seen: when last packet via this neighbor was received
- * @hardif_neigh: hardif_neigh of this neighbor
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_neigh_node {
+	/** @list: list node for batadv_orig_node::neigh_list */
 	struct hlist_node list;
+
+	/** @orig_node: pointer to corresponding orig_node */
 	struct batadv_orig_node *orig_node;
+
+	/** @addr: the MAC address of the neighboring interface */
 	u8 addr[ETH_ALEN];
+
+	/** @ifinfo_list: list for routing metrics per outgoing interface */
 	struct hlist_head ifinfo_list;
-	spinlock_t ifinfo_lock;	/* protects ifinfo_list and its members */
+
+	/** @ifinfo_lock: lock protecting ifinfo_list and its members */
+	spinlock_t ifinfo_lock;
+
+	/** @if_incoming: pointer to incoming hard-interface */
 	struct batadv_hard_iface *if_incoming;
+
+	/** @last_seen: when last packet via this neighbor was received */
 	unsigned long last_seen;
+
+	/** @hardif_neigh: hardif_neigh of this neighbor */
 	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_neigh_ifinfo_bat_iv - neighbor information per outgoing
  *  interface for B.A.T.M.A.N. IV
- * @tq_recv: ring buffer of received TQ values from this neigh node
- * @tq_index: ring buffer index
- * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
- * @real_bits: bitfield containing the number of OGMs received from this neigh
- *  node (relative to orig_node->last_real_seqno)
- * @real_packet_count: counted result of real_bits
  */
 struct batadv_neigh_ifinfo_bat_iv {
+	/** @tq_recv: ring buffer of received TQ values from this neigh node */
 	u8 tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
+
+	/** @tq_index: ring buffer index */
 	u8 tq_index;
+
+	/**
+	 * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
+	 */
 	u8 tq_avg;
+
+	/**
+	 * @real_bits: bitfield containing the number of OGMs received from this
+	 *  neigh node (relative to orig_node->last_real_seqno)
+	 */
 	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
+
+	/** @real_packet_count: counted result of real_bits */
 	u8 real_packet_count;
 };
 
 /**
  * struct batadv_neigh_ifinfo_bat_v - neighbor information per outgoing
  *  interface for B.A.T.M.A.N. V
- * @throughput: last throughput metric received from originator via this neigh
- * @last_seqno: last sequence number known for this neighbor
  */
 struct batadv_neigh_ifinfo_bat_v {
+	/**
+	 * @throughput: last throughput metric received from originator via this
+	 *  neigh
+	 */
 	u32 throughput;
+
+	/** @last_seqno: last sequence number known for this neighbor */
 	u32 last_seqno;
 };
 
 /**
  * struct batadv_neigh_ifinfo - neighbor information per outgoing interface
- * @list: list node for batadv_neigh_node::ifinfo_list
- * @if_outgoing: pointer to outgoing hard-interface
- * @bat_iv: B.A.T.M.A.N. IV private structure
- * @bat_v: B.A.T.M.A.N. V private data
- * @last_ttl: last received ttl from this neigh node
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in a RCU-safe manner
  */
 struct batadv_neigh_ifinfo {
+	/** @list: list node for batadv_neigh_node::ifinfo_list */
 	struct hlist_node list;
+
+	/** @if_outgoing: pointer to outgoing hard-interface */
 	struct batadv_hard_iface *if_outgoing;
+
+	/** @bat_iv: B.A.T.M.A.N. IV private structure */
 	struct batadv_neigh_ifinfo_bat_iv bat_iv;
+
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/** @bat_v: B.A.T.M.A.N. V private data */
 	struct batadv_neigh_ifinfo_bat_v bat_v;
 #endif
+
+	/** @last_ttl: last received ttl from this neigh node */
 	u8 last_ttl;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in a RCU-safe manner */
 	struct rcu_head rcu;
 };
 
@@ -526,148 +724,278 @@ struct batadv_neigh_ifinfo {
 
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
- * @orig: mac address of orig node orginating the broadcast
- * @crc: crc32 checksum of broadcast payload
- * @entrytime: time when the broadcast packet was received
  */
 struct batadv_bcast_duplist_entry {
+	/** @orig: mac address of orig node orginating the broadcast */
 	u8 orig[ETH_ALEN];
+
+	/** @crc: crc32 checksum of broadcast payload */
 	__be32 crc;
+
+	/** @entrytime: time when the broadcast packet was received */
 	unsigned long entrytime;
 };
 #endif
 
 /**
  * enum batadv_counters - indices for traffic counters
- * @BATADV_CNT_TX: transmitted payload traffic packet counter
- * @BATADV_CNT_TX_BYTES: transmitted payload traffic bytes counter
- * @BATADV_CNT_TX_DROPPED: dropped transmission payload traffic packet counter
- * @BATADV_CNT_RX: received payload traffic packet counter
- * @BATADV_CNT_RX_BYTES: received payload traffic bytes counter
- * @BATADV_CNT_FORWARD: forwarded payload traffic packet counter
- * @BATADV_CNT_FORWARD_BYTES: forwarded payload traffic bytes counter
- * @BATADV_CNT_MGMT_TX: transmitted routing protocol traffic packet counter
- * @BATADV_CNT_MGMT_TX_BYTES: transmitted routing protocol traffic bytes counter
- * @BATADV_CNT_MGMT_RX: received routing protocol traffic packet counter
- * @BATADV_CNT_MGMT_RX_BYTES: received routing protocol traffic bytes counter
- * @BATADV_CNT_FRAG_TX: transmitted fragment traffic packet counter
- * @BATADV_CNT_FRAG_TX_BYTES: transmitted fragment traffic bytes counter
- * @BATADV_CNT_FRAG_RX: received fragment traffic packet counter
- * @BATADV_CNT_FRAG_RX_BYTES: received fragment traffic bytes counter
- * @BATADV_CNT_FRAG_FWD: forwarded fragment traffic packet counter
- * @BATADV_CNT_FRAG_FWD_BYTES: forwarded fragment traffic bytes counter
- * @BATADV_CNT_TT_REQUEST_TX: transmitted tt req traffic packet counter
- * @BATADV_CNT_TT_REQUEST_RX: received tt req traffic packet counter
- * @BATADV_CNT_TT_RESPONSE_TX: transmitted tt resp traffic packet counter
- * @BATADV_CNT_TT_RESPONSE_RX: received tt resp traffic packet counter
- * @BATADV_CNT_TT_ROAM_ADV_TX: transmitted tt roam traffic packet counter
- * @BATADV_CNT_TT_ROAM_ADV_RX: received tt roam traffic packet counter
- * @BATADV_CNT_DAT_GET_TX: transmitted dht GET traffic packet counter
- * @BATADV_CNT_DAT_GET_RX: received dht GET traffic packet counter
- * @BATADV_CNT_DAT_PUT_TX: transmitted dht PUT traffic packet counter
- * @BATADV_CNT_DAT_PUT_RX: received dht PUT traffic packet counter
- * @BATADV_CNT_DAT_CACHED_REPLY_TX: transmitted dat cache reply traffic packet
- *  counter
- * @BATADV_CNT_NC_CODE: transmitted nc-combined traffic packet counter
- * @BATADV_CNT_NC_CODE_BYTES: transmitted nc-combined traffic bytes counter
- * @BATADV_CNT_NC_RECODE: transmitted nc-recombined traffic packet counter
- * @BATADV_CNT_NC_RECODE_BYTES: transmitted nc-recombined traffic bytes counter
- * @BATADV_CNT_NC_BUFFER: counter for packets buffered for later nc decoding
- * @BATADV_CNT_NC_DECODE: received and nc-decoded traffic packet counter
- * @BATADV_CNT_NC_DECODE_BYTES: received and nc-decoded traffic bytes counter
- * @BATADV_CNT_NC_DECODE_FAILED: received and decode-failed traffic packet
- *  counter
- * @BATADV_CNT_NC_SNIFFED: counter for nc-decoded packets received in promisc
- *  mode.
- * @BATADV_CNT_NUM: number of traffic counters
  */
 enum batadv_counters {
+	/** @BATADV_CNT_TX: transmitted payload traffic packet counter */
 	BATADV_CNT_TX,
+
+	/** @BATADV_CNT_TX_BYTES: transmitted payload traffic bytes counter */
 	BATADV_CNT_TX_BYTES,
+
+	/**
+	 * @BATADV_CNT_TX_DROPPED: dropped transmission payload traffic packet
+	 *  counter
+	 */
 	BATADV_CNT_TX_DROPPED,
+
+	/** @BATADV_CNT_RX: received payload traffic packet counter */
 	BATADV_CNT_RX,
+
+	/** @BATADV_CNT_RX_BYTES: received payload traffic bytes counter */
 	BATADV_CNT_RX_BYTES,
+
+	/** @BATADV_CNT_FORWARD: forwarded payload traffic packet counter */
 	BATADV_CNT_FORWARD,
+
+	/**
+	 * @BATADV_CNT_FORWARD_BYTES: forwarded payload traffic bytes counter
+	 */
 	BATADV_CNT_FORWARD_BYTES,
+
+	/**
+	 * @BATADV_CNT_MGMT_TX: transmitted routing protocol traffic packet
+	 *  counter
+	 */
 	BATADV_CNT_MGMT_TX,
+
+	/**
+	 * @BATADV_CNT_MGMT_TX_BYTES: transmitted routing protocol traffic bytes
+	 *  counter
+	 */
 	BATADV_CNT_MGMT_TX_BYTES,
+
+	/**
+	 * @BATADV_CNT_MGMT_RX: received routing protocol traffic packet counter
+	 */
 	BATADV_CNT_MGMT_RX,
+
+	/**
+	 * @BATADV_CNT_MGMT_RX_BYTES: received routing protocol traffic bytes
+	 *  counter
+	 */
 	BATADV_CNT_MGMT_RX_BYTES,
+
+	/** @BATADV_CNT_FRAG_TX: transmitted fragment traffic packet counter */
 	BATADV_CNT_FRAG_TX,
+
+	/**
+	 * @BATADV_CNT_FRAG_TX_BYTES: transmitted fragment traffic bytes counter
+	 */
 	BATADV_CNT_FRAG_TX_BYTES,
+
+	/** @BATADV_CNT_FRAG_RX: received fragment traffic packet counter */
 	BATADV_CNT_FRAG_RX,
+
+	/**
+	 * @BATADV_CNT_FRAG_RX_BYTES: received fragment traffic bytes counter
+	 */
 	BATADV_CNT_FRAG_RX_BYTES,
+
+	/** @BATADV_CNT_FRAG_FWD: forwarded fragment traffic packet counter */
 	BATADV_CNT_FRAG_FWD,
+
+	/**
+	 * @BATADV_CNT_FRAG_FWD_BYTES: forwarded fragment traffic bytes counter
+	 */
 	BATADV_CNT_FRAG_FWD_BYTES,
+
+	/**
+	 * @BATADV_CNT_TT_REQUEST_TX: transmitted tt req traffic packet counter
+	 */
 	BATADV_CNT_TT_REQUEST_TX,
+
+	/** @BATADV_CNT_TT_REQUEST_RX: received tt req traffic packet counter */
 	BATADV_CNT_TT_REQUEST_RX,
+
+	/**
+	 * @BATADV_CNT_TT_RESPONSE_TX: transmitted tt resp traffic packet
+	 *  counter
+	 */
 	BATADV_CNT_TT_RESPONSE_TX,
+
+	/**
+	 * @BATADV_CNT_TT_RESPONSE_RX: received tt resp traffic packet counter
+	 */
 	BATADV_CNT_TT_RESPONSE_RX,
+
+	/**
+	 * @BATADV_CNT_TT_ROAM_ADV_TX: transmitted tt roam traffic packet
+	 *  counter
+	 */
 	BATADV_CNT_TT_ROAM_ADV_TX,
+
+	/**
+	 * @BATADV_CNT_TT_ROAM_ADV_RX: received tt roam traffic packet counter
+	 */
 	BATADV_CNT_TT_ROAM_ADV_RX,
+
 #ifdef CONFIG_BATMAN_ADV_DAT
+	/**
+	 * @BATADV_CNT_DAT_GET_TX: transmitted dht GET traffic packet counter
+	 */
 	BATADV_CNT_DAT_GET_TX,
+
+	/** @BATADV_CNT_DAT_GET_RX: received dht GET traffic packet counter */
 	BATADV_CNT_DAT_GET_RX,
+
+	/**
+	 * @BATADV_CNT_DAT_PUT_TX: transmitted dht PUT traffic packet counter
+	 */
 	BATADV_CNT_DAT_PUT_TX,
+
+	/** @BATADV_CNT_DAT_PUT_RX: received dht PUT traffic packet counter */
 	BATADV_CNT_DAT_PUT_RX,
+
+	/**
+	 * @BATADV_CNT_DAT_CACHED_REPLY_TX: transmitted dat cache reply traffic
+	 *  packet counter
+	 */
 	BATADV_CNT_DAT_CACHED_REPLY_TX,
 #endif
+
 #ifdef CONFIG_BATMAN_ADV_NC
+	/**
+	 * @BATADV_CNT_NC_CODE: transmitted nc-combined traffic packet counter
+	 */
 	BATADV_CNT_NC_CODE,
+
+	/**
+	 * @BATADV_CNT_NC_CODE_BYTES: transmitted nc-combined traffic bytes
+	 *  counter
+	 */
 	BATADV_CNT_NC_CODE_BYTES,
+
+	/**
+	 * @BATADV_CNT_NC_RECODE: transmitted nc-recombined traffic packet
+	 *  counter
+	 */
 	BATADV_CNT_NC_RECODE,
+
+	/**
+	 * @BATADV_CNT_NC_RECODE_BYTES: transmitted nc-recombined traffic bytes
+	 *  counter
+	 */
 	BATADV_CNT_NC_RECODE_BYTES,
+
+	/**
+	 * @BATADV_CNT_NC_BUFFER: counter for packets buffered for later nc
+	 *  decoding
+	 */
 	BATADV_CNT_NC_BUFFER,
+
+	/**
+	 * @BATADV_CNT_NC_DECODE: received and nc-decoded traffic packet counter
+	 */
 	BATADV_CNT_NC_DECODE,
+
+	/**
+	 * @BATADV_CNT_NC_DECODE_BYTES: received and nc-decoded traffic bytes
+	 *  counter
+	 */
 	BATADV_CNT_NC_DECODE_BYTES,
+
+	/**
+	 * @BATADV_CNT_NC_DECODE_FAILED: received and decode-failed traffic
+	 *  packet counter
+	 */
 	BATADV_CNT_NC_DECODE_FAILED,
+
+	/**
+	 * @BATADV_CNT_NC_SNIFFED: counter for nc-decoded packets received in
+	 *  promisc mode.
+	 */
 	BATADV_CNT_NC_SNIFFED,
 #endif
+
+	/** @BATADV_CNT_NUM: number of traffic counters */
 	BATADV_CNT_NUM,
 };
 
 /**
  * struct batadv_priv_tt - per mesh interface translation table data
- * @vn: translation table version number
- * @ogm_append_cnt: counter of number of OGMs containing the local tt diff
- * @local_changes: changes registered in an originator interval
- * @changes_list: tracks tt local changes within an originator interval
- * @local_hash: local translation table hash table
- * @global_hash: global translation table hash table
- * @req_list: list of pending & unanswered tt_requests
- * @roam_list: list of the last roaming events of each client limiting the
- *  number of roaming events to avoid route flapping
- * @changes_list_lock: lock protecting changes_list
- * @req_list_lock: lock protecting req_list
- * @roam_list_lock: lock protecting roam_list
- * @last_changeset: last tt changeset this host has generated
- * @last_changeset_len: length of last tt changeset this host has generated
- * @last_changeset_lock: lock protecting last_changeset & last_changeset_len
- * @commit_lock: prevents from executing a local TT commit while reading the
- *  local table. The local TT commit is made up by two operations (data
- *  structure update and metdata -CRC/TTVN- recalculation) and they have to be
- *  executed atomically in order to avoid another thread to read the
- *  table/metadata between those.
- * @work: work queue callback item for translation table purging
  */
 struct batadv_priv_tt {
+	/** @vn: translation table version number */
 	atomic_t vn;
+
+	/**
+	 * @ogm_append_cnt: counter of number of OGMs containing the local tt
+	 *  diff
+	 */
 	atomic_t ogm_append_cnt;
+
+	/** @local_changes: changes registered in an originator interval */
 	atomic_t local_changes;
+
+	/**
+	 * @changes_list: tracks tt local changes within an originator interval
+	 */
 	struct list_head changes_list;
+
+	/** @local_hash: local translation table hash table */
 	struct batadv_hashtable *local_hash;
+
+	/** @global_hash: global translation table hash table */
 	struct batadv_hashtable *global_hash;
+
+	/** @req_list: list of pending & unanswered tt_requests */
 	struct hlist_head req_list;
+
+	/**
+	 * @roam_list: list of the last roaming events of each client limiting
+	 *  the number of roaming events to avoid route flapping
+	 */
 	struct list_head roam_list;
-	spinlock_t changes_list_lock; /* protects changes */
-	spinlock_t req_list_lock; /* protects req_list */
-	spinlock_t roam_list_lock; /* protects roam_list */
+
+	/** @changes_list_lock: lock protecting changes_list */
+	spinlock_t changes_list_lock;
+
+	/** @req_list_lock: lock protecting req_list */
+	spinlock_t req_list_lock;
+
+	/** @roam_list_lock: lock protecting roam_list */
+	spinlock_t roam_list_lock;
+
+	/** @last_changeset: last tt changeset this host has generated */
 	unsigned char *last_changeset;
+
+	/**
+	 * @last_changeset_len: length of last tt changeset this host has
+	 *  generated
+	 */
 	s16 last_changeset_len;
-	/* protects last_changeset & last_changeset_len */
+
+	/**
+	 * @last_changeset_lock: lock protecting last_changeset &
+	 *  last_changeset_len
+	 */
 	spinlock_t last_changeset_lock;
-	/* prevents from executing a commit while reading the table */
+
+	/**
+	 * @commit_lock: prevents from executing a local TT commit while reading
+	 *  the local table. The local TT commit is made up by two operations
+	 *  (data structure update and metdata -CRC/TTVN- recalculation) and
+	 *  they have to be executed atomically in order to avoid another thread
+	 *  to read the table/metadata between those.
+	 */
 	spinlock_t commit_lock;
+
+	/** @work: work queue callback item for translation table purging */
 	struct delayed_work work;
 };
 
@@ -675,31 +1003,57 @@ struct batadv_priv_tt {
 
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
- * @num_requests: number of bla requests in flight
- * @claim_hash: hash table containing mesh nodes this host has claimed
- * @backbone_hash: hash table containing all detected backbone gateways
- * @loopdetect_addr: MAC address used for own loopdetection frames
- * @loopdetect_lasttime: time when the loopdetection frames were sent
- * @loopdetect_next: how many periods to wait for the next loopdetect process
- * @bcast_duplist: recently received broadcast packets array (for broadcast
- *  duplicate suppression)
- * @bcast_duplist_curr: index of last broadcast packet added to bcast_duplist
- * @bcast_duplist_lock: lock protecting bcast_duplist & bcast_duplist_curr
- * @claim_dest: local claim data (e.g. claim group)
- * @work: work queue callback item for cleanups & bla announcements
  */
 struct batadv_priv_bla {
+	/** @num_requests: number of bla requests in flight */
 	atomic_t num_requests;
+
+	/**
+	 * @claim_hash: hash table containing mesh nodes this host has claimed
+	 */
 	struct batadv_hashtable *claim_hash;
+
+	/**
+	 * @backbone_hash: hash table containing all detected backbone gateways
+	 */
 	struct batadv_hashtable *backbone_hash;
+
+	/** @loopdetect_addr: MAC address used for own loopdetection frames */
 	u8 loopdetect_addr[ETH_ALEN];
+
+	/**
+	 * @loopdetect_lasttime: time when the loopdetection frames were sent
+	 */
 	unsigned long loopdetect_lasttime;
+
+	/**
+	 * @loopdetect_next: how many periods to wait for the next loopdetect
+	 *  process
+	 */
 	atomic_t loopdetect_next;
+
+	/**
+	 * @bcast_duplist: recently received broadcast packets array (for
+	 *  broadcast duplicate suppression)
+	 */
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
+
+	/**
+	 * @bcast_duplist_curr: index of last broadcast packet added to
+	 *  bcast_duplist
+	 */
 	int bcast_duplist_curr;
-	/* protects bcast_duplist & bcast_duplist_curr */
+
+	/**
+	 * @bcast_duplist_lock: lock protecting bcast_duplist &
+	 *  bcast_duplist_curr
+	 */
 	spinlock_t bcast_duplist_lock;
+
+	/** @claim_dest: local claim data (e.g. claim group) */
 	struct batadv_bla_claim_dst claim_dest;
+
+	/** @work: work queue callback item for cleanups & bla announcements */
 	struct delayed_work work;
 };
 #endif
@@ -708,68 +1062,94 @@ struct batadv_priv_bla {
 
 /**
  * struct batadv_priv_debug_log - debug logging data
- * @log_buff: buffer holding the logs (ring bufer)
- * @log_start: index of next character to read
- * @log_end: index of next character to write
- * @lock: lock protecting log_buff, log_start & log_end
- * @queue_wait: log reader's wait queue
  */
 struct batadv_priv_debug_log {
+	/** @log_buff: buffer holding the logs (ring bufer) */
 	char log_buff[BATADV_LOG_BUF_LEN];
+
+	/** @log_start: index of next character to read */
 	unsigned long log_start;
+
+	/** @log_end: index of next character to write */
 	unsigned long log_end;
-	spinlock_t lock; /* protects log_buff, log_start and log_end */
+
+	/** @lock: lock protecting log_buff, log_start & log_end */
+	spinlock_t lock;
+
+	/** @queue_wait: log reader's wait queue */
 	wait_queue_head_t queue_wait;
 };
 #endif
 
 /**
  * struct batadv_priv_gw - per mesh interface gateway data
- * @gateway_list: list of available gateway nodes
- * @list_lock: lock protecting gateway_list & curr_gw
- * @curr_gw: pointer to currently selected gateway node
- * @mode: gateway operation: off, client or server (see batadv_gw_modes)
- * @sel_class: gateway selection class (applies if gw_mode client)
- * @bandwidth_down: advertised uplink download bandwidth (if gw_mode server)
- * @bandwidth_up: advertised uplink upload bandwidth (if gw_mode server)
- * @reselect: bool indicating a gateway re-selection is in progress
  */
 struct batadv_priv_gw {
+	/** @gateway_list: list of available gateway nodes */
 	struct hlist_head gateway_list;
-	spinlock_t list_lock; /* protects gateway_list & curr_gw */
-	struct batadv_gw_node __rcu *curr_gw;  /* rcu protected pointer */
+
+	/** @list_lock: lock protecting gateway_list & curr_gw */
+	spinlock_t list_lock;
+
+	/** @curr_gw: pointer to currently selected gateway node */
+	struct batadv_gw_node __rcu *curr_gw;
+
+	/**
+	 * @mode: gateway operation: off, client or server (see batadv_gw_modes)
+	 */
 	atomic_t mode;
+
+	/** @sel_class: gateway selection class (applies if gw_mode client) */
 	atomic_t sel_class;
+
+	/**
+	 * @bandwidth_down: advertised uplink download bandwidth (if gw_mode
+	 *  server)
+	 */
 	atomic_t bandwidth_down;
+
+	/**
+	 * @bandwidth_up: advertised uplink upload bandwidth (if gw_mode server)
+	 */
 	atomic_t bandwidth_up;
+
+	/** @reselect: bool indicating a gateway re-selection is in progress */
 	atomic_t reselect;
 };
 
 /**
  * struct batadv_priv_tvlv - per mesh interface tvlv data
- * @container_list: list of registered tvlv containers to be sent with each OGM
- * @handler_list: list of the various tvlv content handlers
- * @container_list_lock: protects tvlv container list access
- * @handler_list_lock: protects handler list access
  */
 struct batadv_priv_tvlv {
+	/**
+	 * @container_list: list of registered tvlv containers to be sent with
+	 *  each OGM
+	 */
 	struct hlist_head container_list;
+
+	/** @handler_list: list of the various tvlv content handlers */
 	struct hlist_head handler_list;
-	spinlock_t container_list_lock; /* protects container_list */
-	spinlock_t handler_list_lock; /* protects handler_list */
+
+	/** @container_list_lock: protects tvlv container list access */
+	spinlock_t container_list_lock;
+
+	/** @handler_list_lock: protects handler list access */
+	spinlock_t handler_list_lock;
 };
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 
 /**
  * struct batadv_priv_dat - per mesh interface DAT private data
- * @addr: node DAT address
- * @hash: hashtable representing the local ARP cache
- * @work: work queue callback item for cache purging
  */
 struct batadv_priv_dat {
+	/** @addr: node DAT address */
 	batadv_dat_addr_t addr;
+
+	/** @hash: hashtable representing the local ARP cache */
 	struct batadv_hashtable *hash;
+
+	/** @work: work queue callback item for cache purging */
 	struct delayed_work work;
 };
 #endif
@@ -777,375 +1157,582 @@ struct batadv_priv_dat {
 #ifdef CONFIG_BATMAN_ADV_MCAST
 /**
  * struct batadv_mcast_querier_state - IGMP/MLD querier state when bridged
- * @exists: whether a querier exists in the mesh
- * @shadowing: if a querier exists, whether it is potentially shadowing
- *  multicast listeners (i.e. querier is behind our own bridge segment)
  */
 struct batadv_mcast_querier_state {
+	/** @exists: whether a querier exists in the mesh */
 	bool exists;
+
+	/**
+	 * @shadowing: if a querier exists, whether it is potentially shadowing
+	 *  multicast listeners (i.e. querier is behind our own bridge segment)
+	 */
 	bool shadowing;
 };
 
 /**
  * struct batadv_priv_mcast - per mesh interface mcast data
- * @mla_list: list of multicast addresses we are currently announcing via TT
- * @want_all_unsnoopables_list: a list of orig_nodes wanting all unsnoopable
- *  multicast traffic
- * @want_all_ipv4_list: a list of orig_nodes wanting all IPv4 multicast traffic
- * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast traffic
- * @querier_ipv4: the current state of an IGMP querier in the mesh
- * @querier_ipv6: the current state of an MLD querier in the mesh
- * @flags: the flags we have last sent in our mcast tvlv
- * @enabled: whether the multicast tvlv is currently enabled
- * @bridged: whether the soft interface has a bridge on top
- * @num_disabled: number of nodes that have no mcast tvlv
- * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP traffic
- * @num_want_all_ipv4: counter for items in want_all_ipv4_list
- * @num_want_all_ipv6: counter for items in want_all_ipv6_list
- * @want_lists_lock: lock for protecting modifications to mcast want lists
- *  (traversals are rcu-locked)
- * @work: work queue callback item for multicast TT and TVLV updates
  */
 struct batadv_priv_mcast {
+	/**
+	 * @mla_list: list of multicast addresses we are currently announcing
+	 *  via TT
+	 */
 	struct hlist_head mla_list; /* see __batadv_mcast_mla_update() */
+
+	/**
+	 * @want_all_unsnoopables_list: a list of orig_nodes wanting all
+	 *  unsnoopable multicast traffic
+	 */
 	struct hlist_head want_all_unsnoopables_list;
+
+	/**
+	 * @want_all_ipv4_list: a list of orig_nodes wanting all IPv4 multicast
+	 *  traffic
+	 */
 	struct hlist_head want_all_ipv4_list;
+
+	/**
+	 * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast
+	 *  traffic
+	 */
 	struct hlist_head want_all_ipv6_list;
+
+	/** @querier_ipv4: the current state of an IGMP querier in the mesh */
 	struct batadv_mcast_querier_state querier_ipv4;
+
+	/** @querier_ipv6: the current state of an MLD querier in the mesh */
 	struct batadv_mcast_querier_state querier_ipv6;
+
+	/** @flags: the flags we have last sent in our mcast tvlv */
 	u8 flags;
+
+	/** @enabled: whether the multicast tvlv is currently enabled */
 	bool enabled;
+
+	/** @bridged: whether the soft interface has a bridge on top */
 	bool bridged;
+
+	/** @num_disabled: number of nodes that have no mcast tvlv */
 	atomic_t num_disabled;
+
+	/**
+	 * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP
+	 *  traffic
+	 */
 	atomic_t num_want_all_unsnoopables;
+
+	/** @num_want_all_ipv4: counter for items in want_all_ipv4_list */
 	atomic_t num_want_all_ipv4;
+
+	/** @num_want_all_ipv6: counter for items in want_all_ipv6_list */
 	atomic_t num_want_all_ipv6;
-	/* protects want_all_{unsnoopables,ipv4,ipv6}_list */
+
+	/**
+	 * @want_lists_lock: lock for protecting modifications to mcasts
+	 *  want_all_{unsnoopables,ipv4,ipv6}_list (traversals are rcu-locked)
+	 */
 	spinlock_t want_lists_lock;
+
+	/** @work: work queue callback item for multicast TT and TVLV updates */
 	struct delayed_work work;
 };
 #endif
 
 /**
  * struct batadv_priv_nc - per mesh interface network coding private data
- * @work: work queue callback item for cleanup
- * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
- * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
- * @max_fwd_delay: maximum packet forward delay to allow coding of packets
- * @max_buffer_time: buffer time for sniffed packets used to decoding
- * @timestamp_fwd_flush: timestamp of last forward packet queue flush
- * @timestamp_sniffed_purge: timestamp of last sniffed packet queue purge
- * @coding_hash: Hash table used to buffer skbs while waiting for another
- *  incoming skb to code it with. Skbs are added to the buffer just before being
- *  forwarded in routing.c
- * @decoding_hash: Hash table used to buffer skbs that might be needed to decode
- *  a received coded skb. The buffer is used for 1) skbs arriving on the
- *  soft-interface; 2) skbs overheard on the hard-interface; and 3) skbs
- *  forwarded by batman-adv.
  */
 struct batadv_priv_nc {
+	/** @work: work queue callback item for cleanup */
 	struct delayed_work work;
+
+	/**
+	 * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
+	 */
 	struct dentry *debug_dir;
+
+	/**
+	 * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
+	 */
 	u8 min_tq;
+
+	/**
+	 * @max_fwd_delay: maximum packet forward delay to allow coding of
+	 *  packets
+	 */
 	u32 max_fwd_delay;
+
+	/**
+	 * @max_buffer_time: buffer time for sniffed packets used to decoding
+	 */
 	u32 max_buffer_time;
+
+	/**
+	 * @timestamp_fwd_flush: timestamp of last forward packet queue flush
+	 */
 	unsigned long timestamp_fwd_flush;
+
+	/**
+	 * @timestamp_sniffed_purge: timestamp of last sniffed packet queue
+	 *  purge
+	 */
 	unsigned long timestamp_sniffed_purge;
+
+	/**
+	 * @coding_hash: Hash table used to buffer skbs while waiting for
+	 *  another incoming skb to code it with. Skbs are added to the buffer
+	 *  just before being forwarded in routing.c
+	 */
 	struct batadv_hashtable *coding_hash;
+
+	/**
+	 * @decoding_hash: Hash table used to buffer skbs that might be needed
+	 *  to decode a received coded skb. The buffer is used for 1) skbs
+	 *  arriving on the soft-interface; 2) skbs overheard on the
+	 *  hard-interface; and 3) skbs forwarded by batman-adv.
+	 */
 	struct batadv_hashtable *decoding_hash;
 };
 
 /**
  * struct batadv_tp_unacked - unacked packet meta-information
- * @seqno: seqno of the unacked packet
- * @len: length of the packet
- * @list: list node for batadv_tp_vars::unacked_list
  *
  * This struct is supposed to represent a buffer unacked packet. However, since
  * the purpose of the TP meter is to count the traffic only, there is no need to
  * store the entire sk_buff, the starting offset and the length are enough
  */
 struct batadv_tp_unacked {
+	/** @seqno: seqno of the unacked packet */
 	u32 seqno;
+
+	/** @len: length of the packet */
 	u16 len;
+
+	/** @list: list node for batadv_tp_vars::unacked_list */
 	struct list_head list;
 };
 
 /**
  * enum batadv_tp_meter_role - Modus in tp meter session
- * @BATADV_TP_RECEIVER: Initialized as receiver
- * @BATADV_TP_SENDER: Initialized as sender
  */
 enum batadv_tp_meter_role {
+	/** @BATADV_TP_RECEIVER: Initialized as receiver */
 	BATADV_TP_RECEIVER,
+
+	/** @BATADV_TP_SENDER: Initialized as sender */
 	BATADV_TP_SENDER
 };
 
 /**
  * struct batadv_tp_vars - tp meter private variables per session
- * @list: list node for bat_priv::tp_list
- * @timer: timer for ack (receiver) and retry (sender)
- * @bat_priv: pointer to the mesh object
- * @start_time: start time in jiffies
- * @other_end: mac address of remote
- * @role: receiver/sender modi
- * @sending: sending binary semaphore: 1 if sending, 0 is not
- * @reason: reason for a stopped session
- * @finish_work: work item for the finishing procedure
- * @test_length: test length in milliseconds
- * @session: TP session identifier
- * @icmp_uid: local ICMP "socket" index
- * @dec_cwnd: decimal part of the cwnd used during linear growth
- * @cwnd: current size of the congestion window
- * @cwnd_lock: lock do protect @cwnd & @dec_cwnd
- * @ss_threshold: Slow Start threshold. Once cwnd exceeds this value the
- *  connection switches to the Congestion Avoidance state
- * @last_acked: last acked byte
- * @last_sent: last sent byte, not yet acked
- * @tot_sent: amount of data sent/ACKed so far
- * @dup_acks: duplicate ACKs counter
- * @fast_recovery: true if in Fast Recovery mode
- * @recover: last sent seqno when entering Fast Recovery
- * @rto: sender timeout
- * @srtt: smoothed RTT scaled by 2^3
- * @rttvar: RTT variation scaled by 2^2
- * @more_bytes: waiting queue anchor when waiting for more ack/retry timeout
- * @prerandom_offset: offset inside the prerandom buffer
- * @prerandom_lock: spinlock protecting access to prerandom_offset
- * @last_recv: last in-order received packet
- * @unacked_list: list of unacked packets (meta-info only)
- * @unacked_lock: protect unacked_list
- * @last_recv_time: time time (jiffies) a msg was received
- * @refcount: number of context where the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_tp_vars {
+	/** @list: list node for bat_priv::tp_list */
 	struct hlist_node list;
+
+	/** @timer: timer for ack (receiver) and retry (sender) */
 	struct timer_list timer;
+
+	/** @bat_priv: pointer to the mesh object */
 	struct batadv_priv *bat_priv;
+
+	/** @start_time: start time in jiffies */
 	unsigned long start_time;
+
+	/** @other_end: mac address of remote */
 	u8 other_end[ETH_ALEN];
+
+	/** @role: receiver/sender modi */
 	enum batadv_tp_meter_role role;
+
+	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
 	atomic_t sending;
+
+	/** @reason: reason for a stopped session */
 	enum batadv_tp_meter_reason reason;
+
+	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
+
+	/** @test_length: test length in milliseconds */
 	u32 test_length;
+
+	/** @session: TP session identifier */
 	u8 session[2];
+
+	/** @icmp_uid: local ICMP "socket" index */
 	u8 icmp_uid;
 
 	/* sender variables */
+
+	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
 	u16 dec_cwnd;
+
+	/** @cwnd: current size of the congestion window */
 	u32 cwnd;
-	spinlock_t cwnd_lock; /* Protects cwnd & dec_cwnd */
+
+	/** @cwnd_lock: lock do protect @cwnd & @dec_cwnd */
+	spinlock_t cwnd_lock;
+
+	/**
+	 * @ss_threshold: Slow Start threshold. Once cwnd exceeds this value the
+	 *  connection switches to the Congestion Avoidance state
+	 */
 	u32 ss_threshold;
+
+	/** @last_acked: last acked byte */
 	atomic_t last_acked;
+
+	/** @last_sent: last sent byte, not yet acked */
 	u32 last_sent;
+
+	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
+
+	/** @dup_acks: duplicate ACKs counter */
 	atomic_t dup_acks;
+
+	/** @fast_recovery: true if in Fast Recovery mode */
 	bool fast_recovery;
+
+	/** @recover: last sent seqno when entering Fast Recovery */
 	u32 recover;
+
+	/** @rto: sender timeout */
 	u32 rto;
+
+	/** @srtt: smoothed RTT scaled by 2^3 */
 	u32 srtt;
+
+	/** @rttvar: RTT variation scaled by 2^2 */
 	u32 rttvar;
+
+	/**
+	 * @more_bytes: waiting queue anchor when waiting for more ack/retry
+	 *  timeout
+	 */
 	wait_queue_head_t more_bytes;
+
+	/** @prerandom_offset: offset inside the prerandom buffer */
 	u32 prerandom_offset;
-	spinlock_t prerandom_lock; /* Protects prerandom_offset */
+
+	/** @prerandom_lock: spinlock protecting access to prerandom_offset */
+	spinlock_t prerandom_lock;
 
 	/* receiver variables */
+
+	/** @last_recv: last in-order received packet */
 	u32 last_recv;
+
+	/** @unacked_list: list of unacked packets (meta-info only) */
 	struct list_head unacked_list;
-	spinlock_t unacked_lock; /* Protects unacked_list */
+
+	/** @unacked_lock: protect unacked_list */
+	spinlock_t unacked_lock;
+
+	/** @last_recv_time: time time (jiffies) a msg was received */
 	unsigned long last_recv_time;
+
+	/** @refcount: number of context where the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_softif_vlan - per VLAN attributes set
- * @bat_priv: pointer to the mesh object
- * @vid: VLAN identifier
- * @kobj: kobject for sysfs vlan subdirectory
- * @ap_isolation: AP isolation state
- * @tt: TT private attributes (VLAN specific)
- * @list: list node for bat_priv::softif_vlan_list
- * @refcount: number of context where this object is currently in use
- * @rcu: struct used for freeing in a RCU-safe manner
  */
 struct batadv_softif_vlan {
+	/** @bat_priv: pointer to the mesh object */
 	struct batadv_priv *bat_priv;
+
+	/** @vid: VLAN identifier */
 	unsigned short vid;
+
+	/** @kobj: kobject for sysfs vlan subdirectory */
 	struct kobject *kobj;
+
+	/** @ap_isolation: AP isolation state */
 	atomic_t ap_isolation;		/* boolean */
+
+	/** @tt: TT private attributes (VLAN specific) */
 	struct batadv_vlan_tt tt;
+
+	/** @list: list node for bat_priv::softif_vlan_list */
 	struct hlist_node list;
+
+	/**
+	 * @refcount: number of context where this object is currently in use
+	 */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in a RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_priv_bat_v - B.A.T.M.A.N. V per soft-interface private data
- * @ogm_buff: buffer holding the OGM packet
- * @ogm_buff_len: length of the OGM packet buffer
- * @ogm_seqno: OGM sequence number - used to identify each OGM
- * @ogm_wq: workqueue used to schedule OGM transmissions
  */
 struct batadv_priv_bat_v {
+	/** @ogm_buff: buffer holding the OGM packet */
 	unsigned char *ogm_buff;
+
+	/** @ogm_buff_len: length of the OGM packet buffer */
 	int ogm_buff_len;
+
+	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
+
+	/** @ogm_wq: workqueue used to schedule OGM transmissions */
 	struct delayed_work ogm_wq;
 };
 
 /**
  * struct batadv_priv - per mesh interface data
- * @mesh_state: current status of the mesh (inactive/active/deactivating)
- * @soft_iface: net device which holds this struct as private data
- * @bat_counters: mesh internal traffic statistic counters (see batadv_counters)
- * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
- * @bonding: bool indicating whether traffic bonding is enabled
- * @fragmentation: bool indicating whether traffic fragmentation is enabled
- * @packet_size_max: max packet size that can be transmitted via
- *  multiple fragmented skbs or a single frame if fragmentation is disabled
- * @frag_seqno: incremental counter to identify chains of egress fragments
- * @bridge_loop_avoidance: bool indicating whether bridge loop avoidance is
- *  enabled
- * @distributed_arp_table: bool indicating whether distributed ARP table is
- *  enabled
- * @multicast_mode: Enable or disable multicast optimizations on this node's
- *  sender/originating side
- * @orig_interval: OGM broadcast interval in milliseconds
- * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
- * @log_level: configured log level (see batadv_dbg_level)
- * @isolation_mark: the skb->mark value used to match packets for AP isolation
- * @isolation_mark_mask: bitmask identifying the bits in skb->mark to be used
- *  for the isolation mark
- * @bcast_seqno: last sent broadcast packet sequence number
- * @bcast_queue_left: number of remaining buffered broadcast packet slots
- * @batman_queue_left: number of remaining OGM packet slots
- * @num_ifaces: number of interfaces assigned to this mesh interface
- * @mesh_obj: kobject for sysfs mesh subdirectory
- * @debug_dir: dentry for debugfs batman-adv subdirectory
- * @forw_bat_list: list of aggregated OGMs that will be forwarded
- * @forw_bcast_list: list of broadcast packets that will be rebroadcasted
- * @tp_list: list of tp sessions
- * @tp_num: number of currently active tp sessions
- * @orig_hash: hash table containing mesh participants (orig nodes)
- * @forw_bat_list_lock: lock protecting forw_bat_list
- * @forw_bcast_list_lock: lock protecting forw_bcast_list
- * @tp_list_lock: spinlock protecting @tp_list
- * @orig_work: work queue callback item for orig node purging
- * @primary_if: one of the hard-interfaces assigned to this mesh interface
- *  becomes the primary interface
- * @algo_ops: routing algorithm used by this mesh interface
- * @softif_vlan_list: a list of softif_vlan structs, one per VLAN created on top
- *  of the mesh interface represented by this object
- * @softif_vlan_list_lock: lock protecting softif_vlan_list
- * @bla: bridge loope avoidance data
- * @debug_log: holding debug logging relevant data
- * @gw: gateway data
- * @tt: translation table data
- * @tvlv: type-version-length-value data
- * @dat: distributed arp table data
- * @mcast: multicast data
- * @network_coding: bool indicating whether network coding is enabled
- * @nc: network coding data
- * @bat_v: B.A.T.M.A.N. V per soft-interface private data
  */
 struct batadv_priv {
+	/**
+	 * @mesh_state: current status of the mesh
+	 *  (inactive/active/deactivating)
+	 */
 	atomic_t mesh_state;
+
+	/** @soft_iface: net device which holds this struct as private data */
 	struct net_device *soft_iface;
+
+	/**
+	 * @bat_counters: mesh internal traffic statistic counters (see
+	 *  batadv_counters)
+	 */
 	u64 __percpu *bat_counters; /* Per cpu counters */
+
+	/**
+	 * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
+	 */
 	atomic_t aggregated_ogms;
+
+	/** @bonding: bool indicating whether traffic bonding is enabled */
 	atomic_t bonding;
+
+	/**
+	 * @fragmentation: bool indicating whether traffic fragmentation is
+	 *  enabled
+	 */
 	atomic_t fragmentation;
+
+	/**
+	 * @packet_size_max: max packet size that can be transmitted via
+	 *  multiple fragmented skbs or a single frame if fragmentation is
+	 *  disabled
+	 */
 	atomic_t packet_size_max;
+
+	/**
+	 * @frag_seqno: incremental counter to identify chains of egress
+	 *  fragments
+	 */
 	atomic_t frag_seqno;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
+	/**
+	 * @bridge_loop_avoidance: bool indicating whether bridge loop
+	 *  avoidance is enabled
+	 */
 	atomic_t bridge_loop_avoidance;
 #endif
+
 #ifdef CONFIG_BATMAN_ADV_DAT
+	/**
+	 * @distributed_arp_table: bool indicating whether distributed ARP table
+	 *  is enabled
+	 */
 	atomic_t distributed_arp_table;
 #endif
+
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	/**
+	 * @multicast_mode: Enable or disable multicast optimizations on this
+	 *  node's sender/originating side
+	 */
 	atomic_t multicast_mode;
 #endif
+
+	/** @orig_interval: OGM broadcast interval in milliseconds */
 	atomic_t orig_interval;
+
+	/**
+	 * @hop_penalty: penalty which will be applied to an OGM's tq-field on
+	 *  every hop
+	 */
 	atomic_t hop_penalty;
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG
+	/** @log_level: configured log level (see batadv_dbg_level) */
 	atomic_t log_level;
 #endif
+
+	/**
+	 * @isolation_mark: the skb->mark value used to match packets for AP
+	 *  isolation
+	 */
 	u32 isolation_mark;
+
+	/**
+	 * @isolation_mark_mask: bitmask identifying the bits in skb->mark to be
+	 *  used for the isolation mark
+	 */
 	u32 isolation_mark_mask;
+
+	/** @bcast_seqno: last sent broadcast packet sequence number */
 	atomic_t bcast_seqno;
+
+	/**
+	 * @bcast_queue_left: number of remaining buffered broadcast packet
+	 *  slots
+	 */
 	atomic_t bcast_queue_left;
+
+	/** @batman_queue_left: number of remaining OGM packet slots */
 	atomic_t batman_queue_left;
+
+	/** @num_ifaces: number of interfaces assigned to this mesh interface */
 	char num_ifaces;
+
+	/** @mesh_obj: kobject for sysfs mesh subdirectory */
 	struct kobject *mesh_obj;
+
+	/** @debug_dir: dentry for debugfs batman-adv subdirectory */
 	struct dentry *debug_dir;
+
+	/** @forw_bat_list: list of aggregated OGMs that will be forwarded */
 	struct hlist_head forw_bat_list;
+
+	/**
+	 * @forw_bcast_list: list of broadcast packets that will be
+	 *  rebroadcasted
+	 */
 	struct hlist_head forw_bcast_list;
+
+	/** @tp_list: list of tp sessions */
 	struct hlist_head tp_list;
+
+	/** @tp_num: number of currently active tp sessions */
 	struct batadv_hashtable *orig_hash;
-	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
-	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
-	spinlock_t tp_list_lock; /* protects tp_list */
+
+	/** @orig_hash: hash table containing mesh participants (orig nodes) */
+	spinlock_t forw_bat_list_lock;
+
+	/** @forw_bat_list_lock: lock protecting forw_bat_list */
+	spinlock_t forw_bcast_list_lock;
+
+	/** @forw_bcast_list_lock: lock protecting forw_bcast_list */
+	spinlock_t tp_list_lock;
+
+	/** @tp_list_lock: spinlock protecting @tp_list */
 	atomic_t tp_num;
+
+	/** @orig_work: work queue callback item for orig node purging */
 	struct delayed_work orig_work;
+
+	/**
+	 * @primary_if: one of the hard-interfaces assigned to this mesh
+	 *  interface becomes the primary interface
+	 */
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
+
+	/** @algo_ops: routing algorithm used by this mesh interface */
 	struct batadv_algo_ops *algo_ops;
+
+	/**
+	 * @softif_vlan_list: a list of softif_vlan structs, one per VLAN
+	 *  created on top of the mesh interface represented by this object
+	 */
 	struct hlist_head softif_vlan_list;
-	spinlock_t softif_vlan_list_lock; /* protects softif_vlan_list */
+
+	/** @softif_vlan_list_lock: lock protecting softif_vlan_list */
+	spinlock_t softif_vlan_list_lock;
+
 #ifdef CONFIG_BATMAN_ADV_BLA
+	/** @bla: bridge loope avoidance data */
 	struct batadv_priv_bla bla;
 #endif
+
 #ifdef CONFIG_BATMAN_ADV_DEBUG
+	/** @debug_log: holding debug logging relevant data */
 	struct batadv_priv_debug_log *debug_log;
 #endif
+
+	/** @gw: gateway data */
 	struct batadv_priv_gw gw;
+
+	/** @tt: translation table data */
 	struct batadv_priv_tt tt;
+
+	/** @tvlv: type-version-length-value data */
 	struct batadv_priv_tvlv tvlv;
+
 #ifdef CONFIG_BATMAN_ADV_DAT
+	/** @dat: distributed arp table data */
 	struct batadv_priv_dat dat;
 #endif
+
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	/** @mcast: multicast data */
 	struct batadv_priv_mcast mcast;
 #endif
+
 #ifdef CONFIG_BATMAN_ADV_NC
+	/**
+	 * @network_coding: bool indicating whether network coding is enabled
+	 */
 	atomic_t network_coding;
+
+	/** @nc: network coding data */
 	struct batadv_priv_nc nc;
 #endif /* CONFIG_BATMAN_ADV_NC */
+
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/** @bat_v: B.A.T.M.A.N. V per soft-interface private data */
 	struct batadv_priv_bat_v bat_v;
 #endif
 };
 
 /**
  * struct batadv_socket_client - layer2 icmp socket client data
- * @queue_list: packet queue for packets destined for this socket client
- * @queue_len: number of packets in the packet queue (queue_list)
- * @index: socket client's index in the batadv_socket_client_hash
- * @lock: lock protecting queue_list, queue_len & index
- * @queue_wait: socket client's wait queue
- * @bat_priv: pointer to soft_iface this client belongs to
  */
 struct batadv_socket_client {
+	/**
+	 * @queue_list: packet queue for packets destined for this socket client
+	 */
 	struct list_head queue_list;
+
+	/** @queue_len: number of packets in the packet queue (queue_list) */
 	unsigned int queue_len;
+
+	/** @index: socket client's index in the batadv_socket_client_hash */
 	unsigned char index;
-	spinlock_t lock; /* protects queue_list, queue_len & index */
+
+	/** @lock: lock protecting queue_list, queue_len & index */
+	spinlock_t lock;
+
+	/** @queue_wait: socket client's wait queue */
 	wait_queue_head_t queue_wait;
+
+	/** @bat_priv: pointer to soft_iface this client belongs to */
 	struct batadv_priv *bat_priv;
 };
 
 /**
  * struct batadv_socket_packet - layer2 icmp packet for socket client
- * @list: list node for batadv_socket_client::queue_list
- * @icmp_len: size of the layer2 icmp packet
- * @icmp_packet: layer2 icmp packet
  */
 struct batadv_socket_packet {
+	/** @list: list node for batadv_socket_client::queue_list */
 	struct list_head list;
+
+	/** @icmp_len: size of the layer2 icmp packet */
 	size_t icmp_len;
+
+	/** @icmp_packet: layer2 icmp packet */
 	u8 icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
 };
 
@@ -1153,312 +1740,429 @@ struct batadv_socket_packet {
 
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
- * @orig: originator address of backbone node (mac address of primary iface)
- * @vid: vlan id this gateway was detected on
- * @hash_entry: hlist node for batadv_priv_bla::backbone_hash
- * @bat_priv: pointer to soft_iface this backbone gateway belongs to
- * @lasttime: last time we heard of this backbone gw
- * @wait_periods: grace time for bridge forward delays and bla group forming at
- *  bootup phase - no bcast traffic is formwared until it has elapsed
- * @request_sent: if this bool is set to true we are out of sync with this
- *  backbone gateway - no bcast traffic is formwared until the situation was
- *  resolved
- * @crc: crc16 checksum over all claims
- * @crc_lock: lock protecting crc
- * @report_work: work struct for reporting detected loops
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_bla_backbone_gw {
+	/**
+	 * @orig: originator address of backbone node (mac address of primary
+	 *  iface)
+	 */
 	u8 orig[ETH_ALEN];
+
+	/** @vid: vlan id this gateway was detected on */
 	unsigned short vid;
+
+	/** @hash_entry: hlist node for batadv_priv_bla::backbone_hash */
 	struct hlist_node hash_entry;
+
+	/** @bat_priv: pointer to soft_iface this backbone gateway belongs to */
 	struct batadv_priv *bat_priv;
+
+	/** @lasttime: last time we heard of this backbone gw */
 	unsigned long lasttime;
+
+	/**
+	 * @wait_periods: grace time for bridge forward delays and bla group
+	 *  forming at bootup phase - no bcast traffic is formwared until it has
+	 *  elapsed
+	 */
 	atomic_t wait_periods;
+
+	/**
+	 * @request_sent: if this bool is set to true we are out of sync with
+	 *  this backbone gateway - no bcast traffic is formwared until the
+	 *  situation was resolved
+	 */
 	atomic_t request_sent;
+
+	/** @crc: crc16 checksum over all claims */
 	u16 crc;
-	spinlock_t crc_lock; /* protects crc */
+
+	/** @crc_lock: lock protecting crc */
+	spinlock_t crc_lock;
+
+	/** @report_work: work struct for reporting detected loops */
 	struct work_struct report_work;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_bla_claim - claimed non-mesh client structure
- * @addr: mac address of claimed non-mesh client
- * @vid: vlan id this client was detected on
- * @backbone_gw: pointer to backbone gw claiming this client
- * @backbone_lock: lock protecting backbone_gw pointer
- * @lasttime: last time we heard of claim (locals only)
- * @hash_entry: hlist node for batadv_priv_bla::claim_hash
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_bla_claim {
+	/** @addr: mac address of claimed non-mesh client */
 	u8 addr[ETH_ALEN];
+
+	/** @vid: vlan id this client was detected on */
 	unsigned short vid;
+
+	/** @backbone_gw: pointer to backbone gw claiming this client */
 	struct batadv_bla_backbone_gw *backbone_gw;
-	spinlock_t backbone_lock; /* protects backbone_gw */
+
+	/** @backbone_lock: lock protecting backbone_gw pointer */
+	spinlock_t backbone_lock;
+
+	/** @lasttime: last time we heard of claim (locals only) */
 	unsigned long lasttime;
+
+	/** @hash_entry: hlist node for batadv_priv_bla::claim_hash */
 	struct hlist_node hash_entry;
+
+	/** @refcount: number of contexts the object is used */
 	struct rcu_head rcu;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct kref refcount;
 };
 #endif
 
 /**
  * struct batadv_tt_common_entry - tt local & tt global common data
- * @addr: mac address of non-mesh client
- * @vid: VLAN identifier
- * @hash_entry: hlist node for batadv_priv_tt::local_hash or for
- *  batadv_priv_tt::global_hash
- * @flags: various state handling flags (see batadv_tt_client_flags)
- * @added_at: timestamp used for purging stale tt common entries
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_tt_common_entry {
+	/** @addr: mac address of non-mesh client */
 	u8 addr[ETH_ALEN];
+
+	/** @vid: VLAN identifier */
 	unsigned short vid;
+
+	/**
+	 * @hash_entry: hlist node for batadv_priv_tt::local_hash or for
+	 *  batadv_priv_tt::global_hash
+	 */
 	struct hlist_node hash_entry;
+
+	/** @flags: various state handling flags (see batadv_tt_client_flags) */
 	u16 flags;
+
+	/** @added_at: timestamp used for purging stale tt common entries */
 	unsigned long added_at;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_tt_local_entry - translation table local entry data
- * @common: general translation table data
- * @last_seen: timestamp used for purging stale tt local entries
- * @vlan: soft-interface vlan of the entry
  */
 struct batadv_tt_local_entry {
+	/** @common: general translation table data */
 	struct batadv_tt_common_entry common;
+
+	/** @last_seen: timestamp used for purging stale tt local entries */
 	unsigned long last_seen;
+
+	/** @vlan: soft-interface vlan of the entry */
 	struct batadv_softif_vlan *vlan;
 };
 
 /**
  * struct batadv_tt_global_entry - translation table global entry data
- * @common: general translation table data
- * @orig_list: list of orig nodes announcing this non-mesh client
- * @orig_list_count: number of items in the orig_list
- * @list_lock: lock protecting orig_list
- * @roam_at: time at which TT_GLOBAL_ROAM was set
  */
 struct batadv_tt_global_entry {
+	/** @common: general translation table data */
 	struct batadv_tt_common_entry common;
+
+	/** @orig_list: list of orig nodes announcing this non-mesh client */
 	struct hlist_head orig_list;
+
+	/** @orig_list_count: number of items in the orig_list */
 	atomic_t orig_list_count;
-	spinlock_t list_lock;	/* protects orig_list */
+
+	/** @list_lock: lock protecting orig_list */
+	spinlock_t list_lock;
+
+	/** @roam_at: time at which TT_GLOBAL_ROAM was set */
 	unsigned long roam_at;
 };
 
 /**
  * struct batadv_tt_orig_list_entry - orig node announcing a non-mesh client
- * @orig_node: pointer to orig node announcing this non-mesh client
- * @ttvn: translation table version number which added the non-mesh client
- * @flags: per orig entry TT sync flags
- * @list: list node for batadv_tt_global_entry::orig_list
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_tt_orig_list_entry {
+	/** @orig_node: pointer to orig node announcing this non-mesh client */
 	struct batadv_orig_node *orig_node;
+
+	/**
+	 * @ttvn: translation table version number which added the non-mesh
+	 *  client
+	 */
 	u8 ttvn;
+
+	/** @flags: per orig entry TT sync flags */
 	u8 flags;
+
+	/** @list: list node for batadv_tt_global_entry::orig_list */
 	struct hlist_node list;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_tt_change_node - structure for tt changes occurred
- * @list: list node for batadv_priv_tt::changes_list
- * @change: holds the actual translation table diff data
  */
 struct batadv_tt_change_node {
+	/** @list: list node for batadv_priv_tt::changes_list */
 	struct list_head list;
+
+	/** @change: holds the actual translation table diff data */
 	struct batadv_tvlv_tt_change change;
 };
 
 /**
  * struct batadv_tt_req_node - data to keep track of the tt requests in flight
- * @addr: mac address address of the originator this request was sent to
- * @issued_at: timestamp used for purging stale tt requests
- * @refcount: number of contexts the object is used by
- * @list: list node for batadv_priv_tt::req_list
  */
 struct batadv_tt_req_node {
+	/**
+	 * @addr: mac address address of the originator this request was sent to
+	 */
 	u8 addr[ETH_ALEN];
+
+	/** @issued_at: timestamp used for purging stale tt requests */
 	unsigned long issued_at;
+
+	/** @refcount: number of contexts the object is used by */
 	struct kref refcount;
+
+	/** @list: list node for batadv_priv_tt::req_list */
 	struct hlist_node list;
 };
 
 /**
  * struct batadv_tt_roam_node - roaming client data
- * @addr: mac address of the client in the roaming phase
- * @counter: number of allowed roaming events per client within a single
- *  OGM interval (changes are committed with each OGM)
- * @first_time: timestamp used for purging stale roaming node entries
- * @list: list node for batadv_priv_tt::roam_list
  */
 struct batadv_tt_roam_node {
+	/** @addr: mac address of the client in the roaming phase */
 	u8 addr[ETH_ALEN];
+
+	/**
+	 * @counter: number of allowed roaming events per client within a single
+	 * OGM interval (changes are committed with each OGM)
+	 */
 	atomic_t counter;
+
+	/**
+	 * @first_time: timestamp used for purging stale roaming node entries
+	 */
 	unsigned long first_time;
+
+	/** @list: list node for batadv_priv_tt::roam_list */
 	struct list_head list;
 };
 
 /**
  * struct batadv_nc_node - network coding node
- * @list: next and prev pointer for the list handling
- * @addr: the node's mac address
- * @refcount: number of contexts the object is used by
- * @rcu: struct used for freeing in an RCU-safe manner
- * @orig_node: pointer to corresponding orig node struct
- * @last_seen: timestamp of last ogm received from this node
  */
 struct batadv_nc_node {
+	/** @list: next and prev pointer for the list handling */
 	struct list_head list;
+
+	/** @addr: the node's mac address */
 	u8 addr[ETH_ALEN];
+
+	/** @refcount: number of contexts the object is used by */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
+
+	/** @orig_node: pointer to corresponding orig node struct */
 	struct batadv_orig_node *orig_node;
+
+	/** @last_seen: timestamp of last ogm received from this node */
 	unsigned long last_seen;
 };
 
 /**
  * struct batadv_nc_path - network coding path
- * @hash_entry: next and prev pointer for the list handling
- * @rcu: struct used for freeing in an RCU-safe manner
- * @refcount: number of contexts the object is used by
- * @packet_list: list of buffered packets for this path
- * @packet_list_lock: access lock for packet list
- * @next_hop: next hop (destination) of path
- * @prev_hop: previous hop (source) of path
- * @last_valid: timestamp for last validation of path
  */
 struct batadv_nc_path {
+	/** @hash_entry: next and prev pointer for the list handling */
 	struct hlist_node hash_entry;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
+
+	/** @refcount: number of contexts the object is used by */
 	struct kref refcount;
+
+	/** @packet_list: list of buffered packets for this path */
 	struct list_head packet_list;
-	spinlock_t packet_list_lock; /* Protects packet_list */
+
+	/** @packet_list_lock: access lock for packet list */
+	spinlock_t packet_list_lock;
+
+	/** @next_hop: next hop (destination) of path */
 	u8 next_hop[ETH_ALEN];
+
+	/** @prev_hop: previous hop (source) of path */
 	u8 prev_hop[ETH_ALEN];
+
+	/** @last_valid: timestamp for last validation of path */
 	unsigned long last_valid;
 };
 
 /**
  * struct batadv_nc_packet - network coding packet used when coding and
  *  decoding packets
- * @list: next and prev pointer for the list handling
- * @packet_id: crc32 checksum of skb data
- * @timestamp: field containing the info when the packet was added to path
- * @neigh_node: pointer to original next hop neighbor of skb
- * @skb: skb which can be encoded or used for decoding
- * @nc_path: pointer to path this nc packet is attached to
  */
 struct batadv_nc_packet {
+	/** @list: next and prev pointer for the list handling */
 	struct list_head list;
+
+	/** @packet_id: crc32 checksum of skb data */
 	__be32 packet_id;
+
+	/**
+	 * @timestamp: field containing the info when the packet was added to
+	 *  path
+	 */
 	unsigned long timestamp;
+
+	/** @neigh_node: pointer to original next hop neighbor of skb */
 	struct batadv_neigh_node *neigh_node;
+
+	/** @skb: skb which can be encoded or used for decoding */
 	struct sk_buff *skb;
+
+	/** @nc_path: pointer to path this nc packet is attached to */
 	struct batadv_nc_path *nc_path;
 };
 
 /**
  * struct batadv_skb_cb - control buffer structure used to store private data
  *  relevant to batman-adv in the skb->cb buffer in skbs.
- * @decoded: Marks a skb as decoded, which is checked when searching for coding
- *  opportunities in network-coding.c
- * @num_bcasts: Counter for broadcast packet retransmissions
  */
 struct batadv_skb_cb {
+	/**
+	 * @decoded: Marks a skb as decoded, which is checked when searching for
+	 *  coding opportunities in network-coding.c
+	 */
 	bool decoded;
+
+	/** @num_bcasts: Counter for broadcast packet retransmissions */
 	unsigned int num_bcasts;
 };
 
 /**
  * struct batadv_forw_packet - structure for bcast packets to be sent/forwarded
- * @list: list node for batadv_priv::forw_{bat,bcast}_list
- * @cleanup_list: list node for purging functions
- * @send_time: execution time for delayed_work (packet sending)
- * @own: bool for locally generated packets (local OGMs are re-scheduled after
- *  sending)
- * @skb: bcast packet's skb buffer
- * @packet_len: size of aggregated OGM packet inside the skb buffer
- * @direct_link_flags: direct link flags for aggregated OGM packets
- * @num_packets: counter for aggregated OGMv1 packets
- * @delayed_work: work queue callback item for packet sending
- * @if_incoming: pointer to incoming hard-iface or primary iface if
- *  locally generated packet
- * @if_outgoing: packet where the packet should be sent to, or NULL if
- *  unspecified
- * @queue_left: The queue (counter) this packet was applied to
  */
 struct batadv_forw_packet {
+	/** @list: list node for batadv_priv::forw_{bat,bcast}_list */
 	struct hlist_node list;
+
+	/** @cleanup_list: list node for purging functions */
 	struct hlist_node cleanup_list;
+
+	/** @send_time: execution time for delayed_work (packet sending) */
 	unsigned long send_time;
+
+	/**
+	 * @own: bool for locally generated packets (local OGMs are re-scheduled
+	 * after sending)
+	 */
 	u8 own;
+
+	/** @skb: bcast packet's skb buffer */
 	struct sk_buff *skb;
+
+	/** @packet_len: size of aggregated OGM packet inside the skb buffer */
 	u16 packet_len;
+
+	/** @direct_link_flags: direct link flags for aggregated OGM packets */
 	u32 direct_link_flags;
+
+	/** @num_packets: counter for aggregated OGMv1 packets */
 	u8 num_packets;
+
+	/** @delayed_work: work queue callback item for packet sending */
 	struct delayed_work delayed_work;
+
+	/**
+	 * @if_incoming: pointer to incoming hard-iface or primary iface if
+	 *  locally generated packet
+	 */
 	struct batadv_hard_iface *if_incoming;
+
+	/**
+	 * @if_outgoing: packet where the packet should be sent to, or NULL if
+	 *  unspecified
+	 */
 	struct batadv_hard_iface *if_outgoing;
+
+	/** @queue_left: The queue (counter) this packet was applied to */
 	atomic_t *queue_left;
 };
 
 /**
  * struct batadv_algo_iface_ops - mesh algorithm callbacks (interface specific)
- * @activate: start routing mechanisms when hard-interface is brought up
- *  (optional)
- * @enable: init routing info when hard-interface is enabled
- * @disable: de-init routing info when hard-interface is disabled
- * @update_mac: (re-)init mac addresses of the protocol information
- *  belonging to this hard-interface
- * @primary_set: called when primary interface is selected / changed
  */
 struct batadv_algo_iface_ops {
+	/**
+	 * @activate: start routing mechanisms when hard-interface is brought up
+	 *  (optional)
+	 */
 	void (*activate)(struct batadv_hard_iface *hard_iface);
+
+	/** @enable: init routing info when hard-interface is enabled */
 	int (*enable)(struct batadv_hard_iface *hard_iface);
+
+	/** @disable: de-init routing info when hard-interface is disabled */
 	void (*disable)(struct batadv_hard_iface *hard_iface);
+
+	/**
+	 * @update_mac: (re-)init mac addresses of the protocol information
+	 *  belonging to this hard-interface
+	 */
 	void (*update_mac)(struct batadv_hard_iface *hard_iface);
+
+	/** @primary_set: called when primary interface is selected / changed */
 	void (*primary_set)(struct batadv_hard_iface *hard_iface);
 };
 
 /**
  * struct batadv_algo_neigh_ops - mesh algorithm callbacks (neighbour specific)
- * @hardif_init: called on creation of single hop entry
- *  (optional)
- * @cmp: compare the metrics of two neighbors for their respective outgoing
- *  interfaces
- * @is_similar_or_better: check if neigh1 is equally similar or better than
- *  neigh2 for their respective outgoing interface from the metric prospective
- * @print: print the single hop neighbor list (optional)
- * @dump: dump neighbors to a netlink socket (optional)
  */
 struct batadv_algo_neigh_ops {
+	/** @hardif_init: called on creation of single hop entry (optional) */
 	void (*hardif_init)(struct batadv_hardif_neigh_node *neigh);
+
+	/**
+	 * @cmp: compare the metrics of two neighbors for their respective
+	 *  outgoing interfaces
+	 */
 	int (*cmp)(struct batadv_neigh_node *neigh1,
 		   struct batadv_hard_iface *if_outgoing1,
 		   struct batadv_neigh_node *neigh2,
 		   struct batadv_hard_iface *if_outgoing2);
+
+	/**
+	 * @is_similar_or_better: check if neigh1 is equally similar or better
+	 *  than neigh2 for their respective outgoing interface from the metric
+	 *  prospective
+	 */
 	bool (*is_similar_or_better)(struct batadv_neigh_node *neigh1,
 				     struct batadv_hard_iface *if_outgoing1,
 				     struct batadv_neigh_node *neigh2,
 				     struct batadv_hard_iface *if_outgoing2);
+
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+	/** @print: print the single hop neighbor list (optional) */
 	void (*print)(struct batadv_priv *priv, struct seq_file *seq);
 #endif
+
+	/** @dump: dump neighbors to a netlink socket (optional) */
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
 		     struct batadv_priv *priv,
 		     struct batadv_hard_iface *hard_iface);
@@ -1466,24 +2170,36 @@ struct batadv_algo_neigh_ops {
 
 /**
  * struct batadv_algo_orig_ops - mesh algorithm callbacks (originator specific)
- * @free: free the resources allocated by the routing algorithm for an orig_node
- *  object (optional)
- * @add_if: ask the routing algorithm to apply the needed changes to the
- *  orig_node due to a new hard-interface being added into the mesh (optional)
- * @del_if: ask the routing algorithm to apply the needed changes to the
- *  orig_node due to an hard-interface being removed from the mesh (optional)
- * @print: print the originator table (optional)
- * @dump: dump originators to a netlink socket (optional)
  */
 struct batadv_algo_orig_ops {
+	/**
+	 * @free: free the resources allocated by the routing algorithm for an
+	 *  orig_node object (optional)
+	 */
 	void (*free)(struct batadv_orig_node *orig_node);
+
+	/**
+	 * @add_if: ask the routing algorithm to apply the needed changes to the
+	 *  orig_node due to a new hard-interface being added into the mesh
+	 *  (optional)
+	 */
 	int (*add_if)(struct batadv_orig_node *orig_node, int max_if_num);
+
+	/**
+	 * @del_if: ask the routing algorithm to apply the needed changes to the
+	 *  orig_node due to an hard-interface being removed from the mesh
+	 *  (optional)
+	 */
 	int (*del_if)(struct batadv_orig_node *orig_node, int max_if_num,
 		      int del_if_num);
+
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+	/** @print: print the originator table (optional) */
 	void (*print)(struct batadv_priv *priv, struct seq_file *seq,
 		      struct batadv_hard_iface *hard_iface);
 #endif
+
+	/** @dump: dump originators to a netlink socket (optional) */
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
 		     struct batadv_priv *priv,
 		     struct batadv_hard_iface *hard_iface);
@@ -1491,158 +2207,213 @@ struct batadv_algo_orig_ops {
 
 /**
  * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
- * @init_sel_class: initialize GW selection class (optional)
- * @store_sel_class: parse and stores a new GW selection class (optional)
- * @show_sel_class: prints the current GW selection class (optional)
- * @get_best_gw_node: select the best GW from the list of available nodes
- *  (optional)
- * @is_eligible: check if a newly discovered GW is a potential candidate for
- *  the election as best GW (optional)
- * @print: print the gateway table (optional)
- * @dump: dump gateways to a netlink socket (optional)
  */
 struct batadv_algo_gw_ops {
+	/** @init_sel_class: initialize GW selection class (optional) */
 	void (*init_sel_class)(struct batadv_priv *bat_priv);
+
+	/**
+	 * @store_sel_class: parse and stores a new GW selection class
+	 *  (optional)
+	 */
 	ssize_t (*store_sel_class)(struct batadv_priv *bat_priv, char *buff,
 				   size_t count);
+
+	/** @show_sel_class: prints the current GW selection class (optional) */
 	ssize_t (*show_sel_class)(struct batadv_priv *bat_priv, char *buff);
+
+	/**
+	 * @get_best_gw_node: select the best GW from the list of available
+	 *  nodes (optional)
+	 */
 	struct batadv_gw_node *(*get_best_gw_node)
 		(struct batadv_priv *bat_priv);
+
+	/**
+	 * @is_eligible: check if a newly discovered GW is a potential candidate
+	 *  for the election as best GW (optional)
+	 */
 	bool (*is_eligible)(struct batadv_priv *bat_priv,
 			    struct batadv_orig_node *curr_gw_orig,
 			    struct batadv_orig_node *orig_node);
+
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
+	/** @print: print the gateway table (optional) */
 	void (*print)(struct batadv_priv *bat_priv, struct seq_file *seq);
 #endif
+
+	/** @dump: dump gateways to a netlink socket (optional) */
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
 		     struct batadv_priv *priv);
 };
 
 /**
  * struct batadv_algo_ops - mesh algorithm callbacks
- * @list: list node for the batadv_algo_list
- * @name: name of the algorithm
- * @iface: callbacks related to interface handling
- * @neigh: callbacks related to neighbors handling
- * @orig: callbacks related to originators handling
- * @gw: callbacks related to GW mode
  */
 struct batadv_algo_ops {
+	/** @list: list node for the batadv_algo_list */
 	struct hlist_node list;
+
+	/** @name: name of the algorithm */
 	char *name;
+
+	/** @iface: callbacks related to interface handling */
 	struct batadv_algo_iface_ops iface;
+
+	/** @neigh: callbacks related to neighbors handling */
 	struct batadv_algo_neigh_ops neigh;
+
+	/** @orig: callbacks related to originators handling */
 	struct batadv_algo_orig_ops orig;
+
+	/** @gw: callbacks related to GW mode */
 	struct batadv_algo_gw_ops gw;
 };
 
 /**
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
- * @ip: the IPv4 corresponding to this DAT/ARP entry
- * @mac_addr: the MAC address associated to the stored IPv4
- * @vid: the vlan ID associated to this entry
- * @last_update: time in jiffies when this entry was refreshed last time
- * @hash_entry: hlist node for batadv_priv_dat::hash
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_dat_entry {
+	/** @ip: the IPv4 corresponding to this DAT/ARP entry */
 	__be32 ip;
+
+	/** @mac_addr: the MAC address associated to the stored IPv4 */
 	u8 mac_addr[ETH_ALEN];
+
+	/** @vid: the vlan ID associated to this entry */
 	unsigned short vid;
+
+	/**
+	 * @last_update: time in jiffies when this entry was refreshed last time
+	 */
 	unsigned long last_update;
+
+	/** @hash_entry: hlist node for batadv_priv_dat::hash */
 	struct hlist_node hash_entry;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * struct batadv_hw_addr - a list entry for a MAC address
- * @list: list node for the linking of entries
- * @addr: the MAC address of this list entry
  */
 struct batadv_hw_addr {
+	/** @list: list node for the linking of entries */
 	struct hlist_node list;
+
+	/** @addr: the MAC address of this list entry */
 	unsigned char addr[ETH_ALEN];
 };
 
 /**
  * struct batadv_dat_candidate - candidate destination for DAT operations
- * @type: the type of the selected candidate. It can one of the following:
- *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
- *	  - BATADV_DAT_CANDIDATE_ORIG
- * @orig_node: if type is BATADV_DAT_CANDIDATE_ORIG this field points to the
- *	       corresponding originator node structure
  */
 struct batadv_dat_candidate {
+	/**
+	 * @type: the type of the selected candidate. It can one of the
+	 *  following:
+	 *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
+	 *	  - BATADV_DAT_CANDIDATE_ORIG
+	 */
 	int type;
+
+	/**
+	 * @orig_node: if type is BATADV_DAT_CANDIDATE_ORIG this field points to
+	 * the corresponding originator node structure
+	 */
 	struct batadv_orig_node *orig_node;
 };
 
 /**
  * struct batadv_tvlv_container - container for tvlv appended to OGMs
- * @list: hlist node for batadv_priv_tvlv::container_list
- * @tvlv_hdr: tvlv header information needed to construct the tvlv
- * @refcount: number of contexts the object is used
  */
 struct batadv_tvlv_container {
+	/** @list: hlist node for batadv_priv_tvlv::container_list */
 	struct hlist_node list;
+
+	/** @tvlv_hdr: tvlv header information needed to construct the tvlv */
 	struct batadv_tvlv_hdr tvlv_hdr;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
 };
 
 /**
  * struct batadv_tvlv_handler - handler for specific tvlv type and version
- * @list: hlist node for batadv_priv_tvlv::handler_list
- * @ogm_handler: handler callback which is given the tvlv payload to process on
- *  incoming OGM packets
- * @unicast_handler: handler callback which is given the tvlv payload to process
- *  on incoming unicast tvlv packets
- * @type: tvlv type this handler feels responsible for
- * @version: tvlv version this handler feels responsible for
- * @flags: tvlv handler flags
- * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_tvlv_handler {
+	/** @list: hlist node for batadv_priv_tvlv::handler_list */
 	struct hlist_node list;
+
+	/**
+	 * @ogm_handler: handler callback which is given the tvlv payload to
+	 *  process on incoming OGM packets
+	 */
 	void (*ogm_handler)(struct batadv_priv *bat_priv,
 			    struct batadv_orig_node *orig,
 			    u8 flags, void *tvlv_value, u16 tvlv_value_len);
+
+	/**
+	 * @unicast_handler: handler callback which is given the tvlv payload to
+	 *  process on incoming unicast tvlv packets
+	 */
 	int (*unicast_handler)(struct batadv_priv *bat_priv,
 			       u8 *src, u8 *dst,
 			       void *tvlv_value, u16 tvlv_value_len);
+
+	/** @type: tvlv type this handler feels responsible for */
 	u8 type;
+
+	/** @version: tvlv version this handler feels responsible for */
 	u8 version;
+
+	/** @flags: tvlv handler flags */
 	u8 flags;
+
+	/** @refcount: number of contexts the object is used */
 	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 };
 
 /**
  * enum batadv_tvlv_handler_flags - tvlv handler flags definitions
- * @BATADV_TVLV_HANDLER_OGM_CIFNOTFND: tvlv ogm processing function will call
- *  this handler even if its type was not found (with no data)
- * @BATADV_TVLV_HANDLER_OGM_CALLED: interval tvlv handling flag - the API marks
- *  a handler as being called, so it won't be called if the
- *  BATADV_TVLV_HANDLER_OGM_CIFNOTFND flag was set
  */
 enum batadv_tvlv_handler_flags {
+	/**
+	 * @BATADV_TVLV_HANDLER_OGM_CIFNOTFND: tvlv ogm processing function
+	 *  will call this handler even if its type was not found (with no data)
+	 */
 	BATADV_TVLV_HANDLER_OGM_CIFNOTFND = BIT(1),
+
+	/**
+	 * @BATADV_TVLV_HANDLER_OGM_CALLED: interval tvlv handling flag - the
+	 *  API marks a handler as being called, so it won't be called if the
+	 *  BATADV_TVLV_HANDLER_OGM_CIFNOTFND flag was set
+	 */
 	BATADV_TVLV_HANDLER_OGM_CALLED = BIT(2),
 };
 
 /**
  * struct batadv_store_mesh_work - Work queue item to detach add/del interface
  *  from sysfs locks
- * @net_dev: netdevice to add/remove to/from batman-adv soft-interface
- * @soft_iface_name: name of soft-interface to modify
- * @work: work queue item
  */
 struct batadv_store_mesh_work {
+	/**
+	 * @net_dev: netdevice to add/remove to/from batman-adv soft-interface
+	 */
 	struct net_device *net_dev;
+
+	/** @soft_iface_name: name of soft-interface to modify */
 	char soft_iface_name[IFNAMSIZ];
+
+	/** @work: work queue item */
 	struct work_struct work;
 };
 
-- 
2.11.0

