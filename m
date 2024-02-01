Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5794DC47DDB
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 11:08:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A770683477
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 12:08:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706785682;
 b=XYPDSeBjzd0lkussgl6IfNd82OJRqHXXXWCVA/bcIDcujQcQNbyoWVbq58SZOFa/abPZm
 Vi9fi0myGXMQ9kp6XYC/hf3v1iEUZ86Bm6FWPhHIS86GuIM2HDJK2wguevNGLDttnl0q3Yd
 1WRImSAnJt/qirHFJvFSinZS09bRZUE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706785682; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Dh8RRh50uAahCiueMSyres8EfxTXI3/2WX+ACqEZYAo=;
 b=xPHUfIETaL22mdfKA3RxVdJtBy79LAcqBkL7PlyEXP2Wp8azV7gqivnkgHqWnswFKCNm5
 wusAVgXtP9onug/freU3mA9VIjzQg68rAHb6fSpW3btYiT6M1piEFIEr2Bu0lgbgzmRncRu
 9JvqecEAxXnP9BcdMoE0E3VqW7Ypx1Q=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4422C80B42
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 Feb 2024 12:07:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706785679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dh8RRh50uAahCiueMSyres8EfxTXI3/2WX+ACqEZYAo=;
	b=cZq/djE0FMTl0hcfEeriib6svu9Jkg52nVAlRs6reclYk3N3zys1CecsQuQwEMIHTT1OTz
	K4/ElhngLdPsqtse721xE8RaGCeud7MBdEqguf14eeYg5K/gTMmSWV9Ml5ddMmiVIqOkZA
	FnzmVmVlx0fuZ3pDB+vqj//hNPTSrIk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706785679; a=rsa-sha256;
	cv=none;
	b=gGxNqR5tdUPUhCu/wRkDIQv9FTCqhgo6YmdfrS+PfwnxpjMfe4T9/1+1mOTtapQz0URibN
	2JQsp0niV/YR78qe9rWvoBVPhzG5GrLLpSKZj7ZGuNNsk/w5L80FNemkdivMru8XHvl1N6
	fqpLV5byLcVuAIDDM9ii+Sy3sYZ8+ro=
Received: from kero.packetmixer.de
 (p200300C59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 42AD0FA9B1;
	Thu,  1 Feb 2024 12:07:58 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2024-02-01
Date: Thu,  1 Feb 2024 12:07:52 +0100
Message-Id: <20240201110756.29728-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VXR6EFQ6EV6UKLF4RY3MEBGBLLQ3INAM
X-Message-ID-Hash: VXR6EFQ6EV6UKLF4RY3MEBGBLLQ3INAM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VXR6EFQ6EV6UKLF4RY3MEBGBLLQ3INAM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20240201

for you to fetch changes up to db60ad8b21cee0394cb0a1092d9f9190d310562c:

  batman-adv: Drop usage of export.h (2024-01-27 09:13:59 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Improve error handling in DAT and uevent generator,
   by Markus Elfring (2 patches)

 - Drop usage of export.h, by Sven Eckelmann

----------------------------------------------------------------
Markus Elfring (2):
      batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
      batman-adv: Improve exception handling in batadv_throw_uevent()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Drop usage of export.h

 net/batman-adv/distributed-arp-table.c |  3 +--
 net/batman-adv/main.c                  | 14 ++++++++------
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/netlink.c               |  1 -
 4 files changed, 10 insertions(+), 10 deletions(-)
