Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332CCCD4851
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 09:58:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9322D85DED
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 11:58:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839115;
 b=SIFOoGAKHvzsQQCI8eyn7hvJ7hGI+a+CgwKz4ef28wS68MLE86AkGTAq4aD9cQwtcy3WF
 Eeygs4GM96sT3BNDp9HLa2+CAN7RLCA5mLnQiMOXTLq77WRCIomfCRKSNk76ACuyGamjFnL
 eN4xqJMsHk5UlBtWK4mocaTb0kbLVFs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839115; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oT/G9+Zz9YlSVEJ/eFHA+Bgj5aclyRHbfRtU5iwzmRQ=;
 b=WtZQWlyIYHO+gBlpYjbf+z7cJgnjJR7evX9vi9mcoHnbFHvQvnHhWGzOoEfStgXbjxS+M
 dU0rQnQLCBh8vlo5FvjwMbOjNKnMY+8dbyQGDR09edllT23mU1KtBZv53ncO7aG40z1ufxO
 o4AuffW19IN4D1/xH7fOKT3QaWvS5G4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BD4B285337
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:52 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oT/G9+Zz9YlSVEJ/eFHA+Bgj5aclyRHbfRtU5iwzmRQ=;
	b=F+kCO1d6W2/xZnSI+ALJXMF5JWBIaQCwpbPKRUENmkosa3u+WdUZT4WNIEg0pAU7oPmS1e
	d4qooRtLKJgAIhIZLM+5h1wz8X+M8Sp9iwwHMtUsxRHC3einKT6j925iYrUqckxdfnkXUH
	f9ck8wq57RjodaXf2ZuZ6xqSEux1YQI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=0N2lOlnx;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838952;
	b=Q/hOWYgqnCFTnZ9xn8LBaQfRFHosOZJFFDoQy2jA64kGLT+r6P1YEQsclX+1o8gbBwU56R
	xB1dguslDIWwAPYk5XmTQmVzRbcI8QzcdM+iWXWn0x7V8OPBBzaWf+qy5kPBxKiQOffN0V
	9e3OObp/swTRbLMoSoBkMWeoSuDOiMQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oT/G9+Zz9YlSVEJ/eFHA+Bgj5aclyRHbfRtU5iwzmRQ=;
	b=0N2lOlnxd5O0KTE7O9focD8AsoIu80ISUws5w2c72OgQUPTEU9OY0h2DT9jbXD45KHga+a
	U7Hj1kzRW80/SWsqwCyCuFzZc9yyT69h1zkMY9lpItD0ClK9e/Y4DqUU3liUVnSGpGp2zg
	Clo5pkOcppsPUMt4PHb/LpFjdurqJ+lItO2MB5TgOuG9OyVGcchj9DsPBmznV5kXw15ZfP
	y8HTFwKsyaJsnSsEPy4wYvUY6fyx9vg/LMxSVkgnrI8jEm0zmfBzUd1I016kbrnGoGBhUS
	FKlxKCxpKrHsa7WjknsC32DjD9Dgkbyk7bBJuzYyjBvJCeBP+BeCNfyt5paFCg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 05/14] batman-adv: tt: fix negative last_changeset_len
Date: Fri, 15 May 2026 11:55:30 +0200
Message-ID: <20260515095540.325586-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PCQ7W6VWL3BCQQVLCVAXOT6RQA3ALYLL
X-Message-ID-Hash: PCQ7W6VWL3BCQQVLCVAXOT6RQA3ALYLL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PCQ7W6VWL3BCQQVLCVAXOT6RQA3ALYLL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_piv_tt::last_changeset_len len was declared as s16, but the field is
never intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_my_tt_response(), last_changeset_len is temporarily widened
to s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_local_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_my_tt_response().

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 888f337a194bf..739439e2b2350 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -993,7 +993,7 @@ struct batadv_priv_tt {
 	 * @last_changeset_len: length of last tt changeset this host has
 	 *  generated
 	 */
-	s16 last_changeset_len;
+	u16 last_changeset_len;
 
 	/**
 	 * @last_changeset_lock: lock protecting last_changeset &
-- 
2.47.3

