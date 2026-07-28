Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670F7C54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:38:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BFBF184183
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:38:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245919;
 b=kqP9hwFLY0hdd0ikkUCxuDkcALK1LrY30vGlv5TImhuq3jRV9FIrHaNNIo0pybf9TFusb
 ul5Po70YXDoIgrt9iecDmox2R8qJ63Osv5tgHND/xSKvdqvK4qdA4Hte3v0Or4THoktYtJY
 wUWOTQxisp3BKH9K3Ba+1GSmD2vwocI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245919; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Mb3rBdO5Qj3NNbpeDwMkv1SZruiKPAHXeFcLhe0zV2M=;
 b=RPbvu0ubKr6oEIxyV4Dqvs+0tRICiB3hAMZJgdpeGYLXWcfvPdJyAEjDUo6D9z2I4YjWQ
 9F2wSU6oz3Q7TksrTSgDhaZ0LLWvvBcDriPxq8XiwO1UixFtEdVyoUHFChCvEaxP6LdKEGE
 UNI2ChYe0p5OQXzSva8Xvv0hUOjfV8c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EDBEA84306
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:34:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245654;
	b=2QJ/t6oOqmoqXLknxymr6kkhRcUm3zRSBn9LczdCDV/E560pY/h+G3QHPbLMEOnESdT9ZM
	ZSpoEJ1avy9jqffxDMCYu9j5t6YKdhu/PKwWgjFmkIORGAbOv7Xzry1YLAQ3CY8LNBZ+3N
	05RfAmNg2JyUGJQfUDX1QZV37I2UlCc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mb3rBdO5Qj3NNbpeDwMkv1SZruiKPAHXeFcLhe0zV2M=;
	b=QgAsG5tdOJ5A1RxzcVTc7BOLNHQ8LeOdPQEmypab0NNkuJNEZtXtEhv0LnPexRgGWpKbNj
	eA5/cYmCq3O4gAYmfZ/q8acqzoRZoePXJlMsA2i62Ugahv7+K8cqdTojMDFyEVCW/NhYyZ
	hIqghUUWlOcOXfuovC7mf4QQF7SQ1RI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iHz3B4Wl;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8F53D1FF8D;
	Tue, 28 Jul 2026 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb3rBdO5Qj3NNbpeDwMkv1SZruiKPAHXeFcLhe0zV2M=;
	b=iHz3B4Wlva4N3YLJ0TfvdjVU6+j5WWJ5DzFsdxde9IfhD3wO048oXwgx9wmkZZnxViIENi
	V8m4z9KprEbXtjJNcjHzk/jQE4lwU2zx+GNwMcrSOninbHsA3lNVsAVcF+y2pbqK+6VaLn
	O9lpAXlCtuVFycAjuE5tPQP5qYQNorI=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:16 +0200
Subject: [PATCH 7/7] alfred: gpsd: handle empty or not 0-terminated TPV
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-7-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=sven@narfation.org;
 h=from:subject:message-id; bh=tw8rUSFTRHcHKLBaHBzskv0Eg+aNw7SkU50nWsVWzvs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61uztl9TX/s7dBsvU29MVM4zmzi92c0V2zfk3bma1
 cwQWby2o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjAR9nRGhiPGZjM7hRdM3KrR
 yTnrdG/N/3k/P5/mOCxy4uLh5Qx35QwY/tnd/Dtnd9YpNVG9VlZRlpqn+WqTrrZ9vXT1YvWd5IS
 9CcwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: P3PODBBL4M4WRJDXQF32RX5LPTKM7M66
X-Message-ID-Hash: P3PODBBL4M4WRJDXQF32RX5LPTKM7M66
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P3PODBBL4M4WRJDXQF32RX5LPTKM7M66/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

gpsd_read_answer() printed the received TPV data with %s without verifying
that the announced tpv_len bytes actually contain a terminating null byte.
A record without termination made printf() read beyond the received data
until the next null byte in memory.

Ensure printf is only outputting the content of the buffer. A record with
tpv_len == 0 has no TPV bytes at all and must not be printed either.

Fixes: 2b901d69d8fb ("alfred: Add support for passing location information over alfred.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 8e2f1f8..bac5711 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -234,6 +234,7 @@ static int gpsd_read_answer(struct globals *globals)
 	struct gpsd_v1 *gpsd_data;
 	uint8_t source[ETH_ALEN];
 	bool first_line = true;
+	uint32_t tpv_len;
 	uint16_t len;
 	int ret = 0;
 
@@ -248,16 +249,20 @@ static int gpsd_read_answer(struct globals *globals)
 		if (len != GPSD_DATA_SIZE(gpsd_data))
 			continue;
 
+		tpv_len = ntohl(gpsd_data->tpv_len);
+		if (tpv_len == 0)
+			continue;
+
 		if (first_line)
 			first_line = false;
 		else
 			printf(",\n");
 
 		printf("  { \"source\" : \"%02x:%02x:%02x:%02x:%02x:%02x\", "
-		       "\"tpv\" : %s }",
+		       "\"tpv\" : %.*s }",
 		       source[0], source[1], source[2],
 		       source[3], source[4], source[5],
-		       gpsd_data->tpv);
+		       tpv_len, gpsd_data->tpv);
 	}
 	printf("\n]\n");
 

-- 
2.47.3

