Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A49CD4F3C
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:04:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 78EDA80CC6
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:04:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174279;
 b=30T2+9Pz0W/xGZdwczYkxRDRedRhGTu54DFA+Pj/C88pxaMoWraISsbsaNiHrKmNwJW1V
 nUQwDwD+5UHHtb8rheAdJNefEZp2q5iNdHTWXuDP00YZE9pyFaojUnsjsrUUQ0YnPRlEfZc
 1n6ZpD4w/776fONtZkl590/y0eDSBnw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174279; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xdcbRcJu0pJlpmFZ3lxEM6xeza4p7mxfEDnd1s7dmCs=;
 b=XvUkrq2fFJJsR03/O6sYybWkG4AYiRf9nbW1Z1pW2/R0RRK42dZap6IsM7ub+w5vmlI9h
 QunTwVDOlnGucvWM3Q1v9DKlBQjAg/J4ekOaEm1XLEPxGN2D2JePPDJUwo2BDbS5E9fU0Tf
 R2eESOBIaLfXC6MTrPmDJ/INSd+3DxM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1DCC780B51
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:02:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=xdcbRcJu0pJlpmFZ3lxEM6xeza4p7mxfEDnd1s7dmCs=;
	b=a9yNpCLMWe2kSc4/bi7opdCvLeV53NLvIhA7zAPHwhE6M7c7PKFznqIbMh3DgP8CNpPU9W
	Tsgi7fkQJZkQ0KktbsBxzu/POAyXoROM47sMFQ14FFFCPBsIgNo4iw/AGrv5WWLE8qfZRR
	657wAZwYGeviOPdURDQCR5uzf7b3jmo=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174141;
	b=oiruWh6Dbvl2lO9EaMWURXeQSSI+6bcA2a+Zac8YtLcNyGamozKz2dXKmzBIyN9w+NimDT
	bJhkE8MYk0axFrMKyqg1X7L+g/NCzwYkWtcHw5LcHSJlZVfsu8nFa4t+PmucmvqaUfC+5L
	hBGkE3ZKJYhD0LNEnJzrRffLST7r6mI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=B6pjzQma;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 677871FE24;
	Tue, 19 May 2026 07:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xdcbRcJu0pJlpmFZ3lxEM6xeza4p7mxfEDnd1s7dmCs=;
	b=B6pjzQmaASORQ0M8vKwBC+0JTLKOSriF97g/VLQ04VarbjIHwX02y2jjhbv9mZfAyfsfR/
	6L21PWq0LsRu0BkYnDkLG+i1Cp9ji4AMhQUIkksPo41kDcixh2QybMi2I36HkngQyDnAyH
	KXUfEGw8feHKtPp3plmJPO92Fsy/MVg=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC batadv v2 0/5] batman-adv: allow to specify limits for
 remote learned objects
Date: Tue, 19 May 2026 09:02:14 +0200
Message-Id: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYKDGoC/3WOQQ6CMBREr2L+2ppSQgFXJiYewK1hUcovfKPUt
 KXREO5uwbXLmcmbmRk8OkIPx90MDiN5smMSYr8DPaixR0Zd0iC4kLzIJHPo7eQ0sgc9KbBCZyo
 XVV2ZUkOCXg4NvbfCG1wv59VrVVBdhOYX+6m9ow5r6RoO5IN1n+1AzDbs31bMGGfSFHWZS46da
 E+jckaFdPlgXQ/NsixfbTt9JdEAAAA=
X-Change-ID: 20260516-resource-limit-5c1a32898f7c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=sven@narfation.org;
 h=from:subject:message-id; bh=RQ7etMDqtbXoWjW/qR5FAfVUBn35fYhgjS6Q14WyqcA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk8XD+uCMpoZppt6TgscuGUbeK75w+DS4K3OE9wm3Of6
 5Pq4oDSjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBECrcxMqwXyOg747ns8QNl
 2XMav+/+fcUZJuzg/+jafYvqfUsPcZYxMnRcK+57b3twtcrRP+aF7+da/zMrbPj7UCo4Wl4j/8a
 C5WwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CVZPPRWATSWPHID6VFWCFNKSRMEYXUVC
X-Message-ID-Hash: CVZPPRWATSWPHID6VFWCFNKSRMEYXUVC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CVZPPRWATSWPHID6VFWCFNKSRMEYXUVC/>
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
Changes in v2:
- rebase patches
- Link to v1: https://patch.msgid.link/20260516-resource-limit-v1-0-6f597360ed2b@narfation.org

---
Sven Eckelmann (5):
      batman-adv: limit numbers of parallel learned neighbors
      batman-adv: limit numbers of parallel learned originators
      batman-adv: limit numbers of parallel learned DAT entries
      batman-adv: limit numbers of parallel learned BLA backbones
      batman-adv: limit numbers of parallel learned BLA claims

 include/uapi/linux/batman_adv.h        | 30 ++++++++++++++++++++
 net/batman-adv/bat_iv_ogm.c            | 13 ++++++++-
 net/batman-adv/bat_v_ogm.c             | 11 ++++++++
 net/batman-adv/bridge_loop_avoidance.c | 22 +++++++++++++++
 net/batman-adv/distributed-arp-table.c | 11 ++++++++
 net/batman-adv/mesh-interface.c        | 15 ++++++++++
 net/batman-adv/netlink.c               | 51 ++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.c            | 14 ++++++++++
 net/batman-adv/types.h                 | 30 ++++++++++++++++++++
 9 files changed, 196 insertions(+), 1 deletion(-)
---
base-commit: ff182fc0c666754e3f35f7b63c9ccf0dff239e52
change-id: 20260516-resource-limit-5c1a32898f7c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

