Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2FDCD37AC
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 20:37:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 74FFD85B7D
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 22:37:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778704631;
 b=lNtRM3zs07BoUn9vX1BVDcWXoekTDtnGobRJH057av4OeUUzPlKL11fvXnB38kOILLsE/
 oYlNyALzfigyE4xCMH+nqR4u24EU4Hd73mAtPGGJXmDFAtunj5PFLF0vF9Y2oWdLUCpmYAi
 RKj4iuAqpjwea07b7czDbpILM7DiocA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778704631; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wlkc3075+dsZ2TAk+kkk+Q5tfIMJjHbKWtcyvrnZDjM=;
 b=Z/L0f11TGcWCPG02itii3T8Jl793kvXxVVWsI5/ZHDJ6+buxoBw3vFBQncEW0+/HztH/Y
 4LPjfuH+DkriRZ4KN0X0WrXEcHiTnqVmL0FQ50HAlO74sEYgvdvMgvYe1BCSbm/+/4W+gjT
 ixPUPLMprw0DR7PSl0faXKt8VqhxOw4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5B5198474C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 22:36:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778704607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=wlkc3075+dsZ2TAk+kkk+Q5tfIMJjHbKWtcyvrnZDjM=;
	b=BFMw0SQYDLsT9Y44NvBR0Ht3nxZjN5CEm/3RORcE97bvSl4Hyhl8w3Cfo2BkqNXnJM7dp6
	5sPH8XwA8LFjawMJ5ycxkbZ80tDWQJtWFodwIgQ4uzG5ewji7S7EfPt00glZ1moQ9/4+KB
	fWfwl57T3yrs3M7Hgj5jZxXNYZcR9ME=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="w7/XJ15p";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778704607;
	b=HMRVViObE2/wrQ/eP6/xP87e7/D8ducVuTNRMJdRKue/aP5BGub7UjXPONHKINjretAA1H
	x4OtRRPp19+E2kUdRQ9AlKQliuQacvTBihkEC8upZrMoHud6HWlykucbqUMAEj9OalI7T3
	TqSd7o4iLDGSRSqOZVfzL7eTiaV9qsQ=
Received: by dvalin.narfation.org (Postfix) id A038D1FE54;
	Wed, 13 May 2026 20:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778704596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wlkc3075+dsZ2TAk+kkk+Q5tfIMJjHbKWtcyvrnZDjM=;
	b=w7/XJ15ppD74rcgZB9AIgDxoc2000LINbWXBYO2Za9//EEIA1ms8Ei38mF+ESLKrzAyG0R
	2keSHuE9zER1zb6CALxE/gqRxi1xW0MJWQAyaXJPQ7tesTtrdJJAPQEE5xGeKj5ki3saGQ
	mVJd32chRALOK1fjC3pi9R5BwbStZeM=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/2] batman-adv: BLA fixes for sashiko reports
Date: Wed, 13 May 2026 22:36:24 +0200
Message-Id: <20260513-bla-cancel-work-v2-0-9c17d82d7e2d@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjgBGoC/3WOyQ7CIBRFf6V5azFAh1hX/ofpguHRog0YQNQ0/
 XdpXbu8N+cOC0QMFiOcqwUCZhutd0XwQwVqEm5EYnXRwCnvaMsokbMgSjiFM3n5cCcnrTpTK64
 ka6CkHgGNfe+NV5AiCZ1h+PnxKW+o0la3kZONyYfPPp3Zzv9dyYwwUndt09O66Vs0FyeCEam8P
 fowwrCu6xevWwT6zAAAAA==
X-Change-ID: 20260510-bla-cancel-work-8dc6f3c2cb14
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=sven@narfation.org;
 h=from:subject:message-id; bh=riyAIDdSPnDO1Y2SWvzUEK4wVEXux2XvoID4LfjQEPU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFksDy5+OeAfcX1f+q7QKR9Pt3/8X3S94frFY8xKH5/dZ
 7Hls+Ny6ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZLo9w1+BzWusLso0ccS6
 ssm2BBxKEXkbs5Yz/4bD7xWfX/yJ9m9h+J91n4E5RtPyhrJFxKX495sjjlZ83xJnYe75MUN+67G
 GPAYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PMIMILIYPCCOE56G42DG7TRDARMUIBOB
X-Message-ID-Hash: PMIMILIYPCCOE56G42DG7TRDARMUIBOB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PMIMILIYPCCOE56G42DG7TRDARMUIBOB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were new sashiko reports for bridge-loop-avoidance

* https://sashiko.dev/#/patchset/20260508154314.12817-1-sw@simonwunderlich.de?part=7
* https://sashiko.dev/#/patchset/20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org?part=1
* https://sashiko.dev/#/patchset/20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org?part=1

These can be easily tackled. But they must be done at the same time because
they are modifying similar places.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- add patch from (to avoid conflicts)
  https://patch.msgid.link/20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org
- modify bla.num_requests patch to use lock over both request_sent and
  num_requests
- Link to v1: https://patch.msgid.link/20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org

---
Sven Eckelmann (2):
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: bla: avoid double decrement of bla.num_requests

 net/batman-adv/bridge_loop_avoidance.c | 95 +++++++++++++++++++++++-----------
 net/batman-adv/mesh-interface.c        |  1 +
 net/batman-adv/types.h                 |  7 ++-
 3 files changed, 70 insertions(+), 33 deletions(-)
---
base-commit: 57c6af492c1948145db835bb3ea2980472558298
change-id: 20260510-bla-cancel-work-8dc6f3c2cb14

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

