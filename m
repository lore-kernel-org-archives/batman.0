Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 23:51:10 +0100
Message-Id: <1320015072-10313-10-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 09/11] batman-adv: form groups in the bridge
	loop avoidance
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

backbone gateways may be part of the same LAN, but participate
in different meshes. With this patch, backbone gateways form groups by
applying the groupid of another backbone gateway if it is higher. After
forming the group, they only accept messages from backbone gateways of
the same group.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
[2011-10-27] fix a nasty bug which has overwritten the claim type

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

[2011-10-30] Changes suggested by Marek Lindner:
 * give hw_src and hw_dst as parameter in check_claim_group() to
   avoid code duplicates
 * update group id when primary if address is changed

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |  111 +++++++++++++++++++++++++++++++++++++++++++---
 types.h                 |    1 +
 2 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index b1f2abc..52575f2 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -33,7 +33,6 @@
 #include <net/arp.h>
 #include <linux/if_vlan.h>
 
-static const uint8_t claim_dest[6] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
 static const uint8_t announce_mac[6] = {0x43, 0x05, 0x43, 0x05, 0x00, 0x00};
 
 static void bla_periodic_work(struct work_struct *work);
@@ -255,7 +254,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 	if (!primary_if)
 		return;
 
-	memcpy(&local_claim_dest, claim_dest,
+	memcpy(&local_claim_dest, &bat_priv->claim_dest,
 			sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
@@ -268,8 +267,9 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		NULL,				/* Ethernet DST: Broadcast */
 		primary_if->net_dev->dev_addr,	/* Ethernet SRC/HW SRC:
 						 * originator mac */
-		(uint8_t *)&local_claim_dest	/* HW DST: FF:43:05:XX:00:00
-						 * with XX   = claim type */
+		(uint8_t *)&local_claim_dest	/* HW DST: FF:43:05:XX:YY:YY
+						 * with XX   = claim type
+						 * and YY:YY = group id */
 		);
 
 	if (!skb)
@@ -701,6 +701,82 @@ static int handle_claim(struct bat_priv *bat_priv,
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
+		uint8_t *hw_src, uint8_t *hw_dst, struct ethhdr *ethhdr)
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
+			sizeof(bla_dst->magic)) != 0)
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
+	if (compare_eth(backbone_addr, bat_priv->own_orig))
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
@@ -721,6 +797,7 @@ static int bla_process_claim(struct bat_priv *bat_priv, struct sk_buff *skb)
 	uint16_t proto;
 	int headlen;
 	short vid = -1;
+	int ret;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
@@ -761,8 +838,15 @@ static int bla_process_claim(struct bat_priv *bat_priv, struct sk_buff *skb)
 	bla_dst = (struct bla_claim_dst *) hw_dst;
 
 	/* check if it is a claim frame. */
-	if (memcmp(hw_dst, claim_dest, 3) != 0)
-		return 0;
+	ret = check_claim_group(bat_priv, hw_src, hw_dst, ethhdr);
+	if (ret == 1)
+		bat_dbg(DBG_BLA, bat_priv, "bla_process_claim(): received "
+			"a claim frame from another group. From: "
+			"%pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
+			ethhdr->h_source, vid, hw_src, hw_dst);
+
+	if (ret < 2)
+		return ret;
 
 	/* become a backbone gw ourselves on this vlan if not happened yet */
 	bla_update_own_backbone_gw(bat_priv, vid);
@@ -806,6 +890,9 @@ void bla_update_orig_address(struct bat_priv *bat_priv, uint8_t *newaddr)
 	struct hashtable_t *hash;
 	int i;
 
+	/* reset bridge loop avoidance group id */
+	bat_priv->claim_dest.group = htons(crc16(0, newaddr, ETH_ALEN));
+
 	hash = bat_priv->backbone_hash;
 	if (!hash)
 		return;
@@ -971,9 +1058,16 @@ timer:
 int bla_init(struct bat_priv *bat_priv)
 {
 	int i;
+	uint8_t claim_dest[6] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
 
 	bat_dbg(DBG_BLA, bat_priv, "bla hash registering\n");
 
+	/* setting claim destination address */
+	memcpy(&bat_priv->claim_dest.magic, claim_dest, 3);
+	bat_priv->claim_dest.type = 0;
+	bat_priv->claim_dest.group =
+		htons(crc16(0, bat_priv->own_orig, ETH_ALEN));
+
 	/* initialize the duplicate list */
 	for (i = 0; i < DUPLIST_SIZE; i++)
 		bat_priv->bcast_duplist[i].entrytime =
@@ -1390,8 +1484,9 @@ int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "Claims announced for the mesh %s "
-			"(orig %pM)\n",
-			net_dev->name, bat_priv->own_orig);
+			"(orig %pM, group id %04x)\n",
+			net_dev->name, bat_priv->own_orig,
+			ntohs(bat_priv->claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-4s)\n",
 		   "Client", "VID", "Originator", "CRC");
 	for (i = 0; i < hash->size; i++) {
diff --git a/types.h b/types.h
index 5f02447..21c4f3e 100644
--- a/types.h
+++ b/types.h
@@ -192,6 +192,7 @@ struct bat_priv {
 	struct hashtable_t *vis_hash;
 	struct bcast_duplist_entry bcast_duplist[DUPLIST_SIZE];
 	int bcast_duplist_curr;
+	struct bla_claim_dst claim_dest;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t tt_changes_list_lock; /* protects tt_changes */
-- 
1.7.7.1

