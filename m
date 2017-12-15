Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:14 +0100
Message-Id: <20171215114320.13645-15-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 14/20] batman-adv: Use parentheses in
 function kernel-doc
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The documentation describing kernel-doc comments for functions ("How to
format kernel-doc comments") uses parentheses at the end of the function
name. Using this format allows to use a consistent style when adding
documentation to a function and when referencing this function in a
different kernel-doc section.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_algo.c              |   7 +-
 net/batman-adv/bat_iv_ogm.c            |  80 +++++++-------
 net/batman-adv/bat_v.c                 |  48 ++++-----
 net/batman-adv/bat_v_elp.c             |  24 ++---
 net/batman-adv/bat_v_ogm.c             |  34 +++---
 net/batman-adv/bitarray.c              |   2 +-
 net/batman-adv/bitarray.h              |   2 +-
 net/batman-adv/bridge_loop_avoidance.c | 109 ++++++++++---------
 net/batman-adv/bridge_loop_avoidance.h |   4 +-
 net/batman-adv/debugfs.c               |  12 +--
 net/batman-adv/distributed-arp-table.c |  77 +++++++-------
 net/batman-adv/distributed-arp-table.h |   6 +-
 net/batman-adv/fragmentation.c         |  20 ++--
 net/batman-adv/fragmentation.h         |   2 +-
 net/batman-adv/gateway_client.c        |  24 +++--
 net/batman-adv/gateway_common.c        |  18 ++--
 net/batman-adv/hard-interface.c        |  26 ++---
 net/batman-adv/hard-interface.h        |   2 +-
 net/batman-adv/hash.h                  |   2 +-
 net/batman-adv/icmp_socket.c           |   4 +-
 net/batman-adv/main.c                  |  16 +--
 net/batman-adv/main.h                  |   6 +-
 net/batman-adv/multicast.c             |  78 +++++++-------
 net/batman-adv/netlink.c               |  22 ++--
 net/batman-adv/network-coding.c        | 120 +++++++++++----------
 net/batman-adv/originator.c            |  76 ++++++-------
 net/batman-adv/routing.c               |  24 ++---
 net/batman-adv/send.c                  |  45 ++++----
 net/batman-adv/send.h                  |   4 +-
 net/batman-adv/soft-interface.c        |  41 +++----
 net/batman-adv/sysfs.c                 |  20 ++--
 net/batman-adv/tp_meter.c              |  70 ++++++------
 net/batman-adv/translation-table.c     | 189 +++++++++++++++++----------------
 net/batman-adv/tvlv.c                  |  38 +++----
 34 files changed, 633 insertions(+), 619 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 36407f5bde08..06139233bb54 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -40,7 +40,8 @@ char batadv_routing_algo[20] = "BATMAN_IV";
 static struct hlist_head batadv_algo_list;
 
 /**
- * batadv_algo_init - Initialize batman-adv algorithm management data structures
+ * batadv_algo_init() - Initialize batman-adv algorithm management data
+ *  structures
  */
 void batadv_algo_init(void)
 {
@@ -151,7 +152,7 @@ module_param_cb(routing_algo, &batadv_param_ops_ra, &batadv_param_string_ra,
 		0644);
 
 /**
- * batadv_algo_dump_entry - fill in information about one supported routing
+ * batadv_algo_dump_entry() - fill in information about one supported routing
  *  algorithm
  * @msg: netlink message to be sent back
  * @portid: Port to reply to
@@ -182,7 +183,7 @@ static int batadv_algo_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_algo_dump - fill in information about supported routing
+ * batadv_algo_dump() - fill in information about supported routing
  *  algorithms
  * @msg: netlink message to be sent back
  * @cb: Parameters to the netlink request
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 250cb4fb66e7..86e5a6f90bce 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -89,7 +89,7 @@ enum batadv_dup_status {
 };
 
 /**
- * batadv_ring_buffer_set - update the ring buffer with the given value
+ * batadv_ring_buffer_set() - update the ring buffer with the given value
  * @lq_recv: pointer to the ring buffer
  * @lq_index: index to store the value at
  * @value: value to store in the ring buffer
@@ -101,7 +101,7 @@ static void batadv_ring_buffer_set(u8 lq_recv[], u8 *lq_index, u8 value)
 }
 
 /**
- * batadv_ring_buffer_avg - compute the average of all non-zero values stored
+ * batadv_ring_buffer_avg() - compute the average of all non-zero values stored
  * in the given ring buffer
  * @lq_recv: pointer to the ring buffer
  *
@@ -133,7 +133,7 @@ static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
 }
 
 /**
- * batadv_iv_ogm_orig_free - free the private resources allocated for this
+ * batadv_iv_ogm_orig_free() - free the private resources allocated for this
  *  orig_node
  * @orig_node: the orig_node for which the resources have to be free'd
  */
@@ -144,8 +144,8 @@ static void batadv_iv_ogm_orig_free(struct batadv_orig_node *orig_node)
 }
 
 /**
- * batadv_iv_ogm_orig_add_if - change the private structures of the orig_node to
- *  include the new hard-interface
+ * batadv_iv_ogm_orig_add_if() - change the private structures of the orig_node
+ *  to include the new hard-interface
  * @orig_node: the orig_node that has to be changed
  * @max_if_num: the current amount of interfaces
  *
@@ -189,7 +189,7 @@ static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_drop_bcast_own_entry - drop section of bcast_own
+ * batadv_iv_ogm_drop_bcast_own_entry() - drop section of bcast_own
  * @orig_node: the orig_node that has to be changed
  * @max_if_num: the current amount of interfaces
  * @del_if_num: the index of the interface being removed
@@ -227,7 +227,7 @@ batadv_iv_ogm_drop_bcast_own_entry(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_drop_bcast_own_sum_entry - drop section of bcast_own_sum
+ * batadv_iv_ogm_drop_bcast_own_sum_entry() - drop section of bcast_own_sum
  * @orig_node: the orig_node that has to be changed
  * @max_if_num: the current amount of interfaces
  * @del_if_num: the index of the interface being removed
@@ -262,8 +262,8 @@ batadv_iv_ogm_drop_bcast_own_sum_entry(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_orig_del_if - change the private structures of the orig_node to
- *  exclude the removed interface
+ * batadv_iv_ogm_orig_del_if() - change the private structures of the orig_node
+ *  to exclude the removed interface
  * @orig_node: the orig_node that has to be changed
  * @max_if_num: the current amount of interfaces
  * @del_if_num: the index of the interface being removed
@@ -293,7 +293,8 @@ static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_orig_get - retrieve or create (if does not exist) an originator
+ * batadv_iv_ogm_orig_get() - retrieve or create (if does not exist) an
+ *  originator
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: mac address of the originator
  *
@@ -450,7 +451,7 @@ static u8 batadv_hop_penalty(u8 tq, const struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_iv_ogm_aggr_packet - checks if there is another OGM attached
+ * batadv_iv_ogm_aggr_packet() - checks if there is another OGM attached
  * @buff_pos: current position in the skb
  * @packet_len: total length of the skb
  * @tvlv_len: tvlv length of the previously considered OGM
@@ -560,7 +561,7 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 }
 
 /**
- * batadv_iv_ogm_can_aggregate - find out if an OGM can be aggregated on an
+ * batadv_iv_ogm_can_aggregate() - find out if an OGM can be aggregated on an
  *  existing forward packet
  * @new_bat_ogm_packet: OGM packet to be aggregated
  * @bat_priv: the bat priv with all the soft interface information
@@ -663,7 +664,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 }
 
 /**
- * batadv_iv_ogm_aggregate_new - create a new aggregated packet and add this
+ * batadv_iv_ogm_aggregate_new() - create a new aggregated packet and add this
  *  packet to it.
  * @packet_buff: pointer to the OGM
  * @packet_len: (total) length of the OGM
@@ -746,7 +747,7 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 }
 
 /**
- * batadv_iv_ogm_queue_add - queue up an OGM for transmission
+ * batadv_iv_ogm_queue_add() - queue up an OGM for transmission
  * @bat_priv: the bat priv with all the soft interface information
  * @packet_buff: pointer to the OGM
  * @packet_len: (total) length of the OGM
@@ -872,8 +873,8 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_slide_own_bcast_window - bitshift own OGM broadcast windows for
- * the given interface
+ * batadv_iv_ogm_slide_own_bcast_window() - bitshift own OGM broadcast windows
+ *  for the given interface
  * @hard_iface: the interface for which the windows have to be shifted
  */
 static void
@@ -990,7 +991,7 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_iv_ogm_orig_update - use OGM to update corresponding data in an
+ * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the orig node who originally emitted the ogm packet
@@ -1155,7 +1156,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_iv_ogm_calc_tq - calculate tq for current received ogm packet
+ * batadv_iv_ogm_calc_tq() - calculate tq for current received ogm packet
  * @orig_node: the orig node who originally emitted the ogm packet
  * @orig_neigh_node: the orig node struct of the neighbor who sent the packet
  * @batadv_ogm_packet: the ogm packet
@@ -1301,7 +1302,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_update_seqnos -  process a batman packet for all interfaces,
+ * batadv_iv_ogm_update_seqnos() -  process a batman packet for all interfaces,
  *  adjust the sequence number and find out whether it is a duplicate
  * @ethhdr: ethernet header of the packet
  * @batadv_ogm_packet: OGM packet to be considered
@@ -1404,7 +1405,8 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 }
 
 /**
- * batadv_iv_ogm_process_per_outif - process a batman iv OGM for an outgoing if
+ * batadv_iv_ogm_process_per_outif() - process a batman iv OGM for an outgoing
+ *  interface
  * @skb: the skb containing the OGM
  * @ogm_offset: offset from skb->data to start of ogm header
  * @orig_node: the (cached) orig node for the originator of this OGM
@@ -1611,7 +1613,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 }
 
 /**
- * batadv_iv_ogm_process - process an incoming batman iv OGM
+ * batadv_iv_ogm_process() - process an incoming batman iv OGM
  * @skb: the skb containing the OGM
  * @ogm_offset: offset to the OGM which should be processed (for aggregates)
  * @if_incoming: the interface where this packet was receved
@@ -1864,7 +1866,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_iv_ogm_orig_print_neigh - print neighbors for the originator table
+ * batadv_iv_ogm_orig_print_neigh() - print neighbors for the originator table
  * @orig_node: the orig_node for which the neighbors are printed
  * @if_outgoing: outgoing interface for these entries
  * @seq: debugfs table seq_file struct
@@ -1893,7 +1895,7 @@ batadv_iv_ogm_orig_print_neigh(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_iv_ogm_orig_print - print the originator table
+ * batadv_iv_ogm_orig_print() - print the originator table
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: debugfs table seq_file struct
  * @if_outgoing: the outgoing interface for which this should be printed
@@ -1963,7 +1965,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 #endif
 
 /**
- * batadv_iv_ogm_neigh_get_tq_avg - Get the TQ average for a neighbour on a
+ * batadv_iv_ogm_neigh_get_tq_avg() - Get the TQ average for a neighbour on a
  *  given outgoing interface.
  * @neigh_node: Neighbour of interest
  * @if_outgoing: Outgoing interface of interest
@@ -1989,7 +1991,7 @@ batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
 }
 
 /**
- * batadv_iv_ogm_orig_dump_subentry - Dump an originator subentry into a
+ * batadv_iv_ogm_orig_dump_subentry() - Dump an originator subentry into a
  *  message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
@@ -2051,7 +2053,7 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_iv_ogm_orig_dump_entry - Dump an originator entry into a message
+ * batadv_iv_ogm_orig_dump_entry() - Dump an originator entry into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -2113,7 +2115,7 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_iv_ogm_orig_dump_bucket - Dump an originator bucket into a
+ * batadv_iv_ogm_orig_dump_bucket() - Dump an originator bucket into a
  *  message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
@@ -2156,7 +2158,7 @@ batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_iv_ogm_orig_dump - Dump the originators into a message
+ * batadv_iv_ogm_orig_dump() - Dump the originators into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
@@ -2193,7 +2195,7 @@ batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_iv_hardif_neigh_print - print a single hop neighbour node
+ * batadv_iv_hardif_neigh_print() - print a single hop neighbour node
  * @seq: neighbour table seq_file struct
  * @hardif_neigh: hardif neighbour information
  */
@@ -2212,7 +2214,7 @@ batadv_iv_hardif_neigh_print(struct seq_file *seq,
 }
 
 /**
- * batadv_iv_ogm_neigh_print - print the single hop neighbour list
+ * batadv_iv_ogm_neigh_print() - print the single hop neighbour list
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: neighbour table seq_file struct
  */
@@ -2245,7 +2247,7 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
 #endif
 
 /**
- * batadv_iv_ogm_neigh_diff - calculate tq difference of two neighbors
+ * batadv_iv_ogm_neigh_diff() - calculate tq difference of two neighbors
  * @neigh1: the first neighbor object of the comparison
  * @if_outgoing1: outgoing interface for the first neighbor
  * @neigh2: the second neighbor object of the comparison
@@ -2290,7 +2292,7 @@ static bool batadv_iv_ogm_neigh_diff(struct batadv_neigh_node *neigh1,
 }
 
 /**
- * batadv_iv_ogm_neigh_dump_neigh - Dump a neighbour into a netlink message
+ * batadv_iv_ogm_neigh_dump_neigh() - Dump a neighbour into a netlink message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -2329,7 +2331,7 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_iv_ogm_neigh_dump_hardif - Dump the neighbours of a hard interface
+ * batadv_iv_ogm_neigh_dump_hardif() - Dump the neighbours of a hard interface
  *  into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
@@ -2368,7 +2370,7 @@ batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_iv_ogm_neigh_dump - Dump the neighbours into a message
+ * batadv_iv_ogm_neigh_dump() - Dump the neighbours into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
@@ -2420,7 +2422,7 @@ batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 }
 
 /**
- * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
+ * batadv_iv_ogm_neigh_cmp() - compare the metrics of two neighbors
  * @neigh1: the first neighbor object of the comparison
  * @if_outgoing1: outgoing interface for the first neighbor
  * @neigh2: the second neighbor object of the comparison
@@ -2446,7 +2448,7 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 }
 
 /**
- * batadv_iv_ogm_neigh_is_sob - check if neigh1 is similarly good or better
+ * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
  *  than neigh2 from the metric prospective
  * @neigh1: the first neighbor object of the comparison
  * @if_outgoing1: outgoing interface for the first neighbor
@@ -2481,7 +2483,7 @@ static void batadv_iv_iface_activate(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_iv_init_sel_class - initialize GW selection class
+ * batadv_iv_init_sel_class() - initialize GW selection class
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
@@ -2706,7 +2708,7 @@ static void batadv_iv_gw_print(struct batadv_priv *bat_priv,
 #endif
 
 /**
- * batadv_iv_gw_dump_entry - Dump a gateway into a message
+ * batadv_iv_gw_dump_entry() - Dump a gateway into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -2777,7 +2779,7 @@ static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_iv_gw_dump - Dump gateways into a message
+ * batadv_iv_gw_dump() - Dump gateways into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c2eac642fabf..7eea24204b55 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -102,7 +102,7 @@ static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_iface_update_mac - react to hard-interface MAC address change
+ * batadv_v_iface_update_mac() - react to hard-interface MAC address change
  * @hard_iface: the modified interface
  *
  * If the modified interface is the primary one, update the originator
@@ -133,7 +133,7 @@ batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_v_orig_print_neigh - print neighbors for the originator table
+ * batadv_v_orig_print_neigh() - print neighbors for the originator table
  * @orig_node: the orig_node for which the neighbors are printed
  * @if_outgoing: outgoing interface for these entries
  * @seq: debugfs table seq_file struct
@@ -163,7 +163,7 @@ batadv_v_orig_print_neigh(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_v_hardif_neigh_print - print a single ELP neighbour node
+ * batadv_v_hardif_neigh_print() - print a single ELP neighbour node
  * @seq: neighbour table seq_file struct
  * @hardif_neigh: hardif neighbour information
  */
@@ -184,7 +184,7 @@ batadv_v_hardif_neigh_print(struct seq_file *seq,
 }
 
 /**
- * batadv_v_neigh_print - print the single hop neighbour list
+ * batadv_v_neigh_print() - print the single hop neighbour list
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: neighbour table seq_file struct
  */
@@ -218,7 +218,7 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 #endif
 
 /**
- * batadv_v_neigh_dump_neigh - Dump a neighbour into a message
+ * batadv_v_neigh_dump_neigh() - Dump a neighbour into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -261,7 +261,7 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_v_neigh_dump_hardif - Dump the  neighbours of a hard interface  into
+ * batadv_v_neigh_dump_hardif() - Dump the  neighbours of a hard interface into
  *  a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
@@ -299,7 +299,7 @@ batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_v_neigh_dump - Dump the neighbours of a hard interface  into a
+ * batadv_v_neigh_dump() - Dump the neighbours of a hard interface  into a
  *  message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
@@ -351,7 +351,7 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_v_orig_print - print the originator table
+ * batadv_v_orig_print() - print the originator table
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: debugfs table seq_file struct
  * @if_outgoing: the outgoing interface for which this should be printed
@@ -419,8 +419,7 @@ static void batadv_v_orig_print(struct batadv_priv *bat_priv,
 #endif
 
 /**
- * batadv_v_orig_dump_subentry - Dump an originator subentry into a
- *  message
+ * batadv_v_orig_dump_subentry() - Dump an originator subentry into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -486,7 +485,7 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_v_orig_dump_entry - Dump an originator entry into a message
+ * batadv_v_orig_dump_entry() - Dump an originator entry into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -539,8 +538,7 @@ batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_v_orig_dump_bucket - Dump an originator bucket into a
- *  message
+ * batadv_v_orig_dump_bucket() - Dump an originator bucket into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -581,7 +579,7 @@ batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_v_orig_dump - Dump the originators into a message
+ * batadv_v_orig_dump() - Dump the originators into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
@@ -671,7 +669,7 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 }
 
 /**
- * batadv_v_init_sel_class - initialize GW selection class
+ * batadv_v_init_sel_class() - initialize GW selection class
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_v_init_sel_class(struct batadv_priv *bat_priv)
@@ -707,7 +705,7 @@ static ssize_t batadv_v_show_sel_class(struct batadv_priv *bat_priv, char *buff)
 }
 
 /**
- * batadv_v_gw_throughput_get - retrieve the GW-bandwidth for a given GW
+ * batadv_v_gw_throughput_get() - retrieve the GW-bandwidth for a given GW
  * @gw_node: the GW to retrieve the metric for
  * @bw: the pointer where the metric will be stored. The metric is computed as
  *  the minimum between the GW advertised throughput and the path throughput to
@@ -750,7 +748,7 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
 }
 
 /**
- * batadv_v_gw_get_best_gw_node - retrieve the best GW node
+ * batadv_v_gw_get_best_gw_node() - retrieve the best GW node
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: the GW node having the best GW-metric, NULL if no GW is known
@@ -788,7 +786,7 @@ batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_gw_is_eligible - check if a originator would be selected as GW
+ * batadv_v_gw_is_eligible() - check if a originator would be selected as GW
  * @bat_priv: the bat priv with all the soft interface information
  * @curr_gw_orig: originator representing the currently selected GW
  * @orig_node: the originator representing the new candidate
@@ -887,7 +885,7 @@ static int batadv_v_gw_write_buffer_text(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_gw_print - print the gateway list
+ * batadv_v_gw_print() - print the gateway list
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: gateway table seq_file struct
  */
@@ -916,7 +914,7 @@ static void batadv_v_gw_print(struct batadv_priv *bat_priv,
 #endif
 
 /**
- * batadv_v_gw_dump_entry - Dump a gateway into a message
+ * batadv_v_gw_dump_entry() - Dump a gateway into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -1007,7 +1005,7 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_v_gw_dump - Dump gateways into a message
+ * batadv_v_gw_dump() - Dump gateways into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
@@ -1077,7 +1075,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 };
 
 /**
- * batadv_v_hardif_init - initialize the algorithm specific fields in the
+ * batadv_v_hardif_init() - initialize the algorithm specific fields in the
  *  hard-interface object
  * @hard_iface: the hard-interface to initialize
  */
@@ -1091,7 +1089,7 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_mesh_init - initialize the B.A.T.M.A.N. V private resources for a
+ * batadv_v_mesh_init() - initialize the B.A.T.M.A.N. V private resources for a
  *  mesh
  * @bat_priv: the object representing the mesh interface to initialise
  *
@@ -1109,7 +1107,7 @@ int batadv_v_mesh_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_mesh_free - free the B.A.T.M.A.N. V private resources for a mesh
+ * batadv_v_mesh_free() - free the B.A.T.M.A.N. V private resources for a mesh
  * @bat_priv: the object representing the mesh interface to free
  */
 void batadv_v_mesh_free(struct batadv_priv *bat_priv)
@@ -1118,7 +1116,7 @@ void batadv_v_mesh_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_init - B.A.T.M.A.N. V initialization function
+ * batadv_v_init() - B.A.T.M.A.N. V initialization function
  *
  * Description: Takes care of initializing all the subcomponents.
  * It is invoked upon module load only.
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 39fbed58e4c8..0908e313d121 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -55,7 +55,7 @@
 #include "send.h"
 
 /**
- * batadv_v_elp_start_timer - restart timer for ELP periodic work
+ * batadv_v_elp_start_timer() - restart timer for ELP periodic work
  * @hard_iface: the interface for which the timer has to be reset
  */
 static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
@@ -70,7 +70,7 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_elp_get_throughput - get the throughput towards a neighbour
+ * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
  *
  * Return: The throughput towards the given neighbour in multiples of 100kpbs
@@ -156,8 +156,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 }
 
 /**
- * batadv_v_elp_throughput_metric_update - worker updating the throughput metric
- *  of a single hop neighbour
+ * batadv_v_elp_throughput_metric_update() - worker updating the throughput
+ *  metric of a single hop neighbour
  * @work: the work queue item
  */
 void batadv_v_elp_throughput_metric_update(struct work_struct *work)
