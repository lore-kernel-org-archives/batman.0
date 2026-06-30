Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54628C43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 13:44:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AFE8A83E6F
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 15:44:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782827093;
 b=qousqidi08q2ix5bhDHjIbw76iOLe0XXCgNDtc4NCAmyVJoldKBPDEAw57ULh7m8v09lQ
 AHo0uKU79qnHOzGVacs4DbPdZLI9EPjO0koqw9StIcdn4lNfy78nHjrEY3I2gCoFJAqYtl5
 7oSBRDZaS12s8V9+UV97QhE2JQtUw6w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782827093; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SOjchQvhacxvYrMble3BHRhvtECYrwp0WDh1TmLB26c=;
 b=0/Wv3YgJIuBt0pEKKkw45PDWcFtYyu/JQJsRdJg8Q5fwCqtevzfntYAFUDGnfhp6DokSf
 1mNOHGraf5bNe5uO6pQHeFY+9LSKkUUXFLdwjwQZpHSudqvd4bFKKnNNvAVL2KTbnImhBm5
 8XuLx0zNa3hGgVppzT0idODDxihGEeY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DDDA5826A9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 15:44:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782827073;
	b=O1Cxypt849G2oX2M7MZwfKYbnTeZLhf8TZWxs8ixWqw58NhbUzD15PObsnXGLAYCAaqW1g
	IEnUoJQrdhoeNccF8D7QXlU4yJnUiPCB4o2zXmQiVEytf+K+7yF4jllZDp65aXTe7RNxWK
	EzGQOHrHRw1z4IcjFWGXWFkK31msqL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782827073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SOjchQvhacxvYrMble3BHRhvtECYrwp0WDh1TmLB26c=;
	b=XtRZmRXKcB1H7CjEiJM/QgnGL6ExHouYGKzIGBg8jEWwf3ZJeEj6sbvFt4xPhTRCDOM5Kf
	p3VQGWp6EcN2X2++652gER1hnDyScT4kEYzu7aLzpqk+W8ig7uXOrYNUIel0bauJu/skR/
	8spxSElGscgnyYDs2ES5zt9t8JRzDQ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=gSGup5cP;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOjchQvhacxvYrMble3BHRhvtECYrwp0WDh1TmLB26c=;
	b=gSGup5cPIGZra0Xv5mvac2TW7IAkfBMTTDmKokVrMFVTdIcQX4RTZQB4da1DRBJk69tbNw
	OmXD0uvyEiF3ZcmlgHScJd8qtLwGlnTk+R4JgIrJ3GNybfVJKxBVedtauHfaMAA+aXFcGC
	iF+MzJyAZm4oq9VyYtAcv/PgWiUhnCUdZhlNN86N6c9ZLH/QBMUicyeRpqa+GxMlTPdIV4
	Bo9fc1Fp3QYFkUKi8WpRu522oW3xrXHb2TrHreFhdcwwzVqcmwEj4TrTpfyaU4xKX+9WqV
	XGj59EcKqkbDY/b3aZxRO2q19+2j7DTTD869zlUBGfj2NI9Kl49bcBvF3mNxhw==
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
Subject: [PATCH net 1/6] batman-adv: retrieve ethhdr after potential skb
 realloc on RX
Date: Tue, 30 Jun 2026 15:44:25 +0200
Message-ID: <20260630134430.85786-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IE7MOAHGQ2LPJ3JR4BPUPKOEQF7IZ5NI
X-Message-ID-Hash: IE7MOAHGQ2LPJ3JR4BPUPKOEQF7IZ5NI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IE7MOAHGQ2LPJ3JR4BPUPKOEQF7IZ5NI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the VLAN header but missed for the ethernet
header which is later used for the TT and AP isolation handling.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: c78296665c3d ("batman-adv: Check skb size before using encapsulated ETH+VLAN header")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 44026810b99ce..511f70e0706a7 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -434,6 +434,7 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
-- 
2.47.3

