Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22486CA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 12:07:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0F2AE844E9
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 14:07:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791288460;
 b=jB0iosMkkvvZiz+andxzLK+YYcmMzjIsjXDdjOIZX2PJDnKL3GJdIj9Wxy0rahIL5HYRl
 hk52I9HXfySLPXDvS/BaIP3bXGqYlY7OhfuhCIN1OTMZ14N2hauUz/q0U730imUHLInP78x
 JVnOroBZjEQ9aMIySTvR6iFlZT+ZzLY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791288460; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2DBV2WI664mxvRLEH0d9WsYHfTmyRMazdH0zCVnzQuI=;
 b=jHR86qNWlldkABK+XpuK3gLby3qVlSZQ/ED3X/Z49Uajn97a98tm2u6l9owfdRqPM9OZf
 +1Q5R4c9ydqvRli9DpSYfJQuNIWvayMkIHqSHEZBAsQEsbu9/CsoYnbdjLYtbyNvN/a1r29
 QULYAcIYRB7wPg7ChlXGTPrIOP7Fv/k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E5EDF83B19
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 14:07:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791288450;
	b=ktvbwahSxFMbpKfGD3Fr+jbp6cgjiq0Irh/oorQiL1/Unu0bZB+1SRQbvYaPpyCz+usnJ5
	eBfSvjmC+xE6iNUdGUbknHo0NHmKxVZEfhCTbg2SMsF7XxIfblnOfnXiwEWS5EKQojZHua
	1dGaU46i3ZiwzL/6rLOOeJtpYhvBpwg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791288450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DBV2WI664mxvRLEH0d9WsYHfTmyRMazdH0zCVnzQuI=;
	b=Orf+0FRYCJwnFgRInb1xlZhSutfL9wQSJEUadTaznjdIA/z83P8IEqF76XVK4RL4joGIlQ
	947GgKNLRKZWxtzc03FzttK+V/+23+SKnu4Ho2aq+dRIyP1CtRKvu7GLITB28nUnMwZAj8
	mYEXRPf1rjwkWPKpFejcv3qFzPOMZXQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 69A56232CA;
	Tue, 06 Oct 2026 14:07:20 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v13 1/5] batman-adv: move local ARP reply code to
 subfunctions
Date: Tue,  6 Oct 2026 14:06:42 +0200
Message-ID: <20261006120647.8646-2-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006120647.8646-1-linus.luessing@c0d3.blue>
References: <20261006120647.8646-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: RURIOVCZ5WPYMIFPLUNC4Q6Y647HOTHZ
X-Message-ID-Hash: RURIOVCZ5WPYMIFPLUNC4Q6Y647HOTHZ
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RURIOVCZ5WPYMIFPLUNC4Q6Y647HOTHZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Shorten the length of batadv_dat_snoop_outgoing_arp_request() by moving
the checks for and generation of a local ARP reply to a new subfunction.
This is also in preparation for reuseability for the DAT cache/DHT
split.

No functional change.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/distributed-arp-table.c | 181 ++++++++++++++-----------
 1 file changed, 105 insertions(+), 76 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bffedbc..1a0eb9d9812e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -738,6 +738,103 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 	return res;
 }
 
