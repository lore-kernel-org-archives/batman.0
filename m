Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E806CA5FDD
	for <batman@archiver.kernel.org>; Sat,  3 Oct 2026 07:29:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C41008483C
	for <batman@archiver.kernel.org>; Sat, 03 Oct 2026 09:29:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791012579;
 b=vPUDxZMrgagxHt5C+PW5DDVt+T4KaArmXP6t1L+hACU/807FhczEH8S+w3xdI4nazWq5e
 HKGGKuE840vPxMRvutBxdT/36N/jNaqKrFRpQoN/O8HO9PG5JLyDZVOvlP4xws+a1I+2n6w
 6xfaw3fhFv3OZ1CPmP+gB7G62vp/JTY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791012579; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aZEnbuLFAQZ5W6ZiZDS1AVzyp2OBqnZ6PFIF5xhsmjE=;
 b=PbWRcFOxBDFWGs67U+MBtBCAinRvbQ2g8vk3VhOc2jSHKo1o2JjDrrKeb02webq3UXi3G
 Dxj6AFQVZniLoVcnj044LMSPvsT9DwwSvxMJl5jaKp3P+W7IcRbuCNPFk6aprjnqxWblQFI
 MYnMsmU0tuH15iVKKdA/USL55lBIzWk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 40BB0844DB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 03 Oct 2026 09:26:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791012420;
	b=1ovWUYa6hQhuaZWRgxjtoBet3aENxhR5W4cb20A1tmCKPA/Mdo/uhyuxIU7ujjLKQMAo6D
	t+9sz5BJLTrGfCZkYwI0p8Y0eYdxsbM0mitRTOwrv1OBo5NVqh2Lud9zeS2k3TpqxdbDdD
	gyFssT2+mEUFUJ/FWArccNV/Swm0Z0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791012420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZEnbuLFAQZ5W6ZiZDS1AVzyp2OBqnZ6PFIF5xhsmjE=;
	b=at5epj0I9n2ry4F476+1kIITRibEi9h6LLjiEQO0DULPTJd+2z7wLZmCyQs6YNDvpL9tWm
	oe9oz0zxjTS7SaPzbp3hM9Gm4e3QDJoYkhhxVgxz0Q1qe3NzYvsboN8I2hhL18GQi+O0Mq
	2d62pkMA124pTugra9KmvJ7xBVQjffw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7658D23376;
	Sat, 03 Oct 2026 09:26:41 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v12 5/5] batman-adv: avoid superfluous DAT DHT_PUT additions
 to local DAT
Date: Sat,  3 Oct 2026 09:26:28 +0200
Message-ID: <20261003072628.28052-6-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003072628.28052-1-linus.luessing@c0d3.blue>
References: <20261003072628.28052-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: GZ55ZSN3C5NSU732WERKTKAWQQHT7VAQ
X-Message-ID-Hash: GZ55ZSN3C5NSU732WERKTKAWQQHT7VAQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GZ55ZSN3C5NSU732WERKTKAWQQHT7VAQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

We send DHT_PUT ARP Replies to (typically) three DAT DHT candidates
for the sender MAC/IP pair and another three for the target MAC/IP
pair to likely different DAT DHT candidates. On the DHT_PUT
receiving side we would then add both the sender MAC/IP and target
MAC/IP to the local DHT, even if we are not actually a selected
DAT candidate for one of the pairs.

This way we typically unnecessarily populate our local DHT with
superfluous entries. Entries which no DAT DHT_GET will likely
ever query from us.

To avoid these unnecessary local DHT additions add a flag to DHT_PUT
messages to indicate which pair is supposed to be added to the local
DHT.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batadv_packet.h     |  17 +++-
 net/batman-adv/distributed-arp-table.c | 124 ++++++++++++++++++++++---
 net/batman-adv/distributed-arp-table.h |  15 ++-
 net/batman-adv/mesh-interface.c        |   4 +
 net/batman-adv/routing.c               |  19 +++-
 net/batman-adv/send.c                  |   8 +-
 net/batman-adv/send.h                  |   3 +-
 net/batman-adv/types.h                 |  24 +++++
 8 files changed, 186 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 32436560ecc8..6f4783887d37 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -70,6 +70,19 @@ enum batadv_subtype {
 	BATADV_P_DAT_CACHE_REPLY	= 0x04,
 };
 
