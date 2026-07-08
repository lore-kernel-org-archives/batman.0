Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2C2C43458
	for <batman-adv@archiver.kernel.org>; Wed,  8 Jul 2026 20:00:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 29F1084672
	for <batman-adv@archiver.kernel.org>; Wed, 08 Jul 2026 22:00:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783540857;
 b=iYIpIKBjn+9kuawj2IXwLTgsHvH5R1REF7Sl0cXLM5wAbZgY8K2HYsoVtOIwp5KGIgYYk
 1WJigLABlmaldNz0BtU/0BzCKjYjDIualz070TH+6NBRIlEdPoqIoMGUFKtgpY+GGXzwIY3
 iRt/XLXxuzduzdorfo+i2U5yyL7xis0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783540857; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=39yYQMxuVqXfR2JeNGgKX22qp53gt1mct/ymev7+bj8=;
 b=u/rpdoXiEM/zIeE6ccX++4rAxPKpnDfzTOD5Av4UexHNwh+5bGQT5pe7cA1dgAWH/5/tj
 xgT2PMoeEo9WMnjgsFtLJPE19hSdnpBw37VxxR2g1upfswNLNI1+fkWVGdBoeQc8/avi03j
 7llPUKhkuBNatYHtmg7WPfwHPEeUJeI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7D59081461
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 08 Jul 2026 22:00:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783540826;
	b=lrSjTn5BTsJqU1zehouxPHB0Mr2E47wJXIwhv1LhMS2HsbqullMIRFTjJO1NQM1pnWV49j
	z32P4M2KNNlZ+l3JZryrH9uzWwrKDqKInmNJrfGrzQ6a/g3WH8qdc/XfGgF7+XCfSRMrGa
	QMqmw8kcRfHH79ACEWxT+jVmMN/gZJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783540826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=39yYQMxuVqXfR2JeNGgKX22qp53gt1mct/ymev7+bj8=;
	b=EuC/g6S8jhEMbyXsDSOQh4SXGteASDxD8Xfs2NMLlMyz4I0WTtKF6RFmIvqNgsS+XmIsQt
	RthMb1TxCXHoRzXrqtXgH9S4nNseqBatPumiLVKO432m1QkyQmEsOXqrZpTqFHNyJZKE94
	wnPKIC0TAMbbyB2BEDDaODiliTATF9g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TfitS5bP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E88212058C;
	Wed, 08 Jul 2026 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783540826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39yYQMxuVqXfR2JeNGgKX22qp53gt1mct/ymev7+bj8=;
	b=TfitS5bPG04CDAq9j1qGyXWcYXAGm37nuV1gEUNrw+QQAvjQ6h/aiF8wxFZ1aOc2Jx462O
	dTwmFewYuPl2r9IrXs/yT4mBR+Bb2xx3j1kHSniURufCxC5VukX69U+p/xNtgmAV5bdE3r
	0k+FXjoMDeNe+0UD7t+ZJGgc05wW9Q8=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jul 2026 22:00:09 +0200
Subject: [PATCH 03/12] batctl: netlink: don't format NULL extra_info in
 info_callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bugfixes-netlink-v1-3-8ce03e37f17b@narfation.org>
References: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
In-Reply-To: <20260708-bugfixes-netlink-v1-0-8ce03e37f17b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=sven@narfation.org;
 h=from:subject:message-id; bh=S7zlInkuwxiO/IT2rdKs3/xRlKvzYjZOmfZZ0zGg3F0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl+azzYvy6LmlNs8yhYzOlwXFTxmwo+x7m9nY+TWd4Gh
 wpl/FnaUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiI+FOGf/bxnWtOetbqvpWZ
 Xxrln53LcLhS879cUPCVjskewhenGTL8U85err/Yq9uqxMbTqWyCxvolCd0Cm9LbZueURk7J6oh
 gAQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PSNDQLECVOYX4WX2POUPWOCDBYEC7NIM
X-Message-ID-Hash: PSNDQLECVOYX4WX2POUPWOCDBYEC7NIM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PSNDQLECVOYX4WX2POUPWOCDBYEC7NIM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When asprintf() or strdup() fail to create the extra_info string,
info_callback() continues with extra_info set to NULL and passes it as
%s argument to the following asprintf(). Passing NULL to %s is
undefined behavior.

Fall back to an empty string when extra_info could not be allocated.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index cb65655..dd0275e 100644
--- a/netlink.c
+++ b/netlink.c
@@ -440,7 +440,8 @@ static int info_callback(struct nl_msg *msg, void *arg)
 			       mesh_name,
 			       mesh_mac[0], mesh_mac[1], mesh_mac[2],
 			       mesh_mac[3], mesh_mac[4], mesh_mac[5],
-			       algo_name, extra_info, extra_header);
+			       algo_name, extra_info ? extra_info : "",
+			       extra_header);
 		if (ret < 0)
 			opts->remaining_header = NULL;
 

-- 
2.47.3

