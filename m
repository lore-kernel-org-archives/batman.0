Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF64C43458
	for <batman-adv@archiver.kernel.org>; Sat,  4 Jul 2026 19:38:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A8469844D7
	for <batman-adv@archiver.kernel.org>; Sat, 04 Jul 2026 21:38:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783193929;
 b=E1m6iptoGJGMVRc4wePpW9yk0IJTO1Z7JvTlfACNeyBnO2S+E9lRbySKMZ+N1Tetta+gD
 0WMZUCmD4p/fcGk1w0KtLyKE5wemeFkA7+JA6tAUkhenEVF27bPZkTyAtFmO15m4nqSCyXk
 XUfemzGnCLisasTq3CbJzGhBilecXI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783193929; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fHAQ26mTO/hglD8/nUjokn3GOrrlBsa2A8tqYrmvDts=;
 b=SgZdGKbuyT82x9mDe2F+YGJ7s/jtBkl9mh8+L0v66Wf3uAfIYoOsHFTTVkOUHomtENWsy
 Q8tjmHMMgximUqrf8GrN2wW2u4UwT/LccOPy/yHzwcK3W4yrC25DZQaBX98IC4x4gpu+NsF
 bXYHeUPc4a2EkMmrrf19r2YXBU2F9Kw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1498E84206
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 04 Jul 2026 21:36:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783193794;
	b=XxGmrYQ8LLZCdABOTXSQVvlgeFVLSMqDy4Wj06SKJwPAp2DZO5ILbr3NS1KMCNxvomy4gb
	B0ho7E6mfyouqr7jnZKHp+T3Xb2F05kvoKS/Ekn2hpCGNX/TryjowKIhNyv/Z5ygANslS6
	muPL87TZTxyKorN3WlZen/wdjKyzDTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783193794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fHAQ26mTO/hglD8/nUjokn3GOrrlBsa2A8tqYrmvDts=;
	b=yq4Ci2Rzx94l4hqly7HD2A16KBl+PwM8ugur/0a6r6p6pboSaLMGfHpYyWwIH2K9Fk/DBE
	aKEmgEXGvbLJTLHUPplM+5uEeVvwvdj+pANhT1BaKFLkA2jwjNc79L5nvD4oanFoqXyNv3
	sF4lu0EKa7pTT87NVI6drLbTS2Htr90=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="0bv/8MWZ";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C99D420685;
	Sat, 04 Jul 2026 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783193793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHAQ26mTO/hglD8/nUjokn3GOrrlBsa2A8tqYrmvDts=;
	b=0bv/8MWZb/Kp8xqFobMPKJzO+y2I7CPWGkcUYNlbGW2NrTNrixDq5sMQfa0sT+wKpaybky
	cR7ejWT9oetxw+I7G46CiRdt92dDiczXPIt9wJAtKa+62DVMDIigPDMDaRSFr1D4KheSew
	MudNYRknflCbImloPRS0ugvzLTrI8Xc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Jul 2026 21:36:01 +0200
Subject: [PATCH 3/5] batctl: debug: reject trailing garbage for intervals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-bugfixes-debug-v1-3-888ddc878206@narfation.org>
References: <20260704-bugfixes-debug-v1-0-888ddc878206@narfation.org>
In-Reply-To: <20260704-bugfixes-debug-v1-0-888ddc878206@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=sven@narfation.org;
 h=from:subject:message-id; bh=qHqQlcl94C7OiB7QkFIAdvt2A2OAAmoGlS98QFfCH9o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmeCcuvzl7AZXfB9rzeYv2JnXFijCkfMqI8DlmnTFjk1
 bpn/fFZHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJGBgwMuyp3ahqF9FhMiFj
 2ydfVquSyUwvwo+X7NKv8Tvwjc3Ovpjhv9/6N0t21XdwBf1XMGCZzRzRtsBn0qpt28V4FSLOZDo
 ocQEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OMFOWFGX4R24FNV54L4HWRV5LYOW7CVE
X-Message-ID-Hash: OMFOWFGX4R24FNV54L4HWRV5LYOW7CVE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OMFOWFGX4R24FNV54L4HWRV5LYOW7CVE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

 A "%f" sscanf conversion stops at the first
character it cannot consume and reports success for the leading numeric
part, so trailing garbag are still accepted silently.

Append a "%c" conversion so any trailing character makes sscanf() report
more than the one expected item.

Fixes: 302a41a73915 ("batctl: Add timeout filtering option for originators")
Fixes: e4a7b7733faf ("batctl: Add an optional interval for watch-mode")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/debug.c b/debug.c
index ae13dce..1cceea6 100644
--- a/debug.c
+++ b/debug.c
@@ -51,6 +51,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 	float watch_interval = 1;
 	char *orig_iface = NULL;
 	int optchar;
+	char tmp;
 	int err;
 
 	while ((optchar = getopt(argc, argv, "hnw::t:Humi:")) != -1) {
@@ -67,7 +68,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			if (!optarg)
 				break;
 
-			if (sscanf(optarg, "%f", &watch_interval) != 1) {
+			if (sscanf(optarg, "%f%c", &watch_interval, &tmp) != 1) {
 				fprintf(stderr,
 					"Error - provided argument of '-%c' is not a number\n",
 					optchar);
@@ -82,7 +83,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			}
 
 			read_opt |= NO_OLD_ORIGS;
-			if (sscanf(optarg, "%f", &orig_timeout) != 1) {
+			if (sscanf(optarg, "%f%c", &orig_timeout, &tmp) != 1) {
 				fprintf(stderr,
 					"Error - provided argument of '-%c' is not a number\n",
 					optchar);

-- 
2.47.3