+/**
+ * enum batadv_subtype_flags - unicast4addr packet subtype specific flags
+ * @BATADV_P_DAT_DHT_PUT_NO_SRC: do not add sender IP/MAC from DHT_PUT ARP Reply
+ *  to local DHT
+ * @BATADV_P_DAT_DHT_PUT_NO_DST: do not add target IP/MAC from DHT_PUT ARP Reply
+ *  to local DHT
+ */
+enum batadv_subtype_flags {
+	BATADV_P_DAT_DHT_PUT_NO_SRC	= 0x01,
+	BATADV_P_DAT_DHT_PUT_NO_DST	= 0x02,
+};
+
+
 /* this file is included by batctl which needs these defines */
 #define BATADV_COMPAT_VERSION 15
 
@@ -433,13 +446,13 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
- * @reserved: reserved byte for alignment
+ * @flags: packet subtype specific flags
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
 	__u8 src[ETH_ALEN];
 	__u8 subtype;
-	__u8 reserved;
+	__u8 flags;
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 52dff46a7c52..739269a3b9d8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -160,6 +160,9 @@ struct batadv_dhcp_option_header {
 #define BATADV_DHCP_CHADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
 
 static void batadv_dat_purge(struct work_struct *work);
+static bool
+batadv_dat_dht_check_self_is_candidate(struct batadv_priv *bat_priv,
+				       __be32 ip, unsigned short vid);
 
 /**
  * batadv_dat_start_timer() - initialise the DAT periodic worker
@@ -562,6 +565,20 @@ static inline void
 batadv_dat_dht_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 			 u8 *mac_addr, unsigned short vid)
 {
+	/* Happens if a new node just beat us as a candidate, an old node
+	 * does not have the more specific candidate selection enhancements yet
+	 * or if future protocol enhancements, which this node does not have
+	 * yet, added new/other candidate selections. For compatibility reasons
+	 * do not bail out here.
+	 */
+	if (!batadv_dat_dht_check_self_is_candidate(bat_priv, ip, vid)) {
+		batadv_inc_counter(bat_priv,
+				   BATADV_CNT_DAT_DHT_ADD_NOT_CANDIDATE);
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "Adding %pI4 %pM (vid: %d), although we are not a candidate\n",
+			   &ip, mac_addr, batadv_print_vid(vid));
+	}
+
 	batadv_dat_entry_add(bat_priv, bat_priv->dat.dht_hash, ip, mac_addr,
 			     vid, "dht");
 }
@@ -1050,6 +1067,7 @@ batadv_dat_dht_get_self_reply(struct batadv_priv *bat_priv, __be32 ip_src,
  * @ip: the DHT key
  * @vid: VLAN identifier
  * @packet_subtype: unicast4addr packet subtype to use
+ * @flags: packet subtype specific flags to set
  *
  * This function copies the skb with pskb_copy() and is sent as a unicast packet
  * to each of the selected candidates.
@@ -1060,7 +1078,8 @@ batadv_dat_dht_get_self_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 				    struct batadv_dat_candidate *cands,
 				    struct sk_buff *skb, __be32 ip,
-				    unsigned short vid, int packet_subtype)
+				    unsigned short vid, int packet_subtype,
+				    int flags)
 {
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
@@ -1085,7 +1104,8 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, tmp_skb,
 							   cands[i].orig_node,
-							   packet_subtype)) {
+							   packet_subtype,
+							   flags)) {
 			kfree_skb(tmp_skb);
 			goto free_neigh;
 		}
@@ -1135,6 +1155,31 @@ static void batadv_dat_candidates_free(struct batadv_dat_candidate *cands)
 	kfree(cands);
 }
 
