Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE214C43458
	for <batman-adv@archiver.kernel.org>; Thu,  2 Jul 2026 19:07:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0FBAC80CDB
	for <batman-adv@archiver.kernel.org>; Thu, 02 Jul 2026 21:07:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783019235;
 b=OjB/74fRnkAXDx2xZ8XT3y9kq1XRdMNowjquBpVO6Mn1ZskElmQYxGuvapDYve8AQZxKz
 LQRMsMGSGejvYdDuGsATrI5p5rzBrWLw9rIlEitW+3DEzHKd510HpofBNwR2Eyoeb3tb0Kd
 fx3M4d63xRilcwV/A/0qzj7XkuN0ARY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783019235; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9KJ0zukg3zskcHeEtGe3ziBq7BMa42Sl2DBRnKIva9I=;
 b=nyf+uz9ipRIRmFeYPpOBbPdC5+OTUVrWTSyizx7RcxevX3Y5EDUEDWGdsP8O6ycaXODSt
 f9AqY4vCGw4EGf4YZr98oJ80GNdwkjCOV7WkgxoaiqE0N6XMlCf/3dpOdI19NTNrRqQ5JVB
 Rn7mRCMevlQql3+LXrrzfURvkISsxq4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4965F80FA4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Jul 2026 21:06:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783019213;
	b=oGdDnsgDo3wARWYk670xT0L0JwMGTPuc38r+UnyALCElrhlT6knymJsGW82+hhnb70GbPR
	Q5JdI8I1q8v7lT3BoSgzo7LXlmrw6Dx1K4cXlfH6rksBenVksCFZUQXXCJHgtlT5rvxbjQ
	/i+E29oEx1b1F0c3DoBz4/94yVa+LDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783019213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9KJ0zukg3zskcHeEtGe3ziBq7BMa42Sl2DBRnKIva9I=;
	b=Q06kJNcrsvLDAZUEIoFSYkfWHUma+Wm9ubgJsPxYyCfMt+umLGUnFR3/+Kq2ES2ZtkdRWt
	N6LQ5u3Ov7mvqSfcdQFY79D4oFNXGl2XvkrdFQuvnbG1T1dw+DGw98M1E9HY4/++3R9UOs
	UWusvxVNlcE3BqqHm/lghUkd7d0Qrag=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eJTAhAQl;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 61C08202ED;
	Thu, 02 Jul 2026 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783019202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9KJ0zukg3zskcHeEtGe3ziBq7BMa42Sl2DBRnKIva9I=;
	b=eJTAhAQlG/r67rooU0uJwQ5UGtX725KmmCMGVMunSOcP4A66IkV5PYTSPsy2oTgSnWIi6s
	Z1VvvSyYBq0vgeTjQ1lK6ZpIHP5MVRQ9z48TCxde7kKrmL6Wr/T+pNEdiB/HRXcTnWDTVY
	DOm0vuH0WU5mPMYCHiwmzcxrCUY2/Mw=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 02 Jul 2026 21:06:23 +0200
Subject: [PATCH batadv] batman-adv: tt: avoid request storms during pending
 request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-tt-req-fail-cleanup-v1-1-c4a88d99afac@narfation.org>
X-B4-Tracking: v=1; b=H4sIAK62RmoC/yWMwQrCMBAFf6Xs2YUYbYv+injYJi+6UmJN0iKU/
 rtRjzMws1JGUmQ6NyslLJr1GSvsdw25u8QbWH1lssZ2pjeWS+GEFwfRkd0IifPEvTdHHNoT2tB
 RLaeEoO/f9UKDFPELXf8+z8MDrnyXtG0fDiamXX8AAAA=
X-Change-ID: 20260702-tt-req-fail-cleanup-7d04e359e5f6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=sven@narfation.org;
 h=from:subject:message-id; bh=QFX7WH7OUuTMXvGrk1j5PywRVC01riJJiNCoVeJ43jo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlu29bP7e7wXr1y2o0paoorSpevvaWbypSS4tGl8up8f
 8tJ5omzO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATyW1gZHi148u0dRmXM99r
 vPmw4frOjaF3pravKHp0k/P0vfM9nyeXMDJsF36uJHnm/St99WOV8rdErtl5B288HslYP8e/P3v
 LOwt2AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QQWXOWTD6ROFKATGODMFW4G3WOZHXXLW
X-Message-ID-Hash: QQWXOWTD6ROFKATGODMFW4G3WOZHXXLW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QQWXOWTD6ROFKATGODMFW4G3WOZHXXLW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_send_tt_request() allocates a tt_req_node when none exists for the
destination originator node. This should prevent that a multiple TT
requests are send at the same time to an originator.

But if allocation of the send buffer failed, this request must be cleaned
up again. But indicator for such a failure is "ret == false". But the
actual implementation is checking for "ret == true".

The check must be inverted to not loose the information about the TT
request directly after it was attempted to be sent out. This should avoid
potential request storms.

Fixes: 6228419df3a5 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6a132e23..fc635164 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3228,7 +3228,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 out:
 	batadv_hardif_put(primary_if);
 
-	if (ret && tt_req_node) {
+	if (!ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
 		if (!hlist_unhashed(&tt_req_node->list)) {
 			hlist_del_init(&tt_req_node->list);

---
base-commit: 9bd026856d0c9680390b1a1a42ae0fd44532c3d4
change-id: 20260702-tt-req-fail-cleanup-7d04e359e5f6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

