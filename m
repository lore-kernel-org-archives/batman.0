Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8E1C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:02:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EA296853C0
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:02:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783540942;
 b=tYrAjzKZi6VlHmhSCWwiLhQrqWyMD6+yGp9HQTV4rA0XBOsKQJkdrzmpcBVVuIw+PQQcC
 rXCKH7dhe+Y4xLhUB26cLJV+lOyfCTCZaDQawymgCpDzIBDJ/A2B2xpFWdm59tzsbtw6nhq
 kIpkpbvdasSOt0RjPJ3gUtYZY6QeUps=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783540942; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JGCx6F4+Ay2OqECGuNQLkxJfy0M1oW7cmEg7w2YJK6o=;
 b=Alu75v6n98WGasap2tIZAKfZcna+Ud0shjn8kmgMxPLmQ9Iw0JCHnGMIheYAF/PEEbteh
 SkJwK8Bzw2MKUUChSwiH9FNDmgh4ypymFys2DHhzQSHVZS6JPvgIzBsgu2MfsCACFr/cGso
 WzQw61akm61S7Zd50q5jJcVFA/rXJPQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 38C7C8315F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540828;
	b=XmCaVKnhHWUDb1blmYEgkFYVFM9EfMO9DS1mr705D3qJuHV82sL+pdZyCslR3N3PtVdKNv
	mjq20dFPW/n9YKYeUKK8ApGzOuacwib72RZaLUP8Sx1TthhAOEPnoJGJaqyI9JAMQ9KSGa
	vpqPx012QQZ9PEikrpoAHykWdTMiy0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JGCx6F4+Ay2OqECGuNQLkxJfy0M1oW7cmEg7w2YJK6o=;
	b=YB1/XMJuuv9xg3O0jUBrMc1QuhHMfwPKPk6zeVi2nNN9+pKBSVWRNxvGkie1NLous1Q4tf
	7EnxXb8JgaChnozRwyFRn4i8ohpofiL72mL4lOk9Z4cYQYZ/pTluYXHu4RMPAkD4Hmakbw
	LOdK2eWWDOxlSk5L0T4vVHaeud+8wxA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UTZIDW0j;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E74BD20536;
	Wed, 08 Jul 2026 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGCx6F4+Ay2OqECGuNQLkxJfy0M1oW7cmEg7w2YJK6o=;
	b=UTZIDW0jUII7kD1ItEgPa1ph/Yf/im0onBDQP3trxfwmZp50XtmdR0LSZUfxBV8H8ETBnE
	RCmVtMVTOq+XWEigG1Yyv2I1LR3DoPgNhb1d+dT9QtLUpOznyNtwcwHipxdGe0e1zhGXaU
	oNq2ncFrsP/pVcv6K9gxkarl9EZrOqU=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:10 +0200
Subject: [PATCH 04/12] batctl: netlink: report dump errors signalled in the
 NLMSG_DONE message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-4-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=sven@narfation.org;
 h=from:subject:message-id; bh=MdY8JlyTRIfQ3AnO6+z+wpbxAj+dNC7JWS5OMMwGu7w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azx8Tvt6z2P9IL9WITLXTeSB73bFqIYlOlbadQqX3
 8dKPoroKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEykXJiRYfaGA1PnsnRmzPU6
 snraqa2xqcsnt5pcDWFrvatXJMOfIMjwP3Py5bwDzDMfFj/tKww0FY3///l2VmeS20ul4N1aJdp
 KbAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: H2WPFNECHKYULL6Y62S7R4WZUTMSYBTZ
X-Message-ID-Hash: H2WPFNECHKYULL6Y62S7R4WZUTMSYBTZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H2WPFNECHKYULL6Y62S7R4WZUTMSYBTZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a dump is terminated with a non-zero error code in its NLMSG_DONE
message, "Error received" is printed but it is missed to update the global
error state (last_err). netlink_print_common() therefore returns 0 and the
command exits EXIT_SUCCESS despite the error just printed.

Fixes: 854835788001 ("batctl: Move routing_algo specific code it command source file")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index dd0275e..e8b41cf 100644
--- a/netlink.c
+++ b/netlink.c
@@ -316,8 +316,10 @@ int netlink_stop_callback(struct nl_msg *msg, void *arg __maybe_unused)
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	int *error = nlmsg_data(nlh);
 
-	if (*error)
+	if (*error) {
 		fprintf(stderr, "Error received: %s\n", strerror(-*error));
+		last_err = *error;
+	}
 
 	return NL_STOP;
 }

-- 
2.47.3

