Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B77C83F21
	for <batman@archiver.kernel.org>; Thu, 10 Jul 2025 16:45:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 275878475E
	for <batman@archiver.kernel.org>; Thu, 10 Jul 2025 18:45:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1752165944;
 b=Ttgew45ys+SFh7To4pkO+EmQnPNPLZBc6TnPdTTrF8/dZ4iyKaSOsSFVQgA2kwe26oUHA
 Q29TMphd4R1Fmywgx4ClwPB1CvQf5RzvGtiAMifIzkRFgdECpJ5cX+p4+XzrefIQ1/uDuSj
 1sahkjSgERjM1l5SWElTWo1rKlzeLzA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1752165944; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=t31uGxWw3hSjhLd3iHx9pNC8fT08q8+YVzcZBnbRc7k=;
 b=DmRT56uReRpW+HaDnWH6MNl4qQCFr69iDpjaPDALydvqs7bcd71MNdtsxBJ1v6EMji6u+
 mV2ucbnaJ4eI8MHPuiOpxzqobDMm4TQMj0LYKlAlZu2s6k2PHrLz63P0zsuxN85CRWcWx0U
 UPQHMuyo7Yf+t5cNXoJYLHOJ79eFltM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 603FD81E89
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Jul 2025 18:45:11 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1752165916; a=rsa-sha256;
	cv=none;
	b=b1uAeY56aqvqLD34KBUNhaOb2Gu1pJvKRnz7i1qGYq4TOX/g6FrVv9ezYlxZZkg3ZH5xem
	AcYtlEp65DakuLOsJ98ByOYBuIe6MaRV6umn4Y3b9PbGBRlNV2y631aVIyyDTPECFxb16w
	/Q5RLkcvAkQ0cYQKYNTAbcE4SZOI/sQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1752165916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t31uGxWw3hSjhLd3iHx9pNC8fT08q8+YVzcZBnbRc7k=;
	b=ihz3YC/YxoYs5+ydqprIKVK3LeNUqkyGMK1MYxvMl3CGQ1xx5sD9UiW+oYgHegOJP37wgO
	HlJIheAQYX5/I1MOanSp48/IzGqqaal3UUtFlVSHHpfUHihRujoJDiNeafdsnG5VR5VqJ+
	HHB+gamABN3mATL99Qw+GGS6W+5IzAA=
Received: from kero.packetmixer.de
 (p200300fa271BaC80353e86dE392BA4Af.dip0.t-ipconnect.de
 [IPv6:2003:fa:271b:ac80:353e:86de:392b:a4af])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C0CCAFA022;
	Thu, 10 Jul 2025 18:45:09 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/2] pull request for net-next: batman-adv 2025-07-10
Date: Thu, 10 Jul 2025 18:44:59 +0200
Message-Id: <20250710164501.153872-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4OWZJZNGQCLDNOXFK4WBPUZXCJ5Z4A67
X-Message-ID-Hash: 4OWZJZNGQCLDNOXFK4WBPUZXCJ5Z4A67
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4OWZJZNGQCLDNOXFK4WBPUZXCJ5Z4A67/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Jakub, hi David,

here is a small cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 90b83efa6701656e02c86e7df2cb1765ea602d07:

  Merge tag 'bpf-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2025-05-28 15:52:42 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20250710

for you to fetch changes up to 7dc284702bcd065a822a4c0bdbca09a08de5a654:

  batman-adv: store hard_iface as iflink private data (2025-05-31 10:41:11 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - batman-adv: store hard_iface as iflink private data,
   by Matthias Schiffer

----------------------------------------------------------------
Matthias Schiffer (1):
      batman-adv: store hard_iface as iflink private data

Simon Wunderlich (1):
      batman-adv: Start new development cycle

 net/batman-adv/bat_algo.c       |  1 +
 net/batman-adv/bat_algo.h       |  2 --
 net/batman-adv/bat_iv_ogm.c     | 25 ++++++++-----------------
 net/batman-adv/bat_v.c          |  6 ++----
 net/batman-adv/bat_v_elp.c      |  8 ++------
 net/batman-adv/bat_v_ogm.c      | 14 ++++----------
 net/batman-adv/hard-interface.c | 39 ++++++++++++++-------------------------
 net/batman-adv/main.c           |  7 ++-----
 net/batman-adv/main.h           |  2 +-
 net/batman-adv/mesh-interface.c |  6 +++---
 net/batman-adv/multicast.c      |  6 ++----
 net/batman-adv/netlink.c        |  7 ++-----
 net/batman-adv/originator.c     |  7 ++-----
 net/batman-adv/send.c           |  7 ++-----
 14 files changed, 45 insertions(+), 92 deletions(-)
