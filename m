Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E30CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:42:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3F0B280151
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:42:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052946;
 b=HYWW8GRhVOmG0TKwel7mdAeM1vQ0e4YnmN3ASqtYFZot9t0vMSupTYaa1UCpwmeyaxKHo
 aLHhSmcQE9Hj8xrWcb7+oTQTeR5k9GUy6mGy/g+ISZnIGFywck7XoeF836DsUGtwYjqvybU
 bkkFIagHny6TUUHFUVBiGTsrgNb4+yQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052946; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TDve1FjeEaxM3TQCGCdin0lJqmUKAL+JebDMyAeKFTM=;
 b=T0Xny0ANpR1VqyUOzqGmqc9B+c6XBvxiYIY3mQhyagH1DqslVkrW6b6VmuJliylSy6dZb
 XaxCwPHLgtKdM9yCBq52wa4hsN7UBYHUlES5dKCLLhSCtXEvNtEWsVMMEFX6adGvAQ0gOmX
 Qye1Dsa96IxROoJ5e7L3znK+4rkApBU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E671E8427A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051958;
	b=WktX/eVB/jd0xCF7yrWhyIoa6omaS2ZRTJ564cDqRLjvonGoYr/JphZRN2BZTqeTK/Xr38
	zvIzM7gGJRAgFZmSV2eZLhfz48q+rXlgtz8WuXHNhD1MG7kybRCPmBK8xDMECpnlxJiGkt
	SmjYujZL3Wxeg+oYa8YNXEKHFn5Ddnc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TDve1FjeEaxM3TQCGCdin0lJqmUKAL+JebDMyAeKFTM=;
	b=igFGtvDx0e3ZHGuSXjyhXobB9eLdAMSYpbWYQND4KMJ9yUqWCB6Ip5eaIAGJA0HWMX1fX8
	6tJnH9eWQO/8A2+bQk+GaZIu763cYt/4sK0M+33Am2aeoV31tbqucKuRDzWQSzexVwNmiz
	NSwnzJp0LHN3Z49/HxXfB5vyqYHY6h4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0hyVKBhR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 958BA20131;
	Sun, 21 Jun 2026 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDve1FjeEaxM3TQCGCdin0lJqmUKAL+JebDMyAeKFTM=;
	b=0hyVKBhRJInD654gHaBeD5mXW/MAkWNYgcqOrpuB4cE7I9UMeTz9fSAI8EcKUUYjMvKljj
	c2wCXDYkNGDYRGRAvTowEyPqWW5rukK4gLYbmdlEzifaC7Yu+TuiNAJ/rgI8r9ExhViXam
	ub/YMmjSJC8NIMrSOWxHNvyrbXN4B3U=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:14 +0200
Subject: [PATCH 24/28] batctl: bisect_iv: avoid access of uninitialized
 loop magic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-24-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=sven@narfation.org;
 h=from:subject:message-id; bh=IWLBRw2QaiFx2r9yeYp4pwB419LrXZJ/sTAeEqUP3ys=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9i3makpP/KQlt7JqbNy36e3evveMHsxcn3c1Wq1e
 yUXy2bPjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEeMoY/ge89dFw5VKYx/K5
 z1/h0FHuZwFTLzhnLOO9xDDdQiXm8huGvwKT5ycELylYVFB0xPbAX68lbOzZ/1dekAt+c9S4ys6
 ohRUA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PP5K33VGC7BIYA3K4YZBE5LKNQUPA4VE
X-Message-ID-Hash: PP5K33VGC7BIYA3K4YZBE5LKNQUPA4VE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PP5K33VGC7BIYA3K4YZBE5LKNQUPA4VE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The loop magic string is initialized with snprintf - which can be a partial
initialization. But the rest of the access assumes that all of the loop
magic is initialized because it is then only access with memcmp and memcpy.

Initialize everything to 0 at the beginning of the function to avoid
uninitialized bytes.

Fixes: ece05e1c4c1f ("[batctl] bisect (a tool to analyze logfiles) added")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index 5da5bf1..f1ba94e 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -658,7 +658,7 @@ static int print_rt_path_at_seqno(struct bat_node *src_node, struct bat_node *ds
 				  struct bat_node *next_hop, long long seqno,
 				  long long seqno_rand, int read_opt)
 {
-	char curr_loop_magic[LOOP_MAGIC_LEN];
+	char curr_loop_magic[LOOP_MAGIC_LEN] = {};
 	struct bat_node *next_hop_tmp;
 	struct orig_event *orig_event;
 	struct rt_hist *rt_hist;
@@ -720,7 +720,7 @@ static int find_rt_table_change(struct bat_node *src_node, struct bat_node *dst_
 				struct bat_node *curr_node, long long seqno_min,
 				long long seqno_max, long long seqno_rand, int read_opt)
 {
-	char curr_loop_magic[LOOP_MAGIC_LEN];
+	char curr_loop_magic[LOOP_MAGIC_LEN] = {};
 	long long seqno_min_tmp = seqno_min;
 	struct orig_event *orig_event;
 	struct rt_hist *rt_hist_tmp;

-- 
2.47.3

