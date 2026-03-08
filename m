Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE74EA8529
	for <batman-adv@archiver.kernel.org>; Sun,  8 Mar 2026 15:32:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F7B3859F5
	for <batman-adv@archiver.kernel.org>; Sun, 08 Mar 2026 16:32:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1772983934;
 b=J4Vqxr+o0MynNO5Hvgd/YEG6HPTpbFNB3QcY0NLRrry+7MKmNnn0zXnISVV4aoQBHk2bM
 bVRmf5oDPvmeBWpQQb4vmUs9SLzqVwyyKTHR6YnsygbBhrrs44Ac2uyHn9d4RrYY13ZqDYq
 FBZ34AHkLq7PsU/A5YLxVBa50rezfPA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1772983934; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gWrD5E8W1w9eaMuNnaC3Yf8/sux57DiErwPjO/HT0HI=;
 b=sQIbylKGM/NU5LTdYu0MBdlIdAdkLscOsA4YI9mr+uKKGrZs605oTtmA8SamLxBOl6c32
 hbZUeWez+O4JAGxALsK8DYrmDCvm5WfiCXeXgmq8z6RUcCNQ2ghp0cubY0Crc6WX+4DriKb
 Drpq7pL2Ee7XZ7ZLJuZ3SJLZd5+FFok=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4785381FCD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 08 Mar 2026 16:31:50 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1772983920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gWrD5E8W1w9eaMuNnaC3Yf8/sux57DiErwPjO/HT0HI=;
	b=S5JBWz+v4fZF/sNU+RGw9Z+aSWHwDmfEkOFS2Kh5RRQmD1hTuf6Osc/f3d+5zS9ZwvdPB/
	Tc6bdQtehNAtE/e2iI4S9eyJM41rEzA40VlxjG4A32AE2xYDlvgsgD4QEk55NaQ8PH+Rpo
	VV7JbPmczqOY/M5RNAoXRdyNfwHsPqE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sZFfSwhG;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1772983920;
	b=UFMBP3H55IPfPD8F7qezx+vtPpMiYfVgek2VWDdxipxmpeZdUdT3QxXQLv1umxUjtzbHoc
	HrBRzdvOIJZnAxoJDZl2WpEK9qjvU3XMdVCf/lBPgdt6S86S7G1Q/QlgHK6a8A7pLRdjVy
	RkVQXHtHsBZO/K/04r56bJ+7ppAs5A4=
Received: by dvalin.narfation.org (Postfix) id A8710211C4;
	Sun, 08 Mar 2026 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1772983909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gWrD5E8W1w9eaMuNnaC3Yf8/sux57DiErwPjO/HT0HI=;
	b=sZFfSwhGdt0l2he4UcRdXZ93Vx393Y0MopgFhgQFlAewvLfLWr9PPtMf2h62Si2BnM9nz5
	FxRn+pZng10TmKAkEJlFiWYFFJ+nmbiZmeSlTNt/NEbM4djPDcGrlZsCWjWWIIzus9jNZd
	mYU0DjhHEKdGZp78oJ7iVebQdYGQg1A=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 08 Mar 2026 16:31:39 +0100
Subject: [PATCH] batctl: Run manpage through tbl preprocessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-manpage-fmt-v1-1-0cb32a726d2a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFuWrWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwML3dzEvIJEoHBabolukrF5ikWaoWFimqm5ElBHQVFqWmYF2LTo2Np
 aAHJ/F8hdAAAA
X-Change-ID: 20260308-manpage-fmt-b37d8f11af57
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=sven@narfation.org;
 h=from:subject:message-id; bh=O4AJIMul+6fDAnP+/HFPZe0uIafRkF43V8j7F+cgVFs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJlrp8Uf7F4a993TKcGG0/dcQcxrxyY+98sf9UKX2K/1C
 fqZEt/XUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiIshQjwyb3/dpanKxCSV+u
 3nhtnx+4+3zX6R2lhxWjG3gTzu1OkGNk2LIntoLn4qxerw3cN+1XtCVwf/YsOHXmw/rw6xO+S/4
 7ww0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LTBDN6A6EBQOSY5EG2R6GQ3RXMZ523KO
X-Message-ID-Hash: LTBDN6A6EBQOSY5EG2R6GQ3RXMZ523KO
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When checking the manpage for errors/warning, it shows the output:

  an.tmac:<standard input>:119: warning: tbl preprocessor failed, or it or soelim was not run; table(s) likely not rendered (TE macro called with TW register undefined)

This can be fixed by instructing the explicit usage of the tbl preprocessor
via the first line in the file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man/batctl.8 b/man/batctl.8
index ccc7b4a..54745da 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -1,3 +1,4 @@
+'\" t
 .\" SPDX-License-Identifier: GPL-2.0
 .\" License-Filename: LICENSES/preferred/GPL-2.0
 .\"                                      Hey, EMACS: -*- nroff -*-
@@ -21,7 +22,7 @@
 .\" Process this file with
 .\" groff -man batctl.8 -Tutf8
 .\" Retrieve format warnings with
-.\" man --warnings batctl.8 > /dev/null
+.\" LC_ALL=C.UTF-8 MANROFFSEQ='' MANWIDTH=80 man --warnings -E UTF-8  -l -Tutf8 -Z batctl.8 >/dev/null
 .\" --------------------------------------------------------------------------
 .ad l
 .SH NAME

---
base-commit: 8d256ac07c7dada8607ae792dcd0524d91eef127
change-id: 20260308-manpage-fmt-b37d8f11af57

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

