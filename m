Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 23 Jun 2012 12:34:18 +0200
Message-Id: <1340447658-27405-2-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1340447658-27405-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1340447658-27405-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: rename bridge loop avoidance
	claim types
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

for consistency reasons within the code and with the documentation,
we should always call it "claim" and "unclaim".

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |   18 +++++++++---------
 packet.h                |    4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index a61bb74..6882715 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -294,7 +294,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 
 	/* now we pretend that the client would have sent this ... */
 	switch (claimtype) {
-	case BATADV_CLAIM_TYPE_ADD:
+	case BATADV_CLAIM_TYPE_CLAIM:
 		/* normal claim frame
 		 * set Ethernet SRC to the clients mac
 		 */
@@ -302,7 +302,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "bla_send_claim(): CLAIM %pM on vid %d\n", mac, vid);
 		break;
-	case BATADV_CLAIM_TYPE_DEL:
+	case BATADV_CLAIM_TYPE_UNCLAIM:
 		/* unclaim frame
 		 * set HW SRC to the clients mac
 		 */
@@ -465,7 +465,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 				continue;
 
 			batadv_bla_send_claim(bat_priv, claim->addr, claim->vid,
-					      BATADV_CLAIM_TYPE_ADD);
+					      BATADV_CLAIM_TYPE_CLAIM);
 		}
 		rcu_read_unlock();
 	}
@@ -700,7 +700,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 	if (primary_if && batadv_compare_eth(backbone_addr,
 					     primary_if->net_dev->dev_addr))
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
-				      BATADV_CLAIM_TYPE_DEL);
+				      BATADV_CLAIM_TYPE_UNCLAIM);
 
 	backbone_gw = batadv_backbone_hash_find(bat_priv, backbone_addr, vid);
 
@@ -736,7 +736,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 	batadv_bla_add_claim(bat_priv, claim_addr, vid, backbone_gw);
 	if (batadv_compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
-				      BATADV_CLAIM_TYPE_ADD);
+				      BATADV_CLAIM_TYPE_CLAIM);
 
 	/* TODO: we could call something like tt_local_del() here. */
 
@@ -779,12 +779,12 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 	 * otherwise assume it is in the hw_src
 	 */
 	switch (bla_dst->type) {
-	case BATADV_CLAIM_TYPE_ADD:
+	case BATADV_CLAIM_TYPE_CLAIM:
 		backbone_addr = hw_src;
 		break;
 	case BATADV_CLAIM_TYPE_REQUEST:
 	case BATADV_CLAIM_TYPE_ANNOUNCE:
-	case BATADV_CLAIM_TYPE_DEL:
+	case BATADV_CLAIM_TYPE_UNCLAIM:
 		backbone_addr = ethhdr->h_source;
 		break;
 	default:
@@ -900,12 +900,12 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 
 	/* check for the different types of claim frames ... */
 	switch (bla_dst->type) {
-	case BATADV_CLAIM_TYPE_ADD:
+	case BATADV_CLAIM_TYPE_CLAIM:
 		if (batadv_handle_claim(bat_priv, primary_if, hw_src,
 					ethhdr->h_source, vid))
 			return 1;
 		break;
-	case BATADV_CLAIM_TYPE_DEL:
+	case BATADV_CLAIM_TYPE_UNCLAIM:
 		if (batadv_handle_unclaim(bat_priv, primary_if,
 					  ethhdr->h_source, hw_src, vid))
 			return 1;
diff --git a/packet.h b/packet.h
index c0ed5b4..67374dd 100644
--- a/packet.h
+++ b/packet.h
@@ -92,8 +92,8 @@ enum batadv_tt_client_flags {
 
 /* claim frame types for the bridge loop avoidance */
 enum batadv_bla_claimframe {
-	BATADV_CLAIM_TYPE_ADD		= 0x00,
-	BATADV_CLAIM_TYPE_DEL		= 0x01,
+	BATADV_CLAIM_TYPE_CLAIM		= 0x00,
+	BATADV_CLAIM_TYPE_UNCLAIM	= 0x01,
 	BATADV_CLAIM_TYPE_ANNOUNCE	= 0x02,
 	BATADV_CLAIM_TYPE_REQUEST	= 0x03,
 };
-- 
1.7.10

