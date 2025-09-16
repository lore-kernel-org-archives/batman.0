Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92069CAC599
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 12:27:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 37A17849D0
	for <batman-adv@archiver.kernel.org>; Tue, 16 Sep 2025 14:27:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758025625;
 b=Ye1+n2m8TaJqKrB8FobJfRnv8ZDFVGe/oTlUOt4nk/ygxrsJZMvQ19+Y7paY06n+ZezOm
 4MfPrO/KJgPKa8UoMPdNrYkejifYOMaHFKW8KNdw/AEfmJ2nf5djOLYlM0R1cInsCeCnBEn
 6E9mQ4U6RxsPSMoHhYg/TMfveXqE0U8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758025625; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MjqIT1+EEADjxPOfID0+WPgjiZRiplyDrRfoyYEAL8I=;
 b=EVB5Vhz/mSnFYx+JMsDuuX5EdW5P7lB9m8A/mJfvaDSkosIApg6cocLFFIx6UY33KtfaC
 UgNPXbBHlZX9hoVUW4ib7DPp0QnW2bffiIrxTsMKRUM471WBEEy90wh3MygVoTnQMlb+qGy
 HStgkMCKGea8OFtUyx0jmF68MjcT5Yo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A8EEE82F18
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 16 Sep 2025 14:24:50 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758025495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjqIT1+EEADjxPOfID0+WPgjiZRiplyDrRfoyYEAL8I=;
	b=wAYsF8onPi6IHKKYAFL1vqLDIFwePByBkv43nSvfRVV3veZFmi0VpNFFIndQf3zUgSzIFU
	7KLFKuObU8tMwRvmxdFJZxiqNLSPXu55kePFiW6qI+JfIXRZ98J+5JqnTMVVBXM3ajMwPv
	QbpQq76s9FNtsmB0KmpTmoF1YCfbeoA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758025495; a=rsa-sha256;
	cv=none;
	b=VVTmLzWuG+Bp4VzQuQQ/AEpCDZN9bNkh/65T3VFrRYlbjh0gR1rjgQOkM4IeRsvvg7cU2p
	nSsK00U7BTMjKOux6oKzp2ZAHzWOtAVIaIlGJfUOF/y277Tw01/M7vXmAf60y5GdnW44Vj
	S3+A9c1rAeECspKWuYiNH0IWAY3GDE0=
Received: from kero.packetmixer.de
 (p200300C5972536D8604E0a64D0d3AaD8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 42B23FA130;
	Tue, 16 Sep 2025 14:24:50 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH net-next 1/4] batman-adv: Start new development cycle
Date: Tue, 16 Sep 2025 14:24:38 +0200
Message-ID: <20250916122441.89246-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916122441.89246-1-sw@simonwunderlich.de>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MOHZHKODNCF7EXYBZOUCWWV7IZBOSVFG
X-Message-ID-Hash: MOHZHKODNCF7EXYBZOUCWWV7IZBOSVFG
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MOHZHKODNCF7EXYBZOUCWWV7IZBOSVFG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.18.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 1481eb2bacee3..0d3ec0f1c9fb2 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.3"
+#define BATADV_SOURCE_VERSION "2025.4"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.47.3

