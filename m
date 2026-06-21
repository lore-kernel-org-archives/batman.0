Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C782CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:41:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB7CF84A9E
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:41:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052901;
 b=vm2V1NgZ8LjC6wapj+G51URQfWd7d8mnWWJmIdRps0Ny/Oyj5eDkkcATx8L3bozZ3krBx
 zTkLcKn49wGlvXy+0qxYbsg8u7VX7zkytOWW9yUlX5PIgJA2cABBFWd3o1Z12tPXlF9YvZ7
 W4rOhqaGN3wjE8rrgSpqEeUytSGrckg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052901; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hEBSvxG0pzDF2Nnmq+mgqsLojTY8iBR407+2nUnPAbY=;
 b=qAYYIC8u4PAG8x9phQ3ZSo6C4oRfZ+XbW3OpF96vqSi4JqcLWcJYpnFuwESUlBMOmUK3O
 qnvIcwtP2m/QMHbN2ZAkyPouNdyWPZv62vSLWK0C3ObjLKQBkYUa7VSMxLJbOhs2yo1JCP9
 Atng3TE0WiS/fcd0LQkiouLkPdtwgUg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A7DDA84240
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051949;
	b=4IaVQIGqE6LyRAhGVOVG4PL/8ehn/5B9hAyfjpaJofyG6GIL8n5k7PAe1Fzu0Kb5SLBMqr
	q4F9B/rcXgYI3ew6iIe6JJISziUEc6AeyP+yZUB6MNFpxxoiV7q3nYwJXdtL0g+BentmAo
	g6n3g1zRPlIg3zxtY9FV60QwIqXnQ1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hEBSvxG0pzDF2Nnmq+mgqsLojTY8iBR407+2nUnPAbY=;
	b=ozu4me0z1ynTii/8l/AMKP0eNvDUcyWhQUKlkxW7CmhGJV6875dUH63VOcnle8lndC75JN
	tBQn0O1UXCOBJkJWReDayBqDp8lgbAwtDPi+g1fVpP25iU2J9DVqfp2fD38rJ83EJ8S4J+
	4UchtWhE+CNWVbWD8pOyIFVRbJcFjqE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JQWzXdl4;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5DD0E20131;
	Sun, 21 Jun 2026 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEBSvxG0pzDF2Nnmq+mgqsLojTY8iBR407+2nUnPAbY=;
	b=JQWzXdl4TBfZqwxWNlsTQNGpB/j61xQ9jdhlUFY+eLu2ndhmfsBXR4LumYvuuHm7a8320A
	3qUdyl50I+XkJ+hK6r6DX55MrANCjr9cdlmiqyXHr5uRFh5xicBYbJ/2FhXQEo077QIA3B
	bi1kJQ54TpOeUTtiSLhnSM1IzZsvw84=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:13 +0200
Subject: [PATCH 23/28] batctl: mark file read only succesful on read line
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-23-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=sven@narfation.org;
 h=from:subject:message-id; bh=zDwwk9LAJ7pyC/ih/kL+i104kxQMnfAx5wfLT56ih5s=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9gjpkybYpex5weHGMNMLTmnsxm6BQc1nB8ax3/0O
 llS4XKko5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARGwNGhg8zm8LFP7geWNmb
 Gvlj/rSlHvxaTNqRn5uL+rjeP9lmeI+RYb7r5+WTpodq/gnvaqlgP/dkD9PDH+kaPMZZDcssxH/
 acAMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MED4KA3TGKZZ5JUUN2G2SVOQ2PAZQYLX
X-Message-ID-Hash: MED4KA3TGKZZ5JUUN2G2SVOQ2PAZQYLX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MED4KA3TGKZZ5JUUN2G2SVOQ2PAZQYLX/>
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
index ae1c5e2..bb0dc18 100644
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

