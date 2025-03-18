Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03058C282EC
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 15:01:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6DD4583D31
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 16:01:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742310065;
 b=y+gEdv3R25E1WzAtdOTcAroSlcMZI04giPOwxpKk8KDiNGxB9jC9wrWimPLJhTppmjJzI
 wSw3VPGdlmTgkJtk2kZ9NR5ovqsHBXE/To3kisVR2whP1kA7F8TXGP5+uwxMBdCovTbdeyt
 VmI7xa75sTDvcHxQs0PAFQdbAqzhc8A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742310065; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ri/2zwp9PFVXymZc/4aSNZ6JNsU7EBcrk8BsTRt0tIk=;
 b=zhqck8yb/HIhqvcwwAgCB7hmzMa0ToUS/hUAs+OPVcid57Ui2pftcCwyztAT4vnBjpgQm
 B8Ff/bDwC0m1HV6JS75L+BZfmYN6fqimcWnKgTg/W0H1FYMzpm+aIaM/Vezo+V/AxCZucF4
 MrOCNmbVkT18E6k4gMKYd9SAydCkUGk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E90FE80F86
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 18 Mar 2025 16:00:38 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742310049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ri/2zwp9PFVXymZc/4aSNZ6JNsU7EBcrk8BsTRt0tIk=;
	b=ifGguua9YRLgeFzaDfqrJHIo4QcvZUTXEXSoN127OYw7aWNOocNq2KsosOgb8DCx3tYe2r
	6AvZ8FYzXbCSKPZsmFS758uU/TdZRL19jNOvJiSH79/UKA2zUam3MRYM1onxseFb7JIpSW
	STx1HXZ8kCv0Ssn0w3FDsOpe7rH9B58=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742310049; a=rsa-sha256;
	cv=none;
	b=qUrISK/o4Bd+d2DDp+J/sfC//VWsIbe9QvJRCCf6c2C3hk1LX24UB2tajIJTQ6IwUG/y27
	5hmwZlwmwLE+/IcJkgHsGJvSDFKV/G43xjnRL8hXyR0gho4e7nGaOMKOmw8gg1arwy7l/q
	BfTVxlIB80d2irnxrYZQCiWaBoKEOlk=
Received: from kero.packetmixer.de
 (p200300C5973197D81320d84731f3581A.dip0.t-ipconnect.de
 [IPv6:2003:c5:9731:97d8:1320:d847:31f3:581a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C7F02FA131;
	Tue, 18 Mar 2025 16:00:37 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] ] pull request: batman-adv 2025-03-18
Date: Tue, 18 Mar 2025 16:00:34 +0100
Message-Id: <20250318150035.35356-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QB5L3JUHYOHO3VXZXUUUQB7QIANQCNRN
X-Message-ID-Hash: QB5L3JUHYOHO3VXZXUUUQB7QIANQCNRN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QB5L3JUHYOHO3VXZXUUUQB7QIANQCNRN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please note that this pull request supersedes the pull request from
2025-03-13, as Paolo mentioned that there were some issues pulling due
to too many patches added from my end.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit f4c9c2cc827d803159730b1da813a0c595969831:

  batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1() (2025-01-28 22:06:56 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250318

for you to fetch changes up to 548b0c5de7619ef53bbde5590700693f2f6d2a56:

  batman-adv: Ignore own maximum aggregation size during RX (2025-02-08 19:24:33 +0100)

----------------------------------------------------------------
Here is batman-adv bugfix:

- Ignore own maximum aggregation size during RX, Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)
