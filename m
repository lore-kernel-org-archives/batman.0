Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00078CD98F2
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:26:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 791028429D
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:26:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782051961;
 b=2oRrKUB7HuJ3CptsrKQgaW2hSM2Q0t8MrZoVGfmAx1J3qS40J/Vx/doyNqsllx7NL4//O
 sXvOlOfK7wviq0dBI7qCi55cLjUZL+cMTDOQsp4WYRbdxDp80Xy5XQhtEr7Za4efrcQRxGf
 5YYklq1Kp3/4+sbjz0zBsfdVdtsPy1g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782051961; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HFA3fk2r95Nlq5HzUqqIchwXY6D62yjLlk2I93M9jh0=;
 b=HEhAGb5rWSeCCJ+RkDGGEXcCGvmYJ0eIAGOPdlTTYRxF7w1sXhErrwcuUKbfRLLuAGOq3
 4XEAraM+3TMdBulAbNrszS1DhK7l/NZeLPVS2lcsbeA6RlYYdnks8T9yMZyYpK8kqKOmQyN
 1xJFonKmfiV+MyUvOApIMba+XKkazWo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9A49980951
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051861;
	b=EqWgILqCIcplL8ttqgZ0f8nb9SWUyAb5iilf8Ce62xrKMJ85n6AGUq7pXU1qDhvjn6ewpV
	3pD0NTMwuKn5WQXzP6RS97doBsVSoBeukC/mtSJg8vHnfTMtV4vZoNCMWF4HFhztgkUaU3
	NqLFqUDispHNYp3JaYIVIZM8+EE2R4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HFA3fk2r95Nlq5HzUqqIchwXY6D62yjLlk2I93M9jh0=;
	b=YpbC1W0dkVdbOIKd8eRPbY86Duq5r2b2JWudZl6U2fFPFHIOTyU2wSlaySWyWLv9e5+esV
	D1V7yWvNAzc00HIr/34klHfzHDSkfdcfnMJv0EiZYnQUmXcjj2e16pAoN4SUIbQrXGUiUh
	Pirs2iDvSOsBNvcJ1gVfcCZ36TqBO3E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mCw647iT;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 48CD720059;
	Sun, 21 Jun 2026 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFA3fk2r95Nlq5HzUqqIchwXY6D62yjLlk2I93M9jh0=;
	b=mCw647iTozWdB+KD1ZlHeVTDNDRo8T3CNlqkvRJj020inaC9ZDX8DW6Dcu7BTyiZWKDgJO
	Z7v6pAEfuInhmrlja6FhaxvvIHffJs1IYC/e94DBsZ8F2jNFLInz1iA301WZZSJzwx16AE
	FiFYwRwwgVXGpYsiS1hnV8rml1obPGM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:54 +0200
Subject: [PATCH 04/28] batctl: use strict interval/timeout parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-4-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=sven@narfation.org;
 h=from:subject:message-id; bh=SrsJsfHwSTTUG3ejRBUNo1zWG3AGD096q2ksCNQGTiU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1jqW6OEDzg+EhBI0+SdPvXzpMvzrszeKdY+v7fx3
 7qVUtN+d5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0rOW4X/BgZUHMpPeupWH
 RVvr51zr0DBfcmzDJbYKndjGWw1Xrm1n+MMRrd3sGM5+e3FBUsMNMYfrrbkP3Zep9DDUmhp4PuT
 uZQcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LRMC66O52PLSEDQZBAF776DOR2EUGY3B
X-Message-ID-Hash: LRMC66O52PLSEDQZBAF776DOR2EUGY3B
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LRMC66O52PLSEDQZBAF776DOR2EUGY3B/>
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
index 163a46b..5bf6d5f 100644
--- a/debug.c
+++ b/debug.c
@@ -68,7 +68,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 				break;
 			}
 
-			if (!sscanf(optarg, "%f", &watch_interval)) {
+			if (sscanf(optarg, "%f", &watch_interval) != 1) {
 				fprintf(stderr,
 					"Error - provided argument of '-%c' is not a number\n",
 					optchar);
@@ -83,7 +83,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			}
 
 			read_opt |= NO_OLD_ORIGS;
-			if (!sscanf(optarg, "%f", &orig_timeout)) {
+			if (sscanf(optarg, "%f", &orig_timeout) != 1) {
 				fprintf(stderr,
 					"Error - provided argument of '-%c' is not a number\n",
 					optchar);

-- 
2.47.3

