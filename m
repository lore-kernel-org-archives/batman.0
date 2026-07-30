Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE862C55162
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 17:33:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C66180B6E
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:33:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785432808;
 b=OTSwegh/mDV0lOAb/yoiVOCBPivJs+LVzbvUXVDlemuAg7yIMeRW2Jh/kJIUKzZc6nOmZ
 QS7+xgXbkel4/qLL1W0vDJEKYJma2ig+/kc4SSWePp2AsBr2cPYWEbKWgNrs2IRpnqb1h4Q
 6J02NbArdNOV8rpzTLTtNrbfdnQZNrg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785432808; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Y74bkvTnVo9/dfW9d7yrSMDOnQfiApRbY2aWhXVyrvM=;
 b=svHFopuKVXLw513CUtOjt6CEgvPVvGXgMmfF5WHbXwF9ghuUvxsrpNRchN4Wi2+mBYxps
 QSxW/wQS7nr2nX8E2uN8vuK1ci9OOV/yV9YPcflA9wBCOEKEfxEHCHjXtm4IxHzECdNkP51
 hoJAjdI1S0+nwHSvV5T39dsgcxFSE+Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CD14F81C1F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 19:33:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785432789;
	b=gDmsLLkn6YCtkYh6IibYLIeCLK5hRp0karXgeIWZWpRKH7dg5+huymqpcOjD3EZJ926xcG
	6DBS3i8We5VmvhEpXdDvR9cXjYKzXY3q56U1e62dlhBfFxESgC1ME1wMJxxlvz25GhIKxM
	2EkA+KyO3XQRGTFWkTPl91IiKrYBz2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785432789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Y74bkvTnVo9/dfW9d7yrSMDOnQfiApRbY2aWhXVyrvM=;
	b=OnM6P0LQtvlCcTfZOyXZS3mWn89RYXgqBPor9X9888i/it8vfPP7vrktSgoOYwf3A3OT6O
	h4nrbMCOtwq15e22IxcvDH17/8bhkLFr/ceVDfn3gPkeBx45MSyafKYII7cxI9W2G295lQ
	oF5Ym53ESXX5xUO9A5zIfk8FOPokf3Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=trO+UKFK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EDBB71FF5F;
	Thu, 30 Jul 2026 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785432785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y74bkvTnVo9/dfW9d7yrSMDOnQfiApRbY2aWhXVyrvM=;
	b=trO+UKFKFjVFJClsHHBlu3LqWlbQLwYXNnDiK1h7ogx8vdQrDGlg2ju3WvZy6QBseZIvop
	Tp5hf/oN5M5LOXmIdQn9AIry34rzTebW/+pvUaOg+74+ohMBHO3hRffc7HkLKbvv7mLy7F
	QOo5bG6tzuKOA4N+Mv05q5S4FtwJa7c=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/4] batman-adv: tt: atomic_t sashiko fixes
Date: Thu, 30 Jul 2026 19:32:55 +0200
Message-Id: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMeKa2oC/yWMQQqDMBBFryJ/bSCdQoVeRbrIJGM7XVjJRBGCd
 zdtl+/9x68wySqGe1eRZVPTz9zg0neIrzA/xWlqDPJ088PVu1LcpLuYm2IgHoiEOaHlS5bf0Oo
 RHEpIGx5/byu/JZbvD47jBEZz/LF0AAAA
X-Change-ID: 20260730-tt-fixes-fca2b722ebbd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=sven@narfation.org;
 h=from:subject:message-id; bh=n24E6k8q5/sMvVL8EVl01CYUXhD51HYDWkBmr/Gh3O8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZXSeSfmlsnly9mt+VY5pe8oWm/7e2HG3mmvZlk6xeJ
 RezbA5DRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAibIWMDAtr7uYfeuFvXppm
 abxM9t4n1Xzf7f9+z37z4Z/xxyc39HYx/GKau3TXTH6WoJJXW/Ivs/8Ltm3QkDjhr3nUTiXijGm
 9Fy8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RGTH2BRTB4RYR7DNVAPJGULCG3PVAQON
X-Message-ID-Hash: RGTH2BRTB4RYR7DNVAPJGULCG3PVAQON
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RGTH2BRTB4RYR7DNVAPJGULCG3PVAQON/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were a couple of sashiko reports regarding the
batadv-next-pullrequest-20260728 PR. I went through the TT code and tried
to handle them and at the same time already predict what else sashiko might
report as next. I needed to change the batadv_tt_local_remove() hash
interaction as preparation for the related NEW flag (and counter) handling.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (4):
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: don't directly clear NEW flag when removing local entry
      batman-adv: tt: don't uncount never committed clients on pending purge
      batman-adv: tt: fix roaming state handling of a local client

 net/batman-adv/translation-table.c | 164 +++++++++++++++++++++++++------------
 1 file changed, 112 insertions(+), 52 deletions(-)
---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260730-tt-fixes-fca2b722ebbd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