@@ -180,7 +180,7 @@ void batadv_v_elp_throughput_metric_update(struct work_struct *work)
 }
 
 /**
- * batadv_v_elp_wifi_neigh_probe - send link probing packets to a neighbour
+ * batadv_v_elp_wifi_neigh_probe() - send link probing packets to a neighbour
  * @neigh: the neighbour to probe
  *
  * Sends a predefined number of unicast wifi packets to a given neighbour in
@@ -243,7 +243,7 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 }
 
 /**
- * batadv_v_elp_periodic_work - ELP periodic task per interface
+ * batadv_v_elp_periodic_work() - ELP periodic task per interface
  * @work: work queue item
  *
  * Emits broadcast ELP message in regular intervals.
@@ -330,7 +330,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 }
 
 /**
- * batadv_v_elp_iface_enable - setup the ELP interface private resources
+ * batadv_v_elp_iface_enable() - setup the ELP interface private resources
  * @hard_iface: interface for which the data has to be prepared
  *
  * Return: 0 on success or a -ENOMEM in case of failure.
@@ -378,7 +378,7 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_elp_iface_disable - release ELP interface private resources
+ * batadv_v_elp_iface_disable() - release ELP interface private resources
  * @hard_iface: interface for which the resources have to be released
  */
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
@@ -390,7 +390,7 @@ void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_elp_iface_activate - update the ELP buffer belonging to the given
+ * batadv_v_elp_iface_activate() - update the ELP buffer belonging to the given
  *  hard-interface
  * @primary_iface: the new primary interface
  * @hard_iface: interface holding the to-be-updated buffer
@@ -411,7 +411,7 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 }
 
 /**
- * batadv_v_elp_primary_iface_set - change internal data to reflect the new
+ * batadv_v_elp_primary_iface_set() - change internal data to reflect the new
  *  primary interface
  * @primary_iface: the new primary interface
  */
@@ -431,7 +431,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 }
 
 /**
- * batadv_v_elp_neigh_update - update an ELP neighbour node
+ * batadv_v_elp_neigh_update() - update an ELP neighbour node
  * @bat_priv: the bat priv with all the soft interface information
  * @neigh_addr: the neighbour interface address
  * @if_incoming: the interface the packet was received through
@@ -491,7 +491,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_elp_packet_recv - main ELP packet handler
+ * batadv_v_elp_packet_recv() - main ELP packet handler
  * @skb: the received packet
  * @if_incoming: the interface this packet was received through
  *
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 3cc5cd2f267e..a79e89ca5667 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -54,7 +54,7 @@
 #include "tvlv.h"
 
 /**
- * batadv_v_ogm_orig_get - retrieve and possibly create an originator node
+ * batadv_v_ogm_orig_get() - retrieve and possibly create an originator node
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address of the originator
  *
@@ -91,7 +91,7 @@ struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_ogm_start_timer - restart the OGM sending timer
+ * batadv_v_ogm_start_timer() - restart the OGM sending timer
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
@@ -110,7 +110,7 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_ogm_send_to_if - send a batman ogm using a given interface
+ * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
  * @skb: the OGM to send
  * @hard_iface: the interface to use to send the OGM
  */
@@ -130,7 +130,7 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 }
 
 /**
- * batadv_v_ogm_send - periodic worker broadcasting the own OGM
+ * batadv_v_ogm_send() - periodic worker broadcasting the own OGM
  * @work: work queue item
  */
 static void batadv_v_ogm_send(struct work_struct *work)
@@ -238,7 +238,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 }
 
 /**
- * batadv_v_ogm_iface_enable - prepare an interface for B.A.T.M.A.N. V
+ * batadv_v_ogm_iface_enable() - prepare an interface for B.A.T.M.A.N. V
  * @hard_iface: the interface to prepare
  *
  * Takes care of scheduling own OGM sending routine for this interface.
@@ -255,7 +255,7 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_ogm_primary_iface_set - set a new primary interface
+ * batadv_v_ogm_primary_iface_set() - set a new primary interface
  * @primary_iface: the new primary interface
  */
 void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
@@ -271,8 +271,8 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 }
 
 /**
- * batadv_v_forward_penalty - apply a penalty to the throughput metric forwarded
- *  with B.A.T.M.A.N. V OGMs
+ * batadv_v_forward_penalty() - apply a penalty to the throughput metric
+ *  forwarded with B.A.T.M.A.N. V OGMs
  * @bat_priv: the bat priv with all the soft interface information
  * @if_incoming: the interface where the OGM has been received
  * @if_outgoing: the interface where the OGM has to be forwarded to
@@ -317,7 +317,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_ogm_forward - check conditions and forward an OGM to the given
+ * batadv_v_ogm_forward() - check conditions and forward an OGM to the given
  *  outgoing interface
  * @bat_priv: the bat priv with all the soft interface information
  * @ogm_received: previously received OGM to be forwarded
@@ -408,7 +408,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_ogm_metric_update - update route metric based on OGM
+ * batadv_v_ogm_metric_update() - update route metric based on OGM
  * @bat_priv: the bat priv with all the soft interface information
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
@@ -493,7 +493,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_ogm_route_update - update routes based on OGM
+ * batadv_v_ogm_route_update() - update routes based on OGM
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
@@ -593,7 +593,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_ogm_process_per_outif - process a batman v OGM for an outgoing if
+ * batadv_v_ogm_process_per_outif() - process a batman v OGM for an outgoing if
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
@@ -642,7 +642,7 @@ batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_v_ogm_aggr_packet - checks if there is another OGM aggregated
+ * batadv_v_ogm_aggr_packet() - checks if there is another OGM aggregated
  * @buff_pos: current position in the skb
  * @packet_len: total length of the skb
  * @tvlv_len: tvlv length of the previously considered OGM
@@ -662,7 +662,7 @@ static bool batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 }
 
 /**
- * batadv_v_ogm_process - process an incoming batman v OGM
+ * batadv_v_ogm_process() - process an incoming batman v OGM
  * @skb: the skb containing the OGM
  * @ogm_offset: offset to the OGM which should be processed (for aggregates)
  * @if_incoming: the interface where this packet was receved
@@ -790,7 +790,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 }
 
 /**
- * batadv_v_ogm_packet_recv - OGM2 receiving handler
+ * batadv_v_ogm_packet_recv() - OGM2 receiving handler
  * @skb: the received OGM
  * @if_incoming: the interface where this OGM has been received
  *
@@ -854,7 +854,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 }
 
 /**
- * batadv_v_ogm_init - initialise the OGM2 engine
+ * batadv_v_ogm_init() - initialise the OGM2 engine
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 on success or a negative error code in case of failure
@@ -887,7 +887,7 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_ogm_free - free OGM private resources
+ * batadv_v_ogm_free() - free OGM private resources
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_v_ogm_free(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 8b0d2dc12679..96972e927c47 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -35,7 +35,7 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
 }
 
 /**
- * batadv_bit_get_packet - receive and process one packet within the sequence
+ * batadv_bit_get_packet() - receive and process one packet within the sequence
  *  number window
  * @priv: the bat priv with all the soft interface information
  * @seq_bits: pointer to the sequence number receive packet
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 69e8fff5c7c2..25c2cca948e3 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -29,7 +29,7 @@
 #include <linux/types.h>
 
 /**
- * batadv_test_bit - check if bit is set in the current window
+ * batadv_test_bit() - check if bit is set in the current window
  *
  * @seq_bits: pointer to the sequence number receive packet
  * @last_seqno: latest sequence number in seq_bits
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 2f12a556b6b0..15d64a575034 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -72,7 +72,7 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
 			 struct batadv_bla_backbone_gw *backbone_gw);
 
 /**
- * batadv_choose_claim - choose the right bucket for a claim.
+ * batadv_choose_claim() - choose the right bucket for a claim.
  * @data: data to hash
  * @size: size of the hash table
  *
@@ -90,7 +90,7 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
 }
 
 /**
- * batadv_choose_backbone_gw - choose the right bucket for a backbone gateway.
+ * batadv_choose_backbone_gw() - choose the right bucket for a backbone gateway.
  * @data: data to hash
  * @size: size of the hash table
  *
@@ -108,7 +108,7 @@ static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 }
 
 /**
- * batadv_compare_backbone_gw - compare address and vid of two backbone gws
+ * batadv_compare_backbone_gw() - compare address and vid of two backbone gws
  * @node: list node of the first entry to compare
  * @data2: pointer to the second backbone gateway
  *
@@ -132,7 +132,7 @@ static bool batadv_compare_backbone_gw(const struct hlist_node *node,
 }
 
 /**
- * batadv_compare_claim - compare address and vid of two claims
+ * batadv_compare_claim() - compare address and vid of two claims
  * @node: list node of the first entry to compare
  * @data2: pointer to the second claims
  *
@@ -156,7 +156,7 @@ static bool batadv_compare_claim(const struct hlist_node *node,
 }
 
 /**
- * batadv_backbone_gw_release - release backbone gw from lists and queue for
+ * batadv_backbone_gw_release() - release backbone gw from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the backbone gw
  */
@@ -171,7 +171,7 @@ static void batadv_backbone_gw_release(struct kref *ref)
 }
 
 /**
- * batadv_backbone_gw_put - decrement the backbone gw refcounter and possibly
+ * batadv_backbone_gw_put() - decrement the backbone gw refcounter and possibly
  *  release it
  * @backbone_gw: backbone gateway to be free'd
  */
@@ -181,8 +181,8 @@ static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_claim_release - release claim from lists and queue for free after rcu
- *  grace period
+ * batadv_claim_release() - release claim from lists and queue for free after
+ *  rcu grace period
  * @ref: kref pointer of the claim
  */
 static void batadv_claim_release(struct kref *ref)
@@ -207,8 +207,7 @@ static void batadv_claim_release(struct kref *ref)
 }
 
 /**
- * batadv_claim_put - decrement the claim refcounter and possibly
- *  release it
+ * batadv_claim_put() - decrement the claim refcounter and possibly release it
  * @claim: claim to be free'd
  */
 static void batadv_claim_put(struct batadv_bla_claim *claim)
@@ -217,7 +216,7 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
 }
 
 /**
- * batadv_claim_hash_find - looks for a claim in the claim hash
+ * batadv_claim_hash_find() - looks for a claim in the claim hash
  * @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
@@ -256,7 +255,7 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_backbone_hash_find - looks for a backbone gateway in the hash
+ * batadv_backbone_hash_find() - looks for a backbone gateway in the hash
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address of the originator
  * @vid: the VLAN ID
@@ -300,7 +299,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
 }
 
 /**
- * batadv_bla_del_backbone_claims - delete all claims for a backbone
+ * batadv_bla_del_backbone_claims() - delete all claims for a backbone
  * @backbone_gw: backbone gateway where the claims should be removed
  */
 static void
@@ -340,7 +339,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_bla_send_claim - sends a claim frame according to the provided info
+ * batadv_bla_send_claim() - sends a claim frame according to the provided info
  * @bat_priv: the bat priv with all the soft interface information
  * @mac: the mac address to be announced within the claim
  * @vid: the VLAN ID
@@ -460,7 +459,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 }
 
 /**
- * batadv_bla_loopdetect_report - worker for reporting the loop
+ * batadv_bla_loopdetect_report() - worker for reporting the loop
  * @work: work queue item
  *
  * Throws an uevent, as the loopdetect check function can't do that itself
@@ -490,7 +489,7 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
 }
 
 /**
- * batadv_bla_get_backbone_gw - finds or creates a backbone gateway
+ * batadv_bla_get_backbone_gw() - finds or creates a backbone gateway
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
@@ -563,7 +562,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 }
 
 /**
- * batadv_bla_update_own_backbone_gw - updates the own backbone gw for a VLAN
+ * batadv_bla_update_own_backbone_gw() - updates the own backbone gw for a VLAN
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the selected primary interface
  * @vid: VLAN identifier
@@ -589,7 +588,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_answer_request - answer a bla request by sending own claims
+ * batadv_bla_answer_request() - answer a bla request by sending own claims
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: interface where the request came on
  * @vid: the vid where the request came on
@@ -639,7 +638,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_send_request - send a request to repeat claims
+ * batadv_bla_send_request() - send a request to repeat claims
  * @backbone_gw: the backbone gateway from whom we are out of sync
  *
  * When the crc is wrong, ask the backbone gateway for a full table update.
@@ -666,7 +665,7 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_bla_send_announce - Send an announcement frame
+ * batadv_bla_send_announce() - Send an announcement frame
  * @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: our backbone gateway which should be announced
  */
@@ -687,7 +686,7 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_add_claim - Adds a claim in the claim hash
+ * batadv_bla_add_claim() - Adds a claim in the claim hash
  * @bat_priv: the bat priv with all the soft interface information
  * @mac: the mac address of the claim
  * @vid: the VLAN ID of the frame
@@ -777,7 +776,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_claim_get_backbone_gw - Get valid reference for backbone_gw of
+ * batadv_bla_claim_get_backbone_gw() - Get valid reference for backbone_gw of
  *  claim
  * @claim: claim whose backbone_gw should be returned
  *
@@ -797,7 +796,7 @@ batadv_bla_claim_get_backbone_gw(struct batadv_bla_claim *claim)
 }
 
 /**
- * batadv_bla_del_claim - delete a claim from the claim hash
+ * batadv_bla_del_claim() - delete a claim from the claim hash
  * @bat_priv: the bat priv with all the soft interface information
  * @mac: mac address of the claim to be removed
  * @vid: VLAN id for the claim to be removed
@@ -825,7 +824,7 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_handle_announce - check for ANNOUNCE frame
+ * batadv_handle_announce() - check for ANNOUNCE frame
  * @bat_priv: the bat priv with all the soft interface information
  * @an_addr: announcement mac address (ARP Sender HW address)
  * @backbone_addr: originator address of the sender (Ethernet source MAC)
@@ -883,7 +882,7 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 }
 
 /**
- * batadv_handle_request - check for REQUEST frame
+ * batadv_handle_request() - check for REQUEST frame
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @backbone_addr: backbone address to be requested (ARP sender HW MAC)
@@ -916,7 +915,7 @@ static bool batadv_handle_request(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_handle_unclaim - check for UNCLAIM frame
+ * batadv_handle_unclaim() - check for UNCLAIM frame
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @backbone_addr: originator address of the backbone (Ethernet source)
@@ -954,7 +953,7 @@ static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_handle_claim - check for CLAIM frame
+ * batadv_handle_claim() - check for CLAIM frame
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @backbone_addr: originator address of the backbone (Ethernet Source)
@@ -991,7 +990,7 @@ static bool batadv_handle_claim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_check_claim_group - check for claim group membership
+ * batadv_check_claim_group() - check for claim group membership
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary interface of this batman interface
  * @hw_src: the Hardware source in the ARP Header
@@ -1066,7 +1065,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_process_claim - Check if this is a claim frame, and process it
+ * batadv_bla_process_claim() - Check if this is a claim frame, and process it
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @skb: the frame to be checked
@@ -1208,7 +1207,7 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_purge_backbone_gw - Remove backbone gateways after a timeout or
+ * batadv_bla_purge_backbone_gw() - Remove backbone gateways after a timeout or
  *  immediately
  * @bat_priv: the bat priv with all the soft interface information
  * @now: whether the whole hash shall be wiped now
@@ -1261,7 +1260,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 }
 
 /**
- * batadv_bla_purge_claims - Remove claims after a timeout or immediately
+ * batadv_bla_purge_claims() - Remove claims after a timeout or immediately
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the selected primary interface, may be NULL if now is set
  * @now: whether the whole hash shall be wiped now
@@ -1319,7 +1318,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_update_orig_address - Update the backbone gateways when the own
+ * batadv_bla_update_orig_address() - Update the backbone gateways when the own
  *  originator address changes
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the new selected primary_if
@@ -1375,7 +1374,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_send_loopdetect - send a loopdetect frame
+ * batadv_bla_send_loopdetect() - send a loopdetect frame
  * @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: the backbone gateway for which a loop should be detected
  *
@@ -1395,7 +1394,7 @@ batadv_bla_send_loopdetect(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_status_update - purge bla interfaces if necessary
+ * batadv_bla_status_update() - purge bla interfaces if necessary
  * @net_dev: the soft interface net device
  */
 void batadv_bla_status_update(struct net_device *net_dev)
