Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77309CD6E56
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:38:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1C3C580070
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:38:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317523;
 b=1IBFMOy4ENuObSta92DbB1RFpyON1V8t11b058CU6tWfEV0PZHIiUhAL77IxcYsP0BOiJ
 1/3Pxgkd1qFdH+Dcrs3kqVUXyOeO+bPQdTNR0zjXxKf3ixkaY9t+jGFbxJNgio+fJsnIIRU
 lI7W2c5KbjgUWjNd1wpWJiR2qcIMOHI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317523; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
 b=xKTP/gXk7fdfA3jOLySFPLGtxRxdTysfxJrtVJ+qoKaf/JHlvWfet7Bntv/uFWB8Y1xo0
 wjNknZS0jLdGR34pe7NLgeL6cQd8PPQHWfv+WAwKRr1eCPKFuJgfQD6G5ec/SjLnqLZhndg
 tVW0lagRhiZZ5Iknb7bV2PTyF+BNXsM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EEF7480452
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
	b=zPIVJcVMlp7M0Tue9BMvQ0ImH9OsCK9V7e0gH2NcjyyEyH3/msbf8djVXAhCGGHlB0eMnM
	TWfIqC2P29AkdXyRQJXXBga3U7K/vKHmTkF4R/crcZYhmTm7nqHDXBk44Q6bIIe5OWmDDp
	w/feGArDGjgsIl0RQHsRCO/s9H5OmPg=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317406;
	b=1+F7BoMdOswspKgCSrqvLwU7YYoNpiOh25Idcrx1lOAoE6yQTNoDT7LJmOqTS/vcj/G6zz
	agBwZXFsudrrGnFi/HVQa1bFI1hSEiKd8/VbfWIkzOUVAQl8pBTPWZfDv73CtLVbgRCymE
	0h/PNeD/8hLr678So9jh/GGDdUiHavY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=vz759esL;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIEy8VIPaknF5zTeIk9SKJnqfASk5vwCPb0ma2Lo9dw=;
	b=vz759esLIN3EOkBpyGzcOP/frAJ/4SSguFrP7K1GpzZ84AIU/KuPm9nfsov1MvC8HjUeb0
	qIAQXCQtCWrhn3VQiK00Z46TYhc1M6EYHus5k0qoh5dq3Iah19hwZsnCiPjUob80w15Y3k
	If+gJBWj7o1w9da9BXnqZUKWYzmxMew5asxh6A5hQ4N4Hps5EkhDYqBEWf5lwGZztmDHty
	8x7glnvUtKVBX0C+D0UWWJqXnRY5VWwJaoAD5u2mEKc154JPFk7jvkyNYPKX3+sc7Yzafu
	z/5d+IIigtrg5zLRRs8yUo2b6K3Gz33hlUcGuUwR5W+VTxQLPthAN1oGH0sqzw==
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
Date: Mon,  1 Jun 2026 14:36:17 +0200
Message-ID: <20260601123629.707089-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WNS4UHXKWETN4L6APCYIPQXFGUVMQAR4
X-Message-ID-Hash: WNS4UHXKWETN4L6APCYIPQXFGUVMQAR4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WNS4UHXKWETN4L6APCYIPQXFGUVMQAR4/>
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

