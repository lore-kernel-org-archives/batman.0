Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E11C531F9
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 06:54:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 43638843CA
	for <batman@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784876064;
 b=bs9aqQ8llC1oOC2BAfQ8pe3e/A4SCOcDXm2cmsFd4CYCl9HTNXU0SxybuZs3ciKEBuH8x
 nmd/8jDQKZ7eg3AcjrVzmbxvbDCdxnRah8a41p6OXX0ULV2AbRPHSdH+6bJQtPZvwaJTEPl
 n4YD0zkxe4HoqIl8d48s+HZvDD792js=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784876064; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LMfdCTQT71fnD/WGOI7IMssD0x7LDYs2O46Zlk5TsI8=;
 b=TClvZSt+iESSz7N07gQnvsgzK92Y/+nYasfuOyMWSI0gwUIdoFNTJ/YcwGlCHuLQCzemV
 aZO6KkS1BmNyqa/eD12ZYD+B7opr/YpRjJgTyzjrIdLEOnsX/e17sZIupOIS0GJpjsHNsVl
 9foTdhbIsTfwUEmBmortpe/D+LL3pAo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 346BF83DAD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Jul 2026 08:51:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784875923;
	b=Ug0ev1k4Kqyqe1ZB9BpEHusyPd27clz4pp54LCCcDcIPkwCXXT5g+F8tO3yv3C1+N0+4j/
	xEB6ZpZqObN58fFRwXTADnfAIvQ/UuI8unjxVa7VmcQA+bOhc2T9yer5eMDQ8Sg1BCkbCh
	vdm3K0kz+0aym5F+O54d05d8if5Sky0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784875923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=LMfdCTQT71fnD/WGOI7IMssD0x7LDYs2O46Zlk5TsI8=;
	b=XnnsvWLrtPBdVO9hd6zDK6u/aJE2TEwtW6aOVbL+0+fOBs6IgTvKIuHUNac8WyoPS+7Ukd
	CGSGMf5cd1szzoa/nGwpSPHhPiLzD9cJszxLgZpMhYaxnGgk42mRpdA+cI2N80NWMP3Yvx
	nkI6Rp15d4JKf2Tfo2bDLA5sJ8gA5rk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XTRHCDXb;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8726120268;
	Fri, 24 Jul 2026 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784875907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LMfdCTQT71fnD/WGOI7IMssD0x7LDYs2O46Zlk5TsI8=;
	b=XTRHCDXbTHHPOcB7cFsZGxB9QNO9HdArJInFr3lMNrpKm1UWQEuy6234vN7m4FQG2xb2AX
	ccYggn2Iygvjmo+C4D0C3JAq55gR/VngWLa5acKbarOaMp5BInFpCfXfYB8BxYcvZpZOG9
	a1Bjq/bWKgbH2Ibc2WhYmPsx2dM6fQU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v3 0/5] batman-adv: allow to specify limits for
 remote learned objects
Date: Fri, 24 Jul 2026 08:51:37 +0200
Message-Id: <20260724-resource-limit-v3-0-be845f27ff62@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkLY2oC/3WOQQ6CMBBFr0JmbQ1toVBX3sO4KGWAGqWmLY2Gc
 HcLbozG5Z/8/97M4NEZ9HDIZnAYjTd2TIHvMtCDGnskpk0ZWM5EXlJBHHo7OY3kam4mkFJTxVk
 t667SkEZ3h515bMATNCqoNsL5ffdTc0EdVtraHIwP1j03c6Rb/58kUpIT0ZWy4iLHljXHUblOh
 fTr3rp+E0T2iZA/CJYQRS0115JKVRbfiGVZXm2efNENAQAA
X-Change-ID: 20260516-resource-limit-5c1a32898f7c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932; i=sven@narfation.org;
 h=from:subject:message-id; bh=EAJYvGrOBpqJiDpiXneMB2PaSZcQ5Kz2L9xVifSOpeo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnJ3PWTC/KCg1M/iFwq43y20Wv667kfj+w33c3rWrnZL
 kMn9MadjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE8pkZGVa+s3ymLTUvbXpv
 5D9t17UhX5+8f6W3/2ry2zKhdxvm+IoxMqyf/pablcd8cVie2+7QQ9OPNE/1D3hRLC69nZXnJcf
 sJBYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5TWNVS7EDGH2OR3Z7AL4BOA3Y3GP7L5E
X-Message-ID-Hash: 5TWNVS7EDGH2OR3Z7AL4BOA3Y3GP7L5E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5TWNVS7EDGH2OR3Z7AL4BOA3Y3GP7L5E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There are some concerns that an external entity could spam the batman-adv
related interfaces with random mac addresses. The batman-adv would use more
and more resources to safe things like neighbors, originators, TT, ... and
would at some point run out of resources.

One idea is to limit the number of entries for each resource type could
have. Things which might need limits

* orig_node
* neigh_node
* tt_local_entry
* dat_entry
* bla_backbone_gw
* bla_claim

Things which are limited by other things (maybe)

* hardif_neigh_node
* gw_node
* orig_node_vlan
* orig_info

Unknown how to handle overly large tt_global_entries:

* tt_global_entry

This approach is also used for the bridge since commit bdb4dfda3b41 ("net:
bridge: Track and limit dynamically learned FDB entries"). And it is also
disabled by default.

For the moment, I just want to demonstrate how this might work with some
example code. I didn't invest any time to actually check out the other
items in the list. So, please consider these lists as vague suggestions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v3:
- remove RFC
- rebase
- adjust commit messages to mention correct bat_priv members
- exempt own_backbone from resource limit
- keep BLA counters in batadv_priv_bla
- keep DAT counters in batadv_priv_dat
- avoid new over-allocations by first incrementing and then deciding
  whether too many items would have been allocated
- move the decrement of learned to release function (when possible)
- Link to v2: https://patch.msgid.link/20260519-resource-limit-v2-0-489c3c919a54@narfation.org

Changes in v2:
- rebase patches
- Link to v1: https://patch.msgid.link/20260516-resource-limit-v1-0-6f597360ed2b@narfation.org

---
Sven Eckelmann (5):
      batman-adv: limit number of parallel learned neighbors
      batman-adv: limit number of parallel learned originators
      batman-adv: limit number of parallel learned DAT entries
      batman-adv: limit number of parallel learned BLA backbones
      batman-adv: limit number of parallel learned BLA claims

 include/uapi/linux/batman_adv.h        | 30 ++++++++++++++++++++
 net/batman-adv/bat_iv_ogm.c            | 15 ++++++++--
 net/batman-adv/bat_v_ogm.c             | 15 ++++++++--
 net/batman-adv/bridge_loop_avoidance.c | 46 ++++++++++++++++++++++++++++---
 net/batman-adv/distributed-arp-table.c | 17 ++++++++++--
 net/batman-adv/mesh-interface.c        | 15 ++++++++++
 net/batman-adv/netlink.c               | 50 ++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.c            | 22 +++++++++++++--
 net/batman-adv/types.h                 | 36 ++++++++++++++++++++++++
 9 files changed, 234 insertions(+), 12 deletions(-)
---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260516-resource-limit-5c1a32898f7c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

