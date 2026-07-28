Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B8CC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:43:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DCA384636
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:43:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246190;
 b=s5Hi37ZUS1jVbLZyRhJ4ucf1DcqQUoeFWSJQSZ99K2yDKpskwFKz54gDaVnqsKOnyqpFV
 HiFjTreB1zPE/u+Osyw6OAgOy4udD5EQTLkihoUShRsGwhM8FlQG6GwU8HmasYy/jzPwxod
 +6KoKpyM5WTjWVNthNaEBBCXT2ygpag=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246190; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=coWeleOiXkONqOf47ClRWYEbqPr/zU4iKgYTzQvas5s=;
 b=AM7ftk9GYkJBvddqKcb90U3TMnQFl8mVwYl8PVhmm0C0WUh2EkRajwp2+XqZNd80rYX1C
 rR1pY7pzcYDHGC8UBIrQXtTXSztvnzN9KqZRDRBPeBCCOI3lqM6FCcALEQLak2RLVNj6TY1
 Z/0AEbGRMwOc3U3OdvQcT/2O4YDm+lo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4C9E584222
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245963;
	b=fl2Vm0g0msJ9OSWRj/Nzjrutn9rr2HVp0Hak89BtqTqrXdfZy/o0ZbCB1ywD8RJZFgfc8s
	7ZMuXmgmhwhoBPnHCH6p2T0hRWAJvNASim3JZp50N9Y7m4duvtuKzwdqrltJEXVlyqeMzX
	pJ7ifpZ/+StaOhivsps6ZKuEKQUJtPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=coWeleOiXkONqOf47ClRWYEbqPr/zU4iKgYTzQvas5s=;
	b=f85cYx6kNJDvadF+szqlXrE+oqLdYNyL05nL1Hp2cwRUFz6hkM4RGzJLzjvYLeGJg+McCC
	HMT7Dyq7acfD4NXfNMQ8oj6bkYmtIz01ooDw/LWZgnhPLSoGGMxdrWl6vAIws67j0d5ofc
	AZAZhmMQKSbTaNiRq1tNh1vjzXWZUtw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F3lThY3T;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717EaD808F168C97e5563a8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0AC8FFA03E;
	Tue, 28 Jul 2026 15:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coWeleOiXkONqOf47ClRWYEbqPr/zU4iKgYTzQvas5s=;
	b=F3lThY3TeBx/JuJ0tOirHXW+DVp+xY2WjnvWO5GG0iCHL74+RQ/hDCLe/Ql1iQELjqLseI
	miavEHlkzEgtBVm84yrD9gnNgFjl8d4ex3w7CLaOT0C1h003zmPIcFer6n1kKG15ivTpGH
	PUskwZbovYjEREATYapSr4JZCNHnur4bRHUBh5pf/Xgg9ygFQfTPi6+qWSM9PQuUPI0yzy
	fMQCrmSFMuom05XbY1DmrQH1YvhGIvZXV1RQaM9PfZQ5XkRGdTe1YBV/PESmWrZ3BFA3g3
	oRoKlW/tDUbHT5If+yrkGSdRjdKhO1Mf6dfVTdJ26tCBkeCJQS31mqcVvvs/YQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 04/15] batman-adv: dat: atomically update mac
 addresses
Date: Tue, 28 Jul 2026 15:39:07 +0200
Message-ID: <20260728133918.643267-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3OCB64MQXYLNZHGSE65MWHFDAIHBEL7C
X-Message-ID-Hash: 3OCB64MQXYLNZHGSE65MWHFDAIHBEL7C
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3OCB64MQXYLNZHGSE65MWHFDAIHBEL7C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When a MAC address is updated in batadv_dat_entry_add(), it is done using a
simple copy function. A parallel reader might only see parts of this
update. In worst case, the reader is transporting the half updated MAC
address over the network or is creating an ARP response using it -
poisoning the ARP cache.