+/**
+ * batadv_dat_dht_check_self_is_candidate() - check if we are a DHT candidate
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @ip: key to look up in the DHT
+ * @vid: VLAN identifier
+ *
+ * Check if we are a selected candidate for the given IP address key.
+ *
+ * Return: true if we are a selected candidate for the given @ip, false
+ * otherwise.
+ */
+static bool
+batadv_dat_dht_check_self_is_candidate(struct batadv_priv *bat_priv,
+				       __be32 ip, unsigned short vid)
+{
+	struct batadv_dat_candidate *cands;
+	bool self_is_candidate = false;
+
+	cands = batadv_dat_select_candidates(bat_priv, ip, vid,
+					     &self_is_candidate);
+	batadv_dat_candidates_free(cands);
+
+	return self_is_candidate;
+}
+
 /**
  * batadv_dat_forward_dht_put() - send payload via DHT_PUT to DAT candidates
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1142,6 +1187,7 @@ static void batadv_dat_candidates_free(struct batadv_dat_candidate *cands)
  * @ip: the DHT key
  * @hw_addr: the MAC address which the IP resolves to
  * @vid: VLAN identifier
+ * @flags: packet subtype specific flags to set
  *
  * Send the given payload via a DAT DHT_PUT message to the selected
  * candidates.
@@ -1151,7 +1197,8 @@ static void batadv_dat_candidates_free(struct batadv_dat_candidate *cands)
  */
 static bool
 batadv_dat_forward_dht_put(struct batadv_priv *bat_priv, struct sk_buff *skb,
-			   __be32 ip, u8 *hw_addr, unsigned short vid)
+			   __be32 ip, u8 *hw_addr, unsigned short vid,
+			   int flags)
 {
 	struct batadv_dat_candidate *cands;
 	bool self_is_candidate = false;
@@ -1166,12 +1213,56 @@ batadv_dat_forward_dht_put(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		batadv_dat_dht_entry_add(bat_priv, ip, hw_addr, vid);
 
 	ret = batadv_dat_forward_data(bat_priv, cands, skb, ip, vid,
-				      BATADV_P_DAT_DHT_PUT);
+				      BATADV_P_DAT_DHT_PUT, flags);
 
 	batadv_dat_candidates_free(cands);
 	return ret;
 }
 
+/**
+ * batadv_dat_forward_dht_put_src() - send source-specific DHT_PUTs
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @skb: payload to send
+ * @ip_src: the DHT key
+ * @hw_src: the MAC address which the IP resolves to
+ * @vid: VLAN identifier
+ *
+ * Send the given payload via a DAT DHT_PUT message to the selected
+ * candidates, with the PUT_NO_DST flag set.
+ *
+ * Return: true if the packet is sent to at least one candidate, false
+ * otherwise.
+ */
+static bool
+batadv_dat_forward_dht_put_src(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			       __be32 ip_src, u8 *hw_src, unsigned short vid)
+{
+	return batadv_dat_forward_dht_put(bat_priv, skb, ip_src, hw_src, vid,
+					  BATADV_P_DAT_DHT_PUT_NO_DST);
+}
+
+/**
+ * batadv_dat_forward_dht_put_dst() - send destination-specific DHT_PUTs
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @skb: payload to send
+ * @ip_dst: the DHT key
+ * @hw_dst: the MAC address which the IP resolves to
+ * @vid: VLAN identifier
+ *
+ * Send the given payload via a DAT DHT_PUT message to the selected
+ * candidates, with the PUT_NO_SRC flag set.
+ *
+ * Return: true if the packet is sent to at least one candidate, false
+ * otherwise.
+ */
+static bool
+batadv_dat_forward_dht_put_dst(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			       __be32 ip_dst, u8 *hw_dst, unsigned short vid)
+{
+	return batadv_dat_forward_dht_put(bat_priv, skb, ip_dst, hw_dst, vid,
+					  BATADV_P_DAT_DHT_PUT_NO_SRC);
+}
+
 /**
  * batadv_dat_forward_dht_get() - send payload via DHT_GET to DAT candidates
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1211,7 +1302,7 @@ batadv_dat_forward_dht_get(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	}
 
 	ret = batadv_dat_forward_data(bat_priv, cands, skb, ip_dst, vid,
-				      BATADV_P_DAT_DHT_GET);
+				      BATADV_P_DAT_DHT_GET, 0);
 
 skip_remote_forward:
 	batadv_dat_candidates_free(cands);
@@ -1870,8 +1961,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_forward_dht_put(bat_priv, skb, ip_src, hw_src, vid);
-	batadv_dat_forward_dht_put(bat_priv, skb, ip_dst, hw_dst, vid);
+	batadv_dat_forward_dht_put_src(bat_priv, skb, ip_src, hw_src, vid);
+	batadv_dat_forward_dht_put_dst(bat_priv, skb, ip_dst, hw_dst, vid);
 }
 
 /**
@@ -1880,8 +1971,12 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
- * @is_dht_put: ARP reply is part of a unicast 4addr DHT PUT packet and should
- *  not only update our local DAT cache but also our local DAT DHT
+ * @is_dht_put_src: ARP reply is part of a source-specific unicast 4addr DHT PUT
+ *  packet and should not only update our local DAT cache but also our local
+ *  DAT DHT
+ * @is_dht_put_dst: ARP reply is part of a destination-specific unicast 4addr
+ *  DHT PUT packet and should not only update our local DAT cache but also our
+ *  local DAT DHT
  *
  * Warning: This function may reallocate the skb data buffer via
  * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtained
@@ -1893,7 +1988,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size,
-					 bool is_dht_put)
+					 bool is_dht_put_src,
+					 bool is_dht_put_dst)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
 	u8 mac[ETH_ALEN] __aligned(2);
@@ -1926,10 +2022,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	if (is_dht_put) {
+	if (is_dht_put_src)
 		batadv_dat_dht_entry_add(bat_priv, ip_src, hw_src, vid);
+	if (is_dht_put_dst)
 		batadv_dat_dht_entry_add(bat_priv, ip_dst, hw_dst, vid);
-	}
 
 	/* If ip_dst is already in cache and has the right mac address,
 	 * drop this frame if this ARP reply is destined for us because it's
@@ -2212,8 +2308,8 @@ static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
 	batadv_dat_cache_entry_add(bat_priv, yiaddr, chaddr, vid);
 	batadv_dat_cache_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
-	batadv_dat_forward_dht_put(bat_priv, skb, yiaddr, chaddr, vid);
-	batadv_dat_forward_dht_put(bat_priv, skb, ip_dst, hw_dst, vid);
+	batadv_dat_forward_dht_put_src(bat_priv, skb, yiaddr, chaddr, vid);
+	batadv_dat_forward_dht_put_dst(bat_priv, skb, ip_dst, hw_dst, vid);
 
 	consume_skb(skb);
 
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index ad81b7db921e..d955fcb27ae0 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -32,7 +32,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size,
-					 bool is_dht_put);
+					 bool is_dht_put_src,
+					 bool is_dht_put_dst);
 void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
 					__be16 proto,
@@ -81,11 +82,12 @@ int batadv_dat_dht_dump(struct sk_buff *msg, struct netlink_callback *cb);
  * batadv_dat_inc_counter() - increment the correct DAT packet counter
  * @bat_priv: the bat priv with all the mesh interface information
  * @subtype: the 4addr subtype of the packet to be counted
+ * @flags: packet subtype specific flags
  *
  * Updates the ethtool statistics for the received packet if it is a DAT subtype
  */
 static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
