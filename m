Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842E6C55838
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 07:42:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 942A284227
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 09:42:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786002127;
 b=ArD3WXLHkClEGp9Lvj6ZRmVphPoqVhI7LVs7xsu4oLWgnqan40A6sYnDYgTORpMEyQ09a
 MYZpdGnuUZZQPZ13ad3hYlkrj+8hqLEgPGVqP8ah61Ox19AcpQxoX7HF656E2y3BAQLMdeT
 fYjczVstGvnV8YKLpxHQwZiqj/0aS8o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786002127; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YNeklIam5ojn4noR3ehOih/sgUH5emFNRwkgyZ4CHsE=;
 b=G0+oGZR4RIxudKMz94yr0v3OFlhxz+POXr1Sd8GAq5VJC+fWsLYZ2RsDwrOibyKWgQbrf
 HL/iqZGhIJztbvFa+1HcwXlV6SURw8xhAUEpJA0O+daROdE9xktKk3JLCdW4L6+hiDKFgt4
 Qi0oFcdL+L5H5+yQgrum7WL+vvVtEFI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1BB058149E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 09:41:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786002110;
	b=fwvsCfW2JfWsQLv7+SBg7hO8LuAp01q5+gheSjBSOn9y6yO3DSHeEVpSEIcLPFN9aR9cMT
	Tdr9l7CzD9YlzJ5cEPO5inuTc1nWBXtPW1e5BMWucGicTAbZbftoU6+1Wn6Dqpo+pCY6D4
	UFj8qlCUbvXcOIrkz8SXlET0MzTEUs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786002110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=YNeklIam5ojn4noR3ehOih/sgUH5emFNRwkgyZ4CHsE=;
	b=ZwntfjHGdR0zpdorZiyUhYDQimdR3diTWWtNLWcGcM8EDp89/EzS6WzL06wU3s/y6gvLjT
	mL+DbmFr5pmkfzAWx2Q6XzUV0dLvD1DtyDMSeInAg+uIXs5EtRLxCUCg8pSIQLOkIsJopn
	+U8v+1eZ1zoc8qBGzL3zd9CGXncDvfA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2nKbYGgL;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5352F20590;
	Thu, 06 Aug 2026 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786002095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YNeklIam5ojn4noR3ehOih/sgUH5emFNRwkgyZ4CHsE=;
	b=2nKbYGgLPpze8sFPejv62YbImH3VjnsXFM+FHYiAsIBFYxhXmMqpK2uKwioHB0NRjfR3D3
	hPOsylk2BSe0wEQgzWpsC1QIO4XC+rMPEVgzJoO6tfWlrqI4vBjpwGV+EU7qj+kW0ovteS
	FuwJ435i52rEPo+ql4sZVoM9STdEDws=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC batadv v4 0/8] batman-adv: tt: atomic sashiko fixes
Date: Thu, 06 Aug 2026 09:41:25 +0200
Message-Id: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKU6dGoC/23Owc7CIAwH8FcxnMVgR2V6MjHxAbwaD8CK4mEzg
 ERj9u6yefiWT4/tv7+2LxYpeIpsM3uxQNlH37WlkPMZsxfdnon7ptQMBKyEqgRPiTv/oMid1WA
 UABnTsDJ+CzQGZfrIDvvd0DM66Saz0yeOd3Mlm4Z1Q3jxMXXhOZ7Oy5F9X8lLLvhK0poQsEHEb
 auD06m8uejCeVyd4Q/XQk4wFCxrZWXtrHJW/sLVFOMEVwUDGiEMYi2V+I/7vn8DJWpq7z8BAAA
 =
X-Change-ID: 20260730-tt-fixes-fca2b722ebbd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=sven@narfation.org;
 h=from:subject:message-id; bh=TwA2SH9LAJh3FRqfe/qsIUYEPG3Qgns0W6FoFzDBieo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklVqtYO49fTAiz47uyIe2aq8T7pbkXf29zscmfWfd/0
 eGU3o1nO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATqfnFyLBnaojWWqNJNSm7
 WLc62f5aJrlNYUHZutXshVHLe+q2bZNl+Ct7rX3/h9Y5nhxdMf2x8YvlpylJbPp86sTSRTOO5Er
 KCrEDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BOEXPGWSQLAUOIBEVQ6FLGLUJRHV23DB
X-Message-ID-Hash: BOEXPGWSQLAUOIBEVQ6FLGLUJRHV23DB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BOEXPGWSQLAUOIBEVQ6FLGLUJRHV23DB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were a couple of sashiko reports regarding the
batadv-next-pullrequest-20260728 PR. I went through the TT code and tried
to handle them and at the same time already predict what else sashiko might
report as next. I needed to change the batadv_tt_local_remove() hash
interaction as preparation for the related NEW flag (and counter) handling.

And the netdev maintainers rejected this approach (for now). I had to
re-add the atomic_t code parts back in this patchset. But since the netdev
maintainers didn't like the atomic_t implementation, everything was changed
to atomic_t with the help of scoped_guard() or spin_(un)lock_bh (when the
routine used "goto").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- fix setting of BATADV_TT_CLIENT_ROAM batadv_tt_local_add_roam()
- move the roam_at setting in batadv_tt_global_del_roaming() before the
  setting of the flag
- don't unset BATADV_TT_CLIENT_NEW when avoiding the
  batadv_tt_local_size_dec() - it is simply not needed
- new patch: fix lock precondition for batadv_tt_local_size_inc() and
  document it
- clean up mini-helpers to avoid goto. precondition for using scoped_guard
- switch routines with goto's from scoped_guard to spin_(un)lock_bh
- Link to v3: https://patch.msgid.link/20260805-tt-fixes-v3-0-25b00b558470@narfation.org

Changes in v3:
- switched to spinlock_bh due to rejection atomic_t by netdev (and
  potentially easier code)
- switch back to RFC
- Link to v2: https://patch.msgid.link/20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org

Changes in v2:
- rebase on main
- add "batman-adv: tt: use atomic flag modifications" and "batman-adv: tt:
  simplify NEW flag transition code" because they are reverted on main
- add patch to extract the roam "add" code in a separate function
- make the "simplify NEW flag transition code" patch independent of atomic_t code
- Link to v1: https://patch.msgid.link/20260730-tt-fixes-v1-0-64e9e525d555@narfation.org

To: b.a.t.m.a.n@lists.open-mesh.org

---
Sven Eckelmann (8):
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: drop unnecessary cleanup goto in helpers
      batman-adv: tt: use protected flag modifications
      batman-adv: tt: transition NEW local entries only under lock
      batman-adv: tt: don't uncount never committed clients on pending purge
      batman-adv: tt: decrement count for committed client on local_remove

 net/batman-adv/translation-table.c | 487 +++++++++++++++++++++++++------------
 net/batman-adv/types.h             |   8 +-
 2 files changed, 340 insertions(+), 155 deletions(-)
---
base-commit: 46e983472304d8875436a23ccb996ea18856081a
change-id: 20260730-tt-fixes-fca2b722ebbd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

