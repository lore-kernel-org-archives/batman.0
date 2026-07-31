Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E97C55171
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:46:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1E06F8404B
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 08:46:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785480360;
 b=PuPTNO5ze/ZZXCnmqLaWBaktW/vZvs3XewxlYqM0O77RlF8AO0nSEjPYnlHmOy8QPYoGG
 nZb9uJ4egHocOwwyNGRDUftuFympqGm/HOshOc5w0iLRu36O9jBkWTHjtTu6zL5XVJdQFEx
 qd4q1Lc106+z7f7axyGsTdMfFyEYfcI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785480360; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HulrZYTjl8hrn1/G8bnwWXO1qIe57AHPiZeont99WOo=;
 b=ZktefucHJpDlCCn6Ib5FOIvdC7BAydj3kG/qO64aW2cSVga/9avjdkfz04IUw3RI8l7Yf
 iABC4ByBTiV3/ZVfY2yY9eNpnvjJUDj+8jgEj4Nz58yRG+Jy2OSHPGbID8BNpO7wF3anBk9
 eweBqoP304ef82hYbt6hTD0GABwOyuk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 48A11811CE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 08:44:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785480285;
	b=Co4J6w05Ug94aSCKuOI0qD4fKqCzSCu0xPZFrxXZFFYS/a6u6df/MbGnHTI1ZCjvvIfSY9
	MtYrYFzaQx8F3YBPUJrm+LTxvXHJaplIgeGeEu9/1dDxShjp9KsXE66J+J7dZBNr4VGUUA
	fsjVpbNc8UyG0IZl/lIfEX65o12RWms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785480285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HulrZYTjl8hrn1/G8bnwWXO1qIe57AHPiZeont99WOo=;
	b=hTvgSQG/HsE5SmwbuZ3fScM/KrcyQEsvuXzeCK9HmRGRn+uLtnimRxwQyHuNYMa5ReyHdR
	qzJczzSv4xZpsWR0DP2ReHR3uXVerLiJWJ1g1rAY1By8ZjuavC5QI2DsdULdM7mUCMOFzP
	hP1qoRRZ+ZI854gJzu1jUyUKinW1+pg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CPMctE5f;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 56D4820CD5;
	Fri, 31 Jul 2026 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785480270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HulrZYTjl8hrn1/G8bnwWXO1qIe57AHPiZeont99WOo=;
	b=CPMctE5feA+QrKceoOTJUgRXwea0AueoS21mQ4Q5EB7hb1x0P5AdNgA55uxwBibpcWpFua
	NQ6v7RPgP7DWYXL/plFZFVb2T6MSi8VrRd3snKWsUqN+WpU4v7ygMfzNlGEwYFasUOO421
	/IGMaFTJj6NBgbVafLogisGijqJrIus=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 08:44:19 +0200
Subject: [PATCH 1/3] alfred: don't leak event listener when epoll
 registration fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-leaks-v1-1-19e1cd3e7fd2@narfation.org>
References: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
In-Reply-To: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=sven@narfation.org;
 h=from:subject:message-id; bh=swv3Ne8k/J99s+N32uSwr4EyJd6e0kfheVl74HPZv7w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5Lq7TRc2F6zPkSn4bGPq/rvxm/C3W2N+glvd/YOpxP
 S8/0f6OUhYGMS4GWTFFlj1X8s9vZn8r/3nax6Mwc1iZQIYwcHEKwERUQxn+h9291iuc4cseMHs2
 byc/y9/3qRoC3xYx2DH5dJ07tNumluE325nTNpNfHTsYIh9dU6D/KU+o9Hp9Xochk/QWgXD1I94
 cAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HITD2MQULP7FHE55CQMKRRVUKMYCVME4
X-Message-ID-Hash: HITD2MQULP7FHE55CQMKRRVUKMYCVME4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HITD2MQULP7FHE55CQMKRRVUKMYCVME4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

unix_sock_register_listener() allocated the event listener before adding
the client socket to the epoll instance. When epoll_ctl() failed, the error
path only closed the client socket and the listener allocation leaked.

Fixes: b106a7a36f98 ("alfred: notify event listener via unix socket")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unix_sock.c b/unix_sock.c
index e6b44da..07552a2 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -673,6 +673,7 @@ static int unix_sock_register_listener(struct globals *globals, int client_sock)
 	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, client_sock,
 		      &ev) == -1) {
 		perror("Failed to add epoll for event listener");
+		free(listener);
 		goto err;
 	}
 

-- 
2.47.3

