Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Mar 2012 09:07:50 +0100
Message-Id: <1331107673-8986-6-git-send-email-sven@narfation.org>
In-Reply-To: <1331107673-8986-1-git-send-email-sven@narfation.org>
References: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
	<1331107673-8986-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/8-master] batman-adv: Don't begin block
	comments with only a /* line
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   39 +++++++++++++--------------------------
 distributed-arp-table.c |    3 +--
 translation-table.c     |   12 ++++--------
 types.h                 |    3 +--
 4 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 274d93a..1d6fb77 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -123,8 +123,7 @@ static void claim_free_ref(struct claim *claim)
 		call_rcu(&claim->rcu, claim_free_rcu);
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
  * looks for a claim in the hash, and returns it if found
@@ -163,8 +162,7 @@ static struct claim *claim_hash_find(struct bat_priv *bat_priv,
 	return claim_tmp;
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
@@ -243,8 +241,7 @@ static void bla_del_backbone_claims(struct backbone_gw *backbone_gw)
 	backbone_gw->crc = BLA_CRC_INIT;
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address to be announced within the claim
  * @vid: the VLAN ID
  * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
@@ -353,8 +350,7 @@ out:
 		hardif_free_ref(primary_if);
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
  *
@@ -411,8 +407,7 @@ static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 	return entry;
 }
 
-/*
- * update or add the own backbone gw to make sure we announce
+/* update or add the own backbone gw to make sure we announce
  * where we receive other backbone gws
  */
 static void bla_update_own_backbone_gw(struct bat_priv *bat_priv,
@@ -430,8 +425,7 @@ static void bla_update_own_backbone_gw(struct bat_priv *bat_priv,
 	backbone_gw_free_ref(backbone_gw);
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @vid: the vid where the request came on
  *
  * Repeat all of our own claims, and finally send an ANNOUNCE frame
@@ -477,8 +471,7 @@ static void bla_answer_request(struct bat_priv *bat_priv,
 	backbone_gw_free_ref(backbone_gw);
 }
 
-/*
- * @backbone_gw: the backbone gateway from whom we are out of sync
+/* @backbone_gw: the backbone gateway from whom we are out of sync
  *
  * When the crc is wrong, ask the backbone gateway for a full table update.
  * After the request, it will repeat all of his own claims and finally
@@ -505,8 +498,7 @@ static void bla_send_request(struct backbone_gw *backbone_gw)
 	}
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: our backbone gateway which should be announced
  *
  * This function sends an announcement. It is called from multiple
@@ -526,8 +518,7 @@ static void bla_send_announce(struct bat_priv *bat_priv,
 
 }
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @mac: the mac address of the claim
  * @vid: the VLAN ID of the frame
  * @backbone_gw: the backbone gateway which claims it
@@ -595,8 +586,7 @@ claim_free_ref:
 	claim_free_ref(claim);
 }
 
-/*
- * Delete a claim from the claim hash which has the
+/* Delete a claim from the claim hash which has the
  * given mac address and vid.
  */
 static void bla_del_claim(struct bat_priv *bat_priv, const uint8_t *mac,
@@ -818,8 +808,7 @@ static int check_claim_group(struct bat_priv *bat_priv,
 }
 
 
-/*
- * @bat_priv: the bat priv with all the soft interface information
+/* @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  *
  * Check if this is a claim frame, and process it accordingly.
@@ -924,8 +913,7 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 	return 1;
 }
 
-/*
- * Check when we last heard from other nodes, and remove them in case of
+/* Check when we last heard from other nodes, and remove them in case of
  * a time out, or clean all backbone gws if now is set.
  */
 static void bla_purge_backbone_gw(struct bat_priv *bat_priv, int now)
@@ -1082,8 +1070,7 @@ static void bla_start_timer(struct bat_priv *bat_priv)
 			   msecs_to_jiffies(BLA_PERIOD_LENGTH));
 }
 
-/*
- * periodic work to do:
+/* periodic work to do:
  *  * purge structures when they are too old
  *  * send announcements
  */
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 114db0a..c610108 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -217,8 +217,7 @@ static struct dht_candidate *dht_select_candidates(struct bat_priv *bat_priv,
 	return res;
 }
 
-/*
- * Sends the skb payload passed as argument to the candidates selected for
+/* Sends the skb payload passed as argument to the candidates selected for
  * the data represented by 'ip'. The skb is copied by means of pskb_copy()
  * and is sent as unicast packet to each of the selected candidate.
  *
diff --git a/translation-table.c b/translation-table.c
index 8e4964b..cdc7322 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -599,8 +599,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	} else {
 		/* there is already a global entry, use this one. */
 
-		/*
-		 * If there is the TT_CLIENT_ROAM flag set, there is only one
+		/* If there is the TT_CLIENT_ROAM flag set, there is only one
 		 * originator left in the list and we previously received a
 		 * delete + roaming change for this originator.
 		 *
@@ -636,8 +635,7 @@ out:
 	return ret;
 }
 
-/*
- * print all orig nodes who announce the address for this global entry.
+/* print all orig nodes who announce the address for this global entry.
  * it is assumed that the caller holds rcu_read_lock();
  */
 static void tt_global_print_entry(struct tt_global_entry *tt_global_entry,
@@ -773,8 +771,7 @@ static void tt_global_del_struct(struct bat_priv *bat_priv,
 
 }
 
-/*
- * If the client is to be deleted, we check if it is the last origantor entry
+/* If the client is to be deleted, we check if it is the last origantor entry
  * within tt_global entry. If yes, we set the TT_CLIENT_ROAM flag and the timer,
  * otherwise we simply remove the originator scheduled for deletion.
  */
@@ -788,8 +785,7 @@ static void tt_global_del_roaming(struct bat_priv *bat_priv,
 	struct hlist_node *node;
 	struct tt_orig_list_entry *orig_entry;
 
-	/*
-	 * no local entry exists, case 1:
+	/* no local entry exists, case 1:
 	 * Check if this is the last one or if other entries exist.
 	 */
 
diff --git a/types.h b/types.h
index 0643271..5ca9b58 100644
--- a/types.h
+++ b/types.h
@@ -29,8 +29,7 @@
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 
-/*
- * dat_addr_t is the type used for all DHT addresses. If it is changed,
+/* dat_addr_t is the type used for all DHT addresses. If it is changed,
  * DAT_ADDR_MAX is changed as well.
  *
  * *Please be careful: dat_addr_t must be UNSIGNED*
-- 
1.7.9.1

