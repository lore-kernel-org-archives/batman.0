Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A87CD11DD
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:32:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2C70F81B0F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:32:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715552;
 b=E6DvloY2UZcKgypE0xgFb6CjlGWx1J6jlBZ62wfDrVSbAQSMvhfIhz+ABLomCkvdqLMb+
 MLPRMinHC0tnrkUI/HUiR1jlZLFzo1pXk7XBldNeVMLnAyHYp+yhZsrxRalJarbnxa6Kyfg
 cywKqYpmZ8NDN1GMMath9VP0+jiRbEs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715552; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7Pr7G33j2YlA7GPjjmDPCqTyfqQ30DBxZCbk0XYJMfU=;
 b=nBEMX6rLCnT6drlcr8VdGHvkTKfi/m6b0MFmgALDn0IUk0awB760QSChu3KVlNf2BUwkt
 iTPpZbuvYkc2xtlZHOV/9XC1nfrtLSBtLZDr4a68fYbJXfVmHuPz5QwMSclo+1ZnR/yxpyt
 BxwjiQFWSRNNLzFx8mgOSEgFM7T6pDc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D2B3780983
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:32:12 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7Pr7G33j2YlA7GPjjmDPCqTyfqQ30DBxZCbk0XYJMfU=;
	b=ditlRzGij+Hn+LeX5YwvmVjDE5eKs6wbRBGpEkB8f4Epy+H5jqQnm/StSzWuoHDadSPZdL
	kYLUoKNoZ9t6WNhDo89wuXiCShhL7o4LOJpx6uMOwv05DMaVhDLF159BQq9KeknKBEl9G6
	9kB+xdD0IFiNQKFCQhACzqQ1322kNKY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715532; a=rsa-sha256;
	cv=none;
	b=1jE1OVtlNGuSrmgMGMg+pBmCLFbojek/e8waSnsUXGpn8cIWFjn0kc0XD6Cum1eNXb8xGp
	UWf61cvzFzW6WmFVBhUrgfc4LOUkHVl87Cp20uAwedaEJDQgAPSbve3Qf8Sdydb7t32cWR
	x4B9DGRZKJvVncD7toByuj2JHCBd/Kw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HIKWbyA4;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 139.178.84.217 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A7FAB6190D;
	Fri, 29 Mar 2024 12:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034CFC433F1;
	Fri, 29 Mar 2024 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715531;
	bh=lxmW7oVOGPzC1rcU4r1OOci3u1l4XU32SEiJTBfPIKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIKWbyA46gGDSufoJD0NfUMpjpNom9X4amAic7xCmCh48TKG61uxeAr3c+ORRPcxX
	 fXW6KQyifOIq3FFStsIkmSKWaBtRUtHiE+77mbn6zKfD6Gw33I1bVbhyn9VOmRz2uJ
	 TJmyoDI4JyVYXwudGrzk2JC1wlzo4Y25D7AWI9xcR8Ve1QwLz91ruF7+ZPUWYGYlS8
	 RxPETKpTexACs9xdQqeAC4CkWKamHvPtZVXOEDbWm3bB5H7zrcUtzJ/MP4zLLAWEnP
	 SUG2pOf4m9epEsj+uRQwOz789NzKxo4726K4IGTdttFd6zcU4OhAz3kk9yvvH9+dt7
	 UmIwFu/sZgkmw==
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
Subject: [PATCH AUTOSEL 6.1 03/31] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:31:22 -0400
Message-ID: <20240329123207.3085013-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LCXDZYUTDYUEMEPPF7ZDPHKKTT22LK75
X-Message-ID-Hash: LCXDZYUTDYUEMEPPF7ZDPHKKTT22LK75
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LCXDZYUTDYUEMEPPF7ZDPHKKTT22LK75/>
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
index a0233252032dc..521d4952eb515 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0

