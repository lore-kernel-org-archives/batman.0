Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE4CC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:09:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5CF6C844DA
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:09:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791914955;
 b=ywYf4lGklj6C4Dj8wHZ0BvekekWFHM4x5ODk4f7BLpBT/sG/XCBgFHYMqmWbcN8UQdPXL
 QdNIE8s2RS/EcRKo2aWcGiC4RnIEoQCQiVM+uixLcob5NJyms/xmdoduEvCCEXJ/WRuxrVY
 6GTxy5VRi3EDsqBnwDsaX+sfG8aP9VU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791914955; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2qO9dFmPsCafLSq9y4qeQMrflF4XPRdPG1xjVl0wRL8=;
 b=wV+Q5OXxB7ZpwnQYXK8OULJ56B6XRxWava4cm4sCSq/JGIyUZo2xrdfMrCKsAcBxxcW4l
 VeIRpxjAakE2cNcQ7zGKB2soBzYi3IgVOQfPmK/3beDW/9/dFPtKzj8z0juQhxJ/0nwIXKN
 r019tCHn1nOBGB/3P4bRogmT/01NntI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A9B8182079
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:07:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791914884;
	b=v0mxMTFzi5Xai6EOaasC6Z+EKhZ8fAVJ/V2ZxHeZjvp+vAcB7HE4uPRK9fyIfOOP+l0Jsb
	bzNRknkffGALQnLN+dKxzYr0OVOlNtPxSyOraNn2zjIaZWbB0ZEctGbJi2L918L0p40K8x
	XA0U6v1ZeLkS2YxPrUJ0nT/I2gjSDH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791914884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2qO9dFmPsCafLSq9y4qeQMrflF4XPRdPG1xjVl0wRL8=;
	b=mRv0998VGEx6flR/OQWT1nlmdj0OfdmPg8u+oee0RO+UjM36kxXe1td0xZwMd9NYQt1noi
	mu9Fq2NrleqTq6+tRbQ6acypd6mga0V2Omj+PsJMgFd+mLUtv+Dm8+2RdgHJGlUDK3huyn
	0nXmUVlj2OTWWmIZTXzI3C5+VYEFQBg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ievLFWcZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 53CF220E43;
	Tue, 13 Oct 2026 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791914874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qO9dFmPsCafLSq9y4qeQMrflF4XPRdPG1xjVl0wRL8=;
	b=ievLFWcZkREiSmgQwCrFYrixVmWAJ9AqBv8GjJ/MRo5E44CF0/JRUfRwmMXBYQni1qvkSc
	1Js0VHcHMEEzkCaQoVwx1wFkChuU0Tz9uaeEU6SuJK0BsJXelopUw2CK5pX1TGeyIn0MnP
	t8SBToQl3/MIA9EXlcz4oWq/AQXQkS0=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:07:48 +0200
Subject: [PATCH batadv 2/4] batman-adv: mark read-only MAC address
 parameters as const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-simple-type-cleanup-v1-2-8a31d7e82eb4@narfation.org>
References: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
In-Reply-To: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17923; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZWjFmkL+Cgx/4/iRLfZkRMzaaQLzduJL/xnhdY4JeXw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnniot1df8kRu2ef+Eoh5CGkdnPOzELz61x7fn9aHZbw
 81FXjYiHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJKB9mZNh38fC7zkbFD4Yq
 xkFSE7c8nm6UEWjCF8nL3lpelidv94WRoZczq+f20iP9kvPCecWr2L9nWR4IUMmfc8Bz77SuP9M
 TeQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: J7OO7DFWEI3YJJ4YDSB4CD76OVQLTKDP
X-Message-ID-Hash: J7OO7DFWEI3YJJ4YDSB4CD76OVQLTKDP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J7OO7DFWEI3YJJ4YDSB4CD76OVQLTKDP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Many functions take a pointer to a MAC address that they only read
(lookups, comparisons, or copying it into another buffer), but the
parameter was not const. So the prototype does not tell whether the
callee might modify the caller's buffer, and callers holding a const
pointer (e.g. into a const packet header) cannot pass it on without a
cast.