@@ -1415,7 +1414,7 @@ void batadv_bla_status_update(struct net_device *net_dev)
 }
 
 /**
- * batadv_bla_periodic_work - performs periodic bla work
+ * batadv_bla_periodic_work() - performs periodic bla work
  * @work: kernel work struct
  *
  * periodic work to do:
@@ -1520,7 +1519,7 @@ static struct lock_class_key batadv_claim_hash_lock_class_key;
 static struct lock_class_key batadv_backbone_hash_lock_class_key;
 
 /**
- * batadv_bla_init - initialize all bla structures
+ * batadv_bla_init() - initialize all bla structures
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 on success, < 0 on error.
@@ -1582,7 +1581,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_check_bcast_duplist - Check if a frame is in the broadcast dup.
+ * batadv_bla_check_bcast_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: contains the bcast_packet to be checked
  *
@@ -1655,7 +1654,7 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_is_backbone_gw_orig - Check if the originator is a gateway for
+ * batadv_bla_is_backbone_gw_orig() - Check if the originator is a gateway for
  *  the VLAN identified by vid.
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: originator mac address
@@ -1695,7 +1694,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 }
 
 /**
- * batadv_bla_is_backbone_gw - check if originator is a backbone gw for a VLAN.
+ * batadv_bla_is_backbone_gw() - check if originator is a backbone gw for a VLAN
  * @skb: the frame to be checked
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
@@ -1729,7 +1728,7 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 }
 
 /**
- * batadv_bla_free - free all bla structures
+ * batadv_bla_free() - free all bla structures
  * @bat_priv: the bat priv with all the soft interface information
  *
  * for softinterface free or module unload
@@ -1756,7 +1755,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_loopdetect_check - check and handle a detected loop
+ * batadv_bla_loopdetect_check() - check and handle a detected loop
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the packet to check
  * @primary_if: interface where the request came on
@@ -1805,7 +1804,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 }
 
 /**
- * batadv_bla_rx - check packets coming from the mesh.
+ * batadv_bla_rx() - check packets coming from the mesh.
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
@@ -1917,7 +1916,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 }
 
 /**
- * batadv_bla_tx - check packets going into the mesh
+ * batadv_bla_tx() - check packets going into the mesh
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
@@ -2025,7 +2024,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_bla_claim_table_seq_print_text - print the claim table in a seq file
+ * batadv_bla_claim_table_seq_print_text() - print the claim table in a seq file
  * @seq: seq file to print on
  * @offset: not used
  *
@@ -2087,7 +2086,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_bla_claim_dump_entry - dump one entry of the claim table
+ * batadv_bla_claim_dump_entry() - dump one entry of the claim table
  * to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
@@ -2146,7 +2145,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_bla_claim_dump_bucket - dump one bucket of the claim table
+ * batadv_bla_claim_dump_bucket() - dump one bucket of the claim table
  * to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
@@ -2183,7 +2182,7 @@ batadv_bla_claim_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_bla_claim_dump - dump claim table to a netlink socket
+ * batadv_bla_claim_dump() - dump claim table to a netlink socket
  * @msg: buffer for the message
  * @cb: callback structure containing arguments
  *
@@ -2250,8 +2249,8 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_bla_backbone_table_seq_print_text - print the backbone table in a seq
- *  file
+ * batadv_bla_backbone_table_seq_print_text() - print the backbone table in a
+ *  seq file
  * @seq: seq file to print on
  * @offset: not used
  *
@@ -2315,8 +2314,8 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_bla_backbone_dump_entry - dump one entry of the backbone table
- * to a netlink socket
+ * batadv_bla_backbone_dump_entry() - dump one entry of the backbone table to a
+ *  netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
  * @seq: Sequence number of netlink message
@@ -2376,8 +2375,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_bla_backbone_dump_bucket - dump one bucket of the backbone table
- * to a netlink socket
+ * batadv_bla_backbone_dump_bucket() - dump one bucket of the backbone table to
+ *  a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
  * @seq: Sequence number of netlink message
@@ -2413,7 +2412,7 @@ batadv_bla_backbone_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_bla_backbone_dump - dump backbone table to a netlink socket
+ * batadv_bla_backbone_dump() - dump backbone table to a netlink socket
  * @msg: buffer for the message
  * @cb: callback structure containing arguments
  *
@@ -2480,7 +2479,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 /**
- * batadv_bla_check_claim - check if address is claimed
+ * batadv_bla_check_claim() - check if address is claimed
  *
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: mac address of which the claim status is checked
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 4c9497b49c93..ffc7cb484359 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -33,8 +33,8 @@ struct seq_file;
 struct sk_buff;
 
 /**
- * batadv_bla_is_loopdetect_mac - check if the mac address is from a loop detect
- *  frame sent by bridge loop avoidance
+ * batadv_bla_is_loopdetect_mac() - check if the mac address is from a loop
+ *  detect frame sent by bridge loop avoidance
  * @mac: mac address to check
  *
  * Return: true if the it looks like a loop detect frame
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 96df39597ae7..a36c5ad90912 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -68,8 +68,8 @@ static int batadv_originators_open(struct inode *inode, struct file *file)
 }
 
 /**
- * batadv_originators_hardif_open - handles debugfs output for the
- *  originator table of an hard interface
+ * batadv_originators_hardif_open() - handles debugfs output for the originator
+ *  table of an hard interface
  * @inode: inode pointer to debugfs file
  * @file: pointer to the seq_file
  *
@@ -119,7 +119,7 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 /**
- * batadv_dat_cache_open - Prepare file handler for reads from dat_chache
+ * batadv_dat_cache_open() - Prepare file handler for reads from dat_chache
  * @inode: inode which was opened
  * @file: file handle to be initialized
  *
@@ -156,7 +156,7 @@ static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
 /**
- * batadv_mcast_flags_open - prepare file handler for reads from mcast_flags
+ * batadv_mcast_flags_open() - prepare file handler for reads from mcast_flags
  * @inode: inode which was opened
  * @file: file handle to be initialized
  *
@@ -298,7 +298,7 @@ void batadv_debugfs_destroy(void)
 }
 
 /**
- * batadv_debugfs_add_hardif - creates the base directory for a hard interface
+ * batadv_debugfs_add_hardif() - creates the base directory for a hard interface
  *  in debugfs.
  * @hard_iface: hard interface which should be added.
  *
@@ -340,7 +340,7 @@ int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_debugfs_del_hardif - delete the base directory for a hard interface
+ * batadv_debugfs_del_hardif() - delete the base directory for a hard interface
  *  in debugfs.
  * @hard_iface: hard interface which is deleted.
  */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 1035c53af616..37c183633ad0 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -58,7 +58,7 @@
 static void batadv_dat_purge(struct work_struct *work);
 
 /**
- * batadv_dat_start_timer - initialise the DAT periodic worker
+ * batadv_dat_start_timer() - initialise the DAT periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
@@ -69,7 +69,7 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_dat_entry_release - release dat_entry from lists and queue for free
+ * batadv_dat_entry_release() - release dat_entry from lists and queue for free
  *  after rcu grace period
  * @ref: kref pointer of the dat_entry
  */
@@ -83,7 +83,7 @@ static void batadv_dat_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_dat_entry_put - decrement the dat_entry refcounter and possibly
+ * batadv_dat_entry_put() - decrement the dat_entry refcounter and possibly
  *  release it
  * @dat_entry: dat_entry to be free'd
  */
@@ -93,7 +93,7 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
 }
 
 /**
- * batadv_dat_to_purge - check whether a dat_entry has to be purged or not
+ * batadv_dat_to_purge() - check whether a dat_entry has to be purged or not
  * @dat_entry: the entry to check
  *
  * Return: true if the entry has to be purged now, false otherwise.
@@ -105,7 +105,7 @@ static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 }
 
 /**
- * __batadv_dat_purge - delete entries from the DAT local storage
+ * __batadv_dat_purge() - delete entries from the DAT local storage
  * @bat_priv: the bat priv with all the soft interface information
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the dat_entry as argument and has to
@@ -148,8 +148,8 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_purge - periodic task that deletes old entries from the local DAT
- * hash table
+ * batadv_dat_purge() - periodic task that deletes old entries from the local
+ *  DAT hash table
  * @work: kernel work struct
  */
 static void batadv_dat_purge(struct work_struct *work)
@@ -167,7 +167,7 @@ static void batadv_dat_purge(struct work_struct *work)
 }
 
 /**
- * batadv_compare_dat - comparing function used in the local DAT hash table
+ * batadv_compare_dat() - comparing function used in the local DAT hash table
  * @node: node in the local table
  * @data2: second object to compare the node to
  *
@@ -182,7 +182,7 @@ static bool batadv_compare_dat(const struct hlist_node *node, const void *data2)
 }
 
 /**
- * batadv_arp_hw_src - extract the hw_src field from an ARP packet
+ * batadv_arp_hw_src() - extract the hw_src field from an ARP packet
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
@@ -199,7 +199,7 @@ static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_arp_ip_src - extract the ip_src field from an ARP packet
+ * batadv_arp_ip_src() - extract the ip_src field from an ARP packet
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
@@ -211,7 +211,7 @@ static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_arp_hw_dst - extract the hw_dst field from an ARP packet
+ * batadv_arp_hw_dst() - extract the hw_dst field from an ARP packet
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
@@ -223,7 +223,7 @@ static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_arp_ip_dst - extract the ip_dst field from an ARP packet
+ * batadv_arp_ip_dst() - extract the ip_dst field from an ARP packet
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
@@ -235,7 +235,7 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_hash_dat - compute the hash value for an IP address
+ * batadv_hash_dat() - compute the hash value for an IP address
  * @data: data to hash
  * @size: size of the hash table
  *
@@ -270,7 +270,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
 }
 
 /**
- * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
+ * batadv_dat_entry_hash_find() - look for a given dat_entry in the local hash
  * table
  * @bat_priv: the bat priv with all the soft interface information
  * @ip: search key
@@ -313,7 +313,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 }
 
 /**
- * batadv_dat_entry_add - add a new dat entry or update it if already exists
+ * batadv_dat_entry_add() - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
  * @ip: ipv4 to add/edit
  * @mac_addr: mac address to assign to the given ipv4
@@ -370,7 +370,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 
 /**
- * batadv_dbg_arp - print a debug message containing all the ARP packet details
+ * batadv_dbg_arp() - print a debug message containing all the ARP packet
+ *  details
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
@@ -451,7 +452,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
 
 /**
- * batadv_is_orig_node_eligible - check whether a node can be a DHT candidate
+ * batadv_is_orig_node_eligible() - check whether a node can be a DHT candidate
  * @res: the array with the already selected candidates
  * @select: number of already selected candidates
  * @tmp_max: address of the currently evaluated node
@@ -505,7 +506,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 }
 
 /**
- * batadv_choose_next_candidate - select the next DHT candidate
+ * batadv_choose_next_candidate() - select the next DHT candidate
  * @bat_priv: the bat priv with all the soft interface information
  * @cands: candidates array
  * @select: number of candidates already present in the array
@@ -569,8 +570,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_select_candidates - select the nodes which the DHT message has to
- * be sent to
+ * batadv_dat_select_candidates() - select the nodes which the DHT message has
+ *  to be sent to
  * @bat_priv: the bat priv with all the soft interface information
  * @ip_dst: ipv4 to look up in the DHT
  * @vid: VLAN identifier
@@ -615,7 +616,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 }
 
 /**
- * batadv_dat_send_data - send a payload to the selected candidates
+ * batadv_dat_send_data() - send a payload to the selected candidates
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @ip: the DHT key
@@ -691,7 +692,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_tvlv_container_update - update the dat tvlv container after dat
+ * batadv_dat_tvlv_container_update() - update the dat tvlv container after dat
  *  setting change
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -713,7 +714,7 @@ static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_dat_status_update - update the dat tvlv container after dat
+ * batadv_dat_status_update() - update the dat tvlv container after dat
  *  setting change
  * @net_dev: the soft interface net device
  */
@@ -725,7 +726,7 @@ void batadv_dat_status_update(struct net_device *net_dev)
 }
 
 /**
- * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv container
+ * batadv_dat_tvlv_ogm_handler_v1() - process incoming dat tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
@@ -744,7 +745,7 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_hash_free - free the local DAT hash table
+ * batadv_dat_hash_free() - free the local DAT hash table
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
@@ -760,7 +761,7 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_dat_init - initialise the DAT internals
+ * batadv_dat_init() - initialise the DAT internals
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 in case of success, a negative error code otherwise
@@ -785,7 +786,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_dat_free - free the DAT internals
+ * batadv_dat_free() - free the DAT internals
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_dat_free(struct batadv_priv *bat_priv)
@@ -800,7 +801,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_dat_cache_seq_print_text - print the local DAT hash table
+ * batadv_dat_cache_seq_print_text() - print the local DAT hash table
  * @seq: seq file to print on
  * @offset: not used
  *
@@ -853,7 +854,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_arp_get_type - parse an ARP packet and gets the type
+ * batadv_arp_get_type() - parse an ARP packet and gets the type
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to analyse
  * @hdr_size: size of the possible header before the ARP packet in the skb
@@ -927,7 +928,7 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_get_vid - extract the VLAN identifier from skb if any
+ * batadv_dat_get_vid() - extract the VLAN identifier from skb if any
  * @skb: the buffer containing the packet to extract the VID from
  * @hdr_size: the size of the batman-adv header encapsulating the packet
  *
@@ -953,7 +954,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 }
 
 /**
- * batadv_dat_arp_create_reply - create an ARP Reply
+ * batadv_dat_arp_create_reply() - create an ARP Reply
  * @bat_priv: the bat priv with all the soft interface information
  * @ip_src: ARP sender IP
  * @ip_dst: ARP target IP
@@ -988,7 +989,7 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 }
 
 /**
- * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try to
+ * batadv_dat_snoop_outgoing_arp_request() - snoop the ARP request and try to
  * answer using DAT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
@@ -1086,7 +1087,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_snoop_incoming_arp_request - snoop the ARP request and try to
+ * batadv_dat_snoop_incoming_arp_request() - snoop the ARP request and try to
  * answer using the local DAT storage
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
@@ -1156,7 +1157,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_snoop_outgoing_arp_reply - snoop the ARP reply and fill the DHT
+ * batadv_dat_snoop_outgoing_arp_reply() - snoop the ARP reply and fill the DHT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  */
@@ -1196,8 +1197,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
- * DAT storage only
+ * batadv_dat_snoop_incoming_arp_reply() - snoop the ARP reply and fill the
+ *  local DAT storage only
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
@@ -1285,8 +1286,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_dat_drop_broadcast_packet - check if an ARP request has to be dropped
- * (because the node has already obtained the reply via DAT) or not
+ * batadv_dat_drop_broadcast_packet() - check if an ARP request has to be
+ *  dropped (because the node has already obtained the reply via DAT) or not
  * @bat_priv: the bat priv with all the soft interface information
  * @forw_packet: the broadcast packet
  *
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index beedd7d5531b..351de492430d 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -51,7 +51,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet);
 
 /**
- * batadv_dat_init_orig_node_addr - assign a DAT address to the orig_node
+ * batadv_dat_init_orig_node_addr() - assign a DAT address to the orig_node
  * @orig_node: the node to assign the DAT address to
  */
 static inline void
@@ -64,7 +64,7 @@ batadv_dat_init_orig_node_addr(struct batadv_orig_node *orig_node)
 }
 
 /**
- * batadv_dat_init_own_addr - assign a DAT address to the node itself
+ * batadv_dat_init_own_addr() - assign a DAT address to the node itself
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: a pointer to the primary interface
  */
@@ -85,7 +85,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
 
 /**
- * batadv_dat_inc_counter - increment the correct DAT packet counter
+ * batadv_dat_inc_counter() - increment the correct DAT packet counter
  * @bat_priv: the bat priv with all the soft interface information
  * @subtype: the 4addr subtype of the packet to be counted
  *
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 1c2024487eda..3890186b6f70 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -44,7 +44,7 @@
 #include "soft-interface.h"
 
 /**
- * batadv_frag_clear_chain - delete entries in the fragment buffer chain
+ * batadv_frag_clear_chain() - delete entries in the fragment buffer chain
  * @head: head of chain with entries.
  * @dropped: whether the chain is cleared because all fragments are dropped
  *
@@ -68,7 +68,7 @@ static void batadv_frag_clear_chain(struct hlist_head *head, bool dropped)
 }
 
 /**
- * batadv_frag_purge_orig - free fragments associated to an orig
+ * batadv_frag_purge_orig() - free fragments associated to an orig
  * @orig_node: originator to free fragments from
  * @check_cb: optional function to tell if an entry should be purged
  */
@@ -92,7 +92,7 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_frag_size_limit - maximum possible size of packet to be fragmented
+ * batadv_frag_size_limit() - maximum possible size of packet to be fragmented
  *
  * Return: the maximum size of payload that can be fragmented.
  */
@@ -107,7 +107,7 @@ static int batadv_frag_size_limit(void)
 }
 
 /**
- * batadv_frag_init_chain - check and prepare fragment chain for new fragment
+ * batadv_frag_init_chain() - check and prepare fragment chain for new fragment
  * @chain: chain in fragments table to init
  * @seqno: sequence number of the received fragment
  *
@@ -137,7 +137,7 @@ static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
 }
 
 /**
- * batadv_frag_insert_packet - insert a fragment into a fragment chain
+ * batadv_frag_insert_packet() - insert a fragment into a fragment chain
  * @orig_node: originator that the fragment was received from
  * @skb: skb to insert
  * @chain_out: list head to attach complete chains of fragments to
@@ -251,7 +251,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_frag_merge_packets - merge a chain of fragments
+ * batadv_frag_merge_packets() - merge a chain of fragments
  * @chain: head of chain with fragments
  *
  * Expand the first skb in the chain and copy the content of the remaining
@@ -309,7 +309,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 }
 
 /**
- * batadv_frag_skb_buffer - buffer fragment for later merge
+ * batadv_frag_skb_buffer() - buffer fragment for later merge
  * @skb: skb to buffer
  * @orig_node_src: originator that the skb is received from
  *
@@ -349,7 +349,7 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 }
 
 /**
- * batadv_frag_skb_fwd - forward fragments that would exceed MTU when merged
+ * batadv_frag_skb_fwd() - forward fragments that would exceed MTU when merged
  * @skb: skb to forward
  * @recv_if: interface that the skb is received on
  * @orig_node_src: originator that the skb is received from
@@ -403,7 +403,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 }
 
 /**
- * batadv_frag_create - create a fragment from skb
+ * batadv_frag_create() - create a fragment from skb
  * @skb: skb to create fragment from
  * @frag_head: header to use in new fragment
  * @fragment_size: size of new fragment
@@ -441,7 +441,7 @@ static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 }
 
 /**
- * batadv_frag_send_packet - create up to 16 fragments from the passed skb
+ * batadv_frag_send_packet() - create up to 16 fragments from the passed skb
  * @skb: skb to create fragments from
  * @orig_node: final destination of the created fragments
  * @neigh_node: next-hop of the created fragments
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index a2ed3b4755b5..db20be8b0fb9 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -42,7 +42,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 			    struct batadv_neigh_node *neigh_node);
 
 /**
- * batadv_frag_check_entry - check if a list of fragments has timed out
+ * batadv_frag_check_entry() - check if a list of fragments has timed out
  * @frags_entry: table entry to check
  *
  * Return: true if the frags entry has timed out, false otherwise.
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index cffa9e7f3665..9390da029868 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -71,8 +71,8 @@
 #define BATADV_DHCP_CHADDR_OFFSET	28
 
 /**
- * batadv_gw_node_release - release gw_node from lists and queue for free after
- *  rcu grace period
+ * batadv_gw_node_release() - release gw_node from lists and queue for free
+ *  after rcu grace period
  * @ref: kref pointer of the gw_node
  */
 static void batadv_gw_node_release(struct kref *ref)
@@ -86,7 +86,8 @@ static void batadv_gw_node_release(struct kref *ref)
 }
 
 /**
- * batadv_gw_node_put - decrement the gw_node refcounter and possibly release it
+ * batadv_gw_node_put() - decrement the gw_node refcounter and possibly release
+ *  it
  * @gw_node: gateway node to free
  */
 void batadv_gw_node_put(struct batadv_gw_node *gw_node)
@@ -158,7 +159,7 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_gw_reselect - force a gateway reselection
+ * batadv_gw_reselect() - force a gateway reselection
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Set a flag to remind the GW component to perform a new gateway reselection.
@@ -174,7 +175,7 @@ void batadv_gw_reselect(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_gw_check_client_stop - check if client mode has been switched off
+ * batadv_gw_check_client_stop() - check if client mode has been switched off
  * @bat_priv: the bat priv with all the soft interface information
  *
  * This function assumes the caller has checked that the gw state *is actually
@@ -324,7 +325,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_gw_node_add - add gateway node to list of available gateways
+ * batadv_gw_node_add() - add gateway node to list of available gateways
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
  * @gateway: announced bandwidth information
@@ -367,7 +368,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_gw_node_get - retrieve gateway node from list of available gateways
+ * batadv_gw_node_get() - retrieve gateway node from list of available gateways
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
  *
@@ -396,7 +397,7 @@ struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_gw_node_update - update list of available gateways with changed
+ * batadv_gw_node_update() - update list of available gateways with changed
  *  bandwidth information
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
@@ -517,7 +518,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_gw_dump - Dump gateways into a message
+ * batadv_gw_dump() - Dump gateways into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
  *
@@ -570,7 +571,7 @@ int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * batadv_gw_dhcp_recipient_get - check if a packet is a DHCP message
+ * batadv_gw_dhcp_recipient_get() - check if a packet is a DHCP message
  * @skb: the packet to check
  * @header_len: a pointer to the batman-adv header size
  * @chaddr: buffer where the client address will be stored. Valid
@@ -689,7 +690,8 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 }
 
 /**
- * batadv_gw_out_of_range - check if the dhcp request destination is the best gw
+ * batadv_gw_out_of_range() - check if the dhcp request destination is the best
+ *  gateway
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the outgoing packet
  *
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index ddef07afd999..e2d3a8a4df43 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -36,8 +36,8 @@
 #include "tvlv.h"
 
 /**
- * batadv_parse_throughput - parse supplied string buffer to extract throughput
- *  information
+ * batadv_parse_throughput() - parse supplied string buffer to extract
+ *  throughput information
  * @net_dev: the soft interface net device
  * @buff: string buffer to parse
  * @description: text shown when throughput string cannot be parsed
@@ -103,8 +103,8 @@ bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
 }
 
 /**
- * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
- *  and upload bandwidth information
+ * batadv_parse_gw_bandwidth() - parse supplied string buffer to extract
+ *  download and upload bandwidth information
  * @net_dev: the soft interface net device
  * @buff: string buffer to parse
  * @down: pointer holding the returned download bandwidth information
@@ -139,8 +139,8 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 }
 
 /**
- * batadv_gw_tvlv_container_update - update the gw tvlv container after gateway
- *  setting change
+ * batadv_gw_tvlv_container_update() - update the gw tvlv container after
+ *  gateway setting change
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
@@ -210,7 +210,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 }
 
 /**
- * batadv_gw_tvlv_ogm_handler_v1 - process incoming gateway tvlv container
+ * batadv_gw_tvlv_ogm_handler_v1() - process incoming gateway tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
@@ -251,7 +251,7 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_gw_init - initialise the gateway handling internals
+ * batadv_gw_init() - initialise the gateway handling internals
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_gw_init(struct batadv_priv *bat_priv)
@@ -267,7 +267,7 @@ void batadv_gw_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_gw_free - free the gateway handling internals
+ * batadv_gw_free() - free the gateway handling internals
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_gw_free(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 7f4596796c46..485fd1866d86 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -55,7 +55,7 @@
 #include "translation-table.h"
 
 /**
- * batadv_hardif_release - release hard interface from lists and queue for
+ * batadv_hardif_release() - release hard interface from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the hard interface
  */
