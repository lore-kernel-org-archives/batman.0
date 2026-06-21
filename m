Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F4ECD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:40:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4ED1284A93
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:40:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052813;
 b=aXRAS3kcicsdbL6zXXtRCUCdypARqfBXrTLstm5lvo+H3GpU+wsU7I21ZROgbfQABCkgj
 3YAudyuiiWgnrzVpxXONhfWS4kDTnxFZUc0jSOaqGJ5N/ZBP42Z98gQgTG3zI+qihGpbyGw
 SfKqYL5QYefNWby4EYIIXrxAN1DUwpI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052813; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=340Abl12+r9OJga5dVUkHWz3ucF8i+2dEglWDV9vkJs=;
 b=AhZ3xufI1qyFViv5jq99S/CVbXanJcVM9aGjY+FOJ8+6k68imB55IxYmg0kVHVAJtCELB
 L56SIi3P5sVLP1RM0OMtJxMGzIDvQhDb3YbU8KSH3ZLajx1CC9i0myeJefh/L77w1mGLR6z
 1qR6bxdEkbhyegKvtp22bLvJTSuC0F0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 36AF484234
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051945;
	b=04hQc9WUILmyYXiVrZD8U5sJ70P8xHoRlnj2o5PjczpcRyqcs3Ky6mVi4TbsAxtHxxQBOA
	IAy7kEqre/TnrUAK/LDj5emwIFl9cYWBlMuba/2RkUDjSrKhEUQrJFdaJPXecHCAlIkYUh
	4xNJZclwKDnLpRp907onSW3OZTyBxKs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=340Abl12+r9OJga5dVUkHWz3ucF8i+2dEglWDV9vkJs=;
	b=YUOhpVAkaGo5XT9AFWBvl7TYOp9xH9fpwME3kqL05kdfTwKCqso1AZZKTaiqCxe31Exm5V
	vwA2vr7t9AN7PjUDuswrku/xAfxVsxJt67cDs0+zk1dGIJ6lADncjTjNd+5nJX1tXfV2Dn
	0hCT+hxfqyCzHVZn/wEk84rCyyqFUUQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OcJIun6E;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E9A1320131;
	Sun, 21 Jun 2026 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=340Abl12+r9OJga5dVUkHWz3ucF8i+2dEglWDV9vkJs=;
	b=OcJIun6EdDznWfI3y81COBY4NRedn76ufzmjpwFlX9Rx0Gq+GeF/zmd1AQMRMJmHiANOYD
	L/evGxEFFOnCr61WPPexIJ5vtjFtDlpSkvJIIQkVNbX0C8gnwV7o8/0YALXGb4myh9umZn
	UmKENRMXzOnTMBQz8a9yv9G3iqbcqMs=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:11 +0200
Subject: [PATCH 21/28] batctl: rtnl: report correct error on kernel
 communication problem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-21-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=sven@narfation.org;
 h=from:subject:message-id; bh=j4TIoLwllnGBGMV0cgGbW96XoN3/824WxXRwBsYBuH4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9gZt1T39j5v+fWxOfBYQmW1bfbhvabPPXuqD26Ur
 Pnn4BbTUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZgIy3+G/zmsTu/a9szefcG6
 M2pDzIzKbsedJ3j+SYTrSryr1DRPnsXwP/lv00/5ZpWQ1v1fLvybcdj+R4eKe9mTXQd1Ve9Zb4y
 bxwsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PQFXSNP55RJSX5XVA5DGI7KYXUKEBKI4
X-Message-ID-Hash: PQFXSNP55RJSX5XVA5DGI7KYXUKEBKI4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PQFXSNP55RJSX5XVA5DGI7KYXUKEBKI4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When nl_send_auto_complete() fails, an explicit error must be set or
otherwise query_rtnl_link() will return 0 (no error).

Fixes: 60e519bfeaa3 ("batctl: Use rtnl to query list of softif devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index dc6bf75..ae1c5e2 100644
--- a/functions.c
+++ b/functions.c
@@ -493,8 +493,10 @@ int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg)
 	}
 
 	ret = nl_send_auto_complete(sock, msg);
-	if (ret < 0)
+	if (ret < 0) {
+		err = -EIO;
 		goto err_free_msg;
+	}
 
 	nl_recvmsgs(sock, cb);
 

-- 
2.47.3

