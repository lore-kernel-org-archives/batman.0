Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA1C43458
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jul 2026 19:49:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 117EB8542B
	for <batman-adv@archiver.kernel.org>; Thu, 09 Jul 2026 21:49:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783626540;
 b=n+g16gSfuTsWHlCwmdpiBGLjzYSJVQZwHENJhhSGUwsHbAI8EW7LpfndNCS2DSQEA+z/y
 1e4uqgMJgkZiabIRU+4EAjkTqLhEuZPeUOlyxxDw/JRrYzp+0tAy0hqVdg131r5QvIahPqF
 ClcBrA3gcjxGfl6EbdL4umRFdo9YMIQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783626540; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7fFZl6cR6yJ1E0qC7Ojntbx6BoRWi2TDZrKor93CJYU=;
 b=NdwgHZbG7zhuP1oDjPHqecR8OJCDrkATgtPxsdmFhVa3Am0lsgH15hC5WCzOBMOxlHeSP
 lCVM01TotytlP8jnhx8bbT2m8K9yfCHA/Ox5y0M3zvOyFQlrKebuE9sq9GOYpYjnj+Lv2oE
 izh9UP7t5GzztPxEloXGR6hblNuFcdI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9D91083F88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 09 Jul 2026 21:46:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783626386;
	b=RlSDsQyomF1OFKGGdr6O4Y9gmmo/0+mWR31uWaffKHnZaCZYK/toIS+Jjo2Elp+PDPsscn
	CCaDSYV9fVvpSkeBfLrdcfQ4wa4LQCd1G/dKl9VgznFGlTG1BRcSCofs4BB/Ayvkrhvnbp
	/qVD8lHplaGrLPwZni4XtiTtgkW8cDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783626386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7fFZl6cR6yJ1E0qC7Ojntbx6BoRWi2TDZrKor93CJYU=;
	b=Iqxz4wdQ/uKQEWCIWOFPJEmW1gzq5hwZZKjaKddJKMM2m5wXtqabUOWaxbNlP7Ci466HJa
	Ozm+BJ8z61Gg+GQk4ZU2EuJz70i1m/HF7luLioDlsehoDQBXalodI7u7WJCR3VB/Ua8pv6
	AGmQ76imKSUgGTeIln+CzbvPzxbAVHk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kih5IK4e;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1357E20535;
	Thu, 09 Jul 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783626381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fFZl6cR6yJ1E0qC7Ojntbx6BoRWi2TDZrKor93CJYU=;
	b=kih5IK4e/jf5pO0E+nEaEm9zUhHR1JgTkUK+JgXxxRIGZylxjUsoR4Pi5ovBrtnHDfXhlH
	42W/577zl+53w/eCyDZDs9zPj90Bwu+ClYfAjuglRbJJNQy/nMu0C+BaeElHvSgAFVaY9/
	iGPrd8IESLur0gc+zp6VnSz3WlnlYlc=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 09 Jul 2026 21:45:56 +0200
Subject: [PATCH batadv 2/3] batman-adv: mcast: ensure unshared skb for
 multicast packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260709-mcast-header-generation-bugs-v1-2-c7c111fa45b6@narfation.org>
References: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
In-Reply-To: 
 <20260709-mcast-header-generation-bugs-v1-0-c7c111fa45b6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=sven@narfation.org;
 h=from:subject:message-id; bh=dfABjvIHlTgEg16wDCrHhwR6iRePazqbgA9CvHcQab0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn+v8rY3FZ84ljUznPD/1pH4ISsOyyZDDm6h1Ym1JfM6
 m0KFHjYUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIsdmMDGvtlJL/yd5yYD2Y
 f9W/tKj9tdlVlS22/NPZwqpube8u6GRk2Do3/+L96ctXrBJ6VZR69ukXvY96os4vmH5Ubiyd6VC
 XyQEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GQ32KXGV77A22WAY6O3LHPOJ6QGNBERC
X-Message-ID-Hash: GQ32KXGV77A22WAY6O3LHPOJ6QGNBERC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GQ32KXGV77A22WAY6O3LHPOJ6QGNBERC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a packet is transmitted via a batman-adv interface and has already
enough room for the header then the nothing will make sure that the skbuff
is unshared. But it is now allowed to modify a currently shared skbuff.

Always make sure that the pskb_expand_head() is not only called for a too
small header but also for shared skbuffs.

Fixes: be9b0169c840 ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast_forw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 60ad3a55..c5b8e2e3 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1100,8 +1100,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < hdr_size &&
-	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
 	return 0;

-- 
2.47.3

