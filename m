Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA2EE77197
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 16:21:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E4EF68426B
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 17:21:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736266863;
 b=wOA0UevFwDytcRNwoZ0BgLAoQgrpnTz9L5RqD50nW+zaSy9poyomOE87fT42uMtuo+ivJ
 HXZOTIZAHcaoO7Rp5Mj5Aw7qWvIlgTvPEbwo4xoFon8262qH9fCu0MNYJhBhDZRV4F1axMp
 3CqlusW1/PxSPj+7ZL11NaErhlXYwbs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736266863; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HhSfowoJbn2UDFfjDy2IrTiUIhzCFYmcAyLZZd/DryY=;
 b=kDVyqh/63v3E6GP9f2AwbKdUKBJkJ0nOuebKaMjXJkmSMrCIRoGQKy/EhFlO92+B4sOxG
 Cgv23rbXY0GxORgX4P9LeM+p8+NkBkL1zuJdcKCZp9Vz8r66mheWrAjxfqZUlcMhq31acji
 +vCSFy7xOerUmOX19S3nv8fog3V8ZvQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 43657840C0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 17:19:06 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736266746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=HhSfowoJbn2UDFfjDy2IrTiUIhzCFYmcAyLZZd/DryY=;
	b=K0djb9zSYR0+Xs0IflYXI5SITc6k2th1c2sGx6qZ7+5pUD33O26iTjfNGIYUCMlOmKcH1Q
	KRrt4jK4GFDXQb/liW0ES59RkLj2mxUzVlCZ3eMkAszlzZPjgqIz+mNmgzz0ydvkTEIDgL
	3OZPcaIyo6ZW2AO7YIm0qZLMHNugsDw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TJcrxJE2;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736266746; a=rsa-sha256;
	cv=none;
	b=3fbFE9DOJzv+Pzv5ing4DY9/V5Wx0Mm9IfTzEewksPylFLcCDLVPNg1H72UWrLQ7K7+tq9
	8h81KZKk0v/HDjmq5pXZW9TXCv91TjRBe5xUTNoa8n74wMfG7Cf6mBXiNGn3KG0qHSvRg9
	I6Ubx9wszkwz1KyZXH1v2fONqo9MjHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736266745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HhSfowoJbn2UDFfjDy2IrTiUIhzCFYmcAyLZZd/DryY=;
	b=TJcrxJE20zuGnn26gQdnq9k2zS5Ey/vvSJV25hXVvAo/CwYXrhuo6Ea2QTBreeyMZSit+E
	xDRmAJpno9IsTB8lYOYwBBYkzsjrOXYs51m3jvUDiWzuBTAd+Bo6ZhAz6LXgIwnONOX+OR
	r5JLwWJmNmLcLSyfrCi48Z+h/CQYkko=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jan 2025 17:19:02 +0100
Subject: [PATCH v2] batctl: Use mailmap to fix old e-mail addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250107-mailmap-v2-1-92614cd6085a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAPVTfWcC/z2NwQrCMBBEf6Xs2chuamz05H+Ih01N2oBpyqYUo
 fTfDYIypwfzZjYoXqIvcG02EL/GEvNUQR8a6EeeBq/iszJo1AYJO5U4vhLPivvzBS0xWrRQ27P
 4EN/fpfujcpCc1DKK559/It3S319J1RBrh6YzrXO3iSXwUv+PWQbY9w8oq+icnAAAAA==
X-Change-ID: 20250107-mailmap-ac69081a0808
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3194; i=sven@narfation.org;
 h=from:subject:message-id; bh=r4gcez5lc5E80X24JjSSxONbcX/jcVnOHCeANc6dHHo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOm1wd+nN9/mPCslcTbpgOwyl8TlHPmBH1sd9hy6lCK/p
 PxS5QqmjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE5tczMqw7tuzIiYYa1+9v
 PnDvL16T/3QaCw/zxwZlt6l8S96y3uxk+CsUWJaStSf6gE7Wwyw/ydYIjeMtS04/dhNzignb43f
 xPwsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: H7ZSPKBCU7NKPV6X4YD3EYVLNBXEEXN6
X-Message-ID-Hash: H7ZSPKBCU7NKPV6X4YD3EYVLNBXEEXN6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H7ZSPKBCU7NKPV6X4YD3EYVLNBXEEXN6/>
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
Changes in v2:
- Switched to Antonio's preferred e-mail address
- Link to v1: https://lore.kernel.org/r/20241231-mailmap-v1-1-11a2b05753bb@narfation.org
---
 .mailmap | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000000000000000000000000000000000000..efba32e631ecefb900a3bc175390ee8aeafdd341
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,37 @@
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
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@acsom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <ll@simonwunderlich.de>
+Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
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

