Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11D7CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:24:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5808881124
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:24:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782051874;
 b=iVJiOrWJXaVTgSsqKN5Emo8TpxABqJyXBo/PTOWTv6o75PlPqkd3Das9q4ANmmpPAHa2D
 BV6OXv67szIwSf6q6VBd2c/YpPX969+NRYgluZ+wIqwpYIHxqxC+zfIFBCU6WRHoZVab84P
 pKe7RlELClg+Yxfcw1NW7pE0B9fMiys=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782051874; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+tPdKEwRoATc8A0gZU4WjvgolMInM9s+SCP6dmdpaLc=;
 b=ld40kDLMIZjHn3Csoi6eb9tICEzGqqa3g0JR9V1EuKTrzzxQg0WPacnmfg3pU/cMCnXbd
 iOQpTYtfhi3IFRbyBvhjdI8ys0xkMclN5iF8fHj7sF/D1HLOrCcdJO8i+oD03oKNKAeEEIb
 jsraGJexLpQPqkD2BsIlR2CKZQAtyns=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C92BD80C85
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051859;
	b=fDNH8sRGCe5fluQsuFiDCsc/p9RFmHyTydeybsnEG7dfXHngpo/vZuxSfLutB2VUZQnrUP
	G/XLPigf7MhU2r4DdkUgDcOleqCELgK3vUP+mWBaDYVYqlh7+j8M9Wi1OrJri66Nrpkq2W
	yqTS+7cV+Z5eAMFyy1J7+KTbjD2OTv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+tPdKEwRoATc8A0gZU4WjvgolMInM9s+SCP6dmdpaLc=;
	b=RbTcdt8IJ84/3HR0NzSIZ1XNARvARl3g7J05ewV9mVBKpRYIbs9iUUE2JPcKYSEKGHN2ju
	0VTh48fgzWC2T9Tn/e8i4I/FP9d1K/y+/mlV5CLFrodf2/TO/Ut+JVqOpGHvmHH7L3qdsf
	d7jzBMWWeWGSZ3TQAJJfKBvO6uxBIEM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ak3Z9xYR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1764820560;
	Sun, 21 Jun 2026 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tPdKEwRoATc8A0gZU4WjvgolMInM9s+SCP6dmdpaLc=;
	b=ak3Z9xYRQcnNCOGCtVVDBu0z2vkCf+n51f4+DI8EsSg3pEHKbdZHae1bThSL2r7zBPUhPf
	x6BjiI3hOi6N6DXo9F+BiPbORtz0ebHJptMtZYiK1DO0XIoeRgvYOGJbIde3il/ol1W//G
	aTru3hsBRjtnXHCCmwaQ7ifmyudX4Gw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:53 +0200
Subject: [PATCH 03/28] batctl: free header lines after error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-3-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=sven@narfation.org;
 h=from:subject:message-id; bh=P6RQ57NgaZ8ZlOs4DXvX0P0VA+q0A6Z3KgQr7cqB5ms=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1gk7zgLHIhr5z9dcqemLPrpwp2/8r9/NGOetLroy
 d7q+4fndZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmcj2XkeHkvYANsk9mtUxi
 t+4+d33PNdvXj4xO6HWbMXeVsPnw/n7OyPDosFyokMzeR8/zN9tMOuHKwHIrd4fJlJUa8f7irwJ
 vhfEAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KTOU34R6VOLDU7J7U3TJVONKP3DCGE4Q
X-Message-ID-Hash: KTOU34R6VOLDU7J7U3TJVONKP3DCGE4Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KTOU34R6VOLDU7J7U3TJVONKP3DCGE4Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If the common netlink helper or the routing algorithm code never printed
the header, nothing would clean up the remaining_headers. Explicitly free
it up to avoid a minor memory leak.

Fixes: 5401c71adfad ("batctl: Use debugfs fallback when netlink not supported")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c      | 4 ++++
 routing_algo.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index 9d3d3c6..1121956 100644
--- a/netlink.c
+++ b/netlink.c
@@ -589,6 +589,10 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 
 	} while (!last_err && read_opt & (CONT_READ | CLR_CONT_READ));
 
+	/* free a header that was prepared but never printed (e.g. on error) */
+	free(opts.remaining_header);
+	opts.remaining_header = NULL;
+
 	bat_hosts_free();
 
 	return last_err;
diff --git a/routing_algo.c b/routing_algo.c
index c3f4580..1c2c2b4 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -108,8 +108,12 @@ static int print_routing_algos(struct state *state)
 
 	nl_recvmsgs(state->sock, cb);
 
-	if (!last_err)
+	if (!last_err) {
 		netlink_print_remaining_header(&opts);
+	} else {
+		free(opts.remaining_header);
+		opts.remaining_header = NULL;
+	}
 
 	return last_err;
 }

-- 
2.47.3

