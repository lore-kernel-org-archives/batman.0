Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11874606A321
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=UxcEiuVS
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ABEF6812B5
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:30:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393045;
 b=3OgeksGCJfalOBV+JIrqN8pDjxDaekkSHq92ufqWkGzj8po5yop/TyGmPTa190Vh1G5gH
 4WVmTYqpq/AwQCC5o1cGfzsHgEn+kwJR9FDdYejcHuJKJy7Ry002rrELLP15QJ1usHpFiav
 2J7IxEdjhwnpe4zkH7r9+Og6isC8DCs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393045; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BTyJPnUX8QJFuWsW+kgtXOP/9FL3BEkt0ixnYdhsKOw=;
 b=SyNEo7VnME3VcFVWKDvl0AnPkcpzJq6e0/GlDAn7qD+5W958k+d+i+VmmEbopfebEyVZB
 zu0E5mZQeTlrFqwqxUyodeyGaHzBindXDgkiTiPTKnuyelXVB0L+TF8ZlBoLjvPVVt6Dg9W
 7Bvku5oLMQG6F0HtzyY6Z9vYIVS/XCw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 35A7180444
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392865;
	b=IxOkZ+/DIE6kvkp1OdhQ1KW3BzDxpDyCQIdK/z7WEDbTxWamLFlRoekV10NCdSpev2GcEF
	GPHZcDHCBKi+wTVPAzy8E5RC/lcCGC+l01ZZv8O4GXDXw0V+9GV8587JSOBZUdCxunl4CR
	hlaULAf1/N77UY85AaqgrnnjXa6h9+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BTyJPnUX8QJFuWsW+kgtXOP/9FL3BEkt0ixnYdhsKOw=;
	b=aixSlv+n5iZCBadxf5RzdA5wgYyCCD84MRIBVtwdDvKu5AUno6KhLiZn/f5C7tv0iJGmQJ
	1r1xL74atPrX1md4hvuKo4Pw2c6J1iOuy0xVyDFPNRf1+etP4y1nCa2zWMIEF3fsleTbU4
	ZCEehMV6q0XMhbs8MBbwsJe/I4Ee00w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=UxcEiuVS;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740DED843bE7e4a980e9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id EFB85FA2F0;
	Wed, 11 Nov 2026 11:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTyJPnUX8QJFuWsW+kgtXOP/9FL3BEkt0ixnYdhsKOw=;
	b=UxcEiuVSzS3cy0zsa4ElGM2sad95s54XTiRy7zJ2YZxwRx9HKw7oyfk5xpCqOvRaatvfrM
	hmd6LCbXCnExwtLVdk4fCRIBpsZUHotU7IdWL8f0fsbJ0LlpoRHpdF8/UnwT59HnqLH0f1
	D7KBWQkmiUOlpp1JTAu4YRvD2xZGd36ezp9rO8VCqKYhAvbAxagYhMEDILCyJ+KMhCAofB
	qRoNHvCWSOm13hrBJSSERPf8yWzlxrCd+oe6tj/fJ6QWcIyz1EJMNTEwixFqQ0qobEBGdb
	4qZtzqqw+HuCxS4UUGP4678eQbrcFPdhjsGPIeZCJAKmGkCLPrUNkr6tJfIGbw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: mark read-only MAC address
 parameters as const
Date: Wed, 11 Nov 2026 11:27:27 +0100
Message-ID: <20261111102729.2096241-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SJQV4ZC3LSWK236SY4SN7NKMKG2WDTHC
X-Message-ID-Hash: SJQV4ZC3LSWK236SY4SN7NKMKG2WDTHC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SJQV4ZC3LSWK236SY4SN7NKMKG2WDTHC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

Many functions take a pointer to a MAC address that they only read
(lookups, comparisons, or copying it into another buffer), but the
parameter was not const. So the prototype does not tell whether the
callee might modify the caller's buffer, and callers holding a const
pointer (e.g. into a const packet header) cannot pass it on without a
cast.

Mark these parameters const.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            |  8 ++++----
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bridge_loop_avoidance.c | 17 +++++++++--------
 net/batman-adv/bridge_loop_avoidance.h | 11 ++++++-----
 net/batman-adv/distributed-arp-table.c |  8 ++++----
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        |  2 +-
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/originator.c            |  2 +-
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               |  2 +-
 net/batman-adv/translation-table.c     | 25 +++++++++++++------------
 net/batman-adv/translation-table.h     |  8 ++++----
 13 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4e15af1e245a5..9e529215a7908 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -712,7 +712,7 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
  * Return: whether forward packet was scheduled
  */
 static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
-				    unsigned char *packet_buff,
+				    const unsigned char *packet_buff,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
 				    struct batadv_hard_iface *if_outgoing,
@@ -723,12 +723,12 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	 */
 	struct batadv_forw_packet *forw_packet_aggr = NULL;
 	struct batadv_forw_packet *forw_packet_pos = NULL;
-	struct batadv_ogm_packet *batadv_ogm_packet;
+	const struct batadv_ogm_packet *batadv_ogm_packet;
 	unsigned long max_aggregation_jiffies;
 	bool aggregated_ogms;
 	bool direct_link;
 
