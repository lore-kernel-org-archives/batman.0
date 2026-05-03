Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB1CD3426
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:24:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3AE2C80455
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:24:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811059;
 b=I9Ko42zoNdS5bfVMTibblvBE+HcwYnNuKbA7+/6IFXlxyi6jiD9yhOizMjwARZ8NXFRt2
 XnGQQ8Eu1VLYg1vsvukAUBPtxJUuF5sDhvrxWSgN76v9Wp+nr3egZHyV5RS2aXznXfx1qbb
 tneRdcCUAPYl1Omj1jMTJqiBKD1IHYI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811059; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JXg+3Cal2NtyoJqcb3yDaa8t1VMNblT1GtrYRFv3BPE=;
 b=bJhkUl6QMmknPzji7drqCrnRp7OuXNkTEPLJKGmn/iyVzmqqdg0sxxYQWtCBCsx0biX/L
 FFjYMiYLvFV8ZNgO6IjEa+tb+fyaCD/T5mFzs7ZP1Kh4R0NFyquifIGz59tPEqUDYTDpizm
 gKX1wrnMDW++SEaz3uOLUJZj8BZFNtc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9DB0084511
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:22:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777810979;
	b=0fQuJmWSR0O4OMzYwti9SnbEK7V4t0QkzKeaWHPMyfCrEp+6ZMDFYAFPTmPJOb9cRSOkuj
	rU7SS+w6X01WHm9+yooWe5g2YYcm3nKXvtZhDOYxZQm320B6puJHTCtRc9FKhtrrkzELmo
	SHyO5FH6wfjvvJQO2JDg67+lk12H5G4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=dPwQUm4r;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777810979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=JXg+3Cal2NtyoJqcb3yDaa8t1VMNblT1GtrYRFv3BPE=;
	b=Ned2pzUxvvkvGxef1f7b5Hb22oDo+gazDHVR9QhasbNJNSNy7rKv8uyZX/ycLpXPVHiK/t
	C+y5gfoczru5X6pLXxWxOZAUKGakmcLy8AqQwLPwScgWFCYbP/5JrgBDU3dkOcTvEHkeno
	JQ323t0YJyxlS2t9W+4ZMvj7bOTsX7M=
Received: by dvalin.narfation.org (Postfix) id E17FC1FF1D;
	Sun, 03 May 2026 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777810978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JXg+3Cal2NtyoJqcb3yDaa8t1VMNblT1GtrYRFv3BPE=;
	b=dPwQUm4r1zmvSCCZACP/qOyu8qAsKjOa/a7WRloaTnqYBkOeTDFXclPnTnWwGRIkO9Hf+h
	du3m2RZ4/t/NBWQ9gbGPHknOAdFALsOyiEeGHhGOvnQJoSCOSn/G1vFr8Xr0irNYQL6i7e
	lkAxJsOL2MprkLD1LX7tIwCIsYhw6Wc=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Sun, 03 May 2026 14:22:33 +0200
Message-Id: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAk+92kC/yWM0Q6CMBAEf4Xss03OajH6K8aHFq56hlDSAzQh/
 LsFH2eyswuUs7DiVi3IPItK6gscDxWal++fbKQtDEu2JkcnE+XLamLquvSZBkP1ma42XGJ0DiU
 aMu+L0twR/OjbGY+/1ym8uRm3N6zrD+DKpc96AAAA
X-Change-ID: 20260503-fixes-followup-064092b7ff55
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=sven@narfation.org;
 h=from:subject:message-id; bh=rVVDrd6KHlHSie/lH7b8n2cV8jhyUDO+nWJ9m1jRh8E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WSWzm5ee/nI1wvz3xSpbIrTLGMTiNUviTYQfjvz3
 rxVuppbOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATqahjZPj6Z8FmQU/9dU6n
 j6QFpss4+19M/l/ygcfBjZvBX17r0UKGP5yZYhuln6Ru5vw1ay//99OPTaZy/jLcxFm2pijlece
 CKfwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: JWEV4QXO5ZMYK5KVMATNW7O5QC4XTYTN
X-Message-ID-Hash: JWEV4QXO5ZMYK5KVMATNW7O5QC4XTYTN
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JWEV4QXO5ZMYK5KVMATNW7O5QC4XTYTN/>
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
Sven Eckelmann (8):
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: prevent TVLV entry number overflow

 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++-
 net/batman-adv/tp_meter.c              |  5 +++-
 net/batman-adv/translation-table.c     | 55 +++++++++++++++++++++++++++-------
 net/batman-adv/types.h                 |  2 +-
 4 files changed, 58 insertions(+), 14 deletions(-)
---
base-commit: 3d3cf6a7314aca4df0a6dde28ce784a2a30d0166
change-id: 20260503-fixes-followup-064092b7ff55

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

