Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10268C55172
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:18:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 11D53841D5
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:18:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785838734;
 b=pG79V/b0Eo5+UgTxfPzGE58GsYl1sPHrKoxIKDGy0QnV168AOBuUipGQRK+i/1O1jPSsS
 8U8gV9NYFCLQs1y5+WpK7FRuXN7LP56iq+SSjtgXco/7dSI5snAFWScv13rJT9iDLcQ4mEi
 rf7gIn387oVBidheeypteRa4iv2iJkc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785838734; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZnIFUywWMs6jZmc5T9qATewD1wiF3zlLdtYwW0qdHfc=;
 b=ACrw0Uai3yjAt1Bv61psibL6eMC2GPN3X1C368onlr+AXTu0NoQkjwted4NmxISY/P9Wt
 3jHGXy+L7VcJmsWk7ZUPHAtyLqnHStYv/MPIG0AYjGYrsoHcowBRtUDVWffIxN+oUZagBVz
 BPTTxf2uMHH+L1UAQp70Oc2zMbBNt9g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DB26280335
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:18:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838716;
	b=V6TmsChUuddmiXO0xidVSiRFigmV6NFf+ShnADQ1/aNxn9kIVZKPr5NnPaxGfTbBisSbyj
	aOhNwYIBxTqm52esFuBd4b9LUgfSx8gLT3QRK9u7DeqfG+V0jrq3Bt3Wk1mbe3j9g8PNZN
	+MQq+PL3KRuFwnPARuHrmbhGDQY6AAw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZnIFUywWMs6jZmc5T9qATewD1wiF3zlLdtYwW0qdHfc=;
	b=C8cigFjhxQ1F08Rp1RkvuiThoxJyRwxuPjxWEGZVNPPLqbM1gvusgNPu90AcbQiFUovVGX
	g5l5Dd2CUlAuM3Q4kiIpjeNYrB/RHPMnYwYsT39qzxXlzbzT9lRDS91byxvB35QlZV1b2b
	RI6e+t+SYeYSsCqmT+wKTmRa9reJChU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=E4x93TmV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4B7DE21002;
	Tue, 04 Aug 2026 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785838701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZnIFUywWMs6jZmc5T9qATewD1wiF3zlLdtYwW0qdHfc=;
	b=E4x93TmVFvq2a6tka0UcCUnLDGkBw1NKHXx0YNrOROOtd6XmfPs8rNF4iJW+co0jZEN8Z1
	l/eXAxj69gvpMENuSCb29Dx/ZhscJOZNbcXybH7mZ7FcHSPhvwdlz2zesePdqyWSCGFDhC
	MThz31UP8fR4kpskgo2DrAp2itCSazw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/6] batman-adv: tt: atomic_t sashiko fixes
Date: Tue, 04 Aug 2026 12:18:11 +0200
Message-Id: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGO8cWoC/2WOzQ7CIBCEX6XZsxi6Shs9+R6mB36WFg/UABJNw
 7tL8ehxZr7MzAaRgqMI126DQNlFt/oq8NCBXqSfiTlTNSDHgY8nzlJi1r0pMqslqhGRlDJQ8We
 gFlT6DkomaTJMPz++1IN02nt2cnExreHTNnPf+P/63DPOhjNdSKAwQoibl8HKVP8d1zDDVEr5A
 gdaErO+AAAA
X-Change-ID: 20260730-tt-fixes-fca2b722ebbd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=sven@narfation.org;
 h=from:subject:message-id; bh=RcURNiUtsP9TyIHzmfjok7IjR3wHu5xw0hBFIJJB1OQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmFezJz9cJndQv4dkX/tGn7InXgctWE6EWpU2YHRGz23
 pTr336vo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRu3WMDHOvsLBcnPUsYqZ3
 UuiyhxcXXZ84zWKj+hbr8jKGqHDp9WcZGSYz1x0Xqjk6c/Ul7QcrXbenz7q/qmvz8pCrVYYV7Pq
 Z+xgB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5YA4ZLCFKCWW57YN4VZJYOH6MAW6YXSL
X-Message-ID-Hash: 5YA4ZLCFKCWW57YN4VZJYOH6MAW6YXSL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5YA4ZLCFKCWW57YN4VZJYOH6MAW6YXSL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were a couple of sashiko reports regarding the
batadv-next-pullrequest-20260728 PR. I went through the TT code and tried
to handle them and at the same time already predict what else sashiko might
report as next. I needed to change the batadv_tt_local_remove() hash
interaction as preparation for the related NEW flag (and counter) handling.

And the netdev maintainers rejected this approach (for now). I had to
re-add the atomic_t code parts back in this patchset.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- rebase on main
- add "batman-adv: tt: use atomic flag modifications" and "batman-adv: tt:
  simplify NEW flag transition code" because they are reverted on main
- add patch to extract the roam "add" code in a separate function
- make the "simplify NEW flag transition code" patch independent of atomic_t code
- Link to v1: https://patch.msgid.link/20260730-tt-fixes-v1-0-64e9e525d555@narfation.org

---
Sven Eckelmann (6):
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: use atomic flag modifications
      batman-adv: tt: decrement count for committed client on local_remove
      batman-adv: tt: don't uncount never committed clients on pending purge

 net/batman-adv/translation-table.c | 377 +++++++++++++++++++++++++------------
 net/batman-adv/types.h             |   2 +-
 2 files changed, 253 insertions(+), 126 deletions(-)
---
base-commit: 7c21a379ef7f9887c13d7450a3d5236de62f22ed
change-id: 20260730-tt-fixes-fca2b722ebbd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

