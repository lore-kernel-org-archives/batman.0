Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D40CD4F21
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 07:19:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C088985E2F
	for <batman@archiver.kernel.org>; Sat, 16 May 2026 09:19:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778915975;
 b=kSOmJsMw32witWWOOokv1dEN3pVG304UCcQBnjFUjsfO57FhvXejHDWAorz3WV8I8aR1Y
 3uwe8rCAtuXr0IMm2gmkb+Tt5TfCaSm7evJJli6hcKpOgzqTt55wrXdckoY+pRTsWXYy8Cj
 AYdzwsHo/LXOdLwIok7nP98Hu+JOr3U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778915975; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DXoRsv7COggs+5wb/oeJTtUNxU3D7lnvtpTWQaf/35s=;
 b=hTI2tog6pJeUgL9AiGVwnDdFKAKW5sA0oPQc6uqbLEAZ2qr1asuzSLqApfdVFxouIGmyR
 YOZr4vHPYUhE/8Ldsm1KV4McvkQd7tG9Myr0LT9I6OpiwYgybUzveTs5EoZSgSa/WpL4uoV
 z90wH93QCseyHa5P24VNhgOQ8HselHo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3DD1585EFD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 09:18:24 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778915904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=DXoRsv7COggs+5wb/oeJTtUNxU3D7lnvtpTWQaf/35s=;
	b=3BuSlCckhOMtNfSUT3AHGqLP4QBhPgpvAdg4r+xtwc7h0bw+IuUI15A2+vEfgKc2LFp1ys
	5HSh3IIZ3CryD2I0msf8wxUb/TgSqJMKYAIWHCxGyTtxi3CMXTDgFUlJioXqXCstYXBIcc
	QmCygqAc1rj+jIalHMaAVRuDs5Rfm7Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="x/qMYgoX";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778915904;
	b=Syf/DDOtbQFePgy+NI3IiNwETWS722HgB2KILithCIYGXuZvQRmY3obqNoYSZy3AknKTaY
	LI3rz6YDNyp+Kll3Dcs5xqviKx42X2oK1fccwZQwy2i4ALoaB7n2Nvc+nHy69kUyaAqby9
	QzG+BFuwtrHhRXDATNx2yJP4usznLOo=
Received: by dvalin.narfation.org (Postfix) id 8DCDF1FF78;
	Sat, 16 May 2026 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778915903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DXoRsv7COggs+5wb/oeJTtUNxU3D7lnvtpTWQaf/35s=;
	b=x/qMYgoXK356SC1adnjXg2qlJupPyoECETJZRRBeWrJu6KlTtRX6TrlM+J1P5mMepJeKoa
	WvuErAst05/DOIIoMrEDcfUCba2AF6SN9j6jr27bjLu3ZwIOhPmF9yQWHBNdHIIj7xbIZl
	EOfJaOjWEmq8lzma47bx2GDrincZC5E=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 May 2026 09:18:20 +0200
Subject: [PATCH RFC batadv v2] batman-adv: drop batman-adv specific version
 for in-tree module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260516-no-upstream-version-bumps-v2-1-c8a6bf1e3e23@narfation.org>
X-B4-Tracking: v=1; b=H4sIADsaCGoC/42OzQqDMBCEX0X23BQTf9CeCoU+QK/Fw6qrpmAiS
 Qwt4rs3sS/Q4+x8MzsbWDKSLFySDQx5aaVWQYhTAt2EaiQm+6BBpKJMC14wpdm6WGcIZ+bJRJ6
 167xYRih4hrwKGELIL4YG+T66n/C43+KtRYe9h+Zn27V9UedifzQnaZ02n2OL50fsj7eeM85Kx
 Cyvh4rqvL4qNAO6QJy1GaHZ9/0LjXGP/ucAAAA=
X-Change-ID: 20260515-no-upstream-version-bumps-ea213a18051a
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=sven@narfation.org;
 h=from:subject:message-id; bh=MPSwdK/7qBMY5lE5J2+UnxnBax/DJPdy1vdzKYX0emM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkcUjaVLI2PWk7/WNenO8u66imj3nPx9kkPug8y9ho+O
 GHh33q3o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR+zcZGRaIVV9WFBewPtNs
 1h9ztPjGv6zNdXJz9fqEPbdee337VSHDf0829qMrV/XcWBlseZHRruSKttDLZ25vTQ6+Wm9z+Xf
 mIx4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5P4ZCGWWNPQYU77I5XYY5KMYXOUGWABP
X-Message-ID-Hash: 5P4ZCGWWNPQYU77I5XYY5KMYXOUGWABP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5P4ZCGWWNPQYU77I5XYY5KMYXOUGWABP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Bumping the version number on the first pull request after each merge
window was deemed inappropriate for an in-tree component. The version
number carries little meaningful information in the context of the Linux
kernel release model, where stable and distribution might all carry
slightly different patches (without any change to the batman-adv version).

Instead, expose a UTS_RELEASE-based string to consumers of the netlink
and ethtool interfaces.

The out-of-tree batman-adv package is unaffected by this change.

Link: https://lore.kernel.org/r/20210203163302.13e8a2a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
Link: https://lore.kernel.org/r/YnfjtpuAaH+Zkf9S@unreal
Link: https://lore.kernel.org/r/Y9faTA0rNSXg%2FsLD@nanopsycho
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- commit message: UTS_RELASE not UTC_RELEASE
- drop the MODULE_VERSION part because batctl was not actually ready to
  work without it (seems I never prepaqred the changes when we were talking
  about it many years)
- Link to v1: https://patch.msgid.link/20260515-no-upstream-version-bumps-v1-1-6aa349f8e949@narfation.org
---
 net/batman-adv/main.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 465d26d8..7f722425 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -7,15 +7,24 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
+#include <generated/utsrelease.h>
+
 #define BATADV_DRIVER_AUTHOR "Marek Lindner <marek.lindner@mailbox.org>, " \
 			     "Simon Wunderlich <sw@simonwunderlich.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
+#ifdef CONFIG_BATMAN_ADV_IN_TREE // UGLY_HACK_NEW
+#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE
+#else // UGLY_HACK_OLD
+
+/* prefer version provided by Makefile */
 #ifndef BATADV_SOURCE_VERSION
 #define BATADV_SOURCE_VERSION "2026.2"
 #endif
 
+#endif // UGLY_HACK_STOP
+
 /* B.A.T.M.A.N. parameters */
 
 #define BATADV_TQ_MAX_VALUE 255

---
base-commit: 7700c90cbd12d04b8aabb62fe031ce6b31d6a4d9
change-id: 20260515-no-upstream-version-bumps-ea213a18051a

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

