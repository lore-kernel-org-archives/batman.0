Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C44CD11DD
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:38:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 302C281B61
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:38:25 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715905;
 b=M0SZfH3LFrZmk8Pn99l3+T/H4z5I3xPQHbSG8NlMvdR5A6ftAAWcM3mtWOrtAzhZgnzFM
 9bFA7HP/TDK6rIcJ69cMvgJ7LAM2xHTjc34EXsZDTqyQoDIHDu1H4Oco4VHF/Bf0IqzM4TF
 TMqbc9ZHalHI9agCtQFzoBUAuuS6BYA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715905; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=M4sNToqo3pYtCNoKkdQJnzJEmmse315/r8KbzQeFPjs=;
 b=c3aUbfdW4uGSjepJlgZuH/eL+clKnTOR/GfLErKyyEfg/fRE46drmJNPkmAoT8w31JtGn
 s4f4Pi6wMZ5B/KwcPdUUMxZvb47PemgVRJGLaR63rKFswpoQBy1nnC1rO2mxroYccc89P/4
 lUopR7wmEwv6zwh8p2kN62KGepIMjpI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 203D3821C1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:35:26 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=M4sNToqo3pYtCNoKkdQJnzJEmmse315/r8KbzQeFPjs=;
	b=SYkzkebJqd1a6RSFWmimDjg4KORsWF2rXPoRUyWqsyc65RjoWgZGkvTzOc70MiqSAINyrR
	AZQRNk0UPr92m6krx+nygVun5VrQSQOnfDNfdFYlRfOJ2q9Xxp9Uw0qD/cCG7LL1ABsFF1
	VFcV5ynBOGyacIfEdLd1bl/qBLgKfN0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715726; a=rsa-sha256;
	cv=none;
	b=nmY9Eq4BEXQjWzWJWG4yuHO8LIYQ5Oqf7bNQoiaDXjKZSQAA+HCnsrmMvU9pLlwP3oU9nl
	MOuWxNii3e20V4cv1Ugv83Sd533TAJoDRuCmHfLkCj6sWLs42p8T5XVLsGnhpJqJfY+v0k
	HHlAoD3Lrc6EfIfYYdtsjFUSuaUMPYg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=GyLg1Qbn;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 02CBB61932;
	Fri, 29 Mar 2024 12:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B332C43390;
	Fri, 29 Mar 2024 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715724;
	bh=PmkpG9xyozHyIEXJIgQk0WwwHU4/pWTCqDE1hBXAblc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyLg1Qbn/tS+uk3ErVBnZIiPXcy9HFQ9vkP1x0KVDkNmUtp8pq+fbkunDPN7O4eQq
	 uD0TWBljWne22qX6VPe+QdG6fDtrZP1pNCSFZCMK9yEI9jTmcetbAEQi9vdmHpuQXs
	 JYR0+lQ79cnI3cPXgdqoff2oKmW5flDv7Y4vD9M3Rjv0rbU5VqL/+/7TyYflIq6RcU
	 Rf2YWskOR13E/2qhPhHXAL45fqU9zSMreQ3km+PKDtf5K+6+OQvPVouRK3gQKHlnRY
	 +3CLn9+J3UAEgtw5Am2tBjjIUNgk4W1tOKu4hv9oRalef3zVyQjRmNwtGe8rDKP3fz
	 E2dT4kR2RXHBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/11] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:35:08 -0400
Message-ID: <20240329123522.3086878-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S4VRMOTIVBWWDYNSDV2OVLDLWMQR36KQ
X-Message-ID-Hash: S4VRMOTIVBWWDYNSDV2OVLDLWMQR36KQ
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S4VRMOTIVBWWDYNSDV2OVLDLWMQR36KQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit ffc15626c861f811f9778914be004fcf43810a91 ]

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label “out” which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index af380dc877e31..6930d414138e1 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -648,7 +648,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -692,7 +692,6 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0

