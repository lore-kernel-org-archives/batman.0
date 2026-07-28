Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6D1C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:47:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2F74B847A8
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:47:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246432;
 b=saw7H7Bu7OOK+xyLiaQ/nJO9DnPSUP0bJGIVti1+F5o2ciWKhuIjuk/IdfWqQvlzBN55E
 gbIBfMZR/LdFFvLW8aT7pDqKrXpzAB+JgcOocyzBHD7guNpdgrvV421LbXV9mYXO4D+EEh5
 GVFc/THXcfSFDkySpF2MQu6608TiD/M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246432; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7mVER+EO0Pv/Hgxr4Rmu78cpub2jN3J8Axcr5+kRgpc=;
 b=c4nYdYnxEshfRPrzrdyDMX7W2y7FLzlU0Ls4RDHpMoGU1/EwogSOKS7KGMknwXBHqiqXs
 fIfeTK/dZHzXuY4MZ0+cRiHsfOm+p4txI/9AgyIWQi90UitJX1stnCLS36pQjHhaaPiWBZg
 pOvUqwjTgS21O7F4cmXL5MTWR1+nseA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4E644843CA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245967;
	b=RLwLL+7xq45jIMM76EyHGTEp8Trw6nLBNKwwKi8QPNcodXi5w6Lt9Ts1246PvHnA3qgVA+
	1H4Pqa5TM8pUqb/XHm2dNb7CCJ9c/VWrf8BCW6QxQxC6ps+v5qmHGBhm5Vj/HdYHNoc5H4
	ipqML9fcDU9IiQDR30f8JNFfJa6rRdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7mVER+EO0Pv/Hgxr4Rmu78cpub2jN3J8Axcr5+kRgpc=;
	b=GvTVwhuKE56g8Zt7wrAH5/+tpJd5b/wpjYLhAdm/STQoCuzb+34P3V/qYFEee+nhADDCHD
	Jn1Z+N5O57k5g/qUlIzS/gA26zIUPwpnC35z+KQix0uSO2Ex/I3EHnzG2iWwLO/3RsYDaC
	VBZNlrXMPB9JKlJG0Pj2YPCmqFM3eKM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=ganPSHqB;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717ead808f168C97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E1968FA13B;
	Tue, 28 Jul 2026 15:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mVER+EO0Pv/Hgxr4Rmu78cpub2jN3J8Axcr5+kRgpc=;
	b=ganPSHqBM1PtfG62hhaNtmAVNPaZULdb2FINKpnaeMEsyEPWayBblOEO6opIVV3kK3NKNo
	qCXyOqpIUKO1v7hWpyjCBdygntv0JXKeLhHM447Doo/7Kt+BoJDW7WraVMgIlN5Lnom34o
	ou36n/61cfso4KkjMUHPiBj/d/N1YH/RrRRVRu0ZYonklbX2gzQ1wxM1+WuEOKm3T7tgbP
	BrMhJgR2Ew6zcQHw2k0NzlQz5PDtg/tPsAxMBJtDP4oo97clzMs8YZfu8+R3P2XuKU6qVF
	6MH/ptZpzpsD/wYs+alJQwD/qGEIakwG1ryqtvUT4EQZlJAWO1/EEXRCYKSKog==
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
Subject: [PATCH net-next 10/15] batman-adv: fix kernel-doc for functions
 holding skb ownership
Date: Tue, 28 Jul 2026 15:39:13 +0200
Message-ID: <20260728133918.643267-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7UT22C76RB7CJT5NXVSN7FTHZOZVQUW5
X-Message-ID-Hash: 7UT22C76RB7CJT5NXVSN7FTHZOZVQUW5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7UT22C76RB7CJT5NXVSN7FTHZOZVQUW5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Most functions in batman-adv will take the ownership of an skb when they
receive it as argument.  Their NET_RX_DROP return value is only indicating
whether there was direct visible problem while processing it. The caller
must not try to also free the skb when such a negative return code was
received.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b0b6c5ca210a2..c1114ee575478 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -263,8 +263,7 @@ static bool batadv_skb_decrement_ttl(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: icmp packet to process
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb)
@@ -986,8 +985,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 					 struct batadv_hard_iface *recv_if)
@@ -1120,8 +1118,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
@@ -1177,7 +1174,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
  * the assembled packet will exceed our MTU; 2) Buffer fragment, if we still
  * lack further fragments; 3) Merge fragments, if we have all needed parts.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
@@ -1365,7 +1362,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
  * contents of its TVLV forwards it and/or decapsulates it to hand it to the
  * mesh interface.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_mcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
-- 
2.47.3

