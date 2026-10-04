Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1717CA5FCE
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:14:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3E66282241
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:14:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108841;
 b=Wk9D5sWH/CcjfRVI2tLdJpPfsQvB8f7Cb80WD1LogJC2NFg7hLPpm+HeSEGiMqQaxJJcE
 BaOooDn+UvqKv0ewU4ssFS0JB0cAH0b9gRS+fkJrpuS/fCMhN0Eb/34+OZQ6Ho+RWTbXBrB
 WjAg6+XVStgnP7hfPe1mR7KeXimtD/w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108841; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ls/WoSxzPA6uAbWm76rznxXVXDqIWint9oY79/K8Uxk=;
 b=c5NKlVLlpsQreRvM+HebmwTmRZsWE3hK3GA19AtkA/puP8gondAWbG9p52CvzqjxRh2ma
 YkqKtEj5MOVw3P5RyYqb/S6LEtWQLZCpqltHlyRGApOBw3UlYBafE5ZjllideNvDTPm2+Q4
 atjihmyxO92zbqLAw5FNPfSh/+cieOA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E8986845DB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108569;
	b=xwSy/WcNg2HLhTViHfScQgloFq8d4s5olMZzPZ6/kEDaNs5N55Q5nkEzudVtA942aYyDPA
	LHOo7Md26EYMIc5slI46kSuNISrTfdSoKXfm0g4Ha3qW75qSax4PIDeAAwAdvZWHWY0vxe
	9hRPYxwUWuedPa1keK6XUp1HOi22gN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ls/WoSxzPA6uAbWm76rznxXVXDqIWint9oY79/K8Uxk=;
	b=MYuN2vOei/kmOGP6ntVGn0NsHH/U0mcIfGp9CyjDy7a/9WZKlqD7YQMmf3J32AwT6D7MPH
	2V68q9maVaMY5jaAHg4fTX5LvYhTBSUEM0IvfZcBu2EYo4prBeJUc29Cfhq7AcYv398T3/
	VHWs11gJrBFt/mjb2rP9AP2CKQnSmX8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PLSyAM44;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 88CBC20494;
	Sun, 04 Oct 2026 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls/WoSxzPA6uAbWm76rznxXVXDqIWint9oY79/K8Uxk=;
	b=PLSyAM443F85h4M2l0UFEnV/3pmwUfBhQLPdFZ08LiDLrq6Y2kZC0PfOj2CdMVa0S3wsu/
	GAUpvSIGdafH7WGECpZHkRSF66WGvMXWj4FqP22L2abCFWpQ9GBxG/prNyYUdWDQ0elDkh
	OXNvyDNUwn1UCYm3yCCppsYVxqzElxI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:44 +0200
Subject: [PATCH batadv v2 9/9] batman-adv: tpmeter: avoid underflow in rtt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-9-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=sven@narfation.org;
 h=from:subject:message-id; bh=jhklif6OJDYCAzila98PUZQA9QDgkAjj9NO1HoDm7Sk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLfW3orYOa/5ueieCKf47Rvnm6lGFBt2rHuorP8ix
 eLeccbvHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ6L1mZNhhuMy49++SMm/x
 DS8adr6t3fhnqsgxp2eG2h/KNru/Du9gZOj8eDxX8Bu/zf/4ntgtzR4aeX/bwkQ3O/Ws7/zRZjA
 /ng8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SBW6TWQQA4EY2EEGY5PUFA5SMIEOQH4G
X-Message-ID-Hash: SBW6TWQQA4EY2EEGY5PUFA5SMIEOQH4G
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SBW6TWQQA4EY2EEGY5PUFA5SMIEOQH4G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

To avoid an underflow due to an non-strict order read of jffies vs
timestamp, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7d4d84ad..3fdc7f67 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -822,7 +822,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&tp_vars->cc_lock);
 	/* update RTO with the new sampled RTT, if any */
-	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
+	rtt = jiffies_delta_to_msecs(jiffies) - ntohl(icmp->timestamp);
 	if (icmp->timestamp && rtt)
 		batadv_tp_update_rto(tp_vars, rtt);
 

-- 
2.47.3

