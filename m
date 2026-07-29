Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5B1C54F51
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 07:24:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 224C282213
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 09:24:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785309846;
 b=eMKM0LCsQv+9GjVPcJBmCb/KWcpb8/VlIM2+91Zlt4bWGnbvOwg2W6QWi24T+V9hyS+PD
 CKgPzlF7TLKfiTznD9h71o1kfoMaARHzq9ba1Bb6Qazp88IvaT1aq5n8hzmfWYj/qGkQkz3
 OCJsvXFHlv9n2CEUKbi71qZrPReE5aU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785309846; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8D2gSfTQ6A5kCQF5mLIENmIhFLceSt8cWvgR7bQO3ps=;
 b=aIUB5Z+lmIAbN8SWp0QqQmXxnKxrI2J6ATlAoYwXsJgnWESbGKPIWc5sjtKP48V6TPd2a
 qS/Bi3DRdyNcJHOIAE4+7IzVLn2c72ENSSluUzsjVHyGFI28VAsWpZcdF1zIh1oJHdCxMpm
 emWexaln+hNEdR/8QK61YPa/RdXv+MM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A6CD480283
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 09:23:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785309826;
	b=dyifoO3eZAlTtv994WwtPTj/byr9LzvC8Tiqz1x12S2dDkGPOpwmMpgBXYHSd8mShD00dR
	4ELrrme1uHZrfZRDLRnL0isIDTss7AwMwHq73ui9BAZW3y02pAL8u2SLG1eobFVCSwWEZh
	PGsLfHF5jiUWTyr7CsZH7coHNppCvRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785309826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8D2gSfTQ6A5kCQF5mLIENmIhFLceSt8cWvgR7bQO3ps=;
	b=H7yGICVtPkEKNz7V7k46M6McR1Q7n1M/4QiCMfIZbkTLI/GmCj1AWXmsgOrnuBqsn3pibn
	13Y5KWWW1g9Yp+UvJK/7RG6LDyXcs2nJwrqb9tHqCaSmftWlRD0kimTmR4UlRdrQHBWwiL
	GwEKWeOiBklDVVeXRcgh0WEUBvvlvNM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=X8u22i8p;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EB3991FDFF;
	Wed, 29 Jul 2026 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785309812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8D2gSfTQ6A5kCQF5mLIENmIhFLceSt8cWvgR7bQO3ps=;
	b=X8u22i8pkdrR7MPxuCw73xFMuzis+mkJMDqUQ4k7pCQ0ZaVIDg8sJic+tVMz4FdIE2/G2O
	lMI2e2RAb/x6z+OsxqV1k9WZ0OluJUyzqZxRaHaTLVoF1cPZwnY1k1nc9mY4WgDq+K3RQw
	/axohXxpuNNKlRSYQ2sKeUZ4Uihzujs=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] alfred: txrx-warnings: random fixes
Date: Wed, 29 Jul 2026 09:23:26 +0200
Message-Id: <20260729-bugfixes-txrx-warn-v1-0-cf9beb8de0bd@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6qaWoC/yXMSw6DMAxF0a0gj2spiSiUbqViQMCAOwjI5hMJs
 feGMjzSu+8AJWFSeGcHCG2sPIUE+8igHZswEHKXDM64wpSuQr8OPUdSXKJE3BsJaCtvbJe//JN
 ySOEs9J+k7lPf1tV/qV2uJzjPHw7QsRt2AAAA
X-Change-ID: 20260729-bugfixes-txrx-warn-19b01d48b5e4
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=698; i=sven@narfation.org;
 h=from:subject:message-id; bh=d3bqRtc77jhh0wyfuPnU+z2qbFK6JWmNtmYlqmusgl4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmZqwpSDJieVoZK/lc4NfFkUu3mJ7mXVO9da1h8vuEg0
 5mmqN9/O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+afI8D+hTUf6deWvNIGr
 6+9N++m3Isa65Hex74zuu2vceKObg9QYGe6LTLul3TL78Quv1Z4v+sT+NKcb7lvXcaNeS+bIP7n
 795kB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TVIXP66OGIGRT3MT4ZRCABPX6LC35QFI
X-Message-ID-Hash: TVIXP66OGIGRT3MT4ZRCABPX6LC35QFI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TVIXP66OGIGRT3MT4ZRCABPX6LC35QFI/>
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
      alfred: don't treat empty datagrams as a socket read error
      alfred: fix type of sendto() return

 recv.c | 2 +-
 send.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260729-bugfixes-txrx-warn-19b01d48b5e4

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

