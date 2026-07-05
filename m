Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91389C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 12:56:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3453B84552
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 14:56:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783256191;
 b=bHX1w1UNNnzkj59KVBAlSRFxgEmvW2iqGywxrwBDaClrWgBlZ/qWSVfP19dhpGV70+m1V
 pIfcVx+xM39uwybGACqB3qwp/euB7/lO0IDzeHM5XwH8avkedPdaMR14KaG17ZYL5eX1NFW
 ugnCT8bxYeDg0FPB3F0KvWTUjrMlqYM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783256191; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=38YjiZlk0OvT529zy6dg7WYO7YZlAykl/ntOgYDl9F0=;
 b=d3V/du5PwRJNtF3jajVxT+BVqueFelRuY3Pe9Carv9jlkG0hPwTUg8LWx0hYQdPbsKn4b
 qcVtE7Tp/oMyPK75PE7gQENkrB60V4PYJm87GSapQjHIL9GOI9KPQUQlDC55D2BJAchYTVg
 dv83ercUmXVpnZ29u1BzkeA0syu8is4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2615A84005
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 14:55:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783256127;
	b=ZjQDSecZeTgEcH240c3mVmeLCuE3arcIu6xjxVTLFhe9sClvkHstYZOI1Z8T2wTTm3iOl6
	p0NTM5PAMf+gSQCc+OUvLsiDdSl/7LpYCp5yb54Wnw4O53WjppHbfQU4l0YPRr9YS4oEI+
	nlvC9BxT7VYIBGTb4FmirXuEwYfQkFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783256127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=38YjiZlk0OvT529zy6dg7WYO7YZlAykl/ntOgYDl9F0=;
	b=wDYkt0+un9MjZb+avhzsyDZic/KPcXr0sp2Yp4pdc74qkGyXLQoqrgwbi/0mvQamWG+XVs
	iuHeRfKVIZhq9Cn/VL5Q9lcLPBvRV5hrrbBlz6DLoH7wkmSmofggGYyhVLO18ZEYl+vcE3
	ck7CIGZTfiGIvftkQObOZYCs+xWGWzI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UAZy+98n;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DACD4201CF;
	Sun, 05 Jul 2026 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783256126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38YjiZlk0OvT529zy6dg7WYO7YZlAykl/ntOgYDl9F0=;
	b=UAZy+98nD5Ryi0de/eDhkbvhyCwnDsVR/Uu8uFyTISAae95o+czGgzVXztZKrTdrxFMLe1
	d4JThNi8P5Aq/wun7mAoyaem+e+BP/Y3lIJr4h7kNQSV0UetZS1i4VcLRvkFc2ZtZ6kl5J
	Ort+LikGVoN8GncelgtRGroPCJ+xaBI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 14:55:06 +0200
Subject: [PATCH 1/3] batctl: only mark file read successful on read line
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-version-v1-1-5f02046c7eea@narfation.org>
References: <20260705-bugfixes-version-v1-0-5f02046c7eea@narfation.org>
In-Reply-To: <20260705-bugfixes-version-v1-0-5f02046c7eea@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=sven@narfation.org;
 h=from:subject:message-id; bh=qByKRC0ggOxM9FtkpwFd3MB3Gvh1Chs5eTpnrz3PmX8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleIXrXnESiMj2Xumf2/TZX6925aV7odEdLg9bE5a/6J
 n///yS6o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARrw5GhtsTr/guLWEytDu6
 fMenxpnF9YmpT6/q3CoNalcpUKvqk2X4K5enF7uuP/fkJW2VTI6S9SIpdmttwt/tfeb6JS53z5y
 PzAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OPYZMWMXHLXSIPJTP3Q7TOX6YK3XXIOK
X-Message-ID-Hash: OPYZMWMXHLXSIPJTP3Q7TOX6YK3XXIOK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OPYZMWMXHLXSIPJTP3Q7TOX6YK3XXIOK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The line_ptr is shared globally. It can happen that another function like
parse_hosts_file() allocated the buffer successfully. But the next
getline() in read_file() fails - but keeps the line_ptr valid. In this
case, the function would return a success - even when the buffer contains
stale data.

Instead only set the return value to EXIT_SUCCESS when a single line could
be read.

Fixes: deb324e65044 ("batctl: buffer based reading replaced by line-by-line reading")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/functions.c b/functions.c
index 00dbd3d..349569d 100644
--- a/functions.c
+++ b/functions.c
@@ -147,6 +147,8 @@ int read_file(const char *full_path, int read_opt)
 	}
 
 	while (getline(&line_ptr, &len, fp) != -1) {
+		res = EXIT_SUCCESS;
+
 		/* the buffer will be handled elsewhere */
 		if (read_opt & USE_READ_BUFF)
 			break;
@@ -154,9 +156,6 @@ int read_file(const char *full_path, int read_opt)
 		printf("%s", line_ptr);
 	}
 
-	if (line_ptr)
-		res = EXIT_SUCCESS;
-
 	fclose(fp);
 	return res;
 }

-- 
2.47.3