@@ -89,7 +89,7 @@ batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 }
 
 /**
- * batadv_getlink_net - return link net namespace (of use fallback)
+ * batadv_getlink_net() - return link net namespace (of use fallback)
  * @netdev: net_device to check
  * @fallback_net: return in case get_link_net is not available for @netdev
  *
@@ -108,7 +108,7 @@ static struct net *batadv_getlink_net(const struct net_device *netdev,
 }
 
 /**
- * batadv_mutual_parents - check if two devices are each others parent
+ * batadv_mutual_parents() - check if two devices are each others parent
  * @dev1: 1st net dev
  * @net1: 1st devices netns
  * @dev2: 2nd net dev
@@ -141,7 +141,7 @@ static bool batadv_mutual_parents(const struct net_device *dev1,
 }
 
 /**
- * batadv_is_on_batman_iface - check if a device is a batman iface descendant
+ * batadv_is_on_batman_iface() - check if a device is a batman iface descendant
  * @net_dev: the device to check
  *
  * If the user creates any virtual device on top of a batman-adv interface, it
@@ -205,7 +205,7 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
 }
 
 /**
- * batadv_get_real_netdevice - check if the given netdev struct is a virtual
+ * batadv_get_real_netdevice() - check if the given netdev struct is a virtual
  *  interface on top of another 'real' interface
  * @netdev: the device to check
  *
@@ -249,7 +249,7 @@ static struct net_device *batadv_get_real_netdevice(struct net_device *netdev)
 }
 
 /**
- * batadv_get_real_netdev - check if the given net_device struct is a virtual
+ * batadv_get_real_netdev() - check if the given net_device struct is a virtual
  *  interface on top of another 'real' interface
  * @net_device: the device to check
  *
@@ -268,7 +268,7 @@ struct net_device *batadv_get_real_netdev(struct net_device *net_device)
 }
 
 /**
- * batadv_is_wext_netdev - check if the given net_device struct is a
+ * batadv_is_wext_netdev() - check if the given net_device struct is a
  *  wext wifi interface
  * @net_device: the device to check
  *
@@ -292,7 +292,7 @@ static bool batadv_is_wext_netdev(struct net_device *net_device)
 }
 
 /**
- * batadv_is_cfg80211_netdev - check if the given net_device struct is a
+ * batadv_is_cfg80211_netdev() - check if the given net_device struct is a
  *  cfg80211 wifi interface
  * @net_device: the device to check
  *
@@ -312,7 +312,7 @@ static bool batadv_is_cfg80211_netdev(struct net_device *net_device)
 }
 
 /**
- * batadv_wifi_flags_evaluate - calculate wifi flags for net_device
+ * batadv_wifi_flags_evaluate() - calculate wifi flags for net_device
  * @net_device: the device to check
  *
  * Return: batadv_hard_iface_wifi_flags flags of the device
@@ -347,7 +347,7 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 }
 
 /**
- * batadv_is_cfg80211_hardif - check if the given hardif is a cfg80211 wifi
+ * batadv_is_cfg80211_hardif() - check if the given hardif is a cfg80211 wifi
  *  interface
  * @hard_iface: the device to check
  *
@@ -365,7 +365,7 @@ bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_is_wifi_hardif - check if the given hardif is a wifi interface
+ * batadv_is_wifi_hardif() - check if the given hardif is a wifi interface
  * @hard_iface: the device to check
  *
  * Return: true if the net device is a 802.11 wireless device, false otherwise.
@@ -379,7 +379,7 @@ bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_hardif_no_broadcast - check whether (re)broadcast is necessary
+ * batadv_hardif_no_broadcast() - check whether (re)broadcast is necessary
  * @if_outgoing: the outgoing interface checked and considered for (re)broadcast
  * @orig_addr: the originator of this packet
  * @orig_neigh: originator address of the forwarder we just got the packet from
@@ -670,7 +670,7 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_master_del_slave - remove hard_iface from the current master interface
+ * batadv_master_del_slave() - remove hard_iface from the current master iface
  * @slave: the interface enslaved in another master
  * @master: the master from which slave has to be removed
  *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index d17606491d24..ba7b117c8926 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -85,7 +85,7 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh);
 
 /**
- * batadv_hardif_put - decrement the hard interface refcounter and possibly
+ * batadv_hardif_put() - decrement the hard interface refcounter and possibly
  *  release it
  * @hard_iface: the hard interface to free
  */
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 55819b20d316..7647757d3660 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -65,7 +65,7 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 void batadv_hash_destroy(struct batadv_hashtable *hash);
 
 /**
- *	batadv_hash_add - adds data to the hashtable
+ *	batadv_hash_add() - adds data to the hashtable
  *	@hash: storage hash table
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index f1a67eaaf5f5..49467746542a 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -337,7 +337,7 @@ int batadv_socket_setup(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_socket_add_packet - schedule an icmp packet to be sent to
+ * batadv_socket_add_packet() - schedule an icmp packet to be sent to
  *  userspace on an icmp socket.
  * @socket_client: the socket this packet belongs to
  * @icmph: pointer to the header of the icmp packet
@@ -394,7 +394,7 @@ static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 }
 
 /**
- * batadv_socket_receive_packet - schedule an icmp packet to be received
+ * batadv_socket_receive_packet() - schedule an icmp packet to be received
  *  locally and sent to userspace.
  * @icmph: pointer to the header of the icmp packet
  * @icmp_len: total length of the icmp packet
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 107b50e5ecc2..b8fe7305d32a 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -258,8 +258,8 @@ void batadv_mesh_free(struct net_device *soft_iface)
 }
 
 /**
- * batadv_is_my_mac - check if the given mac address belongs to any of the real
- * interfaces in the current mesh
+ * batadv_is_my_mac() - check if the given mac address belongs to any of the
+ *  real interfaces in the current mesh
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address to check
  *
@@ -289,7 +289,7 @@ bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_seq_print_text_primary_if_get - called from debugfs table printing
+ * batadv_seq_print_text_primary_if_get() - called from debugfs table printing
  *  function that requires the primary interface
  * @seq: debugfs table seq_file struct
  *
@@ -326,7 +326,7 @@ batadv_seq_print_text_primary_if_get(struct seq_file *seq)
 #endif
 
 /**
- * batadv_max_header_len - calculate maximum encapsulation overhead for a
+ * batadv_max_header_len() - calculate maximum encapsulation overhead for a
  *  payload packet
  *
  * Return: the maximum encapsulation overhead in bytes.
@@ -351,7 +351,7 @@ int batadv_max_header_len(void)
 }
 
 /**
- * batadv_skb_set_priority - sets skb priority according to packet content
+ * batadv_skb_set_priority() - sets skb priority according to packet content
  * @skb: the packet to be sent
  * @offset: offset to the packet content
  *
@@ -561,7 +561,7 @@ void batadv_recv_handler_unregister(u8 packet_type)
 }
 
 /**
- * batadv_skb_crc32 - calculate CRC32 of the whole packet and skip bytes in
+ * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
  *  the header
  * @skb: skb pointing to fragmented socket buffers
  * @payload_ptr: Pointer to position inside the head buffer of the skb
@@ -594,7 +594,7 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 }
 
 /**
- * batadv_get_vid - extract the VLAN identifier from skb if any
+ * batadv_get_vid() - extract the VLAN identifier from skb if any
  * @skb: the buffer containing the packet
  * @header_len: length of the batman header preceding the ethernet header
  *
@@ -621,7 +621,7 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
 }
 
 /**
- * batadv_vlan_ap_isola_get - return the AP isolation status for the given vlan
+ * batadv_vlan_ap_isola_get() - return AP isolation status for the given vlan
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier for which the AP isolation attributed as to be
  *  looked up
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 34acfd1f96f4..63b3ee0bbc40 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -205,7 +205,7 @@ struct seq_file;
 struct sk_buff;
 
 /**
- * batadv_print_vid - return printable version of vid information
+ * batadv_print_vid() - return printable version of vid information
  * @vid: the VLAN identifier
  *
  * Return: -1 when no VLAN is used, VLAN id otherwise
@@ -241,7 +241,7 @@ void batadv_recv_handler_unregister(u8 packet_type);
 __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
- * batadv_compare_eth - Compare two not u16 aligned Ethernet addresses
+ * batadv_compare_eth() - Compare two not u16 aligned Ethernet addresses
  * @data1: Pointer to a six-byte array containing the Ethernet address
  * @data2: Pointer other six-byte array containing the Ethernet address
  *
@@ -255,7 +255,7 @@ static inline bool batadv_compare_eth(const void *data1, const void *data2)
 }
 
 /**
- * batadv_has_timed_out - compares current time (jiffies) and timestamp +
+ * batadv_has_timed_out() - compares current time (jiffies) and timestamp +
  *  timeout
  * @timestamp:		base value to compare with (in jiffies)
  * @timeout:		added to base value before comparing (in milliseconds)
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 30c442e42d6f..2bda4540466d 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -68,7 +68,7 @@
 static void batadv_mcast_mla_update(struct work_struct *work);
 
 /**
- * batadv_mcast_start_timer - schedule the multicast periodic worker
+ * batadv_mcast_start_timer() - schedule the multicast periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
@@ -78,7 +78,7 @@ static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_get_bridge - get the bridge on top of the softif if it exists
+ * batadv_mcast_get_bridge() - get the bridge on top of the softif if it exists
  * @soft_iface: netdev struct of the mesh interface
  *
  * If the given soft interface has a bridge on top then the refcount
@@ -104,7 +104,7 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
 }
 
 /**
- * batadv_mcast_mla_softif_get - get softif multicast listeners
+ * batadv_mcast_mla_softif_get() - get softif multicast listeners
  * @dev: the device to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  *
@@ -150,7 +150,7 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
 }
 
 /**
- * batadv_mcast_mla_is_duplicate - check whether an address is in a list
+ * batadv_mcast_mla_is_duplicate() - check whether an address is in a list
  * @mcast_addr: the multicast address to check
  * @mcast_list: the list with multicast addresses to search in
  *
@@ -170,7 +170,7 @@ static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
 }
 
 /**
- * batadv_mcast_mla_br_addr_cpy - copy a bridge multicast address
+ * batadv_mcast_mla_br_addr_cpy() - copy a bridge multicast address
  * @dst: destination to write to - a multicast MAC address
  * @src: source to read from - a multicast IP address
  *
@@ -194,7 +194,7 @@ static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
 }
 
 /**
- * batadv_mcast_mla_bridge_get - get bridged-in multicast listeners
+ * batadv_mcast_mla_bridge_get() - get bridged-in multicast listeners
  * @dev: a bridge slave whose bridge to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  *
@@ -247,7 +247,7 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 }
 
 /**
- * batadv_mcast_mla_list_free - free a list of multicast addresses
+ * batadv_mcast_mla_list_free() - free a list of multicast addresses
  * @mcast_list: the list to free
  *
  * Removes and frees all items in the given mcast_list.
@@ -264,7 +264,7 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
 }
 
 /**
- * batadv_mcast_mla_tt_retract - clean up multicast listener announcements
+ * batadv_mcast_mla_tt_retract() - clean up multicast listener announcements
  * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: a list of addresses which should _not_ be removed
  *
@@ -300,7 +300,7 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_mla_tt_add - add multicast listener announcements
+ * batadv_mcast_mla_tt_add() - add multicast listener announcements
  * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: a list of addresses which are going to get added
  *
@@ -336,7 +336,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_has_bridge - check whether the soft-iface is bridged
+ * batadv_mcast_has_bridge() - check whether the soft-iface is bridged
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Checks whether there is a bridge on top of our soft interface.
@@ -357,7 +357,8 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_querier_log - debug output regarding the querier status on link
+ * batadv_mcast_querier_log() - debug output regarding the querier status on
+ *  link
  * @bat_priv: the bat priv with all the soft interface information
  * @str_proto: a string for the querier protocol (e.g. "IGMP" or "MLD")
  * @old_state: the previous querier state on our link
@@ -408,7 +409,8 @@ batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 }
 
 /**
- * batadv_mcast_bridge_log - debug output for topology changes in bridged setups
+ * batadv_mcast_bridge_log() - debug output for topology changes in bridged
+ *  setups
  * @bat_priv: the bat priv with all the soft interface information
  * @bridged: a flag about whether the soft interface is currently bridged or not
  * @querier_ipv4: (maybe) new status of a potential, selected IGMP querier
@@ -447,7 +449,7 @@ batadv_mcast_bridge_log(struct batadv_priv *bat_priv, bool bridged,
 }
 
 /**
- * batadv_mcast_flags_logs - output debug information about mcast flag changes
+ * batadv_mcast_flags_logs() - output debug information about mcast flag changes
  * @bat_priv: the bat priv with all the soft interface information
  * @flags: flags indicating the new multicast state
  *
@@ -473,7 +475,7 @@ static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
 }
 
 /**
- * batadv_mcast_mla_tvlv_update - update multicast tvlv
+ * batadv_mcast_mla_tvlv_update() - update multicast tvlv
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Updates the own multicast tvlv with our current multicast related settings,
@@ -548,7 +550,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 }
 
 /**
- * __batadv_mcast_mla_update - update the own MLAs
+ * __batadv_mcast_mla_update() - update the own MLAs
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Updates the own multicast listener announcements in the translation
@@ -585,7 +587,7 @@ static void __batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_mla_update - update the own MLAs
+ * batadv_mcast_mla_update() - update the own MLAs
  * @work: kernel work struct
  *
  * Updates the own multicast listener announcements in the translation
@@ -608,7 +610,7 @@ static void batadv_mcast_mla_update(struct work_struct *work)
 }
 
 /**
- * batadv_mcast_is_report_ipv4 - check for IGMP reports
+ * batadv_mcast_is_report_ipv4() - check for IGMP reports
  * @skb: the ethernet frame destined for the mesh
  *
  * This call might reallocate skb data.
@@ -633,7 +635,8 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
 }
 
 /**
- * batadv_mcast_forw_mode_check_ipv4 - check for optimized forwarding potential
+ * batadv_mcast_forw_mode_check_ipv4() - check for optimized forwarding
+ *  potential
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
@@ -674,7 +677,7 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_is_report_ipv6 - check for MLD reports
+ * batadv_mcast_is_report_ipv6() - check for MLD reports
  * @skb: the ethernet frame destined for the mesh
  *
  * This call might reallocate skb data.
@@ -698,7 +701,8 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
 }
 
 /**
- * batadv_mcast_forw_mode_check_ipv6 - check for optimized forwarding potential
+ * batadv_mcast_forw_mode_check_ipv6() - check for optimized forwarding
+ *  potential
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
@@ -739,7 +743,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_forw_mode_check - check for optimized forwarding potential
+ * batadv_mcast_forw_mode_check() - check for optimized forwarding potential
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
@@ -777,7 +781,7 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_forw_want_all_ip_count - count nodes with unspecific mcast
+ * batadv_mcast_forw_want_all_ip_count() - count nodes with unspecific mcast
  *  interest
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: ethernet header of a packet
@@ -801,7 +805,7 @@ static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_forw_tt_node_get - get a multicast tt node
+ * batadv_mcast_forw_tt_node_get() - get a multicast tt node
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the ether header containing the multicast destination
  *
@@ -817,7 +821,7 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_forw_ipv4_node_get - get a node with an ipv4 flag
+ * batadv_mcast_forw_ipv4_node_get() - get a node with an ipv4 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set and
@@ -844,7 +848,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_forw_ipv6_node_get - get a node with an ipv6 flag
+ * batadv_mcast_forw_ipv6_node_get() - get a node with an ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
@@ -871,7 +875,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_forw_ip_node_get - get a node with an ipv4/ipv6 flag
+ * batadv_mcast_forw_ip_node_get() - get a node with an ipv4/ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: an ethernet header to determine the protocol family from
  *
@@ -895,7 +899,7 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_forw_unsnoop_node_get - get a node with an unsnoopable flag
+ * batadv_mcast_forw_unsnoop_node_get() - get a node with an unsnoopable flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag
@@ -922,7 +926,7 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_forw_mode - check on how to forward a multicast packet
+ * batadv_mcast_forw_mode() - check on how to forward a multicast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: The multicast packet to check
  * @orig: an originator to be set to forward the skb to
@@ -976,7 +980,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 }
 
 /**
- * batadv_mcast_want_unsnoop_update - update unsnoop counter and list
+ * batadv_mcast_want_unsnoop_update() - update unsnoop counter and list
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
@@ -1021,7 +1025,7 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_want_ipv4_update - update want-all-ipv4 counter and list
+ * batadv_mcast_want_ipv4_update() - update want-all-ipv4 counter and list
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
@@ -1066,7 +1070,7 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_want_ipv6_update - update want-all-ipv6 counter and list
+ * batadv_mcast_want_ipv6_update() - update want-all-ipv6 counter and list
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
@@ -1111,7 +1115,7 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_tvlv_ogm_handler - process incoming multicast tvlv container
+ * batadv_mcast_tvlv_ogm_handler() - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
@@ -1167,7 +1171,7 @@ static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_init - initialize the multicast optimizations structures
+ * batadv_mcast_init() - initialize the multicast optimizations structures
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_mcast_init(struct batadv_priv *bat_priv)
@@ -1182,7 +1186,7 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_mcast_flags_print_header - print own mcast flags to debugfs table
+ * batadv_mcast_flags_print_header() - print own mcast flags to debugfs table
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: debugfs table seq_file struct
  *
@@ -1223,7 +1227,7 @@ static void batadv_mcast_flags_print_header(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_flags_seq_print_text - print the mcast flags of other nodes
+ * batadv_mcast_flags_seq_print_text() - print the mcast flags of other nodes
  * @seq: seq file to print on
  * @offset: not used
  *
@@ -1284,7 +1288,7 @@ int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_mcast_free - free the multicast optimizations structures
+ * batadv_mcast_free() - free the multicast optimizations structures
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
@@ -1299,7 +1303,7 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_purge_orig - reset originator global mcast state modifications
+ * batadv_mcast_purge_orig() - reset originator global mcast state modifications
  * @orig: the originator which is going to get purged
  */
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a06a2cd4d4e6..a68443d3f119 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -102,7 +102,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 };
 
 /**
- * batadv_netlink_get_ifindex - Extract an interface index from a message
+ * batadv_netlink_get_ifindex() - Extract an interface index from a message
  * @nlh: Message header
  * @attrtype: Attribute which holds an interface index
  *
@@ -117,7 +117,7 @@ batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 }
 
 /**
- * batadv_netlink_mesh_info_put - fill in generic information about mesh
+ * batadv_netlink_mesh_info_put() - fill in generic information about mesh
  *  interface
  * @msg: netlink message to be sent back
  * @soft_iface: interface for which the data should be taken
@@ -172,7 +172,7 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 }
 
 /**
- * batadv_netlink_get_mesh_info - handle incoming BATADV_CMD_GET_MESH_INFO
+ * batadv_netlink_get_mesh_info() - handle incoming BATADV_CMD_GET_MESH_INFO
  *  netlink request
  * @skb: received netlink message
  * @info: receiver information
@@ -233,7 +233,7 @@ batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_tp_meter_put - Fill information of started tp_meter session
+ * batadv_netlink_tp_meter_put() - Fill information of started tp_meter session
  * @msg: netlink message to be sent back
  * @cookie: tp meter session cookie
  *
@@ -249,7 +249,7 @@ batadv_netlink_tp_meter_put(struct sk_buff *msg, u32 cookie)
 }
 
 /**
- * batadv_netlink_tpmeter_notify - send tp_meter result via netlink to client
+ * batadv_netlink_tpmeter_notify() - send tp_meter result via netlink to client
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: destination of tp_meter session
  * @result: reason for tp meter session stop
@@ -312,7 +312,7 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_netlink_tp_meter_start - Start a new tp_meter session
+ * batadv_netlink_tp_meter_start() - Start a new tp_meter session
  * @skb: received netlink message
  * @info: receiver information
  *
@@ -389,7 +389,7 @@ batadv_netlink_tp_meter_start(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_tp_meter_start - Cancel a running tp_meter session
+ * batadv_netlink_tp_meter_start() - Cancel a running tp_meter session
  * @skb: received netlink message
  * @info: receiver information
  *
@@ -434,7 +434,7 @@ batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_dump_hardif_entry - Dump one hard interface into a message
+ * batadv_netlink_dump_hardif_entry() - Dump one hard interface into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -476,7 +476,7 @@ batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_netlink_dump_hardifs - Dump all hard interface into a messages
+ * batadv_netlink_dump_hardifs() - Dump all hard interface into a messages
  * @msg: Netlink message to dump into
  * @cb: Parameters from query
  *
@@ -623,7 +623,7 @@ struct genl_family batadv_netlink_family __ro_after_init = {
 };
 
 /**
- * batadv_netlink_register - register batadv genl netlink family
+ * batadv_netlink_register() - register batadv genl netlink family
  */
 void __init batadv_netlink_register(void)
 {
@@ -635,7 +635,7 @@ void __init batadv_netlink_register(void)
 }
 
 /**
- * batadv_netlink_unregister - unregister batadv genl netlink family
+ * batadv_netlink_unregister() - unregister batadv genl netlink family
  */
 void batadv_netlink_unregister(void)
 {
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 64f14f66a56b..aea92d09d7e8 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -69,7 +69,7 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
 /**
- * batadv_nc_init - one-time initialization for network coding
+ * batadv_nc_init() - one-time initialization for network coding
  *
  * Return: 0 on success or negative error number in case of failure
  */
@@ -85,7 +85,7 @@ int __init batadv_nc_init(void)
 }
 
 /**
- * batadv_nc_start_timer - initialise the nc periodic worker
+ * batadv_nc_start_timer() - initialise the nc periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
@@ -95,7 +95,7 @@ static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_nc_tvlv_container_update - update the network coding tvlv container
+ * batadv_nc_tvlv_container_update() - update the network coding tvlv container
  *  after network coding setting change
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -117,7 +117,7 @@ static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_nc_status_update - update the network coding tvlv container after
+ * batadv_nc_status_update() - update the network coding tvlv container after
  *  network coding setting change
  * @net_dev: the soft interface net device
  */
