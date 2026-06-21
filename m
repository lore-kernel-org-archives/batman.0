Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14741CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:39:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B075384694
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:39:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052768;
 b=2RRPgwx/+ChONIXruq+Xp/GFqLyW1/NpNA1dWnqEAaLZAFGBXd0NOvV7EpmV46RbWQHcb
 VT4/aBTJBk7zmF1q0MiNGBx8j7oB4lyPk7c7vjGFskxTBjZvge253O6YJbk+g5jUlZ6SR+u
 xWbJktvOTi3MhSd0mnVW4mhN/D+0sG4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052768; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1WJ7faYQ+LkVtycnMyAFriNfa/axPtfLZMHfa9MTSy0=;
 b=gOFsdSe2mZbDHWvuNE1cfph2Xc3eEu+1fDdgGQ3a4J+kawCkT/VVjaHGPsJ9N5ext9x8j
 qanF3M93uTQMqWJKs7d+Ft+pV3OGpPUEhp5f/Qgduzxbd0/i/bwY9j02pu40gnUlWZM0bIR
 25COgU002ArpE+2jSgyX6YqPvPfjFdw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0FAAA84241
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051943;
	b=ZEXYPBls8AksgBckzkeDU/Yaz2CUkaUoYcpqZsFBr4smxmhLACXYK7v/unlItzt8xjHdsm
	3jdY4gNcp6jX6+FTYfFtW6cZF7l0CMdZsp6AtpBUntM0fwNbh+GCVsaJxcIonLI197j8yw
	j/M1s9t50iGgNMOrR3JBIKugHv4TgKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1WJ7faYQ+LkVtycnMyAFriNfa/axPtfLZMHfa9MTSy0=;
	b=JxqUWGCWRIyhIhwdecNMmfiuRsjLfsxg80YVPPQ9JQAuc163KsXY+PwtA9tNrHQOyYYoRN
	xPfWh3d1z8WGIHpWt0TyAOOqhP1chp157jYidjk9ZX/CVC1GgZ2Tkz/+/Momb7ibQq9vmW
	f3sp4G10qQJp44TlpA6VazSFkrog208=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SNU8IWjz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BB9C720131;
	Sun, 21 Jun 2026 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WJ7faYQ+LkVtycnMyAFriNfa/axPtfLZMHfa9MTSy0=;
	b=SNU8IWjzP+/+VXi2GjREHB4qCR8QjhtAbQB9jkGMDkYQ2jCrTN2y9l/maiKTYUkC7PT/Bt
	q1beBYRR79rDsiIBj1N418sPslxTDCrtRFEKrimn8wi5nxEwBjIq+eX52GuhWmttB+etRc
	fLNDCpoj/R8AKMkShy4oEzXrdcMr3/o=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:10 +0200
Subject: [PATCH 20/28] batctl: version: don't strip newline for empty
 buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-20-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=sven@narfation.org;
 h=from:subject:message-id; bh=37TTFUPZHMXd1rizsEv3RjYdk+V44TWCmHhyGGbTlxI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9hPrbKeXG7+8Mf7mimeu1bd2pJSquHNyLpJt1FIv
 iBjmi9PRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi5T8Z/pn7LVOaZn1C6uKS
 TdF/DjW3ydWLbzW4Y+OpvHP5tkq3vl0Mf/g2pnrvnn/shVHXpNViF5rZMnnfX9ALlStM3cYxfUf
 iR0YA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZHRG5GL22TI75PFHXCMT4K5E223WKWG5
X-Message-ID-Hash: ZHRG5GL22TI75PFHXCMT4K5E223WKWG5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZHRG5GL22TI75PFHXCMT4K5E223WKWG5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When read_file() would return an empty buffer, then version() must not
strip the last byte. Otherwise it would try to access 1 byte before the
start of the buffer.

Fixes: dbc4a8c8e585 ("batctl: version also prints the kernel module version if available")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 79ed4ef..94db4a1 100644
--- a/main.c
+++ b/main.c
@@ -132,7 +132,7 @@ static void version(void)
 	printf("batctl %s [batman-adv: ", SOURCE_VERSION);
 
 	ret = read_file(module_ver_path, USE_READ_BUFF | SILENCE_ERRORS);
-	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
+	if (line_ptr && strlen(line_ptr) > 0 && line_ptr[strlen(line_ptr) - 1] == '\n')
 		line_ptr[strlen(line_ptr) - 1] = '\0';
 
 	if (ret == EXIT_SUCCESS)

-- 
2.47.3

