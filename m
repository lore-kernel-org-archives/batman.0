Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B914FC43458
	for <batman-adv@archiver.kernel.org>; Mon,  6 Jul 2026 17:21:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 26EBC83E66
	for <batman-adv@archiver.kernel.org>; Mon, 06 Jul 2026 19:21:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783358505;
 b=LCFdUcAuWzymJbavp49+tNhylhW6RMP7UALO1Jj9ULEXdLNaqOVsd1w4Ljod7d0pcpycs
 ESYkEcHQFrcjTLV4p+9DLjG5rbVWVMnKJUU5iwf0+msVCqfQmCX46wm1eprvw4lk/o+blLo
 pbb5WtHjLhskCWVhvo6m71ey0jErmqI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783358505; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OSMi2w1GCd3hh8U1eA2myGR5PLVnGFY+q/zgvzk4FBo=;
 b=AKesrosKf7j8NmkbnDnG0lQk3ZRg1+f+ujF2pUjtyJEKhGXujdAUtwyOsfzXKKyYKcyC+
 ECGj5COU2/vAb8BiM5F3wIo17WiYODxhvhMKsqOMAPGLGMPscKMPENQO9weIDuCHxLNJM3Z
 5IRuljaOfWg5fA9XomS/PcV4Q9TXhkk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B7AAB810E8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 06 Jul 2026 19:21:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783358481;
	b=QRS33mPoIH1jYqtSBcSh106rti+xZhA59LIoxcowuU6nT2Mhp/K7uXo4ov8pEuVPF2jy2U
	wLXY1Wb7Oy8XZlMYVpl0PSu4gKw51D+QdTS9UXCMhN6Lw11fhCZ4q6P3hDj5XVU6U7UUQL
	n7epMMaeHBe0MUCzfZznF3k8sFWcP5E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783358481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=OSMi2w1GCd3hh8U1eA2myGR5PLVnGFY+q/zgvzk4FBo=;
	b=YeQTVeLPBslOcVGJOqO/5IQ10hAED3VfQLGyiXipjSS57zYr3glGtv3uw5c4TqGuLB4NMd
	phGxsg7DfsVqqtzPyw8zAQniz2M/L908JRuYPe03qhegXgxUaZob7rSNTBt+7VAgdbTGXF
	ge8WuklMRA0CK1D7xC666gCXWjb35FE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Jnq7VXmZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9B1AD2026A;
	Mon, 06 Jul 2026 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783358480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OSMi2w1GCd3hh8U1eA2myGR5PLVnGFY+q/zgvzk4FBo=;
	b=Jnq7VXmZ6Iz403l145rUhSbtgxEVxOTGcV8ShL3bNGrxdFio+ja7fCeb1CH9gEmUTFn/+4
	kYqNeEtZR1TVtE/fTwTQbfNUBS6u3NnTnMw15sW411N871+lXBLz7/0ojRm+KNHzzkA+Y0
	fw2nBD3EHx1quuMYBc+ns1ybhgNhOd4=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Jul 2026 19:21:14 +0200
Subject: [PATCH batadv] batman-adv: dat: atomically update mac addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-dat-atomic-mac-v1-1-934e5fb2c7e0@narfation.org>
X-B4-Tracking: v=1; b=H4sIAAnkS2oC/yWMQQqDQAwAvyI5NxClXW2/UjzEbNQU1LK7FUH8u
 9v2OAMzO0QNphEexQ5BV4u2zBnKSwEy8jwoms8MFVWOanLoOSGnZTLBiQVJbg2pXmtX3iFH76C
 9bb/hEzpO7Fdo/z5+updK+t7gOE4EQ+VWegAAAA==
X-Change-ID: 20260706-dat-atomic-mac-0c580ee47619
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8038; i=sven@narfation.org;
 h=from:subject:message-id; bh=ixQrZUEfv0/NZMoYUgi0RBUIg5aix/RmZCKRZO0XgEY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFneT3jMLk/fq3x05/pX8bsWXF6b9Exceo25YGzc9d7fS
 7T2Vhj+6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpGwKI8OD3f7LTsye2Jai
 rWJ7mKf6QZLF1UDexiV7tpy9VdF5Z2MbI8P8ify6M6x5xf7qfLg166V4xJw1X9cl3b4XWHTB0nV
 +EQcLAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5O4YSUPDV5VQ3NSNPDS2ADMGTIRWLNTP
X-Message-ID-Hash: 5O4YSUPDV5VQ3NSNPDS2ADMGTIRWLNTP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5O4YSUPDV5VQ3NSNPDS2ADMGTIRWLNTP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a MAC address is updated in batadv_dat_entry_add(), it is done using a
simple copy function. A parallel reader might only see parts of this
update. In worst case, the reader is transporting the half updated MAC
address over the network or is creating an ARP response using it -
poisoning the ARP cache.

atomic64_t can be used to store the 48 bit of a mac address. A reader will
then either see the old mac address or the new one - never a mixture of
both.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: f6badf9eb582 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 58 +++++++++++++++++++++++-----------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a5c9b6d0..6b16ebd7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -440,18 +440,19 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
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
@@ -462,7 +463,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
-	ether_addr_copy(dat_entry->mac_addr, mac_addr);
+	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
@@ -478,7 +479,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, batadv_print_vid(vid));
+		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	batadv_dat_entry_put(dat_entry);
@@ -935,6 +936,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int msecs;
 	void *hdr;
 
@@ -947,11 +950,12 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1231,10 +1235,12 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
+	u8 mac[ETH_ALEN];
 	int hdr_size = 0;
 	__be32 ip_dst;
 	__be32 ip_src;
 	u16 type = 0;
+	u64 u64_mac;
 	u8 *hw_src;
 
 	if (!READ_ONCE(bat_priv->distributed_arp_table))
@@ -1263,6 +1269,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
 		 * duplicate packet.
@@ -1271,7 +1280,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr, vid)) {
+		if (batadv_is_my_client(bat_priv, mac, vid)) {
 			ret = true;
 			goto out;
 		}
@@ -1281,18 +1290,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
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
 
@@ -1336,8 +1343,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	struct sk_buff *skb_new;
 	unsigned short vid;
 	bool ret = false;
+	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
+	u64 u64_mac;
 	u8 *hw_src;
 	u16 type;
 	int err;
@@ -1367,8 +1376,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
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
 
@@ -1460,8 +1472,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool dropped = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
 	__be32 ip_src;
 	__be32 ip_dst;
+	u64 u64_mac;
 	u8 *hw_src;
 	u8 *hw_dst;
 	u16 type;
@@ -1493,11 +1507,17 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
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
index 688cf233..d6e15d46 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2176,7 +2176,7 @@ struct batadv_dat_entry {
 	__be32 ip;
 
 	/** @mac_addr: the MAC address associated to the stored IPv4 */
-	u8 mac_addr[ETH_ALEN];
+	atomic64_t mac_addr;
 
 	/** @vid: the vlan ID associated to this entry */
 	unsigned short vid;

---
base-commit: e281f6726677f7e8950dad1640d5386867e6d2e6
change-id: 20260706-dat-atomic-mac-0c580ee47619

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

