Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52FBC43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:19:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 45EF084327
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:19:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502353;
 b=tTv1uY6SdIrcov38HBcKKQHTP9kvIuCIAq1QiGf4fZ16dn260gWXLLXTVv10f8fyeSVDn
 2uA1jFSeHOQEqqYC5vVUGfeJxPx36soIHQ02MsLuxi5yttgRL0VfPCfW+SJfdCrQRZRTATS
 v1SSfK0GXvWQ6C1+ETDBHMjYFmYDADI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502353; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J5J+tIbRjyAogUs4+BXpxDdI90HGCo95hYrshku0PZg=;
 b=pWsi0z/ukx22a/EyiO6nTkEySbQky5aBHX1RMJudH0p8h/UQiN6cqerkuK0u+WNIOcBYu
 riklfl91T8fAAq+c06seAO53dIOuZCH7znpYK46qwcrooQZkXjLdiPSlhshlu9q/TKzqT07
 5GeLVVmTRWelLQpFnAQG55Iu7xAnNAE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C3D33802A2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502323;
	b=gxJ445EuyZLJM+1ryuG1nn/Qu295+pds1FqFvdzAiUA3OZth3TEjaPXjkginJWBy8/uY8D
	5/HJG0iWbLgwCcWTtjMKz2SKEyQO57BuBzHsG0e/jwapiB+Hox4jW7GUEfyulua2VgXHWt
	hlSSOH6XaY6JJMQ6m1jfcZQ242JkX1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=J5J+tIbRjyAogUs4+BXpxDdI90HGCo95hYrshku0PZg=;
	b=yNHyxAvjX8XJgzqmjJmL8ondupVpwW95aM5Z1b9fBj3vnEIgyoxAs66BEuAToXtNQHJoyQ
	kUSLwx7BsmHnrq2BZOA9Ugas3ckm3H7lmu7WChHRv0qydsJVB9FCF6Cjt9cWqdMwBPLTFV
	s7bGk2IbaoieoWKvL0x4lHE2KGgcBRs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=YxAPM70f;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5J+tIbRjyAogUs4+BXpxDdI90HGCo95hYrshku0PZg=;
	b=YxAPM70fqXr0DJvTU/LwJcskGVz/oMIVqoaWY7+4fsEc5eW1IdEHNQs009Srdfo5Bddyma
	vKPRC0k097WMBy5omhxm3BpMQHahHSLCKNqDtPTTP5w7bb+HzXosN3fwK1QT6/nHnOykwx
	tsE5sV2bdIOvSyjoeeK04tY3P3evHRhGBM7Ssq2Pf/IwJjhVRNljEUNPcliweNAeLssvDn
	Y+k/mboC2wT4S8kmUC3vIeTkr2H0HPcewA6qCxUsKI8xkArfhr5oEqWmZGhpsqcmsw30Qj
	AzQfeeaPV6bQAs8XQviTGNh4/aX9iEvSgoY5xjDMhpqB6nkSo43y9G/MjE8JCQ==
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
Subject: [PATCH net 1/9] batman-adv: ensure minimal ethernet header on TX
Date: Wed,  8 Jul 2026 11:18:13 +0200
Message-ID: <20260708091821.314516-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ACI4MXJKC6MXKQZ6I4H4MYIXHPY6MJDF
X-Message-ID-Hash: ACI4MXJKC6MXKQZ6I4H4MYIXHPY6MJDF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ACI4MXJKC6MXKQZ6I4H4MYIXHPY6MJDF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
at least eth header len bytes"), it is possible by for a local user with
eBPF TC hook access to attach a tc filter which truncates the packet and
redirects to an batadv interface. But the code assumes that at least
ETH_HLEN bytes are available and thus might read outside of the available
buffer.

The batadv_interface_tx() must therefore always check itself if enough data
is available for the ethernet header and don't rely on min_header_len.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 511f70e0706a7..0b75234521b63 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -195,6 +195,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 
-- 
2.47.3

