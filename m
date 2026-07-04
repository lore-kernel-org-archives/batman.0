Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10072C43458
	for <batman-adv@archiver.kernel.org>; Sat,  4 Jul 2026 19:38:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AEB5084197
	for <batman-adv@archiver.kernel.org>; Sat, 04 Jul 2026 21:38:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783193886;
 b=d6AW2ea+2PPoFV+VGs3s5PiG7xhaOosMTIn+5G3umIsSV4YeGC9mKKEhJPlqbNqMvEpau
 1poSaQesLVR0ARzZGJ0GM3+cd/a6qtSDNxd4Un8K8sO8NptLhOGYoAjmFc6MCK58eJomliN
 FrEH0Bw6cHFd8FKqScEvKd1dVifPSi4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783193886; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VJaVxT4aGcSTIZgE62LBxTDBp1HuhXRlXe0F1seshD4=;
 b=hAaTQNQvdDHsmmzLw2rUmGSM7jghOxtS/2AXMmVCmdZVR7mMVEfXnoZnRS9tTnUB8e/Jq
 GkNFQA9UA/HTuVJfSflpPKEnyDmKhOE6ltNoW0++FTRchEUQsD6eqFVAsnUyxIFPz5hs6+t
 tLKaG1yvERgcW1eqyOGbMv0r++mJMoo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 322FF84206
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 04 Jul 2026 21:36:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783193792;
	b=QC7O7YxW7VL9lOLDvjpNiTWMK59Cwrh1QNtU7U4igJQbxJoLUUxeJcijUl56K2NMRbPibL
	0reAoz+PVOJ30x5DN+7kMT5XlFtoxG16A0+DGaB4OE9/twfT9Ajnd14TtCtwxS/g/d4aEu
	N+tUATJd9E5nyEL4B5NigoTxR84ZCqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783193792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VJaVxT4aGcSTIZgE62LBxTDBp1HuhXRlXe0F1seshD4=;
	b=lrPTDhBamnbVLRZNwI4cZxqeQ5cwDT7KYu/NO4IInaElZOUiueqrAl9XYK/G90oVhipYS7
	60bVy+76TvIHI/Jq0ml42vgayQRLvtX/V3RsaqeQjNdGaZEUT4rpyBZlEJj26heezE5mBO
	LPDD6CoaFtDoBG0agjTjMQKMndv8S6U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eU4CsGyF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AEB2720685;
	Sat, 04 Jul 2026 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783193791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJaVxT4aGcSTIZgE62LBxTDBp1HuhXRlXe0F1seshD4=;
	b=eU4CsGyFrXHYhvFZKLE6TrE642XS8CSI28rLeoIlu5hQv2TKM+5xSH71AWqaqtzuVJK0LH
	vpifmabMtXxTAT98pGz0PEYYh4aNgg/GkJiC2sduPzgeNFjV9VuAD1jOqc3CY1VCfe9+Ca
	ve4B+o0fNJwybUeq6PQCCMBNMJhZDjg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Jul 2026 21:36:00 +0200
Subject: [PATCH 2/5] batctl: debug: use strict interval/timeout parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-bugfixes-debug-v1-2-888ddc878206@narfation.org>
References: <20260704-bugfixes-debug-v1-0-888ddc878206@narfation.org>
In-Reply-To: <20260704-bugfixes-debug-v1-0-888ddc878206@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=sven@narfation.org;
 h=from:subject:message-id; bh=eDjIqH6wHZiDH1tTHLB1BYJwQuu4EU8KKA8P2MZMtyM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmeCcvXW/05Ouv5kpKGyxp/lydG75YKOPdlnXmB74fkJ
 yoaa0und5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8r2e4X9NlUT0qjPMouuV
 Mjg/nGENWXh+WyZz/Nzq+Nq3ultljOoZGe623Dl/IPx5ZLdGpelbj19RzVMjS7estF2c91T44b+
 fOZwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZLWFFQ43FKAAI7DAJR36QURJBTNRVIPB
X-Message-ID-Hash: ZLWFFQ43FKAAI7DAJR36QURJBTNRVIPB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZLWFFQ43FKAAI7DAJR36QURJBTNRVIPB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The sscanf() function does not only return 0 when the value could not be
parsed from the string. Also EOF is a potential return value. To make the
check more strict, just compare the returned value with the expected number
of scanned/parsed items.

Fixes: 302a41a73915 ("batctl: Add timeout filtering option for originators")
Fixes: e4a7b7733faf ("batctl: Add an optional interval for watch-mode")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/debug.c b/debug.c
index bca81c8..ae13dce 100644
--- a/debug.c
+++ b/debug.c
@@ -67,7 +67,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			if (!optarg)
 				break;
 
-			if (!sscanf(optarg, "%f", &watch_interval)) {
+			if (sscanf(optarg, "%f", &watch_interval) != 1) {
 				fprintf(stderr,
 					"Error - provided argument of '-%c' is not a number\n",
 					optchar);
@@ -82,7 +82,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			}
 
 			read_opt |= NO_OLD_ORIGS;
-			if (!sscanf(optarg, "%f", &orig_timeout)) {
+			if (sscanf(optarg, "%f", &orig_timeout) != 1) {
 				fprintf(stderr,
 					"Error - provided argument of '-%c' is not a number\n",
 					optchar);

-- 
2.47.3

