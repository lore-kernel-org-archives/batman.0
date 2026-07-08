Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202ADC43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:09:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1C3685823
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:09:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783541345;
 b=mdH3AKGmWHUHJ0ChaXosNbvOJQWR86zeQ4dtXISCFWtpBX0+QS0ea1kJrIHfrVYoryTdn
 82dzQqgUa6/YOGM5tKfYYDbCk0Fl2+WFRX1mUpM/7y0yO2X2JX30HUCm0mruRRGXPqiyz7y
 uepPgCS+6rnHq3aXAmA3ZKSscFTrWcE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783541345; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nF84nEKPwtQl0J6Ix6DY57HxIsdnNjlZzjOYRZjNaOA=;
 b=dGtM+ecCwQn24SWHppPz8Ew9z7DL12fQS7owKQi+wUgWHKIpNZYmOZceiMh+/pClCMREn
 heg9yYLK3/eCuy7eGwrdGvH6j7Sp4gqgUNa0En4eYv+LvRn9koe0dofCTCG9w1opJrGN85M
 tY+g1e6tCDAuHo46GgTWuNcAWl5M6fg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0708C848AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:01:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540867;
	b=jiBPzizLn+2rbtWBzUyRc2c6zRJLHJdBdP9W5RBgKn8AmDq8VifzLtGqFrx5288PAnb2as
	xMFZ+eUovyD2vxKQ4BJaIL6tCpaaCe2l8/vEirm3TmJTRr1NTa4I1FBEr5UpOLk4ZfN37W
	6nIP7KSVc1gJnqfKti5e2odz1sj0AiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nF84nEKPwtQl0J6Ix6DY57HxIsdnNjlZzjOYRZjNaOA=;
	b=Zq3zodG6tQWlIEMrU9A5CsmvkTybBY+MvdbO8mYNv32aCbKj8E6uNU29GI+cUBuse0mVCA
	Xxvqy5BdARNgPPmKxUvovnmH6zXQR1WraIT3TWaDnWjWlsugrqJ8nUfkLC23t020KzRQzT
	JrpTqTRrdofA0nSvTQpY9kMyfkzaFsg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IKns1qRC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B575F20019;
	Wed, 08 Jul 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nF84nEKPwtQl0J6Ix6DY57HxIsdnNjlZzjOYRZjNaOA=;
	b=IKns1qRCdH6PmAeIzYsYn+rJvYbFVlKF2OusKtCxiHbyvcDpb8AsTM6OscWXyDpnQanw2C
	WQk1iCPEu2qMO/Qc/g9bTLZGEAX1lbkJcRIfnO1giPNj5HFfhBYu0kHcw6IgL4Msa9tTpU
	6V2RhTQmo1P9gYOCj3lBscOpdLo1T+Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:17 +0200
Subject: [PATCH 11/12] batctl: netlink: report error on query_rtnl_link
 send failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-11-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=sven@narfation.org;
 h=from:subject:message-id; bh=MdfjJOU6wXMuGlJ/5adx03q8asasEWS6Q85/sgliTPA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azxdlP5Wfs2fVW90LOLXprJ6vR9/7+ew2Ib/OF1QO
 XnWRoMLHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ3NNj+Kd29CLHpWnFV3/Y
 bL657qhrINt9parrR1/o3nievjJ/ipgQI8N+LmajaR8PhF1+N/HtKsFWs4OMR9+cCjwt91D7i57
 XxmomAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: B2DOEJGT3FGG5L53MGHGY3THDPBENEJG
X-Message-ID-Hash: B2DOEJGT3FGG5L53MGHGY3THDPBENEJG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B2DOEJGT3FGG5L53MGHGY3THDPBENEJG/>
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
index 56bacdf..213ba83 100644
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
 
 	ret = nl_recvmsgs(sock, cb);
 	if (ret < 0)

-- 
2.47.3

