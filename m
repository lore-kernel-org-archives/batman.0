Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A8C5DF97
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:15:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C854C83CE2
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 15:15:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787404540;
 b=1bRQ11DtoZ6OahJ2nmIG99Iq/tgRb4Ga2ai9rBGscEkbGZic/ieX7BcOtRGsP1bVaIa+J
 sc8fBLybNYoZnVVWRFl4CU0E9Q9KMJF+A+uMUThUes+ieU9Lp2emFevTvx7htqjlTckI0zx
 Uj7NMALhnk90q+S5lxQnws4bXpYlrM0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787404540; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aMIFZJE9rSjCOBx7E/xagdQD723U9XG2NMyv1j7FX8A=;
 b=wjnzLW1vrG5XFZnena/r8UctnqovpzSKfLZnN1PuBpjjQgmDULYjBqcKk4CVlypeffgOi
 Tyi5bwR6mRn0Ys8byuuIs3almdjDW9a/p7iVdTZ4UNG1eh5nTcNEvnFISdEdd3inOZQ6y/7
 xHlZVHvi9nb2F7rI1N+Med5QtlqZ4eI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 16BB582DE5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 15:14:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787404478;
	b=wnPMiEyeMi9SUzBSdWvM9lQD50H5RJCZv9ntfX4CwnhI1WA4dwpsVmRJP7+e1SC3vvjkxL
	kMDUhYiI9ScxDq5aGBLBg35rumt2z0/0ZGIGTZY1WYuh7cYkZ3bGC44PMWiBE0xLQZC2Zf
	VReFh49lUowNm0NqGjML45fO2cUIA/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787404478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aMIFZJE9rSjCOBx7E/xagdQD723U9XG2NMyv1j7FX8A=;
	b=N02FYc7A8nJyYRuCoRvO+OtqXZ1O6TE+mxNw4tG5pr+WRquMt5Gvyv9jQKDZhOpDY0uQP2
	uzVviODvcdAotRru/XOxnPcDXoGoGiY/gxrEHYCMh3xRow7C9S7vwbjParcRBMIKtiPV9s
	ddPakH6tfZjsxIcqeLWRGPBfmoIv7uY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ONkSjYT5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 30DA320722;
	Sat, 22 Aug 2026 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787404463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMIFZJE9rSjCOBx7E/xagdQD723U9XG2NMyv1j7FX8A=;
	b=ONkSjYT5NkR1n3DqqyxIn6+hI/HwEF5hEBsQORu6TdbUI3K8u731xcRBukM1Mqoi4cgn1e
	4E7vRB4DJIOV9eJoKWuQvSkfoz2S2vgdXZwQIsHcuqosPBhcVjLgB/OJxPjMz2ouc6I/x2
	sCR00EWu3oSaA/Rsg/csXIDkOFQXLRY=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 22 Aug 2026 15:14:03 +0200
Subject: [PATCH batadv 1/2] batman-adv: ensure u16 aligned mac address
 arrays on stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-mac-u16-alignment-v1-1-bafa0040ada7@narfation.org>
References: <20260822-mac-u16-alignment-v1-0-bafa0040ada7@narfation.org>
In-Reply-To: <20260822-mac-u16-alignment-v1-0-bafa0040ada7@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6516; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZPOdrI5fgcBuDEt8C0CtDO4+xe6MngGTCiy1AFNr/LM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmdC+bqNdtZecabnkz4u2O+yOkfJg3rIueae5iF7HuZk
 T33zT7ljlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEmi4yMqw/JRRUamNTLq/S
 /Vu7sHzJH/WNrjrr5aYviVZcufluWRrDXwkRzz8/As47/z+n3bb8ZsiOFUvmL/koaiM7pbZW1Hl
 CNRcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WGTC2WSNZ355BVQFIP5V4ROVHQT6BNHP
X-Message-ID-Hash: WGTC2WSNZ355BVQFIP5V4ROVHQT6BNHP
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WGTC2WSNZ355BVQFIP5V4ROVHQT6BNHP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

An u8 array on the stack has a natural alignment of only 1 byte. An
u8[ETH_ALEN] array on the stack must therefore be assumed to only be 1 byte
aligned. But many etherdevices.h functions are requiring a 2 byte (u16)
alignment.