-					  u8 subtype)
+					  u8 subtype, u8 flags)
 {
 	switch (subtype) {
 	case BATADV_P_DAT_DHT_GET:
@@ -95,6 +97,13 @@ static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
 	case BATADV_P_DAT_DHT_PUT:
 		batadv_inc_counter(bat_priv,
 				   BATADV_CNT_DAT_PUT_RX);
+		if (!flags)
+			batadv_inc_counter(bat_priv,
+					   BATADV_CNT_DAT_PUT_NOFLAGS_RX);
+		if (!(flags & BATADV_P_DAT_DHT_PUT_NO_SRC))
+			batadv_inc_counter(bat_priv, BATADV_CNT_DAT_PUT_SRC_RX);
+		if (!(flags & BATADV_P_DAT_DHT_PUT_NO_DST))
+			batadv_inc_counter(bat_priv, BATADV_CNT_DAT_PUT_DST_RX);
 		break;
 	}
 }
@@ -129,7 +138,7 @@ batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 static inline bool
 batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int hdr_size,
-				    bool is_dht_put)
+				    bool is_dht_put_src, bool is_dht_put_dst)
 {
 	return false;
 }
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 41d148634034..bdf9c21b0da2 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -1005,7 +1005,11 @@ static const struct {
 	{ "dat_get_rx" },
 	{ "dat_put_tx" },
 	{ "dat_put_rx" },
+	{ "dat_put_src_rx" },
+	{ "dat_put_dst_rx" },
+	{ "dat_put_noflags_rx" },
 	{ "dat_cached_reply_tx" },
+	{ "dat_dht_add_not_candidate" },
 #endif
 };
 
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 5cf26e8b3257..8dd4094d134b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1045,8 +1045,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_orig_node *orig_node_gw = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(*unicast_packet);
+	enum batadv_subtype_flags flags;
 	enum batadv_subtype subtype;
-	bool is_dht_put = false;
+	bool is_dht_put_src = false;
+	bool is_dht_put_dst = false;
 	int ret = NET_RX_DROP;
 	u8 *orig_addr_gw;
 	u8 *orig_addr;
@@ -1094,7 +1096,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			unicast_4addr_packet =
 				(struct batadv_unicast_4addr_packet *)skb->data;
 			subtype = unicast_4addr_packet->subtype;