@@ -129,7 +129,7 @@ void batadv_nc_status_update(struct net_device *net_dev)
 }
 
 /**
- * batadv_nc_tvlv_ogm_handler_v1 - process incoming nc tvlv container
+ * batadv_nc_tvlv_ogm_handler_v1() - process incoming nc tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
@@ -148,7 +148,7 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_mesh_init - initialise coding hash table and start house keeping
+ * batadv_nc_mesh_init() - initialise coding hash table and start house keeping
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 on success or negative error number in case of failure
@@ -189,7 +189,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_nc_init_bat_priv - initialise the nc specific bat_priv variables
+ * batadv_nc_init_bat_priv() - initialise the nc specific bat_priv variables
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
@@ -201,7 +201,7 @@ void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_nc_init_orig - initialise the nc fields of an orig_node
+ * batadv_nc_init_orig() - initialise the nc fields of an orig_node
  * @orig_node: the orig_node which is going to be initialised
  */
 void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
@@ -213,8 +213,8 @@ void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 }
 
 /**
- * batadv_nc_node_release - release nc_node from lists and queue for free after
- *  rcu grace period
+ * batadv_nc_node_release() - release nc_node from lists and queue for free
+ *  after rcu grace period
  * @ref: kref pointer of the nc_node
  */
 static void batadv_nc_node_release(struct kref *ref)
@@ -228,7 +228,7 @@ static void batadv_nc_node_release(struct kref *ref)
 }
 
 /**
- * batadv_nc_node_put - decrement the nc_node refcounter and possibly
+ * batadv_nc_node_put() - decrement the nc_node refcounter and possibly
  *  release it
  * @nc_node: nc_node to be free'd
  */
@@ -238,8 +238,8 @@ static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
 }
 
 /**
- * batadv_nc_path_release - release nc_path from lists and queue for free after
- *  rcu grace period
+ * batadv_nc_path_release() - release nc_path from lists and queue for free
+ *  after rcu grace period
  * @ref: kref pointer of the nc_path
  */
 static void batadv_nc_path_release(struct kref *ref)
@@ -252,7 +252,7 @@ static void batadv_nc_path_release(struct kref *ref)
 }
 
 /**
- * batadv_nc_path_put - decrement the nc_path refcounter and possibly
+ * batadv_nc_path_put() - decrement the nc_path refcounter and possibly
  *  release it
  * @nc_path: nc_path to be free'd
  */
@@ -262,7 +262,7 @@ static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
 }
 
 /**
- * batadv_nc_packet_free - frees nc packet
+ * batadv_nc_packet_free() - frees nc packet
  * @nc_packet: the nc packet to free
  * @dropped: whether the packet is freed because is is dropped
  */
@@ -279,7 +279,7 @@ static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet,
 }
 
 /**
- * batadv_nc_to_purge_nc_node - checks whether an nc node has to be purged
+ * batadv_nc_to_purge_nc_node() - checks whether an nc node has to be purged
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_node: the nc node to check
  *
@@ -295,7 +295,7 @@ static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_to_purge_nc_path_coding - checks whether an nc path has timed out
+ * batadv_nc_to_purge_nc_path_coding() - checks whether an nc path has timed out
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path to check
  *
@@ -315,7 +315,8 @@ static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_to_purge_nc_path_decoding - checks whether an nc path has timed out
+ * batadv_nc_to_purge_nc_path_decoding() - checks whether an nc path has timed
+ *  out
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path to check
  *
@@ -335,7 +336,7 @@ static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_purge_orig_nc_nodes - go through list of nc nodes and purge stale
+ * batadv_nc_purge_orig_nc_nodes() - go through list of nc nodes and purge stale
  *  entries
  * @bat_priv: the bat priv with all the soft interface information
  * @list: list of nc nodes
@@ -373,7 +374,7 @@ batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_purge_orig - purges all nc node data attached of the given
+ * batadv_nc_purge_orig() - purges all nc node data attached of the given
  *  originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig_node with the nc node entries to be purged
@@ -399,8 +400,8 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_purge_orig_hash - traverse entire originator hash to check if they
- *  have timed out nc nodes
+ * batadv_nc_purge_orig_hash() - traverse entire originator hash to check if
+ *  they have timed out nc nodes
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
@@ -426,7 +427,7 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_nc_purge_paths - traverse all nc paths part of the hash and remove
+ * batadv_nc_purge_paths() - traverse all nc paths part of the hash and remove
  *  unused ones
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the nc paths to check
@@ -485,7 +486,7 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_hash_key_gen - computes the nc_path hash key
+ * batadv_nc_hash_key_gen() - computes the nc_path hash key
  * @key: buffer to hold the final hash key
  * @src: source ethernet mac address going into the hash key
  * @dst: destination ethernet mac address going into the hash key
@@ -498,7 +499,7 @@ static void batadv_nc_hash_key_gen(struct batadv_nc_path *key, const char *src,
 }
 
 /**
- * batadv_nc_hash_choose - compute the hash value for an nc path
+ * batadv_nc_hash_choose() - compute the hash value for an nc path
  * @data: data to hash
  * @size: size of the hash table
  *
@@ -516,7 +517,7 @@ static u32 batadv_nc_hash_choose(const void *data, u32 size)
 }
 
 /**
- * batadv_nc_hash_compare - comparing function used in the network coding hash
+ * batadv_nc_hash_compare() - comparing function used in the network coding hash
  *  tables
  * @node: node in the local table
  * @data2: second object to compare the node to
@@ -542,7 +543,7 @@ static bool batadv_nc_hash_compare(const struct hlist_node *node,
 }
 
 /**
- * batadv_nc_hash_find - search for an existing nc path and return it
+ * batadv_nc_hash_find() - search for an existing nc path and return it
  * @hash: hash table containing the nc path
  * @data: search key
  *
@@ -579,7 +580,7 @@ batadv_nc_hash_find(struct batadv_hashtable *hash,
 }
 
 /**
- * batadv_nc_send_packet - send non-coded packet and free nc_packet struct
+ * batadv_nc_send_packet() - send non-coded packet and free nc_packet struct
  * @nc_packet: the nc packet to send
  */
 static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
@@ -590,7 +591,7 @@ static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
 }
 
 /**
- * batadv_nc_sniffed_purge - Checks timestamp of given sniffed nc_packet.
+ * batadv_nc_sniffed_purge() - Checks timestamp of given sniffed nc_packet.
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path the packet belongs to
  * @nc_packet: the nc packet to be checked
@@ -629,7 +630,7 @@ static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_fwd_flush - Checks the timestamp of the given nc packet.
+ * batadv_nc_fwd_flush() - Checks the timestamp of the given nc packet.
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path the packet belongs to
  * @nc_packet: the nc packet to be checked
@@ -667,8 +668,8 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_process_nc_paths - traverse given nc packet pool and free timed out
- *  nc packets
+ * batadv_nc_process_nc_paths() - traverse given nc packet pool and free timed
+ *  out nc packets
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: to be processed hash table
  * @process_fn: Function called to process given nc packet. Should return true
@@ -713,7 +714,8 @@ batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_worker - periodic task for house keeping related to network coding
+ * batadv_nc_worker() - periodic task for house keeping related to network
+ *  coding
  * @work: kernel work struct
  */
 static void batadv_nc_worker(struct work_struct *work)
@@ -753,8 +755,8 @@ static void batadv_nc_worker(struct work_struct *work)
 }
 
 /**
- * batadv_can_nc_with_orig - checks whether the given orig node is suitable for
- *  coding or not
+ * batadv_can_nc_with_orig() - checks whether the given orig node is suitable
+ *  for coding or not
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: neighboring orig node which may be used as nc candidate
  * @ogm_packet: incoming ogm packet also used for the checks
@@ -794,7 +796,7 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_find_nc_node - search for an existing nc node and return it
+ * batadv_nc_find_nc_node() - search for an existing nc node and return it
  * @orig_node: orig node originating the ogm packet
  * @orig_neigh_node: neighboring orig node from which we received the ogm packet
  *  (can be equal to orig_node)
@@ -834,7 +836,7 @@ batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_nc_get_nc_node - retrieves an nc node or creates the entry if it was
+ * batadv_nc_get_nc_node() - retrieves an nc node or creates the entry if it was
  *  not found
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node originating the ogm packet
@@ -894,7 +896,7 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_update_nc_node - updates stored incoming and outgoing nc node
+ * batadv_nc_update_nc_node() - updates stored incoming and outgoing nc node
  *  structs (best called on incoming OGMs)
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node originating the ogm packet
@@ -949,7 +951,7 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_get_path - get existing nc_path or allocate a new one
+ * batadv_nc_get_path() - get existing nc_path or allocate a new one
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the nc path
  * @src: ethernet source address - first half of the nc path search key
@@ -1010,7 +1012,7 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_random_weight_tq - scale the receivers TQ-value to avoid unfair
+ * batadv_nc_random_weight_tq() - scale the receivers TQ-value to avoid unfair
  *  selection of a receiver with slightly lower TQ than the other
  * @tq: to be weighted tq value
  *
@@ -1033,7 +1035,7 @@ static u8 batadv_nc_random_weight_tq(u8 tq)
 }
 
 /**
- * batadv_nc_memxor - XOR destination with source
+ * batadv_nc_memxor() - XOR destination with source
  * @dst: byte array to XOR into
  * @src: byte array to XOR from
  * @len: length of destination array
@@ -1047,7 +1049,7 @@ static void batadv_nc_memxor(char *dst, const char *src, unsigned int len)
 }
 
 /**
- * batadv_nc_code_packets - code a received unicast_packet with an nc packet
+ * batadv_nc_code_packets() - code a received unicast_packet with an nc packet
  *  into a coded_packet and send it
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: data skb to forward
@@ -1240,7 +1242,7 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_skb_coding_possible - true if a decoded skb is available at dst.
+ * batadv_nc_skb_coding_possible() - true if a decoded skb is available at dst.
  * @skb: data skb to forward
  * @dst: destination mac address of the other skb to code with
  * @src: source mac address of skb
@@ -1264,7 +1266,7 @@ static bool batadv_nc_skb_coding_possible(struct sk_buff *skb, u8 *dst, u8 *src)
 }
 
 /**
- * batadv_nc_path_search - Find the coding path matching in_nc_node and
+ * batadv_nc_path_search() - Find the coding path matching in_nc_node and
  *  out_nc_node to retrieve a buffered packet that can be used for coding.
  * @bat_priv: the bat priv with all the soft interface information
  * @in_nc_node: pointer to skb next hop's neighbor nc node
@@ -1332,8 +1334,8 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_skb_src_search - Loops through the list of neighoring nodes of the
- *  skb's sender (may be equal to the originator).
+ * batadv_nc_skb_src_search() - Loops through the list of neighoring nodes of
+ *  the skb's sender (may be equal to the originator).
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: data skb to forward
  * @eth_dst: next hop mac address of skb
@@ -1378,7 +1380,7 @@ batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_skb_store_before_coding - set the ethernet src and dst of the
+ * batadv_nc_skb_store_before_coding() - set the ethernet src and dst of the
  *  unicast skb before it is stored for use in later decoding
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: data skb to store
@@ -1413,7 +1415,7 @@ static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_skb_dst_search - Loops through list of neighboring nodes to dst.
+ * batadv_nc_skb_dst_search() - Loops through list of neighboring nodes to dst.
  * @skb: data skb to forward
  * @neigh_node: next hop to forward packet to
  * @ethhdr: pointer to the ethernet header inside the skb
@@ -1471,7 +1473,7 @@ static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
 }
 
 /**
- * batadv_nc_skb_add_to_path - buffer skb for later encoding / decoding
+ * batadv_nc_skb_add_to_path() - buffer skb for later encoding / decoding
  * @skb: skb to add to path
  * @nc_path: path to add skb to
  * @neigh_node: next hop to forward packet to
@@ -1506,7 +1508,7 @@ static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
 }
 
 /**
- * batadv_nc_skb_forward - try to code a packet or add it to the coding packet
+ * batadv_nc_skb_forward() - try to code a packet or add it to the coding packet
  *  buffer
  * @skb: data skb to forward
  * @neigh_node: next hop to forward packet to
@@ -1563,8 +1565,8 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 }
 
 /**
- * batadv_nc_skb_store_for_decoding - save a clone of the skb which can be used
- *  when decoding coded packets
+ * batadv_nc_skb_store_for_decoding() - save a clone of the skb which can be
+ *  used when decoding coded packets
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: data skb to store
  */
@@ -1624,7 +1626,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_skb_store_sniffed_unicast - check if a received unicast packet
+ * batadv_nc_skb_store_sniffed_unicast() - check if a received unicast packet
  *  should be saved in the decoding buffer and, if so, store it there
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: unicast skb to store
@@ -1644,7 +1646,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_skb_decode_packet - decode given skb using the decode data stored
+ * batadv_nc_skb_decode_packet() - decode given skb using the decode data stored
  *  in nc_packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: unicast skb to decode
@@ -1738,7 +1740,7 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 }
 
 /**
- * batadv_nc_find_decoding_packet - search through buffered decoding data to
+ * batadv_nc_find_decoding_packet() - search through buffered decoding data to
  *  find the data needed to decode the coded packet
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: pointer to the ethernet header inside the coded packet
@@ -1803,7 +1805,7 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_nc_recv_coded_packet - try to decode coded packet and enqueue the
+ * batadv_nc_recv_coded_packet() - try to decode coded packet and enqueue the
  *  resulting unicast packet
  * @skb: incoming coded packet
  * @recv_if: pointer to interface this packet was received on
@@ -1878,7 +1880,7 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 }
 
 /**
- * batadv_nc_mesh_free - clean up network coding memory
+ * batadv_nc_mesh_free() - clean up network coding memory
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
@@ -1895,7 +1897,7 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_nc_nodes_seq_print_text - print the nc node information
+ * batadv_nc_nodes_seq_print_text() - print the nc node information
  * @seq: seq file to print on
  * @offset: not used
  *
@@ -1958,7 +1960,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 }
 
 /**
- * batadv_nc_init_debugfs - create nc folder and related files in debugfs
+ * batadv_nc_init_debugfs() - create nc folder and related files in debugfs
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 on success or negative error number in case of failure
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index beb168b148d7..1e3f9a34df90 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -93,7 +93,7 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 static void batadv_purge_orig(struct work_struct *work);
 
 /**
- * batadv_compare_orig - comparing function used in the originator hash table
+ * batadv_compare_orig() - comparing function used in the originator hash table
  * @node: node in the local table
  * @data2: second object to compare the node to
  *
@@ -108,7 +108,7 @@ bool batadv_compare_orig(const struct hlist_node *node, const void *data2)
 }
 
 /**
- * batadv_orig_node_vlan_get - get an orig_node_vlan object
+ * batadv_orig_node_vlan_get() - get an orig_node_vlan object
  * @orig_node: the originator serving the VLAN
  * @vid: the VLAN identifier
  *
@@ -139,7 +139,7 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_orig_node_vlan_new - search and possibly create an orig_node_vlan
+ * batadv_orig_node_vlan_new() - search and possibly create an orig_node_vlan
  *  object
  * @orig_node: the originator serving the VLAN
  * @vid: the VLAN identifier
@@ -180,7 +180,7 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_orig_node_vlan_release - release originator-vlan object from lists
+ * batadv_orig_node_vlan_release() - release originator-vlan object from lists
  *  and queue for free after rcu grace period
  * @ref: kref pointer of the originator-vlan object
  */
@@ -194,7 +194,7 @@ static void batadv_orig_node_vlan_release(struct kref *ref)
 }
 
 /**
- * batadv_orig_node_vlan_put - decrement the refcounter and possibly release
+ * batadv_orig_node_vlan_put() - decrement the refcounter and possibly release
  *  the originator-vlan object
  * @orig_vlan: the originator-vlan object to release
  */
@@ -228,7 +228,7 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_neigh_ifinfo_release - release neigh_ifinfo from lists and queue for
+ * batadv_neigh_ifinfo_release() - release neigh_ifinfo from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the neigh_ifinfo
  */
@@ -245,7 +245,7 @@ static void batadv_neigh_ifinfo_release(struct kref *ref)
 }
 
 /**
- * batadv_neigh_ifinfo_put - decrement the refcounter and possibly release
+ * batadv_neigh_ifinfo_put() - decrement the refcounter and possibly release
  *  the neigh_ifinfo
  * @neigh_ifinfo: the neigh_ifinfo object to release
  */
@@ -255,7 +255,7 @@ void batadv_neigh_ifinfo_put(struct batadv_neigh_ifinfo *neigh_ifinfo)
 }
 
 /**
- * batadv_hardif_neigh_release - release hardif neigh node from lists and
+ * batadv_hardif_neigh_release() - release hardif neigh node from lists and
  *  queue for free after rcu grace period
  * @ref: kref pointer of the neigh_node
  */
@@ -275,7 +275,7 @@ static void batadv_hardif_neigh_release(struct kref *ref)
 }
 
 /**
- * batadv_hardif_neigh_put - decrement the hardif neighbors refcounter
+ * batadv_hardif_neigh_put() - decrement the hardif neighbors refcounter
  *  and possibly release it
  * @hardif_neigh: hardif neigh neighbor to free
  */
@@ -285,7 +285,7 @@ void batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh)
 }
 
 /**
- * batadv_neigh_node_release - release neigh_node from lists and queue for
+ * batadv_neigh_node_release() - release neigh_node from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the neigh_node
  */
@@ -310,7 +310,7 @@ static void batadv_neigh_node_release(struct kref *ref)
 }
 
 /**
- * batadv_neigh_node_put - decrement the neighbors refcounter and possibly
+ * batadv_neigh_node_put() - decrement the neighbors refcounter and possibly
  *  release it
  * @neigh_node: neigh neighbor to free
  */
@@ -320,7 +320,7 @@ void batadv_neigh_node_put(struct batadv_neigh_node *neigh_node)
 }
 
 /**
- * batadv_orig_router_get - router to the originator depending on iface
+ * batadv_orig_router_get() - router to the originator depending on iface
  * @orig_node: the orig node for the router
  * @if_outgoing: the interface where the payload packet has been received or
  *  the OGM should be sent to
@@ -353,7 +353,7 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_orig_ifinfo_get - find the ifinfo from an orig_node
+ * batadv_orig_ifinfo_get() - find the ifinfo from an orig_node
  * @orig_node: the orig node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
@@ -385,7 +385,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_orig_ifinfo_new - search and possibly create an orig_ifinfo object
+ * batadv_orig_ifinfo_new() - search and possibly create an orig_ifinfo object
  * @orig_node: the orig node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
@@ -431,7 +431,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_neigh_ifinfo_get - find the ifinfo from an neigh_node
+ * batadv_neigh_ifinfo_get() - find the ifinfo from an neigh_node
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
@@ -464,7 +464,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 }
 
 /**
- * batadv_neigh_ifinfo_new - search and possibly create an neigh_ifinfo object
+ * batadv_neigh_ifinfo_new() - search and possibly create an neigh_ifinfo object
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
@@ -507,7 +507,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 }
 
 /**
- * batadv_neigh_node_get - retrieve a neighbour from the list
+ * batadv_neigh_node_get() - retrieve a neighbour from the list
  * @orig_node: originator which the neighbour belongs to
  * @hard_iface: the interface where this neighbour is connected to
  * @addr: the address of the neighbour
@@ -544,7 +544,7 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_hardif_neigh_create - create a hardif neighbour node
+ * batadv_hardif_neigh_create() - create a hardif neighbour node
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
  * @orig_node: originator object representing the neighbour
@@ -590,7 +590,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 }
 
 /**
- * batadv_hardif_neigh_get_or_create - retrieve or create a hardif neighbour
+ * batadv_hardif_neigh_get_or_create() - retrieve or create a hardif neighbour
  *  node
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
@@ -614,7 +614,7 @@ batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
 }
 
 /**
- * batadv_hardif_neigh_get - retrieve a hardif neighbour from the list
+ * batadv_hardif_neigh_get() - retrieve a hardif neighbour from the list
  * @hard_iface: the interface where this neighbour is connected to
  * @neigh_addr: the address of the neighbour
  *
@@ -646,7 +646,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 }
 
 /**
- * batadv_neigh_node_create - create a neigh node object
+ * batadv_neigh_node_create() - create a neigh node object
  * @orig_node: originator object representing the neighbour
  * @hard_iface: the interface where the neighbour is connected to
  * @neigh_addr: the mac address of the neighbour interface
@@ -711,7 +711,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_neigh_node_get_or_create - retrieve or create a neigh node object
+ * batadv_neigh_node_get_or_create() - retrieve or create a neigh node object
  * @orig_node: originator object representing the neighbour
  * @hard_iface: the interface where the neighbour is connected to
  * @neigh_addr: the mac address of the neighbour interface
@@ -735,7 +735,7 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_hardif_neigh_seq_print_text - print the single hop neighbour list
+ * batadv_hardif_neigh_seq_print_text() - print the single hop neighbour list
  * @seq: neighbour table seq_file struct
  * @offset: not used
  *
@@ -770,8 +770,8 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_hardif_neigh_dump - Dump to netlink the neighbor infos for a specific
- *  outgoing interface
+ * batadv_hardif_neigh_dump() - Dump to netlink the neighbor infos for a
+ *  specific outgoing interface
  * @msg: message to dump into
  * @cb: parameters for the dump
  *
@@ -847,7 +847,7 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * batadv_orig_ifinfo_release - release orig_ifinfo from lists and queue for
+ * batadv_orig_ifinfo_release() - release orig_ifinfo from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the orig_ifinfo
  */
