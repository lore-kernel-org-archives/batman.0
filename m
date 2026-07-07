Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52987C43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:53:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E855484C8A
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:53:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450383;
 b=iJ1j3wyHP1EUjO0abSNVAoIWudwpdy6NUrRtGxt2yDGAJpmIyVSIDbgZhaBbbwjyQ6VZH
 2CtMOGSOK7I59OGMyHuR9z/P8BYHfYHvNjkv2psffcm2zpd2TB+HevvaZGPZGrNnjBfkyDw
 aV73HoaPruh+/R8kRRmw0Jyln0QMMac=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450383; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=M1v21i6JqHkrqRJhRieFa2HwY/Q3wUQ64IzOh0bQxUk=;
 b=wi+gC0NsHuLwhy5OeKC7JY4ZbW+rUtr+9yZoyuXu88FI4EP/qHx+7+KipnBP+CYSiXZNN
 sXkbhqKuAtfPj+BjaM/B10wPBiStenqhG08B8J4gGV6GzvdZn86gtl43CKJpD3w5wBYsms3
 YN9oF1PATIDI6b1+Sca+8p27/HYpKaY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CB68583761
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450029;
	b=snx1I8qeKI8VZjJKon0sLsP6LvZkGfZJwQ5jBHm1UBDtKZ+QKR9y8B4J5UPGWDSZ25NU7+
	0zdKErG4SUcy988Ivmd3l7j3pB9yTIh4E/2OpygUoWcjNfuZs4l6XDyIT2rqN/yx5Pa7V9
	1ekSiDDytvmg81HGtrElqVVFJraokIg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=M1v21i6JqHkrqRJhRieFa2HwY/Q3wUQ64IzOh0bQxUk=;
	b=YpEOXet+qaFnLkpqI90ny0qNVMzL0VkKWc5jyaMxkg4Fu4Lpy+GBiioELZkynQNgO07g/B
	nh1Dj/0cqJ4BzcEwMwKk6gvJDfTm6UBfBEm6VZ05iYN8Dut0vjkRkWELFiqDQqhohMT2+4
	VhJ7fQNqZdi+rjq3yoizJHYAXKSPY8k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tLXY59O1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 89616202D1;
	Tue, 07 Jul 2026 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1v21i6JqHkrqRJhRieFa2HwY/Q3wUQ64IzOh0bQxUk=;
	b=tLXY59O1oJglRJunkrsaVs3UkHW7nRG6eWmWODp0IqvtiE5pQ9b2pJg+rmX7xnjeeRp562
	Bz4AHVrWSvSjcfnx4yNRyNXLi5YLlN25xzekyTxFCk+qVtdMH8Wl5itLjKsQdlilGNTIb7
	gn7tcB06yJkFzqZ48N6MyLY/o1virAQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:50 +0200
Subject: [PATCH 08/11] batctl: ping: reject invalid timeout argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-8-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=sven@narfation.org;
 h=from:subject:message-id; bh=DzHWSUdXQmcX22mL/2k0pbyMXVn2+V2b5bC9keE8wYE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+ntPse6fOet27cZ8Y450H7pVT5Fs6c+xVjqUvmfRAx
 EhccXpaRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi9wIZGS6aZL27kH7D4/ay
 fqb9HD/vTLi0uDr4Kssy63mhnzwSCuYyMjzvt9M3P2h9UpmnlV3oPRNr87T8hX7sd85rKTyLCb7
 Lzw0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: R4DC7TU62SSHYHMGNDEXBVBEOIDAV4OR
X-Message-ID-Hash: R4DC7TU62SSHYHMGNDEXBVBEOIDAV4OR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R4DC7TU62SSHYHMGNDEXBVBEOIDAV4OR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The -t option parses its argument with strtol and defines a lower limit of
1. But it ignores any invalid parameter silently.

Use the same strto* validation as the rest of batctl and print a user
readable error in case of an parsing error.

Fixes: 2474249a6312 ("[batctl] ping utility updated to latest batman adv")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ping.c b/ping.c
index 5551cd4..7ba872a 100644
--- a/ping.c
+++ b/ping.c
@@ -128,9 +128,16 @@ static int ping(struct state *state, int argc, char **argv)
 			loop_interval.tv_nsec = (long)(fractional_part * 1000000000l);
 			break;
 		case 't':
-			timeout = strtol(optarg, NULL, 10);
-			if (timeout < 1)
-				timeout = 1;
+			tmp = strtol(optarg, &endptr, 10);
+			if (!endptr || *endptr != '\0' || endptr == optarg ||
+			    tmp < 1 || tmp > INT_MAX) {
+				fprintf(stderr,
+					"Error - the supplied timeout is invalid: %s\n",
+					optarg);
+				ping_usage();
+				return EXIT_FAILURE;
+			}
+			timeout = tmp;
 			break;
 		case 'R':
 			rr = 1;

-- 
2.47.3

