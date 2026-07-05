Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3BEC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 15:58:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EC39081ADF
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 17:58:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783267089;
 b=3TMzFhzbcrBi2tqLrf3nVCfzKrMPGdpc4VI7iF/lMy/wgbmDbWflO2PjyP971b9QN5H8q
 SRSLHR2sShclrDpKQ+XAhaq1H3B1Y6vOPEyP7XQrE2f41L4NN5R+aIiHVj9yJ+t9Gozk+ku
 shqsnieCza7j3P4+dXc5+8jooufhyEo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783267089; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Si27B/9yGfIMp8XIL4gBQ5xcCclhocPffro1VFbWr3g=;
 b=If5unxCUBxnMgXYl32Nj5BE/tg2YHK2Kc4ZMesAKafG/EebjPqB22XK8oz2dyBcMwKbtB
 hbZeahExJisVqN/qIgcWZ61Cg9T858V8KGClNvXEg5m7u7EqKZNviUBtFvDQzQj79g+3akx
 2eZC6F8THSbGa1bcnbVhm8frN8kklvg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A21968191A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 17:54:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783266857;
	b=RseCOV44+Y/OCVdY7xAql5KwHWWcmcZkAp2gEocg+2GkD3jhtLwp/qzUpuMBxqNUGu6WNG
	RIaR8FSiOwhamY4vEdZdYSWNJZJQAhMmQSf5THmhI31oKdCD9FB0E4cxdiFp789uD6K2Ad
	yOcqdxalJT52bTA1gl2Eh6UPpH8O+rM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783266857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Si27B/9yGfIMp8XIL4gBQ5xcCclhocPffro1VFbWr3g=;
	b=nNRkvsI+2onEHd9VQ5Qclvp2zy7VmJAten+kXmbunNxivFsxBm7OgiHGrbUvxNcVW7rWpo
	rE7ETn7NAI6EVpksCWfTmv0aJgSng3N26s+nYW0JS+QifmOG340aNIX31742Wsv7v71AuP
	rioPuAx141+U1m7H3UAd1Uaozn0T6cc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=m98pBMPo;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 40A8E203F3;
	Sun, 05 Jul 2026 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783266857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Si27B/9yGfIMp8XIL4gBQ5xcCclhocPffro1VFbWr3g=;
	b=m98pBMPob4g5b3B4hhFmHj1CngmGIYQilhKQbCk1jQE69fZQ0buN9xOSCTDrEj29m06C7g
	3cJD8HwsTjSHMXqh/ckrV2c+b3ljcevlZOeHUv2OYe5INSx9tvFutqGDVgT/Fvflomt9Ej
	iN1iMwLnQ2hzoKaBoX71a2U0re+pgys=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 17:53:39 +0200
Subject: [PATCH 5/5] batctl: genl_json: drop leftover network coding log
 level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-genl_json-v1-5-8cc79129012c@narfation.org>
References: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
In-Reply-To: <20260705-bugfixes-genl_json-v1-0-8cc79129012c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=sven@narfation.org;
 h=from:subject:message-id; bh=qyIEaYIw3k3lrCbbtJq408/KPKoQu6MZZpWYnQHkdy0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFledfzdCZNW1+m+2bVNUvnI7Z6uyTNPnTG7u01K8sg/n
 xy+koD8jhIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEZl1nZDhSmXbh4xP3KS1r
 L1V8kjizS7Zl7qaKV6l3ci9my53YcE+H4ceHKW7V14ubV6+1/huv1v1X9Fxb6E6XgnuPHsoVhab
 rsgIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LWAP5RUKFGFARXZQE4ABYDZKIVSKSHQJ
X-Message-ID-Hash: LWAP5RUKFGFARXZQE4ABYDZKIVSKSHQJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LWAP5RUKFGFARXZQE4ABYDZKIVSKSHQJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Support for the network coding feature was removed from batctl but missed
in the genl_json loglevel output.

Fixes: 882ab0d91468 ("batctl: remove support for network coding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 genl_json.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/genl_json.c b/genl_json.c
index bb32cab..c3ef83a 100644
--- a/genl_json.c
+++ b/genl_json.c
@@ -219,8 +219,6 @@ static void nljson_print_loglevel(struct nlattr *attrs[], int idx)
 	       val & BIT(3) ? "true" : "false");
 	printf("\"dat\": %s,",
 	       val & BIT(4) ? "true" : "false");
-	printf("\"nc\": %s,",
-	       val & BIT(5) ? "true" : "false");
 	printf("\"mcast\": %s,",
 	       val & BIT(6) ? "true" : "false");
 	printf("\"tp\": %s,",

-- 
2.47.3