atomic64_t can be used to store the 48 bit of a mac address. A reader will
then either see the old mac address or the new one - never a mixture of
both.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 58 +++++++++++++++++---------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 6ca946da92758..95d8e3a383902 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -376,18 +376,19 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 				 u8 *mac_addr, unsigned short vid)
 {
+	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
-		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
-			ether_addr_copy(dat_entry->mac_addr, mac_addr);
+		atomic64_set(&dat_entry->mac_addr, u64_mac);
+
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, dat_entry->mac_addr,
+			   &dat_entry->ip, mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -398,7 +399,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
-	ether_addr_copy(dat_entry->mac_addr, mac_addr);
+	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
@@ -414,7 +415,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, batadv_print_vid(vid));
+		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	batadv_dat_entry_put(dat_entry);
@@ -868,6 +869,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int msecs;
 	void *hdr;
 
@@ -880,11 +883,12 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 	genl_dump_check_consistent(cb, hdr);
 
 	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+	u64_mac = atomic64_read(&dat_entry->mac_addr);
+	u64_to_ether_addr(u64_mac, mac);
 
 	if (nla_put_in_addr(msg, BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
 			    dat_entry->ip) ||
-	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN,
-		    dat_entry->mac_addr) ||
+	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN, mac) ||
 	    nla_put_u16(msg, BATADV_ATTR_DAT_CACHE_VID, dat_entry->vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
 		genlmsg_cancel(msg, hdr);
@@ -1151,6 +1155,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	int hdr_size = 0;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1178,6 +1184,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
 		 * duplicate packet.
@@ -1186,7 +1195,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr, vid)) {
+		if (batadv_is_my_client(bat_priv, mac, vid)) {
 			ret = true;
 			goto out;
 		}
@@ -1196,18 +1205,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * the backbone gws belonging to our backbone has claimed the
 		 * destination.
 		 */
-		if (!batadv_bla_check_claim(bat_priv,
-					    dat_entry->mac_addr, vid)) {
+		if (!batadv_bla_check_claim(bat_priv, mac, vid)) {
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
 				   "Device %pM claimed by another backbone gw. Don't send ARP reply!",
-				   dat_entry->mac_addr);
+				   mac);
 			ret = true;
 			goto out;
 		}
 
 		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-						      dat_entry->mac_addr,
-						      hw_src, vid);
+						      mac, hw_src, vid);
 		if (!skb_new)
 			goto out;
 
@@ -1249,6 +1256,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int err;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
@@ -1276,8 +1285,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!dat_entry)
 		goto out;
 
+	u64_mac = atomic64_read(&dat_entry->mac_addr);
+	u64_to_ether_addr(u64_mac, mac);
+
 	skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-					      dat_entry->mac_addr, hw_src, vid);
+					      mac, hw_src, vid);
 	if (!skb_new)
 		goto out;
 
@@ -1368,6 +1380,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	u8 *hw_src, *hw_dst;
 	bool dropped = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
 		goto out;
@@ -1396,11 +1410,17 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	 * this frame would lead to doubled receive of an ARP reply.
 	 */
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
-	if (dat_entry && batadv_compare_eth(hw_src, dat_entry->mac_addr)) {
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
-			   hw_src, &ip_src, hw_dst, &ip_dst,
-			   dat_entry->mac_addr,	&dat_entry->ip);
-		dropped = true;
+	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
+		if (batadv_compare_eth(hw_src, mac)) {
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
+				   hw_src, &ip_src, hw_dst, &ip_dst,
+				   mac, &dat_entry->ip);
+			dropped = true;
+		}
 	}
 
 	/* Update our internal cache with both the IP addresses the node got
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cd12755d21f35..992de87632954 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2176,7 +2176,7 @@ struct batadv_dat_entry {
 	__be32 ip;
 
 	/** @mac_addr: the MAC address associated to the stored IPv4 */
-	u8 mac_addr[ETH_ALEN];
+	atomic64_t mac_addr;
 
 	/** @vid: the vlan ID associated to this entry */
 	unsigned short vid;
-- 
2.47.3

