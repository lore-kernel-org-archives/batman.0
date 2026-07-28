Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE90C54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:33:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 90EC8840BB
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:33:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245606;
 b=GO60jytIu2bRtOsMbWgA6OmK/IOlouX8OjIFwjLP2H6jQsNkZDjU+fNAFcsoSFpRLvj25
 PVyEkKG9jWJduAyZJO/EiA86xInu9wxNx+MrYUGMV/K2A0wkb2bHT2VfqTPFyWN/uF1rrca
 cgVXVmysxKUdMFjwzKmHM1jVHMTnrKc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245606; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bzcQbXidWtRN/azAP2UDe2+bax1WcjdWsLXChK3cp58=;
 b=b+9KBrdPol6UwDPChhozZbmxhNxLHIP+FQfYqX37p5QsnEzUdNeUGEgiaIfUv8D4yNC1d
 dsVvbFkqAxamatCmVmWMuxsjqIBJTyXbXGICovLdBBbInlPe2EnRBkZVHa6v668pvKzEnqU
 em2340uFQ7b1MwCqbPNklzrM9PjxIHc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2EB6580288
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245603;
	b=GCwleBF/cz8+EsL5fCp7wEEx9ZKwa+H1HTc6B/xNSVyap2mAS4hIdZ8NeDCthexhrMTJ1R
	6pVuaTyO1iQopGcjUNLR7SEvSyFGQ9gO9AN3tc8Sm+Fqt7ZiMNysv6lwWonZSxsfIFb3/Z
	UH/aajNKg0glVnA201C7rRowGF/FAro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=bzcQbXidWtRN/azAP2UDe2+bax1WcjdWsLXChK3cp58=;
	b=VRZKlzg/gQF0hjCm86aEKh6E9P+hGZB5lgZRZjbud+/i1CUFo/8o9e/z9dy5+uyYod8H0+
	PStCQUA1Ju0zkfDbRkJiBi5QGBmPwO6Zy9DH5qUOyu7s+1h1fN4u/sNl0ogFw32ncAkL0G
	YnNy0hMeFETR1nVbJTtHZW7VgHnuVGg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EgT6Z2Dq;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 40294203F6;
	Tue, 28 Jul 2026 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bzcQbXidWtRN/azAP2UDe2+bax1WcjdWsLXChK3cp58=;
	b=EgT6Z2DqbI8kLh6o1xwHOCLqLGkiGhdHRnZnkF6HU0+U5q+OugfJK7dLsGNODSLRUALgsv
	t50cyZ3UtpnPwofvMzzpogCLBR8i8dMIPJRMItaXNHnwuiT4MFtnpO4P8lnnJOTJHsWTns
	n0I+dKylmB5++JaW9UkNj2thV8YY3RA=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/7] alfred: gpsd: random fixes
Date: Tue, 28 Jul 2026 15:32:09 +0200
Message-Id: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmvaGoC/yXMwQ5AMBCE4VeRPWtCSYlXEQdq1DogXUQi3l1x/
 DL55yKBZwhV0UUeBwsvc0AaR2THdnZQ3AeTTrRJCl2qbncDnxDlVulVm5kcNktRDIZCs3p8a0j
 q5rfs3QS7vSd03w/b30iKcQAAAA==
X-Change-ID: 20260728-bugfixes-gpsd-a364ec31e7f6
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=sven@narfation.org;
 h=from:subject:message-id; bh=BNhRUJxD5FDiEnUEvvc4u8PPNZiwWe0oUyJmwlmosOQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61u2PalS/iAea2oSpKzu7ur55u7u468FXlx/dt20/
 syPm+8vd5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmwrmTkeGc/rSt5TtvaD96
 Me1Jn1b+1GDHjM8vD6eXT1qZ3cUntYmFkeH+wuRwg94narW221Lko5ab6dR53Vg4d+UXncrpKur
 MBUwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JIBAVM4B7TRMWZYPBKUNJ246LH6HCCXL
X-Message-ID-Hash: JIBAVM4B7TRMWZYPBKUNJ246LH6HCCXL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JIBAVM4B7TRMWZYPBKUNJ246LH6HCCXL/>
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

This time, we will only handle the gpsd changes. 

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (7):
      alfred: gpsd: show unix-path option in the usage output
      alfred: gpsd: reject too long unix socket paths
      alfred: gpsd: fix counter underflow on leading carriage return
      alfred: gpsd: handle short reads on the unix socket
      alfred: gpsd: report failures while reading the answer
      alfred: gpsd: don't drop the rest of the answer for a bogus dataset
      alfred: gpsd: handle empty or not 0-terminated TPV

 gpsd/alfred-gpsd.c | 104 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 21 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260728-bugfixes-gpsd-a364ec31e7f6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

