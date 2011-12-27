Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 27 Dec 2011 17:51:21 +0100
Message-Id: <1325004682-16792-10-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1325004682-16792-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1325004682-16792-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 09/10] batman-adv: form groups in the
	bridge loop avoidance
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

backbone gateways may be part of the same LAN, but participate
in different meshes. With this patch, backbone gateways form groups by
applying the groupid of another backbone gateway if it is higher. After
forming the group, they only accept messages from backbone gateways of
the same group.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

---
[2011-10-27] fix a nasty bug which has overwritten the claim type
[2011-10-30] Changes suggested by Marek Lindner:
 * give hw_src and hw_dst as parameter in check_claim_group() to
   avoid code duplicates
 * update group id when primary if address is changed

[2011-11-04] remove primary_if address caching
[2011-12-27] fix alignment

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |  128 +++++++++++++++++++++++++++++++++++++++++------
 types.h                 |    1 +
 2 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 4c4b897..99b0a8f 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -33,7 +33,6 @@
 #include <net/arp.h>
 #include <linux/if_vlan.h>
 
-static const uint8_t claim_dest[6] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
 static const uint8_t announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
 
 static void bla_periodic_work(struct work_struct *work);
@@ -268,7 +267,8 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 	if (!primary_if)
 		return;
 
-	memcpy(&local_claim_dest, claim_dest, sizeof(local_claim_dest));
+	memcpy(&local_claim_dest, &bat_priv->claim_dest,
+	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
 	soft_iface = primary_if->soft_iface;
@@ -284,7 +284,8 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 			 /* Ethernet SRC/HW SRC:  originator mac */
 			 primary_if->net_dev->dev_addr,
 			 /* HW DST: FF:43:05:XX:00:00
-			  * with XX   = claim type */
+			  * with XX   = claim type
+			  * and YY:YY = group id */
 			 (uint8_t *)&local_claim_dest);
 
 	if (!skb)
@@ -746,6 +747,84 @@ static int handle_claim(struct bat_priv *bat_priv,
 	return 1;
 }
 
