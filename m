Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2795DC54F4C
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:35:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B59098451A
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:35:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245738;
 b=2mYatNxA1H1yshSiVMAoalcIli2FpI+F4n1ozFzp4IaoPObyqiAdkWYhuALy1tpRK7Wb8
 rz9m+UaEJ0Qe5Dyi25wLmNSL+YVAfQ2txtxZcevvdMuWaPtLkdmrKOzSTxYJDleVwR4+eOZ
 OzQAaPBo4nMsPZfNmuMPTL+hz9Di3zI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245738; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hKdSQap725H9tIiuCwx7UtyQ1eQWk+4lBHapjp5xdv0=;
 b=YwrI0divWZ9wGCh9heOcTOoF+ae5I1y7yukxEmpEeqZUPlETRl9oosxmBIA4izrTpuFnS
 SumJTkFp2bHF7rZnIfnOsHz5mZI0TNHJrenZFwxS9R2KEMmLCWHXjMbT7FkPVkQXdHugemy
 H2Shwb20QWkkm7k/m5pA36LVowYdHow=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2D18081436
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245613;
	b=KENEHeUg+lyFOGQlnrrK7OSAvfbVDCjQtEyQoX2NrKuym5fk/jbdWwdPVXTXp4R3xd7/Nm
	CT7gO/i9E78KvFhSUTpnX5AY2yxBKMWfqTil85tLMMGCKZItI0O15MSaEjnXc54DM9ItVc
	8kyxj2T9O3Z806UjaIh1asrdrY+CQNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hKdSQap725H9tIiuCwx7UtyQ1eQWk+4lBHapjp5xdv0=;
	b=s1mIbQ47jTw61rfv7fyo6L1rx3Z3WkjO5wSi6MpoScnOkA/mnO/zdxHW949YQ4/fq4IdZ/
	sVxFDJwljNa1g6Ln7rkAMZQjAeJqHOhJV42ksZBxEltgHk+xfvT0Y96g1nECZ942KQJDU6
	fMrlK6MyL7Vtk6IffuSgXuPlJskic2A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FtNqXy1y;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B6D91203F6;
	Tue, 28 Jul 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKdSQap725H9tIiuCwx7UtyQ1eQWk+4lBHapjp5xdv0=;
	b=FtNqXy1ykC+gfGk3CTEifKU0OvcPI4cKIDRhr38dtJO8KLeVJgy/qMnIBLho5e8SRtIOWt
	rB1Hzs51efE5SAOTAR7LhnbEKrA1gB7Dir6oqrU3oQv4PkmfpsxtYNkCOkdxHsC7ZhnQC6
	j8X0hG5HjWOClVeRb+8374YOqvrwq7U=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:12 +0200
Subject: [PATCH 3/7] alfred: gpsd: fix counter underflow on leading
 carriage return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-3-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=sven@narfation.org;
 h=from:subject:message-id; bh=4QURTo/4EYI9FEzlwpcVdT9f1p2YTcJRoxd9CQnMscc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61v2/e67tVJ2a1VcnNRG5jclD1J8v53QEnjzMavae
 k/rxK/hHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJLDBi+Kc6bevZlTs7FHgX
 Viz5Ua3/p3+R08T58VHqco8WKtxnVWxm+O869Ur59O8ptUcuqu3bJ+Eg/+lS/zEdLYsWZS1pVrd
 CDw4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EZ5X7AQB72CT4KZJEJEPFYSP62MB2RDQ
X-Message-ID-Hash: EZ5X7AQB72CT4KZJEJEPFYSP62MB2RDQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EZ5X7AQB72CT4KZJEJEPFYSP62MB2RDQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

gpsd_read_gpsd() strips carriage returns from received lines by
decrementing the write position so the next character overwrites the '\r'.
A line starting with a carriage return causes an underflow to SIZE_MAX. The
read is aborted because it will be much larger than the size of the buffer.

Simplify the logic by going through the buffer and only incrementing the
write position on valid characters.

Fixes: 2b901d69d8fb ("alfred: Add support for passing location information over alfred.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index eecf914..6456e74 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -314,29 +314,33 @@ static void gpsd_read_gpsd(struct globals *globals)
 				sizeof(struct alfred_data) -
 				sizeof(*globals->gpsd_data);
 	bool eol = false;
+	size_t received;
 	char buf[4096];
 	ssize_t ret;
 	size_t cnt;
+	char c;
 
 	cnt = 0;
-	do {
-		ret = read(globals->gpsdata.gps_fd, &buf[cnt], 1);
+	for (received = 0; received < sizeof(buf) - 1 && !eol; received++) {
+		ret = read(globals->gpsdata.gps_fd, &c, 1);
 		if (ret != 1) {
 			gps_close(&globals->gpsdata);
 			globals->gpsdata.gps_fd = -1;
 			return;
 		}
 
-		switch (buf[cnt]) {
+		switch (c) {
 		case '\r':
-			cnt--;
+			/* strip carriage returns */
 			break;
 		case '\n':
 			eol = true;
-			buf[cnt] = '\0';
+			break;
+		default:
+			buf[cnt++] = c;
 			break;
 		}
-	} while (cnt++ < sizeof(buf) - 1 && !eol);
+	}
 
 	if (!eol) {
 		gps_close(&globals->gpsdata);
@@ -344,6 +348,8 @@ static void gpsd_read_gpsd(struct globals *globals)
 		return;
 	}
 
+	buf[cnt] = '\0';
+
 #define STARTSWITH(str, prefix)	strncmp(str, prefix, sizeof(prefix)-1)==0
 	if (STARTSWITH(buf, "{\"class\":\"TPV\"")) {
 		strncpy(globals->gpsd_data->tpv, buf, tpv_size);

-- 
2.47.3

