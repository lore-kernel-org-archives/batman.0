Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39BC5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:34:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3F78684009
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:34:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785440041;
 b=w6A7mk2PDua4+Q8xS3tVHnIXX6Xev3kWUQf6nmxhVOk3jvP5NVu9wfAi7Fh/dnFsDM31+
 23AfWB54xm0FeTr+GqYsWQUEG+284S4kwuEdLuI97O6xj9nBFD07lS3Zb4qzW9IBcE6IKid
 f1H1VtmnpGfKjTu09/coL3FvQR3/z24=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785440041; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IBE6KyJrunHH1Pb7ubniRqIVk9bczohfMHsLKGSCTgI=;
 b=cA1rvDeIVc72VWnfr6HxIJt4FeEVegYH3qPGP60pWHdjN/fmtbDkIU8e2Z/11Awt0qmNr
 E0s9r6hMCJMIFE59mwTpsSelpBdvRFEW4ul5jdS/nvgVZeZDKqhCmUhw8PLBj/gx2dqzt0J
 f4/LOpVrWlZ/nz2yqPjaQTdlyCcLmho=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D2A2E83E78
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:32:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439975;
	b=srAFdTYMJjLrnN904TPKJp+7djGCAkzjNBCLD5GcVitK0GA2ClaWl7s0TOKkEUDK5UTjgy
	mXKh7j7s+wUXCPw1AK+Xd4ANM1/2c4LJuKrdq2orwpIIgv/fV6feVq9YCj3PLxG0FeYkXr
	J8XIqFaOaonyS0oVgVzJfmaMbhDGEuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IBE6KyJrunHH1Pb7ubniRqIVk9bczohfMHsLKGSCTgI=;
	b=1k0oeg3BJeEyO2K44uum4Db5Fd2Rd3GMWp9+JXwgShOof7K6NJrkC88xtVd4++vZF60Dp/
	UwzEmaRzKApgjohiimT6KExORvXiPETfqw5bad1UngZO3cZkV8bTfKsSskysRtokj5yXWG
	XQIouImSA8+jaLH2mijr/21jL/TjD/U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=x0DWzTk3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 69ABE203F6;
	Thu, 30 Jul 2026 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBE6KyJrunHH1Pb7ubniRqIVk9bczohfMHsLKGSCTgI=;
	b=x0DWzTk387/MJpo26gPYx3kLp+meIt9aKiEKCHcWGLUgdvkfqRuAiHSx6HHgbWVp66XF6R
	q9PyiO6cj4UROw1FBnHE9apWJ4jeDXKWoBh9weJ/K86jNDctJ/MN0R8Mb/8esakmUlJmpy
	9lDW/DPEHJJTvK/X7cEl4568l/5bReA=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:31:57 +0200
Subject: [PATCH 3/6] alfred: check strdup() failures during option parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-parsing-v1-3-c0f2ce4764bd@narfation.org>
References: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
In-Reply-To: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=sven@narfation.org;
 h=from:subject:message-id; bh=C1DSyDY63MKXpe3erc018q0+mAIONIvFoOAOOQpyYZ0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9Ymz/NWtA1+GXRF3jMjO3Pf+h3RZj1M0hqzg4I+v
 rvte7Ovo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRGa8ZGc4kTIveodDSxnRO
 NPLEwp9GvEzhsV59GyYz3lu2Qr/9+EyGf0pyG3aJ1Gl+0Pp3/kPXkqm2Gt8ntrxo2NZgvdPI/pr
 dHj4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6KAGKWX2HND6B35MUMXSEPCZXRPF3774
X-Message-ID-Hash: 6KAGKWX2HND6B35MUMXSEPCZXRPF3774
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6KAGKWX2HND6B35MUMXSEPCZXRPF3774/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

alfred_init() duplicates the default batman-adv interface name and the
interface names passed via -i/-I and -b/-B with strdup() but never
checked the result. On allocation failure globals->mesh_iface or
globals->net_iface is left NULL and later used unconditionally and crashes.

The allocation should be checked to present a user readable error instead
of crashing at a later point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/main.c b/main.c
index cc3bc42..baedbd2 100644
--- a/main.c
+++ b/main.c
@@ -262,6 +262,10 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'i':
 			free(globals->net_iface);
 			globals->net_iface = strdup(optarg);
+			if (!globals->net_iface) {
+				perror("strdup");
+				return NULL;
+			}
 			break;
 		case 'B':
 			globals->clientmode = CLIENT_CHANGE_BAT_IFACE;
@@ -269,6 +273,10 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'b':
 			free(globals->mesh_iface);
 			globals->mesh_iface = strdup(optarg);
+			if (!globals->mesh_iface) {
+				perror("strdup");
+				return NULL;
+			}
 			break;
 		case 'S':
 			globals->clientmode = CLIENT_SERVER_STATUS;

-- 
2.47.3

