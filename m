Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F19C54F51
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 06:28:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 707B980C84
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 08:28:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785306523;
 b=UorSQLoWMkqx+Wu1WWW9bMdNSdqKHCe0t8EChcVMKjVa8OKFsPrUYpqO4z7hsgWdP+VOq
 s60ZuNOXBeGApBcTD0ZyC1Wn+iLlenxAQrnPpdF6jRgUbO+cHaUHGz/EZUz9j30P6PcURLn
 LW1AvhjWLSWZJh3ZbyCWnTnB5z/uZQ8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785306523; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cruTMziJsubL85vElblFp4jmu/eHVzMx6TetjEM7fdY=;
 b=btQYq8qK2A89QOGOIOQ0kKOxkY+uA9K+3nqZkhnPj9XBC4RBzYf6DV9XY/EdqtVdV+yUY
 ez1gHUKCuiMzyBZtzPtjMD+fo45jA56ZwRyPyRVRiv5mucBYyFIoNhhE4BujrRaUByvRiMo
 t+55jv2unWTFJZc6Z22nQbIhLrGBopc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EA29E8236A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 08:27:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785306459;
	b=Z0oxTWX200NJ8f2EYYu1GTmCUp6MdtXa+Qg4pAQ9SmoQUbjGVS+ZYE9WDm6/I7f2o1b/nG
	a/ICYcONcOIgeAb5LC86HnHBEpfYgQ+uYbQmGtQ72XJMvFaKU6bt2kIfi7GYovqr4y7UBX
	WngO1wvYz0plrTkKFKaWN5wPVV1a7j8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785306459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cruTMziJsubL85vElblFp4jmu/eHVzMx6TetjEM7fdY=;
	b=Fg1C+IEx0DvAoKadTk9VbHnRzu8GWSw8KApXAmGRW0btK5P5WWiD2u/uSyyOZARuCEXAGs
	EcZeo0T9P9jV/ajJ1hCTB8F+8y7RG1HUcKbr/k0hzM/GQvt0+2+RqJp3gQURzTKd1HUlxl
	CuRO5s+a1TeUsRVnkqXtEV9PuF5GPUQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AmCtrsKG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 77080200C4;
	Wed, 29 Jul 2026 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785306454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cruTMziJsubL85vElblFp4jmu/eHVzMx6TetjEM7fdY=;
	b=AmCtrsKGt0GzRsAvzO6CurmCZgTjp0RA7SjUZlJsflvomishNQd2C5JoAtTjG+JulwONjX
	lML0aCEtOTdEu5sj0QyvdSNTOlVIlDaNCJyuxYq45bqheD4dxMHROGP9Fc0z2ke5H6+RoT
	cOR4LS3LoFelV40JwBmc2h7qr5k5uKE=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jul 2026 08:26:29 +0200
Subject: [PATCH 2/2] alfred: free the correct capability set when
 cap_init() fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-bugfixes-libcap-v1-2-23529745c828@narfation.org>
References: <20260729-bugfixes-libcap-v1-0-23529745c828@narfation.org>
In-Reply-To: <20260729-bugfixes-libcap-v1-0-23529745c828@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=sven@narfation.org;
 h=from:subject:message-id; bh=UASMUHQHJdsU0b6gERDVDcIEH2St/yYgvHxEWD7eR08=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmZc5WkCmtYvXfVHGW783fdIoaqFxZVmz6r8bLZL+d7c
 arE/vH0jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEtJcy/A+R6ij88GFd9Juq
 HzNVp2u4KTrZnNZ6qHGGVzku6kuPWxQjw/zdVYVXnbs5DlopH341dSJj6vdl3P2SDzdGips9Y9b
 rYgUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NFNANYNDPUKOVGYSG4DLDDQKF435FN4Q
X-Message-ID-Hash: NFNANYNDPUKOVGYSG4DLDDQKF435FN4Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NFNANYNDPUKOVGYSG4DLDDQKF435FN4Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

reduce_capabilities() first allocates the current capability state with
cap_get_proc() into cap_cur and then allocates a fresh capability set
with cap_init() into cap_new. When the latter fails it tries to deallocate
the NULL cap_new.

Free cap_cur instead to avoid a leak.

Fixes: b0877b387ba1 ("alfred: Drop capabilities when not needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 9c38fd7..07e3cca 100644
--- a/main.c
+++ b/main.c
@@ -84,7 +84,7 @@ static int reduce_capabilities(void)
 	cap_new = cap_init();
 	if (!cap_new) {
 		perror("cap_init");
-		cap_free(cap_new);
+		cap_free(cap_cur);
 		return -1;
 	}
 

-- 
2.47.3

