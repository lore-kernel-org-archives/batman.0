Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F8DCD6E5D
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:23:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 71F4681679
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:23:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644206;
 b=2pATOdAUrwGHvx69FvHkGgbH9w5Te0zc6kuDDwz5frw/5TYPvCiNdlTZ4semjubTrRJRs
 Uz+jE98qRtNK8gzvGGZm0KyYDx3Kluub7x20YKMbYpOGbcxb4OUPLJsFmS9H8+EsmFmoLKi
 mtGT6k0BRz7uBSpBRlhb+I+t1/4qFEk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644206; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8Z3e0PI28LeGcMYG8odw5Z/Z//UT2Tl+ozm0Mg/7nqE=;
 b=Qw/viNjDeAJ2c98V6ABhp7gB0nSsaL0GhSIMew2fXFe5IxrrLzAuLb0/uVEYmcbOw0f8Q
 7ImDbgNKkqr9t/DI2kprk7b7bWUfonvAQmD0DUnZeCVdQPve6d2HuO4U1gbuyo1Q82ssQ4U
 5G9qA0s3fm34S5lof2wJRE3SOR28asE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5B410810BF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644017;
	b=rDHuduCiqsnfK/In/i9Y8+I0RBLU8AGEb8mxbKAwczZk+lMvlWTEOJwxirT72hKMPl7wIg
	Xa6FG4IZAofxjLj0nWcTaQsCu2uWfBJSeQu7RLbfHGHk3bTJQ3l+jJVRmKRwnBQwWuWNuZ
	Lf8EH5B7AFVSMpSseMGaRK3iOmgJ/XI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=LcIl2QsH;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8Z3e0PI28LeGcMYG8odw5Z/Z//UT2Tl+ozm0Mg/7nqE=;
	b=Eru8yEs4a90lqC5XlmTyolFFBM+SsQsZaVVPm8sU45HKO+n1a4zpdlIEyPk4uYHGK3zizO
	qeU2ou33tKGwSqRHFVl/w/GufVsgPV55wByOLrUmAgJTOe6aVF9P/pxGdFJ6dfgQTFG8qP
	UvmF2OTibHBqYEfzpXom9uN976OIZpQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z3e0PI28LeGcMYG8odw5Z/Z//UT2Tl+ozm0Mg/7nqE=;
	b=LcIl2QsHTdsLYxV/GZ5xPeL2W2u0vR4HHxqSzoAsROkZZqSU+qzUFsBeT/NfSvYIwNWt7m
	qbIbDlBVGdipyNX0d689qoitud/P1z9XGQgqGSIWvoGebFEoF/y8BXQ7TY2Qy62Gs/Iuy3
	oOqEkxjcUKh2U3dQoAPy7WX9sOoSYvyFQ05QEAFRAH5/uifRNwdopc/007UHK/y/geS4aT
	KPgHu+HFNJlYxQA9SGQtKoDnbuU3/MxDZHEbwCEPPvHkCo/I9f6m18bq1UqNY4b8XldSG8
	XnBqNgIsr13vWUDaozQ0mGjd+DMpoytRB9fVFzmCfWOa36AgJkfnSN38HF0uOA==
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
Subject: [PATCH net-next 05/11] batman-adv: document cleanup of
 batadv_wifi_net_devices entries
Date: Fri,  5 Jun 2026 09:19:59 +0200
Message-ID: <20260605072005.490368-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IVMJAJBZAO3RTUGPOU6TCN7YGZDXKOQI
X-Message-ID-Hash: IVMJAJBZAO3RTUGPOU6TCN7YGZDXKOQI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IVMJAJBZAO3RTUGPOU6TCN7YGZDXKOQI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

It doesn't seem to be obvious how the entries from the
batadv_wifi_net_devices rhashtable are getting removed before the actual
rhashtable is destroyed. Document the idea behind the process and which
steps are involved.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 04b227ec80525..e2c85bd8dbb53 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1185,5 +1185,9 @@ int __init batadv_wifi_net_devices_init(void)
  */
 void batadv_wifi_net_devices_deinit(void)
 {
+	/* just destroy table. entries should have been removed by
+	 * unregister_netdevice_notifier() and the corresponding
+	 * NETDEV_UNREGISTER events
+	 */
 	rhashtable_destroy(&batadv_wifi_net_devices);
 }
-- 
2.47.3

