Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04301C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:25:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96A08854A9
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:25:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502701;
 b=usmqqoDBdBojPKTaY0ZhYRYm5ssoJEST+VCzx+l6etD9wC5HBgx+AXO1EhhQwBMuAKuef
 koiMWSfTHU3HviG+vwAYJPNsJJz3z0guO6SC0ksopImKEHx1FfGLTGpgfLtIw7p1WePeWYx
 HW0hjYH1nXXsEBbiX2i4A6dpEHrRXuY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502701; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5U8UISu70rMYz9drDEm9dQtE1+U1aVr9Myb/+AxDp0w=;
 b=4HWp2CDVOF3bVoFXRCjYSgeDVLy2i4urpjHBhhFCCom7KmeL99JOKTNGpa6zjXZriFan4
 SgxpbY7Sr9VmNrrv9lnha3Ksky2uqXOlahFYa+7N+KSEZNQVr1Dhdy4DixMRFuMspQklbu1
 Ut3BNR3sp+fUTCdJ6r7SphhObGEio0E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 52E7D83704
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502326;
	b=qsBX3cEWaJBzczqZ24j7YPyUeN04hakKWz4QK+38UOoHyjUI35yPWC+0hnEA7CxwdSj3O3
	Z/qWiIjivwCmMhgcjnGLnRIiQl5n9I+J8uiGsyGHCtGM2hSRAdC0R9deUXDmPhSLXHrE8T
	Zc87LnvKx2mbmux8AEpYH8IZUtQmXEg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5U8UISu70rMYz9drDEm9dQtE1+U1aVr9Myb/+AxDp0w=;
	b=LQ1KtNoenLKFOzqVpjy238QqOGPggUmmcwP+IrnnuDGGsOEjA9Coe1TijvDVGSMEUYN8/p
	u9uVJ2j2sywloOjYAIoMWz+buymdI5qwm37qB+CIYHw4XJijb+L/0WZrFtjBQkI4bWrcyG
	6ox2V5d6pOFJ1obj/wxuXijqzhZQW7k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=muBAzhwl;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U8UISu70rMYz9drDEm9dQtE1+U1aVr9Myb/+AxDp0w=;
	b=muBAzhwl74D3W/iPlVV2Ovb/bVoaPw6ZLpszOTHLeFfvbl0ZscfwKvPsXFEOoF5wThik4V
	980JR9Mupm0Gbo0JHsyZ3FFmdX6i9ASXihka8cL0OQUO1v4A8RH4Ys+9iNmNQ3bzFURcXm
	Lhwjnt7T8IyI2XsZ9JT0LC0w7Vhr+qbOl2epPrmkeJvKiZffS95abLFD/1HWbdnr5ledHM
	BllMMsFgCKccIpKsvdwIe4ThjGxMVMRq7UVdagPc/ozINuNx3ecMfI+7ETqGWhwCHzC8ll
	5K43jF0siA5VcHVAwzhagDsEg9yg5kG9dSvLkvlBoTywR+neC1X1GvPcEEcijg==
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
Subject: [PATCH net 9/9] batman-adv: dat: fix tie-break for candidate
 selection
Date: Wed,  8 Jul 2026 11:18:21 +0200
Message-ID: <20260708091821.314516-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N3UPPIAWLL7QVMTHL6JHHJZ3Q6JKWZ4F
X-Message-ID-Hash: N3UPPIAWLL7QVMTHL6JHHJZ3Q6JKWZ4F
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N3UPPIAWLL7QVMTHL6JHHJZ3Q6JKWZ4F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The original version of the candidate selection for DAT attempted to
compare both candidate and max_orig_node to identify which has the smaller
MAC address. This comparison is required as tie-break when a hash collision
happened.

But the used function returned 0 when the function was not equal and a
non-zero value when it was equal. As result, the actually selected
node was dependent on the order of entries in the orig_hash and not
actually on the mac addresses. The last originator in the hash collision
would always win.

To have a proper ordering, it must diff the actual MAC address bytes and
reject the candidate when the diff is not smaller than 0.

Cc: stable@vger.kernel.org
Fixes: 785ea1144182 ("batman-adv: Distributed ARP Table - create DHT helper functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index c40c9e02391be..a6fe4820f65b9 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -546,7 +546,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	 * the one with the lowest address
 	 */
 	if (tmp_max == max && max_orig_node &&
-	    batadv_compare_eth(candidate->orig, max_orig_node->orig))
+	    memcmp(candidate->orig, max_orig_node->orig, ETH_ALEN) >= 0)
 		goto out;
 
 	ret = true;
-- 
2.47.3

