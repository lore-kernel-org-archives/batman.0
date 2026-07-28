Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C9AC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 18:30:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0E5338402E
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 20:30:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785263401;
 b=Hjr/ClQH9sfBVBsCeQaxzfAefOAQpHYUrlFbmYxqDEVVG2Fd9uQS/2x2Zakt9uDqmPlCn
 u0D1jyuRlphVkbDxsyMM7He+9KZPUYxdWGwp36vOTrevDx35moHShzIutlqHHVOaMcneGio
 Te8gjZ90rhTxSYRfpBHOLZSMw745YQA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785263401; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fBo88AL6OMU9GJLfjyIGl0zlIDV+FdNBmnGx+jkgK6w=;
 b=it+0WMK2IGUHJu9MKJeGPAcz4tLuhNuiasz88CKNFzgB0DiQgfW9MAeyC1jzZQbsBYoKG
 5INZw/VTONu6iov5A0H63qHl1Uek9w0Ti+Oe2uzrs/IHGGHAjhfUS06srx9wn6meCkNqFsl
 6UACuURX1UoNo6eBi+UVkWKYS9Ihbh0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7E98784029
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:03:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254615;
	b=PD5PQYHzB2bvq0MwugoSLXx/dsmIXjU3G8rC/eYcUmSEM5wILJho8jxiEZbPt0lvPC8W3w
	rZbTBplh9kbsBPJxxEfa7bG2HgKfzwaeIdSirb4KztMlCq3TAziRfiaN+WH2imUGLUWUHO
	9RcEJ5vf4IkLv1/u0aMfkG5cb+o9Odc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fBo88AL6OMU9GJLfjyIGl0zlIDV+FdNBmnGx+jkgK6w=;
	b=UYjmpefJqeSyK3rT1kaMdW5K2k2jZh+/CbDQBHXaWawnc1aEe/mlzpfhaZdHt9XmBPDWfZ
	XKrkrROXMQe3HA/2vBBAf4DfG21t9MNqqqt11fdtRen60MRVLR/qOPoUBNFUsCaRrAyrPY
	Nr6mEKHavlZJemw9gOlV/A3G/vGQqD4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xZ91W9UA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2BF0420536;
	Tue, 28 Jul 2026 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBo88AL6OMU9GJLfjyIGl0zlIDV+FdNBmnGx+jkgK6w=;
	b=xZ91W9UAsSUGrPrRHuC5B/rtkNnlIXYARFx8d4qXQDDoIqf7jb5P7k5nHaGTzkr4KLf4p/
	c/1sScBVyPoGY4RjClxRROGJqAJGZ57+VrNWc6uoihgYN1KIKX7c6of4AAjLzMHZcOUGHV
	EP9Gd14H1MCjt99kRnzWaUeAkChF87E=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:36 +0200
Subject: [PATCH 7/8] alfred: vis: fix jsondoc output for nodes without vis
 entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-7-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=sven@narfation.org;
 h=from:subject:message-id; bh=ykpCb44MW8E43W4JZNNhFAeVY83H/xAG6mS3ZpLbMrY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2Jvtx3/t795udHPO3XCIbv6NRZXKQpKHxL4tSE/8
 eiucyoLO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATaaphZNi+iMd48a5w2Umx
 OYm9IsaNv5+KR80x8pZZ735qyTWxgEsM/2ztxZqWTX1w+fsCD+/r2bPuyASVO2wW1FEQtJ2x+dB
 Pd14A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EV47PESJGLKQRECDLAYYBUIYAAPOWZZ5
X-Message-ID-Hash: EV47PESJGLKQRECDLAYYBUIYAAPOWZZ5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EV47PESJGLKQRECDLAYYBUIYAAPOWZZ5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

vis_read_answer() skipped the entries handler when a received vis record
contained no entries. For the jsondoc format, the per-node object is opened
by vis_jsondoc_interfaces() but only closed at the end of
vis_jsondoc_entries().

The entries handler must always be called and all entry handlers must
handled `entries_n == 0`.

Fixes: 38eae4d50e81 ("vis: Add an output format which is json conformant.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index 93f444b..025745d 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1046,10 +1046,6 @@ static int vis_read_answer(struct globals *globals)
 		vis_entries = (struct vis_entry *) &ifaces[vis_data->iface_n];
 
 		ops->interfaces(vis_data->iface_n, ifaces);
-
-		if (vis_data->entries_n == 0)
-			continue;
-
 		ops->entries(vis_data->entries_n, vis_entries,
 			     vis_data->iface_n, ifaces);
 	}

-- 
2.47.3