-	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
+	batadv_ogm_packet = (const struct batadv_ogm_packet *)packet_buff;
 	direct_link = !!(batadv_ogm_packet->flags & BATADV_DIRECTLINK);
 	max_aggregation_jiffies = msecs_to_jiffies(BATADV_MAX_AGGREGATION_MS);
 
@@ -1487,7 +1487,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
  * address. Bonding candidates are ignored.
  */
 static struct batadv_neigh_node *
-batadv_orig_to_direct_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+batadv_orig_to_direct_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
 			     struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *neigh_node;
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 144bb30d608a8..0eb07b789cffc 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -498,7 +498,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
  * ELP packet.
  */
 static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
-				      u8 *neigh_addr,
+				      const u8 *neigh_addr,
 				      struct batadv_hard_iface *if_incoming,
 				      struct batadv_elp_packet *elp_packet)
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 0833f9f99e2a9..fc8336aa09a0c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -850,8 +850,9 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
  *
  * Return: true if handled
  */
-static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
-				   u8 *backbone_addr, unsigned short vid)
+static bool batadv_handle_announce(struct batadv_priv *bat_priv,
+				   const u8 *an_addr, const u8 *backbone_addr,
+				   unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	u16 backbone_crc;
@@ -868,7 +869,7 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 	/* handle as ANNOUNCE frame */
 	WRITE_ONCE(backbone_gw->lasttime, jiffies);
-	crc = ntohs(*((__force __be16 *)(&an_addr[4])));
+	crc = ntohs(*((__force const __be16 *)(&an_addr[4])));
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "%s(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
@@ -914,8 +915,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
  */
 static bool batadv_handle_request(struct batadv_priv *bat_priv,
 				  struct batadv_hard_iface *primary_if,
-				  u8 *backbone_addr, struct ethhdr *ethhdr,
-				  unsigned short vid)
+				  const u8 *backbone_addr,
+				  struct ethhdr *ethhdr, unsigned short vid)
 {
 	/* check for REQUEST frame */
 	if (!batadv_compare_eth(backbone_addr, ethhdr->h_dest))
@@ -1788,8 +1789,8 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
  *
  * Return: true if orig is a backbone for this vid, false otherwise.
  */
-bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
-				    unsigned short vid)
+bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
+				    const u8 *orig, unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
 	struct batadv_bla_backbone_gw *backbone_gw;
@@ -2522,7 +2523,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * false if the device addr is already claimed by another gateway
  */
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
-			    u8 *addr, unsigned short vid)
+			    const u8 *addr, unsigned short vid)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bla_backbone_gw *backbone_gw;
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 06c7dfb8c677f..1ef7f96a08507 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -42,8 +42,8 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 			       int hdr_size);
 int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb);
-bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
-				    unsigned short vid);
+bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
+				    const u8 *orig, unsigned short vid);
 bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb);
 void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
@@ -53,7 +53,7 @@ void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
 #ifdef CONFIG_BATMAN_ADV_DAT
-bool batadv_bla_check_claim(struct batadv_priv *bat_priv, u8 *addr,
+bool batadv_bla_check_claim(struct batadv_priv *bat_priv, const u8 *addr,
 			    unsigned short vid);
 #endif
 #define BATADV_BLA_CRC_INIT	0
@@ -80,7 +80,8 @@ static inline bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 }
 
 static inline bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
-						  u8 *orig, unsigned short vid)
+						  const u8 *orig,
+						  unsigned short vid)
 {
 	return false;
 }
@@ -121,7 +122,7 @@ static inline int batadv_bla_backbone_dump(struct sk_buff *msg,
 }
 
 static inline
-bool batadv_bla_check_claim(struct batadv_priv *bat_priv, u8 *addr,
+bool batadv_bla_check_claim(struct batadv_priv *bat_priv, const u8 *addr,
 			    unsigned short vid)
 {
 	return true;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 7e82c154c13f8..862a3a5eab566 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -443,7 +443,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
  * @vid: VLAN identifier
  */
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 u8 *mac_addr, unsigned short vid)
+				 const u8 *mac_addr, unsigned short vid)
 {
 	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
@@ -1199,7 +1199,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
  */
 static struct sk_buff *
 batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
-			    __be32 ip_dst, u8 *hw_src, u8 *hw_dst,
+			    __be32 ip_dst, const u8 *hw_src, const u8 *hw_dst,
 			    unsigned short vid)
 {
 	struct sk_buff *skb;
@@ -1771,8 +1771,8 @@ static bool batadv_dat_get_dhcp_chaddr(struct sk_buff *skb, u8 *buf)
  * For the DHT propagation, client MAC + IP will appear as the ARP Reply
  * transmitter (and hw_dst/ip_dst as the target).
  */
-static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
-				__be32 yiaddr, u8 *hw_dst, __be32 ip_dst,
+static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, const u8 *chaddr,
+				__be32 yiaddr, const u8 *hw_dst, __be32 ip_dst,
 				unsigned short vid)
 {
 	struct sk_buff *skb;
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index e7ad295504e4f..bf36879caab1b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -442,7 +442,7 @@ bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface)
  *	BATADV_HARDIF_BCAST_OK: Several neighbors, must broadcast
  */
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
-			       u8 *orig_addr, u8 *orig_neigh)
+			       const u8 *orig_addr, const u8 *orig_neigh)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	int ret = BATADV_HARDIF_BCAST_OK;
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 935f47ca9a48f..1aec7ce892445 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -76,7 +76,7 @@ int batadv_hardif_min_mtu(struct net_device *mesh_iface);
 void batadv_update_min_mtu(struct net_device *mesh_iface);
 void batadv_hardif_release(struct kref *ref);
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
-			       u8 *orig_addr, u8 *orig_neigh);
+			       const u8 *orig_addr, const u8 *orig_neigh);
 int __init batadv_wifi_net_devices_init(void);
 void batadv_wifi_net_devices_deinit(void);
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 22dd28d5e1abc..0446324c64e85 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -337,7 +337,7 @@ batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
  * Return: true if the given address is already in the given list.
  * Otherwise returns false.
  */
