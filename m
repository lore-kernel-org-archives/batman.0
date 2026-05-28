Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE502CD4F54
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 14:30:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6F3BF83F09
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 16:30:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779978642;
 b=sNn29wszpO7zRTOF1jVo6gUBZgJA+I9BLlgyEaV6zPHMdklYrhWdA1Uwyr7u/yyIZKXYA
 RcrXAQLzaFACRa5qn0lw0YLkGM8aRpcYbGZSxbsyBWlYDB/li+5H8Pe53SitGKQGZbNXE6E
 /AdSmqKvRzhetl7uo4SgrwSmd9FX9xE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779978642; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
 b=4ETUpABLKngti7rzDqhFGL67/TeYOf9R/Tn+eYh/yz8noOMgHs1OiL19UzepqsZNgOWDq
 ynvpc3/RcFEEDxGXzjSFupvCBjb5FBBVG9nyIw9jM/EKZTT9sLvEkJWS+hwbzghLXDnWBlh
 FftQEmmCv+6JkiBIPj5SSJInPdRW/t4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A36C083B96
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 May 2026 16:29:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779978569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
	b=RDotIiZ2L35APrrQl31+RX2jlULhAYq0iFlgrqGv3dDUeJZNFBh5k8IRZ/a1S5zShZta6k
	GxwAysA5pm40pUy79a5u4ZrbvNbY9ofD+ElEwxCQ7RMRUQyzWPxerxGK9aBWktkx67lXbj
	BP51/FbdC/g3oK6cE0wkPV5iR4rvyFg=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779978569;
	b=bmI/S60EiFEm31+X0H6ZMpyD7hyMAyvA6lIBGgXsQ1gIDfZeMRzgvzaCXHCg3SNlO4CILM
	tBqnO5wN+wfNNBZEnjDABrZWU6b+HWpNccOEfnLbeOWsExPJP6B8Co4ub41ZIExvSMSzlN
	UCq1mv1Qhqxpel7HF23h8ozQNTMuyo8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=CJfeCqS7;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
	b=CJfeCqS7qikt2c3LdpYPYqlxIpfI35QRvdNQbCtRbx3qLRoKQYosfz1XlptkxqR+/hNbmJ
	OWP4C2GJuKA0O8jF4gOodEZZg7zzlOjtb1c5+IJif0tGhsmyuZdACesJrEnR2PF0OU+qNo
	pJI1RRUsMbtGnO9qNBypEDQslQM6uKUbYiGraQ80MPlHEdRztpq66TQkRhXXzt3GM3K/NI
	nNJn/KGK8K1SZBgr1HojXXDPKwhrwo9BMoKg4wi+7S1I3EvB4fezBGPYdRvd6mEhM2IYP4
	1Qr2IUQn16zYIO1Ypa9kPk1kjmwC66nc2FsnHezoksBSz4whezDA3HzbkkR06A==
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
Subject: [PATCH net-next 03/15] MAINTAINERS: Don't send batman-adv patches to
 netdev
Date: Thu, 28 May 2026 16:29:12 +0200
Message-ID: <20260528142924.329658-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZSOHABGQ2Q7HPHWN6YQF76YPUIQHAOFK
X-Message-ID-Hash: ZSOHABGQ2Q7HPHWN6YQF76YPUIQHAOFK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZSOHABGQ2Q7HPHWN6YQF76YPUIQHAOFK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Do not send batman-adv patches directly to the networking maintainers or
the netdev mailing list for initial review. Keeping these patch iterations
off netdev reduces review load, especially for patchsets that require
multiple revisions before reaching consensus.

After the review was finished on the BATMAN ADVANCED mailing list, the
patches will be queued up and then submitted to netdev as PR, including the
full patchset in the same thread (for the last review).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 741fb4166aa2b..75ff01377fc6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18635,6 +18635,7 @@ F:	net/
 F:	samples/pktgen/
 F:	tools/net/
 F:	tools/testing/selftests/net/
+X:	Documentation/networking/batman-adv.rst
 X:	Documentation/networking/mac80211-injection.rst
 X:	Documentation/networking/mac80211_hwsim/
 X:	Documentation/networking/regulatory.rst
@@ -18645,6 +18646,7 @@ X:	include/net/iw_handler.h
 X:	include/net/mac80211.h
 X:	include/net/wext.h
 X:	net/9p/
+X:	net/batman-adv/
 X:	net/bluetooth/
 X:	net/can/
 X:	net/ceph/
-- 
2.47.3

