Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 May 2017 13:02:00 +0200
Message-Id: <20170519110200.29867-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Print correct function names in
	dbg messages
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

The function names in batman-adv changed slightly in the past. But some of
the debug messages were not updated correctly and therefore some messages
were incorrect. To avoid this in the future, these kind of messages should
use __func__ to automatically print the correct function name.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            |  3 +-
 net/batman-adv/bridge_loop_avoidance.c | 72 +++++++++++++++++-----------------
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/routing.c               |  4 +-
 net/batman-adv/send.c                  |  6 +--
 5 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 495ba7c..257b61f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1022,7 +1022,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	u8 tq_avg;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "update_originator(): Searching and updating originator entry of received packet\n");
+		   "%s(): Searching and updating originator entry of received packet\n",
+		   __func__);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node,
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d07e89e..67234d1 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -394,7 +394,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 		 */
 		ether_addr_copy(ethhdr->h_source, mac);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): CLAIM %pM on vid %d\n", mac,
+			   "%s(): CLAIM %pM on vid %d\n", __func__, mac,
 			   batadv_print_vid(vid));
 		break;
 	case BATADV_CLAIM_TYPE_UNCLAIM:
@@ -403,7 +403,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 		 */
 		ether_addr_copy(hw_src, mac);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): UNCLAIM %pM on vid %d\n", mac,
+			   "%s(): UNCLAIM %pM on vid %d\n", __func__, mac,
 			   batadv_print_vid(vid));
 		break;
 	case BATADV_CLAIM_TYPE_ANNOUNCE:
@@ -412,7 +412,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 		 */
 		ether_addr_copy(hw_src, mac);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): ANNOUNCE of %pM on vid %d\n",
+			   "%s(): ANNOUNCE of %pM on vid %d\n", __func__,
 			   ethhdr->h_source, batadv_print_vid(vid));
 		break;
 	case BATADV_CLAIM_TYPE_REQUEST:
@@ -423,15 +423,15 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 		ether_addr_copy(hw_src, mac);
 		ether_addr_copy(ethhdr->h_dest, mac);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): REQUEST of %pM to %pM on vid %d\n",
+			   "%s(): REQUEST of %pM to %pM on vid %d\n", __func__,
 			   ethhdr->h_source, ethhdr->h_dest,
 			   batadv_print_vid(vid));
 		break;
 	case BATADV_CLAIM_TYPE_LOOPDETECT:
 		ether_addr_copy(ethhdr->h_source, mac);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_send_claim(): LOOPDETECT of %pM to %pM on vid %d\n",
-			   ethhdr->h_source, ethhdr->h_dest,
+			   "%s(): LOOPDETECT of %pM to %pM on vid %d\n",
+			   __func__, ethhdr->h_source, ethhdr->h_dest,
 			   batadv_print_vid(vid));
 
 		break;
@@ -509,7 +509,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 		return entry;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "bla_get_backbone_gw(): not found (%pM, %d), creating new entry\n",
+		   "%s(): not found (%pM, %d), creating new entry\n", __func__,
 		   orig, batadv_print_vid(vid));
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
@@ -605,7 +605,8 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 	int i;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "bla_answer_request(): received a claim request, send all of our own claims again\n");
+		   "%s(): received a claim request, send all of our own claims again\n",
+		   __func__);
 
 	backbone_gw = batadv_backbone_hash_find(bat_priv,
 						primary_if->net_dev->dev_addr,
@@ -718,8 +719,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		kref_init(&claim->refcount);
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
-			   mac, batadv_print_vid(vid));
+			   "%s(): adding new entry %pM, vid %d to hash ...\n",
+			   __func__, mac, batadv_print_vid(vid));
 
 		kref_get(&claim->refcount);
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
@@ -739,8 +740,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			goto claim_free_ref;
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_add_claim(): changing ownership for %pM, vid %d to gw %pM\n",
-			   mac, batadv_print_vid(vid), backbone_gw->orig);
+			   "%s(): changing ownership for %pM, vid %d to gw %pM\n",
+			   __func__, mac, batadv_print_vid(vid), backbone_gw->orig);
 
 		remove_crc = true;
 	}
@@ -808,7 +809,7 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	if (!claim)
 		return;
 
-	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n",
+	batadv_dbg(BATADV_DBG_BLA, bat_priv, "%s(): %pM, vid %d\n", __func__,
 		   mac, batadv_print_vid(vid));
 
 	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
@@ -848,8 +849,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 	crc = ntohs(*((__be16 *)(&an_addr[4])));
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
-		   batadv_print_vid(vid), backbone_gw->orig, crc);
+		   "%s(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
+		   __func__, batadv_print_vid(vid), backbone_gw->orig, crc);
 
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_crc = backbone_gw->crc;
@@ -857,8 +858,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 	if (backbone_crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
-			   "handle_announce(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
-			   backbone_gw->orig,
+			   "%s(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
+			   __func__, backbone_gw->orig,
 			   batadv_print_vid(backbone_gw->vid),
 			   backbone_crc, crc);
 
