Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67C0C5516D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:48:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 840DC81233
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:48:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498489;
 b=DHGZpIKEx3qoUVAw5a27MF7xwxQ9hiiGggXS8LtYQ9ZjNevCF5L4w+p1+o6Sefdr2ieiu
 6AAzbeZndpY82oTRjCJFdvN0cjfcLt7oK4fibhKmLh2YGoEngqPfaOoYi2zkiSD9i4OlHUM
 MwpdWRAHRSAolfHkuYMxqN5PLFL7JVE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498489; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tXhVZuoSeEXLQj4UEUlx2qDd3zVZRq9gBcmyJclpj9k=;
 b=4SCTrUnpphSDILuXGdhElWqgtjXnJmaUNW6fO3dJLoRC8hU46kZr1qC+IRiPrOW357/QW
 WCgpyGeNzJZliAopK1FvhOwGoZEZndhTQYWnB5lw+bwbmEBcu1/K3qLa8RxAZj1V7pGmz9k
 SvXbn+viaUf/VtZP55cbvnACP2IvXho=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7FB1583FE0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:46:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498367;
	b=u9evDAiHrbM95rckr4+xNf5ytyasE+MU7/WWNGk/bobesqGOkWZVuclSLZteBcd++DSLqa
	b8J3k5B7GdOnLBRrePsMfwyZF6puwx228I1b9o7eulaptTvwp+F2+1zRhw77z2f/lUJSEV
	uC71H8O0fF11XVRgLdAAgsM+4jqPsZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tXhVZuoSeEXLQj4UEUlx2qDd3zVZRq9gBcmyJclpj9k=;
	b=a6KBSeL1q+Efi00XHfyqb7fnm7PfK8vXKmn16D8Y4igylq1HprkN2dTm/IU1dRSyJ52rq/
	oaO7JnQid9PvCSDlpmXRWcWdJW4MwzDgEbTrPqts1CtAF2J/3B/n/2/Jy5VBMeDEWk9XGp
	oWQ3CLEWsVTHUMKRT7nIN4CHVFDuCOQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mx1cIY2n;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 130961FD3C;
	Fri, 31 Jul 2026 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXhVZuoSeEXLQj4UEUlx2qDd3zVZRq9gBcmyJclpj9k=;
	b=mx1cIY2nY+o0u3RXMSyYXgG0r9zuhGg1zdQ11BAOhcs+KYBZ42CMXBjptOU75ChlLmowPF
	Ub5bHBco9Ry4U+hWzHJ/1TgASP8lIhpjvcQEmd5qvYCShAcxlxR4fY9IM5M8uhykdyo/pA
	5lOx8T1zd+PBKk26OI9qqcKgXjbTn2M=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 13:44:54 +0200
Subject: [PATCH 5/6] alfred: Report failure when the client refuses to
 change interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-interfaces-v1-5-a148ca2f6688@narfation.org>
References: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
In-Reply-To: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=sven@narfation.org;
 h=from:subject:message-id; bh=/WM662LJcl0S3P2I5MAO3vyOOxhEYZSdFwk/GRjE144=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZs/h/CrzCuOvct6L/hhW3mLX2AG+2M2zjevXt221
 NyVy7eto5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRTdMZGR48FJnXt0L/19Pi
 e46KSoc6p8TenWPsHBPa8b2bwzrtxxdGhqWhordX7WH60zBZ16I1zPH64i4Rlaj4SR4Z9ypNqvN
 ZGQE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 65NOUTLMIJE462R4THOWR4YPAR7INXNP
X-Message-ID-Hash: 65NOUTLMIJE462R4THOWR4YPAR7INXNP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/65NOUTLMIJE462R4THOWR4YPAR7INXNP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

alfred_client_change_interface() and alfred_client_change_bat_iface() open
the connection to the daemon and then an interface that fails the local
checks printed a warning but returned 0. That reported success to the
caller even though nothing was changed and left the connected unix socket
open.

Close the socket and return -1 on these paths so the exit status
reflects that the requested change was rejected.

Fixes: babd772a36e1 ("alfred: support for changing interfaces")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 client.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/client.c b/client.c
index f56042a..d25e3bb 100644
--- a/client.c
+++ b/client.c
@@ -265,7 +265,8 @@ int alfred_client_change_interface(struct globals *globals)
 	if (interface_len >= sizeof(change_interface.ifaces)) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
-		return 0;
+		unix_sock_close(globals);
+		return -1;
 	}
 
 	len = sizeof(change_interface);
@@ -286,8 +287,10 @@ int alfred_client_change_interface(struct globals *globals)
 		input = NULL;
 
 		ret = check_interface(token);
-		if (ret < 0)
-			return 0;
+		if (ret < 0) {
+			unix_sock_close(globals);
+			return -1;
+		}
 	}
 
 	ret = write(globals->unix_sock, &change_interface, len);
@@ -314,7 +317,8 @@ int alfred_client_change_bat_iface(struct globals *globals)
 	if (interface_len >= sizeof(change_bat_iface.bat_iface)) {
 		fprintf(stderr, "%s: batman-adv interface name list too long, not changing\n",
 			__func__);
-		return 0;
+		unix_sock_close(globals);
+		return -1;
 	}
 
 	len = sizeof(change_bat_iface);

-- 
2.47.3

