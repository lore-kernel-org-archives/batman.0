Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D9ACD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:04:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3013585E85
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:04:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839445;
 b=0TPdQpFCfwH5TwsbQA3xlsvQuMoTJkS2mXHPbIWp1BF9rLLCGLr7BeSizrLHXU52nYJmU
 qA4VtUo4iS3n25gVQ/48Af6tY+Zp249OVzay3PnaqJ4O5DBB39f9nGsAJJuRsOw9QnfR5pS
 txxLoR/coY/eNTWXPcZoTrjEyy8Rqtg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839445; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MD7N++K/ODC3M1fZeSj71WXES304/gYjuuvWCHBoPkI=;
 b=OgpriHyHac4l9zdr5ny4g6akrG8tSrRpvHzj4i5QRMMpOFtb0BMgCSaPjhJkJPAg0X/NL
 v+Q62Yk6NVGv3xNcujm6zl0H76lDvNuGNhMOMO7ga9ctZW7CdhnfB5zoRVHLpIztApsik8X
 ixWguJnVAqjGLdBywEj0rzPS2qfBYYA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 672448537C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MD7N++K/ODC3M1fZeSj71WXES304/gYjuuvWCHBoPkI=;
	b=D/bB37Ph8tF+772cvqWcKgpym0PA7cEWUK+8wFtlS6QEcnvwGwrvEw/UF4xmhl8mZN3bt2
	HRx3f7efSYs45XtVyq1+UWRe1KjB8qacu9j75qmm17hKWDUg7f7/AW3oB2mxF4LwEagYAr
	O4nAqQkfx7giSIyr2ND7B/izElFDCn4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=kuXYf9Oc;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838956;
	b=vo7p+BStvbmGQVYvtzUd3PGN7jN2UxeUmo7hIIw81KzpWYoT07ZaxXOVlanFXMyexCmoir
	YafL8kwbgtUXARmmOM6DkX4pF4OEWTFZFFBMOyPHMnQ6DpBPTnLDDZ6KUf2Nwl1c7OKnzs
	O7NuZz5KWY++XzTon0/Xfvo6QrVucoY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MD7N++K/ODC3M1fZeSj71WXES304/gYjuuvWCHBoPkI=;
	b=kuXYf9OcuM4E/PVrqnysbJ4fQ8zUSSGuI0z/fDOx1R56paTQYkVq8Ye9CcmV/CsZiNTseW
	stnMRWM8ltb5K8C4xhiXy3GM/DBFEKmPltH/mxrPvtXf2L7KBP+617akmPP7TwEiFkJIAX
	SfTt7HEIBQZK+HIGJdHATn6lntsKLOLBd/wplD3kKUhW5G6Vz4JZRL2EmCK5dKfHQIouDl
	vzLu9sqRB2QVOxtxQGl3KIuKIuRZvxfyPeX8pg4yvlo3iV8Qhh+w+MM3StbbS/+lm/ycGJ
	/fA9ettrY9l9QoMppfOVdZ6FkgkV3CB6iC5tFquTXBgBTh5naqjynMzo6Xd76Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Ruijie Li <ruijieli51@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Zhanpeng Li <lzhanpeng2025@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 10/14] batman-adv: clear current gateway during teardown
Date: Fri, 15 May 2026 11:55:35 +0200
Message-ID: <20260515095540.325586-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RUTAJVSE3QC74Z6ZDD7BMNSB5HWS4PB2
X-Message-ID-Hash: RUTAJVSE3QC74Z6ZDD7BMNSB5HWS4PB2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RUTAJVSE3QC74Z6ZDD7BMNSB5HWS4PB2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Ruijie Li <ruijieli51@gmail.com>

batadv_gw_node_free() removes the gateway list entries during mesh teardown,
but it does not clear the currently selected gateway. This leaves stale
gateway state behind across cleanup and can break a later mesh recreation.

Clear bat_priv->gw.curr_gw before walking the gateway list so the selected
gateway reference is dropped as part of teardown.

Fixes: 2265c1410864 ("batman-adv: gateway election code refactoring")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
Signed-off-by: Zhanpeng Li <lzhanpeng2025@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 51e9c081a2a4e..a9d0346e8332e 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -478,10 +478,14 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
  */
 void batadv_gw_node_free(struct batadv_priv *bat_priv)
 {
+	struct batadv_gw_node *curr_gw;
 	struct batadv_gw_node *gw_node;
 	struct hlist_node *node_tmp;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
+	curr_gw = rcu_replace_pointer(bat_priv->gw.curr_gw, NULL, true);
+	batadv_gw_node_put(curr_gw);
+
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.gateway_list, list) {
 		hlist_del_init_rcu(&gw_node->list);
-- 
2.47.3

