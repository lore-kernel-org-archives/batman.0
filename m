Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B287C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:34:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B31D8433F
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:34:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245650;
 b=Hkm6JSdV3vgqB2WBdGxlmgZ1l8JsAm+J4iXJs6n7+RGVZd7kTKlaGiFkwEbIezyD7qHS2
 Ewe2HzSpDIoXe0hljo8nTc/7kZg0O5vW6yvpGoCqFTE/Il0aQ35+x+hmlxzMUh7OVrJLQPQ
 s5mqQb3W8l/RYLZCrmgg9y2GGpQK4vE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245650; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UQhKx65TWzi0PF4iO5S7oeG+Had5yv3vKkWTYViDdYU=;
 b=M4Zn25lX+Wt9KP5sS8fZz4D1DWuxhP5UDSwz9NcUyQOn6M1fab8fnyhzcq6q/su8xf30d
 tRA45X9dN4lA5vozcGVubRl+h37eTzT0fWH/85y6VyGuQz+P9FJ3jx2uDMa2luxr7aDlOYd
 AOYuM3nu3U77XyGx1WSgLpYFjTJ9zoo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B4475840E8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245606;
	b=srPuI0+tbB8ROqaBXTMoOQxbBcRCo6AC6L/upg5HfFByiQ+hdv4xFj2lOMhuK8YBr+aSQw
	VHKeVC2CWUeYyCK5mX2QtzKjnT4p47hHgsob3hK7wlrTwi4NZJYm1lFqJOTDON49Oe/ux8
	wHWzLy/a4tuQngdHPQyVA8Mw5Lw7av8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UQhKx65TWzi0PF4iO5S7oeG+Had5yv3vKkWTYViDdYU=;
	b=AInKreAWwKmiax1lOmdVwiqvqjPm/c7NjPJWJ+nDUDhCuk4BxN5kSsQuf/AQi0gBRVaD4H
	aKCP/jeT0uuEnItvKlMEmbNmep32z4RqIpm/m2M6GU4XjKnvbYsLWboLjabGNU1ogX+m/1
	JIfwgxGjQa1um06hBxZfSYHdFjQJfDQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FakQoepN;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5408D204EB;
	Tue, 28 Jul 2026 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQhKx65TWzi0PF4iO5S7oeG+Had5yv3vKkWTYViDdYU=;
	b=FakQoepNyCBiE4QRVZFFNzCisgz6jUx4vG5zwVG8ErxK1T/Jh0oWslkuiHPgazU/6hs2EL
	ITlkE+yFFn1wdCxhK//ov/9RIMPrbGHaVkum/t5GfpRn9Kof4hzPekuGDjeuaJuHcm1CnA
	wmR6FHhMUpeuIkY44zJXylMJ4Z87XR4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:11 +0200
Subject: [PATCH 2/7] alfred: gpsd: reject too long unix socket paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-2-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=sven@narfation.org;
 h=from:subject:message-id; bh=f+aftLyU0/OCFn+TLfZwsfYyT54tBeO3Qyi8DllL1KI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61t+207qVnVfdi17zaIk8SlXlI7ZPr4VVlLz0l3hZ
 /zrfp2mjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEvusxMtx9lj037JfodMOV
 S886LPB+/m99Yq9U1cnn/ytnVqmwx5sw/E/c4cQXcH2uaO1Zj39VAY+Y89Ml3yr8m7dndYXlm8k
 upxkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4TPX5DYY5F4CMHVUC2B3EP4DI35LOV3M
X-Message-ID-Hash: 4TPX5DYY5F4CMHVUC2B3EP4DI35LOV3M
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4TPX5DYY5F4CMHVUC2B3EP4DI35LOV3M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The unix socket path needs to be stored in sockaddr_un::sun_path. But
strncpy() is silently truncating the string when the target buffer is too
small.

Reject such paths with a clear error message.

Fixes: 6c6a6f735054 ("alfred: Make unix socket path configurable")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 4a00526..eecf914 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -16,6 +16,12 @@ static int alfred_open_sock(struct globals *globals)
 {
 	struct sockaddr_un addr;
 
+	if (strlen(globals->unix_path) >= sizeof(addr.sun_path)) {
+		fprintf(stderr, "unix socket path too long\n");
+		globals->unix_sock = -1;
+		return -1;
+	}
+
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
 		perror("can't create unix socket");

-- 
2.47.3

