Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA0C43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 13:48:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC46B803FF
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 15:48:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782827310;
 b=eaECT1K9R0n4qdIVLwrw2IDYxeUiaBszjwP0R8NYAxcIJResyuJJPwGYAJWiUyvhSF4n0
 dWAj8S8OCqdlGIuUpcTRcNpGS8tQrl+IIOGqFK7nx8ZQ65Y9T5QuV5oUGXIuEv5flHM1F93
 gKjvWSzIYy6aFqsR22WiINbBhZbnF2Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782827310; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UONHzAgMDnGAqgV001hktCRBsTNwdlIvzqeiepXYuTc=;
 b=SFuV4MDsplALrNCo9oaYSbH/yzxp3tKUBatR+z4t891F7mLYtF3wMcE2Ttm4UZsodG4M7
 hrb9r5kvJCr+B4KPBw339uJBSsq+bKQo/NJZ51nLofjf8BpivpVV6ycnc2WZEj2QcqbJRXR
 SqMHqD07mOK7Jc/zDUbkEh9UM5MuhDQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E2BDC83B5A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 15:44:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782827076;
	b=J1TF22WAIpBs0Fxo2HdfNpsx0YKTSFqR4zY+cFoLoJfCyGvtp0L+4mX5Gun+Hd5As8UPfs
	Htf1PSWmyDH2R7KIHdr4R+qVCoEDryyG74RR0LsSXthtI3LRptSesHO4ZbprrFVKsgKI0L
	kwHgqtMg+N3TnGG8DqmoM+/xw7I3448=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782827076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UONHzAgMDnGAqgV001hktCRBsTNwdlIvzqeiepXYuTc=;
	b=tTjzo970/+WG/r2dwhOu2nHiNVXc+3EouH9ZiVtqRv11Hvdva6NnXl2CAUP6YbMJwb4w54
	nQ7vXoG5ZOaxN3uyahJiIe/RALnMNxQPH+2XqU4mH8yI5SbR75gpZMCmFxCuC7k/UaQB7N
	l+QzMRvgnKfyje3TpEYm38zHR5Jr4cI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=YyjZHLMS;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UONHzAgMDnGAqgV001hktCRBsTNwdlIvzqeiepXYuTc=;
	b=YyjZHLMScOcXHooP1WAl/NiqDz1zr5JAK22e1P6TuqE+S+n6XYytAGOK6LY5NQP7zYy+ha
	FTVK+AERmm/PfH+tJmuVur5FWus5o+NVXZ7Iqa93QHMTotDS7WN+Phk5T9YLqefHGtP/LM
	oKjQfCknbYChfCtTAjLMqVturhtdntUDNQ+kOIO9qyHh1v6UAnSfeQdhLucYse4kBha0gO
	XO+X55x6JWWxxEup8DzJtH+TjhOJlZYSHjgtiA47aFIxa/HnaNu0rGnF89/LOcJ/4+8T50
	DfHlWsgn1i1UPKZZ8dRpyezt/aOZY5MLuTJyTxK5nF/Qykcl4iEW2WCX7zLjgQ==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 5/6] batman-adv: bla: reacquire gw address after skb
 realloc
Date: Tue, 30 Jun 2026 15:44:29 +0200
Message-ID: <20260630134430.85786-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WFQO7D5HIWBF6JJVUV5VTP4F2AUPV2MC
X-Message-ID-Hash: WFQO7D5HIWBF6JJVUV5VTP4F2AUPV2MC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WFQO7D5HIWBF6JJVUV5VTP4F2AUPV2MC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The pskb_may_pull() called by batadv_bla_is_backbone_gw() could reallocate
the buffer behind the skb. Variables which were pointing to the old buffer
need to be reassigned to avoid an use-after-free.

Cc: stable@vger.kernel.org
Fixes: 9e794b6bf4a2 ("batman-adv: drop unicast packets from other backbone gw")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2cc2307a41702..bbd40fe3a8e59 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1029,6 +1029,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size);
 			batadv_orig_node_put(orig_node_gw);
 			if (is_gw) {
+				orig_addr_gw = eth_hdr(skb)->h_source;
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
 					   "%s(): Dropped unicast pkt received from another backbone gw %pM.\n",
 					   __func__, orig_addr_gw);
-- 
2.47.3

