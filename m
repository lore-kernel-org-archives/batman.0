Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C7AC5DF87
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:52:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2F7CA80728
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:52:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305957;
 b=wx4drNPqiA7Srqr57u7vS07rXKjttXTCuxm3kTRblmv0Svvujg5XemRSULJ3eHNqE2vir
 u7BnjXjFd3sn5MZVn6t0CoVfWu3g/tZcmn20GISfl9FlDkeiGjbnM7hH0jp6CxEup0CXU67
 4KwsQGd/mbUc51YccERb4D4sCa3QorA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305957; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QZuErQ3cxKr3SogMZj3GKBsaBSwY81i74yvWwVU+ZPU=;
 b=Bp6XysU/xhKKoaGHPftxciKUbktSR6HdiOIVlpHNgpnuJIRh2Tf7ZFXeb+AdsRapXaVYa
 3z4iFaL3i3MiTUW0kN1Ez8CJDXh8isSapvELjBuEnCQ5RFAL8B1kbvPgO3G0ox8GhkgZxGr
 FhPVH2hAYtBrF38UNGZICaPPTdfmhEw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 360A4812B3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305703;
	b=2mSmvCAU6vMj0axEngygRFIKTyh5qVYp9PgpJvhd4Y3UxiXLCdmD2dredqWTbVe/jmu1+H
	fHDbVJnx2aP7GvBA5SRCTap1MRQLZOr1folFT7M+yNbtul3HoWXj0ORov/K2m9MFO1EhnF
	VgErSsLJquqwAbRkQ/JJFsfsYUOjOVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QZuErQ3cxKr3SogMZj3GKBsaBSwY81i74yvWwVU+ZPU=;
	b=FJAI99K8A5Jbcguz1HCqj2GjfqEXffZwPybOJWEafN034LNA/j9BvofY7+FfzxizkkCqUS
	CgLNKwE8EwdSIqh7/aL/x/bNUzZEgM5RqFcgDT05sPb1wBNaQBs6aXVPPbzt4p7oxtMfzl
	WbyHpBQRkFTmcAK46D0JuxVrCrl863E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=VIgEtKAb;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714FcD8EC8C87C354003fed.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C96F7FA154;
	Fri, 21 Aug 2026 11:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZuErQ3cxKr3SogMZj3GKBsaBSwY81i74yvWwVU+ZPU=;
	b=VIgEtKAbBkzOI4pZ+xVR2XS1EQRajR5/zbHZzHf/AX1gTdOh0YooS6+gvUAbPKIMTzKNCD
	drimB/Y6QKubO+ULjqv4oEwV0zPmyhGtGV2Y4f9NI+k8xBpDklDpN2p17t0TK58OenwguF
	fEqfhQfyOuGNmVo7j/s0JE7BNm3i+OTQRmQ2PFOwLue+nU/jQZcL8fLp2yYWT/WhEROxuc
	sZ92/dcHk6dEBm70yNscKiYud9ujkGeL9Va28/OybwmgWG+dHecgB30iGTIC2i40S+25IZ
	3A+TGEHPzH6pSdx5XlL/Ngssx/+4DoY55qOqjTabcvmElHByJneG5JBTvFc1ag==
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
Subject: [PATCH net 8/9] batman-adv: mcast: linearize skbuff for packet
 generation
Date: Fri, 21 Aug 2026 11:48:12 +0200
Message-ID: <20260821094813.201800-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LWXKFZ4QCH6OP2BHZURSOCKJ3PRNFTDB
X-Message-ID-Hash: LWXKFZ4QCH6OP2BHZURSOCKJ3PRNFTDB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LWXKFZ4QCH6OP2BHZURSOCKJ3PRNFTDB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_forw_packet() and batadv_mcast_forw_scrape() is not only
called (indirectly) by the unsharing+linearizing batadv_recv_mcast_packet()
handler. When it is called (indirectly) by batadv_mcast_forw_mcsend() then
it will be unshared but not linearized. The SKB_LINEAR_ASSERT() can
therefore cause a fatal BUG().

The linearization should happen during the expansion of the head because
the scrape function can be hit already during the initial
batadv_mcast_forw_mode() selection code:

* batadv_interface_tx
* batadv_mcast_forw_mode
* batadv_mcast_forw_mode_by_count()
* batadv_mcast_forw_push()
  -> calls batadv_mcast_forw_expand_head() before everything else
* batadv_mcast_forw_push_tvlvs()
* batadv_mcast_forw_push_dests()
* batadv_mcast_forw_push_adjust_padding()
* batadv_mcast_forw_scrape()

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 3927d28dcbb89..ac97cd8b81dc9 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1108,6 +1108,10 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
+	/* batadv_mcast_forw_scrape() + batadv_mcast_forw_packet() require linearized skb */
+	if (skb_linearize(skb) < 0)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.47.3

