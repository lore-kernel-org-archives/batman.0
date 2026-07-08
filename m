Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F85C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:04:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 543DC854E6
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:04:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541074;
 b=Paz0B+glMEbOclF1hNVmJCUPMkzwoHJyfEcXYKb2W9PqekCBFtX/7i3RGNZCK2QIxfn6L
 eC8qVKvpuIVU6aD6MhkzfAV8oV7zu74NL1b9BS+1EHGKQ0ipJT4CzCSexNJe/gXk3mV0QBM
 2Ic0rsWdMbSaH16lNlcZFfyhDNPBcQk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541074; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CBZlxtIV1zTGwIc8/o/rVGbsQEvk/wWRL+lTaksrO7Y=;
 b=NOA6/XugCjduGr4JEU4N9AeBMlsXw2bwWzZqqa2qHBWtgcwj3tfssrOsuAwjiAKe4u4cM
 R5auI/c/MNU5adBAVTAWWM3TdW+qLIFCgnfQ8MJ7hBjtMCsWDv5/icBHaNm71eoNWC89S1j
 sIlyztS9Mkdi57nJaLkoMioDiEI0ghQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DFF9283E5F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540830;
	b=Gf+CxtM+AFHZxbXsQlT3NxWJ3F3qlOvOADFF08Tb6iP2LhgkW42rHVFDMvITzBM/GtbJv3
	hwlIhN6idHYwgvybCSNEvOTtzZswji8NeJWy0acY5vSlCGir2mOoxrFn7zG+6R2cEW9aZf
	aoxsgR6nz1iy6boaquXE49x3/RbmRmg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=CBZlxtIV1zTGwIc8/o/rVGbsQEvk/wWRL+lTaksrO7Y=;
	b=CQmx/9PeczxwOp0yLQ0vRdnWGbxQjAYOf9w6h9WzugFBqFxyTz5bG2/ELNbBEFAJExyJR2
	UQus2LOlTjfvbzcIcJySz19nO4ZllnpKkOK/0KAal9VpPqfJequyB72yozAyHejQ8Im/3K
	+XQOLXxsQJk8GW96/im3rVpM0igQMRE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bBec75jd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A491B20019;
	Wed, 08 Jul 2026 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CBZlxtIV1zTGwIc8/o/rVGbsQEvk/wWRL+lTaksrO7Y=;
	b=bBec75jd8zOI5gE1HJB1mdhioJCUtqL452s2TZnlrWG1J68gIPI4ugW+S22YLMPoWSYY+D
	04QOIUwSTtHaotTXII9ygOymDgWxgpoqykH1foqq4xBDupuAeHAZ+JsyKqvIZ8UXZugelE
	chPyVojcJXIzxxQaQV4TPvQGW4LdhdY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 00/12] batctl: netlink bugfixes
Date: Wed, 08 Jul 2026 22:00:06 +0200
Message-Id: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEasTmoC/yXMyw5AMBCF4VeRWWtS4hJeRSxopwxS0imRiHdXL
 L/k/OcCRkfIUEcXODyIabUBSRyBGjs7oCAdDKlMC1nKTPT7YOhEFhb9QnYW2pi80JlJVFlByDa
 H3yBUTfub935C5d8fuO8HrnXFpnQAAAA=
X-Change-ID: 20260704-bugfixes-netlink-dff56d4f1c79
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=sven@narfation.org;
 h=from:subject:message-id; bh=HdSpKn/MtAyZGtFEzaCgb+8gW3Tzw5gArehMeWnIALw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+a9wtX+jJSnndiWm0YonX2VYn9fPWL2v5r5WlxgXCD
 HsdNyR1lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbyjpOR4cyK6kuHGR98eyG8
 eV9NSLrYnmdJMvmKLfdW3r5UdbuR4zkjQ0f6/xMXH2lu+v6CwZ3z5Cfh1Xc5vHYyPM5ve1H/72d
 INDsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KXI72XWQ2L6SVAZNWD4RRWLAZEZZCYLM
X-Message-ID-Hash: KXI72XWQ2L6SVAZNWD4RRWLAZEZZCYLM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KXI72XWQ2L6SVAZNWD4RRWLAZEZZCYLM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I have now splitted the bugfixes for batctl in topic branches to make it a
little bit easier to review. Similar to the "random bugfixes 2026-06-21"
patchset, they are just various (mostly minor) problems which should be
tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (12):
      batctl: handle netlink callback object on error
      batctl: netlink: abort netlink_print_common when message allocation fails
      batctl: netlink: don't format NULL extra_info in info_callback
      batctl: netlink: report dump errors signalled in the NLMSG_DONE message
      batctl: netlink: detect receive errors in netlink_print_common
      batctl: netlink: report kernel errors when writing settings
      batctl: netlink: report send errors in netlink_simple_request
      batctl: netlink: detect receive errors in query_rtnl_link
      batctl: netlink: detect receive errors in netlink_simple_request
      batctl: netlink: detect receive errors in query_rtnl_link_single
      batctl: netlink: report error on query_rtnl_link send failure
      batctl: netlink: use kernel-style error codes for nl_recvmsgs

 functions.c       | 67 ++++++++++++++++++++++++++++++++++++++++++-------------
 netlink.c         | 27 ++++++++++++++++------
 routing_algo.c    |  1 +
 sys.c             | 10 +++++++--
 throughputmeter.c | 10 ++++++++-
 5 files changed, 90 insertions(+), 25 deletions(-)
---
base-commit: eb9597d4ca6db17c579f5ae9443c51b013e2fe65
change-id: 20260704-bugfixes-netlink-dff56d4f1c79

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

