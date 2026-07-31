Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DCAC55167
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:44:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5F74283443
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 08:44:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785480298;
 b=lrw02Ajkx7+UzVXC4bfA7IBBmwKdm3Shj8QfIBKjnrleTeqz8RAG7+jhmfR+s0GQFeZTi
 AEp0KLkHoSqmfAh2umQNagXRtsBR6msAuEn3Z4HgrlLJgPUtgtjwBzG1dRazVF+pSZ5XwGO
 xiV67jpP6tNVB/Ga/dyueHGuHS8Aw+A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785480298; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LxfmSITYTCBZh/xpKIdyhgiUdNeCXnU0INnVwBH8uBE=;
 b=vjMGKabB0bWwO1/AyUKGTlgBBWDpnfi7GO/NMkftrWJzx23Fw+ozry9JIr3WJ38YqzGBN
 Vo+h/FFh5yVKw09D3a04t5Let6PTTzWOB6OSIR0t00WvhAAzPtH6R6H7O4aGSbPnaLxXkPa
 uZUwWbnuUDvVf4ofQt/VUuoVaxIHzGQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EC07A82003
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 08:44:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785480279;
	b=sAmvZiNB3pesiP9Z3cYISe3P73BJATBdT0Xa0Jsse5TsNJQm0kX6/tvQdJEfjKrydd3tLg
	IAmPn1X2ZBjAkkh752KHhe64Qa+AR9PGtAQMIeX5/BhsuCgLaz2MRtFVobNz//J5q3sxJ/
	zCBA6ZRI6Tnbll+ut2M3RLxUvLTxegU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785480279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=LxfmSITYTCBZh/xpKIdyhgiUdNeCXnU0INnVwBH8uBE=;
	b=vzvuVssl9qEhFlAI6H0ohhW3lBoZ0TkmTs1EX7jTlOj+ShN68QyWg/p2uDtK1RdP12tdFx
	3sd5c5HgiVDqgZ+yN+IZPhQWYssar/2ce/AOVbBf+JI1NOaQCe7oz/FWO4Vkq6N6HHOqaF
	YHkfPK9aVyHDnP26zm3fVgAI1AG9cbg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XstDPzPR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0C0A41FE2D;
	Fri, 31 Jul 2026 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785480264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LxfmSITYTCBZh/xpKIdyhgiUdNeCXnU0INnVwBH8uBE=;
	b=XstDPzPRyp38EIwthmr2n+P6V382IA1fmcbXscf9QzD30B+pSLW8mzGYT03igMdCDnlEK3
	KYF/lnGY8N+Qe5pIkIxOffXuemGwVGXhArDdVhQcrlwBY3UtwdrkHu9hkfqw/pMQGy9Paw
	J83UDSdbjvfgWMeS1nlh5OZN8Oms+bY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/3] alfred: leaks: random fixes
Date: Fri, 31 Jul 2026 08:44:18 +0200
Message-Id: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJEbGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2ND3aTS9LTMitRi3ZzUxOxiXUsLC0MLkzRLizQLAyWgpoKiVLA0UE9
 0LIRfXJqUlZpcAjJFqbYWAKn7UStyAAAA
X-Change-ID: 20260731-bugfixes-leaks-988184f98f80
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=sven@narfation.org;
 h=from:subject:message-id; bh=J0DOF1/bZx8OSgm3GpGqhbIre51GiK0aOG8/nU7sb7E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5Lq6maq+vaSh+/rs+Xa91fpF5HpO4TE73lVk9l63v8
 AtYWlZ0lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbitIHhr7yTLROfIfuqysk8
 wtMePbB5w3j2dV/rOR5Z1dvPb7Me/sXIsNUr93HO9XOu9qdmt3Lt2vHzSfXxaFneR5ruAkGqL0V
 beQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BRYW4TYYXYMMIVHQIEQTB2EZU3H5DXI2
X-Message-ID-Hash: BRYW4TYYXYMMIVHQIEQTB2EZU3H5DXI2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BRYW4TYYXYMMIVHQIEQTB2EZU3H5DXI2/>
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
Sven Eckelmann (3):
      alfred: don't leak event listener when epoll registration fails
      alfred: dlose the client socket on unix_sock_req_data errors
      alfred: Close the periodic timer fd on setup errors

 server.c    | 9 +++++++--
 unix_sock.c | 8 ++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260731-bugfixes-leaks-988184f98f80

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