@@ -870,7 +870,7 @@ static void batadv_orig_ifinfo_release(struct kref *ref)
 }
 
 /**
- * batadv_orig_ifinfo_put - decrement the refcounter and possibly release
+ * batadv_orig_ifinfo_put() - decrement the refcounter and possibly release
  *  the orig_ifinfo
  * @orig_ifinfo: the orig_ifinfo object to release
  */
@@ -880,7 +880,7 @@ void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo)
 }
 
 /**
- * batadv_orig_node_free_rcu - free the orig_node
+ * batadv_orig_node_free_rcu() - free the orig_node
  * @rcu: rcu pointer of the orig_node
  */
 static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
@@ -901,7 +901,7 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_orig_node_release - release orig_node from lists and queue for
+ * batadv_orig_node_release() - release orig_node from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the orig_node
  */
@@ -952,7 +952,7 @@ static void batadv_orig_node_release(struct kref *ref)
 }
 
 /**
- * batadv_orig_node_put - decrement the orig node refcounter and possibly
+ * batadv_orig_node_put() - decrement the orig node refcounter and possibly
  *  release it
  * @orig_node: the orig node to free
  */
@@ -994,7 +994,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_orig_node_new - creates a new orig_node
+ * batadv_orig_node_new() - creates a new orig_node
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the originator
  *
@@ -1073,7 +1073,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_purge_neigh_ifinfo - purge obsolete ifinfo entries from neighbor
+ * batadv_purge_neigh_ifinfo() - purge obsolete ifinfo entries from neighbor
  * @bat_priv: the bat priv with all the soft interface information
  * @neigh: orig node which is to be checked
  */
@@ -1114,7 +1114,7 @@ batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_purge_orig_ifinfo - purge obsolete ifinfo entries from originator
+ * batadv_purge_orig_ifinfo() - purge obsolete ifinfo entries from originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
  *
@@ -1166,7 +1166,7 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_purge_orig_neighbors - purges neighbors from originator
+ * batadv_purge_orig_neighbors() - purges neighbors from originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
  *
@@ -1224,7 +1224,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_find_best_neighbor - finds the best neighbor after purging
+ * batadv_find_best_neighbor() - finds the best neighbor after purging
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
  * @if_outgoing: the interface for which the metric should be compared
@@ -1259,7 +1259,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_purge_orig_node - purges obsolete information from an orig_node
+ * batadv_purge_orig_node() - purges obsolete information from an orig_node
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
  *
@@ -1411,7 +1411,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 }
 
 /**
- * batadv_orig_hardif_seq_print_text - writes originator infos for a specific
+ * batadv_orig_hardif_seq_print_text() - writes originator infos for a specific
  *  outgoing interface
  * @seq: debugfs table seq_file struct
  * @offset: not used
@@ -1458,7 +1458,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_orig_dump - Dump to netlink the originator infos for a specific
+ * batadv_orig_dump() - Dump to netlink the originator infos for a specific
  *  outgoing interface
  * @msg: message to dump into
  * @cb: parameters for the dump
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0acfa6eee832..12954e746c5e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -57,7 +57,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
 /**
- * _batadv_update_route - set the router for this originator
+ * _batadv_update_route() - set the router for this originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be configured
  * @recv_if: the receive interface for which this route is set
@@ -121,7 +121,7 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_update_route - set the router for this originator
+ * batadv_update_route() - set the router for this originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be configured
  * @recv_if: the receive interface for which this route is set
@@ -148,7 +148,7 @@ void batadv_update_route(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_window_protected - checks whether the host restarted and is in the
+ * batadv_window_protected() - checks whether the host restarted and is in the
  *  protection time.
  * @bat_priv: the bat priv with all the soft interface information
  * @seq_num_diff: difference between the current/received sequence number and
@@ -215,7 +215,7 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 }
 
 /**
- * batadv_recv_my_icmp_packet - receive an icmp packet locally
+ * batadv_recv_my_icmp_packet() - receive an icmp packet locally
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: icmp packet to process
  *
@@ -443,7 +443,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 }
 
 /**
- * batadv_check_unicast_packet - Check for malformed unicast packets
+ * batadv_check_unicast_packet() - Check for malformed unicast packets
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of header to pull
@@ -481,7 +481,7 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_last_bonding_get - Get last_bonding_candidate of orig_node
+ * batadv_last_bonding_get() - Get last_bonding_candidate of orig_node
  * @orig_node: originator node whose last bonding candidate should be retrieved
  *
  * Return: last bonding candidate of router or NULL if not found
@@ -504,7 +504,7 @@ batadv_last_bonding_get(struct batadv_orig_node *orig_node)
 }
 
 /**
- * batadv_last_bonding_replace - Replace last_bonding_candidate of orig_node
+ * batadv_last_bonding_replace() - Replace last_bonding_candidate of orig_node
  * @orig_node: originator node whose bonding candidates should be replaced
  * @new_candidate: new bonding candidate or NULL
  */
@@ -527,7 +527,7 @@ batadv_last_bonding_replace(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_find_router - find a suitable router for this originator
+ * batadv_find_router() - find a suitable router for this originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the destination node
  * @recv_if: pointer to interface this packet was received on
@@ -744,7 +744,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 }
 
 /**
- * batadv_reroute_unicast_packet - update the unicast header for re-routing
+ * batadv_reroute_unicast_packet() - update the unicast header for re-routing
  * @bat_priv: the bat priv with all the soft interface information
  * @unicast_packet: the unicast header to be updated
  * @dst_addr: the payload destination
@@ -907,7 +907,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_recv_unhandled_unicast_packet - receive and process packets which
+ * batadv_recv_unhandled_unicast_packet() - receive and process packets which
  *	are in the unicast number space but not yet known to the implementation
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
@@ -1039,7 +1039,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 }
 
 /**
- * batadv_recv_unicast_tvlv - receive and process unicast tvlv packets
+ * batadv_recv_unicast_tvlv() - receive and process unicast tvlv packets
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
@@ -1093,7 +1093,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 }
 
 /**
- * batadv_recv_frag_packet - process received fragment
+ * batadv_recv_frag_packet() - process received fragment
  * @skb: the received fragment
  * @recv_if: interface that the skb is received on
  *
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 68b0bb1ad83e..68705584f537 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -57,7 +57,7 @@
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
 /**
- * batadv_send_skb_packet - send an already prepared packet
+ * batadv_send_skb_packet() - send an already prepared packet
  * @skb: the packet to send
  * @hard_iface: the interface to use to send the broadcast packet
  * @dst_addr: the payload destination
@@ -156,7 +156,7 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
 }
 
 /**
- * batadv_send_skb_to_orig - Lookup next-hop and transmit skb.
+ * batadv_send_skb_to_orig() - Lookup next-hop and transmit skb.
  * @skb: Packet to be transmitted.
  * @orig_node: Final destination of the packet.
  * @recv_if: Interface used when receiving the packet (can be NULL).
@@ -219,7 +219,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 }
 
 /**
- * batadv_send_skb_push_fill_unicast - extend the buffer and initialize the
+ * batadv_send_skb_push_fill_unicast() - extend the buffer and initialize the
  *  common fields for unicast packets
  * @skb: the skb carrying the unicast header to initialize
  * @hdr_size: amount of bytes to push at the beginning of the skb
@@ -252,7 +252,7 @@ batadv_send_skb_push_fill_unicast(struct sk_buff *skb, int hdr_size,
 }
 
 /**
- * batadv_send_skb_prepare_unicast - encapsulate an skb with a unicast header
+ * batadv_send_skb_prepare_unicast() - encapsulate an skb with a unicast header
  * @skb: the skb containing the payload to encapsulate
  * @orig_node: the destination node
  *
@@ -267,7 +267,7 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
 }
 
 /**
- * batadv_send_skb_prepare_unicast_4addr - encapsulate an skb with a
+ * batadv_send_skb_prepare_unicast_4addr() - encapsulate an skb with a
  *  unicast 4addr header
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the skb containing the payload to encapsulate
@@ -311,7 +311,7 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_skb_unicast - encapsulate and send an skb via unicast
+ * batadv_send_skb_unicast() - encapsulate and send an skb via unicast
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @packet_type: the batman unicast packet type to use
@@ -381,7 +381,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_skb_via_tt_generic - send an skb via TT lookup
+ * batadv_send_skb_via_tt_generic() - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @packet_type: the batman unicast packet type to use
@@ -428,7 +428,7 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_skb_via_gw - send an skb via gateway lookup
+ * batadv_send_skb_via_gw() - send an skb via gateway lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @vid: the vid to be used to search the translation table
@@ -455,7 +455,7 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 }
 
 /**
- * batadv_forw_packet_free - free a forwarding packet
+ * batadv_forw_packet_free() - free a forwarding packet
  * @forw_packet: The packet to free
  * @dropped: whether the packet is freed because is is dropped
  *
@@ -480,7 +480,7 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
 }
 
 /**
- * batadv_forw_packet_alloc - allocate a forwarding packet
+ * batadv_forw_packet_alloc() - allocate a forwarding packet
  * @if_incoming: The (optional) if_incoming to be grabbed
  * @if_outgoing: The (optional) if_outgoing to be grabbed
  * @queue_left: The (optional) queue counter to decrease
@@ -546,7 +546,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 }
 
 /**
- * batadv_forw_packet_was_stolen - check whether someone stole this packet
+ * batadv_forw_packet_was_stolen() - check whether someone stole this packet
  * @forw_packet: the forwarding packet to check
  *
  * This function checks whether the given forwarding packet was claimed by
@@ -561,7 +561,7 @@ batadv_forw_packet_was_stolen(struct batadv_forw_packet *forw_packet)
 }
 
 /**
- * batadv_forw_packet_steal - claim a forw_packet for free()
+ * batadv_forw_packet_steal() - claim a forw_packet for free()
  * @forw_packet: the forwarding packet to steal
  * @lock: a key to the store to steal from (e.g. forw_{bat,bcast}_list_lock)
  *
@@ -592,7 +592,7 @@ bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
 }
 
 /**
- * batadv_forw_packet_list_steal - claim a list of forward packets for free()
+ * batadv_forw_packet_list_steal() - claim a list of forward packets for free()
  * @forw_list: the to be stolen forward packets
  * @cleanup_list: a backup pointer, to be able to dispose the packet later
  * @hard_iface: the interface to steal forward packets from
@@ -628,7 +628,7 @@ batadv_forw_packet_list_steal(struct hlist_head *forw_list,
 }
 
 /**
- * batadv_forw_packet_list_free - free a list of forward packets
+ * batadv_forw_packet_list_free() - free a list of forward packets
  * @head: a list of to be freed forw_packets
  *
  * This function cancels the scheduling of any packet in the provided list,
@@ -652,7 +652,7 @@ static void batadv_forw_packet_list_free(struct hlist_head *head)
 }
 
 /**
- * batadv_forw_packet_queue - try to queue a forwarding packet
+ * batadv_forw_packet_queue() - try to queue a forwarding packet
  * @forw_packet: the forwarding packet to queue
  * @lock: a key to the store (e.g. forw_{bat,bcast}_list_lock)
  * @head: the shelve to queue it on (e.g. forw_{bat,bcast}_list)
@@ -696,7 +696,7 @@ static void batadv_forw_packet_queue(struct batadv_forw_packet *forw_packet,
 }
 
 /**
- * batadv_forw_packet_bcast_queue - try to queue a broadcast packet
+ * batadv_forw_packet_bcast_queue() - try to queue a broadcast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @forw_packet: the forwarding packet to queue
  * @send_time: timestamp (jiffies) when the packet is to be sent
@@ -715,7 +715,7 @@ batadv_forw_packet_bcast_queue(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_forw_packet_ogmv1_queue - try to queue an OGMv1 packet
+ * batadv_forw_packet_ogmv1_queue() - try to queue an OGMv1 packet
  * @bat_priv: the bat priv with all the soft interface information
  * @forw_packet: the forwarding packet to queue
  * @send_time: timestamp (jiffies) when the packet is to be sent
@@ -733,7 +733,7 @@ void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_add_bcast_packet_to_list - queue broadcast packet for multiple sends
+ * batadv_add_bcast_packet_to_list() - queue broadcast packet for multiple sends
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
@@ -793,7 +793,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_forw_packet_bcasts_left - check if a retransmission is necessary
+ * batadv_forw_packet_bcasts_left() - check if a retransmission is necessary
  * @forw_packet: the forwarding packet to check
  * @hard_iface: the interface to check on
  *
@@ -821,7 +821,8 @@ batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet,
 }
 
 /**
- * batadv_forw_packet_bcasts_inc - increment retransmission counter of a packet
+ * batadv_forw_packet_bcasts_inc() - increment retransmission counter of a
+ *  packet
  * @forw_packet: the packet to increase the counter for
  */
 static void
@@ -831,7 +832,7 @@ batadv_forw_packet_bcasts_inc(struct batadv_forw_packet *forw_packet)
 }
 
 /**
- * batadv_forw_packet_is_rebroadcast - check packet for previous transmissions
+ * batadv_forw_packet_is_rebroadcast() - check packet for previous transmissions
  * @forw_packet: the packet to check
  *
  * Return: True if this packet was transmitted before, false otherwise.
@@ -956,7 +957,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 }
 
 /**
- * batadv_purge_outstanding_packets - stop/purge scheduled bcast/OGMv1 packets
+ * batadv_purge_outstanding_packets() - stop/purge scheduled bcast/OGMv1 packets
  * @bat_priv: the bat priv with all the soft interface information
  * @hard_iface: the hard interface to cancel and purge bcast/ogm packets on
  *
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index f6ead20b7458..b9ef010bfb03 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -79,7 +79,7 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			   unsigned short vid);
 
 /**
- * batadv_send_skb_via_tt - send an skb via TT lookup
+ * batadv_send_skb_via_tt() - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @dst_hint: can be used to override the destination contained in the skb
@@ -100,7 +100,7 @@ static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_skb_via_tt_4addr - send an skb via TT lookup
+ * batadv_send_skb_via_tt_4addr() - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @packet_subtype: the unicast 4addr packet subtype to use
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index aea576f3e461..e2d5c2ae640b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -99,7 +99,7 @@ static int batadv_interface_release(struct net_device *dev)
 }
 
 /**
- * batadv_sum_counter - Sum the cpu-local counters for index 'idx'
+ * batadv_sum_counter() - Sum the cpu-local counters for index 'idx'
  * @bat_priv: the bat priv with all the soft interface information
  * @idx: index of counter to sum up
  *
@@ -172,7 +172,7 @@ static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 }
 
 /**
- * batadv_interface_set_rx_mode - set the rx mode of a device
+ * batadv_interface_set_rx_mode() - set the rx mode of a device
  * @dev: registered network device to modify
  *
  * We do not actually need to set any rx filters for the virtual batman
@@ -392,7 +392,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 }
 
 /**
- * batadv_interface_rx - receive ethernet frame on local batman-adv interface
+ * batadv_interface_rx() - receive ethernet frame on local batman-adv interface
  * @soft_iface: local interface which will receive the ethernet frame
  * @skb: ethernet frame for @soft_iface
  * @hdr_size: size of already parsed batman-adv header
@@ -504,8 +504,8 @@ void batadv_interface_rx(struct net_device *soft_iface,
 }
 
 /**
- * batadv_softif_vlan_release - release vlan from lists and queue for free after
- *  rcu grace period
+ * batadv_softif_vlan_release() - release vlan from lists and queue for free
+ *  after rcu grace period
  * @ref: kref pointer of the vlan object
  */
 static void batadv_softif_vlan_release(struct kref *ref)
@@ -522,7 +522,7 @@ static void batadv_softif_vlan_release(struct kref *ref)
 }
 
 /**
- * batadv_softif_vlan_put - decrease the vlan object refcounter and
+ * batadv_softif_vlan_put() - decrease the vlan object refcounter and
  *  possibly release it
  * @vlan: the vlan object to release
  */
@@ -535,7 +535,7 @@ void batadv_softif_vlan_put(struct batadv_softif_vlan *vlan)
 }
 
 /**
- * batadv_softif_vlan_get - get the vlan object for a specific vid
+ * batadv_softif_vlan_get() - get the vlan object for a specific vid
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the identifier of the vlan object to retrieve
  *
@@ -564,7 +564,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_softif_create_vlan - allocate the needed resources for a new vlan
+ * batadv_softif_create_vlan() - allocate the needed resources for a new vlan
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  *
@@ -616,7 +616,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 }
 
 /**
- * batadv_softif_destroy_vlan - remove and destroy a softif_vlan object
+ * batadv_softif_destroy_vlan() - remove and destroy a softif_vlan object
  * @bat_priv: the bat priv with all the soft interface information
  * @vlan: the object to remove
  */
@@ -634,7 +634,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_interface_add_vid - ndo_add_vid API implementation
+ * batadv_interface_add_vid() - ndo_add_vid API implementation
  * @dev: the netdev of the mesh interface
  * @proto: protocol of the the vlan id
  * @vid: identifier of the new vlan
@@ -692,7 +692,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 }
 
 /**
- * batadv_interface_kill_vid - ndo_kill_vid API implementation
+ * batadv_interface_kill_vid() - ndo_kill_vid API implementation
  * @dev: the netdev of the mesh interface
  * @proto: protocol of the the vlan id
  * @vid: identifier of the deleted vlan
@@ -735,7 +735,7 @@ static struct lock_class_key batadv_netdev_xmit_lock_key;
 static struct lock_class_key batadv_netdev_addr_lock_key;
 
 /**
- * batadv_set_lockdep_class_one - Set lockdep class for a single tx queue
+ * batadv_set_lockdep_class_one() - Set lockdep class for a single tx queue
  * @dev: device which owns the tx queue
  * @txq: tx queue to modify
  * @_unused: always NULL
@@ -748,7 +748,7 @@ static void batadv_set_lockdep_class_one(struct net_device *dev,
 }
 
 /**
- * batadv_set_lockdep_class - Set txq and addr_list lockdep class
+ * batadv_set_lockdep_class() - Set txq and addr_list lockdep class
  * @dev: network device to modify
  */
 static void batadv_set_lockdep_class(struct net_device *dev)
@@ -758,7 +758,7 @@ static void batadv_set_lockdep_class(struct net_device *dev)
 }
 
 /**
- * batadv_softif_init_late - late stage initialization of soft interface
+ * batadv_softif_init_late() - late stage initialization of soft interface
  * @dev: registered network device to modify
  *
  * Return: error code on failures
@@ -863,7 +863,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 }
 
 /**
- * batadv_softif_slave_add - Add a slave interface to a batadv_soft_interface
+ * batadv_softif_slave_add() - Add a slave interface to a batadv_soft_interface
  * @dev: batadv_soft_interface used as master interface
  * @slave_dev: net_device which should become the slave interface
  * @extack: extended ACK report struct
@@ -891,7 +891,7 @@ static int batadv_softif_slave_add(struct net_device *dev,
 }
 
 /**
- * batadv_softif_slave_del - Delete a slave iface from a batadv_soft_interface
+ * batadv_softif_slave_del() - Delete a slave iface from a batadv_soft_interface
  * @dev: batadv_soft_interface used as master interface
  * @slave_dev: net_device which should be removed from the master interface
  *
@@ -1026,7 +1026,7 @@ static const struct ethtool_ops batadv_ethtool_ops = {
 };
 
 /**
- * batadv_softif_free - Deconstructor of batadv_soft_interface
+ * batadv_softif_free() - Deconstructor of batadv_soft_interface
  * @dev: Device to cleanup and remove
  */
 static void batadv_softif_free(struct net_device *dev)