-static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
+static bool batadv_mcast_mla_is_duplicate(const u8 *mcast_addr,
 					  struct hlist_head *mcast_list)
 {
 	struct batadv_hw_addr *mcast_entry;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0f47ac3ecc967..1ac3e0ad66c79 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -346,7 +346,7 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
  * address.
  */
 struct batadv_neigh_node *
-batadv_orig_to_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+batadv_orig_to_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
 		      struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *neigh_node;
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index db0c55128170c..fabfc3e67c6eb 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -37,7 +37,7 @@ struct batadv_neigh_node *
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
 		       const struct batadv_hard_iface *if_outgoing);
 struct batadv_neigh_node *
-batadv_orig_to_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+batadv_orig_to_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
 		      struct batadv_hard_iface *if_outgoing);
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6442f5d0cc937..79fad88cd039c 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -828,7 +828,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 static bool
 batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			      struct batadv_unicast_packet *unicast_packet,
-			      u8 *dst_addr, unsigned short vid)
+			      const u8 *dst_addr, unsigned short vid)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 76635ae82c84b..50f24a3ad0ea0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -68,7 +68,7 @@ static struct kmem_cache *batadv_tt_roam_cache __read_mostly;
 static struct lock_class_key batadv_tt_local_hash_lock_class_key;
 static struct lock_class_key batadv_tt_global_hash_lock_class_key;
 
-static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv, const u8 *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node);
 static void batadv_tt_purge(struct work_struct *work);
@@ -3705,7 +3705,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
  */
 static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 					  struct batadv_tvlv_tt_data *tt_data,
-					  u8 *req_src, u8 *req_dst)
+					  const u8 *req_src, const u8 *req_dst)
 {
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
@@ -3836,7 +3836,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
  */
 static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 				       struct batadv_tvlv_tt_data *tt_data,
-				       u8 *req_src)
+				       const u8 *req_src)
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -3955,7 +3955,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
  */
 static bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_tt_data *tt_data,
-				    u8 *req_src, u8 *req_dst)
+				    const u8 *req_src, const u8 *req_dst)
 {
 	if (batadv_is_my_mac(bat_priv, req_dst))
 		return batadv_send_my_tt_response(bat_priv, tt_data, req_src);
@@ -4031,7 +4031,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
-				  u8 ttvn, u8 *resp_src,
+				  u8 ttvn, const u8 *resp_src,
 				  u16 num_entries)
 {
 	struct batadv_orig_node *orig_node;
@@ -4121,7 +4121,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
  */
 static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 				      struct batadv_tvlv_tt_data *tt_data,
-				      u8 *resp_src, u16 num_entries)
+				      const u8 *resp_src, u16 num_entries)
 {
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
@@ -4222,7 +4222,8 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  *
  * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client, u16 vid)
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv,
+				       const u8 *client, u16 vid)
 {
 	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
@@ -4282,7 +4283,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client,
  * for this particular roamed client has to be forwarded to the sender of the
  * roaming message.
  */
-static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv, const u8 *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node)
 {
@@ -4539,8 +4540,8 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
  *
  * Return: true when src+dst(+vid) pair should be isolated, false otherwise
  */
-bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
-			   unsigned short vid)
+bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, const u8 *src,
+			   const u8 *dst, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
@@ -4669,7 +4670,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
  * deleted later by a DEL or because of timeout
  */
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
-					u8 *addr, unsigned short vid)
+					const u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	bool ret;
@@ -4696,7 +4697,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
  * to keep the latter consistent with the node TTVN
  */
 bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
-				       u8 *addr, unsigned short vid)
+				       const u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret;
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index ca01d20ee2d7f..41b7c40790419 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -41,13 +41,13 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 void batadv_tt_free(struct batadv_priv *bat_priv);
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid);
-bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
-			   unsigned short vid);
+bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, const u8 *src,
+			   const u8 *dst, unsigned short vid);
 void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv);
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
-					u8 *addr, unsigned short vid);
+					const u8 *addr, unsigned short vid);
 bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
-				       u8 *addr, unsigned short vid);
+				       const u8 *addr, unsigned short vid);
 void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface);
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
-- 
2.47.3

