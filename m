Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC9DCA9ED1
	for <batman@archiver.kernel.org>; Mon, 12 Oct 2026 11:11:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A8DDC8200C
	for <batman@archiver.kernel.org>; Mon, 12 Oct 2026 13:11:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791803497;
 b=A9ue4U0aGGXaVZ32aXmDcjUuO1ZcLYXISq5sidv9YgHURWZg0daiap8eWb1+pRSdr8Ad6
 Ae7qHDTzqk/E4Vji0OQtNcuOflrUG4ySqsMksExRd0EMBGStSewWWzatbhfhT6+DRFLGfGy
 ELYoyRi21xbmpPNQr4K4XxYuKFfuZe8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791803497; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tOTGCoKkRpQXYQ9u67sC/HFWoelI1Bkt3XUedgLcbmM=;
 b=bfXUAPws8X5hTzTqci/owUwLkrlLGTKwmkbY0NqxdU3islawpHJWUsvMJn37+Sx8nM66q
 9m5JhYXlDDsTY4Ip1ofQ0yRcSFhNeY4MKVvsfOIo9mABOrHaLxTxyDDPw0OA6mDpng+uOrr
 7qxSt4yv+7g2jKziyXq2gMk58a2nOFU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9E993804A5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Oct 2026 13:11:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791803486;
	b=h5RgVqlwbieBUVK2L1+IvSzjDtwb6Gzi8lR/21kGeY/OUMJPylLv5VdtXgDC4W0eTUTGwM
	DBlIIbr+PBt9yq1nazzH89vrk35UL3wbi3JeKxlU74qlMIWasMCEHFcKWeKwuCy+M3OBkk
	cus/JhPY1kefJV6qrkESOcwK4uSlHTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791803486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=tOTGCoKkRpQXYQ9u67sC/HFWoelI1Bkt3XUedgLcbmM=;
	b=BMw5hRMaDhD1d8NPv8lKhk8ASQ3t87W5xutA0LEKtiAAY1Wpn7vHukI85Thkx/tnIm6Eb+
	Vci2LzXWJMcABAHWVyYdyRbyYPe+LG18eXS8rJ6serzSz1AVq2chkT+n4djyvEdwM6dgNQ
	4hAkyUqHeI/9S9b33iFVh1khJQas8tg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZpJLA6pW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CCF3A200DB;
	Mon, 12 Oct 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791803474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tOTGCoKkRpQXYQ9u67sC/HFWoelI1Bkt3XUedgLcbmM=;
	b=ZpJLA6pWrzNeMXnR8WIDtHkbn10BDimdoeWZsTqHOphiGqOK1O1m9uvO4gUPmA9HIEpbU/
	aOqRBrQlEkF4XtYOkCl/mJziJE5mWfxD+2TWPiaBk0MsuofSiJleBfyAPKgYLnyuTrgHYY
	riskTQbAVfpueWH+kjFtjrGt5VlIjk0=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 12 Oct 2026 13:10:57 +0200
Subject: [PATCH batadv] batman-adv: mcast: explicitly initialize
 mcast.want_all_rtr{4,6}_list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mcast_list_init-v1-1-046d66d18e0e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAEDAzGoC/yWMWwqDMBREtyLzbcDEtkK3IiJ53La3tFFyoxTEv
 Te2PwNn4JwNQolJcK02JFpZeIoFdF3BP2y8k+JQGKYxF91oo97eSh5fXIYjZ3VyrfYdhfZMHYo
 1J7rx51fs4Wy2YcXw/2VxT/L5yGHfv/70L017AAAA
X-Change-ID: 20261012-mcast_list_init-4b31c7ed35e7
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=sven@narfation.org;
 h=from:subject:message-id; bh=UC32/eS1zgOLtLlT7h2ax7BgFezQbPQ5yxkjog4GiI8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlnDrjvvxi91z+xcY9bTMK5LMakK7dPfZ1vNu1A39Nyr
 0aTGwv4O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT6W5hZNh11VfL5InGFfm/
 ZXHTUhWn68vHS6hU23ay6Z6c/vDIv4cM/xTdrgTVvFp2YXrIekGd9X0xLDrcufqnT0kcK/i4fpo
 UHxsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HXIFR3R6EFVWU7BUVJ2AB4GDZANL77L6
X-Message-ID-Hash: HXIFR3R6EFVWU7BUVJ2AB4GDZANL77L6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HXIFR3R6EFVWU7BUVJ2AB4GDZANL77L6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

All mcast.want_*_list are initialized in batadv_mesh_init() - with the
exception of mcast.want_all_rtr4_list + mcast.want_all_rtr6_list. At the
moment, it works because INIT_HLIST_HEAD just initializes it to NULL and
the netdev private data is already set to 0 before being passed to
.ndo_init.

For consistency purposes, also initialize mcast.want_all_rtr4_list +
mcast.want_all_rtr6_list explicitly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6c54a8d4..e7f9677b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -216,6 +216,8 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_unsnoopables_list);
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv4_list);
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv6_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_rtr4_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_rtr6_list);
 #endif
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_HLIST_HEAD(&bat_priv->tt.req_list);

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261012-mcast_list_init-4b31c7ed35e7

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

