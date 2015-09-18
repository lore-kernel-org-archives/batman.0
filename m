Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 18 Sep 2015 16:18:23 +0800
Message-Id: <1442564303-8601-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: kernel doc readability updates
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/types.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8c3dda3..af2a2b1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -73,7 +73,7 @@ enum batadv_dhcp_recipient {
 #define BATADV_TT_SYNC_MASK	0x00F0
 
 /**
- * struct batadv_hard_iface_bat_iv - per hard interface B.A.T.M.A.N. IV data
+ * struct batadv_hard_iface_bat_iv - per hard-interface B.A.T.M.A.N. IV data
  * @ogm_buff: buffer holding the OGM packet
  * @ogm_buff_len: length of the OGM packet buffer
  * @ogm_seqno: OGM sequence number - used to identify each OGM
@@ -97,8 +97,8 @@ struct batadv_hard_iface_bat_iv {
  *  batman-adv for this interface
  * @soft_iface: the batman-adv interface which uses this network interface
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: BATMAN IV specific per hard interface data
- * @cleanup_work: work queue callback item for hard interface deinit
+ * @bat_iv: per hard-interface B.A.T.M.A.N. IV data
+ * @cleanup_work: work queue callback item for hard-interface deinit
  * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
  * @neigh_list: list of unique single hop neighbors via this interface
  * @neigh_list_lock: lock protecting neigh_list
@@ -125,7 +125,7 @@ struct batadv_hard_iface {
 /**
  * struct batadv_orig_ifinfo - originator info per outgoing interface
  * @list: list node for orig_node::ifinfo_list
- * @if_outgoing: pointer to outgoing hard interface
+ * @if_outgoing: pointer to outgoing hard-interface
  * @router: router that should be used to reach this originator
  * @last_real_seqno: last and best known sequence number
  * @last_ttl: ttl of last received packet
@@ -202,7 +202,7 @@ struct batadv_orig_node_vlan {
 
 /**
  * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
- * @bcast_own: set of bitfields (one per hard interface) where each one counts
+ * @bcast_own: set of bitfields (one per hard-interface) where each one counts
  * the number of our OGMs this orig_node rebroadcasted "back" to us  (relative
  * to last_real_seqno). Every bitfield is BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
  * @bcast_own_sum: sum of bcast_own
@@ -349,7 +349,8 @@ struct batadv_gw_node {
  * struct batadv_hardif_neigh_node - unique neighbor per hard interface
  * @list: list node for batadv_hard_iface::neigh_list
  * @addr: the MAC address of the neighboring interface
- * @if_incoming: pointer to incoming hard interface
+ * @if_incoming: pointer to incoming hard-interface
+ * @last_seen: when last packet via this neighbor was received
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in a RCU-safe manner
  */
@@ -369,7 +370,7 @@ struct batadv_hardif_neigh_node {
  * @addr: the MAC address of the neighboring interface
  * @ifinfo_list: list for routing metrics per outgoing interface
  * @ifinfo_lock: lock protecting private ifinfo members and list
- * @if_incoming: pointer to incoming hard interface
+ * @if_incoming: pointer to incoming hard-interface
  * @last_seen: when last packet via this neighbor was received
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
@@ -388,7 +389,7 @@ struct batadv_neigh_node {
 
 /**
  * struct batadv_neigh_ifinfo_bat_iv - neighbor information per outgoing
- *  interface for BATMAN IV
+ *  interface for B.A.T.M.A.N. IV
  * @tq_recv: ring buffer of received TQ values from this neigh node
  * @tq_index: ring buffer index
  * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
@@ -407,7 +408,7 @@ struct batadv_neigh_ifinfo_bat_iv {
 /**
  * struct batadv_neigh_ifinfo - neighbor information per outgoing interface
  * @list: list node for batadv_neigh_node::ifinfo_list
- * @if_outgoing: pointer to outgoing hard interface
+ * @if_outgoing: pointer to outgoing hard-interface
  * @bat_iv: B.A.T.M.A.N. IV private structure
  * @last_ttl: last received ttl from this neigh node
  * @refcount: number of contexts the object is used
@@ -783,8 +784,8 @@ struct batadv_softif_vlan {
  * @forw_bat_list_lock: lock protecting forw_bat_list
  * @forw_bcast_list_lock: lock protecting forw_bcast_list
  * @orig_work: work queue callback item for orig node purging
- * @cleanup_work: work queue callback item for soft interface deinit
- * @primary_if: one of the hard interfaces assigned to this mesh interface
+ * @cleanup_work: work queue callback item for soft-interface deinit
+ * @primary_if: one of the hard-interfaces assigned to this mesh interface
  *  becomes the primary interface
  * @bat_algo_ops: routing algorithm used by this mesh interface
  * @softif_vlan_list: a list of softif_vlan structs, one per VLAN created on top
-- 
2.5.1

