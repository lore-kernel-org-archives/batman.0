Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDD5CC6B34
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 06:31:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB5EC845AD
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 08:31:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792045898;
 b=cM2IJ613flpOVomE16o92kilQ0qQgohrzp+5JaRCyy3HmsW4t0+d9kb80lK7/vG9J4fLN
 okuNC1tKG2isAT/i888PEvO2DW4ahnYHn21aGUN+SOL2VqVk7xuwVweeZMBDnZ5e8p6mUs8
 uDwN2qzpyN//uRgFlK3A+PQ6w+FGP2g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792045898; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oBiu0YvGgE60l/XBSkqzmtAXMmH2FcrScaDGasWYSH8=;
 b=iiY5ZdfzMZo2aM+ZthV5ylWOqR9xHWH62KeWj3kDxdE4ehD+nJZHYoGKxiLctmwyHILDw
 y9Jdv4As79hS520u7orVVYyOBmwicsC97E5MJF9u2Xp1Os6Js+vqMxUXhkt45r/VWpTpRg8
 KnhC6Ce2gr8E63OFQ52Wx9nBghMpzcg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7AB8180A3D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 08:31:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792045887;
	b=AH6wFHK5HkoZFNqo+TOb8YlIOHEcZcifuvOwDGybfI+RWFqxVkgHUDsGAzIxNYLJOzO1y5
	LBK3Knv+Zuf9g56RFeLLr/pHv9frRgIvEYibs350WYoKtqXvFzisp6vA3/S4nVGuF/ZjjW
	/XXQIGU7smcX34YvA+3Nl+1jg2euORk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792045887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=oBiu0YvGgE60l/XBSkqzmtAXMmH2FcrScaDGasWYSH8=;
	b=Z7KGbLchs1IbC979Ch+XYoNLXouPNZeF2z4xAT6GI0/mgl6I71tfXBrw9bZqiziElBHHPf
	yBJaCCgnA0LbvwzP2O6/o3Zt5WmRCVDSUeKVD0tAp97eoMi8NGNMwocEzrxo6TwKhgs+V8
	bNH35jO4RLH3HrnKnlxeUrAPGEP/pJY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bu2Tn0LY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B797A20320;
	Thu, 15 Oct 2026 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792045871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBiu0YvGgE60l/XBSkqzmtAXMmH2FcrScaDGasWYSH8=;
	b=bu2Tn0LYBLMfcwkdu47rm6JvazZgvxNZlrvZ31zYHLe0hj169nTSyJQJf2/GYXvrMerAUW
	QhKqOLS5seKCadS6c144Wa5+hJZFLqmdi1nOuSBPQPiOOL+/azqu/ftvK8LI53w0DZxUAW
	slM7e8uYpZrhe+aNHasoMnLBNoAeXvE=
From: Sven Eckelmann <sven@narfation.org>
Subject: [batadv PATCH RESEND 0/4] batman-adv: avoid mixed
 borrow/consume-skb functions
Date: Thu, 15 Oct 2026 08:31:00 +0200
Message-Id: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=sven@narfation.org;
 h=from:subject:message-id; bh=iq7Cbth8Ngl/pMV9IhyxF/TeVRgTDzbYiXwTDl2HCHU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkXitXWNfFzCyp6m7T/u7Q/zLhGJNBA94nTv7si3Q+D/
 1XPMrbvKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAFykmuF/8lr7b4c8bvaz+eYZ
 JkRucJojXfFAbteX67vO1f4tW/oukpHhvVf7M09BpfmLLarunlhjlrFclInnqE7oxdivMiqh3Zo
 8AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YIYUUGDAHW6AXFKXGS5POYDUDRIFUHBB
X-Message-ID-Hash: YIYUUGDAHW6AXFKXGS5POYDUDRIFUHBB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YIYUUGDAHW6AXFKXGS5POYDUDRIFUHBB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the past, batman-adv was changed to have a strict distinction between
functiosn which consume skbs and functions which just borrow them.

Unfortunately, this concept was broken in various places. As result, more
and more bugs were introduced which are related to skbs which were
accidentally leaked in corner-cases.

Modify the functions to ensure that they are belonging to exactly one of
the two strict types.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (4):
      batman-adv: never consume skb in BLA rx and DAT incoming snooping
      batman-adv: always consume skb in batadv_forw_packet_alloc()
      batman-adv: split fragment forwarding into lookup and forward
      batman-adv: document skb ownership of always-consuming functions

 net/batman-adv/bat_iv_ogm.c            |   4 +-
 net/batman-adv/bat_v_elp.c             |   6 +-
 net/batman-adv/bridge_loop_avoidance.c |  13 ++--
 net/batman-adv/distributed-arp-table.c |  10 +--
 net/batman-adv/fragmentation.c         | 107 ++++++++++++++++++---------------
 net/batman-adv/fragmentation.h         |   9 +--
 net/batman-adv/mesh-interface.c        |   6 +-
 net/batman-adv/routing.c               |  31 ++++++----
 net/batman-adv/send.c                  |  31 +++++++---
 9 files changed, 122 insertions(+), 95 deletions(-)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261013-skb-ownership-e97162f86c9b

Best regards,
--
Sven Eckelmann <sven@narfation.org>
-- 
Sven Eckelmann <sven@narfation.org>

