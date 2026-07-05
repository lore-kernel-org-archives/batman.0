Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA2C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 13:04:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 601908457E
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 15:04:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783256696;
 b=R5yvvjmSqEMDG88IHUAS+mIYAWpIkBMGMPCz0d5ACL/I0ENJiJxFYWSUYXij21ueGk/Tw
 pMhtgqiLfTKEQmJX9larp/uURJNX+dsBUWs75kOkeeOTis2N++6NTeP9YvtjGk1osGSkgu1
 apq5RfaOJB0LNySEEPHeZSXzgInT4x8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783256696; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7Mv8xD1NudtUA6EjmJ8jS26c8GuZ2auSnllaYkN0qjg=;
 b=uAbeeJUStjMxEBXIwj/AjurEe4BjqT+Fhrs+Nd6pG2kbkWk1zRA9gZ0JyoG1As0OnNw4i
 Xqo3Q8kEqlYMc5T3i/gFYPtVcpzrNx2Qn0GufU7thzMw50uoe/fwN8jGemJyNBiSKU4KY2q
 jtCpFUcDFujiPU4gEogQL4HbLpSewwQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CEB1B809E2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 15:04:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783256675;
	b=MdvEWNsyaJ3OC1TUDth97VJBdH5G5/nsPxksu2uAdyIVwGdHXNRjT7iE2mQfOPGf5LU/b4
	Bd9ozQFxHGcr8iRuR2KELhNt7bvCWAuhmopZLySkFhA6nuUwnlkYWe3ztErTnFgLKL3K8h
	wlH8+sXqEQ/GNaxXC1ffARPBbfBwGog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783256675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=7Mv8xD1NudtUA6EjmJ8jS26c8GuZ2auSnllaYkN0qjg=;
	b=OQ6eYCT++uAZZWazaHjs5d2ZjIxYKafb71jq9PYaOIoCDkgOaS8taeGP2oYckhAUncz1DF
	9ysgaHLhs7gI9cnZJdnOkfpxjwMcXNnYQrDLiwME0eJFcA3Xu14gjEFnbK8BiZpRu7CTj6
	TxhfH+609TEEZdLvLQ+GbG49AeBXPw8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Kl8xX7s0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3ACF41FD9C;
	Sun, 05 Jul 2026 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783256670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Mv8xD1NudtUA6EjmJ8jS26c8GuZ2auSnllaYkN0qjg=;
	b=Kl8xX7s06v8UD503cMhcmuN9M+ZRXdaEZU/lUlSHDy1useBt8IIwTGHWgAQNGSTWi+ZykA
	RbMXGWYyTVe/3lyMhSJDaDelvkOO8TCk9YLRuL244srI9ljgO1fA7sicekYp42M/ZkNf6L
	k7f5XPN+IlJ//kKNS5MCL0C6CsAozEo=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] batctl: interface bugfixes
Date: Sun, 05 Jul 2026 15:04:25 +0200
Message-Id: <20260705-bugfixes-interface-v1-0-64743906b3d4@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlWSmoC/yXMwQqDMBCE4VeRPTeQBkmgryI9mDjR9ZBK1hRB8
 u5N9fjB/HOSIDOEXt1JGV8W/qSG56OjsIxphuKpmYw2VjvdK1/myAdEcdqR4xigLOBtiM7FfqI
 WbhnXpHXD+7YUvyLs/yeq9QcvyFj+dgAAAA==
X-Change-ID: 20260704-bugfixes-interface-6eeb6cf77f4d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=706; i=sven@narfation.org;
 h=from:subject:message-id; bh=Blv1t6wc2ToFB+ajInLjP6rF7KAqJLTs7WDWkfyn6lQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleYVEcl6umSVR0s+Wk/7nAsfPjHY/rEVbPFszim+HXe
 foaX0JcRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiGWcZGY5OuXNu93rH/Y7t
 jNxeewwbjpvIni/wuxkQVW3ZWy5QZcrIMFkvOzpJfrH9gxfHtoit6BYvkAvbbRWxd8drpbiZjjZ
 hHAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AEGCPOBM2DDJRFIYZWKY5RDDCNSAXQP6
X-Message-ID-Hash: AEGCPOBM2DDJRFIYZWKY5RDDCNSAXQP6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AEGCPOBM2DDJRFIYZWKY5RDDCNSAXQP6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I have now splitted the bugfixes for batctl in topic branches to make it a
little bit easier to review. Similar to the "random bugfixes 2026-06-21"
patchset, they are just various (mostly minor) problems which should be
tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batctl: interface: report rtnl query failures
      batctl: interface: return fail for non-existing interface

 interface.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
---
base-commit: eb9597d4ca6db17c579f5ae9443c51b013e2fe65
change-id: 20260704-bugfixes-interface-6eeb6cf77f4d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

