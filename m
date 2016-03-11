Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 16:36:19 +0100
Message-Id: <1457710579-4028-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: fix wrong names in kerneldoc
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
Cc: Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

Signed-off-by: Antonio Quartulli <a@unstable.cc>
[sven@narfation.org: Fix additional names]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - add 11 more name fixes for kernel-doc

Antonio wanted to resend this patch himself [1] but this didn't happen until
now.

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014624.html


 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/icmp_socket.c           |  2 +-
 net/batman-adv/main.h                  |  3 ++-
 net/batman-adv/multicast.c             | 11 ++++++-----
 net/batman-adv/originator.c            |  2 +-
 net/batman-adv/packet.h                |  2 +-
 net/batman-adv/soft-interface.c        |  2 +-
 8 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 642167f..f0075ff 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1576,7 +1576,7 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 }
 
 /**
- * batadv_bla_init - free all bla structures
+ * batadv_bla_free - free all bla structures
  * @bat_priv: the bat priv with all the soft interface information
  *
  * for softinterface free or module unload
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 919a8d2..ab79f3a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -717,7 +717,7 @@ void batadv_dat_status_update(struct net_device *net_dev)
 }
 
 /**
- * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv container
+ * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 14d0013..df449a0 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -337,7 +337,7 @@ err:
 }
 
 /**
- * batadv_socket_receive_packet - schedule an icmp packet to be sent to
+ * batadv_socket_add_packet - schedule an icmp packet to be sent to
  *  userspace on an icmp socket.
  * @socket_client: the socket this packet belongs to
  * @icmph: pointer to the header of the icmp packet
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e602408..1565df0 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -296,7 +296,8 @@ static inline bool batadv_compare_eth(const void *data1, const void *data2)
 }
 
 /**
- * has_timed_out - compares current time (jiffies) and timestamp + timeout
+ * batadv_has_timed_out - compares current time (jiffies) and timestamp +
+ *  timeout
  * @timestamp:		base value to compare with (in jiffies)
  * @timeout:		added to base value before comparing (in milliseconds)
  *
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8caa2c7..c32f24f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -394,7 +394,8 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_want_all_ip_count - count nodes with unspecific mcast interest
+ * batadv_mcast_forw_want_all_ip_count - count nodes with unspecific mcast
+ *  interest
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: ethernet header of a packet
  *
@@ -433,7 +434,7 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_want_forw_ipv4_node_get - get a node with an ipv4 flag
+ * batadv_mcast_forw_ipv4_node_get - get a node with an ipv4 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set and
@@ -460,7 +461,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_want_forw_ipv6_node_get - get a node with an ipv6 flag
+ * batadv_mcast_forw_ipv6_node_get - get a node with an ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
@@ -487,7 +488,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_want_forw_ip_node_get - get a node with an ipv4/ipv6 flag
+ * batadv_mcast_forw_ip_node_get - get a node with an ipv4/ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: an ethernet header to determine the protocol family from
  *
@@ -511,7 +512,7 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_want_forw_unsnoop_node_get - get a node with an unsnoopable flag
+ * batadv_mcast_forw_unsnoop_node_get - get a node with an unsnoopable flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e63d6a5..84d5a1e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -289,7 +289,7 @@ void batadv_neigh_node_put(struct batadv_neigh_node *neigh_node)
 }
 
 /**
- * batadv_orig_node_get_router - router to the originator depending on iface
+ * batadv_orig_router_get - router to the originator depending on iface
  * @orig_node: the orig node for the router
  * @if_outgoing: the interface where the payload packet has been received or
  *  the OGM should be sent to
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 8a8d7ca..0796dfd 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -501,7 +501,7 @@ struct batadv_coded_packet {
 #pragma pack()
 
 /**
- * struct batadv_unicast_tvlv - generic unicast packet with tvlv payload
+ * struct batadv_unicast_tvlv_packet - generic unicast packet with tvlv payload
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7679f3a..bae24c0 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -539,7 +539,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_create_vlan - allocate the needed resources for a new vlan
+ * batadv_softif_create_vlan - allocate the needed resources for a new vlan
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  *
-- 
2.7.0

