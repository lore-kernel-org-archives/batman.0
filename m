Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77549C43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 13:47:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F06E280837
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 15:47:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782827223;
 b=TRsvVlO8FM8ionplk8IEuNszSdB7+e7GcD88Q1HXQ9+e6rV8FAP+umV2vYjar/dd0Zijx
 3i4s4NriOz71H6YWH5WvObsY6McCfSYOUXEmthHW0Tli5pP22sw+IG3IgAoS12gHteS6+OP
 PEX8F3tuE9jjO3xxXL6Qa9Sjs8L0MgE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782827223; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JBuHPZ3Gw+mxEmOkIIjrkJNU1dKRnB7h3kisH349Hag=;
 b=aTsHk6KP5KwApwWFXw820YsrQXeeEY/4c6/Cv1UyVBW46jKCMsCWk/PVnufkOIFNwqW81
 HsA12H1u9LEYJTQDVwF+lD7Lc+iZSX+jMdCrEhc1ZGqR1Y8MeCe0VTviQhJ33QGzrphqrXP
 /b0kccpG1kgd6T4Cvy+GywFoepkUhHA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5780680C21
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 15:44:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782827075;
	b=quNYa3RaLTa7vWdEoqsK/ZZoKYmrHHSArZqC+LyfV0p0ffT3oRM3dVCrgqIO25IFLwaKz7
	iJjuXXXxoX6HCnLMwxfoMi4wuzAbpP2XzK5g5CHNc5Lz+tSTmL9BwxPtR5N8O0/VFXi1If
	6jTjBWQQM+xI9NMKmsdF2WTMY5LBY2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782827075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JBuHPZ3Gw+mxEmOkIIjrkJNU1dKRnB7h3kisH349Hag=;
	b=FDYXQZGfXJ4UzZaHSjme80oNmOORoz3Pyc6yepLhgC1cDoTmAIc1P6tno+gtNTeCAcbYGB
	Xca0UD0hwJcdET3Xy6HvZMO20ziZdxucG0eybo88wk1a4mBnFPPA2aNRo+6wDMRIDdm8q+
	4egrugkCCRq+05kHUgI8MGHkjJ58TTE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=InxosmK1;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBuHPZ3Gw+mxEmOkIIjrkJNU1dKRnB7h3kisH349Hag=;
	b=InxosmK1H4dBLqnjRvXv8/9FIZjpGJzRKYs6i7DJrTtsB0sA9lDmbj6mQVVUb1ruxDE9SN
	I/ETKihQZlImJOidz2lWiDk/tBdPM076Jzg6dxEerRixHCo2BAUoVM5IzhT/ig8VCVL7br
	v+hRDptzhwlKxAQvOmJkt8ybClTmNbgVGx8hUiyj1jr0kLczS76lNsUxhE7bITB4zrN3Sq
	iudM3agVD3ZQ1AhCweabAxgLuJScwlPCFv+m96ypwxk+VEF5Kt8lr20/dDZjs2SsU22sAq
	rz47rE7gIxGqoIFQxOCd18hUgpHpOFp3X5Z3ci3tYPuPoSl3qs0Yhoa04IXpkA==
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
Subject: [PATCH net 3/6] batman-adv: gw: acquire ethernet header only after
 skb realloc
Date: Tue, 30 Jun 2026 15:44:27 +0200
Message-ID: <20260630134430.85786-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PCCJ3QBRJNZJCTTVN2HDBOWP4R4WZCIK
X-Message-ID-Hash: PCCJ3QBRJNZJCTTVN2HDBOWP4R4WZCIK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PCCJ3QBRJNZJCTTVN2HDBOWP4R4WZCIK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

Cc: stable@vger.kernel.org
Fixes: 6c413b1c22a2 ("batman-adv: send every DHCP packet as bat-unicast")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 305488a74a256..a5ac82eabd250 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -684,12 +684,13 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_gw_node *gw_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo, *old_ifinfo;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct ethhdr *ethhdr;
 	bool out_of_range = false;
 	u8 curr_tq_avg;
 	unsigned short vid;
 
 	vid = batadv_get_vid(skb, 0);
+	ethhdr = (struct ethhdr *)skb->data;
 
 	if (is_multicast_ether_addr(ethhdr->h_dest))
 		goto out;
-- 
2.47.3

