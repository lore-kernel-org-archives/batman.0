Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0387DCD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:30:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9249283FA9
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:30:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780461043;
 b=KZBf3rjy4VoZan5UB6hKpBqzsbavo7JeTJFRFdcUkVyd4kEoh2zcjyDOewEIUgWqhLfHV
 Bk6u1O8iVL3LeATA+cZjsKQ4OwKibSHZbiq8NstvuYzNuOJEGk62WnFU0x+6hjPrLhAhbph
 4Od7NEz/1XaPvT23ABV2S0Y3P7/kAOg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780461043; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MUqHfv3gCBGDW1ZADRVJ86xGxzG/5BMeDCoYhN4G9QI=;
 b=mPXERMjkPQwEs/qbSZlIGoL8qgkKBP5N/Dj43vmz0UGgv9nxPYRMe2xDfeDd5QKvztb4L
 VPsm1JdaauwYzLswhKO8bTELMP3QEHVQTA/m6PpnoVhJmEFtgTxJpM7YsaPHrQZov3T9Su2
 OTEzCZSypGlUjgt8DgXqynETj1ivz48=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8579C84940
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:29:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460951;
	b=1bBYrffi23pgnMGs0Ibdw4vJrRox87zQnMfzylPO6jPHU86zsISITN9o97ZMbcOQYtt7tR
	lcX06XrK72VaXEfH1SAhD0s0C+MMs6LPwGruXQ5c7qkGpwNTA9pUgrGEoVSFixIZ8Zfctg
	Lq/QTqZJjZhm82j1Tf3umiYtUTjHj+c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=b95zeRUF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=MUqHfv3gCBGDW1ZADRVJ86xGxzG/5BMeDCoYhN4G9QI=;
	b=ndlHE4MCusef1bDbUgupTsl7MMIq4t84VLVSFqYDyX45rQ6zZiXKLiG1uNSonPmrW0enz/
	2SgdYP6rV9Gzk+4a5Y2c+useG7IOLe++Tu5fx9L8R8Q//B9JEF5OWPYa+etqqg0K2v4of/
	IGATY8pWU7CCpp6Le5Vz8vD4MJgI374=
Received: by dvalin.narfation.org (Postfix) id 047371FE4D;
	Wed, 03 Jun 2026 04:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MUqHfv3gCBGDW1ZADRVJ86xGxzG/5BMeDCoYhN4G9QI=;
	b=b95zeRUFbYS4KaIQfCPPRQe80/9UjQ9De1ScZRBaCAKBc4A1oB7txppubzHoYhLP/oUheW
	ixmR8yWDtPDW3rPS8TaxF9VlN0mEY1lWn+idSYWLFk7bfcdkjfK0Eg2ehxQRbMXqn8CZh7
	YHVA5iOhQ6aQlsS0xd5L3KiKFf30uHM=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/5] batman-adv: drop global hard interface list
Date: Wed, 03 Jun 2026 06:28:59 +0200
Message-Id: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIutH2oC/yWNS47CMBBEr4J6PY4cJ86HFfdALNp2N+nRkKC2i
 UCIuxOY5StVvXpCJhXKsN89QWmVLMu8gfvZQZxwPpORtDE46zrrm9okXa5mQk3C5k9yMSHyULu
 E3ZgSbLOrEsv9qzxCwIJphdN/nm/hl2L5+D5N1uViyqSE3wsbXOd9i0zonW0GZxmJ68ShHQfk3
 jcNjsGnqu7bvht6b9vqLKW65DgJM+nhNstKmskwxrLoo5qpwOv1Bp/XzmDlAAAA
X-Change-ID: 20260531-drop-hardif-list-bcf812da69dd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=sven@narfation.org;
 h=from:subject:message-id; bh=1O0S/vWSOmMe7JLxyYoyXeLCpyw+T2M4VgVY6IYS8tQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyaycfMTf8IOKbdFJCsDdeLO5y4D0+8/UrXnkGTv/oH
 RfXp5zeUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjInr2MDCtC9hgyuvlW10xp
 jjy9+IvD5+3MkntF0/+fVavxat18fBnDH36/+NMCb2/P82OaZmYkW7fz4DzRrpQ1dcl267Qn+IU
 7cgAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: CUHVZS7S7DMNGBJGNZWG6R6HLLLSHV3V
X-Message-ID-Hash: CUHVZS7S7DMNGBJGNZWG6R6HLLLSHV3V
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CUHVZS7S7DMNGBJGNZWG6R6HLLLSHV3V/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The global hard interface list was used in the past to provide and sysfs
(debugfs, procfs) based configuration interface. This requirement is gone
after it was switched to generic netlink and NETLINK_ROUTE. And after the
wifi-flags cache was introduced, it is also no longer used to get
non-batman-adv attached interface information (for ap_isolation and
re-broadcast configuration).

But this odd net_devices list (batadv_hardif_list) stayed and caused some
headaches:

* memory requirement increased (useless) for each network interface of the
  system
* massive increase of various ethernet operations due to the O(n) nature of
  this global list
* the code had to handle switch of a batadv_hard_iface from one mesh_iface
  to either NULL or a different mesh_iface

Just get rid of it now and start to simplify the code around it.

This RFC is on purpose not Signed-off-by because I just want to restart the
discussion but didn't discuss this with the original author (nor documented
the changes in each patch in detail). And it is also not meant to look like
I've reviewed the changes and Ack it - this is unfortunately something
which I have to do again with this rebased version.

I will later post an range-diff which contains all the changes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- rebased
- submit as RFC to get the discussion started again
- drop already merged "batman-adv: store hard_iface as iflink private data"
- switch from kzalloc to kzalloc_obj
- update author's mail and name
- fix reference counting for batman_adv_ptype
- Link to v1: https://patch.msgid.link/0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net

---
Nora Schiffer (4):
      batman-adv: only create hardif while a netdev is part of a mesh
      batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
      batman-adv: remove global hardif list
      batman-adv: move hardif generation counter into batadv_priv

Sven Eckelmann (1):
      batman-adv: tt: directly retrieve wifi flags of net_device

 net/batman-adv/bat_iv_ogm.c        |   3 +-
 net/batman-adv/bat_v_elp.c         |   3 +-
 net/batman-adv/hard-interface.c    | 183 +++++++++++++++----------------------
 net/batman-adv/hard-interface.h    |  11 +--
 net/batman-adv/main.c              |   6 --
 net/batman-adv/main.h              |   3 -
 net/batman-adv/mesh-interface.c    |  13 +--
 net/batman-adv/netlink.c           |   4 +-
 net/batman-adv/originator.c        |   4 -
 net/batman-adv/translation-table.c |  14 +--
 net/batman-adv/types.h             |   6 +-
 11 files changed, 93 insertions(+), 157 deletions(-)
---
base-commit: bba80ddd693e6d82a0b1f456511904cfefd5df24
change-id: 20260531-drop-hardif-list-bcf812da69dd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

