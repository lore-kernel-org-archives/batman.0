Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F23C5DF97
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:15:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7970D82DF9
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 15:15:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787404510;
 b=fU6TqcO9XuqbxXo4xmO/O2UP/EO29OLccp0ebY79IESFWPloHOqFmV63RAYUMmXPgguGh
 HngURri06I5VvBn8ioXUIyrlPTIkvXRowPtXOa0ZqpU1uNVLY5Mp/A8wYgYx1AOpmw0UZpj
 OabRiCdWGFiOB1NbK//y3zmDU1aU6vI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787404510; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yRKNr+pB+skjYPULJhrxtYDAAsU5ReorIfbSQelzRak=;
 b=HukERl0FV4Gro0AnmWwXttW/Q9ko5YDiotsF6tMZ2mkphPeXbpkWSxsAlo29Ld6k8eXW+
 uCx5KxMySEv5a9sT5bkQe9DyfL8/V6Hx82YneKBWVWo+f0/Pw+az2w/+EnWgekkvmP+1EYT
 rXB1cY7unHxWQDOx15aeWvD+yZs5R44=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A4A0D8067F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 15:14:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787404474;
	b=Hsi3ZlUpeq1we5fzu1V8N3ZUOnmeHVbNV8TEPR9vQvgFeNw55QyI5qZY/pimPmhtE+UWG/
	SJnzXlLIVmzz5mkTHLAsuTTPw1WjpH0NOsvWuoQCF+6EtyXoKp2LU6lFTrD1PEq+HZ7ca4
	qOPXF+06AEClRvmTDOyPHRMJlOZag/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787404474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yRKNr+pB+skjYPULJhrxtYDAAsU5ReorIfbSQelzRak=;
	b=GTkrdxODWe/F1odtCMzo3kJpuPy0cppSw6z3OwxPmRiaOQgETo4TIYkIsEVUINKwX0l39y
	GRahE1yofn5cWVxWzigUAjcg6sD8hqCAKbuiGvu8TJdV/u9u907n3fnASTIpL2lFTyk0KN
	aGrJOrRKMAo92f+YDYNTntqqDHFGgjg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=gUF3v7mw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4789B20802;
	Sat, 22 Aug 2026 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787404470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRKNr+pB+skjYPULJhrxtYDAAsU5ReorIfbSQelzRak=;
	b=gUF3v7mw5uIQ3UrYGvNYc53riTui0lKFmwOX/n79WADmZKVXEeiT+xKTALaC+rd8g9xpr3
	2iTRCr9TMwtx7I59oMGQuBvN351ao0ihxglzVH/L/4XiKzLqiYfIRZzqxtJGCKUmz+2X+3
	MPr/wiVBJ50Kxqucvjxh6T2atQmWMKo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 22 Aug 2026 15:14:04 +0200
Subject: [PATCH batadv 2/2] batman-adv: ensure u16 aligned mac address in
 structs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-mac-u16-alignment-v1-2-bafa0040ada7@narfation.org>
References: <20260822-mac-u16-alignment-v1-0-bafa0040ada7@narfation.org>
In-Reply-To: <20260822-mac-u16-alignment-v1-0-bafa0040ada7@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4346; i=sven@narfation.org;
 h=from:subject:message-id; bh=wR8/SKFivBl9kHVcBGjX53ZDhaez99loorbsirhduAk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmdC+bWLX6rekBOK0Vo5/VWzSj77J/vd/x7u7TgVHnPt
 zfifFd2d5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8piP4Q/nj6Tt0uslbs7Z
 N+39e43TqcqyUnJ3zIwlPn1jNjD7n2EGVOE+4THfuZnH676prbQ3Y/28dKX/n+n1q8Wy05Z/WVT
 8jgkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FDTT6QCMFOKOMNYAX4ZGX2RV6CLILV2Y
X-Message-ID-Hash: FDTT6QCMFOKOMNYAX4ZGX2RV6CLILV2Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FDTT6QCMFOKOMNYAX4ZGX2RV6CLILV2Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

An u8 array in structures have a natural alignment of only 1 byte. An
u8[ETH_ALEN] array must therefore be assumed to only be 1 byte aligned. But
many etherdevices.h functions are requiring a 2 byte (u16) alignment.

All these addresses were either on the start of a struct or after a struct
member which required at least an alignment of 2 byte. Still, annote all
u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure that this
assumption isn't broken by other modifications inside the structs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e..c4bfd4cd 100644
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

