Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8C9C61DBE
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:27:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6E3A683C77
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:27:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984852;
 b=2BF8HXC5wB1tRtkGngF8y/FL7C1V+mV7PXXqLXy393Y2ewPgfTvpo/Fx/SAIcFop2HBtl
 wfE/qLic9D4Z/r5jBBeQQhF2NzgV/aGwFOw7ZydYkYyqL+QkMdnV/ipeoLZZM0UY805u2jV
 ZltXqRCb73+eYCCE6pg6qsxPDVnPH/4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984852; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=R+F1nFM6RQuIJmO4sCr7uJOONBO6TnIT0+ttoPkLVzM=;
 b=0co91huIwMb2tQehWkBd4kJvtVkCtaj+GdRlSEvvNPk/eFzqaHOypkNqOaJt2EsOv6Pyb
 Fh67CArQQE84NJaN9EXZz49bsnqTviE4LnsFNncLelbjLkqUdKZZ+BTC+HJzCGYWxAsOoj2
 RTfN4GQ46/n4Zm2QGZyFXItBHJQJCFY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AAD0984300
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:22:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984521;
	b=kym1ESx2dDzkBZMGIttflSd5qx2LuMK7ucFWk0mRIo+mxRVzSaZSeNRWAqAT8TOEVkR3zq
	COIRsXC02PxbPIvgCJ0Dwqv02I0z7T/WR0g2624NZmeGDycENzFIyebVh+6gPAYV9QZ/O3
	QqglSni6CaDfABaMtDwWu1dwhhorxLA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=R+F1nFM6RQuIJmO4sCr7uJOONBO6TnIT0+ttoPkLVzM=;
	b=eXS7MaMgdH647LpltGkBj88zJnEYzpuczjVkTduHS8Rf3ZEPO+w4UEkajq7jzpCkD6S88D
	CehP3fhNSXr9cfU9MYoOxn+v9L2R3u6GOyAsx+ezJgYpyV7ZdgXmzfaV3x1QcR8tQ7rayu
	QGZ7JjS3YHoiOwxAc/Hh0PjYUw40Dqs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=e2l+ewgO;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 427681FEC4;
	Sat, 29 Aug 2026 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+F1nFM6RQuIJmO4sCr7uJOONBO6TnIT0+ttoPkLVzM=;
	b=e2l+ewgOvMqSKP9Pw75tN33K1HatS+KxPaLLG41MIslcCMRI1Rc/EBwD/1U7puhepULhCs
	PEHujDf7hfVJH1AOeEFgXbD49BIq7ZjtRFOife5tcTFJxiTYfd2MF6cY36MpfUt/oUrBEx
	jwwv3PzGvtMMeBaBKWQv+lQmISO2pfA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:27 +0200
Subject: [PATCH batadv v5 16/20] batman-adv: tt: replace add_orig_entry
 goto in batadv_tt_global_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-16-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=sven@narfation.org;
 h=from:subject:message-id; bh=QzC94YuN7tBaCFOXcSKOXBIHcpT4D8ZHaoEPPfEKbqw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKteyucnuU1X5luJhMG/e3adb1NucS/7qXNg31Wc7/
 01rDUX7jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBENjowMnzd4il1cv36RPsy
 aa9t1XmVs4tXvXjxxPdihyxXcLDqhyyGP9xs77aZ3tMrygmwPvq+NG9mlej5Z9NUzkzlLlhqyin
 6jx8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UI4O2ZZM2PAQRWG643T7VKW56MKV7XLX
X-Message-ID-Hash: UI4O2ZZM2PAQRWG643T7VKW56MKV7XLX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UI4O2ZZM2PAQRWG643T7VKW56MKV7XLX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The "add_orig_entry" label was only used to skip the flag merging of the
non-temporary path. Which means that the code jumping to it and the code
below it are the two halves of an if/else.

Both halves now only decide whether the originator list has to be purged,
so turn them into an if/else and purge the list at a single place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 71d9fcf6..17a92ff4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2073,15 +2073,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			goto add_orig_entry;
+
+			delete = true;
+		} else {
+			delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		}
 
-		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-add_orig_entry:
+
 	/* add the new orig_entry (if needed) or update it */
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn,
 					flags & BATADV_TT_SYNC_MASK);

-- 
2.47.3

