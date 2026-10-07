Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8695CA5FF1
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 10:30:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E399D84270
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 12:30:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791369048;
 b=XoYOwhJyTvQCzY3xwf7XdbRSLmEs8eEiNoGXDzjbvEFmY7JkK8XmUOSGlczPTBLFR9Yvy
 xKpoYxqegaMMurmHsCPC7TKmCMEC3qUllfT7CzUplofg1laHewdO3o2JDAhHxRQysn6+Gw3
 0UZOkJWwY250LwsPb5DOYenLFiynM/w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791369048; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lRDjt2Jtv8Pq8JWcPnV0tHFn4HDdy3B24DuGrlU6oUs=;
 b=ddsb0g3BFw6xWTK+1dAOZSSDn4FoexTINdF4C1s7SwlTGnNxBgpLrwjxwxw/2bJltPC6M
 v9QwaLXqQ7T5Iq+58iD+/cX2vjLBzXAElX5Cb7tOnW1hXybPtYCHWGn8EDtI18uQuW9DO5D
 vOXqElv4A5moHndUPW0xkZr0/5TTuvs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 369DC811C7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 12:30:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791369039;
	b=wZcJbNAO5QbgiaovmHvAYDiab+aL3Wig8pq5jrnD01w6zhyms+f+Wo6ZCoNYW6qHYowUN2
	K0lTXP76ELmluUmiEBed0kxxTEG+v92x2VErg9HQP13p1nh91jFRLzscEGxa5ZRiTlA7xI
	G1Y2FmpLPXO8bLjW2/ykY+RKjlTHY34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791369039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=lRDjt2Jtv8Pq8JWcPnV0tHFn4HDdy3B24DuGrlU6oUs=;
	b=JIFRKzpsvqZTZ9qgSq1Q9hna49yPnokPSPduyVdGK/abcU+7yuQFwIa9ks0we5Uhoa3LEA
	q4GItxj2IU7C+Ap+ly2G26CI3QEPAOVyFES5FDt6IBtku3VYJAOskJskfoP6VjqRFszE+h
	OsEK5Oq2JTZscbCX6zAl1CdjnWlmtec=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=i0ZYgL6u;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1DE4120131;
	Wed, 07 Oct 2026 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791369028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lRDjt2Jtv8Pq8JWcPnV0tHFn4HDdy3B24DuGrlU6oUs=;
	b=i0ZYgL6u/69l3hnaXfWKow1EJkAuWfe7Qtbo37QkWCWNZjB+2uHOrN1gXV6r+hdFXz2bIS
	ofiwetLwpjsvelCoHy6/4UfC+u1JFj5jpDGi1JYAJqPGcgGx5MAJqhJh9qsqoxLsnKQT8H
	XczTCe34w6LjwaI15u2yIKTWOIprO9U=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/4] batman-adv: tt: shashiko 20260930 follow ups
Date: Wed, 07 Oct 2026 12:29:44 +0200
Message-Id: <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgfxmoC/yWMQQrCMBAAv1L27EJSaAS/Ih42zdash1Sy21Ao/
 btRjzMwc4ByFVa4DQdUbqKylg7+MsCcqTwZJXWG0Y3BOxfQDKmtknArmTRzQm5cDK8hxmkJIXk
 /Qa/flRfZf+c7RDJKDR5/r1t88WzfLZznBwISfdqDAAAA
X-Change-ID: 20261006-tt-avoid-unhashed-event-76bb5f66d115
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=sven@narfation.org;
 h=from:subject:message-id; bh=5/RV7icLVfeHSpecNpZnVeQiotny9LgZW6AV1LzYtGw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH5FU4dgY9jWtR8QrlfPs4Mj1820knJ3cWu1nMcp/fc
 az1ub66o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjARxVeMDNNXv5uyPfciz9Vp
 z7dHWU7WmhPC8cFpQbVI09eiug9WsrcYGbYd+uNpmZV3WPD93r2yojeXfT7lvFnMN7yWbY9PKIu
 4NTsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5SO5QZ5GGKD7PO6RE5PHGPEKTRPEMNDC
X-Message-ID-Hash: 5SO5QZ5GGKD7PO6RE5PHGPEKTRPEMNDC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5SO5QZ5GGKD7PO6RE5PHGPEKTRPEMNDC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were various reports in the Sashiko report from

* https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%2540simonwunderlich.de
* https://sashiko.dev/#/patchset/20260930094558.3723766-1-sw@simonwunderlich.de

Some of them are about the rather bad locking behavior in TT and addressed
here. While looking at this, it was also noticed that the TT event handling
seems to be broken since the introduction of dynamic flag changes.

I have more changes about the TT code but first wanted to post the changes
for review.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (4):
      batman-adv: tt: don't queue local events for unhashed entries
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: avoid list_lock for unchanged local clients
      batman-adv: tt: drop ADD+DEL events of never announced clients

 net/batman-adv/translation-table.c | 374 +++++++++++++++++++++++--------------
 1 file changed, 231 insertions(+), 143 deletions(-)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261006-tt-avoid-unhashed-event-76bb5f66d115

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

