Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23FEC55167
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 07:41:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5440481066
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 09:41:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785483673;
 b=X4KguOwu1dD2iUdRvENDka5KBRI7LrMttDjUKcHwNBQCPEq3oTGau5y/MQ+w7m8Ogj99+
 z3rGK39yn3xAwMUP6MBpUQJ96XrGE7PQ2zA1mdCde9V7LGCW/Tjr85Lf46MDjSvYeqZtgTF
 f9SzyrIMnzQV4CpTtUSvJH/5pVu+mhw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785483673; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aI1uS17+fDZbyLelcuLROgqx5ZQEp6cs2l46VVzGANI=;
 b=qgmJN10h+/jStEO5trC5/R1fdINVsZlnZqDoLpLAdzpJo+DI0KKbm9BscltcpcN/FTAY9
 3uZnkRjetOZwtHPQR22fEV2g6h4wfzDo9LeQYil8+TioEtuzwzBbtIDp+I+uZDmfgtm88xL
 rVehaWTl+KKW8f+4pluhK9dWX+tTHMc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 64F1B81066
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 09:40:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785483654;
	b=AfkGCmrFzbky+TJthuv/CoaD6OZ8K6g3nAv/EImgMLRLbu5L/ex9k9QEfMRbrwaKhvgfXA
	hLQ3PPbw1OydAs6ECYkvsedl1nOPD0i6KBgaOeEsRUAmnYj9QjC2LivcaaCij/v8GMzkbD
	UB9oPo49N7Dim10mgPVai2XEITBOC98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785483654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aI1uS17+fDZbyLelcuLROgqx5ZQEp6cs2l46VVzGANI=;
	b=elMSJglgkE3YoKz5uKITKvqadakvxt1gsqyViceurOuIjVR3F9NcnmRRvxf92Recp0NQQI
	NOtdlkpFPNdqMREt7Ctf+4OWMTJI7kTIdj0jmzZaGRPBEX2y3gl4rUHMlbkd3X9B+SArc4
	IeSnVEbYxXUYerKk9gQZTvd/dyMvTnU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hJTiP40q;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C1ACD203F3;
	Fri, 31 Jul 2026 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785483639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aI1uS17+fDZbyLelcuLROgqx5ZQEp6cs2l46VVzGANI=;
	b=hJTiP40qudH9GDHWjg7YV0erV2ncHgp2j+WB5/4hUihKVgqEKphTbrthYT9sBLtmlLPMnf
	lsCrcebsO0fPKhCgTaj7oyOSsGubAL0AkJl7pbTCy5+Ddl40lLYJdM98rpQ3aKXa4KsjpG
	DTPqhsa1Gy8IYJbqS4aLQBIB7hA6eG4=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/4] alfred: client: random fixes
Date: Fri, 31 Jul 2026 09:40:12 +0200
Message-Id: <20260731-bugfixes-client-v1-0-83d8c7a26421@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxRbGoC/yXMUQqDMBCE4avIPjeQKCr2KqUPJhl1paQlG0UQ7
 26qjx/DPzsJIkPoWewUsbLwN2SYR0Fu6sMIxT6bSl02uq2Msss48AZR7sMISWlfw3cGbe0t5eo
 Xce05er1vy2JnuPS/oeM4AfUBpZFzAAAA
X-Change-ID: 20260731-bugfixes-client-0d5ed91e75db
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=sven@narfation.org;
 h=from:subject:message-id; bh=+u/Zo6vSjggB5FnCxq/8aZBOonfFwoc81LBsdvNsNds=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5gbHZKh/OeyisnKu1/oq+mqVAtsTp4NKT/O0/nD2r9
 T5eEDvVUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiIyByGfwYxD4X/nfsW5c/+
 VClTlXfOcvU7OW0/e43llxafbvt64RnD/6ou04+29mm8EWe3Fn+ODV158UT31HNp5mt0NlbusF/
 GygsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PZJJQP56E42BHGYHC7P3FEUDUKOGJAGQ
X-Message-ID-Hash: PZJJQP56E42BHGYHC7P3FEUDUKOGJAGQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PZJJQP56E42BHGYHC7P3FEUDUKOGJAGQ/>
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
Sven Eckelmann (4):
      alfred: fix error code from unix_sock_req_data_reply
      alfred: avoid endless-loop when reading data from stdin fails
      alfred: close the listening socket on daemon setup errors
      alfred: handle short reads when waiting for daemon answer

 alfred.h    |  1 +
 client.c    | 77 +++++++++++++++++++++++++++++++++++++++----------------------
 unix_sock.c | 39 +++++++++++++++++--------------
 util.c      | 25 ++++++++++++++++++++
 4 files changed, 97 insertions(+), 45 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260731-bugfixes-client-0d5ed91e75db

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

