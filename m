Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F943C5516E
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:35:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8A983816BA
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:35:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785440102;
 b=MLFPV4yJ7G2966J5+MxIMSNi0/Egk6dO8T3RTguEc49tR0GF4AZdg6QEOAdVZSatiQCOA
 P64akx9PT6v4etL/3GoeE/WwGVWJDRbfM42+n5FMghsA5+CPYuviyCtk84E13+doF72qg8x
 Y6pxkd6dUsy+SDqqWWaOL4XvrS+qn9U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785440102; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7cT7IDQAVuL5WRpZRRWLdjSOIJ5FiVq+xIAnh3kplHk=;
 b=WpYcKezEfD7sB7YQ0Jf0mMSGNWnhGuagaL4ssldT6hLiBvcCVouCXvApmgh6yDnfJamfU
 2a2mJDgEe2ozbU8/s0dw4SAFsZm3xKk42NNbmh/QnDS8iBkr0H8dG9AZHHxts9Tf01kD2FD
 FwTYWbUFCZRTJQuq/sExZwIoPAmaY8A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D4668806CB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:34:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785440046;
	b=SQh6SQ8DDtLAz6RP3cnG4Lvrr738pCXGo+2JA7OXo6R9vilMiT8gFt2Ra0y9vHUJGV5nWS
	rskX06bPK6t8IwrnyKoDj6zoF+T2janTo0AZ2LHHHJpllu5VBOepYg0VC1IPeqrMmcWDWX
	20fNM1Etoz/romUx53N6srqqFrUa0dw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785440046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7cT7IDQAVuL5WRpZRRWLdjSOIJ5FiVq+xIAnh3kplHk=;
	b=S7PwY6i9Pea/u5o5cCfW0pKlCafKwJ6rZ8Fep2KW4Y6APZHpayhn3rCY2RI3O/2UBFktyR
	3B3x6aj1YyGjgeKxiWav9zUQJqu2o8Xte+cKzeG3nkwBwrS0ESZh5gPGNoIdiQTLRXa+T8
	R4gFrnDFSpVDUjxAYDJzdUS1dDK6QjI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="1pk/CENt";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6DCDF20CBF;
	Thu, 30 Jul 2026 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785440042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cT7IDQAVuL5WRpZRRWLdjSOIJ5FiVq+xIAnh3kplHk=;
	b=1pk/CENtNCtPdOTriwQ51JwvwprZX+tjIPTy0KXCI63FkWIFM/ek4czmmebvmOmuwvUs8S
	WUBlFU9k8fUlbFp+yInrXilVYxqmVvN9RWslwFmAThlP369vgIIPyYlFadVp41l49+w9fQ
	T3qKhZXtB2MSID0Fm/pOlbWoPoDJwYA=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:31:59 +0200
Subject: [PATCH 5/6] alfred: reject too long unix socket paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-parsing-v1-5-c0f2ce4764bd@narfation.org>
References: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
In-Reply-To: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=sven@narfation.org;
 h=from:subject:message-id; bh=MdCkfI3vLb82wk+Jj5Q4ko4SkviNV/SeIYiWpceInSs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9Z673y3KmC/4dqqc+nL77BLld25y5exfJfovAVzb
 0urvl0o0lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiFYZwz9rv/xzJZHOXAG3
 YzKyDsnu/+O2dc2BuTFe4tXcT0K2vfrJyNBwQ1pn09Oaaq6tX56Kdqk1v8isNLr8fUs6V78lj9c
 MP14A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DXNUKMMGPBF3LDCYKSB5VR6AQXVHKXSW
X-Message-ID-Hash: DXNUKMMGPBF3LDCYKSB5VR6AQXVHKXSW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DXNUKMMGPBF3LDCYKSB5VR6AQXVHKXSW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The unix socket path needs to be stored in sockaddr_un::sun_path. But
strncpy() is silently truncating the string when the target buffer is too
small.

Reject such paths with a clear error message.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unix_sock.c b/unix_sock.c
index e6b44da..99c2538 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -35,6 +35,11 @@ int unix_sock_open_daemon(struct globals *globals)
 	struct sockaddr_un addr;
 	struct epoll_event ev;
 
+	if (strlen(globals->unix_path) >= sizeof(addr.sun_path)) {
+		fprintf(stderr, "unix socket path too long\n");
+		return -1;
+	}
+
 	unlink(globals->unix_path);
 
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
@@ -76,6 +81,11 @@ int unix_sock_open_client(struct globals *globals)
 {
 	struct sockaddr_un addr;
 
+	if (strlen(globals->unix_path) >= sizeof(addr.sun_path)) {
+		fprintf(stderr, "unix socket path too long\n");
+		return -1;
+	}
+
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
 		perror("can't create unix socket");

-- 
2.47.3