Annote all u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure
that the compiler takes care of aligning it correctly.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260821094813.201800-1-sw%40simonwunderlich.de?part=5
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |  6 ++++--
 net/batman-adv/distributed-arp-table.c |  8 ++++----
 net/batman-adv/mesh-interface.c        | 12 ++++++++----
 net/batman-adv/multicast.c             |  6 +++---
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f635da4b..ad6ab4a5 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -663,7 +663,7 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 				     struct batadv_bla_backbone_gw *backbone_gw)
 {
-	u8 mac[ETH_ALEN];
+	u8 mac[ETH_ALEN] __aligned(2);
 	__be16 crc;
 
 	memcpy(mac, batadv_announce_mac, 4);
@@ -1582,7 +1582,9 @@ static struct lock_class_key batadv_backbone_hash_lock_class_key;
  */
 int batadv_bla_init(struct batadv_priv *bat_priv)
 {
-	u8 claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
+	static const u8 claim_dest[ETH_ALEN] __aligned(2) = {
+		0xff, 0x43, 0x05, 0x00, 0x00, 0x00
+	};
 	struct batadv_hard_iface *primary_if;
 	unsigned long entrytime;
 	u16 crc;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 011cfdc4..ae0e45a2 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -940,7 +940,7 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
-	u8 mac[ETH_ALEN];
+	u8 mac[ETH_ALEN] __aligned(2);
 	u64 u64_mac;
 	int msecs;
 	void *hdr;
@@ -1236,10 +1236,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 {
 	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	struct batadv_dat_entry *dat_entry = NULL;
+	u8 mac[ETH_ALEN] __aligned(2);
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
-	u8 mac[ETH_ALEN];
 	int hdr_size = 0;
 	__be32 ip_dst;
 	__be32 ip_src;
@@ -1344,10 +1344,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
+	u8 mac[ETH_ALEN] __aligned(2);
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
-	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
 	u64 u64_mac;
@@ -1474,9 +1474,9 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
+	u8 mac[ETH_ALEN] __aligned(2);
 	bool dropped = false;
 	unsigned short vid;
-	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
 	u64 u64_mac;
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 53bb9836..3c95d9ce 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -141,9 +141,9 @@ static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	u8 old_addr[ETH_ALEN] __aligned(2);
 	struct batadv_meshif_vlan *vlan;
 	struct sockaddr *addr = p;
-	u8 old_addr[ETH_ALEN];
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -213,13 +213,18 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *mesh_iface)
 {
-	static const u8 ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00, 0x00, 0x00};
-	static const u8 stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	enum batadv_dhcp_recipient dhcp_rcp = BATADV_DHCP_NO;
 	enum batadv_forw_mode forw_mode = BATADV_FORW_BCAST;
+	static const u8 ectp_addr[ETH_ALEN] __aligned(2) = {
+		0xCF, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+	static const u8 stp_addr[ETH_ALEN] __aligned(2) = {
+		0x01, 0x80, 0xC2, 0x00, 0x00, 0x00
+	};
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
+	u8 chaddr[ETH_ALEN] __aligned(2);
 	int network_offset = ETH_HLEN;
 	unsigned int header_len = 0;
 	unsigned long brd_delay = 0;
@@ -229,7 +234,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	struct ethhdr *ethhdr;
 	bool do_bcast = false;
 	u8 *dst_hint = NULL;
-	u8 chaddr[ETH_ALEN];
 	unsigned short vid;
 	bool client_added;
 	__be16 proto;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 155592ab..4a92f672 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -374,9 +374,9 @@ batadv_mcast_mla_meshif_get_ipv4(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
+	u8 mcast_addr[ETH_ALEN] __aligned(2);
 	struct batadv_hw_addr *new;
 	struct in_device *in_dev;
-	u8 mcast_addr[ETH_ALEN];
 	struct ip_mc_list *pmc;
 	int ret = 0;
 
@@ -441,9 +441,9 @@ batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
+	u8 mcast_addr[ETH_ALEN] __aligned(2);
 	struct batadv_hw_addr *new;
 	struct inet6_dev *in6_dev;
-	u8 mcast_addr[ETH_ALEN];
 	struct ifmcaddr6 *pmc6;
 	int ret = 0;
 
@@ -593,10 +593,10 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 				       struct batadv_mcast_mla_flags *flags)
 {
 	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
+	u8 mcast_addr[ETH_ALEN] __aligned(2);
 	u8 tvlv_flags = flags->tvlv_flags;
 	struct br_ip_list *br_ip_entry;
 	struct batadv_hw_addr *new;
-	u8 mcast_addr[ETH_ALEN];
 	struct br_ip_list *tmp;
 	int ret;
 

-- 
2.47.3

