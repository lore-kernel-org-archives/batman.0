Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A9FCD6E68
	for <batman-adv@archiver.kernel.org>; Thu,  4 Jun 2026 04:45:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7FB9F806D6
	for <batman-adv@archiver.kernel.org>; Thu, 04 Jun 2026 06:45:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780548312;
 b=3jskyf2KmKX3pRBaxI2yLlCRDLSotdSs02bKnHGH271VtKZ498Ts2lwFgFNNvTv9btCxj
 1zll+Zatt1+rhRDW95Lhf7OU3S+F+RjB4GAli5ItbbIopltULVkV378QtFx/dVhzN2Hdpe+
 WpetYa7JzR3USGeUWZSiCVmPaqylu+E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780548312; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jATcNv/X5XSIn4dbTZ4f55sihpASI671jRk9XVQOOcg=;
 b=EjweXLYI5ZXmRfXLdMTjECT/mUspiwM1jbV5RDKzkbrr/0k9eCpFFh+0bWZ8eOHTZlZ+Y
 r/bQ/+ou5IpSynBzSAHzou+9n6/hwHbe4TTE4T/LfCHSqJO6qbIpT1tpBaiJe5PmA/y/HjS
 Dsy7wmnOfm0gIqaPL4AvWPBbDipjkc4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9197981F65
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 04 Jun 2026 06:41:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780548076;
	b=uwPGPkKbyXaOGmPmVQ1mcdrCu3+NxJNSxxJnWMoW+Zeq0KXr0FW73GDlFriRDUEz295E4Z
	+dHshBs1iXWnJbPLj8hQUMjpoJl/Cz1g5whrXIItnuhOTgvdxMbXXDY6jbAorjmC54dkMs
	lXXxkwXQWKeNKNbV8DABMvfV6DKLAaE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FlVnlyJd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780548076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jATcNv/X5XSIn4dbTZ4f55sihpASI671jRk9XVQOOcg=;
	b=Xc42v2S2IezaC5/40vT9GjuD0aOcA8jA/72V2cOJ9NyIzxj+DETpZDQC7/IGMxaHNfNQ9D
	PQIrI6Po6WBD96o66QprNVZTSoKotwBZp0SgGrnTGvFDdneW2JE00i+sWMCNqt/T0jhRp/
	NFfvUEIk1Bqx6bbdFf0HJXgc30rAaxo=
Received: by dvalin.narfation.org (Postfix) id 1AD211FEF0;
	Thu, 04 Jun 2026 04:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780548076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jATcNv/X5XSIn4dbTZ4f55sihpASI671jRk9XVQOOcg=;
	b=FlVnlyJdI1bS8p75YKTBRE9M0oo1w7RytbfRKKWgtMaM/4ORe+Q4P1Dlhh8nRdWzIGARD6
	xM3qDTmDYNCy/GVi4iCwXV2/8t0YUPa55qydZbGJU9RPMXmAk59V0WA3wEWKj6tECgDlms
	qYvAqOYaztsHIeUzr/c8fa7nwCeRBJg=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Jun 2026 06:40:51 +0200
Subject: [PATCH batadv v2 2/4] batman-adv: document cleanup of
 batadv_wifi_net_devices entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-wifi-cache-cleanup-v2-2-c89d32c02471@narfation.org>
References: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
In-Reply-To: <20260604-wifi-cache-cleanup-v2-0-c89d32c02471@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=sven@narfation.org;
 h=from:subject:message-id; bh=ruDUOsoy1eGu0K1F1znyoFRb2Iyt07kBia4IPb7hMjE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmKjJeXP9u4h4lDqq8tWFi2q6BszukvTzccXvL7hCv/h
 02eLg9WdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmoqnC8L/m/NWbueVhfWct
 9UolVY4u2dr/s+tRXcmvRuuL8XmfnjUz/M8VKNnSoLMk2fF7Vfm5a9sXc56sLImMzItistLMX9C
 3kRcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UUC55OYNXTSQZMCRBHJDTWR6JB6Q2L42
X-Message-ID-Hash: UUC55OYNXTSQZMCRBHJDTWR6JB6Q2L42
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UUC55OYNXTSQZMCRBHJDTWR6JB6Q2L42/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

It doesn't seem to be obvious how the entries from the
batadv_wifi_net_devices rhashtable are getting removed before the actual
rhashtable is destroyed. Document the idea behind the process and which
steps are involved.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index d4a351b0..694d6c47 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1186,5 +1186,9 @@ int __init batadv_wifi_net_devices_init(void)
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

