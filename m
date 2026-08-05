Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0B3C55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 14:33:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 968FD84255
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 16:32:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785940378;
 b=dFLOrfTroeSIEg8JuKvFuOQRheqPgN8Hm4z1EhP4rlBK9iOMsUJLGSvULDOou5o3YU38l
 9ylXJp41qVSfFAkLiBzWd+/IDtUwDv950WwOjxYLZSPT6fGBPkmU7jcaMIvNQNwFjAhSWx9
 Op0mJSMt02xIP7a7/XZaI7XPtmVx9ZQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785940378; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Howpo1a3QB5x6OHOeonqhkoLDqgr8XPk8OtZIK1fu6A=;
 b=eNHCYoR1vh9p1bWqt7nVBkrewKoQHYclyCj3q24FIn1SoV/kgUoMYSCQl/MsUv/iluIq1
 4/6EIftWAjxCVf5cn72wredPopXGHUCK1+0sixEdETqyCw1cYXNXBjwBbbSo/9kvnM3ynSV
 x9fKLsUi/O6efADl+fhRR1eji3VUkr8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 66F1483C5C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 16:32:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785940328;
	b=UnD5KJwvawIu61HsJDElwAXwTlTzppCzHS1wuvsfYsuvz2gq06gWb+ivWP7FuJJnVsrhnQ
	dIPIwN0NFS/WDwYNOn/XAWFfPqyx6LVcASIETuDVW2JEheLxLJGwQhhUAcXYfHeJyUVjgo
	amjvp2gS+p8uCzohTOWDvQk68Zw/cm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785940328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Howpo1a3QB5x6OHOeonqhkoLDqgr8XPk8OtZIK1fu6A=;
	b=vrkMBsl5V4UmnR1X9FcRWlra8URz789394gMPIBLIDpCw46dvpd9ETQGav7meCOM5wZBFs
	7mS/hYMnXvDzJv9Bo7RuBRMoh/s3+1FtBWn+xQaTeZs79Cd04wiXi4LZ+eqYVvm5suN+Tb
	bDhm4h1u7yRSp24TFszhPUrrI3KvHgw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=xzMl3a2x;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de
 [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0313BFA1DA;
	Wed, 05 Aug 2026 16:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Howpo1a3QB5x6OHOeonqhkoLDqgr8XPk8OtZIK1fu6A=;
	b=xzMl3a2xgR194p32kbuQcYrYeCVtS4bkWe0BdXJ08w+T87hF3GDcRs49m39WBXoEr1Hujl
	3noZXxRAFYvr5jT4GRrxazxs52Thd4B2ZoamywO9FEiNBOyHwyHmkW7buA8JDh0wDpC6sa
	vv3TIRAm6XeVsmbDudb4JzY7/UIZ+QmZq1FS0N94i0CuF6hiHYwhvYQRXmNq6SeTr2oIUM
	rNsVZ+XgnGlRLsBYJWCTmfs9ta+a6Za4dgAoQP8obKDykbE4D2P50gIAwscWKV9rpBxfNL
	PmEELCIZrEcH4uVnkMBPatcz7Ad60EfMyarrTNPmXAqkk2Q2LFMrHYpbDwmz8g==
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
Subject: [PATCH net-next 04/10] batman-adv: fix kernel-doc for functions
 holding skb ownership
Date: Wed,  5 Aug 2026 16:27:18 +0200
Message-ID: <20260805143200.722098-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GDVIYORNPPM67GL5UIGR4CBFR4IH7CL5
X-Message-ID-Hash: GDVIYORNPPM67GL5UIGR4CBFR4IH7CL5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GDVIYORNPPM67GL5UIGR4CBFR4IH7CL5/>
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
 net/batman-adv/routing.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b62a984e73dc0..de0848cce98ab 100644
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
-- 
2.47.3

