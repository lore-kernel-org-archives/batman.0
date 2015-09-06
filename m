Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:50 +0200
Message-Id: <1441568333-15947-7-git-send-email-sven@narfation.org>
In-Reply-To: <1441568333-15947-1-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Remove kerneldoc for missing
	parameters
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
 net/batman-adv/fragmentation.c     | 1 -
 net/batman-adv/packet.h            | 1 -
 net/batman-adv/routing.c           | 1 -
 net/batman-adv/translation-table.c | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 700c96c..0934b0c 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -242,7 +242,6 @@ err:
 /**
  * batadv_frag_merge_packets - merge a chain of fragments
  * @chain: head of chain with fragments
- * @skb: packet with total size of skb after merging
  *
  * Expand the first skb in the chain and copy the content of the remaining
  * skb's into the expanded one. After doing so, clear the chain.
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index c5973a1..456b54e 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -414,7 +414,6 @@ struct batadv_bcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
- * @reserved: Align following fields to 2-byte boundaries
  * @first_source: original source of first included packet
  * @first_orig_dest: original destinal of first included packet
  * @first_crc: checksum of first included packet
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 8d990b0..68e46d6 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -893,7 +893,6 @@ rx_success:
  * batadv_recv_unicast_tvlv - receive and process unicast tvlv packets
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
- * @dst_addr: the payload destination
  *
  * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
  * otherwise.
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4228b10..73a4d89 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -215,7 +215,6 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
- * @hash: hash table containing the tt entries
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -300,7 +299,6 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_size_mod - change the size by v of the local table
  *  identified by vid
- * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -2400,7 +2398,6 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
  * @orig_node: originator for which the CRCs have to be checked
  * @tt_vlan: pointer to the first tvlv VLAN entry
  * @num_vlan: number of tvlv VLAN entries
- * @create: if true, create VLAN objects if not found
  *
  * Return true if all the received CRCs match the locally stored ones, false
  * otherwise
@@ -3355,7 +3352,6 @@ out:
  * @tt_change: pointer to the first entry in the TT buffer
  * @tt_num_changes: number of tt changes inside the tt buffer
  * @ttvn: translation table version number of this changeset
- * @tt_crc: crc32 checksum of orig node's translation table
  */
 static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
-- 
2.5.1

