Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A84C624C6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:59:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C54E854B7
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:59:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184754;
 b=U0E3YPfX2CZbXGFBXXM0PsjnGhWJGF2iku3uj1A9JodmI6X61Zon6yXU0/KNo0utzVTML
 eb5BzZK7cvpV43E3YKPKJ0ETUrg2yo3e9fUm9MlZ08J46gUoSJb/sN7rNaDOxzpRju673DE
 iDeAh5ByIGhAtnQP/v0AvevK6kCpqLA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184754; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UtQOkpiHnes8mpnleD54qSgD8djfVr3QVhGA6hv1Jvs=;
 b=Dn5sMZf5ZHY5E8tSBpI6dQh0Tu3YLVzJ6yOkBZ3xqS8qCifL0XxMcxxUQCSekUsijePtY
 R2n6yFBJQbYMp+wj6gTqabyRGPtp8+LoZ7sttKSGL/uzH5FrEVGMhYQmLD0fjB2abJD2NCN
 O6MROCQULYrVNcEbaB5jCOOB82NLxmc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 70440819D0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184305;
	b=AB9LcUuMx0I7rTUqeUtER/nIGJLmmPPn4Ok+hEY0SldOqovgF/yslc9qZs/Ogbo79cXJsp
	BzKSN49tT2QsEJJs6g+KMMSgdsBZdalR5PPndNUq1zcLCZYf3Qj/Dx9APh2XEtnUQ8ywkG
	2wbif9Mu4+48SXfrNzd1wnFjTs++UdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UtQOkpiHnes8mpnleD54qSgD8djfVr3QVhGA6hv1Jvs=;
	b=ZnUYM3SA10y4Zyl0QeH8j9HA02Ty0H1pDCVjIH77SjDhuzeSOXrqrOBuQjs/H2avhhMzPY
	h5BGWSp6sF4ARSHYQIbSkkva0i1hJOgKTlN9lfC3A3iZVx0D5toBcnpHLKxwlaU4ANYJaq
	464B5C+TYgTje2tADaNRLtLoHlExTOU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=tF1DaBtX;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id DFF49FA1CC;
	Mon, 31 Aug 2026 15:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtQOkpiHnes8mpnleD54qSgD8djfVr3QVhGA6hv1Jvs=;
	b=tF1DaBtXZTo9EJVkObiOXPft0/xAOzCCknrxsZu6gyD6Ns4OYxMO7isqy1WASdvTTp0Pxi
	bvpHF97HminDoV2ImJr8z9AwESY5UygLtvuZzHY3xWk6fgsCudZnMYSgINRvMoz/yq76He
	3ayNDwTaK85+1OYUEETt3Hhol44re9dx0UaYb4Ek7NzjQoEtwVhFdXgql/WgGeyEKnQF/9
	4B30yzTNsDl/mGPaconH2jhxU3yLS1EygWG/mv/0worFLApnz0qjuhthoE0Qwr0Y7cKZ31
	ub09DmMAh9Np7nHxSp+EK28bG30GOaOznMInQ7eA9k1kuQ23MEf/i9sfPhHXgQ==
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
Subject: [PATCH net-next 07/15] batman-adv: ensure u16 aligned mac address in
 structs
Date: Mon, 31 Aug 2026 15:51:09 +0200
Message-ID: <20260831135117.574836-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LIW3ZVZKHO7CENMD7H5YLGOPKMNCS5TQ
X-Message-ID-Hash: LIW3ZVZKHO7CENMD7H5YLGOPKMNCS5TQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LIW3ZVZKHO7CENMD7H5YLGOPKMNCS5TQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

An u8 array in structures have a natural alignment of only 1 byte. An
u8[ETH_ALEN] array must therefore be assumed to only be 1 byte aligned. But
many etherdevices.h functions are requiring a 2 byte (u16) alignment.

All these addresses were either on the start of a struct or after a struct
member which required at least an alignment of 2 byte. Still, annote all
u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure that this
assumption isn't broken by other modifications inside the structs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 99667f632d4d9..c42a4aa8f41a3 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -410,7 +410,7 @@ struct batadv_orig_bat_iv {
  */
 struct batadv_orig_node {
 	/** @orig: originator ethernet address */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @ifinfo_list: list for routers per outgoing interface */
 	struct hlist_head ifinfo_list;
@@ -634,12 +634,12 @@ struct batadv_hardif_neigh_node {
 	struct hlist_node list;
 
 	/** @addr: the MAC address of the neighboring interface */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/**
 	 * @orig: the address of the originator this neighbor node belongs to
 	 */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @if_incoming: pointer to incoming hard-interface */
 	struct batadv_hard_iface *if_incoming;
@@ -677,7 +677,7 @@ struct batadv_neigh_node {
 #endif
 
 	/** @addr: the MAC address of the neighboring interface */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @ifinfo_list: list for routing metrics per outgoing interface */
 	struct hlist_head ifinfo_list;
@@ -777,7 +777,7 @@ struct batadv_neigh_ifinfo {
  */
 struct batadv_bcast_duplist_entry {
 	/** @orig: mac address of orig node originating the broadcast */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @crc: crc32 checksum of broadcast payload */
 	u32 crc;
@@ -1085,7 +1085,7 @@ struct batadv_priv_bla {
 	struct batadv_hashtable *backbone_hash;
 
 	/** @loopdetect_addr: MAC address used for own loopdetection frames */
-	u8 loopdetect_addr[ETH_ALEN];
+	u8 loopdetect_addr[ETH_ALEN] __aligned(2);
 
 	/**
 	 * @loopdetect_lasttime: time when the loopdetection frames were sent
@@ -1352,7 +1352,7 @@ struct batadv_tp_vars_common {
 	struct batadv_priv *bat_priv;
 
 	/** @other_end: mac address of remote */
-	u8 other_end[ETH_ALEN];
+	u8 other_end[ETH_ALEN] __aligned(2);
 
 	/** @session: TP session identifier */
 	u8 session[2];
@@ -1765,7 +1765,7 @@ struct batadv_bla_backbone_gw {
 	 * @orig: originator address of backbone node (mac address of primary
 	 *  iface)
 	 */
-	u8 orig[ETH_ALEN];
+	u8 orig[ETH_ALEN] __aligned(2);
 
 	/** @vid: vlan id this gateway was detected on */
 	unsigned short vid;
@@ -1810,7 +1810,7 @@ struct batadv_bla_backbone_gw {
  */
 struct batadv_bla_claim {
 	/** @addr: mac address of claimed non-mesh client */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: vlan id this client was detected on */
 	unsigned short vid;
@@ -1840,7 +1840,7 @@ struct batadv_bla_claim {
  */
 struct batadv_tt_common_entry {
 	/** @addr: mac address of non-mesh client */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: VLAN identifier */
 	unsigned short vid;
@@ -1942,7 +1942,7 @@ struct batadv_tt_req_node {
 	/**
 	 * @addr: mac address of the originator this request was sent to
 	 */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @issued_at: timestamp used for purging stale tt requests */
 	unsigned long issued_at;
@@ -1959,7 +1959,7 @@ struct batadv_tt_req_node {
  */
 struct batadv_tt_roam_node {
 	/** @addr: mac address of the client in the roaming phase */
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 
 	/** @vid: VLAN identifier */
 	u16 vid;
@@ -2204,7 +2204,7 @@ struct batadv_hw_addr {
 	struct hlist_node list;
 
 	/** @addr: the MAC address of this list entry */
-	unsigned char addr[ETH_ALEN];
+	unsigned char addr[ETH_ALEN] __aligned(2);
 };
 
 /**
-- 
2.47.3

