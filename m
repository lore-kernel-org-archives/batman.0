Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6528CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:37:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 55D8C84268
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:37:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052631;
 b=3YeXMv9XdanFdGGcF/JLKQ41ReUK1YhiTlWQwpI/V2rOfttdzqoJwt8tmLNPPv8iRgHQI
 KbqkW1a9GQ6nbbWCx43+72v+3gTBLxCGtYbLlRNSXqoYEE/ctZGpYFMGw3IHEVpz1o134sd
 OqgVjA/yyHcK7faBU6z5fOIIHeP9iys=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052631; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rdSOu636v6SEFNELc2pwhakDAdk+lSr4K5Mk5TRPhDM=;
 b=JJ8jR+JC+V+xuQX6OhCffnysZLE3IOe1fke+TH9TZUbWWncfMhHZ5pJtF89W0r4pqOMhp
 O4hRYt707OfVMtOnTxDaJ71bq5KqE0ol6bh2pXfp8DXq66rrpMbAUHTEALzVilssoAIXHy1
 cXFjClbrjYvceuYoF/CwSGpjaPbwKsA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3A8BA841B6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051919;
	b=J/eKzg0Kv9Sn9mnvNy/qxPJ9wv3WO2GqIWQLZQNlp6AkFQGOiNXW2PqjuKqB7OavJLx42P
	Cv+GNfXTbtWQ85AyLFAUbJ4j929XZLnTQvKEsxiNUB1ZshYV3o1TcQw0cghzVgrOWTKSg6
	sAQ6BstlD2jMNHqbi2LWhfkVj1P2QKw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rdSOu636v6SEFNELc2pwhakDAdk+lSr4K5Mk5TRPhDM=;
	b=cqf78siHs7ZNO2oh1izeXKqhuJn+KHpo4sHSVJHAlwSgjbMl0zOjwK2ttnzYV+eGTiF1kB
	GawqftWVOf90mcDbT2jyOzhqorrh0Dws+DfNSwzbiVdqly0PCNaanoJXf9ujwy6tOArumj
	SiX5LGBwqpHoAQjT5ahXViVP7bI0oIo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZugJ2qFY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BAAE620131;
	Sun, 21 Jun 2026 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdSOu636v6SEFNELc2pwhakDAdk+lSr4K5Mk5TRPhDM=;
	b=ZugJ2qFY+Funtsi3DwPgL6Tlv1+jUCRBcT9GIiaoO/ZM7CbogM6Vn3OT9eZgwR1KRAu7Zd
	2dixeCFN0CAR+vJfgSCZoHPv94zpaNzpjLnA/LRBrmG4Fz6Pc3R0PsUAU0NVi/Bfy+XbSl
	zFfgKf1H1m4oGv+6q/ErWHJByfDb/Aw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:07 +0200
Subject: [PATCH 17/28] batctl: netlink: check for BATADV_ATTR_MESH_ADDRESS
 before accessing it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-17-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=sven@narfation.org;
 h=from:subject:message-id; bh=qCeUnPDAofCnp2RRnuMMjBCVzCvJagTuLGFvG81ZeV8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9imfLy4fv5V6WbeGgYuEdk73E/Sb7WcVfv3RbBBe
 NqL2Nl8HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJHOBl+GfoMqWzyyN/WX3C
 jLWHuVsS7pnEeHPvvRZ4/nTiee+n5/0Y/ukeEy3eM3l3qpaXc0qsvsXDQ71vIwMFFc/+Xa8af0H
 5FQcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JDQY3P2PEY2QYDZDXPGRN736WFV4GXYP
X-Message-ID-Hash: JDQY3P2PEY2QYDZDXPGRN736WFV4GXYP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JDQY3P2PEY2QYDZDXPGRN736WFV4GXYP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

info_callback expects the BATADV_ATTR_MESH_ADDRESS attribute to be set. But
it never checked if it is not NULL.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/netlink.c b/netlink.c
index 5f78602..be92a9c 100644
--- a/netlink.c
+++ b/netlink.c
@@ -325,6 +325,7 @@ int netlink_stop_callback(struct nl_msg *msg, void *arg __maybe_unused)
 static const int info_mandatory[] = {
 	BATADV_ATTR_MESH_IFINDEX,
 	BATADV_ATTR_MESH_IFNAME,
+	BATADV_ATTR_MESH_ADDRESS,
 };
 
 static const int info_hard_mandatory[] = {

-- 
2.47.3

