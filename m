Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E044CC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 19:20:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8938784AEF
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 21:20:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783452017;
 b=VUS40I9AZUaT3fq7NvoiwUbXyYN+TSnM5GwQGAV+ifSTceWEMyQYa/INu1/kotskN/BS/
 TjtSh0kfnKmlDGICVUZ3Vqw2l2JlLMcM8tFlaXXEUdmL847JAFx/1/0o39AoaExo9F3WrpH
 UoOSYJj9m68k44ghbNBGLuWmXF0MHiY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783452017; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E4Fe5SNc+c+ACxesM4OAcfypeMZU9Izw24apRVZt2N0=;
 b=FtZe2xr4UMaKQitcgRptHV4m/fyrMJXyRVkO8dIkFoGJvNLgZgKQX9+muMqjAWUy7KTp6
 JOyz2Sq75G/oEBBdi/rPHTrk3J+3cMgw4DDc5V/yrYZOAZ0i+Sv64oZHlJ3QB+397faio5x
 4WBOFVDw2jN0MzlYr/Fgfu7P2v7LvSY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A42DD81DCA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 21:17:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783451855;
	b=WAPq5s9jXZ3ayNa+Q6UvhJlcZqSyJUkbPAFdewXh0GyYDzPTlMLaNZClbWTrkeqxq1DLVK
	u83YsEQGNIkSEgz1IIFxXrWLz6NelNw3tbQD+WKz1fkN8UfsmcCi/TdLP3aHnzfJFI39qO
	F37/f9fQxOgkG0jpNFpbnBUiXKyfkUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783451855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E4Fe5SNc+c+ACxesM4OAcfypeMZU9Izw24apRVZt2N0=;
	b=KAN4DN1ScTLXjAKbVp+8tGPZAHBmL8Kr8MrLXsccLzQZNYxlkVa1diLQa5gsBeuI6gIQs/
	B2w4pOyk98/4tKDa+DCU4uLyYwRPNAH9ynodfkUcQX0vpnlJJFpE1zOyYS+mtanyX6O/Iq
	DKG21ZmFR4Iidfofi++GBD5KplyeIEo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="pschvpI/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 474FA20442;
	Tue, 07 Jul 2026 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783451855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4Fe5SNc+c+ACxesM4OAcfypeMZU9Izw24apRVZt2N0=;
	b=pschvpI/2ika2QQgC7MAVnn9PYzQetEPDL0PyHbo2A07m7t6X3aAFOQgGnXIeMIMupcALn
	VPK1k9huFHUe6U5Qql/RSOFErdC3cn8/daRCb1QCsKyCIgvAt5A4olTdAyyAejuQurI+Lb
	0aY+rEYUo6LYI9u9u6/rL3RTdZMYSCM=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 21:17:03 +0200
Subject: [PATCH 4/5] batctl: tpmeter: report kernel errors via strerror
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-tpmeter-v1-4-78d96fb7b36c@narfation.org>
References: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
In-Reply-To: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=sven@narfation.org;
 h=from:subject:message-id; bh=0yT9uLenR8Z5BBnF8zbyTU4hPkTIyYjgI6isEVSMDcM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+AeuncfRd2KkoI/I8rFNriqVJ8mmz58VCPw+YnPc5t
 HHSyc/WHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJPDNl+J+8I3CJ05/Hcies
 n7xa5XN2UambIMOCzWecefyXL1681bqdkaH9raRC367bFzWSJm1d1iQv1dv2f3+43roco93r9xz
 PfMYPAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7755VHSEHGLJ2DVE3DHTSTSGTHHQVJYT
X-Message-ID-Hash: 7755VHSEHGLJ2DVE3DHTSTSGTHHQVJYT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7755VHSEHGLJ2DVE3DHTSTSGTHHQVJYT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

tp_meter_start() and tp_recv_result() return a negative system errno
captured from the kernel's netlink error reply. Both failure paths in
throughputmeter() printed that value with "%d", so the user saw a raw
negative number instead of a readable message. In batctl, this is usually
formatted with strerror() to get a human readable version.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 throughputmeter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/throughputmeter.c b/throughputmeter.c
index 7d41c10..6799c93 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -397,7 +397,8 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 
 	ret = tp_meter_start(state, dst_mac, time, &cookie);
 	if (ret < 0) {
-		printf("Failed to send tp_meter request to kernel: %d\n", ret);
+		printf("Failed to send tp_meter request to kernel: %s\n",
+		       strerror(-ret));
 		ret = EXIT_FAILURE;
 		goto out;
 	}
@@ -405,7 +406,8 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	result.cookie = cookie.cookie;
 	ret = tp_recv_result(listen_sock, &result);
 	if (ret < 0) {
-		printf("Failed to recv tp_meter result from kernel: %d\n", ret);
+		printf("Failed to recv tp_meter result from kernel: %s\n",
+		       strerror(-ret));
 		ret = EXIT_FAILURE;
 		goto out;
 	}

-- 
2.47.3