-			batadv_dat_inc_counter(bat_priv, subtype);
+			flags = unicast_4addr_packet->flags;
+			batadv_dat_inc_counter(bat_priv, subtype, flags);
 
 			/* Only payload data should be considered for speedy
 			 * join. For example, DAT also uses unicast 4addr
@@ -1107,7 +1110,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 				orig_node = batadv_orig_hash_find(bat_priv,
 								  orig_addr);
 			} else if (subtype == BATADV_P_DAT_DHT_PUT) {
-				is_dht_put = true;
+				if (!(flags & BATADV_P_DAT_DHT_PUT_NO_SRC))
+					is_dht_put_src = true;
+				if (!(flags & BATADV_P_DAT_DHT_PUT_NO_DST))
+					is_dht_put_dst = true;
 			}
 		}
 
@@ -1115,7 +1121,9 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size))
 			goto rx_success;
 		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
-							hdr_size, is_dht_put))
+							hdr_size,
+							is_dht_put_src,
+							is_dht_put_dst))
 			goto rx_success;
 
 		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
@@ -1356,7 +1364,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto rx_success;
-	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size, false))
+	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size, false,
+						false))
 		goto rx_success;
 
 	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 929b6dd34c10..e6ebe311f79d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -263,13 +263,15 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
  * @skb: the skb containing the payload to encapsulate
  * @orig: the destination node
  * @packet_subtype: the unicast 4addr packet subtype to use
+ * @flags: packet subtype specific flags to set
  *
  * Return: false if the payload could not be encapsulated or true otherwise.
  */
 bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb,
 					   struct batadv_orig_node *orig,
-					   int packet_subtype)
+					   int packet_subtype,
+					   int flags)
 {
 	struct batadv_unicast_4addr_packet *uc_4addr_packet;
 	struct batadv_hard_iface *primary_if;
@@ -291,7 +293,7 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 	uc_4addr_packet->u.packet_type = BATADV_UNICAST_4ADDR;
 	ether_addr_copy(uc_4addr_packet->src, primary_if->net_dev->dev_addr);
 	uc_4addr_packet->subtype = packet_subtype;
-	uc_4addr_packet->reserved = 0;
+	uc_4addr_packet->flags = flags;
 
 	ret = true;
 out:
@@ -337,7 +339,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	case BATADV_UNICAST_4ADDR:
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, skb,
 							   orig_node,
-							   packet_subtype))
+							   packet_subtype, 0))
 			goto out;
 		break;
 	default:
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 3415afec4a0c..7481c4fa0681 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -53,7 +53,8 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb,
 					   struct batadv_orig_node *orig_node,
-					   int packet_subtype);
+					   int packet_subtype,
+					   int flags);
 int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, int packet_type,
 			    int packet_subtype,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 045727c3adc0..68b753bb32f6 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -975,11 +975,35 @@ enum batadv_counters {
 	/** @BATADV_CNT_DAT_PUT_RX: received dht PUT traffic packet counter */
 	BATADV_CNT_DAT_PUT_RX,
 
+	/**
+	 * @BATADV_CNT_DAT_PUT_SRC_RX: received source-specfic dht PUT traffic
+	 *  packet counter
+	 */
+	BATADV_CNT_DAT_PUT_SRC_RX,
+
+	/**
+	 * @BATADV_CNT_DAT_PUT_DST_RX: received destination-specfic dht PUT
+	 *  traffic packet counter
+	 */
+	BATADV_CNT_DAT_PUT_DST_RX,
+
+	/**
+	 * @BATADV_CNT_DAT_PUT_NOFLAGS_RX: received unspecific/unflagged dht PUT
+	 *  traffic packet counter
+	 */
+	BATADV_CNT_DAT_PUT_NOFLAGS_RX,
+
 	/**
 	 * @BATADV_CNT_DAT_CACHED_REPLY_TX: transmitted dat cache reply traffic
 	 *  packet counter
 	 */
 	BATADV_CNT_DAT_CACHED_REPLY_TX,
+
+	/**
+	 * @BATADV_CNT_DAT_DHT_ADD_NOT_CANDIDATE: counter for local DHT
+	 *  additions without (supposedly) being a selected candidate
+	 */
+	BATADV_CNT_DAT_DHT_ADD_NOT_CANDIDATE,
 #endif
 
 	/** @BATADV_CNT_NUM: number of traffic counters */
-- 
2.55.0

