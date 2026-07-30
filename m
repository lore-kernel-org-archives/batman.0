Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1CC5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:32:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1523D83ABC
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:32:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785439944;
 b=AqEejdDYfVEWVdyXTsUDpHHsEq6OvlcgbLAI5G92UTAMYgIh615SpSMBXKiORtq0rqKGU
 G26bq6FeCkE3QXFKONh/VGwvpbYooRgaW4ygw+Wll3cxXz+Pj2yXLR+/TMXshkAoaA7MJ0n
 zpKC8tiP/n4RuLDQAY4ZEHp+4qawzt0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785439944; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5PW1so2uKkYgKY60pw64iyI+WqQzKsQU09xFYaoC5qA=;
 b=O27Qd1Gi3tdAnmUJz1ohfZSCgPkLBW90GHDYJUjS+HXL7cLstY1f0cqnZz74hRYWgLCUy
 /8edGImQ6tz4XiqzZurpEXN/NZtmBfoEK3Qf8VAeuC0sO2Y9pHpS3NsVldHxx7L+Xd25pY1
 31Ux9E+Y0NRWBIHUzmCXr+RoecvBgT0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D1E7A816BA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:32:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439924;
	b=zLcjfiQVD4/M/D1Qne9K3HQt2IVTEDmCb8/oasJUghQ4bxedaHiis4jdSDmpLDRjPQz9U8
	/yTFRt802gAT+ipjoXs5tc9Z3qS/85VeZpJlLKbtlQ/TwkLSlbOnxtEIsnKPxsu7bALqg3
	Kjv7WUHhEnkhjA7KJBR1kdzpFTKYJlw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=5PW1so2uKkYgKY60pw64iyI+WqQzKsQU09xFYaoC5qA=;
	b=Gu89/gJIGCYNmQZOu7SXoy2LeUdGpeXMC4jyyqT0w4mWjeeRlwyCGwG8/6PHlCAMHCzfsi
	S/WTqMyF2azPG0y4luGStTRNmUxOf17TtjdHwG+Qs+VlFD4IvS1luP8nLiy4bfxDHWtL/+
	rFb4i7+qeuxH/Nc5sIW2ahUWKfZmjQ0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=t+K0MfuW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3139B1FD9C;
	Thu, 30 Jul 2026 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5PW1so2uKkYgKY60pw64iyI+WqQzKsQU09xFYaoC5qA=;
	b=t+K0MfuW42kkogcL9mQqcfLe0eHxHyOaKcES6PybEeqH8YwC+EAjxxCf2Cvrut817jpa80
	BEf6T9sQuCdDhPp4zmrDOEesaxZEYEQaxMeo029MHLpkmGFh70wnYi6CpBEJ6in3tbjHbI
	GAH+GYkT9aOK5s9321Xv2elyNPFTBlk=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/6] alfred: argument-parsing: random fixes
Date: Thu, 30 Jul 2026 21:31:54 +0200
Message-Id: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqma2oC/yXMSwqFMAyF4a1IxhZqfIFbEQe2jTUOqjQqgrj32
 6vDD85/bhCKTAJddkOkk4XXkFDkGdh5DJ4Uu2RAjY1uS63M4Se+SNQ2RuHglcVKNwaxLpyDlG2
 R3kGq+uGzHGYhu/9/4Hl+1GCn23QAAAA=
X-Change-ID: 20260730-bugfixes-parsing-c2406b2251dd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=sven@narfation.org;
 h=from:subject:message-id; bh=9rz/quLLaw5B6nLb1fRJEF1hmZGtegBu64tl9O6eNJ0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9Y4Pq/XTu4sFW2Q5d5ylcHDVrRpXlTol4yG47tFj
 7nKV3p2lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTAC4SyvA/+ULroVM7VCcznV6f
 dnKJ8TyPM/cDDk1i5LBa0XTNRPhOFCPDItFH3HaG+i+upazJuBCx/jH7o8NTrp7cwnj8Tc7t9R8
 duAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Q23GQXHMAFMRUBY2IG2RAHCVHL3MSGLC
X-Message-ID-Hash: Q23GQXHMAFMRUBY2IG2RAHCVHL3MSGLC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q23GQXHMAFMRUBY2IG2RAHCVHL3MSGLC/>
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
      alfred: keep interface names always in heap
      alfred: free interface parameters before assigning new
      alfred: check strdup() failures during option parsing
      alfred: reject invalid synchronization periods
      alfred: reject too long unix socket paths
      alfred: validate the IPv4 multicast group argument

 Makefile    |  2 +-
 main.c      | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 unix_sock.c | 10 ++++++++++
 3 files changed, 60 insertions(+), 10 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260730-bugfixes-parsing-c2406b2251dd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

