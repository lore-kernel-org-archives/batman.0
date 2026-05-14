Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED9ECD4F25
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 15:43:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 407E585CC0
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 17:43:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778773435;
 b=bcFNTxLeCn7V+cIr6S1n8ZSSJFDWsJBlMLe7Yt4x21MQUNkZBzj7SR8yfF6UWJ/GPXCfd
 LhQpLxEN8R0dR51LCgmXQe850cvQLpBhN7b7mFHNRbsX5PUU5uzrM55glVOPAIb0J9M1kbZ
 OStLL3t15nQiHaJv8LibmEmSf0FCLOg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778773435; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=taBBQoThMEZy8+Ky4BMfKtGSmxCfHY7mbbfPx80Us08=;
 b=ebjlx7xQ+r+Jm7W1XIaK5ioMewGVfBettYhSq1vbN6Qa9Ec7S1BitUR+tTmNax5H/IHZm
 p+tk0tHWNH/EZRm14Ds7U2UgsBHL8eFGRCKAR7OMCbJCitlSVlUHSLdWY3kWuLSFqnFpc8X
 fXBeWVcGFVqtppqNmDvtLiZMtMp8rKA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0969E805A5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 17:43:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778773412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=taBBQoThMEZy8+Ky4BMfKtGSmxCfHY7mbbfPx80Us08=;
	b=XT09ivMSpjx0J0mwDGY++vs5rCX11gmzJ74JP6hreVcpxoJ2ddMjryBdNRz7rSNIc8l8iP
	uRAEHuz/c7K4JPKpffUl9xdyV5Gb0gQp0e106opQUWj8M2YzQ05Cr4Icg+LQ6uJAUta+j9
	BNe6Ihao6ZSb9aeZloBoLKagD3BWpVs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XD20f0Qq;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778773412;
	b=3OGJfkHpWrSveeCylwWQSthOoISXmhrL6C8N5KRcixZeRrV6nKW/q2QlP5o+qNz4HILY/K
	Rl82svfDJ4w9pXdsajBUXIf+CmZGY7uArcfii0OxyWGzgask+tnmRK6ZQPrPFd11/vZRv6
	htH4EIWS5B4Iv6kYjP0hP73q2qmpNGU=
Received: by dvalin.narfation.org (Postfix) id 8B7881FD98;
	Thu, 14 May 2026 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778773400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=taBBQoThMEZy8+Ky4BMfKtGSmxCfHY7mbbfPx80Us08=;
	b=XD20f0QqSGygjQh8FURPP9yccIMWVkqD0I7joVln2jV20Wn96Rc0NAdw2Yf9unyReEqHnu
	m6odep3LH4prSoqmUK6BOACZKpTIx62ubc6yk3xt9FsF6Q+eeaCMq7DQkR5z1kxXYCeM9K
	93WmonektAIReusk1o2YXEAtrid4/jI=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v3 0/2] batman-adv: BLA fixes for sashiko reports
Date: Thu, 14 May 2026 17:43:11 +0200
Message-Id: <20260514-bla-cancel-work-v3-0-dc65d3485e11@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI/tBWoC/3WOSQ7CMBAEvxL5zCAvWTnxD8TByyQxIAfZwYCi/
 B0nXBCIY4+6q2YiAb3FQHbZRDxGG+zgUhCbjOheug7BmpQJp7ykBaOgLhK0dBovcB/8GWqjy1Z
 orhXLSVpdPbb2sRIPRMlRmkiO73u4qRPqccEtzd6GcfDPVR3Z2v9riQwYiLLIGyrypsB276Rv5
 Zi+3Q6+Ww2RfzLEL4MDhUazytTcVMjNN2Oe5xcDN8YfEAEAAA==
X-Change-ID: 20260510-bla-cancel-work-8dc6f3c2cb14
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=sven@narfation.org;
 h=from:subject:message-id; bh=HRJEvbNthn19scTOtF4bqA4mSqVloNyjUXU52ZvzF0c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmsbydfuZKvuGnSNVfnlgPfWUIenTDSt8vZfndhkCZ75
 OzaZYGBHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJaHUxMjRsSFn9tmmnhcXr
 G5EnNvwwkKm8HHrx8s3S85pRBkv5ry9jZDhQHqhkGrXGcLpPoqJ1T/Di7f1/mJSUvyyw2s7X0ib
 8gR8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7FA7LMKYTCWO7WYACVO4ZOIREJ4CYTXI
X-Message-ID-Hash: 7FA7LMKYTCWO7WYACVO4ZOIREJ4CYTXI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7FA7LMKYTCWO7WYACVO4ZOIREJ4CYTXI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were new sashiko reports for bridge-loop-avoidance

* https://sashiko.dev/#/patchset/20260508154314.12817-1-sw@simonwunderlich.de?part=7
* https://sashiko.dev/#/patchset/20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org?part=1
* https://sashiko.dev/#/patchset/20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org?part=1
* https://sashiko.dev/#/patchset/20260513-bla-cancel-work-v2-0-9c17d82d7e2d%40narfation.org

These can be easily^W tackled. But they must be done at the same time
because they are modifying similar places.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v3:
- get rid of the idea of being able to protect num_requests with only a
  boolean "request_sent", instead introduce a third state "stopped" to
  prevent num_requests++/-- after batadv_bla_purge_backbone_gw() ran
- ignore Simons Reviewed-by bla.num_requests patch because the original
  patch turned out to not work out in this version
- convert also wait_periods to a simple u8 and prevent it from underflowing
- Link to v2: https://patch.msgid.link/20260513-bla-cancel-work-v2-0-9c17d82d7e2d@narfation.org

Changes in v2:
- add patch from (to avoid conflicts)
  https://patch.msgid.link/20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org
- modify bla.num_requests patch to use lock over both request_sent and
  num_requests
- Link to v1: https://patch.msgid.link/20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org

---
Sven Eckelmann (2):
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: bla: avoid double decrement of bla.num_requests

 net/batman-adv/bridge_loop_avoidance.c | 103 ++++++++++++++++++++++-----------
 net/batman-adv/mesh-interface.c        |   1 +
 net/batman-adv/types.h                 |  39 ++++++++++---
 3 files changed, 101 insertions(+), 42 deletions(-)
---
base-commit: 57c6af492c1948145db835bb3ea2980472558298
change-id: 20260510-bla-cancel-work-8dc6f3c2cb14

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

