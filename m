Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:46 +0200
Message-Id: <1441568333-15947-3-git-send-email-sven@narfation.org>
In-Reply-To: <1441568333-15947-1-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/9] batman-adv: Fix kerneldoc member names
	in for main structs
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6e8515c..409b0bb 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -218,12 +218,12 @@ struct batadv_orig_bat_iv {
  * @orig: originator ethernet address
  * @ifinfo_list: list for routers per outgoing interface
  * @last_bonding_candidate: pointer to last ifinfo of last used router
- * @batadv_dat_addr_t:  address of the orig node in the distributed hash
+ * @dat_addr:  address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @mcast_handler_lock: synchronizes mcast-capability and -flag changes
  * @mcast_flags: multicast flags announced by the orig node
- * @mcast_want_all_unsnoop_node: a list node for the
+ * @mcast_want_all_unsnoopables_node: a list node for the
  *  mcast.want_all_unsnoopables list
  * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 list
  * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 list
@@ -405,7 +405,7 @@ struct batadv_neigh_ifinfo {
 
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
- * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
+ * @orig: mac address of orig node orginating the broadcast
  * @crc: crc32 checksum of broadcast payload
  * @entrytime: time when the broadcast packet was received
  */
@@ -554,7 +554,7 @@ struct batadv_priv_tt {
 
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
- * @num_requests; number of bla requests in flight
+ * @num_requests: number of bla requests in flight
  * @claim_hash: hash table containing mesh nodes this host has claimed
  * @backbone_hash: hash table containing all detected backbone gateways
  * @bcast_duplist: recently received broadcast packets array (for broadcast
@@ -777,7 +777,7 @@ struct batadv_softif_vlan {
  * @dat: distributed arp table data
  * @mcast: multicast data
  * @network_coding: bool indicating whether network coding is enabled
- * @batadv_priv_nc: network coding data
+ * @nc: network coding data
  */
 struct batadv_priv {
 	atomic_t mesh_state;
@@ -910,7 +910,7 @@ struct batadv_bla_backbone_gw {
  * struct batadv_bla_claim - claimed non-mesh client structure
  * @addr: mac address of claimed non-mesh client
  * @vid: vlan id this client was detected on
- * @batadv_bla_backbone_gw: pointer to backbone gw claiming this client
+ * @backbone_gw: pointer to backbone gw claiming this client
  * @lasttime: last time we heard of claim (locals only)
  * @hash_entry: hlist node for batadv_priv_bla::claim_hash
  * @refcount: number of contexts the object is used
-- 
2.5.1

