Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75F5C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:06:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8ADC685379
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:06:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541167;
 b=Ni5ph/zZUJu4t/cWUeeGSzQFOgJ4LyiIwM8Ny15Ou06gFhe1lcdST7ePTk0aUKSenTa0u
 mlqPFKYg+BENqfcvyx/KpgfX61nkSabLUTYI6RNlL+3h+gUA6eiUd4W+OZcpJrqULPfYvc8
 jkXPt7v3/imGOO/E7tyjEqBOvg24YFU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541167; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4r8OREAOsSPJyxRgIWkpdVwPmLeztFcGnnythYcOBPI=;
 b=Tzx7Y5vTRplqn6jFJdYbqaeiWUDrvfLzZQPfE58sqa0TXzkkKMWSPQVVdSAmx+WaTSEzF
 jn6j+O8sLjGceptf860XnqhyQ7mOyR/snFimi+YoA/6gpBodjxcGyv6K2p9Lsg98zf71ZYY
 wKSf4pjCbhBdddEUvHuOw7Cqom77HgU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1CF0284694
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540858;
	b=GKBpjZRjAYZi+BOX4Fw2Pcc170MAeJNUna+ibzCLcOBuzgOHgioKHPxrCQy1VOS59TpXOp
	H6KpJnARLrP8/bzM0tDWk+ETSoP9zT9+Od+zPNz5WkgO3DpR6LRA3joT90KGCsE7i2T2yf
	X6F7BmWW8elAXfGexNqpoQ0PfoHSXNk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4r8OREAOsSPJyxRgIWkpdVwPmLeztFcGnnythYcOBPI=;
	b=x2Xk/78TVeIycH87RHpvAWaQGDnehqVdHPnUUZRmUpYKS40XtQjV9lEaxiqJi2YnN+H1Ss
	TzDeXrdjmT18Cvu3oCgfcex+zOe0kKIyNoGO2nNPfoiFCCPpRowbcnk48f665I0mrBN7u2
	X0sJyTtrlcG7JUr0YM8PLG9BCP4Ak+g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=HfX7mfIH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BD9F81FD9C;
	Wed, 08 Jul 2026 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r8OREAOsSPJyxRgIWkpdVwPmLeztFcGnnythYcOBPI=;
	b=HfX7mfIHmO1nEmZL1IohBw4fPmzO1JNhHLt+X9nc1JadZmfQmg6goOE8zRX7nkGExgz6kY
	cQfGdhSuXHJHuFObDoXkdNlVd7G41asB8Jnr/+T/2TqYuTPGImqTqzJ9QpHcrPfF+OVxC7
	rZRllDzAUGuS2FTFUZ+XT1Zyvv5S8PY=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:13 +0200
Subject: [PATCH 07/12] batctl: netlink: report send errors in
 netlink_simple_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-7-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=sven@narfation.org;
 h=from:subject:message-id; bh=WOZJO3X3eMQVRo7M9vsamHSYzhIH7M1mfMNYJJqQtgg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azwCNT3P8thyx2zTv7ph0etHXf+UpgStVvp0+PZrk
 S+zeY4zd5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm0neZ4TdrVFPZws6FHiGl
 17P4Dm/3uW8irFoby3CiaX33LkvWDScY/tkE34nOKdRmfJAvKftIyXnCH7kHJ2Ve7jStcjm9YP2
 O9fwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HCFVSRBFRMS2TKBSUTQKP6SOVMOMEBDA
X-Message-ID-Hash: HCFVSRBFRMS2TKBSUTQKP6SOVMOMEBDA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HCFVSRBFRMS2TKBSUTQKP6SOVMOMEBDA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netlink_simple_request() initializes err to 0 and only lets
ack_errno_handler() update it while receiving. When nl_send_auto_complete()
fails, the function jumps to the cleanup path with err still set to 0 and
reports success even though the request never reached the kernel. Callers
like the interface create/destroy handling then exit without any error
indication.

Set err to -EIO on the send error path to let the caller handle it as
actual error.

Fixes: dd2bbe182780 ("batctl: Add command to create/destroy batman-adv interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index 00dbd3d..a3f6639 100644
--- a/functions.c
+++ b/functions.c
@@ -552,8 +552,10 @@ int netlink_simple_request(struct nl_msg *msg)
 	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_wait_handler, NULL);
 
 	ret = nl_send_auto_complete(sock, msg);
-	if (ret < 0)
+	if (ret < 0) {
+		err = -EIO;
 		goto err_free_cb;
+	}
 
 	// ack_errno_handler sets err on errors
 	err = 0;

-- 
2.47.3

