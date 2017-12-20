Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:20 +0100
Message-Id: <20171220110124.13117-16-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 15/19] batman-adv: Fix kernel-doc references
 to struct members
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

The correct syntax to create references in kernel-doc to a struct member is
not "struct_name::member"" but "&struct_name->member" or
"&struct_name.member". The correct syntax is required to get the correct
cross-referencing in the reStructuredText text output.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c39f879d7dde..77b145eba193 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -234,7 +234,7 @@ struct batadv_hard_iface {
  * struct batadv_orig_ifinfo - originator info per outgoing interface
  */
 struct batadv_orig_ifinfo {
-	/** @list: list node for orig_node::ifinfo_list */
+	/** @list: list node for &batadv_orig_node.ifinfo_list */
 	struct hlist_node list;
 
 	/** @if_outgoing: pointer to outgoing hard-interface */
@@ -320,7 +320,7 @@ struct batadv_orig_node_vlan {
 	/** @tt: VLAN specific TT attributes */
 	struct batadv_vlan_tt tt;
 
-	/** @list: list node for orig_node::vlan_list */
+	/** @list: list node for &batadv_orig_node.vlan_list */
 	struct hlist_node list;
 
 	/**
@@ -467,7 +467,7 @@ struct batadv_orig_node {
 	 */
 	spinlock_t neigh_list_lock;
 
-	/** @hash_entry: hlist node for batadv_priv::orig_hash */
+	/** @hash_entry: hlist node for &batadv_priv.orig_hash */
 	struct hlist_node hash_entry;
 
 	/** @bat_priv: pointer to soft_iface this orig node belongs to */
@@ -539,7 +539,7 @@ enum batadv_orig_capabilities {
  * struct batadv_gw_node - structure for orig nodes announcing gw capabilities
  */
 struct batadv_gw_node {
-	/** @list: list node for batadv_priv_gw::list */
+	/** @list: list node for &batadv_priv_gw.list */
 	struct hlist_node list;
 
 	/** @orig_node: pointer to corresponding orig node */
@@ -588,7 +588,7 @@ struct batadv_hardif_neigh_node_bat_v {
  * struct batadv_hardif_neigh_node - unique neighbor per hard-interface
  */
 struct batadv_hardif_neigh_node {
-	/** @list: list node for batadv_hard_iface::neigh_list */
+	/** @list: list node for &batadv_hard_iface.neigh_list */
 	struct hlist_node list;
 
 	/** @addr: the MAC address of the neighboring interface */
@@ -621,7 +621,7 @@ struct batadv_hardif_neigh_node {
  * struct batadv_neigh_node - structure for single hops neighbors
  */
 struct batadv_neigh_node {
-	/** @list: list node for batadv_orig_node::neigh_list */
+	/** @list: list node for &batadv_orig_node.neigh_list */
 	struct hlist_node list;
 
 	/** @orig_node: pointer to corresponding orig_node */
@@ -697,7 +697,7 @@ struct batadv_neigh_ifinfo_bat_v {
  * struct batadv_neigh_ifinfo - neighbor information per outgoing interface
  */
 struct batadv_neigh_ifinfo {
-	/** @list: list node for batadv_neigh_node::ifinfo_list */
+	/** @list: list node for &batadv_neigh_node.ifinfo_list */
 	struct hlist_node list;
 
 	/** @if_outgoing: pointer to outgoing hard-interface */
@@ -1308,7 +1308,7 @@ struct batadv_tp_unacked {
 	/** @len: length of the packet */
 	u16 len;
 
-	/** @list: list node for batadv_tp_vars::unacked_list */
+	/** @list: list node for &batadv_tp_vars.unacked_list */
 	struct list_head list;
 };
 
@@ -1327,7 +1327,7 @@ enum batadv_tp_meter_role {
  * struct batadv_tp_vars - tp meter private variables per session
  */
 struct batadv_tp_vars {
-	/** @list: list node for bat_priv::tp_list */
+	/** @list: list node for &bat_priv.tp_list */
 	struct hlist_node list;
 
 	/** @timer: timer for ack (receiver) and retry (sender) */
@@ -1459,7 +1459,7 @@ struct batadv_softif_vlan {
 	/** @tt: TT private attributes (VLAN specific) */
 	struct batadv_vlan_tt tt;
 
-	/** @list: list node for bat_priv::softif_vlan_list */
+	/** @list: list node for &bat_priv.softif_vlan_list */
 	struct hlist_node list;
 
 	/**
@@ -1727,7 +1727,7 @@ struct batadv_socket_client {
  * struct batadv_socket_packet - layer2 icmp packet for socket client
  */
 struct batadv_socket_packet {
-	/** @list: list node for batadv_socket_client::queue_list */
+	/** @list: list node for &batadv_socket_client.queue_list */
 	struct list_head list;
 
 	/** @icmp_len: size of the layer2 icmp packet */
@@ -1752,7 +1752,7 @@ struct batadv_bla_backbone_gw {
 	/** @vid: vlan id this gateway was detected on */
 	unsigned short vid;
 
-	/** @hash_entry: hlist node for batadv_priv_bla::backbone_hash */
+	/** @hash_entry: hlist node for &batadv_priv_bla.backbone_hash */
 	struct hlist_node hash_entry;
 
 	/** @bat_priv: pointer to soft_iface this backbone gateway belongs to */
@@ -1810,7 +1810,7 @@ struct batadv_bla_claim {
 	/** @lasttime: last time we heard of claim (locals only) */
 	unsigned long lasttime;
 
-	/** @hash_entry: hlist node for batadv_priv_bla::claim_hash */
+	/** @hash_entry: hlist node for &batadv_priv_bla.claim_hash */
 	struct hlist_node hash_entry;
 
 	/** @refcount: number of contexts the object is used */
@@ -1832,8 +1832,8 @@ struct batadv_tt_common_entry {
 	unsigned short vid;
 
 	/**
-	 * @hash_entry: hlist node for batadv_priv_tt::local_hash or for
-	 *  batadv_priv_tt::global_hash
+	 * @hash_entry: hlist node for &batadv_priv_tt.local_hash or for
+	 *  &batadv_priv_tt.global_hash
 	 */
 	struct hlist_node hash_entry;
 
@@ -1900,7 +1900,7 @@ struct batadv_tt_orig_list_entry {
 	/** @flags: per orig entry TT sync flags */
 	u8 flags;
 
-	/** @list: list node for batadv_tt_global_entry::orig_list */
+	/** @list: list node for &batadv_tt_global_entry.orig_list */
 	struct hlist_node list;
 
 	/** @refcount: number of contexts the object is used */
@@ -1914,7 +1914,7 @@ struct batadv_tt_orig_list_entry {
  * struct batadv_tt_change_node - structure for tt changes occurred
  */
 struct batadv_tt_change_node {
-	/** @list: list node for batadv_priv_tt::changes_list */
+	/** @list: list node for &batadv_priv_tt.changes_list */
 	struct list_head list;
 
 	/** @change: holds the actual translation table diff data */
@@ -1936,7 +1936,7 @@ struct batadv_tt_req_node {
 	/** @refcount: number of contexts the object is used by */
 	struct kref refcount;
 
-	/** @list: list node for batadv_priv_tt::req_list */
+	/** @list: list node for &batadv_priv_tt.req_list */
 	struct hlist_node list;
 };
 
@@ -1958,7 +1958,7 @@ struct batadv_tt_roam_node {
 	 */
 	unsigned long first_time;
 
-	/** @list: list node for batadv_priv_tt::roam_list */
+	/** @list: list node for &batadv_priv_tt.roam_list */
 	struct list_head list;
 };
 
@@ -2060,7 +2060,10 @@ struct batadv_skb_cb {
  * struct batadv_forw_packet - structure for bcast packets to be sent/forwarded
  */
 struct batadv_forw_packet {
-	/** @list: list node for batadv_priv::forw_{bat,bcast}_list */
+	/**
+	 * @list: list node for &batadv_priv.forw.bcast_list and
+	 *  &batadv_priv.forw.bat_list
+	 */
 	struct hlist_node list;
 
 	/** @cleanup_list: list node for purging functions */
@@ -2290,7 +2293,7 @@ struct batadv_dat_entry {
 	 */
 	unsigned long last_update;
 
-	/** @hash_entry: hlist node for batadv_priv_dat::hash */
+	/** @hash_entry: hlist node for &batadv_priv_dat.hash */
 	struct hlist_node hash_entry;
 
 	/** @refcount: number of contexts the object is used */
@@ -2334,7 +2337,7 @@ struct batadv_dat_candidate {
  * struct batadv_tvlv_container - container for tvlv appended to OGMs
  */
 struct batadv_tvlv_container {
-	/** @list: hlist node for batadv_priv_tvlv::container_list */
+	/** @list: hlist node for &batadv_priv_tvlv.container_list */
 	struct hlist_node list;
 
 	/** @tvlv_hdr: tvlv header information needed to construct the tvlv */
@@ -2348,7 +2351,7 @@ struct batadv_tvlv_container {
  * struct batadv_tvlv_handler - handler for specific tvlv type and version
  */
 struct batadv_tvlv_handler {
-	/** @list: hlist node for batadv_priv_tvlv::handler_list */
+	/** @list: hlist node for &batadv_priv_tvlv.handler_list */
 	struct hlist_node list;
 
 	/**
-- 
2.11.0