+/**
+ * batadv_dat_arp_create_reply() - create an ARP Reply
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @ip_src: ARP sender IP
+ * @ip_dst: ARP target IP
+ * @hw_src: Ethernet source and ARP sender MAC
+ * @hw_dst: Ethernet destination and ARP target MAC
+ * @vid: VLAN identifier (optional, set to zero otherwise)
+ *
+ * Creates an ARP Reply from the given values, optionally encapsulated in a
+ * VLAN header.
+ *
+ * Return: An skb containing an ARP Reply.
+ */
+static struct sk_buff *
+batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
+			    __be32 ip_dst, u8 *hw_src, u8 *hw_dst,
+			    unsigned short vid)
+{
+	struct sk_buff *skb;
+
+	skb = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_dst, bat_priv->mesh_iface,
+			 ip_src, hw_dst, hw_src, hw_dst);
+	if (!skb)
+		return NULL;
+
+	skb_reset_mac_header(skb);
+
+	if (vid & BATADV_VLAN_HAS_TAG)
+		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q),
+				      vid & VLAN_VID_MASK);
+
+	return skb;
+}
+
+/**
+ * batadv_dat_arp_self_reply() - (maybe) reply to a local ARP request
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @ip_src: ARP request sender IP (and ARP reply target IP)
+ * @ip_dst: ARP request target IP (and ARP reply sender IP)
+ * @hw_src: Ethernet source and ARP sender MAC of ARP request
+ * @hw_dst: Ethernet destination and ARP target MAC of ARP request
+ * @vid: VLAN identifier (optional, set to zero otherwise)
+ * @arp_len: ARP packet size, including ethernet frame
+ *
+ * If the ARP request target is not a local client and if BLA is
+ * enabled and we have BLA claimed this target then generate and reply
+ * with an ARP reply locally on our mesh interface.
+ *
+ * Return: 0 if we transmitted an ARP reply, -ENOMEM if we should have but
+ * could not create an ARP reply (e.g. due to out-of-memory), -EACCSS
+ * otherwise (because the client is local or due to BLA suppression).
+ */
+static int
+batadv_dat_arp_self_reply(struct batadv_priv *bat_priv, __be32 ip_src,
+			  __be32 ip_dst, u8 *hw_src, u8 *hw_dst,
+			  unsigned short vid, unsigned int arp_len)
+{
+	struct sk_buff *skb;
+
+	/* If the ARP request is destined for a local client the local
+	 * client will answer itself. DAT would only generate a
+	 * duplicate packet.
+	 *
+	 * Moreover, if the mesh-interface is enslaved into a bridge, an
+	 * additional DAT answer may trigger kernel warnings about
+	 * a packet coming from the wrong port.
+	 */
+	if (batadv_is_my_client(bat_priv, hw_dst, vid))
+		return -EACCES;
+
+	/* If BLA is enabled, only send ARP replies if we have claimed
+	 * the destination for the ARP request or if no one else of
+	 * the backbone gws belonging to our backbone has claimed the
+	 * destination.
+	 */
+	if (!batadv_bla_check_claim(bat_priv, hw_dst, vid)) {
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "Device %pM claimed by another backbone gw. Don't send ARP reply!",
+			   hw_dst);
+		return -EACCES;
+	}
+
+	skb = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src, hw_dst,
+					  hw_src, vid);
+	if (!skb)
+		return -ENOMEM;
+
+	skb->protocol = eth_type_trans(skb, bat_priv->mesh_iface);
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES, arp_len);
+
+	netif_rx(skb);
+	return 0;
+}
+
 /**
  * batadv_dat_forward_data() - copy and send payload to the selected candidates
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1179,41 +1276,6 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 	return vid;
 }
 
-/**
- * batadv_dat_arp_create_reply() - create an ARP Reply
- * @bat_priv: the bat priv with all the mesh interface information
- * @ip_src: ARP sender IP
- * @ip_dst: ARP target IP
- * @hw_src: Ethernet source and ARP sender MAC
- * @hw_dst: Ethernet destination and ARP target MAC
- * @vid: VLAN identifier (optional, set to zero otherwise)
- *
- * Creates an ARP Reply from the given values, optionally encapsulated in a
- * VLAN header.
- *
- * Return: An skb containing an ARP Reply.
- */
-static struct sk_buff *
-batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
-			    __be32 ip_dst, u8 *hw_src, u8 *hw_dst,
-			    unsigned short vid)
-{
-	struct sk_buff *skb;
-
-	skb = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_dst, bat_priv->mesh_iface,
-			 ip_src, hw_dst, hw_src, hw_dst);
-	if (!skb)
-		return NULL;
-
-	skb_reset_mac_header(skb);
-
-	if (vid & BATADV_VLAN_HAS_TAG)
-		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q),
-				      vid & VLAN_VID_MASK);
-
-	return skb;
-}
-
 /**
  * batadv_dat_snoop_outgoing_arp_request() - snoop the ARP request and try to
  * answer using DAT
@@ -1232,10 +1294,9 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
-	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	struct batadv_dat_entry *dat_entry = NULL;
 	u8 mac[ETH_ALEN] __aligned(2);
-	struct sk_buff *skb_new;
+	unsigned int arp_len;
 	unsigned short vid;
 	bool ret = false;
 	int hdr_size = 0;
@@ -1244,6 +1305,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	u16 type = 0;
 	u64 u64_mac;
 	u8 *hw_src;
+	int rep;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1253,6 +1315,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
+	arp_len = skb->len + ETH_HLEN + hdr_size;
 
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	/* If the node gets an ARP_REQUEST it has to send a DHT_GET unicast
@@ -1274,46 +1337,12 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		u64_mac = atomic64_read(&dat_entry->mac_addr);
 		u64_to_ether_addr(u64_mac, mac);
 
-		/* If the ARP request is destined for a local client the local
-		 * client will answer itself. DAT would only generate a
-		 * duplicate packet.
-		 *
-		 * Moreover, if the mesh-interface is enslaved into a bridge, an
-		 * additional DAT answer may trigger kernel warnings about
-		 * a packet coming from the wrong port.
-		 */
-		if (batadv_is_my_client(bat_priv, mac, vid)) {
-			ret = true;
-			goto out;
-		}
-
-		/* If BLA is enabled, only send ARP replies if we have claimed
-		 * the destination for the ARP request or if no one else of
-		 * the backbone gws belonging to our backbone has claimed the
-		 * destination.
-		 */
-		if (!batadv_bla_check_claim(bat_priv, mac, vid)) {
+		rep = batadv_dat_arp_self_reply(bat_priv, ip_src, ip_dst,
+						hw_src, mac, vid, arp_len);
+		if (!rep)
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
-				   "Device %pM claimed by another backbone gw. Don't send ARP reply!",
-				   mac);
-			ret = true;
-			goto out;
-		}
-
-		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-						      mac, hw_src, vid);
-		if (!skb_new)
-			goto out;
-
-		skb_new->protocol = eth_type_trans(skb_new, mesh_iface);
-
-		batadv_inc_counter(bat_priv, BATADV_CNT_RX);
-		batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
-				   skb->len + ETH_HLEN + hdr_size);
-
-		netif_rx(skb_new);
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
-		ret = true;
+				   "ARP request replied locally\n");
+		ret = (rep != -ENOMEM);
 	} else {
 		/* Send the request to the DHT */
 		ret = batadv_dat_forward_data(bat_priv, skb, ip_dst, vid,
-- 
2.55.0

