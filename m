Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC218C43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 19:17:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 75E678418B
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 21:17:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783451845;
 b=HDAlVtofHWLCFnrGlOasYz7B9ACK3logwZzchAHsvJTpntqIVjM5o+Ej3gmFqwsESkFJb
 cs48QpK8rTwZGMU8oYKpxeAl9mw5i1WUbRBJBOVMyyVvzEFq/JNnJb22B3CkH9pkY/D5K9R
 siL4NmbdseOJQHafBT2J92SDtE/Nx6c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783451845; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mlyYN2ITz27DyS+4fzIUdcDnxVrUySv+RPaK6ujp5wA=;
 b=ePMM4IA0JhjwO0g44OtzphiSRbiqSr4G4OxelFk8uNRjzbvNnTF4i6b6P0NyXV9CODCfA
 CnSl/QhvcHx8hm7fCBVtu95sPUNfXZR10Im6Yf5wUOVxzk0ya05qEnBg3RDvvUZWd+HfzUO
 KnUJZq8siFNVWyETZNgCSbFPGJPNl/Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2833680740
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 21:17:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783451835;
	b=ASS16sThBIM9Mqw7kYm05CvaavQ0BhiJFAMnqx9ulz7Ybvc8iktatS3XQXIFkTJb0C1ZEV
	owK8o5UaHpQH7o3vAdd/KkYqlNXO8TmbnLL3paX4Hjv7l/M+dzaBWptmwOEmrT1U6+Yg4I
	+NhNvZaRbliAuLDIYsFIW9pubq37OXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783451835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mlyYN2ITz27DyS+4fzIUdcDnxVrUySv+RPaK6ujp5wA=;
	b=l0EqlYa4HxVME+rygPt6CVCWa3WIzYDulErN/LL/UAsW2h5qCPMiTi5TtRO2eg/M7R+zHe
	CIL7uZ9QvCBN34yD/hD90hvTTRr9w6b4mrrbGMy1sHKBa4UTA5tGFEtInD/68Eu4UwdwDG
	OZrAR24WX17Bo1c60Dxp+N8WxWAoTpY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=r5MVnzvQ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2ACB920636;
	Tue, 07 Jul 2026 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783451834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlyYN2ITz27DyS+4fzIUdcDnxVrUySv+RPaK6ujp5wA=;
	b=r5MVnzvQJigHW+CBg1Fartm9fwiIeIZbuP7nxf0D9Fy8PwbjRAJprq/A3Gbn9rpKqlO81m
	Ry9w+mqLlJqa1k5jf9qY9XyusvpHrYXekd1JrsZsRiN5WrpHsGC2qtglikgRe+wzRqIs9E
	iM0nnwTkVkRIgPO46V1+mFhFfhCj3cg=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 21:17:02 +0200
Subject: [PATCH 3/5] batctl: tpmeter: reject invalid test duration argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-tpmeter-v1-3-78d96fb7b36c@narfation.org>
References: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
In-Reply-To: <20260707-bugfixes-tpmeter-v1-0-78d96fb7b36c@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=sven@narfation.org;
 h=from:subject:message-id; bh=iGPDE1igLVOTNsbqcT5nKyZuiAIhpIbjmgclSHdd9Yo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+AeuXXlv7WC7hu4JxclRmyel12Qu2RHyWrKrP17Dz3
 lH6nOFjRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi8sGMDN+MNY/Zlnr7xL7f
 dbxVzqP0+HO9AyxBe6+Ia57ib28+/5Dhr+DPxYH+R7tOLwryzXMS9tReV3Iw+kNqxEOVpvIfeqb
 pbAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DSZGMAJXMDJRIKRAEFPH6675WANJSHCH
X-Message-ID-Hash: DSZGMAJXMDJRIKRAEFPH6675WANJSHCH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DSZGMAJXMDJRIKRAEFPH6675WANJSHCH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The -t option parses its argument with strtoul and
assigns the result straight into the uint32_t test length without any
validation.

Use the same strto* validation as the rest of batctl and print a user
readable error in case of an parsing error.

Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 throughputmeter.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/throughputmeter.c b/throughputmeter.c
index fd4165c..7d41c10 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -329,15 +329,26 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	};
 	struct bat_host *bat_host;
 	int ret = EXIT_FAILURE;
+	unsigned long time_arg;
 	uint64_t throughput;
 	uint32_t time = 0;
 	char *dst_string;
+	char *endptr;
 	int optchar;
 
 	while ((optchar = getopt(argc, argv, "t:n")) != -1) {
 		switch (optchar) {
 		case 't':
-			time = strtoul(optarg, NULL, 10);
+			time_arg = strtoul(optarg, &endptr, 10);
+			if (!endptr || *endptr != '\0' || endptr == optarg ||
+			    time_arg > UINT32_MAX) {
+				fprintf(stderr,
+					"Error - the supplied test duration is invalid: %s\n",
+					optarg);
+				tp_meter_usage();
+				return EXIT_FAILURE;
+			}
+			time = time_arg;
 			break;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;

-- 
2.47.3

