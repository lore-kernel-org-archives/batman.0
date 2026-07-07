Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AFEC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 19:19:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7FA848423C
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 21:19:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783451974;
 b=gC5XaMSr5qbFKxJxpWv5A6g7k4PFJY5XpnTAfha867mcfo/8efoGD0AnjzRs4S3PFBU8u
 gRozPVsODoQVTIT4FcLgBWB7ZcuIKwAgu247BR2HaUqtKEG9y1uOHpDoJcDwcbwDwzmCl8G
 6rl443cl10RyLfQplAy/UtTaOv4I2JI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783451974; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f/KtcJgaNkHCflPXkp8SqtuePVBeflEXIwIHcfUjd8Q=;
 b=ttPlCiudQa6LcVWWI16AxYSEhvlWXbEEJiaKZS5KOf95tqC2dMbNV2Oc9EpTnHsLqNz5G
 5xXp7vCtp/uUomKCnr9v9ilYOUfbbARDaZwUdoYOiAMzBHRvLrxu/dEAXC3u5Y3Ea3k7mkp
 9nbu5sSZCmgFhWYKeAgxYSSU3XmJC40=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5E167810D5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 21:17:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783451838;
	b=Gsh7xZ230LJEWaOuP9QVaEI+3RQ789E6SYsJDtqBECI1Se6coVkdHL8L+9ubqipmzB/9rn
	LbbHj+VYdj1N9ZFZ3/fl+9oP5ArMV3Bp16Z9TQk2SsR3Mno/o+1YN4wBZG/bmvphglDWuf
	j67M2dpiQmWYsII00gXBxW/8NYnPwqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783451838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=f/KtcJgaNkHCflPXkp8SqtuePVBeflEXIwIHcfUjd8Q=;
	b=JkhG4KT3sFQ2rnQ3h9aF/dibSO769dQJQa0qjSJxsHDIfdB/lIHwPXMe5VCgcuodDIBfxh
	cohaVuqBmD1Zawaxyue1fieTPat9XhMlvBxYTNXSOOYeStSDkoG6zJQuf5wN9ywmj4MHUl
	BLt8KdHJvjTdTusytP4drY+XwW+KmqU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eJRPYuqF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D3DBA20442;
	Tue, 07 Jul 2026 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783451827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f/KtcJgaNkHCflPXkp8SqtuePVBeflEXIwIHcfUjd8Q=;
	b=eJRPYuqFbmjyCtRm4fiF+aGq57QkrisZZbcRzxsazVnYRUB6cVoZM0x6Jr/RBTnOuUb19V
	NgLX9DdvW7gTdiBjX5f5tx8FvAmQelZZ1yjUcepF4DDyfwmMXPDriFKHWZlRTXWaIPST+j
	eILO+91c86r8et4hvCvbYDmTyG/ZT6M=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/5] batctl: tpmeter bugfixes
Date: Tue, 07 Jul 2026 21:16:59 +0200
Message-Id: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKtQTWoC/yXMQQqEMBBE0atIrw1Exyh4lcFFoqW2oCPpKAPi3
 Y26fFC/DhJ4hlCdHOSxs/BvicjShNrRLgMUd9GU67zUlS6U24ae/xAV1hkBXlnT4WMqZ0pkFLP
 V4xnE6tu8ls1NaMP9Q+d5AfOzefV0AAAA
X-Change-ID: 20260704-bugfixes-tpmeter-a5de357b56e1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=sven@narfation.org;
 h=from:subject:message-id; bh=avL7OmvnPUeLa87JM0DRkdWQYEZnlcR/bjCqClvXJCs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+AWvzdXLSKjZvk/lz9b7oRJ03Tn1Plp9eedo8undpp
 4pZiMS6jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE7FsYGbryBTOTzzzeueQ7
 25PAhOozE++bcT3bfH9jzNUdJ76Kz1BiZDilJFZh3WDmX+Vw3u2O/OfS33vuzp3im77ljd5N5mx
 +Rn4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OUFG6J653NT5MKMKWBMGNGSWGECATMHJ
X-Message-ID-Hash: OUFG6J653NT5MKMKWBMGNGSWGECATMHJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OUFG6J653NT5MKMKWBMGNGSWGECATMHJ/>
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
Sven Eckelmann (5):
      batctl: tpmeter: don't use negative errno as exit status
      batctl: tpmeter: abort result wait on receive errors
      batctl: tpmeter: reject invalid test duration argument
      batctl: tpmeter: report kernel errors via strerror
      batctl: tpmeter: don't cancel test from the signal handler

 throughputmeter.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)
---
base-commit: eb9597d4ca6db17c579f5ae9443c51b013e2fe65
change-id: 20260704-bugfixes-tpmeter-a5de357b56e1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

