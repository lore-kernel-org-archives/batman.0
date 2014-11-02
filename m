Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  2 Nov 2014 11:29:56 +0100
Message-Id: <1414924197-24141-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix misspelled words
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Reported-by: checkpatch
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 CHANGELOG               | 2 +-
 bridge_loop_avoidance.c | 4 ++--
 main.c                  | 2 +-
 packet.h                | 4 ++--
 routing.c               | 2 +-
 translation-table.c     | 2 +-
 types.h                 | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a91e233..affb823 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -248,7 +248,7 @@ batman-adv 2011.4.0:
 batman-adv 2011.3.1:
 
 * don't send all packets to selected gateway as broadcast
-* prevent translation table corruptions caused by unintialized memory and
+* prevent translation table corruptions caused by uninitialized memory and
   invalid sizes send through client announcement mechanism
 
  -- Tue, 18 Oct 2011 20:40:59 +0200
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 4fc6cab..ac4b96e 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -244,7 +244,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 		spin_unlock_bh(list_lock);
 	}
 
-	/* all claims gone, intialize CRC */
+	/* all claims gone, initialize CRC */
 	backbone_gw->crc = BATADV_BLA_CRC_INIT;
 }
 
@@ -1328,7 +1328,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		goto out;
 	}
 	/* not found, add a new entry (overwrite the oldest entry)
-	 * and allow it, its the first occurence.
+	 * and allow it, its the first occurrence.
 	 */
 	curr = (bat_priv->bla.bcast_duplist_curr + BATADV_DUPLIST_SIZE - 1);
 	curr %= BATADV_DUPLIST_SIZE;
diff --git a/main.c b/main.c
index d4079cd..6f48cdb 100644
--- a/main.c
+++ b/main.c
@@ -795,7 +795,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tvlv_realloc_packet_buff - reallocate packet buffer to accomodate
+ * batadv_tvlv_realloc_packet_buff - reallocate packet buffer to accommodate
  *  requested packet size
  * @packet_buff: packet buffer
  * @packet_buff_len: packet buffer size
diff --git a/packet.h b/packet.h
index facd1fe..b81fbbf 100644
--- a/packet.h
+++ b/packet.h
@@ -377,7 +377,7 @@ struct batadv_frag_packet {
 	uint8_t reserved:4;
 	uint8_t no:4;
 #else
-#error "unknown bitfield endianess"
+#error "unknown bitfield endianness"
 #endif
 	uint8_t dest[ETH_ALEN];
 	uint8_t orig[ETH_ALEN];
@@ -453,7 +453,7 @@ struct batadv_coded_packet {
  * @src: address of the source
  * @dst: address of the destination
  * @tvlv_len: length of tvlv data following the unicast tvlv header
- * @align: 2 bytes to align the header to a 4 byte boundry
+ * @align: 2 bytes to align the header to a 4 byte boundary
  */
 struct batadv_unicast_tvlv_packet {
 	uint8_t  packet_type;
diff --git a/routing.c b/routing.c
index 3a6764d..e5f2ccd 100644
--- a/routing.c
+++ b/routing.c
@@ -454,7 +454,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	 * the last chosen bonding candidate (next_candidate). If no such
 	 * router is found, use the first candidate found (the previously
 	 * chosen bonding candidate might have been the last one in the list).
-	 * If this can't be found either, return the previously choosen
+	 * If this can't be found either, return the previously chosen
 	 * router - obviously there are no other candidates.
 	 */
 	rcu_read_lock();
diff --git a/translation-table.c b/translation-table.c
index 84e6f01..07b263a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2852,7 +2852,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 /**
  * batadv_is_my_client - check if a client is served by the local node
  * @bat_priv: the bat priv with all the soft interface information
- * @addr: the mac adress of the client to check
+ * @addr: the mac address of the client to check
  * @vid: VLAN identifier
  *
  * Returns true if the client is served by this node, false otherwise.
diff --git a/types.h b/types.h
index 462a70c..9398c3f 100644
--- a/types.h
+++ b/types.h
@@ -968,7 +968,7 @@ struct batadv_tt_orig_list_entry {
 };
 
 /**
- * struct batadv_tt_change_node - structure for tt changes occured
+ * struct batadv_tt_change_node - structure for tt changes occurred
  * @list: list node for batadv_priv_tt::changes_list
  * @change: holds the actual translation table diff data
  */
-- 
2.1.3

