Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F3BCD3439
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:21:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1207983F7E
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:21:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778098906;
 b=UT8WaPYc3+DZVZALujQvWUoFtUu+WjS59QMEtCBMEC5d9HPScFavQzuV2+EYH15zOwO5N
 l9fJf27LFkbEAP3ljGkgJZsU5wwVixE5aotsIylHHclhW7P7hWVOFkRhR0KhsjLHfOvJ4wJ
 HQObXG5VRWh4puGmKdi0ZmcBx6tQAiQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778098906; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6gI/10FNkQLThSROOv/AK/gUlLXzDQYn8ogNFAT2iEc=;
 b=rPWqg2JnvUVKRvWEQddgpQxnRv8LmYgG/RQLzEcoTK3tTzqi/XwoWLg9tCQ2mnDKli2tQ
 252axQ7T8++7DyDc/08Ovb/6mV05vshnlUEcbOSG8O+6/YOhugSUJX4diOTCaF+VBkFxfug
 BV+z1YycFoneL2zW6XAzkm4HkILISxc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D4575817F6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:21:27 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6gI/10FNkQLThSROOv/AK/gUlLXzDQYn8ogNFAT2iEc=;
	b=eoaspW2iYOSSWbkWH+dQBUPCY1OK4dI8GscrqaRZJSGTQN/hakXfCfG+jTK1UJxZTN5qNn
	KaImoryXCKxOxwl8KgFVKd4+ub6HJgpah6rfEMx9pLAOVpv3aG0KGTXE7og2Hvill6dwOx
	PnVfP0dNr6sek3pSHwC2kwT9DVMbMBs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sBHhKbN0;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098897;
	b=njCPgHwaryAsXb0nvyf6zBgp+15h/FCVJlmg6irrxJruOWE6GksnUi0P94L7o/83wYQ69+
	+hBu0hHzrJ2wKJcfU0Q2Al+r+aoaYmKbJsQ6Bc9GSpjiXfJCb1z8D2lP4ogSBdZNDztaXK
	JtK3fpjhTWBHPRIIr0G941VIaCWkedA=
Received: by dvalin.narfation.org (Postfix) id 649FB20DD3;
	Wed, 06 May 2026 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gI/10FNkQLThSROOv/AK/gUlLXzDQYn8ogNFAT2iEc=;
	b=sBHhKbN0CHFaAaMYE6BFeU1w/u2t95f8SwZ4CIV/yIppMZXzoo35kJ144PTnxm02lJLZCY
	KPkzVQcoFYnIMromsZ97Y4JPTJkPnrgh2Q0etOQ5wGO1RQIegNoJNp8Z6lqhuL1sINWbbN
	pl+zvbAoaOYrxc7yGnZJeb7dJ0NBH+Q=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 00/11] batman-adv: follow up fixes
Date: Wed, 06 May 2026 22:20:47 +0200
Message-Id: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+i+2kC/3WOyQ6CMBRFf4W8tTUdGF35H4ZFoa9QQyhpS9UQ/
 t2Ca5f35txhA4/OoIdbtoHDaLyxcxL8kkE/ynlAYlTSwCkvaUEF0eaNnmg7Tfa1LoSWOW14V2l
 dFJBCi8OTSJkHdDJIFaH9+X7tntiHo+0gR+ODdZ9zObKT/zcSGaEkF0zwqm5YrcR9lk7LkL5er
 Rug3ff9C05tmdnKAAAA
X-Change-ID: 20260503-fixes-followup-064092b7ff55
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
 Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Luxing Yin <tr0jan@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531; i=sven@narfation.org;
 h=from:subject:message-id; bh=hkaQ8PBYANPyeU0aTmx1tFOwEirA2pEVW5+dlAG0xhQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx1Ynnel8VrJ/NWeU3gSy85fzQ903Lbpjsle/SenN
 nSeCJDY11HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSIU3I8OCEEn5K5pOf/gy
 LkQqLolxvG699eMHr6SsyQUFYtl/ZWwY/pdrndBe1Hd+jdl5fQMrW6/4F4/v3Fv3bJ3p82eX3jt
 mZbADAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NGENQKGUAIRNEKAAUSICYKYULSND4QJO
X-Message-ID-Hash: NGENQKGUAIRNEKAAUSICYKYULSND4QJO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NGENQKGUAIRNEKAAUSICYKYULSND4QJO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

While reviewing the fixes submitted to batman-adv in the recent weeks,
further problems in similar or adjecent code was identified. This was either
noticed in the manual review or reported by sashiko.dev.

Especially in the TT code, you have the global and the local translation
table. But when a bug was fixed, often only one of the two codepaths was
fixed. It was now tried to sync the TVLV preparation code between to of
them - not style wise but fixes wise. Besides the hardening, it will also
make the code less confusing.

The BLA and TP fixes are just some reference counting fixes - either
reference leak fixes or missing reference handling.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- keep initial num_vlan for TVLVs to avoid CONFIG_UBSAN_BOUNDS confusion
- add patch to handle backbone_gw ref leak in batadv_bla_add_claim
- add patch to switch last_changeset_len to unsigned type
- add patch to avoid interaction with bonding code when checking for
  temporary loops in batadv_iv_ogm_process_per_outif()
- also switch vlan_entries in batadv_tt_prepare_tvlv_local_data() to int
- clarify batadv_bla_purge_claims() kref_get_unless_zero comment
- drop netdev from To/Cc
- Link to v1: https://patch.msgid.link/20260503-fixes-followup-v1-0-4313278918d3@narfation.org

---
Sven Eckelmann (11):
      batman-adv: iv: avoid bonding logic for outgoing OGM
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: prevent TVLV entry number overflow

 net/batman-adv/bat_iv_ogm.c            | 31 +++++++++++++++++--
 net/batman-adv/bridge_loop_avoidance.c | 11 ++++++-
 net/batman-adv/tp_meter.c              |  5 +++-
 net/batman-adv/translation-table.c     | 55 +++++++++++++++++++++++++++-------
 net/batman-adv/types.h                 |  4 +--
 5 files changed, 90 insertions(+), 16 deletions(-)
---
base-commit: fa15d5b68da1a96c6baf846afd01390e6c217328
change-id: 20260503-fixes-followup-064092b7ff55

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

