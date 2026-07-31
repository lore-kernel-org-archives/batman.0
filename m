Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1790C55167
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 07:42:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1DD108408E
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 09:42:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785483765;
 b=U6MQD59e1oF+VXFyGI7DPf1pCfzBoNLhcHCGkNpKd6lJjbbKGIwCTJ+d2XRyAiQVQv7MX
 okA50vYZJ2+eDwiYfe0eMy6KEpK3qJCU02rJSz2sJy2M47nGXvHAFuhTeDw39Mdm4qvGh6v
 mijY3ALOdOZxdgWUYuPWTi5MJ53HNCI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785483765; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6nsL31XBzBfd/4sCAzsmCgticaDAmAUtBspcLMS8bRk=;
 b=eky/SpAKEHesQuOVnqeQa2sZjygR1ETHXcYPsI50iwlgBX1jRjM9y+Xwe9L1khRG/4Ddq
 EdYyUs3GJa3Z1BHmcEFmgndCBpYZV0jfGp3U3fjTvXNm94cWNvp+S4PdPaJzMKSpBQNdt4K
 OmHpePHopi2QE3yFSz93kOmIH22npnU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9A4D284016
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 09:41:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785483695;
	b=ZVFE1QMmxneGmHxPrNXEN/OnKy/4BUkvu8GAkzn2S4qyjsvhG7D9QPotq8CdDuSFHWxXKh
	uv+zXvS++9s0fMdQs34WmX/Z35DbmdVMc2MKXpqu6kH31oLgqR4cYdoHATa31JM4QmxKaF
	Tr2UaQC3VZGuTqR6nXEIVxYan8DGdA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785483695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6nsL31XBzBfd/4sCAzsmCgticaDAmAUtBspcLMS8bRk=;
	b=yLP+eLbAeceWm5VAE3nzRXngBWOZFIirbmb1mhNYvfqFUUosGtF1Oeq+bw7PusSb2c5i84
	73D+JPrNyL0kC9IKxl7XvybzL0hxsI1nTejhkpFwyHze5Dmi9rN3neht4XwjLgq2jzqAED
	5Lk2qIuWsuVZ1R98i6jy4smP4XeGQT4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=G5gbPKvJ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2DC4F1FE2D;
	Fri, 31 Jul 2026 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785483691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nsL31XBzBfd/4sCAzsmCgticaDAmAUtBspcLMS8bRk=;
	b=G5gbPKvJyL47DbGv+AIFPx3aP4l3rnvzfHKpWhkjE78JeBEs+sX7KZnfsVASvJdRnnORYH
	lYlw9QihxZA411QsGJfho0lLzPCxbCFWgCJr5oOoODF9pEBMmxvUuMu1lTGnU6wQt/mB5l
	JU43Yeqtp2+t6wkCYJKQT43Q+m90rqE=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 09:40:15 +0200
Subject: [PATCH 3/4] alfred: close the listening socket on daemon setup
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-client-v1-3-83d8c7a26421@narfation.org>
References: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
In-Reply-To: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=sven@narfation.org;
 h=from:subject:message-id; bh=kJphcQt2kJQK96f1+kf6NNTo0aD+05XzppeLK2rq1zs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5gXGrpssFz3tSqcf7SPWDozqXr5324TP2+8U0JkgKu
 lytrVXqKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExk7jtGhsvK8jrdMtfP7j3W
 bc35TjvG6pXiqta8XTby/k2Pd+VJf2L4Hz+73J0zyNxwi7NXiVdLZk23+KMc8VnftIN+7tOKYf7
 MBwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MITSGNG3GRH7O73LC6ESQOTQ5MHMTL24
X-Message-ID-Hash: MITSGNG3GRH7O73LC6ESQOTQ5MHMTL24
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MITSGNG3GRH7O73LC6ESQOTQ5MHMTL24/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

unix_sock_open_daemon() created the listening unix socket but returned -1
without closing it again when bind(), listen() or the epoll_ctl()
registration failed, leaking the descriptor.

Fixes: 23359bbf72aa ("alfred: initial commit")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index e24c788..d4261ba 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -51,12 +51,12 @@ int unix_sock_open_daemon(struct globals *globals)
 	if (bind(globals->unix_sock, (struct sockaddr *)&addr,
 		 sizeof(addr)) < 0) {
 		perror("can't bind unix socket");
-		return -1;
+		goto err;
 	}
 
 	if (listen(globals->unix_sock, 10) < 0) {
 		perror("can't listen on unix socket");
-		return -1;
+		goto err;
 	}
 
 	ev.events = EPOLLIN;
@@ -66,10 +66,15 @@ int unix_sock_open_daemon(struct globals *globals)
 	if (epoll_ctl(globals->epollfd, EPOLL_CTL_ADD, globals->unix_sock,
 		      &ev) == -1) {
 		perror("Failed to add epoll for check_timer");
-		return -1;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	close(globals->unix_sock);
+	globals->unix_sock = -1;
+	return -1;
 }
 
 int unix_sock_open_client(struct globals *globals)

-- 
2.47.3

