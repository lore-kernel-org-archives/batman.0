Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3EAC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:36:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6FCC983E88
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:36:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783272990;
 b=oC1pX99YtOhRS60tMld8I7TWRbbOoa7q2acz3OhWmvO7vkhw2ibu31OBGDH+3PP42T8HA
 Hj5I0Y3/cgBcjEPQPH5XdE0t+HnWwJ6c8U9XvRDI0Yie2qQTbX3gQPL6nPOxz+hh5hfRILM
 Z9xUuVVwvQrxhkBbyK6JFOl08Lq1Yow=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783272990; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xo3MlOwsMVj9FAvwSmgU+3tlXbEQRgwGWi5hnFiGJpM=;
 b=uGzt8qXaGM5VAPrXJ81p3jilKn0b2QH4akKxAzyN4EEahewi6l0fz6OiSMsgDX8WWOEIZ
 OKl2YTso73DZfqtV6zoR0YbKhFMwcA18fSLt2h7kUG1vont/fzBhcudxuIlmtEcwzJVPIL3
 G7sS5y3qf+3u8DWX5DWBd6ppNpeAMPo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B197482E1A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272626;
	b=e4YWmuW97PdiXda0DMbpVej7NTL6rTGh9irW8A3uULbC7OfjQNVaTboRse9uIB/q3JGdNS
	Say1F/3ts7GA3qMFtFMQ+ftXmZqaMhbyCNCDMURnfBOJFbGQwD4FByhWHUTFUULriTpUKQ
	MbYBqnfoa4DKnCizjnDibHueLjjb2FA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xo3MlOwsMVj9FAvwSmgU+3tlXbEQRgwGWi5hnFiGJpM=;
	b=caZNLXNoWPrrxUHgYfVI7E52SZoJeq+S9Nh0OnqsftThuQknEBOA8IX5ZZzltyKrydBqVK
	7ADDRuV0j5UZn+RTCDJabpZZtEdZI2ZnLkXZhjXbiyrIH2t+nCvfQQ5WJJzjyT7aHJm8oN
	Ok/D+5ONTXdgPvnfvTJHZ8rEkuBLjDM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QriHf8H9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5C0061FEE6;
	Sun, 05 Jul 2026 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xo3MlOwsMVj9FAvwSmgU+3tlXbEQRgwGWi5hnFiGJpM=;
	b=QriHf8H9MwWKe975Z8J3cG+t5iz8bMmKuoV3hgLKgp0U71iSRd7giDKoDZUdnRClO65Tbf
	9XQeSmzETK/BOZ3or2gkCtlLLcccD4+dor+rXC/KWa5p71oPtIDx2Wbm5TagBDubCuGDVG
	Icsd0k6HO7UzGxT7xUpljy5BtRWydHQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:11 +0200
Subject: [PATCH 8/9] batctl: tcpdump: reject invalid packet type arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-8-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2684; i=sven@narfation.org;
 h=from:subject:message-id; bh=e0Q7ydS5e30naXVD+PphQBEcLrykB/r6xwbPVby6HyM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+aH3ClVvjvjxm+lhjPKsToCeZzulZJN+37tqfvyb
 eqL9NnCHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ8BcxMjwp63vw75LweZt9
 eVve6Bi/+35jmt/VWWs/MXgdmXLI4u8tRobXyxa8Dq2TmVbSUaBev1tgvp+fwv1JQQ92s0ndf73
 90nw+AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: W2TRXGXP33H5ZYNTXDFULVHL5HD3OJOD
X-Message-ID-Hash: W2TRXGXP33H5ZYNTXDFULVHL5HD3OJOD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W2TRXGXP33H5ZYNTXDFULVHL5HD3OJOD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The strtol error handling is rather complicated and it is not only about
checking the return value. The possible error indicators are:

* endptr is NULL
* endptr is not pointing to end delimiter
* endptr is pointing at nptr (because it might have been an empty string)
* returned value is larger/smaller than the expected maximum/minimum value
  range

The first tree conditions were not checked even when it is a potential
problem for multiple places. And the user was never informed about the
parsing errors. The old value was simply used.

Perform the needed validation steps and stop with an user readable error on
parsing problems. At the same time, switch to the unsigned number parsing
function strtoul because no negative numbers are allowed as inputs.

Fixes: fca4ef98aa99 ("change mac convert functions, add icmp packet output")
Fixes: c6ed60c0f6fd ("batctl: tcpdump - add option to select all packet types except specified")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index f9fb0c1..48744ea 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1506,12 +1506,13 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 	fd_set tmp_wait_sockets;
 	int ret = EXIT_FAILURE;
 	fd_set wait_sockets;
+	unsigned long tmp;
 	struct timeval tv;
 	int max_sock = 0;
 	ssize_t read_len;
+	char *endptr;
 	int optchar;
 	int res;
-	int tmp;
 
 	dump_level = dump_level_all;
 
@@ -1527,14 +1528,28 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 			read_opt &= ~USE_BAT_HOSTS;
 			break;
 		case 'p':
-			tmp = strtol(optarg, NULL, 10);
-			if (tmp > 0 && tmp <= dump_level_all)
-				dump_level = tmp;
+			tmp = strtoul(optarg, &endptr, 10);
+			if (!endptr || *endptr != '\0' || endptr == optarg ||
+			    tmp == 0 || tmp > dump_level_all) {
+				fprintf(stderr,
+					"Error - the supplied packet type is invalid: %s\n",
+					optarg);
+				tcpdump_usage();
+				return EXIT_FAILURE;
+			}
+			dump_level = tmp;
 			break;
 		case 'x':
-			tmp = strtol(optarg, NULL, 10);
-			if (tmp > 0 && tmp <= dump_level_all)
-				dump_level &= ~tmp;
+			tmp = strtoul(optarg, &endptr, 10);
+			if (!endptr || *endptr != '\0' || endptr == optarg ||
+			    tmp == 0 || tmp > dump_level_all) {
+				fprintf(stderr,
+					"Error - the supplied packet type is invalid: %s\n",
+					optarg);
+				tcpdump_usage();
+				return EXIT_FAILURE;
+			}
+			dump_level &= ~tmp;
 			break;
 		default:
 			tcpdump_usage();

-- 
2.47.3