@@ -903,8 +904,8 @@ static bool batadv_handle_request(struct batadv_priv *bat_priv,
 		return true;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "handle_request(): REQUEST vid %d (sent by %pM)...\n",
-		   batadv_print_vid(vid), ethhdr->h_source);
+		   "%s(): REQUEST vid %d (sent by %pM)...\n",
+		   __func__, batadv_print_vid(vid), ethhdr->h_source);
 
 	batadv_bla_answer_request(bat_priv, primary_if, vid);
 	return true;
@@ -940,7 +941,7 @@ static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
 
 	/* this must be an UNCLAIM frame */
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "handle_unclaim(): UNCLAIM %pM on vid %d (sent by %pM)...\n",
+		   "%s(): UNCLAIM %pM on vid %d (sent by %pM)...\n", __func__,
 		   claim_addr, batadv_print_vid(vid), backbone_gw->orig);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
@@ -1160,9 +1161,9 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
 				       ethhdr);
 	if (ret == 1)
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
-			   ethhdr->h_source, batadv_print_vid(vid), hw_src,
-			   hw_dst);
+			   "%s(): received a claim frame from another group. From: %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
+			   __func__, ethhdr->h_source, batadv_print_vid(vid),
+			   hw_src, hw_dst);
 
 	if (ret < 2)
 		return !!ret;
@@ -1196,8 +1197,9 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	}
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
-		   "bla_process_claim(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
-		   ethhdr->h_source, batadv_print_vid(vid), hw_src, hw_dst);
+		   "%s(): ERROR - this looks like a claim frame, but is useless. eth src %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
+		   __func__, ethhdr->h_source, batadv_print_vid(vid), hw_src,
+		   hw_dst);
 	return true;
 }
 
@@ -1237,8 +1239,8 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 				continue;
 
 			batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
-				   "bla_purge_backbone_gw(): backbone gw %pM timed out\n",
-				   backbone_gw->orig);
+				   "%s(): backbone gw %pM timed out\n",
+				   __func__, backbone_gw->orig);
 
 purge_now:
 			/* don't wait for the pending request anymore */
@@ -1295,11 +1297,11 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 				goto skip;
 
 			batadv_dbg(BATADV_DBG_BLA, bat_priv,
-				   "bla_purge_claims(): timed out.\n");
+				   "%s(): timed out.\n", __func__);
 
 purge_now:
 			batadv_dbg(BATADV_DBG_BLA, bat_priv,
-				   "bla_purge_claims(): %pM, vid %d\n",
+				   "%s(): %pM, vid %d\n", __func__,
 				   claim->addr, claim->vid);
 
 			batadv_handle_unclaim(bat_priv, primary_if,
@@ -1851,8 +1853,8 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		 */
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "bla_rx(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
-			   ethhdr->h_source,
+			   "%s(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
+			   __func__, ethhdr->h_source,
 			   batadv_is_my_client(bat_priv,
 					       ethhdr->h_source, vid) ?
 			   "yes" : "no");
@@ -1978,15 +1980,15 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			 * older than 100 ms to make sure we really
 			 * have a roaming client here.
 			 */
-			batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Roaming client %pM detected. Unclaim it.\n",
-				   ethhdr->h_source);
+			batadv_dbg(BATADV_DBG_BLA, bat_priv, "%s(): Roaming client %pM detected. Unclaim it.\n",
+				   __func__, ethhdr->h_source);
 			batadv_handle_unclaim(bat_priv, primary_if,
 					      primary_if->net_dev->dev_addr,
 					      ethhdr->h_source, vid);
 			goto allow;
 		} else {
-			batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Race for claim %pM detected. Drop packet.\n",
-				   ethhdr->h_source);
+			batadv_dbg(BATADV_DBG_BLA, bat_priv, "%s(): Race for claim %pM detected. Drop packet.\n",
+				   __func__, ethhdr->h_source);
 			goto handled;
 		}
 	}
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 000ca2f..6930d6b 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -601,7 +601,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
+		   "%s(): IP=%pI4 hash(IP)=%u\n", __func__, &ip_dst,
 		   ip_key);
 
 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index ae9f4d3..f10e3ff 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -985,8 +985,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			batadv_orig_node_put(orig_node_gw);
 			if (is_gw) {
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
-					   "recv_unicast_packet(): Dropped unicast pkt received from another backbone gw %pM.\n",
-					   orig_addr_gw);
+					   "%s(): Dropped unicast pkt received from another backbone gw %pM.\n",
+					   __func__, orig_addr_gw);
 				goto free_skb;
 			}
 		}
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 403df59..d239a9d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -971,11 +971,11 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 	if (hard_iface)
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "purge_outstanding_packets(): %s\n",
-			   hard_iface->net_dev->name);
+			   "%s(): %s\n",
+			   __func__, hard_iface->net_dev->name);
 	else
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "purge_outstanding_packets()\n");
+			   "%s()\n", __func__);
 
 	/* claim bcast list for free() */
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-- 
2.11.0

