Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 19 Apr 2013 18:07:01 +0200
Message-Id: <1366387621-12718-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366387621-12718-1-git-send-email-ordex@autistici.org>
References: <1366387621-12718-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: print the VID properly
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Since the MSB bits of any vid variable are now used for
storing flags, print the vid properly by taking the flags
away and printing -1 in case of VID representing no real
VLAN.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bridge_loop_avoidance.c | 36 ++++++++++++++++++++----------------
 main.h                  |  2 ++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index d75fb80..fc0f29c 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -307,7 +307,8 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		 */
 		memcpy(ethhdr->h_source, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): CLAIM %pM on vid %d\n", mac, vid);
+			   "bla_send_claim(): CLAIM %pM on vid %d\n", mac,
+			   BATADV_PRINT_VID(vid));
 		break;
 	case BATADV_CLAIM_TYPE_UNCLAIM:
 		/* unclaim frame
@@ -316,7 +317,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		memcpy(hw_src, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): UNCLAIM %pM on vid %d\n", mac,
-			   vid);
+			   BATADV_PRINT_VID(vid));
 		break;
 	case BATADV_CLAIM_TYPE_ANNOUNCE:
 		/* announcement frame
@@ -325,7 +326,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		memcpy(hw_src, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): ANNOUNCE of %pM on vid %d\n",
-			   ethhdr->h_source, vid);
+			   ethhdr->h_source, BATADV_PRINT_VID(vid));
 		break;
 	case BATADV_CLAIM_TYPE_REQUEST:
 		/* request frame
@@ -336,7 +337,8 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		memcpy(ethhdr->h_dest, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): REQUEST of %pM to %pM on vid %d\n",
-			   ethhdr->h_source, ethhdr->h_dest, vid);
+			   ethhdr->h_source, ethhdr->h_dest,
+			   BATADV_PRINT_VID(vid));
 		break;
 	}
 
@@ -380,7 +382,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "bla_get_backbone_gw(): not found (%pM, %d), creating new entry\n",
-		   orig, vid);
+		   orig, BATADV_PRINT_VID(vid));
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
@@ -572,7 +574,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		atomic_set(&claim->refcount, 2);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
-			   mac, vid);
+			   mac, BATADV_PRINT_VID(vid));
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
@@ -591,7 +593,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
-			   mac, vid);
+			   mac, BATADV_PRINT_VID(vid));
 
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 		batadv_backbone_gw_free_ref(claim->backbone_gw);
@@ -622,7 +624,7 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 		return;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n",
-		   mac, vid);
+		   mac, BATADV_PRINT_VID(vid));
 
 	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
 			   batadv_choose_claim, claim);
@@ -658,12 +660,12 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
-		   vid, backbone_gw->orig, crc);
+		   BATADV_PRINT_VID(vid), backbone_gw->orig, crc);
 
 	if (backbone_gw->crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "handle_announce(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
-			   backbone_gw->orig, backbone_gw->vid,
+			   backbone_gw->orig, BATADV_PRINT_VID(backbone_gw->vid),
 			   backbone_gw->crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
@@ -699,7 +701,7 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "handle_request(): REQUEST vid %d (sent by %pM)...\n",
-		   vid, ethhdr->h_source);
+		   BATADV_PRINT_VID(vid), ethhdr->h_source);
 
 	batadv_bla_answer_request(bat_priv, primary_if, vid);
 	return 1;
@@ -727,7 +729,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 	/* this must be an UNCLAIM frame */
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "handle_unclaim(): UNCLAIM %pM on vid %d (sent by %pM)...\n",
-		   claim_addr, vid, backbone_gw->orig);
+		   claim_addr, BATADV_PRINT_VID(vid), backbone_gw->orig);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
 	batadv_backbone_gw_free_ref(backbone_gw);
@@ -911,7 +913,8 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	if (ret == 1)
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
-			   ethhdr->h_source, vid, hw_src, hw_dst);
+			   ethhdr->h_source, BATADV_PRINT_VID(vid), hw_src,
+			   hw_dst);
 
 	if (ret < 2)
 		return ret;
@@ -946,7 +949,7 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "bla_process_claim(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
-		   ethhdr->h_source, vid, hw_src, hw_dst);
+		   ethhdr->h_source, BATADV_PRINT_VID(vid), hw_src, hw_dst);
 	return 1;
 }
 
@@ -1627,7 +1630,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 			is_own = batadv_compare_eth(claim->backbone_gw->orig,
 						    primary_addr);
 			seq_printf(seq, " * %pM on %5u by %pM [%c] (%#.4x)\n",
-				   claim->addr, claim->vid,
+				   claim->addr, BATADV_PRINT_VID(claim->vid),
 				   claim->backbone_gw->orig,
 				   (is_own ? 'x' : ' '),
 				   claim->backbone_gw->crc);
@@ -1680,7 +1683,8 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 				continue;
 
 			seq_printf(seq, " * %pM on %5d %4i.%03is (%#.4x)\n",
-				   backbone_gw->orig, backbone_gw->vid, secs,
+				   backbone_gw->orig,
+				   BATADV_PRINT_VID(backbone_gw->vid), secs,
 				   msecs, backbone_gw->crc);
 		}
 		rcu_read_unlock();
diff --git a/main.h b/main.h
index 7fce4f0..5de3a51 100644
--- a/main.h
+++ b/main.h
@@ -174,6 +174,8 @@ enum batadv_vlan_flags {
 
 /* mask needed to extract the vlan ID (12bits) from a 16bits variable */
 #define BATADV_VID_MASK	0x0FFF
+#define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
+			       (int)(vid & BATADV_VID_MASK) : -1)
 
 extern char batadv_routing_algo[];
 extern struct list_head batadv_hardif_list;
-- 
1.8.1.5

