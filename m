Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 Jul 2012 10:13:52 +0200
Message-Id: <1342167232-7469-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix (nearly-)kernel-doc comments
	for various functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Ben Hutchings <bhutchings@solarflare.com>

Fix incorrect start markers, wrapped summary lines, missing section
breaks, incorrect separators, and some name mismatches.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is already part of net-next


 bridge_loop_avoidance.c |   51 +++++++++++++++++++++++++++++++----------------
 hash.h                  |    3 ++-
 main.h                  |    3 ++-
 types.h                 |    3 ++-
 4 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index e350ea4..6705d35 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -162,12 +162,13 @@ static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
 	return claim_tmp;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_backbone_hash_find - looks for a claim in the hash
+ * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
- * looks for a claim in the hash, and returns it if found
- * or NULL otherwise.
+ * Returns claim if found or NULL otherwise.
  */
 static struct batadv_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv,
@@ -242,12 +243,12 @@ batadv_bla_del_backbone_claims(struct batadv_backbone_gw *backbone_gw)
 	backbone_gw->crc = BATADV_BLA_CRC_INIT;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_send_claim - sends a claim frame according to the provided info
+ * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address to be announced within the claim
  * @vid: the VLAN ID
  * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
- *
- * sends a claim frame according to the provided info.
  */
 static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 				  short vid, int claimtype)
@@ -348,7 +349,9 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_get_backbone_gw
+ * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
  *
@@ -520,12 +523,12 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_add_claim - Adds a claim in the claim hash
+ * @bat_priv: the bat priv with all the soft interface information
  * @mac: the mac address of the claim
  * @vid: the VLAN ID of the frame
  * @backbone_gw: the backbone gateway which claims it
- *
- * Adds a claim in the claim hash.
  */
 static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 				 const uint8_t *mac, const short vid,
@@ -743,7 +746,9 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 	return 1;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_check_claim_group
+ * @bat_priv: the bat priv with all the soft interface information
  * @hw_src: the Hardware source in the ARP Header
  * @hw_dst: the Hardware destination in the ARP Header
  * @ethhdr: pointer to the Ethernet header of the claim frame
@@ -975,7 +980,9 @@ purge_now:
 	}
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_purge_claims
+ * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the selected primary interface, may be NULL if now is set
  * @now: whether the whole hash shall be wiped now
  *
@@ -1023,7 +1030,9 @@ purge_now:
 	}
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_update_orig_address
+ * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the new selected primary_if
  * @oldif: the old primary interface, may be NULL
  *
@@ -1193,7 +1202,9 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_check_bcast_duplist
+ * @bat_priv: the bat priv with all the soft interface information
  * @bcast_packet: originator mac address
  * @hdr_size: maximum length of the frame
  *
@@ -1297,7 +1308,9 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 }
 
 
-/* @skb: the frame to be checked
+/**
+ * batadv_bla_is_backbone_gw
+ * @skb: the frame to be checked
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
@@ -1363,7 +1376,9 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 		batadv_hardif_free_ref(primary_if);
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_rx
+ * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
  * @is_bcast: the packet came in a broadcast packet type.
@@ -1457,7 +1472,9 @@ out:
 	return ret;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * batadv_bla_tx
+ * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
  *
diff --git a/hash.h b/hash.h
index 83990e3..977de9c 100644
--- a/hash.h
+++ b/hash.h
@@ -81,7 +81,8 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 	batadv_hash_destroy(hash);
 }
 
-/*	hash_add - adds data to the hashtable
+/**
+ *	batadv_hash_add - adds data to the hashtable
  *	@hash: storage hash table
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
diff --git a/main.h b/main.h
index 6dca9c4..c88e18e 100644
--- a/main.h
+++ b/main.h
@@ -218,7 +218,8 @@ static inline int batadv_compare_eth(const void *data1, const void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
-/* has_timed_out - compares current time (jiffies) and timestamp + timeout
+/**
+ * has_timed_out - compares current time (jiffies) and timestamp + timeout
  * @timestamp:		base value to compare with (in jiffies)
  * @timeout:		added to base value before comparing (in milliseconds)
  *
diff --git a/types.h b/types.h
index 2141c13..12635fd 100644
--- a/types.h
+++ b/types.h
@@ -44,7 +44,8 @@ struct batadv_hard_iface {
 	struct rcu_head rcu;
 };
 
-/*	batadv_orig_node - structure for orig_list maintaining nodes of mesh
+/**
+ *	struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
  *	@last_seen: when last packet from this node was received
  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
-- 
1.7.10.4

