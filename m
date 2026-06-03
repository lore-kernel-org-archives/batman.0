Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2646CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:27:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 92ED584B44
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:27:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780471625;
 b=a+Q9Zuk9U48fXP3Jk0hvSpPZED5jGVhJ3KszV6TZ/KrHlYw8tj3grxmoG9cubJnPJRtR4
 8SPFpLvowUQNZVVQKBbD2rrNfVCbtlehuPiko3h4vxbqFJSoLhYZfqqdwN5qqLQN2+t09fR
 UZbyLeDRJU2+WAcFotivKxwZ083YB/U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780471625; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=e+83fEsbAL69oKWYxDFj7s2qHg00oHFkNjwBFZNJ2Lc=;
 b=SVraM9nQiqqc+zo1BDEa+ibrc/xZKmtMYtHaF6id0lsRcrULP5v1HEhJNc/YcGtTVkPmu
 +rNmhR8Lfp36iyr0SJp1cTtetUeXjuAPF51es6PgBTIdz/lYpV5A8pxmEQ4bl/RB22Z1POf
 cRRHcT/q6i+7D32dXWh+T6T6NTOnPwo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 220D98460D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471532;
	b=PPiVE8aOzEqQaOhAJ8UOKb5tgAZvDhEiYUsgFXjF/JOBYlV28OsU9rhWegbi+qycN9fzjp
	UE3aW7xL0/XBkri6vo/Jxvlx8g2/ZeyOFrMVC6tqgZcoFttCWVYdRXrzNVIwpa4TSoEH6b
	gT3zJSZiQRFyQNZQDYnC1E8/J6CGeaQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=f6v8iz4m;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=e+83fEsbAL69oKWYxDFj7s2qHg00oHFkNjwBFZNJ2Lc=;
	b=WwgruOCWrbV0U2zltoUPcoXMW1cafNgvb84074klG6Z0vMgtTupn/7civ/w47SUrOl4TBM
	szbBEizdI3awTYb3yHSFe5w9JJMKxYKCDTFebt/GiJ+EbW2Lw8l9pQ586zL8g7OsZWDEt4
	DXwBN+wRLK/WydbYVkTparX1Hc3HJG0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+83fEsbAL69oKWYxDFj7s2qHg00oHFkNjwBFZNJ2Lc=;
	b=f6v8iz4mYK/t+dIlg5vlY9pW/piwxb51qHhTAc2ZgNTJCjJdWZZDMSUdGt8kbo3JdTHlFJ
	zEf73MUKltr1UzogMmGVRSVw/sYY8f07ICZF0qGqo58N68qA/bCZ4I7KcZAbR5r3aJKLYS
	W2AGAf5siXF3gHO7BbM2GMg03z/W4x3qCquSR+jzjWEHAn+z7FGe5lCKbXibn7lLOy7P4Y
	hm8NEnm+ip+Mo2MlPRIRw54UyekhPCO41utbgtVfmpb4uFwZPV2VRc37dnom8QQ4sMUomF
	32aZdr3Col04mLuTRVfBS53B5nn1r3cAYa5GwS4ppVVFu76OKiE29jUocQZOSQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: tp_meter: initialize dec_cwnd
 explicitly
Date: Wed,  3 Jun 2026 09:25:14 +0200
Message-ID: <20260603072527.174487-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 67U6E5FS7HFDMOYBQMLEZL5JIS3CPF6Q
X-Message-ID-Hash: 67U6E5FS7HFDMOYBQMLEZL5JIS3CPF6Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/67U6E5FS7HFDMOYBQMLEZL5JIS3CPF6Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_update_cwnd() is called, dec_cwnd is increased. But dec_cwnd
is only initialixed (to 0) when a duplicate Ack was received or when cwnd
is below the ss_threshold.

Just initialize the cwnd during the initialization to avoid any potential
access of uninitialized data.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 8d7308327a9bf..beabc264a4f16 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1055,6 +1055,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	 * mesh_interface, hence its MTU
 	 */
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->dec_cwnd = 0;
+
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */
-- 
2.47.3

