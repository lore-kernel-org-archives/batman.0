Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F325C67861
	for <batman-adv@archiver.kernel.org>; Fri,  5 Apr 2024 08:46:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5EE14820F7
	for <batman-adv@archiver.kernel.org>; Fri,  5 Apr 2024 10:46:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712306801;
 b=scl9MUdMiDmmYfH8x5aO5YhLEYTO5qJDQzM0snaHCl7RfCKmNM+8jfMWXD7ZrkV0WGcMj
 Xomphdssc76aRGDC3KFvtu+zZxcOJrKOYRf5CL93XMY6LSl2T4s2toFAneJZP0u/cozlLgL
 UDdocZZHWCmqI2gO+Uepv+tyL/Xtma8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712306801; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3aUr4/dni4MrEUc5QFw60LijXMxBbN04WTqmqPuotks=;
 b=NEWG9ic4Jf2swAjdYWrxtfJeNqBvXoOZGjPtELm14oDy+kQm3XAdb3355V035xDaTsxKb
 nI5Y5JSGwqVgTVGJJS1qsxaHJgsBS3RLmkYRxgtJsWRHrNqUd98BlWa3AyqKB7NSD1lIATh
 DOAweIewZRsW4W5lkvJVXCzDIHikYec=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B172480BF1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  5 Apr 2024 10:45:55 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712306755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aUr4/dni4MrEUc5QFw60LijXMxBbN04WTqmqPuotks=;
	b=g7d11ej7m1KaLdYdWCjQ07F/nyNrS8Dk93wWDR2UFTpUFziVMSggepdeoNjs/rqRPUBgox
	EKU+VorJeoSy7ZfFAMJpTEJKWiHA/jLmsV0RXpve0wGhPSBN5zlN4Nwr6r9VuDDuww8BdP
	F+T5akNu5iweVQjjMYaDI/c9vH8bv9I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1712306755; a=rsa-sha256;
	cv=none;
	b=i32etNLMSd+TkRDfh9xrsS1CZLQy4kayyaDDLqxtJVJKcQp91VtkS8BkwjZ8wJylMsWaiG
	EJD2SSBkvkG6xfPM7Y/xGczVJ24FgdzWsz5pOOHgfGf4+4a5e+w15UZzF9BWc8dcR1yID0
	BzirRMh9m3ZNDMYe0XzY4/qC/NvuhGk=
Received: from kero.packetmixer.de (p5de1fdf8.dip0.t-ipconnect.de
 [93.225.253.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 6CBFEFA101;
	Fri,  5 Apr 2024 10:45:55 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/3] batman-adv: Start new development cycle
Date: Fri,  5 Apr 2024 10:45:47 +0200
Message-Id: <20240405084549.20003-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405084549.20003-1-sw@simonwunderlich.de>
References: <20240405084549.20003-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4BBP5PR2XKEDOYSCYY5GOEVCM4OWH6U7
X-Message-ID-Hash: 4BBP5PR2XKEDOYSCYY5GOEVCM4OWH6U7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4BBP5PR2XKEDOYSCYY5GOEVCM4OWH6U7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.10.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8ca854a75a32..3d4c36ae2e1a 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2024.1"
+#define BATADV_SOURCE_VERSION "2024.2"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.2

