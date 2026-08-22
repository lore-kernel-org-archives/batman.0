Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD784C5DF8C
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:14:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 05ACA82E1A
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 15:14:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787404480;
 b=OH9VUUZ30E6lBFiINiOxR2b2ywgxW0D3yTMz2LrLJ65gXBwQImUt+mk8mtnCHgXn0mcyl
 RuJ40R4qmmwrPHkgoECDmp7ZPopecR+D0+0g70wPWd5wC/tNBoVjWg4GApF98hp/kcdARan
 jx3satAUF2JlB6UEbQuadx/kAAbfIVw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787404480; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9cdkv3c656siraMNR1gnGlrbYT1L8HHak/MjIbV/nQ0=;
 b=nbPA9c0Fx0vhPS1VBfFnwAumrL0HkTdq7yF024D/KFP4jFo7rMzA/zTvIv9Xl73atx4+j
 HqE7MzxmiKGOkEI325u9ezzLe+Venk5LhEIM3C9pLBju+uUcvn+DSXii73n38FpE+BQ34CH
 EPfCnof5RDRGADptmVQW59Q9m86zNp8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 349038067F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 15:14:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787404472;
	b=Gdql7gzfCHHy0N9N4HMCGE/IvSkpGsOw8HliBssWgy7nk0AJRMuJ1q8+lvULGlRlo0XBew
	qMo7LRXr8mAlXgZ/d4c7c5GGWNx7psHvKe8iAH/xYDsivsffhrILUjFoo25boS2TPm2GBt
	sKfYBz4fBUbiwekFASmQNZaYLA0rZ8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787404472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9cdkv3c656siraMNR1gnGlrbYT1L8HHak/MjIbV/nQ0=;
	b=ETPIM/EXU/aihPKS2v5Y548jl+05fRwQ4b8c3Jj7DRixgayUe9/AmcdPwNofxoPZIhr/RR
	f7xHEx7Zcqs4CuoS3Es0U0OCfQ4WdD6C+UKG3hS86NyZcnxfBw0JqNmFgeNOynlyTv19eP
	ctbmsojoo2JHpnNIr52gcqR6FjeeXKo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Itrzzfso;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 26E7E200A3;
	Sat, 22 Aug 2026 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787404456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9cdkv3c656siraMNR1gnGlrbYT1L8HHak/MjIbV/nQ0=;
	b=ItrzzfsokgdvaToePcYzJWH1DBdMrJDnETnMft+1JGPsYTSqYYJ+pQaw1n7ngTuWnkB0sr
	8B3sWDRQBWb+Lgp731bwWYHkbN/o+9QzjbPRGNXCf45f0eiEzSaLqZN1EU871gzbMkbPZI
	89aLL5F/AxJnpRvUqHiwm16hPP4IrtM=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/2] batman-adv: enforce u16 MAC address alignment
Date: Sat, 22 Aug 2026 15:14:02 +0200
Message-Id: <20260822-mac-u16-alignment-v1-0-bafa0040ada7@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqgiWoC/yWM0QqDMAwAf0XybEADFvFXxh5iGl2GdtJWGYj/v
 m57vIO7E5JG0wRDdULUw5K9QoG2rkAeHGZF84WBGnJNT4QrC+6tQ15sDquGjJ46z93ktBeB0m1
 RJ3v/njcYObM/4P73aR+fKvk7hOv6AHPa5XN9AAAA
X-Change-ID: 20260822-mac-u16-alignment-d25da5f6e8cc
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=sven@narfation.org;
 h=from:subject:message-id; bh=kWVUARq8/if3k5Dn3WnbLV/gwYClPl863WOBtCn3Hbo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmdC+Zmer8Iza/p0Dr/vGSKVoHd+cQNpydOrOU6/2d7Z
 lRLb8HjjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBElkxhZNj6sYpd7WvtPN7q
 8FMPXxn2zfd8lc71aV3NmwW6l7Wdf81lZOgxPGmecXqOboMsi3RWyN74C1u5QuZz+Wztl1q7wXP
 DDD4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UWZFDTUXJQ27LIIAMQ3W73OIRESLG357
X-Message-ID-Hash: UWZFDTUXJQ27LIIAMQ3W73OIRESLG357
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UWZFDTUXJQ27LIIAMQ3W73OIRESLG357/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Sashiko reported problems with mac addresses on the stack as part of
https://sashiko.dev/#/patchset/20260821094813.201800-1-sw%40simonwunderlich.de?part=5

> The mac array is allocated on the stack with 1-byte alignment by default.
[...]
> Because ether_addr_copy() casts the pointers to u16 to perform 16-bit
> operations on these architectures, it strictly requires both the source and
> destination pointers to be 2-byte aligned.

Annote MAC address ETH_ALEN arrays to avoid this problem in the most common
cases.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: ensure u16 aligned mac address arrays on stack
      batman-adv: ensure u16 aligned mac address in structs

 net/batman-adv/bridge_loop_avoidance.c |  6 ++++--
 net/batman-adv/distributed-arp-table.c |  8 ++++----
 net/batman-adv/mesh-interface.c        | 12 ++++++++----
 net/batman-adv/multicast.c             |  6 +++---
 net/batman-adv/types.h                 | 26 +++++++++++++-------------
 5 files changed, 32 insertions(+), 26 deletions(-)
---
base-commit: f3c33e7fcb7e88cc099b783faf26f0494b774571
change-id: 20260822-mac-u16-alignment-d25da5f6e8cc

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

