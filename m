Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30A6C004D4
	for <batman@archiver.kernel.org>; Sat, 21 Jan 2023 18:19:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 13D70840D3
	for <batman@archiver.kernel.org>; Sat, 21 Jan 2023 19:19:52 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 32378807DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 21 Jan 2023 19:19:24 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1674325164; a=rsa-sha256;
	cv=none;
	b=MCFZaYTQmeuv0GcaCmJY2YJhQel1fEbDJwgzXsKk5zQA6cJKAs5vRKFlW1l3n2u0vVPtIb
	SQddMWnEvw3ADpKfIMEYMMsSfuJTMZ+c3On1H3JW+42MCjljOkb8pv4cLuyg1tvKdD6os2
	ApgUQypyXo5GlNPSUEblFByK14AdfNc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MMDX4gif;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674325164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Mf+C4T94XwW7eb+p78rkjRzTOwwGyHCLYK6XJplEZCc=;
	b=y9saOiQyhptDWtMZ6In33wgxZWqeNrOUhVU4t4sBodokQUBVdF49BUjv3h8FhK52RJ+1hb
	JhEPEYfQV0NJ0YEW+g5iZIqCWx6VTlKpjkyBVIB0cfBB9eTfLSgmYbdlmUJIk4hqlQS1n+
	oWI6cDXohCQ2gAVOvRxQgTQ4cNmt4Yg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1674325163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mf+C4T94XwW7eb+p78rkjRzTOwwGyHCLYK6XJplEZCc=;
	b=MMDX4gifKuqXcWLNOho2Xk7xJ/yA4tG2Rs8xjCzmF3j8oWuXQnzqcCyHzCqJf9IjmZMukE
	BMIiv52qydGoJ1qEJABnGow1oSoGN0uLOW5SFuRAQ1JkCCItBhRhzPeA54v7yPRyhTKAsS
	j5AosYuuMECk6/xiVTCeMr8U0gjwWRM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Jan 2023 19:19:05 +0100
Subject: [PATCH] batman-adv: Fix mailing list address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230121-mailinglist-v1-1-6e7f164ca599@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJgszGMC/x2NQQqAMAwEvyI5W2grSvEr4qGtUQMapRERxL9bP
 c6ww94gmAgF2uKGhCcJbZzBlAXE2fOEiobMYLWttLFGrZ4W4mkhOVQ9VrVzqJ2LDeQieEEVkuc
 4f02e8qf3hCNd/0nXP88LoLQroXQAAAA=
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=sven@narfation.org;
 h=from:subject:message-id; bh=cRRaYOLOTFpUT2zFp7KFXCaVH5NoCuVV4ekrjElkZu8=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBjzCynpz8JGpr6KpjuEHMkIEctDxhnW/9MZtvy/asW
 RH3G0fiJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCY8wspwAKCRBdhwoHwSZ7Rjo+EA
 CJosaAmu0CLK6r/Q4B3h1nJvsOpvsWyXzXD6IvM8rLTpYCsrcaSwnYArTl7oO9BqaBu3Y7yHRSSXI3
 K5V+8D2e6uFrcnheHtRfcLfzjSulUkcYOCrrMYohIz8+W9b8ppl9vvtz5T1oYuKVMm+U5Dhg0/VdaP
 DdkRwg685CdmMP6ahf8KYgmIWDdXON/W1KkJYqoVbh3pr1uYjbHF2GjGXLoW0LYcKLJbLAE2EH5ey5
 CChpXMpO2rKvmAPKlPEwwH+puAAE9sJnFDaOvG8p6QHnpVWzquFflu2HzhF0xOMCyIF+Zm4Y7e8DeU
 PEpYixk+PMxeHSm9dpqM4QYRl8vsNHKzO47Y6piuZC+CIqa4hGdEn0JskgR474TAtsf6YEzCJOQPpD
 ItLspf13yJ7bEWxvkDdX7OIGice3SZ1KvKATpLkBFs3sdd+6jiPY53vhu7Ke+iFdMFztTS90sW6Rt5
 5derxs5Bgt1iFt1nj7wfZDh958lnCXZiN/AhGuNfgPf4fmJNf7jPGT/c8eg0l90BKY02vFd0YED6z9
 UnO+19aJ3KVuAOg5dPjkRdlXLNqA4oNpmWwYtduti3nB17W4bV7F/xGMVFgwNpBVCmCyYislx+B9fL
 89g5ManeTbdLEzuJWEOyh4kWkRzpiqocpsu2PIX8teHgC6JGrWeAOtLcztgg==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MFUDLR7JJELKW76JSJ3WIMJXQNSC4JLL
X-Message-ID-Hash: MFUDLR7JJELKW76JSJ3WIMJXQNSC4JLL
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MFUDLR7JJELKW76JSJ3WIMJXQNSC4JLL/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Fixes: d83571147325 ("add some README to describe the usage")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index b85563ea..8a0dcb18 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -159,7 +159,7 @@ Please send us comments, experiences, questions, anything :)
 IRC:
   #batadv on ircs://irc.hackint.org/
 Mailing-list:
-  b.a.t.m.a.n@open-mesh.org (optional subscription at
+  b.a.t.m.a.n@lists.open-mesh.org (optional subscription at
   https://lists.open-mesh.org/mailman3/postorius/lists/b.a.t.m.a.n.lists.open-mesh.org/)
 
 You can also contact the Authors:

---
base-commit: d364e8168b28b345f39c3f77526a2d71a28c282e
change-id: 20230121-mailinglist-5f3588e088c6

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
