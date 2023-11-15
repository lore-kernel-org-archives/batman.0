Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E100C072A2
	for <batman-adv@archiver.kernel.org>; Wed, 15 Nov 2023 18:00:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8CBA683D7B
	for <batman-adv@archiver.kernel.org>; Wed, 15 Nov 2023 19:00:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1700071246;
 b=uNoUYK04ZpCd/EP0V2i1fO0/hJ7+HjAxBEwKKp/eekzzcj6T26smvvotDvWVRzgNPh2Eb
 t52QK1l5Nl1viJ2Y3M4ayiqgveEbC/JH6kOOu+xARC03seXC0eavxvx1xTxSYHr+crq841O
 MwTgdJOsexZeITpIQP1gYD/b1XcwNMY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1700071246; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jk9t/C1Kv7eM6BqP924MQJG+SIBfyQJnZABD7Cj7uJk=;
 b=uk8I18/q/l6Nd43oLJTgnTH7qH/y/yCSxMXoeIB4w8HfLhhMNhHPfzpCK3T9z3uHbf0PA
 Pf20gXZwOxoGl6ubqvMzWMB0vdGCtBvDdZ+fnzs8u0xTDpR+YaMy/bWfMYhLtofiAv310bg
 wrZnyKhStR2vgXA3jiyT7EcssGufOBY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5EBEA807C5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 15 Nov 2023 18:59:42 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1700071182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk9t/C1Kv7eM6BqP924MQJG+SIBfyQJnZABD7Cj7uJk=;
	b=SW+6DJsg/wqDFCvp83J6K7zhXtGzFxfetGVFUEcvuFLlDpTLwdrEXSSs1m67ZGxTpCSQkj
	sjgsjIKYlfpyfTAHZI6NsJXn5DmkutdKQ4BG6Nm22swHpOYDcxzk1Nit7aU370cBU1rvpJ
	0cY48mmG0CWSXWZhQfG4w+Gb3KxyoZg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1700071182; a=rsa-sha256;
	cv=none;
	b=SD4baw1iQXZu4KDxVbMKF1HE/EHcN1AN3I49wWPXjAedeYhZWjEvFBQF4/BiIYiU5HM7bV
	N0Dpk/xAnSH/7EkJWfQd11HBkSWw5ewauJnGX9Hqi0q82ivDTLCWm/2tkCSm+kml/XGjU/
	4rq+ArQ/a6+mwtlhTnceMfw+9Lnys1I=
Received: from kero.packetmixer.de
 (p200300FA2706340047Bd8A14B9c54dBb.dip0.t-ipconnect.de
 [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0AC86FB5F9;
	Wed, 15 Nov 2023 18:59:42 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/6] batman-adv: Start new development cycle
Date: Wed, 15 Nov 2023 18:59:27 +0100
Message-Id: <20231115175932.127605-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115175932.127605-1-sw@simonwunderlich.de>
References: <20231115175932.127605-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OGN4CFERRMLH4YB5FSWTD3S52UXRHJ2D
X-Message-ID-Hash: OGN4CFERRMLH4YB5FSWTD3S52UXRHJ2D
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OGN4CFERRMLH4YB5FSWTD3S52UXRHJ2D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.8.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 10007c5894a1..870dcd7f1786 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2023.3"
+#define BATADV_SOURCE_VERSION "2024.0"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2

