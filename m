Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5378EC55ABA
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:13:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DCF6F84217
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:13:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942782;
 b=tKJthi/mhqmNvJRQYLj4IFs4i5UMTyEscb6BS/6TJh3GI6XIs4klsZ/dwAF8f6AwHf1ZV
 beQkXMKwUxFZDjD8EzWuAbmWNbuqURWOd4XFVW9XJN+TlLiGhSeOoALw5tycixdt8qfQvWS
 Rb55KupDlTkrNRrFbeqeTXwWgU/5V+E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942782; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Kc9axLQbzzzPVZmIfy2VaGCLraTH+EsNOvkNVXCJ4+M=;
 b=2/nQLlgw8ZjOpEgUAzq1PQpKpDgmnUSc+AOOIlQd6ij8E9RA1bN34gpD/5SJ491ULaUYW
 aAJaJL0egX9rUHekDEzZRbT5sOCJHZLoRKIRm77prqCyjidXkd5inc723ZGfabyR6qTz3kh
 bSdYg7Wr2FdNp3NEdpMzKx5mS7jHJMY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C1A5C84221
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:10:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942637;
	b=MssCl8MdxYpooAtMspjj3tk7VDoJMhQhr4Bo2f2aVsJ+51iCEuUiPwSO6GD+d6sGPa+V+V
	1ed7nk734qAfcmrOdHcBbh/5fEqf0ASIWdO85UmBeCzOqMbp9VuxxRJmpuyhE2FaSV7DqA
	oX3+aaiShd9JYGBUoBwUuCEtrbvh3XU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Kc9axLQbzzzPVZmIfy2VaGCLraTH+EsNOvkNVXCJ4+M=;
	b=jVnoxhWD5xdd3vHtf2KN3Yl06iALVpLLHISeO/XAOC+Emgz99gRmZt9wzclKwOcOaF+brd
	sqo1ZZpYDzCtSwRj4Yn9S8A014PHgEq0JdBGJ6Ocd6DudmIa3tjQLVqX7g1KLRpt65CB+w
	wKXKbuu97FlJZuqlWHDZF/7MzIyh9xk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AbHnbOJ0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5D3C3204D0;
	Wed, 05 Aug 2026 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc9axLQbzzzPVZmIfy2VaGCLraTH+EsNOvkNVXCJ4+M=;
	b=AbHnbOJ06TKhsT7CYg6q/HWfEnxwUI4yEjnUjv8juWqfGGy8tN+u/ovavzfcQo5F452PwY
	vHDfUhnyATqxflmgEXCRRZL/aYxDQ556PMttCVwEUQAAgDHQC+Jmq+opG3JIvC6gVYotLw
	gtRRtXpTsqBBz7nq4NPyufmROmK2DsA=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Aug 2026 17:09:39 +0200
Subject: [PATCH RFC batadv v3 5/6] batman-adv: tt: decrement count for
 committed client on local_remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tt-fixes-v3-5-25b00b558470@narfation.org>
References: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
In-Reply-To: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=sven@narfation.org;
 h=from:subject:message-id; bh=/d2N1s+vZ07aT0MgU+pMGxMFSbSQH3DClcSaG7iuOhM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFQaazdvALrg+w/J96JETqV+3irweXLexz40lqKGj3v
 rosfWlURykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiWyUY/ocIWR+5bRDUsm3j
 4aTu1q/Tg2bNeR4kkq9VennfNhnXoGcMfyU+SZ18GC6Y8cP4eOOhT0wvC/yvNjBbpv90UvywukO
 amwUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IJF7U4AYLUUPHL577HBZCHGMOWYAO5AV
X-Message-ID-Hash: IJF7U4AYLUUPHL577HBZCHGMOWYAO5AV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IJF7U4AYLUUPHL577HBZCHGMOWYAO5AV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index df99c67e..ce76d056 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1458,6 +1458,18 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
+		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)
+			break;
+
+		tt_local_entry->common.flags &= ~BATADV_TT_CLIENT_NEW;
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+	}
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

