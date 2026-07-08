Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A960C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:07:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1A4B2841E9
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:07:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541253;
 b=WEUAcSdqnHI6Ixwhc+4UTzJXw4icGh4XY6FiW78HgJ2h1gxlZF2riS+1wOuAHXUeyfMpq
 sDcdOw2ALGuQWRCZ4HVNugPQY1mct/Sjnx1Eyjv2QYAodG4b5NOhd4NpnES7yzlDtG+GtfX
 hx5fKc9p1MuZ72XsFWifcUFlGC9XxRU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541253; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Q+X0DG0Xkf5bhwVtXCkXF7oeV5HSTc66ZqdkUQmLQJ4=;
 b=DU5+w22MrxZiFmWX0ZUdN1IG0P5vxmE3rbb/kRVtUpqYde1zykeMgKXpm6gtSKRo9thqF
 La6raAghZ/wZq755i5h67bXr40IhGiUig6TFc6eEMVNn5S1+WHYGOqS5X5yhLeZtXcXqo46
 3JyeM3SyMarF3UV4JXdYLxbUPnFEtgc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D51ED83CF3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:01:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540862;
	b=v3j65FydKw0lqxDfBiBVPj74AwD0RWfLWmbKp21PIA9g/sibIaOAkmk40YQfTXLSMQ0U/U
	zw4yc+/e35asCAaEiz3bpzH5CpSa+suu/XaItm7MWP2cbdYk88ahnKmkKNvEE/gb1mos0w
	KUsU7tEebYPx8U3zsx0F+Y4lidNxtqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Q+X0DG0Xkf5bhwVtXCkXF7oeV5HSTc66ZqdkUQmLQJ4=;
	b=IhH63CDO/h8Zknq3SrtaMxt90rYXuFCQ/XZFXjxc7ei2F7E+HJmjG2FtA7o285TCZQIsDZ
	wbgJIk5Po8VxmDv1fZiny1ThfMOJxtabupVbP/rZSB+00mvbwG8fOC4nvpYLC+uJY1wNjr
	Dzi1t5L4+woZnGCABdYvGvWPLM65Y0o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QOaHzsue;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 93A8720019;
	Wed, 08 Jul 2026 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+X0DG0Xkf5bhwVtXCkXF7oeV5HSTc66ZqdkUQmLQJ4=;
	b=QOaHzsuermlg4bPbeYj4XKLkyf/vKMdmLYr5PiNXurJMnY3xf/kB96PRa9sXomLplEvOUn
	AqKKxjxI/z2eMwrEi3paC8bvaltgA6VKJnAQztQNu9kwL/x1ZYBu8PhoKaG/fK8hmK5X9+
	toP7ULOgoDg2J/INIOFzBNuKTUB18co=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:15 +0200
Subject: [PATCH 09/12] batctl: netlink: detect receive errors in
 netlink_simple_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-9-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=sven@narfation.org;
 h=from:subject:message-id; bh=MwUKBrGBCWCoNlEQ9jSvpt+VgOE7638d+7il9FGI98A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azw7C33aN09e7tuw5YXnl5BNVgxzZk8xPn7jpV2yD
 IeDwMy2jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBETHcz/BW8WKJaX8MUvXmO
 sf714upDtW53/Dr3nxLnXe5+xNY7LIGR4emZqA+iBxe+mvxp4v8TNd4/38hI8hZvc7USV8j+693
 DyQ4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZZCUROLGHAKSNQOX5WOF4SWMLRR46D32
X-Message-ID-Hash: ZZCUROLGHAKSNQOX5WOF4SWMLRR46D32
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZZCUROLGHAKSNQOX5WOF4SWMLRR46D32/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netlink_simple_request() ignores the return value of nl_recvmsgs(). Once
nl_send_auto_complete() succeeds, the local err stays 0 no matter what
happens while receiving the RTM_GETLINK dump, so a failed or truncated dump
is reported as success.

Set err to -EIO on an receive error to let the caller handle it as actual
error.

Fixes: dd2bbe182780 ("batctl: Add command to create/destroy batman-adv interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index f3ad560..36cae49 100644
--- a/functions.c
+++ b/functions.c
@@ -561,7 +561,9 @@ int netlink_simple_request(struct nl_msg *msg)
 
 	// ack_errno_handler sets err on errors
 	err = 0;
-	nl_recvmsgs(sock, cb);
+	ret = nl_recvmsgs(sock, cb);
+	if (ret < 0)
+		err = ret;
 
 err_free_cb:
 	nl_cb_put(cb);

-- 
2.47.3