+/**
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hw_src: the Hardware source in the ARP Header
+ * @hw_dst: the Hardware destination in the ARP Header
+ * @ethhdr: pointer to the Ethernet header of the claim frame
+ *
+ * checks if it is a claim packet and if its on the same group.
+ * This function also applies the group ID of the sender
+ * if it is in the same mesh.
+ *
+ * returns:
+ *	2  - if it is a claim packet and on the same group
+ *	1  - if is a claim packet from another group
+ *	0  - if it is not a claim packet
+ */
+static int check_claim_group(struct bat_priv *bat_priv,
+			     struct hard_iface *primary_if,
+			     uint8_t *hw_src, uint8_t *hw_dst,
+			     struct ethhdr *ethhdr)
+{
+	uint8_t *backbone_addr;
+	struct orig_node *orig_node;
+	struct bla_claim_dst *bla_dst, *bla_dst_own;
+
+	bla_dst = (struct bla_claim_dst *) hw_dst;
+	bla_dst_own = &bat_priv->claim_dest;
+
+	/* check if it is a claim packet in general */
+	if (memcmp(bla_dst->magic, bla_dst_own->magic,
+		   sizeof(bla_dst->magic)) != 0)
+		return 0;
+
+	/* if announcement packet, use the source,
+	 * otherwise assume it is in the hw_src */
+	switch (bla_dst->type) {
+	case CLAIM_TYPE_ADD:
+		backbone_addr = hw_src;
+		break;
+	case CLAIM_TYPE_REQUEST:
+	case CLAIM_TYPE_ANNOUNCE:
+	case CLAIM_TYPE_DEL:
+		backbone_addr = ethhdr->h_source;
+		break;
+	default:
+		return 0;
+	}
+
+	/* don't accept claim frames from ourselves */
+	if (compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
+		return 0;
+
+	/* if its already the same group, it is fine. */
+	if (bla_dst->group == bla_dst_own->group)
+		return 2;
+
+	/* lets see if this originator is in our mesh */
+	orig_node = orig_hash_find(bat_priv, backbone_addr);
+
+	/* dont accept claims from gateways which are not in
+	 * the same mesh or group. */
+	if (!orig_node)
+		return 1;
+
+	/* if our mesh friends mac is bigger, use it for ourselves. */
+	if (ntohs(bla_dst->group) > ntohs(bla_dst_own->group)) {
+		bat_dbg(DBG_BLA, bat_priv,
+			"taking other backbones claim group: %04x\n",
+			ntohs(bla_dst->group));
+		bla_dst_own->group = bla_dst->group;
+	}
+
+	orig_node_free_ref(orig_node);
+
+	return 2;
+}
+
+
 /*
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
@@ -768,6 +847,7 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 	uint16_t proto;
 	int headlen;
 	short vid = -1;
+	int ret;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
@@ -810,8 +890,15 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 	bla_dst = (struct bla_claim_dst *) hw_dst;
 
 	/* check if it is a claim frame. */
-	if (memcmp(hw_dst, claim_dest, 3) != 0)
-		return 0;
+	ret = check_claim_group(bat_priv, primary_if, hw_src, hw_dst, ethhdr);
+	if (ret == 1)
+		bat_dbg(DBG_BLA, bat_priv, "bla_process_claim(): received "
+			"a claim frame from another group. From: "
+			"%pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
+			ethhdr->h_source, vid, hw_src, hw_dst);
+
+	if (ret < 2)
+		return ret;
 
 	/* become a backbone gw ourselves on this vlan if not happened yet */
 	bla_update_own_backbone_gw(bat_priv, primary_if, vid);
@@ -960,6 +1047,10 @@ void bla_update_orig_address(struct bat_priv *bat_priv,
 	struct hashtable_t *hash;
 	int i;
 
+	/* reset bridge loop avoidance group id */
+	bat_priv->claim_dest.group =
+		htons(crc16(0, primary_if->net_dev->dev_addr, ETH_ALEN));
+
 	if (!oldif) {
 		bla_purge_claims(bat_priv, NULL, 1);
 		bla_purge_backbone_gw(bat_priv, 1);
@@ -1059,9 +1150,23 @@ out:
 int bla_init(struct bat_priv *bat_priv)
 {
 	int i;
+	uint8_t claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
+	struct hard_iface *primary_if;
 
 	bat_dbg(DBG_BLA, bat_priv, "bla hash registering\n");
 
+	/* setting claim destination address */
+	memcpy(&bat_priv->claim_dest.magic, claim_dest, 3);
+	bat_priv->claim_dest.type = 0;
+	primary_if = primary_if_get_selected(bat_priv);
+	if (primary_if) {
+		bat_priv->claim_dest.group =
+			htons(crc16(0, primary_if->net_dev->dev_addr,
+				    ETH_ALEN));
+		hardif_free_ref(primary_if);
+	} else
+		bat_priv->claim_dest.group = 0; /* will be set later */
+
 	/* initialize the duplicate list */
 	for (i = 0; i < DUPLIST_SIZE; i++)
 		bat_priv->bcast_duplist[i].entrytime =
@@ -1233,9 +1338,6 @@ int bla_is_backbone_gw(struct sk_buff *skb,
 	if (!backbone_gw)
 		return 0;
 
-	bat_dbg(DBG_BLA, orig_node->bat_priv,
-		"bla_is_backbone_gw(): originator %pM has a claim "
-		"for vid %d on the LAN ...\n", orig_node->orig, vid);
 	backbone_gw_free_ref(backbone_gw);
 	return 1;
 }
@@ -1395,11 +1497,6 @@ int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 	memcpy(search_claim.addr, ethhdr->h_source, ETH_ALEN);
 	search_claim.vid = vid;
 
-	bat_dbg(DBG_BLA, bat_priv,
-		"bla_tx(): checked for claims, now starting ..."
-		"%pM -> %pM [%04x], vid %d\n",
-		ethhdr->h_source, ethhdr->h_dest,
-		ntohs(ethhdr->h_proto), search_claim.vid);
 	claim = claim_hash_find(bat_priv, &search_claim);
 
 	/* if no claim exists, allow it. */
@@ -1470,8 +1567,9 @@ int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "Claims announced for the mesh %s "
-		   "(orig %pM)\n",
-		   net_dev->name, primary_if->net_dev->dev_addr);
+		   "(orig %pM, group id %04x)\n",
+		   net_dev->name, primary_if->net_dev->dev_addr,
+		   ntohs(bat_priv->claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-4s)\n",
 		   "Client", "VID", "Originator", "CRC");
 	for (i = 0; i < hash->size; i++) {
diff --git a/types.h b/types.h
index e4767a5..b60ccdb 100644
--- a/types.h
+++ b/types.h
@@ -193,6 +193,7 @@ struct bat_priv {
 	struct hashtable_t *vis_hash;
 	struct bcast_duplist_entry bcast_duplist[DUPLIST_SIZE];
 	int bcast_duplist_curr;
+	struct bla_claim_dst claim_dest;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t tt_changes_list_lock; /* protects tt_changes */
-- 
1.7.7.3

