Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 18 Apr 2013 15:43:47 +0200
Message-Id: <1366292627-6417-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366292627-6417-1-git-send-email-ordex@autistici.org>
References: <1366292627-6417-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: print the VID properly
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
 bridge_loop_avoidance.c | 57 ++++++++++++++++++++++++++-----------------------
 main.h                  |  2 ++
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 16f9239..24a62ac 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -307,7 +307,8 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		 */
 		memcpy(ethhdr->h_source, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): CLAIM %pM on vid %hu\n", mac, vid);
+			   "bla_send_claim(): CLAIM %pM on vid %hd\n", mac,
+			   BATADV_PRINT_VID(vid));
 		break;
 	case BATADV_CLAIM_TYPE_UNCLAIM:
 		/* unclaim frame
@@ -315,8 +316,8 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): UNCLAIM %pM on vid %hu\n", mac,
-			   vid);
+			   "bla_send_claim(): UNCLAIM %pM on vid %hd\n", mac,
+			   BATADV_PRINT_VID(vid));
 		break;
 	case BATADV_CLAIM_TYPE_ANNOUNCE:
 		/* announcement frame
@@ -324,8 +325,8 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): ANNOUNCE of %pM on vid %hu\n",
-			   ethhdr->h_source, vid);
+			   "bla_send_claim(): ANNOUNCE of %pM on vid %hd\n",
+			   ethhdr->h_source, BATADV_PRINT_VID(vid));
 		break;
 	case BATADV_CLAIM_TYPE_REQUEST:
 		/* request frame
@@ -335,8 +336,9 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		memcpy(hw_src, mac, ETH_ALEN);
 		memcpy(ethhdr->h_dest, mac, ETH_ALEN);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): REQUEST of %pM to %pM on vid %hu\n",
-			   ethhdr->h_source, ethhdr->h_dest, vid);
+			   "bla_send_claim(): REQUEST of %pM to %pM on vid %hd\n",
+			   ethhdr->h_source, ethhdr->h_dest,
+			   BATADV_PRINT_VID(vid));
 		break;
 	}
 
@@ -379,8 +381,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 		return entry;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "bla_get_backbone_gw(): not found (%pM, %hu), creating new entry\n",
-		   orig, vid);
+		   "bla_get_backbone_gw(): not found (%pM, %hd), creating new entry\n",
+		   orig, BATADV_PRINT_VID(vid));
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
@@ -571,8 +573,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 		atomic_set(&claim->refcount, 2);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_add_claim(): adding new entry %pM, vid %hu to hash ...\n",
-			   mac, vid);
+			   "bla_add_claim(): adding new entry %pM, vid %hd to hash ...\n",
+			   mac, BATADV_PRINT_VID(vid));
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
@@ -590,8 +592,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			goto claim_free_ref;
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_add_claim(): changing ownership for %pM, vid %hu\n",
-			   mac, vid);
+			   "bla_add_claim(): changing ownership for %pM, vid %hd\n",
+			   mac, BATADV_PRINT_VID(vid));
 
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 		batadv_backbone_gw_free_ref(claim->backbone_gw);
@@ -621,8 +623,8 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	if (!claim)
 		return;
 
-	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %hu\n",
-		   mac, vid);
+	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %hd\n",
+		   mac, BATADV_PRINT_VID(vid));
 
 	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
 			   batadv_choose_claim, claim);
@@ -657,13 +659,13 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 	crc = ntohs(*((__be16 *)(&an_addr[4])));
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "handle_announce(): ANNOUNCE vid %hu (sent by %pM)... CRC = %#.4x\n",
-		   vid, backbone_gw->orig, crc);
+		   "handle_announce(): ANNOUNCE vid %hd (sent by %pM)... CRC = %#.4x\n",
+		   BATADV_PRINT_VID(vid), backbone_gw->orig, crc);
 
 	if (backbone_gw->crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
-			   "handle_announce(): CRC FAILED for %pM/%hu (my = %#.4x, sent = %#.4x)\n",
-			   backbone_gw->orig, backbone_gw->vid,
+			   "handle_announce(): CRC FAILED for %pM/%hd (my = %#.4x, sent = %#.4x)\n",
+			   backbone_gw->orig, BATADV_PRINT_VID(backbone_gw->vid),
 			   backbone_gw->crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
@@ -698,8 +700,8 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 		return 1;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "handle_request(): REQUEST vid %hu (sent by %pM)...\n",
-		   vid, ethhdr->h_source);
+		   "handle_request(): REQUEST vid %hd (sent by %pM)...\n",
+		   BATADV_PRINT_VID(vid), ethhdr->h_source);
 
 	batadv_bla_answer_request(bat_priv, primary_if, vid);
 	return 1;
@@ -726,8 +728,8 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 
 	/* this must be an UNCLAIM frame */
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "handle_unclaim(): UNCLAIM %pM on vid %hu (sent by %pM)...\n",
-		   claim_addr, vid, backbone_gw->orig);
+		   "handle_unclaim(): UNCLAIM %pM on vid %hd (sent by %pM)...\n",
+		   claim_addr, BATADV_PRINT_VID(vid), backbone_gw->orig);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
 	batadv_backbone_gw_free_ref(backbone_gw);
@@ -910,8 +912,9 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 				       ethhdr);
 	if (ret == 1)
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %hu ...(hw_src %pM, hw_dst %pM)\n",
-			   ethhdr->h_source, vid, hw_src, hw_dst);
+			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %hd ...(hw_src %pM, hw_dst %pM)\n",
+			   ethhdr->h_source, BATADV_PRINT_VID(vid), hw_src,
+			   hw_dst);
 
 	if (ret < 2)
 		return ret;
@@ -945,8 +948,8 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	}
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "bla_process_claim(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %hu ...(hw_src %pM, hw_dst %pM)\n",
-		   ethhdr->h_source, vid, hw_src, hw_dst);
+		   "bla_process_claim(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %hd ...(hw_src %pM, hw_dst %pM)\n",
+		   ethhdr->h_source, BATADV_PRINT_VID(vid), hw_src, hw_dst);
 	return 1;
 }
 
diff --git a/main.h b/main.h
index 7fce4f0..815fb69 100644
--- a/main.h
+++ b/main.h
@@ -174,6 +174,8 @@ enum batadv_vlan_flags {
 
 /* mask needed to extract the vlan ID (12bits) from a 16bits variable */
 #define BATADV_VID_MASK	0x0FFF
+#define BATADV_PRINT_VID(vid) ((short)(vid & BATADV_VLAN_HAS_TAG ? \
+				       vid & BATADV_VID_MASK : -1))
 
 extern char batadv_routing_algo[];
 extern struct list_head batadv_hardif_list;
-- 
1.8.1.5

