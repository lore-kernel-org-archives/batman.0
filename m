Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3D7C5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:35:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1E35F806CB
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:35:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785440134;
 b=xdvcNDx7J7RyfLj7sjihrmGdG4g2Xl/fG3VE9QSqv+fkfP/ZwZYRwPkKIaq6OuKODGrHA
 yJKFXcU00Xi3ykAOMJSEEWewibcsLMcXiSBjdLrTay9KFsEzaiWWJphSyStNmD3MYDA1faq
 Eh9N+7PkbnyJVVo3Y6LEF0oaETC70Gg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785440134; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BYF9LNYC6ivkkKF6mEwj44VKr+1jQ13Ttdxpg/awNIk=;
 b=L0MTlWedfwf80Ow82cCuOpyD34hAVExujHI0CpZpudUn8e4njpQOFQsyaUlbRFsAeE4Tp
 8Jcvbds9oqmJn9WZqRlw6KWMLhwR7iH4IUzZ/9c6SUZrpXI76kx0bicX9/7Dmmcp3c3L1an
 Gw2lsE2JJa1AVChTDLutDiQaNDFSvuU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9779983D53
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:34:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785440053;
	b=MfIDWSQy4gIYX7FryOk6ER11S2Qz2mQp70AuLjBmQ6hbygxo5qTrCUuh1SSflXKVoOIbnV
	qM8ZfS9l7isHaf0/HdncK5DSNiJBpksMKXXEtF/yGv2O/P4pUBUTpL/IfAbKLsyjXYZrmJ
	XsMgqPVnaa1qKjfwkD82DdUNg2YqIwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785440053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BYF9LNYC6ivkkKF6mEwj44VKr+1jQ13Ttdxpg/awNIk=;
	b=hqzLic+BdzkRnFrHxeHdGsN6eKI9Wf8QVubPAg/4hYcEtQXurOUQA2wJOKzY83UDwbGxuq
	S6KaafZYg5yzXROJwzaMwhH9DfhcJKYKypB9grx4J7j+oWJVQ1BpoAgQDbBCB612HRk7hm
	mAztqbEEczT3vBMrefbHsZ4IpR+bma8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=llowE4HL;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3137D20CBF;
	Thu, 30 Jul 2026 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785440049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYF9LNYC6ivkkKF6mEwj44VKr+1jQ13Ttdxpg/awNIk=;
	b=llowE4HLFPb2hOzZHwJZZPtPPvpmKjvXH0HfiLCMm6KBXY0/b4Tz9Mvg6yiB/MTZ+TDMDS
	iNyDpVRO2VePVCu0ear+W2fUaOta9YKvX28dDJ4gs5aIy30KSQc2R8QqR3Oe1eCdT7z5Tw
	VGyGOcOunTq+GbDcmcp70pEBSwl427I=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:32:00 +0200
Subject: [PATCH 6/6] alfred: validate the IPv4 multicast group argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-parsing-v1-6-c0f2ce4764bd@narfation.org>
References: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
In-Reply-To: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=sven@narfation.org;
 h=from:subject:message-id; bh=NN69C/SryZ4Nu5vs38l1mqG+zzIyu3XAk9SN+b2OYwo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9YuCfj625Tj0f7yw5PfrQ75WfM+wTil+neaotwqq
 ZlyZjNqOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATqc1n+J/2rPHDyvNbPKfo
 iRoHm9oleigoCZeteVY+U9BvRa7+rd0M/12MJ/6Z8pRTxHES68ZTpuXTD77cGnHaf7r7Ua7/O/a
 46DMDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4PSCTGKSNVILUSBG7UJYR7VVXBB7RXAP
X-Message-ID-Hash: 4PSCTGKSNVILUSBG7UJYR7VVXBB7RXAP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4PSCTGKSNVILUSBG7UJYR7VVXBB7RXAP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The return value of inet_pton() was ignored when parsing the -4
option. A mistyped group address left alfred_mcast untouched, so the
daemon continued with the first bytes of the IPv6 default group
(255.2.0.0) as IPv4 multicast group. Instead of a clear parse error
the user only got confusing 'can't add multicast membership' failures
at runtime.

Reject the option argument when it is not a valid IPv4 address.

Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 6372ec8..3953020 100644
--- a/main.c
+++ b/main.c
@@ -330,7 +330,11 @@ static struct globals *alfred_init(int argc, char *argv[])
 			break;
 		case '4':
 			globals->ipv4mode = true;
-			inet_pton(AF_INET, optarg, &alfred_mcast.ipv4);
+			ret = inet_pton(AF_INET, optarg, &alfred_mcast.ipv4);
+			if (ret != 1) {
+				fprintf(stderr, "bad IPv4 multicast group argument\n");
+				return NULL;
+			}
 			printf(" ** IPv4 Multicast Mode: %x\n", alfred_mcast.ipv4.s_addr);
 			break;
 		case 'f':

-- 
2.47.3

