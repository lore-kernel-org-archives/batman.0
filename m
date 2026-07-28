Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C097C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:37:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B8D20846AC
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:37:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245876;
 b=zZfxOnKR7MvGMZQ2s3B9cM5aHH1CHKdhMA/ICFiWA1GK9CaeVXNvZeNTarbE/dcO6NvBh
 RPGWm2HF1TS0KIf+gaeNgZpUZIsIRGT2Qxmj04LCKQ1w1WhScrEUNASGnTKOkmG0EG5y4gD
 QISuwuHmixZF4ldWGUeIJXEXxqkYoNQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245876; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SGtNXrrgFKZ08rIbF+JU2oweVdC7BXMfzUEUzjy33to=;
 b=zBZbDbepyTWtZzG2DEPGYh6MGlcv5yDFByXsR++DpDaVNaX1U8AcmwutT/VGPqy7n6UWY
 q9gUHhTwniZ1F+Zwd6PvXYUj543GJ3CdmWV7qiLSPi5hhdlT8QivmWFnMzXE4orJaQZI4an
 TgG+WnsHj1oMAWJKq9rPZF1ZFn5+GPg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0749884243
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245634;
	b=Jej4FqmRhJbFtdtTyKqz2eUyWifiULe3s9QqaJFbmT20YpmKnrghZkjSuCb21ZAkHTWfrX
	/I+U7+SgEfwfVgAO1LfOSWpd6zJSlTGDuY/E28UZBuorZ8YQNszJpJy/U3/Nyqfj8RWmyZ
	eAOobAsQwLvaVfEIJDH+046b+RXabQY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SGtNXrrgFKZ08rIbF+JU2oweVdC7BXMfzUEUzjy33to=;
	b=V4Cjm1B0wpXVkPg1GEEb6HmKsK10gxEQ5Qnb5lTO9uuyGaJLJwazYtpfGPrq/ktztm3ZHT
	MvjUAFFPnJ8oGW/vBIXCEmhwcONnGcNlWfw2LOMKVdHcTj/7mGI0PsYoXMavcSEg0415PR
	swDlyvbWmx4arqA9LSEA8Nm4o7mG+Dc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xpxcvt6v;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9BF8A1FF8D;
	Tue, 28 Jul 2026 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGtNXrrgFKZ08rIbF+JU2oweVdC7BXMfzUEUzjy33to=;
	b=Xpxcvt6vDg1yYp/DVtwnggWHJRvW9SiaG3S3G3fidvcCJdKJobALI9OnjC3PTR/2CaWoFY
	qHerL26+42eZvx1TYkAuUxkvitrzQSVsyNUhi8Yg0i9+8ewnjmwclY/DNi/jBN3Ca92eR3
	Mdj+/yda7LsDol942bz19i2UoXO25PU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:15 +0200
Subject: [PATCH 6/7] alfred: gpsd: don't drop the rest of the answer for a
 bogus dataset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-6-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=sven@narfation.org;
 h=from:subject:message-id; bh=V79KYP3409tMpOnfYVkgK03lS3KlB/GDv9BRJJaXV2I=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61tMLp7wXsFcPmmX/azQth+n5jx7Z9oUt2VFgq77p
 zOOBlPed5SyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm4uzEyHDIcGE116WkyC5W
 zgbJrT6GqevP9bHWv7Dm3/fl7tKj26MZGXZs7roX75zx8+3XlsuM9tc0fzpXh9eJ6V87esdo2oM
 JOrwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: F5RYS2SSYUUNXHHVEYZL25ALJAU24TNR
X-Message-ID-Hash: F5RYS2SSYUUNXHHVEYZL25ALJAU24TNR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F5RYS2SSYUUNXHHVEYZL25ALJAU24TNR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A dataset which is too short to even hold the length of the TPV string
aborted the processing of the answer. The positions of all following nodes
were dropped from the printed document although only the dataset of a
single node was malformed.

Skip such a dataset like the other bogus datasets instead.

Fixes: 2b901d69d8fb ("alfred: Add support for passing location information over alfred.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 57ac9cf..8e2f1f8 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -242,7 +242,7 @@ static int gpsd_read_answer(struct globals *globals)
 	while ((gpsd_data = gpsd_receive_answer_packet(globals->unix_sock,
 						       &len, source, &ret)) != NULL) {
 		if (len < sizeof(*gpsd_data))
-			break;
+			continue;
 
 		/* check size and skip bogus packets */
 		if (len != GPSD_DATA_SIZE(gpsd_data))

-- 
2.47.3

