Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF98C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 737B9853B5
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:22:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502565;
 b=GFfhbmZaRIPv0nNXeMcbq9qz1uc6yJrTJbDxp+E/B/WHy0mbl4yRk0dKEzjoHMEAZFA6W
 61QwRh5nROl2PwIqFjr8y+owJRCEfzzKk77Bpx4BlFV84wTAcyYp+XYtgg2/Cy8WwN6Is0E
 fh7k5V99Re7qo6YHQxkCZvaGvtAsJPs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502565; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iKVr6k89o6c2SMn62B3acIsRyxHbKZyCo6kVHh2xDwU=;
 b=3or5BrKU2Ul/KzYDf6ov+0mdbVKkZgqfxoTmHGhAvT6lpXXMjC1JXSxAEux1id1Aqf4RD
 5Za5WCuzL+KJYeY2V7mzbYC9ihsChtRHOp4fJlGLNcvP7ca+ZPktcOyyxxvp7Cwe8vCw6hG
 /yfWAXWTdgq+LAwqecx5qaMXw9mYtYc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C0DC381E8C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502324;
	b=DNOt+UnEpzjBb6dcbR0xz90Az6QhNT7oVrCwcO2gaFSnr6e1BlP4bHv0uRZK/rZpS5BO6V
	Sg9cPh6OTIHMfPEyZd03zJZ7xwj0xTffmVs3ycnKmLjYIpMZHYG7gwCUrrd6Qchz+ZLtH1
	/w1y9AAdPf13pKcCmeZhKYtm+lMBfF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iKVr6k89o6c2SMn62B3acIsRyxHbKZyCo6kVHh2xDwU=;
	b=MM4PO2zK7Ca/7p1tgPet5setc1n9tYLIz3AaSDuWogkM/4URw3/u0w0W7ezkyWb3wR27NN
	k1Ca2TJvMKxuaMU4r1wPUAE8fqkZxPs32l6wtKp3zAbTFWXH6cBn/IbfUWPivnAp/KIr4i
	r11/ws2tnGQ53idTYqCXrj6m1X3dtIY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=yR0X5FCa;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKVr6k89o6c2SMn62B3acIsRyxHbKZyCo6kVHh2xDwU=;
	b=yR0X5FCaJ/Pz0v6Ak83gzmOdsOjnN4BYXXJ0lzqjd1nym7vRWHa/cmSCaM/nJ3KPulJ7A8
	nIGLvaOlOLOqxCR2DcVUypCBUN5xAIqLlhshWNy/tDcDdy+I9h8uqazQwuzXd/x2SdHSSq
	ZWu8Zs/qypEas5HNpN07N77oqv2AVXpLgEB213NnBtCdkB6ZmG3VZgzrZLV3E5L+B+uUzp
	bgngvfjJBK1Kj/d4cJr0kC3eJAtv04tlZJ+k6VG5hzZvXTU/CJ7xDfnrUCDpdKcyPw1W5P
	hca30uz/2LYvg8NkKYYMMYPXIASjODIC4aH2a0IZWFQfb1qhSKhoFtftKOvIhA==
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
Subject: [PATCH net 2/9] batman-adv: fix VLAN priority offset
Date: Wed,  8 Jul 2026 11:18:14 +0200
Message-ID: <20260708091821.314516-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CF43S52SRYXP7S52GX35G6EY7GBKQOT5
X-Message-ID-Hash: CF43S52SRYXP7S52GX35G6EY7GBKQOT5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CF43S52SRYXP7S52GX35G6EY7GBKQOT5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The batadv_skb_set_priority() receives an SKB with the inner ethernet
header at position "offset". When it tries to extract the IPv4 and IPv6
header, it needs to skip the ethernet header to get access to the IP
header.

But for VLAN header, it performs the access with the struct vlan_ethhdr.
This struct contains both both the ethernet header and the VLAN header. It
is therefore incorrect to skip over the whole vlan_ethhdr size to get
access to the vlan_ethhdr.

Cc: stable@vger.kernel.org
Fixes: c54f38c9aa22 ("batman-adv: set skb priority according to content")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4d3807a645b78..8844e40e6a803 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -368,7 +368,7 @@ void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 
 	switch (ethhdr->h_proto) {
 	case htons(ETH_P_8021Q):
-		vhdr = skb_header_pointer(skb, offset + sizeof(*vhdr),
+		vhdr = skb_header_pointer(skb, offset,
 					  sizeof(*vhdr), &vhdr_tmp);
 		if (!vhdr)
 			return;
-- 
2.47.3

