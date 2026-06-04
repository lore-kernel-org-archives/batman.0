Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D49CD6E4A
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 04:45:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2C4784306
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 06:45:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780548355;
 b=guvKkgvv3Rk+zJC89vSAoIJos6mg0a6IfxfpLsaorn9oO1efNbpgsQQvSq0un7k2h+z0B
 A+3H9Nc5NVgZvm5n60EIuT7jAlnqsUW/HxLCEYr3GVPGH8QD/rcjtl33orQdNHCxh6C2Ul8
 vTh2yfRto8rRG5izCSA1Ur1KVT+jy1E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780548355; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yzbRpAb/LDZLFEBB1Tcmics7h1w8e3X0v6iWNxKO7Dk=;
 b=CpSOFOKTJ1w0iVD0qiJApEItqLQV4ZFJoZzfPhMxmiNtEFalw3eHoCrJeh+orpN7RPTHb
 Qkn1/8OdottoveE0w4X0iPT8nJMT/0Ubhi4GbXuHEDrVIvBOPIvTSE3IYOZ0Gl85CDBj6n6
 gBesLoDogJ3qk6IOynT8iZeJvt+xOQE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B4D30818EB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 06:41:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780548078;
	b=BSw6m0GTYIH6EKYbeG8XpykUaSDW1DcYosloqSReGmM0ylqkkx0fXdv0Hr3R5/OP4wWOy/
	PIOKdWSMOrB8EHcjo++Ur9yUENr08udQXaQWs4M4wOfM46ZFcTZYnkg4ttR+/SPiLWYckh
	6RvTXbYcWBork/dIMFo9PjGCVHtJMRo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=g2x6ukFM;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780548078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yzbRpAb/LDZLFEBB1Tcmics7h1w8e3X0v6iWNxKO7Dk=;
	b=Cl6ez6rkxx+m9YbJ1vIlLOfPXvb4fp+S14ISm8nVY+uFXLyFmP5ubFDo8KrcL0fChgKFNF
	FBzSjZGzsehy1YvH7ErG8mBTaJLJ5rB3/6PNOe3FUaD+a537MiZFgVqlauH4cZuwDQK6BV
	tm1NHDrkCaoWKp9xXpldd5HQKR8XGXs=
Received: by dvalin.narfation.org (Postfix) id 6E36F1FEF0;
	Thu, 04 Jun 2026 04:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780548078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzbRpAb/LDZLFEBB1Tcmics7h1w8e3X0v6iWNxKO7Dk=;
	b=g2x6ukFMdfMw+tZx7IRgVcfkfe49hF2NIqFQ1+20RAfmoBxKAr+pSvAA7mdWoSOVHw7TnM
	SGhj86gl9z5K6NSIFLUau91zRdlwXFMTYkPoBFLNcn55gvJ1ls9fr8L03tuII845306PA/
	ChS2GUAaYbzTteGXvEq2mcB/1Iv/7Cc=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 06:40:52 +0200
Subject: [PATCH batadv v2 3/4] batman-adv: drop duplicated wifi_flags
 assignments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-wifi-cache-cleanup-v2-3-c89d32c02471@narfation.org>
References: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
In-Reply-To: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=sven@narfation.org;
 h=from:subject:message-id; bh=U9LvpEVJjOuDv2ONwJrr7fKjbzOH071SgYob7v7sBpc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKjJdPBzw3mm7Qs8zDbt3Otnvhzbn/glrS9F24p+1l3
 vZPzK24o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRfY2MDP1i+5y2vl9sx3jA
 d8fn6S/2aBdcvRrxefNfMZVcvXaOSB1GhhmqR41smO0NOyeuNtHpiT53XK/5kPiDeyUzj6u82L1
 3KxMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2RW4AZCBDCDLAMT67CD3YXEXZTZBZXK2
X-Message-ID-Hash: 2RW4AZCBDCDLAMT67CD3YXEXZTZBZXK2
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2RW4AZCBDCDLAMT67CD3YXEXZTZBZXK2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

During the initialization of the batadv_wifi_net_device_state, it is enough
to write the wifi_flags once before the batadv_wifi_net_device_state is
added to the batadv_wifi_net_devices rhashtable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 694d6c47..041df554 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -987,7 +987,6 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 	if (!device_state)
 		return -ENOMEM;
 
-	device_state->wifi_flags = wifi_flags;
 	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);

-- 
2.47.3

