Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23127C43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 19:18:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A736784790
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 21:18:08 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783451888;
 b=ZmVHJOattgnd6aSS5Vjd4yYF2jVeKHW9ajS/0jaHbx+liWupIhkLpa79nepf8QScx98aO
 m+NUN06YDwt94YuZHN2FGjNk0plZJAMy7/3Ox2M7i7n53xApN120ET1lT2NyukKgPob1jPX
 coizlA2J/MI5YO/JZV3ZM3nIDED+YLY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783451888; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HjO9tQOG64JrYUZ4KEf0JipjM9WyhJMXyhPyVp4Mnb0=;
 b=cSJLi12YXbzS21V3KB7SnBR9SyeTYDnzi+yLCQUFCCuBnwdTW/9JfHgDmtlcRi4dvzgM6
 3bh1g4UJ6J06tzev3uBv6xdmBqrnOCml0d9qUlz3s3d5YU/nQUbCs+tM68bDhsBbBzQkE1R
 IyaXPn8RRxOEaBpi6KacyAEXO6TUbrg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F0972810D5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 21:17:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783451836;
	b=JVSvB2jgUutTQ98ZqNt8naKWtaX+de4DQTqvwVtTSLudaaMEQp4JtdEOUZS+xwx86/6Ks8
	PKBrnm9pD3RaqGCQD1fCfs3Iitj3vq1l0YwsLqzRCnCIgFybthvf5QCMAKsTu+z0cIlwni
	A0UBnzk9H4KjyjeNlwrAFnrcBQ/K0Fw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783451836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HjO9tQOG64JrYUZ4KEf0JipjM9WyhJMXyhPyVp4Mnb0=;
	b=zSAP25NkxC1qkOewE48Ffo2h6tknbMJ3d7sUYt6BQUk/xJ44/j0wY/3jOs1QREtPaVZ+NS
	pj2CDY+QyyMafbpwjc7GuYlpMYdCxDtl/Ce2ko7eI5C8UFmTRcNsOr7Nu7abfh6FHu5mq9
	T5WjZJngQvlXJI1el5L2eevp3DNaMTo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tnr73k3X;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 98794204D8;
	Tue, 07 Jul 2026 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783451830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjO9tQOG64JrYUZ4KEf0JipjM9WyhJMXyhPyVp4Mnb0=;
	b=tnr73k3X70352Emwu4blruf/Eykq39Ym7F9n8AwzoYDMysfMWPDkNMH2tEjrg05vvMeN/q
	lNxW6daPp6CDnTHA0IKwQOg4JggbAeHZQZPcIpNDZxaYQ1oqEjdarDQ93l1zjZBzuPSZXo
	lJI7IbXH6i/GjU6As3Cs2Yr19GyAySM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 21:17:00 +0200
Subject: [PATCH 1/5] batctl: tpmeter: don't use negative errno as exit
 status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-tpmeter-v1-1-78d96fb7b36c@narfation.org>
References: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
In-Reply-To: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=sven@narfation.org;
 h=from:subject:message-id; bh=g5TRM+VWSRWX/uXcydJHyqB3vybVLFYQnZdNrjGSTWo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+Aevf922++tBgZ9Psx41K06abH+ppthHaWRTmkPpre
 oYig8i5jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEWJoZGY6f1NOeddH4jGF1
 GavoWT9JdsbDgZVLem9/n75f9a596iFGhisnVOa03TkdHzDRkd/EzG7PncmL0oo3lh4s71Ke8Nb
 yPA8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UTIR7C2FOS5VL7XHKUBFXFUGUPX642QH
X-Message-ID-Hash: UTIR7C2FOS5VL7XHKUBFXFUGUPX642QH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UTIR7C2FOS5VL7XHKUBFXFUGUPX642QH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The netlink error codes from tp_meter_start() and tp_recv_result() are
returned unmodified as command result, which main() passes to exit(). A
failure like -EOPNOTSUPP therefore turns into the meaningless exit status
instead of EXIT_FAILURE.

Report EXIT_FAILURE after printing the error.

Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 throughputmeter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/throughputmeter.c b/throughputmeter.c
index 98a9490..10f4f24 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -383,6 +383,7 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	ret = tp_meter_start(state, dst_mac, time, &cookie);
 	if (ret < 0) {
 		printf("Failed to send tp_meter request to kernel: %d\n", ret);
+		ret = EXIT_FAILURE;
 		goto out;
 	}
 
@@ -390,6 +391,7 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	ret = tp_recv_result(listen_sock, &result);
 	if (ret < 0) {
 		printf("Failed to recv tp_meter result from kernel: %d\n", ret);
+		ret = EXIT_FAILURE;
 		goto out;
 	}
 

-- 
2.47.3