Mark these parameters const.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            |  4 ++--
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bridge_loop_avoidance.c | 15 ++++++++-------
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
 13 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 85e99506..fea10d57 100644
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
index 6ad6042a..4cffa796 100644
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
index a96f269d..da166fac 100644
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
@@ -2520,7 +2521,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * false if the device addr is already claimed by another gateway
  */
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
-			    u8 *addr, unsigned short vid)
+			    const u8 *addr, unsigned short vid)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bla_backbone_gw *backbone_gw;
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 06c7dfb8..1ef7f96a 100644
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
index 74050bff..02dd5ca7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -442,7 +442,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
  * @vid: VLAN identifier
  */
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 u8 *mac_addr, unsigned short vid)
+				 const u8 *mac_addr, unsigned short vid)
 {
 	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
@@ -1195,7 +1195,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
  */
 static struct sk_buff *
 batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
-			    __be32 ip_dst, u8 *hw_src, u8 *hw_dst,
+			    __be32 ip_dst, const u8 *hw_src, const u8 *hw_dst,
 			    unsigned short vid)
 {
 	struct sk_buff *skb;
@@ -1767,8 +1767,8 @@ static bool batadv_dat_get_dhcp_chaddr(struct sk_buff *skb, u8 *buf)
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
index c5bc60d1..07552d24 100644
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
index 935f47ca..1aec7ce8 100644
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
index 22dd28d5..0446324c 100644
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
index f06583ef..dac35c23 100644
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
index db0c5512..fabfc3e6 100644
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
index 6442f5d0..79fad88c 100644
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
index e46040fd..bf5d452e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -66,7 +66,7 @@ static struct kmem_cache *batadv_tt_roam_cache __read_mostly;
 static struct lock_class_key batadv_tt_local_hash_lock_class_key;
 static struct lock_class_key batadv_tt_global_hash_lock_class_key;
 
-static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv, const u8 *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node);
 static void batadv_tt_purge(struct work_struct *work);
@@ -3699,7 +3699,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
  */
 static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 					  struct batadv_tvlv_tt_data *tt_data,
-					  u8 *req_src, u8 *req_dst)
+					  const u8 *req_src, const u8 *req_dst)
 {
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
@@ -3830,7 +3830,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
  */
 static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 				       struct batadv_tvlv_tt_data *tt_data,
-				       u8 *req_src)
+				       const u8 *req_src)
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -3949,7 +3949,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
  */
 static bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_tt_data *tt_data,
-				    u8 *req_src, u8 *req_dst)
+				    const u8 *req_src, const u8 *req_dst)
 {
 	if (batadv_is_my_mac(bat_priv, req_dst))
 		return batadv_send_my_tt_response(bat_priv, tt_data, req_src);
@@ -4016,7 +4016,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
  */
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
-				  u8 ttvn, u8 *resp_src,
+				  u8 ttvn, const u8 *resp_src,
 				  u16 num_entries)
 {
 	struct batadv_orig_node *orig_node;
@@ -4106,7 +4106,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
  */
 static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 				      struct batadv_tvlv_tt_data *tt_data,
-				      u8 *resp_src, u16 num_entries)
+				      const u8 *resp_src, u16 num_entries)
 {
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
@@ -4207,7 +4207,8 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  *
  * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client, u16 vid)
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv,
+				       const u8 *client, u16 vid)
 {
 	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
@@ -4267,7 +4268,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client,
  * for this particular roamed client has to be forwarded to the sender of the
  * roaming message.
  */
-static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv, const u8 *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node)
 {
@@ -4510,8 +4511,8 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
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
@@ -4640,7 +4641,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
  * deleted later by a DEL or because of timeout
  */
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
-					u8 *addr, unsigned short vid)
+					const u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	bool ret;
@@ -4667,7 +4668,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
  * to keep the latter consistent with the node TTVN
  */
 bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
-				       u8 *addr, unsigned short vid)
+				       const u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret;
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index ca01d20e..41b7c407 100644
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

