Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDED7C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 09:25:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 626CC84694
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 11:25:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783502744;
 b=OPZJJPXZ7zy3NbGDAk0U+0LmNpfSe+6woUIVGWl5qZFmulJFMU06bh2ANIb/NeBtSgoCz
 iTv6vlA+iZEXmuLoa+FcX+s5oXG/NIzvxEhQOOmwCPkEp4KgFnk+GRnyMAjDwy1pXzuLX1y
 0XCiO3GtVHBGGNiD0J7NFfCezJwg6oc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783502744; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Mhon6sTuY4kUTXwjWv/Mi9kGv+9UzLfGRQ7dJRuPoZ4=;
 b=fAYcQdVmjHrFUN6e7BSJ+tp+qSVd7vQed6mM24gcxhgebp3fUYpMz22q5gWy15vfaEeZf
 68SfGXf2roEN3r0HeO1j8uinT0tMIj6kbWw6EYcR0L2Yw/sDsh5u2FYOLqTM2toWAs9fut8
 AqppTLpywxX8ScFMcBjvnCTnqAOkcGs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A580481E8C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 11:18:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783502326;
	b=UziTFucQo9ZonepYfz+jSBlSlOv1vKPwlSC3GQ71mHJfwGQdzvfvLvZXCRFhn0woCzLLpI
	I4KR6+vEt74O4QSt2dGoaISSpUTDQvdt3pj5gjet3W9pnoTzCxw5xkux7fc5kCv+3uvjrp
	GGn9eVZjsnj8+BbPLlwJzoiMqnHoRi0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783502326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mhon6sTuY4kUTXwjWv/Mi9kGv+9UzLfGRQ7dJRuPoZ4=;
	b=vXvtfEHtVrWQPBnt6TTeoM/rMr5XNBo5jyV1manFxekYudDCjTwbuWz3MjLHFuwi+gA7uW
	pOdcrH1IkA0z0ymon/20x5tGMr2ln3AZaXqWsFXIzXKuXxPX+zyvwV5mRfvowQjkvDzN3i
	FEBmvC9oNa7ejbS5TSQDm2woTgOmEMo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=mN+nJC0h;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhon6sTuY4kUTXwjWv/Mi9kGv+9UzLfGRQ7dJRuPoZ4=;
	b=mN+nJC0hwMwr8tRccPs1GyDN2Pi/CAxBAEBxe1wnx42SIMgXXRUhZfXYc3m2lQtAb70G8B
	WQL3CHenvd+3zxuodQAj9RkV+njCVLgnF9g24+NXwXj58VUOvWjKbufU5jRjEkkPmj0p/r
	pgN6c1s+xqScl/WK7sVOl/8PErDZwMCDfGYKfvyaU1Fj/HSkJUoyHBo+t/+rMgb7nSuCIC
	mHh38te0f84yXeM7fHJB39Geu5J+oKOPXqOZXhTJEjS3tqdnH1Pc61u8v3izyNkz/RiUdk
	ZI7OZXEg4n8km/8MSMNIzf0emYMiGAKM1fAly6PgXddjr3sNMHb/c13tGvYTjQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 4/9] batman-adv: tt: avoid request storms during pending
 request
Date: Wed,  8 Jul 2026 11:18:16 +0200
Message-ID: <20260708091821.314516-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: D33WRXO7VLOTN6RJ3ASFGKHIJHLHOUAM
X-Message-ID-Hash: D33WRXO7VLOTN6RJ3ASFGKHIJHLHOUAM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D33WRXO7VLOTN6RJ3ASFGKHIJHLHOUAM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_send_tt_request() allocates a tt_req_node when none exists for the
destination originator node. This should prevent that a multiple TT
requests are send at the same time to an originator.

But if allocation of the send buffer failed, this request must be cleaned
up again. But indicator for such a failure is "ret == false". But the
actual implementation is checking for "ret == true".

The check must be inverted to not loose the information about the TT
request directly after it was attempted to be sent out. This should avoid
potential request storms.

Cc: stable@vger.kernel.org
Fixes: 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4bfad36a4b704..aae72015645a4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2971,7 +2971,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 out:
 	batadv_hardif_put(primary_if);
 
-	if (ret && tt_req_node) {
+	if (!ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
 		if (!hlist_unhashed(&tt_req_node->list)) {
 			hlist_del_init(&tt_req_node->list);
-- 
2.47.3

