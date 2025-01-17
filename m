Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A4CC02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:43:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 016238455F
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:43:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117833;
 b=Xo2/XqpocLoYRaXZWXR6F8Fi9cCOTSnkgLDGLpW1lteWQGigWFooDoij1COp9ptccbgfy
 NjkLuKqxWcPDNmmdtTGZeucwpcX+2oCbpchfH4lTQBrG9r/pEd9pIepDSmihEXyeGAyX7yN
 OB4Qj+JzOoYx0Z7iAKj/y0jkaBUVKzw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117833; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=feZRruAcUJ+Am2HGGm3SlXhvn+uKBqCHkBQP/YjTrVE=;
 b=si/O/E8fkmbLZaviHBCW9OnTs1a0x2GxY/Wtlzq9ZB+jJsb55dXLAo3rpSMLloI7qfFJR
 S4mUzLUoxW9xbyLrTbGE6F5wzw9gEVRx8M5fo8BKrLV/m4AQdlN4N0k0GDXd1BrVIm+7Zx9
 WjOfagoLuljf2NLnyIDGBcxiF4REC0s=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 27CD984138
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feZRruAcUJ+Am2HGGm3SlXhvn+uKBqCHkBQP/YjTrVE=;
	b=BFbmnZl9J5ATgIvnaBH8hhVhG7r7gcK5dEnXs0D9PGjw9xAmJXtPeWeStRtXgyTPIrcJfe
	1bBmt9wR9GvOmaSvCWfoiOHWmDSmd3q1VzxuQRtYCiCCclejxMdppa09ISDYFVkiB2Y8bY
	pAXLT4zA+kUgnreuWXDikQUdWoJrr20=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117580; a=rsa-sha256;
	cv=none;
	b=q3njfyUpfGCY1Yj3q19BmjNnIwTxMuiUDeSj8igV4h5T4qoZMOa/a06RTrUE0iiUU4D9ng
	XvTycGQvJwiwrbupvKM2gzUA6N25N3049jXuKHlPQMJJ8Z2MlIo23EQYv/ZH2aZ+faoPTU
	g6n44lDfGSgwlmmpXXjOepXWQvzUyhs=
Received: from kero.packetmixer.de
 (p200300C5973C90D8A96DD71A2E03f697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B51E6FA366;
	Fri, 17 Jan 2025 13:39:39 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Marek Lindner <marek.lindner@mailbox.org>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 06/10] MAINTAINERS: update email address of Marek Linder
Date: Fri, 17 Jan 2025 13:39:06 +0100
Message-Id: <20250117123910.219278-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ODHEFIRU3YTC5LHQDC5546VNYP6IE53H
X-Message-ID-Hash: ODHEFIRU3YTC5LHQDC5546VNYP6IE53H
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ODHEFIRU3YTC5LHQDC5546VNYP6IE53H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Marek Lindner <marek.lindner@mailbox.org>

Signed-off-by: Marek Lindner <marek.lindner@mailbox.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 .mailmap                                | 2 ++
 Documentation/networking/batman-adv.rst | 2 +-
 MAINTAINERS                             | 2 +-
 net/batman-adv/main.h                   | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 5ff0e5d681e7..53e038f5f654 100644
--- a/.mailmap
+++ b/.mailmap
@@ -427,6 +427,8 @@ Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
 Marek Behún <kabel@kernel.org> Marek Behun <marek.behun@nic.cz>
+Marek Lindner <marek.lindner@mailbox.org> <lindner_marek@yahoo.de>
+Marek Lindner <marek.lindner@mailbox.org> <mareklindner@neomailbox.ch>
 Mark Brown <broonie@sirena.org.uk>
 Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
 Markus Schneider-Pargmann <msp@baylibre.com> <mpa@pengutronix.de>
diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 8a0dcb1894b4..44b9b5cc0e24 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -164,5 +164,5 @@ Mailing-list:
 
 You can also contact the Authors:
 
-* Marek Lindner <mareklindner@neomailbox.ch>
+* Marek Lindner <marek.lindner@mailbox.org>
 * Simon Wunderlich <sw@simonwunderlich.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..c5e909a759e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3867,7 +3867,7 @@ S:	Maintained
 F:	drivers/platform/x86/barco-p50-gpio.c
 
 BATMAN ADVANCED
-M:	Marek Lindner <mareklindner@neomailbox.ch>
+M:	Marek Lindner <marek.lindner@mailbox.org>
 M:	Simon Wunderlich <sw@simonwunderlich.de>
 M:	Antonio Quartulli <a@unstable.cc>
 M:	Sven Eckelmann <sven@narfation.org>
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 1fbe3a4dd965..964f3088af5b 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -7,7 +7,7 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
-#define BATADV_DRIVER_AUTHOR "Marek Lindner <mareklindner@neomailbox.ch>, " \
+#define BATADV_DRIVER_AUTHOR "Marek Lindner <marek.lindner@mailbox.org>, " \
 			     "Simon Wunderlich <sw@simonwunderlich.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
-- 
2.39.5

