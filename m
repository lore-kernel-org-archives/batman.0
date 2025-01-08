Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAECE77188
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 14:05:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4357F84308
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 15:05:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736345135;
 b=vBlPjjFbps7aqhRwNt/Tde5p46BZ9W3w/dTtLqSWLRL+PFrPutvnKpI4+TOugfvN+TeW0
 d8OgQZZuGmobiYOhwzzCL9Z56uKnRuQcr3rAzjdbyXQbdiWB7xfJoYD3boDWXkmDVrI5eT4
 ZTAzICYEvUH8weMXLUbIO4kAgK2x5Kk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736345135; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dmU8xnyTPrTdKQUcZHPIGWIYWt9cKCgJ87YSH5qmNHc=;
 b=bm24YVr5HmYnIQCe7fUGhMG2Z8TOhTHL+wO3tWc9FkLzxJxG9wljDV1J18Pg6+Bt+w7Pc
 Eo9R7Xh4SB2WFbDU4I9LQRjC3rhTSYCGUN6yW0JNkOnaieOBHJ5shJjJG/H8ZzcK0qhF94T
 PTIETov6Gjk8fyMfJQCRSoQ53X+hszA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0697D84107
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  8 Jan 2025 15:04:21 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736345062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dmU8xnyTPrTdKQUcZHPIGWIYWt9cKCgJ87YSH5qmNHc=;
	b=tZnodXJZHF2Y2mLG0GVaZikOUed8Ui3BCZZb4KzuGvMpz+fmGo770Ycg19nUAteiguxIog
	YaedbXj5dJCExMfKDOjpzQMb8Qrkw99b6hpyupoyNdvJd6M/tUbZt8XwiVflpnOyyBpxL/
	id6+uPStgN9lsf6tNpCz0tUtA2BsUJE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=juKU6F2M;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736345062; a=rsa-sha256;
	cv=none;
	b=gOg6xVsfRD9mHHyfS7WIPHnqukiZESRcPJ/IMwpXyfKgPYPAPXHPGI0/9LVvQBCrlmx2tA
	lN18oWJQUWtJdGGGvoz0koa1H8U/FXTV3b0fV6oNl81xd1J9CFVwr8BeIxY32r2rSWBpVT
	rq4IgLpdUt+HsOhyORXemL+Lotxw0mc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736345061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dmU8xnyTPrTdKQUcZHPIGWIYWt9cKCgJ87YSH5qmNHc=;
	b=juKU6F2MVJc35y7CfwK2zpF2V0jPnNBfeKqVKmuzmro17NCIV9CNQcYHBgO5Kx+JPHu6XN
	+A8UPdRWa/XLn/qowcYVYZt6vqsqJLKPqB92pwIuGb0NNEUAZdxMqG3UfoOPMWeyEeuYm1
	MlHc0uW5YT+O3DJR0NPF1j2f3uwFw08=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jan 2025 15:04:08 +0100
Subject: [PATCH v3] batctl: Use mailmap to fix old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250108-mailmap-v3-1-3fbfdf276e21@narfation.org>
X-B4-Tracking: v=1; b=H4sIANeFfmcC/2WOQQqDMBBFryJZN2USjUZXvUdxMWrUQDUykdAi3
 r1RaBcts3ow//2/MW/IGs+qZGNkgvXWzRHSS8LaEefBcNtFZhKkAgEFn9A+Jlw4tnkJWiBo0Cx
 +L2R6+zxN9zpyT27i60gGP/lMyFR880HweAJlA6pQadPcZqQe19h/dTQcytH61dHr3BbkIf6fE
 WTUlDIXWdvloBX+aOp9398IFl+A5QAAAA==
X-Change-ID: 20250107-mailmap-ac69081a0808
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=sven@narfation.org;
 h=from:subject:message-id; bh=mfLDKOyoKBOI6ojKy2sMvPKzoT1ZueeuW4j1WSxjfbw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOl1rY8CVTaYBireXCL4Jmz1WxaNMv1lra2Jd7mflu5ZL
 PHXZJV6RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiCecZ/sffy9KpOjZTv2EH
 2/w7hw33BmZxqdc/2JOrY6jwfEML00FGho9R79fpyLeuvLHVUCLlJIMbv6232Wuz96tknxuJTVq
 zghsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PHKFJWYKJSKTSEQW7ORMK4SOZMCH64LU
X-Message-ID-Hash: PHKFJWYKJSKTSEQW7ORMK4SOZMCH64LU
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PHKFJWYKJSKTSEQW7ORMK4SOZMCH64LU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The .mailmap is used by git-(short)log to fix some botchered names and to
map contributions from old e-mail addresses to new ones. It is also used by
some tools to get the correct e-mail address for reviewers based on old
contributions.

The list was generated using old e-mail address changes in the source code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v3:
- Drop duplicated mail mapping for linus.luessing@web.de
- Link to v2: https://lore.kernel.org/r/20250107-mailmap-v2-1-92614cd6085a@narfation.org
Changes in v2:
- Switched to Antonio's preferred e-mail address
- Link to v1: https://lore.kernel.org/r/20241231-mailmap-v1-1-11a2b05753bb@narfation.org
---
 .mailmap | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..612218661f1ceb003d64a5bd55b2f272ab5c07b4
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,35 @@
+#
+# This list is used by git-shortlog to fix a few botched name translations
+# in the git archive, either because the author's full name was messed up
+# and/or not always written the same way, making contributions from the
+# same person appearing not to be so or badly displayed. Also allows for
+# old email addresses to map to new email addresses.
+#
+# For format details, see "man gitmailmap" or "MAPPING AUTHORS" in
+# "man git-shortlog" on older systems.
+#
+# Please keep this list dictionary sorted.
+#
+Andreas Langer <an.langer@gmx.de> <a.langer@q-dsl.de>
+Andreas Langer <an.langer@gmx.de> <an.langer at gmx.de>
+Andrew Lunn <andrew@lunn.ch> <andrew.lunn@ascom.ch>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@meshcoding.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
+Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
+Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
+Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <ll@simonwunderlich.de>
+Marek Lindner <marek.lindner@mailbox.org> <lindner_marek@yahoo.de>
+Marek Lindner <marek.lindner@mailbox.org> <mareklindner@neomailbox.ch>
+Simon Wunderlich <sw@simonwunderlich.de> <simon@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@s2003.tu-chemnitz.de>
+Simon Wunderlich <sw@simonwunderlich.de> <siwu@hrz.tu-chemnitz.de>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@gmx.de>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@open-mesh.com>
+Sven Eckelmann <sven@narfation.org> <sven.eckelmann@openmesh.com>
+Sven Eckelmann <sven@narfation.org> <sven@open-mesh.com>

---
base-commit: 4ebe4fb7b08d795f8f7544c04e1bfb928ece5000
change-id: 20250107-mailmap-ac69081a0808

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