@@ -1042,7 +1042,7 @@ static void batadv_softif_free(struct net_device *dev)
 }
 
 /**
- * batadv_softif_init_early - early stage initialization of soft interface
+ * batadv_softif_init_early() - early stage initialization of soft interface
  * @dev: registered network device to modify
  */
 static void batadv_softif_init_early(struct net_device *dev)
@@ -1092,7 +1092,7 @@ struct net_device *batadv_softif_create(struct net *net, const char *name)
 }
 
 /**
- * batadv_softif_destroy_sysfs - deletion of batadv_soft_interface via sysfs
+ * batadv_softif_destroy_sysfs() - deletion of batadv_soft_interface via sysfs
  * @soft_iface: the to-be-removed batman-adv interface
  */
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
@@ -1114,7 +1114,8 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
 }
 
 /**
- * batadv_softif_destroy_netlink - deletion of batadv_soft_interface via netlink
+ * batadv_softif_destroy_netlink() - deletion of batadv_soft_interface via
+ *  netlink
  * @soft_iface: the to-be-removed batman-adv interface
  * @head: list pointer
  */
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 9eed06647065..61ab133aeeb1 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -67,7 +67,7 @@ static struct batadv_priv *batadv_kobj_to_batpriv(struct kobject *obj)
 }
 
 /**
- * batadv_vlan_kobj_to_batpriv - convert a vlan kobj in the associated batpriv
+ * batadv_vlan_kobj_to_batpriv() - convert a vlan kobj in the associated batpriv
  * @obj: kobject to covert
  *
  * Return: the associated batadv_priv struct.
@@ -87,7 +87,7 @@ static struct batadv_priv *batadv_vlan_kobj_to_batpriv(struct kobject *obj)
 }
 
 /**
- * batadv_kobj_to_vlan - convert a kobj in the associated softif_vlan struct
+ * batadv_kobj_to_vlan() - convert a kobj in the associated softif_vlan struct
  * @bat_priv: the bat priv with all the soft interface information
  * @obj: kobject to covert
  *
@@ -602,7 +602,7 @@ static ssize_t batadv_store_gw_bwidth(struct kobject *kobj,
 }
 
 /**
- * batadv_show_isolation_mark - print the current isolation mark/mask
+ * batadv_show_isolation_mark() - print the current isolation mark/mask
  * @kobj: kobject representing the private mesh sysfs directory
  * @attr: the batman-adv attribute the user is interacting with
  * @buff: the buffer that will contain the data to send back to the user
@@ -620,8 +620,8 @@ static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
 }
 
 /**
- * batadv_store_isolation_mark - parse and store the isolation mark/mask entered
- *  by the user
+ * batadv_store_isolation_mark() - parse and store the isolation mark/mask
+ *  entered by the user
  * @kobj: kobject representing the private mesh sysfs directory
  * @attr: the batman-adv attribute the user is interacting with
  * @buff: the buffer containing the user data
@@ -792,7 +792,7 @@ void batadv_sysfs_del_meshif(struct net_device *dev)
 }
 
 /**
- * batadv_sysfs_add_vlan - add all the needed sysfs objects for the new vlan
+ * batadv_sysfs_add_vlan() - add all the needed sysfs objects for the new vlan
  * @dev: netdev of the mesh interface
  * @vlan: private data of the newly added VLAN interface
  *
@@ -853,7 +853,7 @@ int batadv_sysfs_add_vlan(struct net_device *dev,
 }
 
 /**
- * batadv_sysfs_del_vlan - remove all the sysfs objects for a given VLAN
+ * batadv_sysfs_del_vlan() - remove all the sysfs objects for a given VLAN
  * @bat_priv: the bat priv with all the soft interface information
  * @vlan: the private data of the VLAN to destroy
  */
@@ -898,7 +898,7 @@ static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 }
 
 /**
- * batadv_store_mesh_iface_finish - store new hardif mesh_iface state
+ * batadv_store_mesh_iface_finish() - store new hardif mesh_iface state
  * @net_dev: netdevice to add/remove to/from batman-adv soft-interface
  * @ifname: name of soft-interface to modify
  *
@@ -951,7 +951,7 @@ static int batadv_store_mesh_iface_finish(struct net_device *net_dev,
 }
 
 /**
- * batadv_store_mesh_iface_work - store new hardif mesh_iface state
+ * batadv_store_mesh_iface_work() - store new hardif mesh_iface state
  * @work: work queue item
  *
  * Changes the parts of the hard+soft interface which can not be modified under
@@ -1047,7 +1047,7 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 /**
- * batadv_store_throughput_override - parse and store throughput override
+ * batadv_store_throughput_override() - parse and store throughput override
  *  entered by the user
  * @kobj: kobject representing the private mesh sysfs directory
  * @attr: the batman-adv attribute the user is interacting with
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 6f3dca80d74f..d73346057310 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -100,7 +100,7 @@
 static u8 batadv_tp_prerandom[4096] __read_mostly;
 
 /**
- * batadv_tp_session_cookie - generate session cookie based on session ids
+ * batadv_tp_session_cookie() - generate session cookie based on session ids
  * @session: TP session identifier
  * @icmp_uid: icmp pseudo uid of the tp session
  *
@@ -118,7 +118,7 @@ static u32 batadv_tp_session_cookie(const u8 session[2], u8 icmp_uid)
 }
 
 /**
- * batadv_tp_cwnd - compute the new cwnd size
+ * batadv_tp_cwnd() - compute the new cwnd size
  * @base: base cwnd size value
  * @increment: the value to add to base to get the new size
  * @min: minumim cwnd value (usually MSS)
@@ -143,7 +143,7 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
 }
 
 /**
- * batadv_tp_updated_cwnd - update the Congestion Windows
+ * batadv_tp_updated_cwnd() - update the Congestion Windows
  * @tp_vars: the private data of the current TP meter session
  * @mss: maximum segment size of transmission
  *
@@ -179,7 +179,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
 }
 
 /**
- * batadv_tp_update_rto - calculate new retransmission timeout
+ * batadv_tp_update_rto() - calculate new retransmission timeout
  * @tp_vars: the private data of the current TP meter session
  * @new_rtt: new roundtrip time in msec
  */
@@ -215,7 +215,7 @@ static void batadv_tp_update_rto(struct batadv_tp_vars *tp_vars,
 }
 
 /**
- * batadv_tp_batctl_notify - send client status result to client
+ * batadv_tp_batctl_notify() - send client status result to client
  * @reason: reason for tp meter session stop
  * @dst: destination of tp_meter session
  * @bat_priv: the bat priv with all the soft interface information
@@ -247,7 +247,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 }
 
 /**
- * batadv_tp_batctl_error_notify - send client error result to client
+ * batadv_tp_batctl_error_notify() - send client error result to client
  * @reason: reason for tp meter session stop
  * @dst: destination of tp_meter session
  * @bat_priv: the bat priv with all the soft interface information
@@ -262,7 +262,7 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 }
 
 /**
- * batadv_tp_list_find - find a tp_vars object in the global list
+ * batadv_tp_list_find() - find a tp_vars object in the global list
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the other endpoint MAC address to look for
  *
@@ -297,7 +297,8 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tp_list_find_session - find tp_vars session object in the global list
+ * batadv_tp_list_find_session() - find tp_vars session object in the global
+ *  list
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the other endpoint MAC address to look for
  * @session: session identifier
@@ -338,7 +339,7 @@ batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_vars_release - release batadv_tp_vars from lists and queue for
+ * batadv_tp_vars_release() - release batadv_tp_vars from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the batadv_tp_vars
  */
@@ -363,7 +364,7 @@ static void batadv_tp_vars_release(struct kref *ref)
 }
 
 /**
- * batadv_tp_vars_put - decrement the batadv_tp_vars refcounter and possibly
+ * batadv_tp_vars_put() - decrement the batadv_tp_vars refcounter and possibly
  *  release it
  * @tp_vars: the private data of the current TP meter session to be free'd
  */
@@ -373,7 +374,7 @@ static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_sender_cleanup - cleanup sender data and drop and timer
+ * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
  * @bat_priv: the bat priv with all the soft interface information
  * @tp_vars: the private data of the current TP meter session to cleanup
  */
@@ -403,7 +404,7 @@ static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tp_sender_end - print info about ended session and inform client
+ * batadv_tp_sender_end() - print info about ended session and inform client
  * @bat_priv: the bat priv with all the soft interface information
  * @tp_vars: the private data of the current TP meter session
  */
@@ -436,7 +437,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tp_sender_shutdown - let sender thread/timer stop gracefully
+ * batadv_tp_sender_shutdown() - let sender thread/timer stop gracefully
  * @tp_vars: the private data of the current TP meter session
  * @reason: reason for tp meter session stop
  */
@@ -450,7 +451,7 @@ static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 }
 
 /**
- * batadv_tp_sender_finish - stop sender session after test_length was reached
+ * batadv_tp_sender_finish() - stop sender session after test_length was reached
  * @work: delayed work reference of the related tp_vars
  */
 static void batadv_tp_sender_finish(struct work_struct *work)
@@ -466,7 +467,7 @@ static void batadv_tp_sender_finish(struct work_struct *work)
 }
 
 /**
- * batadv_tp_reset_sender_timer - reschedule the sender timer
+ * batadv_tp_reset_sender_timer() - reschedule the sender timer
  * @tp_vars: the private TP meter data for this session
  *
  * Reschedule the timer using tp_vars->rto as delay
@@ -484,7 +485,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_sender_timeout - timer that fires in case of packet loss
+ * batadv_tp_sender_timeout() - timer that fires in case of packet loss
  * @arg: address of the related tp_vars
  *
  * If fired it means that there was packet loss.
@@ -534,7 +535,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 }
 
 /**
- * batadv_tp_fill_prerandom - Fill buffer with prefetched random bytes
+ * batadv_tp_fill_prerandom() - Fill buffer with prefetched random bytes
  * @tp_vars: the private TP meter data for this session
  * @buf: Buffer to fill with bytes
  * @nbytes: amount of pseudorandom bytes
@@ -566,7 +567,7 @@ static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
 }
 
 /**
- * batadv_tp_send_msg - send a single message
+ * batadv_tp_send_msg() - send a single message
  * @tp_vars: the private TP meter data for this session
  * @src: source mac address
  * @orig_node: the originator of the destination
@@ -626,7 +627,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 }
 
 /**
- * batadv_tp_recv_ack - ACK receiving function
+ * batadv_tp_recv_ack() - ACK receiving function
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the buffer containing the received packet
  *
@@ -768,7 +769,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tp_avail - check if congestion window is not full
+ * batadv_tp_avail() - check if congestion window is not full
  * @tp_vars: the private data of the current TP meter session
  * @payload_len: size of the payload of a single message
  *
@@ -786,7 +787,7 @@ static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
 }
 
 /**
- * batadv_tp_wait_available - wait until congestion window becomes free or
+ * batadv_tp_wait_available() - wait until congestion window becomes free or
  *  timeout is reached
  * @tp_vars: the private data of the current TP meter session
  * @plen: size of the payload of a single message
@@ -808,7 +809,7 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
 }
 
 /**
- * batadv_tp_send - main sending thread of a tp meter session
+ * batadv_tp_send() - main sending thread of a tp meter session
  * @arg: address of the related tp_vars
  *
  * Return: nothing, this function never returns
@@ -907,7 +908,8 @@ static int batadv_tp_send(void *arg)
 }
 
 /**
- * batadv_tp_start_kthread - start new thread which manages the tp meter sender
+ * batadv_tp_start_kthread() - start new thread which manages the tp meter
+ *  sender
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
@@ -938,7 +940,7 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_start - start a new tp meter session
+ * batadv_tp_start() - start a new tp meter session
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the receiver MAC address
  * @test_length: test length in milliseconds
@@ -1063,7 +1065,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_stop - stop currently running tp meter session
+ * batadv_tp_stop() - stop currently running tp meter session
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the receiver MAC address
  * @return_value: reason for tp meter session stop
@@ -1095,7 +1097,7 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_reset_receiver_timer - reset the receiver shutdown timer
+ * batadv_tp_reset_receiver_timer() - reset the receiver shutdown timer
  * @tp_vars: the private data of the current TP meter session
  *
  * start the receiver shutdown timer or reset it if already started
@@ -1107,7 +1109,7 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_receiver_shutdown - stop a tp meter receiver when timeout is
+ * batadv_tp_receiver_shutdown() - stop a tp meter receiver when timeout is
  *  reached without received ack
  * @arg: address of the related tp_vars
  */
@@ -1152,7 +1154,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 }
 
 /**
- * batadv_tp_send_ack - send an ACK packet
+ * batadv_tp_send_ack() - send an ACK packet
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the mac address of the destination originator
  * @seq: the sequence number to ACK
@@ -1224,7 +1226,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_handle_out_of_order - store an out of order packet
+ * batadv_tp_handle_out_of_order() - store an out of order packet
  * @tp_vars: the private data of the current TP meter session
  * @skb: the buffer containing the received packet
  *
@@ -1300,7 +1302,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 }
 
 /**
- * batadv_tp_ack_unordered - update number received bytes in current stream
+ * batadv_tp_ack_unordered() - update number received bytes in current stream
  *  without gaps
  * @tp_vars: the private data of the current TP meter session
  */
@@ -1333,7 +1335,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_init_recv - return matching or create new receiver tp_vars
+ * batadv_tp_init_recv() - return matching or create new receiver tp_vars
  * @bat_priv: the bat priv with all the soft interface information
  * @icmp: received icmp tp msg
  *
@@ -1386,7 +1388,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tp_recv_msg - process a single data message
+ * batadv_tp_recv_msg() - process a single data message
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the buffer containing the received packet
  *
@@ -1471,7 +1473,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tp_meter_recv - main TP Meter receiving function
+ * batadv_tp_meter_recv() - main TP Meter receiving function
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the buffer containing the received packet
  */
@@ -1497,7 +1499,7 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 }
 
 /**
- * batadv_tp_meter_init - initialize global tp_meter structures
+ * batadv_tp_meter_init() - initialize global tp_meter structures
  */
 void __init batadv_tp_meter_init(void)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ce90bfd70cd2..8bcc459543ac 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -90,7 +90,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 bool roaming);
 
 /**
- * batadv_compare_tt - check if two TT entries are the same
+ * batadv_compare_tt() - check if two TT entries are the same
  * @node: the list element pointer of the first TT entry
  * @data2: pointer to the tt_common_entry of the second TT entry
  *
@@ -109,7 +109,7 @@ static bool batadv_compare_tt(const struct hlist_node *node, const void *data2)
 }
 
 /**
- * batadv_choose_tt - return the index of the tt entry in the hash table
+ * batadv_choose_tt() - return the index of the tt entry in the hash table
  * @data: pointer to the tt_common_entry object to map
  * @size: the size of the hash table
  *
@@ -129,7 +129,7 @@ static inline u32 batadv_choose_tt(const void *data, u32 size)
 }
 
 /**
- * batadv_tt_hash_find - look for a client in the given hash table
+ * batadv_tt_hash_find() - look for a client in the given hash table
  * @hash: the hash table to search
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
@@ -174,7 +174,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_hash_find - search the local table for a given client
+ * batadv_tt_local_hash_find() - search the local table for a given client
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
@@ -199,7 +199,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 }
 
 /**
- * batadv_tt_global_hash_find - search the global table for a given client
+ * batadv_tt_global_hash_find() - search the global table for a given client
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
@@ -224,7 +224,7 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_entry_free_rcu - free the tt_local_entry
+ * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
  * @rcu: rcu pointer of the tt_local_entry
  */
 static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
@@ -238,7 +238,7 @@ static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_tt_local_entry_release - release tt_local_entry from lists and queue
+ * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
  * @ref: kref pointer of the nc_node
  */
@@ -255,7 +255,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_local_entry_put - decrement the tt_local_entry refcounter and
+ * batadv_tt_local_entry_put() - decrement the tt_local_entry refcounter and
  *  possibly release it
  * @tt_local_entry: tt_local_entry to be free'd
  */
@@ -267,7 +267,7 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 }
 
 /**
- * batadv_tt_global_entry_free_rcu - free the tt_global_entry
+ * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
  * @rcu: rcu pointer of the tt_global_entry
  */
 static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
@@ -281,8 +281,8 @@ static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_tt_global_entry_release - release tt_global_entry from lists and queue
- *  for free after rcu grace period
+ * batadv_tt_global_entry_release() - release tt_global_entry from lists and
+ *  queue for free after rcu grace period
  * @ref: kref pointer of the nc_node
  */
 static void batadv_tt_global_entry_release(struct kref *ref)
@@ -298,7 +298,7 @@ static void batadv_tt_global_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_global_entry_put - decrement the tt_global_entry refcounter and
+ * batadv_tt_global_entry_put() - decrement the tt_global_entry refcounter and
  *  possibly release it
  * @tt_global_entry: tt_global_entry to be free'd
  */
@@ -310,7 +310,7 @@ batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_entry)
 }
 
 /**
- * batadv_tt_global_hash_count - count the number of orig entries
+ * batadv_tt_global_hash_count() - count the number of orig entries
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
@@ -335,8 +335,8 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_size_mod - change the size by v of the local table identified
- *  by vid
+ * batadv_tt_local_size_mod() - change the size by v of the local table
+ *  identified by vid
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier of the sub-table to change
  * @v: the amount to sum to the local table size
@@ -356,8 +356,8 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_size_inc - increase by one the local table size for the given
- *  vid
+ * batadv_tt_local_size_inc() - increase by one the local table size for the
+ *  given vid
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  */
@@ -368,8 +368,8 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_size_dec - decrease by one the local table size for the given
- *  vid
+ * batadv_tt_local_size_dec() - decrease by one the local table size for the
+ *  given vid
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  */
@@ -380,7 +380,7 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_size_mod - change the size by v of the global table
+ * batadv_tt_global_size_mod() - change the size by v of the global table
  *  for orig_node identified by vid
  * @orig_node: the originator for which the table has to be modified
  * @vid: the VLAN identifier
@@ -408,7 +408,7 @@ static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_tt_global_size_inc - increase by one the global table size for the
+ * batadv_tt_global_size_inc() - increase by one the global table size for the
  *  given vid
  * @orig_node: the originator which global table size has to be decreased
  * @vid: the vlan identifier
