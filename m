Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Mar 2012 09:07:52 +0100
Message-Id: <1331107673-8986-8-git-send-email-sven@narfation.org>
In-Reply-To: <1331107673-8986-1-git-send-email-sven@narfation.org>
References: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
	<1331107673-8986-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/8-master] batman-adv: Remove spaces after a
	cast
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
 bridge_loop_avoidance.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index da220cf..23bfbed 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -289,7 +289,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		goto out;
 
 	ethhdr = (struct ethhdr *)skb->data;
-	hw_src = (uint8_t *) ethhdr + ETH_HLEN + sizeof(struct arphdr);
+	hw_src = (uint8_t *)ethhdr + ETH_HLEN + sizeof(struct arphdr);
 
 	/* now we pretend that the client would have sent this ... */
 	switch (claimtype) {
@@ -512,7 +512,7 @@ static void bla_send_announce(struct bat_priv *bat_priv,
 
 	memcpy(mac, announce_mac, 4);
 	crc = htons(backbone_gw->crc);
-	memcpy(&mac[4], (uint8_t *) &crc, 2);
+	memcpy(&mac[4], (uint8_t *)&crc, 2);
 
 	bla_send_claim(bat_priv, mac, backbone_gw->vid, CLAIM_TYPE_ANNOUNCE);
 
@@ -629,7 +629,7 @@ static int handle_announce(struct bat_priv *bat_priv,
 
 	/* handle as ANNOUNCE frame */
 	backbone_gw->lasttime = jiffies;
-	crc = ntohs(*((uint16_t *) (&an_addr[4])));
+	crc = ntohs(*((uint16_t *)(&an_addr[4])));
 
 	bat_dbg(DBG_BLA, bat_priv,
 		"handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %04x\n",
@@ -755,7 +755,7 @@ static int check_claim_group(struct bat_priv *bat_priv,
 	struct orig_node *orig_node;
 	struct bla_claim_dst *bla_dst, *bla_dst_own;
 
-	bla_dst = (struct bla_claim_dst *) hw_dst;
+	bla_dst = (struct bla_claim_dst *)hw_dst;
 	bla_dst_own = &bat_priv->claim_dest;
 
 	/* check if it is a claim packet in general */
@@ -834,7 +834,7 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
-		vhdr = (struct vlan_ethhdr *) ethhdr;
+		vhdr = (struct vlan_ethhdr *)ethhdr;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 		proto = ntohs(vhdr->h_vlan_encapsulated_proto);
 		headlen = sizeof(*vhdr);
@@ -852,8 +852,8 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 		return 0;
 
 	/* pskb_may_pull() may have modified the pointers, get ethhdr again */
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
-	arphdr = (struct arphdr *) ((uint8_t *) ethhdr + headlen);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	arphdr = (struct arphdr *)((uint8_t *)ethhdr + headlen);
 
 	/* Check whether the ARP frame carries a valid
 	 * IP information */
@@ -869,7 +869,7 @@ static int bla_process_claim(struct bat_priv *bat_priv,
 
 	hw_src = (uint8_t *)arphdr + sizeof(struct arphdr);
 	hw_dst = hw_src + ETH_ALEN + 4;
-	bla_dst = (struct bla_claim_dst *) hw_dst;
+	bla_dst = (struct bla_claim_dst *)hw_dst;
 
 	/* check if it is a claim frame. */
 	ret = check_claim_group(bat_priv, primary_if, hw_src, hw_dst, ethhdr);
@@ -1193,7 +1193,7 @@ int bla_check_bcast_duplist(struct bat_priv *bat_priv,
 	struct bcast_duplist_entry *entry;
 
 	length = hdr_size - sizeof(*bcast_packet);
-	content = (uint8_t *) bcast_packet;
+	content = (uint8_t *)bcast_packet;
 	content += sizeof(*bcast_packet);
 
 	/* calculate the crc ... */
@@ -1299,14 +1299,14 @@ int bla_is_backbone_gw(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
 		return 0;
 
-	ethhdr = (struct ethhdr *) (((uint8_t *)skb->data) + hdr_size);
+	ethhdr = (struct ethhdr *)(((uint8_t *)skb->data) + hdr_size);
 
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
 		if (!pskb_may_pull(skb, hdr_size + sizeof(struct vlan_ethhdr)))
 			return 0;
 
-		vhdr = (struct vlan_ethhdr *) (((uint8_t *)skb->data) +
-						hdr_size);
+		vhdr = (struct vlan_ethhdr *)(((uint8_t *)skb->data) +
+					      hdr_size);
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 	}
 
-- 
1.7.9.1

