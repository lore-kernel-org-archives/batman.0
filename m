Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C452CD98CF
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 20:58:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E95488449E
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 22:58:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781384329;
 b=2pFbNU5uWbqEHYmjH24+TK/DdqcSc1Wpanmchoac4BQVW76JlG9nU4AK81FxAC+MmDTqY
 dUTuiA+SVGkwCM8dTlC1OwTE5cnkiJZKZvO7jKxqhGzfTPW0qKJfGeE8ugyHFUNFrIUH3Zs
 jMIjaFFtVl2XIadT0iOZMUVIEpYm6/I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781384329; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FI0UtbqOTZ0H/SRfgFuaHe1VlCRpfn6nC+Es6tRuGoE=;
 b=DyGvteN4wgpk9UVZmuLd/Za7zh9hlJPgMNB+uOP5k/X6gYfhh95oV3y/yS96iYUo7UTa6
 nzWXgr8zSgzlSyGB7ErrimnbeS6gLHrVZp/wsJXJl+jQfh6/QMh6nNA5IYRPUGp/95BCUo6
 EWLoyTwZPH4PB11UqPM0AJaiZEMfSVo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6FF7680FAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 13 Jun 2026 22:56:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781384223;
	b=MyWb6cziLVkc64ap6rqa6Gt/an/rR0i9jRJOE9jHhyxOMmK/IjLYnFvNI//+A5a92T9h41
	VUyOE35zgD9E5JuEqodWC8ftmc+C8oQfmJxoYtCiaetyFo/E+MF7mAkTMMD3Ts62riTuHC
	iRBExDLnEB/MJ6yXkj5FM7+HUKuzuu8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781384223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=FI0UtbqOTZ0H/SRfgFuaHe1VlCRpfn6nC+Es6tRuGoE=;
	b=nYygUAkhbOjT8B0NBJcifI9oM+DfyrxLI752msFIqOE/96ro1O7onOUnMaqZU6PoGLnwO6
	PkutSgmBbWA1Zm8WgKRqlaATjTgnmFbtwHlQO5NUWMtVATP3++/sQohOFEcgPLktiRxDjG
	WkaT9KHq72niseoALgQOCUHo/C3S3LA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ifXfJj5Q;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BA0A01FEDA;
	Sat, 13 Jun 2026 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781384212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FI0UtbqOTZ0H/SRfgFuaHe1VlCRpfn6nC+Es6tRuGoE=;
	b=ifXfJj5Qvbc4zl2pzkShYsETdRaW73XRk3QlLpG1kOeqXpPBh6RGrAmMmxegrJrLIjWQZ3
	1+HDJtZlNmbCxW4r7G91JoV6AxA+iB0AQ64FulSbQ5dHs++tYS6w9pu98FhIM4ChSVj+KT
	BCY1G8DeXVdv6xcrDJ/mJt7LhSJaC78=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC batadv 0/3] batman-adv: tt: use atomic flag
 modifications
Date: Sat, 13 Jun 2026 22:56:40 +0200
Message-Id: <20260613-tt-atomic-refactor-v1-0-9f6a762c5d24@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjELWoC/yWMQQrCMBBFr1Jm7UCTSKFuBQ/gVlxMplMdwUaSs
 QildzfV5fuP/xYoklUKHJoFssxaNE0V3K4BvtN0E9ShMvjWd23nApohWXoqY5aR2FLGnvvoA+1
 dGD3U46sa/fyiFzifjtsWyWiY4frX5R0fwraFYV2/VsZ2FYUAAAA=
X-Change-ID: 20260613-tt-atomic-refactor-9c9b23a413f2
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=sven@narfation.org;
 h=from:subject:message-id; bh=FlKQj8EFzhghTNKTBaMPPVnpSoW3jYDx7hRfFRpy5/M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm6R3iMNdJjl7y3k2j9rCXKcuW+U/l75StvbUNEJtbdf
 Zvv5MvSUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIr0eMDP35vKKn6j/cVFCc
 /PfrgbPnzvzOiGlm2NvNe+p3q+cNqdUMPxnZnssZL65w6Vv13Hk9+5lmc/15E693qVtZJC/mfmI
 bxAsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DSNYWUANJMUPOCN6QH4OMVHQX2DLARM6
X-Message-ID-Hash: DSNYWUANJMUPOCN6QH4OMVHQX2DLARM6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DSNYWUANJMUPOCN6QH4OMVHQX2DLARM6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The flags of translation table entries are modified in various places using
RMW operations like:

* read flags + add flag + store
* read flags + remove flag + store

These were done without making sure that no other context is doing a
similar operation at the same time. If another context does modify the
flags then it could happen that a store of the flag modifications is simply
lost. This problem can usually be fixed at a later point when the flags are
tried to be adjusted again.

To reduce the time the wrong flags are used, it is better to change the u16
flags type to use an atomic_t with its atomic helper to perform these
adjustments.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batman-adv: tt: don't merge change entries with different VIDs
      batman-adv: tt: use atomic flag modifications
      batman-adv: tt: simplify NEW flag transition code

 net/batman-adv/translation-table.c | 258 +++++++++++++++++++++++--------------
 net/batman-adv/types.h             |   2 +-
 2 files changed, 165 insertions(+), 95 deletions(-)
---
base-commit: c7518adb8b6ebdc481f6ed1fc42c7f45099806af
change-id: 20260613-tt-atomic-refactor-9c9b23a413f2

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

