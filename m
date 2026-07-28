Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA63C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 21:52:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 52243820F7
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 23:52:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785275524;
 b=i6y/4IJwzVv6k9jLYPyjoWC5moB4hwc69i2tNoZywK5EbpxZD1QVueq5O7vC3vqw1KdHR
 7SGWpCTKZEwBVtt6vJIDPNqkrIQ26aRAxVKzVmZWxglQoWDA2j9Sko0BEDcnUGjkzgQ8Et/
 WfeBB6gQMGm12VSBwYq7TCW2+FrOHSE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785275524; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TPnYcXCoBdz6gYeDNvSwlgMTju8oIOqr189hd2jJsDM=;
 b=x901ic1onTDehNSpX/OxRpn23DhEdLhtRE0CpWev0ojg9Vi34FJdceRN8b6WId55nk0np
 mOXwslIM/0XDbjCn8S6uGi8IWRDIhRmV+tSH7EMtkutcqlMb0L7WtG/isQeEdwzu815O1KP
 gq8DnYrpvsZzd0UuDbD/D+p5FCl0aiQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CC36F84B98
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 19:26:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785259587;
	b=dQayiAOQDdoux/lqJRf727HN9m5La3DjTDMTBopcHUNxpm1++XsMcokYts6uoyWHg5SGsO
	o0HhMvq84/kZ5UPmTEhYielRDLiXGbKDZuxAZh187Hrm9PZSV/bSZLUJAh9UF/qB2VO4lW
	kAzocSRpkxX+kh3rap+1z16giSPOUsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785259587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TPnYcXCoBdz6gYeDNvSwlgMTju8oIOqr189hd2jJsDM=;
	b=NLvqA8BtFTx4pjmAGKkhEIn4GNMhRCG8FscrpMntUBuoNLzXHFcX2Q0htm0NlvKT+4QT6E
	E6qsGzOBO50hanI3nK2p4zeHTwiFc40A8TBuDHaw6/bMBaFzjIoTUOttmSgRRtNRpB9mkw
	D8tmvXwmfpZ2BGM5kOiVetJHuk05+ZY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sKbx0xVW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3C3F7200D8;
	Tue, 28 Jul 2026 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785259583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TPnYcXCoBdz6gYeDNvSwlgMTju8oIOqr189hd2jJsDM=;
	b=sKbx0xVWA3ufDdrNV89+z5ryBE8/xSkKG/stRLExfuUTE/9QSkJc4cTeh1xT4KG5Z7Uhb7
	04x5ikWfcrDUmnrryLj91X5GdEkUhdQjK41D5YYrWbuprHpP5MsG2vfXr82/E98f8vQozJ
	Uc8rQqPCHtI2U1JEmdfHAF3Db9eGjqc=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] alfred: netlink: random fixes
Date: Tue, 28 Jul 2026 19:26:17 +0200
Message-Id: <20260728-bugfixes-netlink-v1-0-d338671f316b@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnmaGoC/yXMQQ5AMBCF4avIrDVpu6BcRSyKwSAlHUTSuLti+
 SXvfwEYPSFDmQTweBLT6iJUmkA7WjegoC4atNSZzLURzTH0dCELh/tCbhaF7KwujFJWZhCzzeM
 3iFVV/+ajmbDd3x+47wcBpDCJdAAAAA==
X-Change-ID: 20260728-bugfixes-netlink-90da29811a06
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=sven@narfation.org;
 h=from:subject:message-id; bh=MXoBsmnll6nwX6p5KmlS7FsB8RedEPdhJkRfrPDLSQw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZz6xzov9u1D/7/mVB+uc5sRNffOT/+X4jq9vLiI8Pf
 vBsrW/a21HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiOF7RoZvpz+F/FsxX37f
 GaFF8Wtcdp071vOrafHtbSk7fOK/V05sZWSYGnpST/nFOs+/d7ij61UjU8MS7I1r7krlsrbZHpa
 ddJgBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZPV4VMDCE6ENWXM332PQF27LXQOY5VQA
X-Message-ID-Hash: ZPV4VMDCE6ENWXM332PQF27LXQOY5VQA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZPV4VMDCE6ENWXM332PQF27LXQOY5VQA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the batctl fixes, I have now compiled a list of potential fixes
for alfred. Instead of posting everything at once, I will be posted in
smaller chunks. They are just various (mostly minor) problems which should
be tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      alfred: import batadv_netlink_policy from batctl
      alfred: don't stop translation table dump after first entry

 batadv_querynl.c |   2 +-
 netlink.c        | 277 +++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 198 insertions(+), 81 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260728-bugfixes-netlink-90da29811a06

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

