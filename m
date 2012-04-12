Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 12 Apr 2012 09:07:27 +0200
Message-Id: <1334214449-3996-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334214449-3996-1-git-send-email-ordex@autistici.org>
References: <1334214449-3996-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: fix comments ending style
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

All multiline comments must end with "*/" on a newline.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |  102 +++++++++++++++++++++++++----------------------
 packet.h                |    3 +-
 routing.c               |    6 ++-
 soft-interface.c        |    6 ++-
 translation-table.c     |   16 +++++---
 5 files changed, 74 insertions(+), 59 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index aaa4b9f..8bf9751 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -123,13 +123,13 @@ static void claim_free_ref(struct claim *claim)
 		call_rcu(&claim->rcu, claim_free_rcu);
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
  * looks for a claim in the hash, and returns it if found
  * or NULL otherwise.
  */
-
 static struct claim *claim_hash_find(struct bat_priv *bat_priv,
 				     struct claim *data)
 {
@@ -162,14 +162,14 @@ static struct claim *claim_hash_find(struct bat_priv *bat_priv,
 	return claim_tmp;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
  * looks for a claim in the hash, and returns it if found
  * or NULL otherwise.
  */
-
 static struct backbone_gw *backbone_hash_find(struct bat_priv *bat_priv,
 					      uint8_t *addr, short vid)
 {
@@ -241,14 +241,14 @@ static void bla_del_backbone_claims(struct backbone_gw *backbone_gw)
 	backbone_gw->crc = BLA_CRC_INIT;
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address to be announced within the claim
  * @vid: the VLAN ID
  * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
  *
  * sends a claim frame according to the provided info.
  */
-
 static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 			   short vid, int claimtype)
 {
@@ -282,7 +282,8 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 			 primary_if->net_dev->dev_addr,
 			 /* HW DST: FF:43:05:XX:00:00
 			  * with XX   = claim type
-			  * and YY:YY = group id */
+			  * and YY:YY = group id
+			  */
 			 (uint8_t *)&local_claim_dest);
 
 	if (!skb)
@@ -294,8 +295,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 	/* now we pretend that the client would have sent this ... */
 	switch (claimtype) {
 	case CLAIM_TYPE_ADD:
-		/*
-		 * normal claim frame
+		/* normal claim frame
 		 * set Ethernet SRC to the clients mac
 		 */
 		memcpy(ethhdr->h_source, mac, ETH_ALEN);
@@ -303,8 +303,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 			"bla_send_claim(): CLAIM %pM on vid %d\n", mac, vid);
 		break;
 	case CLAIM_TYPE_DEL:
-		/*
-		 * unclaim frame
+		/* unclaim frame
 		 * set HW SRC to the clients mac
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
@@ -312,8 +311,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 			"bla_send_claim(): UNCLAIM %pM on vid %d\n", mac, vid);
 		break;
 	case CLAIM_TYPE_ANNOUNCE:
-		/*
-		 * announcement frame
+		/* announcement frame
 		 * set HW SRC to the special mac containg the crc
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
@@ -322,8 +320,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 			ethhdr->h_source, vid);
 		break;
 	case CLAIM_TYPE_REQUEST:
-		/*
-		 * request frame
+		/* request frame
 		 * set HW SRC to the special mac containg the crc
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
@@ -350,14 +347,14 @@ out:
 		hardif_free_ref(primary_if);
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
  *
  * searches for the backbone gw or creates a new one if it could not
  * be found.
  */
-
 static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 					       uint8_t *orig, short vid)
 {
@@ -425,13 +422,13 @@ static void bla_update_own_backbone_gw(struct bat_priv *bat_priv,
 	backbone_gw_free_ref(backbone_gw);
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @vid: the vid where the request came on
  *
  * Repeat all of our own claims, and finally send an ANNOUNCE frame
  * to allow the requester another check if the CRC is correct now.
  */
-
 static void bla_answer_request(struct bat_priv *bat_priv,
 			       struct hard_iface *primary_if, short vid)
 {
@@ -471,13 +468,13 @@ static void bla_answer_request(struct bat_priv *bat_priv,
 	backbone_gw_free_ref(backbone_gw);
 }
 
-/* @backbone_gw: the backbone gateway from whom we are out of sync
+/**
+ * @backbone_gw: the backbone gateway from whom we are out of sync
  *
  * When the crc is wrong, ask the backbone gateway for a full table update.
  * After the request, it will repeat all of his own claims and finally
  * send an announcement claim with which we can check again.
  */
-
 static void bla_send_request(struct backbone_gw *backbone_gw)
 {
 	/* first, remove all old entries */
@@ -498,7 +495,8 @@ static void bla_send_request(struct backbone_gw *backbone_gw)
 	}
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: our backbone gateway which should be announced
  *
  * This function sends an announcement. It is called from multiple
@@ -518,14 +516,14 @@ static void bla_send_announce(struct bat_priv *bat_priv,
 
 }
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @mac: the mac address of the claim
  * @vid: the VLAN ID of the frame
  * @backbone_gw: the backbone gateway which claims it
  *
  * Adds a claim in the claim hash.
  */
-
 static void bla_add_claim(struct bat_priv *bat_priv, const uint8_t *mac,
 			  const short vid, struct backbone_gw *backbone_gw)
 {
@@ -644,7 +642,8 @@ static int handle_announce(struct bat_priv *bat_priv,
 		bla_send_request(backbone_gw);
 	} else {
 		/* if we have sent a request and the crc was OK,
-		 * we can allow traffic again. */
+		 * we can allow traffic again.
+		 */
 		if (atomic_read(&backbone_gw->request_sent)) {
 			atomic_dec(&backbone_gw->bat_priv->bla_num_requests);
 			atomic_set(&backbone_gw->request_sent, 0);
@@ -666,7 +665,8 @@ static int handle_request(struct bat_priv *bat_priv,
 		return 0;
 
 	/* sanity check, this should not happen on a normal switch,
-	 * we ignore it in this case. */
+	 * we ignore it in this case.
+	 */
 	if (!compare_eth(ethhdr->h_dest, primary_if->net_dev->dev_addr))
 		return 1;
 
@@ -732,7 +732,6 @@ static int handle_claim(struct bat_priv *bat_priv,
 }
 
 /**
- *
  * @bat_priv: the bat priv with all the soft interface information
  * @hw_src: the Hardware source in the ARP Header
  * @hw_dst: the Hardware destination in the ARP Header
@@ -765,7 +764,8 @@ static int check_claim_group(struct bat_priv *bat_priv,
 		return 0;
 
 	/* if announcement packet, use the source,
-	 * otherwise assume it is in the hw_src */
+	 * otherwise assume it is in the hw_src
+	 */
 	switch (bla_dst->type) {
 	case CLAIM_TYPE_ADD:
 		backbone_addr = hw_src;
@@ -791,7 +791,8 @@ static int check_claim_group(struct bat_priv *bat_priv,
 	orig_node = orig_hash_find(bat_priv, backbone_addr);
 
 	/* dont accept claims from gateways which are not in
-	 * the same mesh or group. */
+	 * the same mesh or group.
+	 */
 	if (!orig_node)
 		return 1;
 
@@ -809,7 +810,8 @@ static int check_claim_group(struct bat_priv *bat_priv,
 }
 
 
-/* @bat_priv: the bat priv with all the soft interface information
+/**
+ * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  *
  * Check if this is a claim frame, and process it accordingly.
@@ -817,7 +819,6 @@ static int check_claim_group(struct bat_priv *bat_priv,
  * returns 1 if it was a claim frame, otherwise return 0 to
  * tell the callee that it can use the frame on its own.
  */
-
 static int bla_process_claim(struct bat_priv *bat_priv,
 			     struct hard_iface *primary_if,
 			     struct sk_buff *skb)
@@ -857,7 +858,8 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 	arphdr = (struct arphdr *)((uint8_t *)ethhdr + headlen);
 
 	/* Check whether the ARP frame carries a valid
-	 * IP information */
+	 * IP information
+	 */
 
 	if (arphdr->ar_hrd != htons(ARPHRD_ETHER))
 		return 0;
@@ -1054,7 +1056,8 @@ void bla_update_orig_address(struct bat_priv *bat_priv,
 			memcpy(backbone_gw->orig,
 			       primary_if->net_dev->dev_addr, ETH_ALEN);
 			/* send an announce frame so others will ask for our
-			 * claims and update their tables. */
+			 * claims and update their tables.
+			 */
 			bla_send_announce(bat_priv, backbone_gw);
 		}
 		rcu_read_unlock();
@@ -1075,7 +1078,6 @@ static void bla_start_timer(struct bat_priv *bat_priv)
  *  * purge structures when they are too old
  *  * send announcements
  */
-
 static void bla_periodic_work(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
@@ -1205,7 +1207,8 @@ int bla_check_bcast_duplist(struct bat_priv *bat_priv,
 		entry = &bat_priv->bcast_duplist[curr];
 
 		/* we can stop searching if the entry is too old ;
-		 * later entries will be even older */
+		 * later entries will be even older
+		 */
 		if (has_timed_out(entry->entrytime, DUPLIST_TIMEOUT))
 			break;
 
@@ -1216,7 +1219,8 @@ int bla_check_bcast_duplist(struct bat_priv *bat_priv,
 			continue;
 
 		/* this entry seems to match: same crc, not too old,
-		 * and from another gw. therefore return 1 to forbid it. */
+		 * and from another gw. therefore return 1 to forbid it.
+		 */
 		return 1;
 	}
 	/* not found, add a new entry (overwrite the oldest entry) */
@@ -1241,7 +1245,7 @@ int bla_check_bcast_duplist(struct bat_priv *bat_priv,
  *
  * returns 1 if it is found, 0 otherwise
  *
- **/
+ */
 
 int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
 {
@@ -1283,8 +1287,7 @@ int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
  * if the orig_node is also a gateway on the soft interface, otherwise it
  * returns 0.
  *
- **/
-
+ */
 int bla_is_backbone_gw(struct sk_buff *skb,
 		       struct orig_node *orig_node, int hdr_size)
 {
@@ -1357,8 +1360,7 @@ void bla_free(struct bat_priv *bat_priv)
  * returns 1, otherwise it returns 0 and the caller shall further
  * process the skb.
  *
- **/
-
+ */
 int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
@@ -1387,7 +1389,8 @@ int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 
 	if (!claim) {
 		/* possible optimization: race for a claim */
-		/* No claim exists yet, claim it for us! */
+		/* No claim exists yet, claim it for us!
+		 */
 		handle_claim(bat_priv, primary_if,
 			     primary_if->net_dev->dev_addr,
 			     ethhdr->h_source, vid);
@@ -1409,7 +1412,8 @@ int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 	} else {
 		/* seems the client considers us as its best gateway.
 		 * send a claim and update the claim table
-		 * immediately. */
+		 * immediately.
+		 */
 		handle_claim(bat_priv, primary_if,
 			     primary_if->net_dev->dev_addr,
 			     ethhdr->h_source, vid);
@@ -1445,8 +1449,7 @@ out:
  * returns 1, otherwise it returns 0 and the caller shall further
  * process the skb.
  *
- **/
-
+ */
 int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
@@ -1487,7 +1490,8 @@ int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 	if (compare_eth(claim->backbone_gw->orig,
 			primary_if->net_dev->dev_addr)) {
 		/* if yes, the client has roamed and we have
-		 * to unclaim it. */
+		 * to unclaim it.
+		 */
 		handle_unclaim(bat_priv, primary_if,
 			       primary_if->net_dev->dev_addr,
 			       ethhdr->h_source, vid);
@@ -1497,11 +1501,13 @@ int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 	/* check if it is a multicast/broadcast frame */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* drop it. the responsible gateway has forwarded it into
-		 * the backbone network. */
+		 * the backbone network.
+		 */
 		goto handled;
 	} else {
 		/* we must allow it. at least if we are
-		 * responsible for the DESTINATION. */
+		 * responsible for the DESTINATION.
+		 */
 		goto allow;
 	}
 allow:
diff --git a/packet.h b/packet.h
index 3c4c533..307dbb3 100644
--- a/packet.h
+++ b/packet.h
@@ -108,7 +108,8 @@ enum bla_claimframe {
 };
 
 /* the destination hardware field in the ARP frame is used to
- * transport the claim type and the group id */
+ * transport the claim type and the group id
+ */
 struct bla_claim_dst {
 	uint8_t magic[3];	/* FF:43:05 */
 	uint8_t type;		/* bla_claimframe */
diff --git a/routing.c b/routing.c
index 795d3af..2181a91 100644
--- a/routing.c
+++ b/routing.c
@@ -670,7 +670,8 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	/* check if it is a backbone gateway. we don't accept
 	 * roaming advertisement from it, as it has the same
-	 * entries as we have. */
+	 * entries as we have.
+	 */
 	if (bla_is_backbone_gw_orig(bat_priv, roam_adv_packet->src))
 		goto out;
 
@@ -1089,7 +1090,8 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	add_bcast_packet_to_list(bat_priv, skb, 1);
 
 	/* don't hand the broadcast up if it is from an originator
-	 * from the same backbone. */
+	 * from the same backbone.
+	 */
 	if (bla_is_backbone_gw(skb, orig_node, hdr_size))
 		goto out;
 
diff --git a/soft-interface.c b/soft-interface.c
index 92137af..f8a4a59 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -163,7 +163,8 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	/* don't accept stp packets. STP does not help in meshes.
-	 * better use the bridge loop avoidance ... */
+	 * better use the bridge loop avoidance ...
+	 */
 	if (compare_eth(ethhdr->h_dest, stp_addr))
 		goto dropped;
 
@@ -311,7 +312,8 @@ void interface_rx(struct net_device *soft_iface,
 		goto dropped;
 
 	/* Let the bridge loop avoidance check the packet. If will
-	 * not handle it, we can safely push it up. */
+	 * not handle it, we can safely push it up.
+	 */
 	if (bla_rx(bat_priv, skb, vid))
 		goto out;
 
diff --git a/translation-table.c b/translation-table.c
index b3e608a..72dfbe1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -263,8 +263,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		}
 		rcu_read_unlock();
 		/* The global entry has to be marked as ROAMING and
-		 * has to be kept for consistency purpose */
-
+		 * has to be kept for consistency purpose
+		 */
 		tt_global_entry->common.flags |= TT_CLIENT_ROAM;
 		tt_global_entry->roam_at = jiffies;
 	}
@@ -518,7 +518,8 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 }
 
 /* find out if an orig_node is already in the list of a tt_global_entry.
- * returns 1 if found, 0 otherwise */
+ * returns 1 if found, 0 otherwise
+ */
 static bool tt_global_entry_has_orig(const struct tt_global_entry *entry,
 				     const struct orig_node *orig_node)
 {
@@ -807,7 +808,8 @@ static void tt_global_del_roaming(struct bat_priv *bat_priv,
 		tt_global_entry->roam_at = jiffies;
 	} else
 		/* there is another entry, we can simply delete this
-		 * one and can still use the other one. */
+		 * one and can still use the other one.
+		 */
 		tt_global_del_orig_entry(bat_priv, tt_global_entry,
 					 orig_node, message);
 }
@@ -1078,12 +1080,14 @@ static uint16_t tt_global_crc(struct bat_priv *bat_priv,
 			/* Roaming clients are in the global table for
 			 * consistency only. They don't have to be
 			 * taken into account while computing the
-			 * global crc */
+			 * global crc
+			 */
 			if (tt_global_entry->common.flags & TT_CLIENT_ROAM)
 				continue;
 
 			/* find out if this global entry is announced by this
-			 * originator */
+			 * originator
+			 */
 			if (!tt_global_entry_has_orig(tt_global_entry,
 						      orig_node))
 				continue;
-- 
1.7.9.4

