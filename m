Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4882CD6E74
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:27:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 45CAA805BE
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:27:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644425;
 b=I/WBZNPWN6YZmkWz2GDCpC6sfB/h/q315j6aHqhJyinB8m93KERQDZfuDcoWOzAD9cH/v
 GRQoXMNQCowCY9EZLf/gQnMnYp8lmF83yg4RKm/m8j3viAXFeC9SWJMQhBN0ky6o12zvST3
 jQzuZVFMrWADEogNJZzaB+mAY4l91X8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644425; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=naKYUFl2vGqcev/VZdeDENqs5fMgwMk1BQg8G5Yx5BA=;
 b=Og7M4YL0cCNNdf42xo5Oc17cYnSTHY1X1loOUfdUJwSnwIjblLBBdl1bS6H1MrAsNCkqa
 aYq7Zej9oj0/9/lSa7p9fAUZQ79XfkpPvDfyCOIss1Wt5TxQZ5i10tz7HxLtHM/WzosqIKH
 JINFWjCgQoTF8Oz+4+voUj9RxBgiGRg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BEBBD81117
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644018;
	b=z5s8FaZzSyPKTIHyN115vz/OLZbxqNJGkPsZDfUK8vr6G0egU0Wr5+5drROWoCrRl1yQTO
	yMaXG3TnZSjN2jNsvKWgQBIlNwZL7oddqsjWQJyuF97vlKVgApeoLkpEQkxEbE7+K1faAq
	FGcrAeL4QWuSVy075MYwDxkb/4snCVM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=kF9bpel1;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=naKYUFl2vGqcev/VZdeDENqs5fMgwMk1BQg8G5Yx5BA=;
	b=dkIoQ+BKDus0auCL209UwKTs7tmGqfW5FWPLvuF0js6fCS3FueXuk/hS3H6SH0m912+V3U
	sCnAIQQkEzV1b/I+VUHeRti4LgpEL+iRjgn19Kn3Edo+emQw/T0jb85W90MMF2f4ZQQ+Jp
	AC/VJ+KJEi1dzEN5GRlkolwZPGdEh7U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=naKYUFl2vGqcev/VZdeDENqs5fMgwMk1BQg8G5Yx5BA=;
	b=kF9bpel1wv90SxzGm4i0Ys3SaCLT73q9xxuXHFnFr32SAjrUZAaLdBgWkld2kHCbOwRbR0
	KUF9UCSJxqqtY6b09AUR3smIuBEOPA3wZzbxb6Jgjzg9g+tvWkWCiygzDGOeS3bYFJClMN
	ABeVNMNC57rkwyNFnrRGBxNpoQvKuG8fg+igGRDMhfYu11eWs/D7A4/o2Ts1XYDRojSO3a
	NerSNQnQ9/RmXbvWhODd2b/pvVW9sZf7sZ+UXr2xq0lIjnKoM9skkKdHmNEgf+wIKRbJqS
	/oBedh83P9ddQWEnA1fEKD/6NbDRsUrBnqU3T0gW3qx04831zNDXffpCMF7Wyw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/11] pull request for net-next: batman-adv
 2026-06-05
Date: Fri,  5 Jun 2026 09:19:54 +0200
Message-ID: <20260605072005.490368-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MOT2BJNJVZDIJ4VQ7N7MS47GOFU6VDGK
X-Message-ID-Hash: MOT2BJNJVZDIJ4VQ7N7MS47GOFU6VDGK
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MOT2BJNJVZDIJ4VQ7N7MS47GOFU6VDGK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is another cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 626fd14371614b7a8177f79b357fd323a7b91032:

  batman-adv: tt: directly retrieve wifi flags of net_device (2026-06-03 08:27:17 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260605

for you to fetch changes up to 1e2fa2b10c234578d3c98c70f89c04a7aba4db92:

  batman-adv: fix kernel-doc typos and grammar errors (2026-06-05 09:12:09 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by
Sven Eckelmann:

 - tp_meter: initialize last_recv_time during init

 - convert cancellation of work items to disable helper

 - clean up wifi detection cache (3 patches)

 - clean up kernel-doc: corrections, reword, typos (6 patches)

----------------------------------------------------------------
Sven Eckelmann (11):
      batman-adv: tp_meter: initialize last_recv_time during init
      batman-adv: convert cancellation of work items to disable helper
      batman-adv: drop duplicated wifi_flags assignments
      batman-adv: use GFP_KERNEL allocations for the wifi detection cache
      batman-adv: document cleanup of batadv_wifi_net_devices entries
      batman-adv: correct batadv_wifi_* kernel-doc
      batman-adv: tp_meter: update stale kernel-doc after refactoring
      batman-adv: bla: update stale kernel-doc
      batman-adv: uapi: keep kernel-doc in struct member order
      batman-adv: fix batadv_v_ogm_packet_recv error handling kernel-doc
      batman-adv: fix kernel-doc typos and grammar errors

 include/uapi/linux/batadv_packet.h     |  6 +++---
 net/batman-adv/bat_iv_ogm.c            |  2 +-
 net/batman-adv/bat_v.c                 |  4 +++-
 net/batman-adv/bat_v_elp.c             |  6 +++---
 net/batman-adv/bat_v_ogm.c             | 16 +++++++++-------
 net/batman-adv/bitarray.c              |  2 +-
 net/batman-adv/bitarray.h              |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  6 +++---
 net/batman-adv/bridge_loop_avoidance.h |  2 +-
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/fragmentation.c         |  3 ++-
 net/batman-adv/hard-interface.c        | 15 +++++++++------
 net/batman-adv/hard-interface.h        |  4 ++--
 net/batman-adv/hash.h                  |  4 ++--
 net/batman-adv/mesh-interface.c        |  6 +++---
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/netlink.c               |  4 ++--
 net/batman-adv/originator.c            |  6 +++---
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/tp_meter.c              | 28 ++++++++++++++++------------
 net/batman-adv/translation-table.c     |  2 +-
 net/batman-adv/tvlv.c                  |  4 ++--
 net/batman-adv/types.h                 | 24 +++++++++++++++---------
 23 files changed, 85 insertions(+), 67 deletions(-)
