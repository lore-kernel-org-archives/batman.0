Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE8CC3ABBC
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 09:03:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5974584A1A
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 11:03:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746781407;
 b=K+KSY2dNN2NMaJ2SRhJYm7vWojWUdy+Zi7Q2npmy44RcYcq7Hifj2bgzYXunFZDoZGiHU
 mMBkyA+st9JmjheeAq6sIzwWp2+9riovHXZYccy5Xd8/M/Sc/vTL3pdbBAU9IzzDdGh2zIJ
 u41MVv69XwAp4t1hFkk29YeT3EPoe7s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746781407; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PJiGenIHT2YggMiOASHfUC8tC9HUeNcLLrzXTixP5yA=;
 b=NHWbbgaWquPMIy1+G27V9hCi30cZ732qenpTAJcuRgM3iABReJWTZ1iVJ0ZytrYL1bEjA
 jADSQcrI8pE65kHVUrH1Qjs9J01mEjuyJ/fpTY7pLeYT7RHdUr4bSHQJojJs4eF3HypJFTp
 SrRkevvVv7l5+u4tVJ0JZU0egCoH6bU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 08D01847A1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 11:02:51 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746781382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PJiGenIHT2YggMiOASHfUC8tC9HUeNcLLrzXTixP5yA=;
	b=RrmhLgeH0wc9aSiwB+sEt8q1yITzeb/7ut0YdFfaYPsW+4OR1v0C20e5X3GWgy6Hm7qdZ9
	eMlTFaXh1Nn+GjYaclu1DZ+Ro9X3r0Hd5T5dFaXslc/uuwJETEqQSzQk6PxhXBgCvh6IEq
	VMRdyMm2FoeOVuxHVg5rCuk/04xM4ww=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746781382; a=rsa-sha256;
	cv=none;
	b=hmujLeEel10FhXZODS44WHrQmB4PqmsDxF9hLI6RG9H+tAgHTiKPHg5t+RExrAoo/kQ6mU
	xTwmJgmK1DKY81QOb81H9XJ1FIvKCenZqB69lkaJpIlvHB/yGbeG65iQi3TVIcbX7RnzO3
	buDbHpif/pCuPkQhCHJidsYVW/tyvkg=
Received: from kero.packetmixer.de
 (p200300c59736C7D829705D90AB67a755.dip0.t-ipconnect.de
 [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2E792FA131;
	Fri,  9 May 2025 11:02:48 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2025-05-09
Date: Fri,  9 May 2025 11:02:39 +0200
Message-Id: <20250509090240.107796-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: R3AAGXA7U6BGEBHLQ3XMI4YYHNSR2KHL
X-Message-ID-Hash: R3AAGXA7U6BGEBHLQ3XMI4YYHNSR2KHL
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R3AAGXA7U6BGEBHLQ3XMI4YYHNSR2KHL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 61f96e684edd28ca40555ec49ea1555df31ba619:

  Merge tag 'net-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-04 09:15:35 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250509

for you to fetch changes up to 8772cc49e0b8ab782e475ce5ef659eedab601a09:

  batman-adv: fix duplicate MAC address check (2025-04-16 20:52:33 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix duplicate MAC address check, by Matthias Schiffer

----------------------------------------------------------------
Matthias Schiffer (1):
      batman-adv: fix duplicate MAC address check

 net/batman-adv/hard-interface.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)
