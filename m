Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD2CD6E5D
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:40:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EC5B181067
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:40:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317617;
 b=2d8u1as6SogobN96tZYClWBVsJ9GJVMFuiMOfh5cEuTwH5xt27KfCwk8dD4UFA2Fvkeab
 OAdQtURZ4cH87SGE1DIzKqdQFGsj6gnowwDGpiaFhvrj0hwcNNj17PqFkjFdwI1nGq3SQlH
 mLGwXSEXXQCLtQoFwF2xvieXHfTM+Yg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317617; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Oh7Iga6kezW1PnsL9zoSfhgAn0KI160ZKJycdSegy3U=;
 b=CmZJ18DOeA+mB6y+rPWHnl2fQ9CUIAwHe1tW0X1nnw/G22xzG3wu17eI+t0fYqteOyubS
 7jDxl3FDCoGPpoZrOZ6ru1HPAhhCkASXiUAiwbDlD1Mu7baIzVgHcj5XcHdjzerFGm1fwgP
 Mu7cSnuw13yRHkPPwtLbGpyL2zqMqQ0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B773B80465
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Oh7Iga6kezW1PnsL9zoSfhgAn0KI160ZKJycdSegy3U=;
	b=r/FWLCqNcPS3Fi+JPFC6wf7TF9dApz1A+d8ZiduU/CgJj4gvFCkfDT+dX1T8rODLF8qEuh
	owy7dLGG7Fe9VQa4iuhLozQyao2oF4R4NXthWimB7d7Bi9ADy2az4SW7/uboAxiY82ILHE
	MlZFxqCDDVBMcNg9vKSQPUUrHybU4Q8=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317407;
	b=eyttX1OzfNUDXw3ZMXUM0sD32liIQxd4T29SA9OXAayPhy4mctZNXsLXiyQ1o6nHRb7eEO
	42NoosqUgNUilGObN3ru32orS6ZZQAVpcbVJM/sLZzg4+0uf/AO+vJj2Tps8nabajzaLXs
	rCerkaikvoUSM6+pKVM6N1BTnIrPH7k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=OkRlxBHt;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh7Iga6kezW1PnsL9zoSfhgAn0KI160ZKJycdSegy3U=;
	b=OkRlxBHthAzykwb8BPy+5DNikR4l6n+Z1YGcjTQNlaY1M62pG0SJwuzAuzU1LYn5FKBqPS
	fPqZAtFAcgDcy+tV5I9O/1AD9ADCA3R1hmIDxlFRFOj0SBlPvTHQ7xXl27GYknDzxYT5W6
	6DH9tfknqiiIyPbyPhTYRryqN04n1yc1uSOYzcNN464xz3YhZvUe5/5aSD7eIlkOLnZIWY
	5nHUpiOHaS/XVGqv/QIYXw9XFmix7k5JR8VfHGNVCfV2YujgeeQ+7Jd1AGV2mW807SvDIg
	1ekXV2LaN9kNU3KD1m2MJADsoCER2lUu9/n4Z5GjuZiui676fLvd4jaL1CLrUA==
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
Subject: [PATCH net-next 05/15] batman-adv: use atomic_xchg() for gw.reselect
 check
Date: Mon,  1 Jun 2026 14:36:19 +0200
Message-ID: <20260601123629.707089-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JDO2X6I4MORB2QVC3SZLB35GIQDJ574Q
X-Message-ID-Hash: JDO2X6I4MORB2QVC3SZLB35GIQDJ574Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JDO2X6I4MORB2QVC3SZLB35GIQDJ574Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_gw_election() only needs to test whether gw.reselect was set and
clear it afterwards. Replace the batadv_atomic_dec_not_zero()
[atomic_add_unless(..., -1, 0)] call with atomic_xchg(..., 0) to simplify
the logic and make the intent more explicit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index ec743ce39be47..026627c8ba45b 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -211,7 +211,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	if (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr_gw)
+	if (atomic_xchg(&bat_priv->gw.reselect, 0) == 0 && curr_gw)
 		goto out;
 
 	/* if gw.reselect is set to 1 it means that a previous call to
-- 
2.47.3

