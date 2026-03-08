Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D5EA8524
	for <batman-adv@archiver.kernel.org>; Sun,  8 Mar 2026 15:07:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EFB7C859D1
	for <batman-adv@archiver.kernel.org>; Sun, 08 Mar 2026 16:07:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1772982466;
 b=PqjaRlsXo1MBMjS4sPq6moTzc7TkflmDnUA9RNTjOkN9BiOTkg2da/3i1GLTRJe1GOdgl
 QMCWTS896MQCi9mDKwXF+VMaLw5ltXu0sA0zsiKUL1VjXg5KhgC+RdJRAxZKHqihCPn6TSG
 nUBKR9UYv6yX5M4EM71Ok5801JH67Kw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1772982466; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7dNzhCJyOXhFvpAIr9acHGbxkmq0VisbDF2MnMYbLm8=;
 b=2UP8m2rgyoAbL+RXGq1WXifO4q1CfdcPgkmNZ5+i+Fep1KoKC4Msbaqh03yWSKaMkzRGB
 YrCBYF4x8axbuv+fJazL5ZWhR7e7eAZUGSc6dmcjmT5K1SQTzmMff38NpagdlTg7tBPaAuk
 /+sbErMX1RfRxr0MwwjTP3NEsq7GHxs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 814F08436B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 08 Mar 2026 16:07:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1772982453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=7dNzhCJyOXhFvpAIr9acHGbxkmq0VisbDF2MnMYbLm8=;
	b=ATUNMLZfknawcvggTMIyRPxeorpUFpsm7H5wd2V/0rR8/j9Yg+WFZ8CyFP8HlUwZKRWufp
	nqTSv/a48VS/oDpCT7sWmmrXjM+Vgv2c84+l8AGkzY7/QfQ8WJiYStNBcG779ZVN+RPy91
	40lDZxfkQVSwEunNDyMNf0HFFkBCy0A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MgsXpkki;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1772982453;
	b=yxmtlo81E8WmxRU8ybW+VxZ2ocKhd2ybudehhB60VdJmJRvjwdIrS/gkGoRH7Hem/fdf22
	vdlbe9B4c09EqYtPPlUxkKteqqUR0jgFZAKKOtyVXGCec5W7WuEDK6PVmaZ4RKHMFXICOx
	iPSSzlxrD68lyyw/JCQlrIni1wzHWKk=
Received: by dvalin.narfation.org (Postfix) id DF85E1FE5D;
	Sun, 08 Mar 2026 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1772982453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dNzhCJyOXhFvpAIr9acHGbxkmq0VisbDF2MnMYbLm8=;
	b=MgsXpkkiYjv7aIvxo8Ln0Ee48HoxXQVjjyMwP3YAUDoGszCEw/Q6Qwuq7+mLJkX0szQhkB
	lrl083UvJjcebSkuNLf5u8S7QIz6ZNDPkhaVaP3SrIX7fRe4SBCjkwE/6lyrVmxNg6H7mO
	vLGdmEQJnxCjva2sixb4HkNtJPWMvMI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 08 Mar 2026 16:07:25 +0100
Subject: [PATCH] alfred: Fix printing of timespec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-t64-v1-1-638047cd3e7e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKyQrWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwML3RIzE10Tw+QUQyNjM6OklGQloMqCotS0zAqwKdGxtbUAzOrUKFU
 AAAA=
X-Change-ID: 20260308-t64-41cd12362bdc
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=sven@narfation.org;
 h=from:subject:message-id; bh=oRc6YWVus925BF08/r/UXrFXVPRtGso3dsC+Erdskec=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJlrJ6xbE/Oras1Xix2a/2pEOv5ePf2g+vqyW/7zTTZen
 73BaQ9nY0cpC4MYF4OsmCLLniv55zezv5X/PO3jUZg5rEwgQxi4OAVgIuYMjAyzn+df5y65e5mr
 qnt/5by8CKkEh30TGCf4HY35IHWqtD+P4X/SzeKy94IX1Jeqqb5YeGXN4VYrwTevqrcbGN17Pi3
 10EdeAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7TH5R77U3SHXV57ZCWEURJCS5PY7E2OR
X-Message-ID-Hash: 7TH5R77U3SHXV57ZCWEURJCS5PY7E2OR
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

musl on a 32 bit system still uses a 64-bit value (long long) for the
storage of tv_sec and tv_nsec. But the printf was evaluating these
arguments always only as long.

During the print of the nsec value, range of 0-999_999_999 is only
possible. 30 bit is therefore enough to store this range. For simplicity,
just use an unsigned int.

The second value on the other hand can get up to 64 bit on a 64-bit-unix
timestamp system. Just use long long for it to be on the safe side.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c   | 4 +++-
 server.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/main.c b/main.c
index 0f242e8..71a6260 100644
--- a/main.c
+++ b/main.c
@@ -285,7 +285,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 			sync_period = strtod(optarg, NULL);
 			globals->sync_period.tv_sec = (int)sync_period;
 			globals->sync_period.tv_nsec = (double)(sync_period - (int)sync_period) * 1e9;
-			printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
+			printf(" ** Setting sync interval to: %.9f seconds (%lld.%09u)\n", sync_period,
+			       (long long)globals->sync_period.tv_sec,
+			       (unsigned int)globals->sync_period.tv_nsec);
 			break;
 		case '4':
 			globals->ipv4mode = true;
diff --git a/server.c b/server.c
index 0d792b0..c3d32a0 100644
--- a/server.c
+++ b/server.c
@@ -404,8 +404,8 @@ static void sync_period_timer(struct globals *globals,
 
 	if (globals->opmode == OPMODE_PRIMARY) {
 		/* we are a primary */
-		printf("[%ld.%09ld] announce primary ...\n",
-		       now.tv_sec, now.tv_nsec);
+		printf("[%lld.%09u] announce primary ...\n",
+		       (long long)now.tv_sec, (unsigned int)now.tv_nsec);
 		announce_primary(globals);
 		sync_data(globals);
 	} else {

---
base-commit: bdab2a4dd79716edd6c5ecdbda7bf38c8495083c
change-id: 20260308-t64-41cd12362bdc

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

