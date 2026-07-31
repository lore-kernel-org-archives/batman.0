Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73150C54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 11:45:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 74F058039D
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 13:45:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785498329;
 b=ithtjg/6Lkeiz+C3aonvRBrOghDtNJNO8JujP/HU/mZtBwjfgQFz9X+C5gzCuiQP7fce5
 whDccMfoXGMla9TdjjkCYzDsytOkapbGgTJ+w4aPkWJN88e+AvPQOeREKhH52AwM4PfYZ6x
 j5iZwQVcj3kILfhuFvn5TJAoAGbmOFM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785498329; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DfAy23H3lH3c9oVXGiqYREBDIC2E7e832c8SJhBFydg=;
 b=nTr8n4QC70ae0xyYuiTo2M4uyGuXKS9tibEk3RyAaiDKlgWBNRZ7yFWts4B4bEHxxDTsP
 IgnxnC5Gg25mYmSluDOe3N25vp41HmzGKg2VlE5B9EU8BLmvICYtKZ2tC/LuFiySR4uAAsi
 w1sIB1RwAfJxnSSxCZDHtTI5QGNqoHo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 06B7B80758
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 13:44:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785498310;
	b=sq2kJv5H3ccKQLGfA8sAcEln5mv8Txm2FNWZxdX8fAzYbPZdXDUu34CBdn7XOcxR7+KCnL
	J4sR+1JkCHDf/9IIoA4e0UAUMx1GIbHspJ1XLDb+telDaephotqa49x8WRnnP2b+IrGXQ9
	9Mp0gg3WQAdADJ3QpRxK3xa2iEJcDOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785498310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=DfAy23H3lH3c9oVXGiqYREBDIC2E7e832c8SJhBFydg=;
	b=nsFwrBJM8OgLIHOGMxs3b7RzbPNsv7wrYJ/7OB8jUYgcxaUCcRoMq1YPPiKwfAWGAwF966
	dbETeEw0YbxMe67hmYisIgH3wU8DdlyevQZVvj9RsYUsBC/YPlsrYJE7ZcH+ddvyls2eTF
	+NRRC/3GDvxd2takGMinYdCRQ58+J/Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="T3i/74ql";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 102A020CB8;
	Fri, 31 Jul 2026 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785498295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DfAy23H3lH3c9oVXGiqYREBDIC2E7e832c8SJhBFydg=;
	b=T3i/74qliiV2huHt9+t1AMqVfz3JLv5fYSij8wfuxn+TncRMh5gD+Ab3HA138ki961sw9K
	oL1o4NihGZkDJMzlK71xh3l9GoOeuEtBLm0BZRygOk6fUyCvuWSLCiwE6H0BAkelzRwksg
	QaaE/0BF5hfK7+RjKhgwvUciCyilRJ4=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/6] alfred: interfaces: random fixes
Date: Fri, 31 Jul 2026 13:44:49 +0200
Message-Id: <20260731-bugfixes-interfaces-v1-0-a148ca2f6688@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGKbGoC/yWMQQqDMBBFryKzbiDaquhViotkOtFxESUTRRDv3
 rHd/Qf/vROEEpNAX5yQaGfhJSqUjwJwcnEkwx9lqGzV2PZZGr+NgQ8SwzFTCg51onu1Hdrgal+
 Dmmui30fF9/Bn2fxMmO8UXNcXk+ywVXcAAAA=
X-Change-ID: 20260731-bugfixes-interfaces-ca479c0fa5b5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=sven@narfation.org;
 h=from:subject:message-id; bh=oZJW0BLHXJa26KEyinopn6dwz8XMqlk/lTvcdgmywNs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5XZsycnx2PP0yaXNQWI+FRf/7VXes/9+efsBMg3+i0
 m+vN63iHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJzOBmZJgZzBdw/1bU5dWy
 qlO7738Q2/2geLPCDE6+xatPuAS7GlQyMrz9aSJXqZPixRxmY2zwVWOni6juqqMNUYYVwcYOGq5
 zmAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3LWHXPNYLGYZ444MJBGUEQHZCO2CGILT
X-Message-ID-Hash: 3LWHXPNYLGYZ444MJBGUEQHZCO2CGILT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3LWHXPNYLGYZ444MJBGUEQHZCO2CGILT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the batctl fixes, I have now compiled a list of potential fixes
for alfred. Instead of posting everything at once, I will be posted in
smaller chunks. They are just various (mostly minor) problems which should
be tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (6):
      alfred: fix off-by-one in client interface name length checks
      alfred: update stored interface list on interface change
      alfred: don't drop the mesh interface name on OOM
      alfred: keep the running interfaces when reconfiguration fails
      alfred: Report failure when the client refuses to change interfaces
      alfred: don't check the "none" on network interface change

 client.c    | 31 ++++++++++++++++++++-----------
 netsock.c   | 41 +++++++++++++++++++++++++++--------------
 unix_sock.c | 22 +++++++++++++++++++---
 3 files changed, 66 insertions(+), 28 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260731-bugfixes-interfaces-ca479c0fa5b5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

