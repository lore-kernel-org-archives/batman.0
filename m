Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C071C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 12:57:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AF0F384718
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 14:57:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783256241;
 b=z8v29lTBdaFnmOdLHwXhfL6pSW6bGd5eJZ7jJitPg8EsQGPYS2Klgg8wwGJEYePFqeGCI
 i32DGRdXR2UZ9em3NwL0YhuHHmugvRg8vLdDXqKXWKbROA5ATQ+n6uZBPa4DN6uCFY/rPMV
 +SbFNYNta3OK3924poR574dsloVPkPM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783256241; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zA+r67xjDk1CAsCZYshekOWjm1sihjlP5iFC68AhrQQ=;
 b=YOmRR3VPHvKJz2irOcHb+8QU5dHFvqCDVa4jD/3wbunJElkg07crNSOLAVyeBwWwb2ly+
 pFBHvz4v7bqDc1aqaxWo8coBeOFraLom3fqCp6tt6au7598IAOJoaADD7f1zW97daVXJgC6
 hITEIPwHiXYsa4eF3ZD3HKEYwSZ5z+g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9A9BF84189
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 14:55:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783256132;
	b=JJIaKiZbW5xBdsNmcsJmogjkNTns4jH6/v5ZXwWDDKvWGPKbwUvlxgRm9ljBb4NZhbNGpB
	+8h1mg5waicnPDyInX0/1vmb7ss2w+tANQGGp5iBccUWeEYB+17hvkggjZ9xC9C2wfEqPz
	taadoGokOQZVFTPI2/XOTD9IHZ1i7R0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783256132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zA+r67xjDk1CAsCZYshekOWjm1sihjlP5iFC68AhrQQ=;
	b=f3GmkIloP2Tiyca02raJxz/bRGg3Fk5uRwgc6xv7fRiYRU5zAHH8XFdkNkQVuUojbCmU0o
	InnoZwDIbCbYEMoBGr3mE+VVCiVKLNX2hoINWn8ovHaoOFm9aNIcw6y8PrGaR7+CvP72KF
	MNvSYLNv6/ENup4BxC+YOhuaZVFGEVw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=jRZSXpd3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3DA47201CF;
	Sun, 05 Jul 2026 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783256132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zA+r67xjDk1CAsCZYshekOWjm1sihjlP5iFC68AhrQQ=;
	b=jRZSXpd3j+FJd+ua4fAC2fLvMUMSOjwI1BZt7XJJUq16RdA2K1Sh8oD9qDY4BGKVdvEx5D
	Nia8Wd8MUbTKBL97/iwfBDJSiGcNsIsR2LPSeWzOk9Ed6gPAu5U9FTnBNnqGmY5Eabtaaj
	Sf9KXW5CIEF5dj3rs3T9dZrpcmElxBc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 14:55:07 +0200
Subject: [PATCH 2/3] batctl: version: avoid use of uninitialized read
 buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-version-v1-2-5f02046c7eea@narfation.org>
References: <20260705-bugfixes-version-v1-0-5f02046c7eea@narfation.org>
In-Reply-To: <20260705-bugfixes-version-v1-0-5f02046c7eea@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=sven@narfation.org;
 h=from:subject:message-id; bh=zeKn8ZqUprK0KvVv2P54nCj5EnUuiXTpwiOMY/hDaNA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleIXrXHe1F3/qdsnK7tyGvpC3znVnTqtoi1kXFN85eO
 OCx1tW8o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRVZwM/72U9fJLYmT7ypMc
 HbQ2CrUrirp4X0sr2Lotq7/a+myAOyPDo2CnTtUFMfJOaRM+Vms/V1N85RMswBAvd29nvO75a+7
 MAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: M47CMP42IUBRSLOEZPMCARXLPPLGTG65
X-Message-ID-Hash: M47CMP42IUBRSLOEZPMCARXLPPLGTG65
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M47CMP42IUBRSLOEZPMCARXLPPLGTG65/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

version() strips the trailing newline from line_ptr before checking whether
read_file() actually succeeded. If the read_file() returned an error, it
could be that line_ptr was allocated buyt not yet initialized. It could
therefore not contain any \0 delimiter - making the strlen read outside the
buffer. The write of the \0 could therefore also be outside the buffer.

Only attempt to access the buffer when a success was indicated.

Fixes: dbc4a8c8e585 ("batctl: version also prints the kernel module version if available")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/main.c b/main.c
index 79ed4ef..e625291 100644
--- a/main.c
+++ b/main.c
@@ -132,13 +132,14 @@ static void version(void)
 	printf("batctl %s [batman-adv: ", SOURCE_VERSION);
 
 	ret = read_file(module_ver_path, USE_READ_BUFF | SILENCE_ERRORS);
-	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
-		line_ptr[strlen(line_ptr) - 1] = '\0';
+	if (ret == EXIT_SUCCESS) {
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
 
-	if (ret == EXIT_SUCCESS)
 		printf("%s]\n", line_ptr);
-	else
+	} else {
 		printf("module version unknown]\n");
+	}
 
 	free(line_ptr);
 	exit(EXIT_SUCCESS);

-- 
2.47.3

