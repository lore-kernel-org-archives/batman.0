Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C604C54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:46:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 17FE38308C
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 08:46:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785480396;
 b=Bcs36C4XdlUfHgjrnII+fes5/t+GX+6OHc8TzFNzD7zdgbGWyzTz2qreIjagbMA8K5sqn
 Uy5lPQGU6cgewpJ0qEZATqDhyHT39UHp6ZQf5Y+QXAcGicYcbyPK5g5p6utPWtu+5Ut1tda
 RC3pbiRDpMm5NCLw/zc9ju6VEsiwizY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785480396; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PYHYXMrtSfzPlO0HyQ12S3Lx6c625IjtwIrObtjzlmw=;
 b=IrTT1RPNLGVk+btL9Bl69+u6lcCnzd9f8GGPsXjRmrgzzeqKNgBuXmAsytZDVRHz5JZ7T
 AKRDijGCUPoG4z+cpMWpoCNxsa76SUfYmWqBxj18QTP/l3SRDK8nZYVZZT/0Uv3l6GjFHhz
 H8nHnNUmc+yFbfhXxBjCp5wGE6ji0Tk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 336A584016
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 08:44:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785480287;
	b=WTlpxYBpuQdC94Jej1BADKGOm4bvLH3vH7QhMSB7j1RBgCzrGhAdaJrTENn9REE+FMHaf/
	zsn4euoz2rBDewloAJimgKP8gQbd4LvaMpLtH9lyW2JahMvy2WKNszhYoKFpHjlnXly/Km
	MGsGWWCqvJMORRkfG1tzjkkpIC/lR/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785480287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PYHYXMrtSfzPlO0HyQ12S3Lx6c625IjtwIrObtjzlmw=;
	b=itUBDBj5QmAHr/ZcE/Lhu6YwRxGNFWaq28x4j+nVjESvj/cmnw00Yk0S42+fi1HxY/+L7m
	3ZifPewGoxfUIb4kG9qB+4owWbnqpWfLSDzylzzHwZKRxVkcso9FPXajupeQSjzcVLF56Y
	uMcju4rHfu0Yoac7jyDPoWwRSDrdL9U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0fMAQVy3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C4A4F1FE2D;
	Fri, 31 Jul 2026 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785480282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYHYXMrtSfzPlO0HyQ12S3Lx6c625IjtwIrObtjzlmw=;
	b=0fMAQVy3QpnabCYZxpagT2YyDQdN1DLd4mfREei9TXjM00rRGccjpBgLPhCZX2OgKSDra2
	vUNUdTYF2dfLhDeRy3rwSOFE2dHHsikOXdKecC3VcPy+L4U9FSlwOICF/JMfZ6hiOmS3ZM
	j2A/QZRcjTTl+xuWw3DeEQ+l5V7kWms=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 08:44:21 +0200
Subject: [PATCH 3/3] alfred: Close the periodic timer fd on setup errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-leaks-v1-3-19e1cd3e7fd2@narfation.org>
References: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
In-Reply-To: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=sven@narfation.org;
 h=from:subject:message-id; bh=Z7KcL1xqbqURrN2jVhQ7deWnscxqOgJ0l1XVkN3dRg0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5Lq4aexasC2ONSeyXce+0m6Udu7hzg/X81nmLlLhV+
 raGZDzvKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwk/zPDP2U3WyXF5sbVwXWa
 82Onr9XJybRrSpdekvDqlkzX9rNWSQx/xZ+X102/Zr9soe6pgg3FCQwz1JwunDcUf2vHM89n7/O
 FTAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5WNXM5PLVFEQ2YDF5SE7X5M3RWCT3VBM
X-Message-ID-Hash: 5WNXM5PLVFEQ2YDF5SE7X5M3RWCT3VBM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5WNXM5PLVFEQ2YDF5SE7X5M3RWCT3VBM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

create_sync_period_timer() created the timerfd but returned -1 without
closing it when timerfd_settime() or the epoll_ctl() registration failed,
leaking the descriptor. Route those failures through an error label that
closes the timerfd and resets globals->check_timerfd to -1.

Fixes: d04723b78ae1 ("alfred: Stabilize synchronization period using timerfd")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 server.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/server.c b/server.c
index cb3fcfe..72b5ba2 100644
--- a/server.c
+++ b/server.c
@@ -440,7 +440,7 @@ static int create_sync_period_timer(struct globals *globals)
 	ret = timerfd_settime(globals->check_timerfd, 0, &sync_timer, NULL);
 	if (ret < 0) {
 		perror("Failed to arm synchronization timer");
-		return -1;
+		goto err;
 	}
 
 	ev.events = EPOLLIN;
@@ -450,10 +450,15 @@ static int create_sync_period_timer(struct globals *globals)
 	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, globals->check_timerfd,
 		      &ev) == -1) {
 		perror("Failed to add epoll for check_timer");
-		return -1;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	close(globals->check_timerfd);
+	globals->check_timerfd = -1;
+	return -1;
 }
 
 int alfred_server(struct globals *globals)

-- 
2.47.3

