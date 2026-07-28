Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA472C531F9
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 16:44:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F208D809E2
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 18:44:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785257066;
 b=BL4v+9XW+TO550K53/KcFvJ1BEw4fKe+k73SAW1r3S1qQLGayANPE4v4NtuGb5KSJBYYK
 YGzFISWn41xIIN3DZy5SntHKQi7NIrpeMvFi3xNtGQBMalb1oFKJS8sTCjdSa5Ix/V3c5Qk
 81JzQLWAPleEytWZgEHhWT8LvDus/5g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785257066; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3wVu6/xZIPaF1Pn3lKJcWeWqHyUyMffg/upNMOi150o=;
 b=pdKl8th5Dg4yk0f95HydsQD+V+W9zDSQwljUl3Cc6uf5dHe11UvIaxd3k/UtsbTlup53x
 gzLAfznsNvwX8JsRURvxzIHDbgYA9csNoRKSxfhNSrp/m1b33G4T/ZTUvlQMo4pZSansQW6
 4XIe75x+C22yDQA5QmLWwF8ByCUvkPs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DC390846FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:02:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254551;
	b=O9uhvdV30WIaLjKJRVuNe9jO7/hfrVanF0XBihyLDRxw2OO/CVGtFPNFVGhg2dmvkPI06s
	Zwth1TxRcP8kuIQJpWJFxQD85PENoL2zbPmn65tss/dyhDIYsGoM1ajBb3MYaMvjX7LwkK
	ueL/dkPldhkC5luKU4qDixckWbWEAKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3wVu6/xZIPaF1Pn3lKJcWeWqHyUyMffg/upNMOi150o=;
	b=Fr5MSXQtA8QoMGxtyIBru9ZqeUaESfdRZLMPUsvKu+koOhmD0NQujktgTVT6oVZMsnOOxi
	Z4KgeQjUW8JMRfPJzpdiQRs9fENRd0Kp8R/jytzbDNtyzRCk7Urw0LavGbnLF3OvXGs81O
	AZTh4goJ+BxqLv7DC8h4FehGHBq1UXg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PCEWRNgk;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 85F9E200D8;
	Tue, 28 Jul 2026 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wVu6/xZIPaF1Pn3lKJcWeWqHyUyMffg/upNMOi150o=;
	b=PCEWRNgk0xwcQKb/sCkzARpvh7/Ams55AKBWdSF9GrLvzpjS3/8AtqGL/Sa9lLnEyik14U
	p66vjdiYTIeB8LKxKHMUe+wBSO7GPpARvOV25O+yIkh1PtBodGT6pDDVqmKROMpCYoZTC+
	qZOGoOB3uiWEw+EyRmoae1kgDsYojbQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:32 +0200
Subject: [PATCH 3/8] alfred: vis: return query_rtnl_link error on failed
 send
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-3-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=sven@narfation.org;
 h=from:subject:message-id; bh=LV9prZ4oul70uYuqFM0Kg5+EDOz2XJMpCKRJsbPpBEs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2I2HVVmMJxywzFlpuuL2MA5jombEiZXfQvuW3tie
 oxOs9WbjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEYlkZGfY6PV3keWRCyRf+
 HNUI+71/curXxZ9q6vpZs/3Z4zw7mV1AFdfZnYvvp2rpSpaav50s9s/v/r/yhOLjKgyPFUzPTU5
 hBgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 65HIXCUVWL3WEZBYVSAYY6YPSFKO4HDM
X-Message-ID-Hash: 65HIXCUVWL3WEZBYVSAYY6YPSFKO4HDM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/65HIXCUVWL3WEZBYVSAYY6YPSFKO4HDM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When nl_send_auto_complete() failed, query_rtnl_link() jumped to the
cleanup path without setting err. The function then returned 0 and the
caller assumed a successful interface query even though no request was ever
sent to the kernel.

Handle this as EIO error because nl_send_auto_complete uses an internal
error code which cannot be translated easily in errno codes.

Fixes: a34f044de561 ("alfred: vis: Use rtnl to query list of hardifs of meshif")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 97c6093..d529583 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -316,8 +316,10 @@ static int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg)
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