@@ -420,7 +420,7 @@ static void batadv_tt_global_size_inc(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_tt_global_size_dec - decrease by one the global table size for the
+ * batadv_tt_global_size_dec() - decrease by one the global table size for the
  *  given vid
  * @orig_node: the originator which global table size has to be decreased
  * @vid: the vlan identifier
@@ -432,7 +432,7 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_tt_orig_list_entry_free_rcu - free the orig_entry
+ * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
  * @rcu: rcu pointer of the orig_entry
  */
 static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
@@ -445,7 +445,7 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_tt_orig_list_entry_release - release tt orig entry from lists and
+ * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
  *  queue for free after rcu grace period
  * @ref: kref pointer of the tt orig entry
  */
@@ -461,7 +461,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_orig_list_entry_put - decrement the tt orig entry refcounter and
+ * batadv_tt_orig_list_entry_put() - decrement the tt orig entry refcounter and
  *  possibly release it
  * @orig_entry: tt orig entry to be free'd
  */
@@ -472,7 +472,7 @@ batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
 }
 
 /**
- * batadv_tt_local_event - store a local TT event (ADD/DEL)
+ * batadv_tt_local_event() - store a local TT event (ADD/DEL)
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_local_entry: the TT entry involved in the event
  * @event_flags: flags to store in the event structure
@@ -547,7 +547,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_len - compute length in bytes of given number of tt changes
+ * batadv_tt_len() - compute length in bytes of given number of tt changes
  * @changes_num: number of tt changes
  *
  * Return: computed length in bytes.
@@ -558,7 +558,7 @@ static int batadv_tt_len(int changes_num)
 }
 
 /**
- * batadv_tt_entries - compute the number of entries fitting in tt_len bytes
+ * batadv_tt_entries() - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
  *
  * Return: the number of entries.
@@ -569,8 +569,8 @@ static u16 batadv_tt_entries(u16 tt_len)
 }
 
 /**
- * batadv_tt_local_table_transmit_size - calculates the local translation table
- *  size when transmitted over the air
+ * batadv_tt_local_table_transmit_size() - calculates the local translation
+ *  table size when transmitted over the air
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: local translation table size in bytes.
@@ -629,7 +629,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_add - add a new client to the local table or update an
+ * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
  * @soft_iface: netdev struct of the mesh interface
  * @addr: the mac address of the client to add
@@ -834,7 +834,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_prepare_tvlv_global_data - prepare the TVLV TT header to send
+ * batadv_tt_prepare_tvlv_global_data() - prepare the TVLV TT header to send
  *  within a TT Response directed to another node
  * @orig_node: originator for which the TT data has to be prepared
  * @tt_data: uninitialised pointer to the address of the TVLV buffer
@@ -907,8 +907,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_tt_prepare_tvlv_local_data - allocate and prepare the TT TVLV for this
- *  node
+ * batadv_tt_prepare_tvlv_local_data() - allocate and prepare the TT TVLV for
+ *  this node
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_data: uninitialised pointer to the address of the TVLV buffer
  * @tt_change: uninitialised pointer to the address of the area where the TT
@@ -981,8 +981,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_tvlv_container_update - update the translation table tvlv container
- *  after local tt changes have been committed
+ * batadv_tt_tvlv_container_update() - update the translation table tvlv
+ *  container after local tt changes have been committed
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
@@ -1127,7 +1127,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_tt_local_dump_entry - Dump one TT local entry into a message
+ * batadv_tt_local_dump_entry() - Dump one TT local entry into a message
  * @msg :Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -1183,7 +1183,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_tt_local_dump_bucket - Dump one TT local bucket into a message
+ * batadv_tt_local_dump_bucket() - Dump one TT local bucket into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -1220,7 +1220,7 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_tt_local_dump - Dump TT local entries into a message
+ * batadv_tt_local_dump() - Dump TT local entries into a message
  * @msg: Netlink message to dump into
  * @cb: Parameters from query
  *
@@ -1304,7 +1304,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_remove - logically remove an entry from the local table
+ * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the MAC address of the client to remove
  * @vid: VLAN identifier
@@ -1366,7 +1366,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_purge_list - purge inactive tt local entries
+ * batadv_tt_local_purge_list() - purge inactive tt local entries
  * @bat_priv: the bat priv with all the soft interface information
  * @head: pointer to the list containing the local tt entries
  * @timeout: parameter deciding whether a given tt local entry is considered
@@ -1401,7 +1401,7 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_purge - purge inactive tt local entries
+ * batadv_tt_local_purge() - purge inactive tt local entries
  * @bat_priv: the bat priv with all the soft interface information
  * @timeout: parameter deciding whether a given tt local entry is considered
  *  inactive or not
@@ -1494,7 +1494,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_global_orig_entry_find - find a TT orig_list_entry
+ * batadv_tt_global_orig_entry_find() - find a TT orig_list_entry
  * @entry: the TT global entry where the orig_list_entry has to be
  *  extracted from
  * @orig_node: the originator for which the orig_list_entry has to be found
@@ -1528,8 +1528,8 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 }
 
 /**
- * batadv_tt_global_entry_has_orig - check if a TT global entry is also handled
- *  by a given originator
+ * batadv_tt_global_entry_has_orig() - check if a TT global entry is also
+ *  handled by a given originator
  * @entry: the TT global entry to check
  * @orig_node: the originator to search in the list
  *
@@ -1554,7 +1554,7 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 }
 
 /**
- * batadv_tt_global_sync_flags - update TT sync flags
+ * batadv_tt_global_sync_flags() - update TT sync flags
  * @tt_global: the TT global entry to update sync flags in
  *
  * Updates the sync flag bits in the tt_global flag attribute with a logical
@@ -1578,7 +1578,7 @@ batadv_tt_global_sync_flags(struct batadv_tt_global_entry *tt_global)
 }
 
 /**
- * batadv_tt_global_orig_entry_add - add or update a TT orig entry
+ * batadv_tt_global_orig_entry_add() - add or update a TT orig entry
  * @tt_global: the TT global entry to add an orig entry in
  * @orig_node: the originator to add an orig entry for
  * @ttvn: translation table version number of this changeset
@@ -1628,7 +1628,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 }
 
 /**
- * batadv_tt_global_add - add a new TT global entry or update an existing one
+ * batadv_tt_global_add() - add a new TT global entry or update an existing one
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the originator announcing the client
  * @tt_addr: the mac address of the non-mesh client
@@ -1800,7 +1800,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_transtable_best_orig - Get best originator list entry from tt entry
+ * batadv_transtable_best_orig() - Get best originator list entry from tt entry
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_global_entry: global translation table entry to be analyzed
  *
@@ -1846,8 +1846,8 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
 /**
- * batadv_tt_global_print_entry - print all orig nodes who announce the address
- *  for this global entry
+ * batadv_tt_global_print_entry() - print all orig nodes who announce the
+ *  address for this global entry
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_global_entry: global translation table entry to be printed
  * @seq: debugfs table seq_file struct
@@ -1971,7 +1971,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
- * batadv_tt_global_dump_subentry - Dump all TT local entries into a message
+ * batadv_tt_global_dump_subentry() - Dump all TT local entries into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -2032,7 +2032,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_tt_global_dump_entry - Dump one TT global entry into a message
+ * batadv_tt_global_dump_entry() - Dump one TT global entry into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -2077,7 +2077,7 @@ batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_tt_global_dump_bucket - Dump one TT local bucket into a message
+ * batadv_tt_global_dump_bucket() - Dump one TT local bucket into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
@@ -2116,7 +2116,7 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 }
 
 /**
- * batadv_tt_global_dump -  Dump TT global entries into a message
+ * batadv_tt_global_dump() -  Dump TT global entries into a message
  * @msg: Netlink message to dump into
  * @cb: Parameters from query
  *
@@ -2184,7 +2184,7 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * _batadv_tt_global_del_orig_entry - remove and free an orig_entry
+ * _batadv_tt_global_del_orig_entry() - remove and free an orig_entry
  * @tt_global_entry: the global entry to remove the orig_entry from
  * @orig_entry: the orig entry to remove and free
  *
@@ -2226,7 +2226,7 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 }
 
 /**
- * batadv_tt_global_del_orig_node - remove orig_node from a global tt entry
+ * batadv_tt_global_del_orig_node() - remove orig_node from a global tt entry
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_global_entry: the global entry to remove the orig_node from
  * @orig_node: the originator announcing the client
@@ -2305,7 +2305,7 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_del - remove a client from the global table
+ * batadv_tt_global_del() - remove a client from the global table
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: an originator serving this client
  * @addr: the mac address of the client
@@ -2371,8 +2371,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_del_orig - remove all the TT global entries belonging to the
- *  given originator matching the provided vid
+ * batadv_tt_global_del_orig() - remove all the TT global entries belonging to
+ *  the given originator matching the provided vid
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the originator owning the entries to remove
  * @match_vid: the VLAN identifier to match. If negative all the entries will be
@@ -2543,7 +2543,7 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 }
 
 /**
- * batadv_transtable_search - get the mesh destination for a given client
+ * batadv_transtable_search() - get the mesh destination for a given client
  * @bat_priv: the bat priv with all the soft interface information
  * @src: mac address of the source client
  * @addr: mac address of the destination client
@@ -2603,7 +2603,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_crc - calculates the checksum of the local table belonging
+ * batadv_tt_global_crc() - calculates the checksum of the local table belonging
  *  to the given orig_node
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator for which the CRC should be computed
@@ -2698,7 +2698,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_crc - calculates the checksum of the local table
+ * batadv_tt_local_crc() - calculates the checksum of the local table
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: VLAN identifier for which the CRC32 has to be computed
  *
@@ -2755,7 +2755,7 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_req_node_release - free tt_req node entry
+ * batadv_tt_req_node_release() - free tt_req node entry
  * @ref: kref pointer of the tt req_node entry
  */
 static void batadv_tt_req_node_release(struct kref *ref)
@@ -2768,7 +2768,7 @@ static void batadv_tt_req_node_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_req_node_put - decrement the tt_req_node refcounter and
+ * batadv_tt_req_node_put() - decrement the tt_req_node refcounter and
  *  possibly release it
  * @tt_req_node: tt_req_node to be free'd
  */
@@ -2830,7 +2830,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_req_node_new - search and possibly create a tt_req_node object
+ * batadv_tt_req_node_new() - search and possibly create a tt_req_node object
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node this request is being issued for
  *
@@ -2867,7 +2867,7 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_valid - verify that given tt entry is a valid one
+ * batadv_tt_local_valid() - verify that given tt entry is a valid one
  * @entry_ptr: to be checked local tt entry
  * @data_ptr: not used but definition required to satisfy the callback prototype
  *
@@ -2901,7 +2901,7 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 }
 
 /**
- * batadv_tt_tvlv_generate - fill the tvlv buff with the tt entries from the
+ * batadv_tt_tvlv_generate() - fill the tvlv buff with the tt entries from the
  *  specified tt hash
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the tt entries
@@ -2952,7 +2952,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_check_crc - check if all the CRCs are correct
+ * batadv_tt_global_check_crc() - check if all the CRCs are correct
  * @orig_node: originator for which the CRCs have to be checked
  * @tt_vlan: pointer to the first tvlv VLAN entry
  * @num_vlan: number of tvlv VLAN entries
@@ -3009,7 +3009,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_tt_local_update_crc - update all the local CRCs
+ * batadv_tt_local_update_crc() - update all the local CRCs
  * @bat_priv: the bat priv with all the soft interface information
  */
 static void batadv_tt_local_update_crc(struct batadv_priv *bat_priv)
@@ -3025,7 +3025,7 @@ static void batadv_tt_local_update_crc(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_global_update_crc - update all the global CRCs for this orig_node
+ * batadv_tt_global_update_crc() - update all the global CRCs for this orig_node
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the orig_node for which the CRCs have to be updated
  */
@@ -3052,7 +3052,7 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_tt_request - send a TT Request message to a given node
+ * batadv_send_tt_request() - send a TT Request message to a given node
  * @bat_priv: the bat priv with all the soft interface information
  * @dst_orig_node: the destination of the message
  * @ttvn: the version number that the source of the message is looking for
@@ -3141,7 +3141,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_other_tt_response - send reply to tt request concerning another
+ * batadv_send_other_tt_response() - send reply to tt request concerning another
  *  node's translation table
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_data: tt data containing the tt request information
@@ -3274,8 +3274,8 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_my_tt_response - send reply to tt request concerning this node's
- *  translation table
+ * batadv_send_my_tt_response() - send reply to tt request concerning this
+ *  node's translation table
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_data: tt data containing the tt request information
  * @req_src: mac address of tt request sender
@@ -3392,7 +3392,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_send_tt_response - send reply to tt request
+ * batadv_send_tt_response() - send reply to tt request
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_data: tt data containing the tt request information
  * @req_src: mac address of tt request sender
@@ -3488,7 +3488,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_is_my_client - check if a client is served by the local node
+ * batadv_is_my_client() - check if a client is served by the local node
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to check
  * @vid: VLAN identifier
@@ -3518,7 +3518,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 }
 
 /**
- * batadv_handle_tt_response - process incoming tt reply
+ * batadv_handle_tt_response() - process incoming tt reply
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_data: tt data containing the tt request information
  * @resp_src: mac address of tt reply sender
@@ -3611,7 +3611,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_check_roam_count - check if a client has roamed too frequently
+ * batadv_tt_check_roam_count() - check if a client has roamed too frequently
  * @bat_priv: the bat priv with all the soft interface information
  * @client: mac address of the roaming client
  *
@@ -3666,7 +3666,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 }
 
 /**
- * batadv_send_roam_adv - send a roaming advertisement message
+ * batadv_send_roam_adv() - send a roaming advertisement message
  * @bat_priv: the bat priv with all the soft interface information
  * @client: mac address of the roaming client
  * @vid: VLAN identifier
@@ -3748,7 +3748,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_set_flags - set or unset the specified flags on the local
+ * batadv_tt_local_set_flags() - set or unset the specified flags on the local
  *  table and possibly count them in the TT size
  * @bat_priv: the bat priv with all the soft interface information
  * @flags: the flag to switch
@@ -3834,7 +3834,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_commit_changes_nolock - commit all pending local tt changes
+ * batadv_tt_local_commit_changes_nolock() - commit all pending local tt changes
  *  which have been queued in the time since the last commit
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -3867,7 +3867,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_commit_changes - commit all pending local tt changes which
+ * batadv_tt_local_commit_changes() - commit all pending local tt changes which
  *  have been queued in the time since the last commit
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -3913,7 +3913,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 }
 
 /**
- * batadv_tt_update_orig - update global translation table with new tt
+ * batadv_tt_update_orig() - update global translation table with new tt
  *  information received via ogms
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the orig_node of the ogm
@@ -3998,7 +3998,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_client_is_roaming - check if a client is marked as roaming
+ * batadv_tt_global_client_is_roaming() - check if a client is marked as roaming
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to check
  * @vid: VLAN identifier
@@ -4024,7 +4024,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_client_is_roaming - tells whether the client is roaming
+ * batadv_tt_local_client_is_roaming() - tells whether the client is roaming
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the local client to query
  * @vid: VLAN identifier
@@ -4073,7 +4073,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_resize_to_mtu - resize the local translation table fit the
+ * batadv_tt_local_resize_to_mtu() - resize the local translation table fit the
  *  maximum packet size that can be transported through the mesh
  * @soft_iface: netdev struct of the mesh interface
  *
@@ -4114,7 +4114,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
 }
 
 /**
- * batadv_tt_tvlv_ogm_handler_v1 - process incoming tt tvlv container
+ * batadv_tt_tvlv_ogm_handler_v1() - process incoming tt tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
@@ -4153,7 +4153,7 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_tvlv_unicast_handler_v1 - process incoming (unicast) tt tvlv
+ * batadv_tt_tvlv_unicast_handler_v1() - process incoming (unicast) tt tvlv
  *  container
  * @bat_priv: the bat priv with all the soft interface information
  * @src: mac address of tt tvlv sender
@@ -4235,7 +4235,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_roam_tvlv_unicast_handler_v1 - process incoming tt roam tvlv container
+ * batadv_roam_tvlv_unicast_handler_v1() - process incoming tt roam tvlv
+ *  container
  * @bat_priv: the bat priv with all the soft interface information
  * @src: mac address of tt tvlv sender
  * @dst: mac address of tt tvlv recipient
@@ -4285,7 +4286,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_init - initialise the translation table internals
+ * batadv_tt_init() - initialise the translation table internals
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 on success or negative error number in case of failure.
@@ -4321,7 +4322,7 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_global_is_isolated - check if a client is marked as isolated
+ * batadv_tt_global_is_isolated() - check if a client is marked as isolated
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client
  * @vid: the identifier of the VLAN where this client is connected
@@ -4347,7 +4348,7 @@ bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_cache_init - Initialize tt memory object cache
+ * batadv_tt_cache_init() - Initialize tt memory object cache
  *
  * Return: 0 on success or negative error number in case of failure.
  */
@@ -4416,7 +4417,7 @@ int __init batadv_tt_cache_init(void)
 }
 
 /**
- * batadv_tt_cache_destroy - Destroy tt memory object cache
+ * batadv_tt_cache_destroy() - Destroy tt memory object cache
  */
 void batadv_tt_cache_destroy(void)
 {
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 308a0f3117c7..e5857e755ffd 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -45,7 +45,7 @@
 #include "tvlv.h"
 
 /**
- * batadv_tvlv_handler_release - release tvlv handler from lists and queue for
+ * batadv_tvlv_handler_release() - release tvlv handler from lists and queue for
  *  free after rcu grace period
  * @ref: kref pointer of the tvlv
  */
@@ -58,7 +58,7 @@ static void batadv_tvlv_handler_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_handler_put - decrement the tvlv container refcounter and
+ * batadv_tvlv_handler_put() - decrement the tvlv container refcounter and
  *  possibly release it
  * @tvlv_handler: the tvlv handler to free
  */
@@ -68,7 +68,7 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 }
 
 /**
- * batadv_tvlv_handler_get - retrieve tvlv handler from the tvlv handler list
+ * batadv_tvlv_handler_get() - retrieve tvlv handler from the tvlv handler list
  *  based on the provided type and version (both need to match)
  * @bat_priv: the bat priv with all the soft interface information
  * @type: tvlv handler type to look for
@@ -102,7 +102,7 @@ batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 }
 
 /**
- * batadv_tvlv_container_release - release tvlv from lists and free
+ * batadv_tvlv_container_release() - release tvlv from lists and free
  * @ref: kref pointer of the tvlv
  */
 static void batadv_tvlv_container_release(struct kref *ref)
@@ -114,7 +114,7 @@ static void batadv_tvlv_container_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_container_put - decrement the tvlv container refcounter and
+ * batadv_tvlv_container_put() - decrement the tvlv container refcounter and
  *  possibly release it
  * @tvlv: the tvlv container to free
  */
@@ -124,7 +124,7 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 }
 
 /**
- * batadv_tvlv_container_get - retrieve tvlv container from the tvlv container
+ * batadv_tvlv_container_get() - retrieve tvlv container from the tvlv container
  *  list based on the provided type and version (both need to match)
  * @bat_priv: the bat priv with all the soft interface information
  * @type: tvlv container type to look for
@@ -158,7 +158,7 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 }
 
 /**
- * batadv_tvlv_container_list_size - calculate the size of the tvlv container
+ * batadv_tvlv_container_list_size() - calculate the size of the tvlv container
  *  list entries
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -183,8 +183,8 @@ static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tvlv_container_remove - remove tvlv container from the tvlv container
- *  list
+ * batadv_tvlv_container_remove() - remove tvlv container from the tvlv
+ *  container list
  * @bat_priv: the bat priv with all the soft interface information
  * @tvlv: the to be removed tvlv container
  *
@@ -207,7 +207,7 @@ static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_container_unregister - unregister tvlv container based on the
+ * batadv_tvlv_container_unregister() - unregister tvlv container based on the
  *  provided type and version (both need to match)
  * @bat_priv: the bat priv with all the soft interface information
  * @type: tvlv container type to unregister
@@ -225,7 +225,7 @@ void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_container_register - register tvlv type, version and content
+ * batadv_tvlv_container_register() - register tvlv type, version and content
  *  to be propagated with each (primary interface) OGM
  * @bat_priv: the bat priv with all the soft interface information
  * @type: tvlv container type
@@ -270,7 +270,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_realloc_packet_buff - reallocate packet buffer to accommodate
+ * batadv_tvlv_realloc_packet_buff() - reallocate packet buffer to accommodate
  *  requested packet size
  * @packet_buff: packet buffer
  * @packet_buff_len: packet buffer size
@@ -303,7 +303,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
 }
 
 /**
- * batadv_tvlv_container_ogm_append - append tvlv container content to given
+ * batadv_tvlv_container_ogm_append() - append tvlv container content to given
  *  OGM packet buffer
  * @bat_priv: the bat priv with all the soft interface information
  * @packet_buff: ogm packet buffer
@@ -356,7 +356,7 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_call_handler - parse the given tvlv buffer to call the
+ * batadv_tvlv_call_handler() - parse the given tvlv buffer to call the
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
  * @tvlv_handler: tvlv callback function handling the tvlv content
@@ -410,7 +410,7 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_containers_process - parse the given tvlv buffer to call the
+ * batadv_tvlv_containers_process() - parse the given tvlv buffer to call the
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
  * @ogm_source: flag indicating whether the tvlv is an ogm or a unicast packet
@@ -477,7 +477,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_ogm_receive - process an incoming ogm and call the appropriate
+ * batadv_tvlv_ogm_receive() - process an incoming ogm and call the appropriate
  *  handlers
  * @bat_priv: the bat priv with all the soft interface information
  * @batadv_ogm_packet: ogm packet containing the tvlv containers
@@ -504,7 +504,7 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_handler_register - register tvlv handler based on the provided
+ * batadv_tvlv_handler_register() - register tvlv handler based on the provided
  *  type and version (both need to match) for ogm tvlv payload and/or unicast
  *  payload
  * @bat_priv: the bat priv with all the soft interface information
@@ -559,7 +559,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_handler_unregister - unregister tvlv handler based on the
+ * batadv_tvlv_handler_unregister() - unregister tvlv handler based on the
  *  provided type and version (both need to match)
  * @bat_priv: the bat priv with all the soft interface information
  * @type: tvlv handler type to be unregistered
@@ -582,7 +582,7 @@ void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_unicast_send - send a unicast packet with tvlv payload to the
+ * batadv_tvlv_unicast_send() - send a unicast packet with tvlv payload to the
  *  specified host
  * @bat_priv: the bat priv with all the soft interface information
  * @src: source mac address of the unicast packet
-- 
2.11.0

