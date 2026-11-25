Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC2606A31E
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lFlDcWWy
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 749F0816A7
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 20:42:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795635740;
 b=q2dnkJwfoOx1424jQHq10q/oTBYUwL1bAgE6QxBadd91Awv15qWp5LvdCzrWdIhs3ED3U
 ESxFMjKCw6MLPBpa8xF9faYR8qm6qSi2uuuhNAT0ef4cLeDC4WKKjk6oUtumsX7k18zqIG1
 xOr179CIRmjcx/xMKWfb2sdjymo3t70=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795635740; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4agfYlXWtkvbO3uO1SqJ0Vl11KAagmrikAIEroI9Mm4=;
 b=hvdZUYT1fP4J3VZZNlAV/3lUVOiX8VJktpa3qE9g+dIm/iaJvN/9NPEmo8/F7wkz/ptou
 WynSxnhJMYrtdiPbNe599c04fEciXuVROmAtVDd1ezCWIqyqtYVHUJuY6dmOF32LYDhVnNh
 t7HS2w5sT2nNmBGj9uvEZhJ1SkP4DgY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DAA7480479
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Nov 2026 20:42:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795635733;
	b=RKWg6GozeLG/fVtcVHiIpGbFP5iWWO/gbSzvQK4NK5bxnjIHXahPp3Zmo9JGr7loo73tY5
	jtgIai/5nCo0rbm3G58FyRsU6ld5LLnCtSM0U0CW77VAp0zwhj45MucGFY7Hu/wTUgejl8
	FByuEjqjKBPanBCzjWHSz/L8/b/vaSo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795635733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=4agfYlXWtkvbO3uO1SqJ0Vl11KAagmrikAIEroI9Mm4=;
	b=rLC5L0HXblf+EW/rM1UYIBzCgcpMS/WU9Gi85bWVPAdXCXXc3HUvKNMYqNP/VTJfkLB+4S
	DNqHhEgKRqooDO2PO9eeLjXg9Hhpcqsi5qDTWlRRowUM/G5FR+/p4+so68e5eNYhqbT44E
	ldfOCxSvtu7ohZeh+sx3YgjexLaNQsA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lFlDcWWy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 28C2D205DD;
	Wed, 25 Nov 2026 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795635721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4agfYlXWtkvbO3uO1SqJ0Vl11KAagmrikAIEroI9Mm4=;
	b=lFlDcWWyPUb8CSMFpNOto9kGKHAHwn+gfOzf/3TNoLwUxACD4u8MAoU77pBpBFvTf77rQ3
	SXDDaGVEkObfHvPhwadbjKfnlBb6WTtlR9sqKtxjQ0dPYqGJ/kdbJ10yK5MOJcN3ZjgbuI
	gUFzGa6KGs7ETO4wNImz5RITGFf6CQY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/5] batman-adv: sashiko kernel-doc fixes
Date: Wed, 25 Nov 2026 20:41:55 +0100
Message-Id: <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAM6B2sC/4WOTQqDMBCFryKz7hRnCCZ01XsUFzFGTQVTkhhax
 Ls32gN0+T7e3wbRBmcj3KoNgs0uOr8UwZcKzKSX0aLriwauuSFigVHHyc0e594bPCgSYeGsBDW
 qIyulgZJ+BTu499n8gE4n3Wdofzyu3dOadNQezsnF5MPnvJDp9P9dy4Q1smTFSgmWYrgvOgw6l
 fdXH0Zo933/AhIn/6TcAAAA
X-Change-ID: 20261124-sashiko-kdoc-2026-11-24-284168b1e77c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=sven@narfation.org;
 h=from:subject:message-id; bh=JKx2txGlWr/iSQFtllEv2B1+vX62V8cnGuyB75J+QpY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNnsVizrzh6xLlwSIeq+yGKWDsMyzStNO+c23zPJb5ktH
 HVPPkm9o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRV4WMDO8n5zUxWnlN+xwj
 obZwZd5Kn6KM4hnGl/69XKmbyC0Wp8jIsKdFwelxwbTmQ41LBBrsDr7n/llyW8DqkcbVSUs+vNj
 0jxUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AS3ONORJEO6BHD4SLTYLO3PYFGIZC4Z5
X-Message-ID-Hash: AS3ONORJEO6BHD4SLTYLO3PYFGIZC4Z5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AS3ONORJEO6BHD4SLTYLO3PYFGIZC4Z5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Sashiko report for
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
contained a couple of complains about the kernel-doc. Let us just fix it
directly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- drop unrelated change in "batman-adv: tt: clarify uncounted state of new
  local entries"
- fix also batadv_tt_local_remove_entry() for "tt: document immediate removal of unannounced local entries"
- Link to v1: https://patch.msgid.link/20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org

---
Sven Eckelmann (5):
      batman-adv: tt: sync requirements of unhash helpers for local entries
      batman-adv: tt: clarify uncounted state of new local entries
      batman-adv: tt: mention purge of pending clients as concurrent removal
      batman-adv: tt: document immediate removal of unannounced local entries
      batman-adv: unify kernel-doc about refcount of returned objects

 net/batman-adv/originator.c        | 20 +++++++-------------
 net/batman-adv/routing.c           |  5 ++---
 net/batman-adv/translation-table.c | 28 ++++++++++++++++++----------
 3 files changed, 27 insertions(+), 26 deletions(-)
---
base-commit: b76921870912bf2543c1f4c7310fbf18da610acf
change-id: 20261124-sashiko-kdoc-2026-11-24-284168b1e77c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

