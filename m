Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFA8C54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 16:02:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EE402843B1
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 18:02:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785254522;
 b=aGDtvjWjldUM+46HIBl95UxaPSlbFRE58l7aVX2cOZUam6gERURPKbB7oeaV259nRFrym
 Ulhspzj2VrDeMnFCR+DfK1bQ9Pf3dbAmfQXhwj7YkT06r9snkq3ltwgK18eD6iSc5cDtrdd
 HY8zqDlujMoQpbT8zOowtSac7tXqbtI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785254522; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Qp/Egnzq020f9FZ+1fBO/mHKkDfqyX7mw/9zOdqaPAg=;
 b=B6D5ZQLOGcx7GV1djOEaQzOU/BYv0jhoEQaYf1dpY12AB1cQv7zkfSYCS/oDM6B+5vMA7
 TVpmG04Ffn6XKH5CywwJ3iePXV7twSMq/8uU4tNNXE/RDH8P4uK6aQSNKaQfRYApIMywKL+
 1RUe3egDSHEs/K0hz5ceZyF5+heK8+M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8CE1481060
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:01:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254512;
	b=YKX25JjlIzNOE/fXaVMKg2tel72yGrbjzxFNoQ1ElWMkoJAj5p4nPoSCVlGWnjt2+uJYmo
	IsemWYgJlxSG8kBjrHomluPhok085jnCBFjIlrXRZx3/7jL0OS0qd9Evn1JFTIFfRY5Ulw
	nsNN8j8Z5FrA9lOIkM7PH0f/vYhTdpM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Qp/Egnzq020f9FZ+1fBO/mHKkDfqyX7mw/9zOdqaPAg=;
	b=Pe0A7jIsVx+T36Dd/uD2zZ13pIc84rz5u7OUAQTyxcbw6sNasp+xWIcRA370CsYd6eKo3h
	coub79ttylHkhH1hCndzMQ9nMvkPXGdopzSP9Gj4CcKRZP2egYuqPWhHUx6EzjHtwmrWL8
	SThMDDKCHUFpbWlBc0to5N47CH7S6Vg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vL035sDM;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 748BD200D8;
	Tue, 28 Jul 2026 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qp/Egnzq020f9FZ+1fBO/mHKkDfqyX7mw/9zOdqaPAg=;
	b=vL035sDMtqsnfh1tZBusM2Jc9Bca1zvSDScFWErTLdwTIqrTJC1pcngtGH3qJ5KXNAvNIN
	lobuAzG6ZSLk1NvOTkzSzezR+Fpaw2TDYf1CdoEbX+QecNPCgl62JnExSyAkEGyJJFb9qj
	p7uB6LBO+oenoMFvM8KN5h3NG6Y+8tw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/8] alfred: vis: random fixes
Date: Tue, 28 Jul 2026 18:01:29 +0200
Message-Id: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnSaGoC/yWMQQ5AQAxFryJdm6RmYXAVsTB0qAUyRSTi7orly
 /vvXyAUmQSq5IJIBwsvs0KWJtCN7TyQ4V4ZLNocnS2M34fAJ4nRrUG0waHLyzaUoMka6ZNa1M3
 PsvuJuu39gPt+AI6bbnpwAAAA
X-Change-ID: 20260728-bugfixes-vis-002f70769af9
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZE7EuCE32CRaYT9zBtjrS06+agrGI0tz1G7N0qHX9/o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2IkH0U7fw1S2DO/95TknZD5Nptmf7n1fSJLVurkP
 GPlCuFHHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJBKozMqzj3nVtg2lVgVw2
 25KdxvO2m84LyPwT8yNAPSKJbYbeHWuGf1pucwJ7RP741L/+Zpit/Obll017CxYqvD6+kfXF/sA
 l4uwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HL66TXDW5HZU373UGDCQES5OQ43VAEQZ
X-Message-ID-Hash: HL66TXDW5HZU373UGDCQES5OQ43VAEQZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HL66TXDW5HZU373UGDCQES5OQ43VAEQZ/>
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

This time, we will only handle the vis changes. 

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (8):
      alfred: vis: reject too long unix socket paths
      alfred: vis: keep interface names always in heap
      alfred: vis: return query_rtnl_link error on failed send
      alfred: vis: handle short reads on the unix socket
      alfred: vis: report failures while reading the answer
      alfred: vis: don't drop the rest of the answer for a bogus dataset
      alfred: vis: fix jsondoc output for nodes without vis entries
      alfred: vis: skip originators with unresolvable hard interface

 vis/vis.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 vis/vis.h |   2 +-
 2 files changed, 86 insertions(+), 22 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260728-bugfixes-vis-002f70769af9

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

