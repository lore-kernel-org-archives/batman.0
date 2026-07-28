Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFC3C54F4D
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0F21580B8E
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 19:40:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785260410;
 b=y9OATtyj9+V2KU/vy6JOto8THgJBigSY8w8ffbwsaziUGUgGP6lomZqbnL8yTqV44JOv+
 0VELGwqEtdcNuTG8vUW7TJg2G0aCx9/2UA3PFB/VFK9igo19mcpEOTgBRBlwi9PqB/aYi+w
 EP4GTNZBZU5AAwYOPicHS8YWMnwsmyo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785260410; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=T4vFapAHPaF374bPR3eYINYBDzss07TJ9IlpC2tg7C8=;
 b=tveG75gjY3dE8TyrpYRN/Yo0FzNV4/p02dbAmx1V/7sa2Y78vGaxp5c7P3bbZmll3Qgfo
 fC7j8EAbbGtYQU5SEixhRi0VO7qgktfteQuiqe9eW9y60Q3Teo5jkbrxwQHfyUdfjxl0I5j
 zALhgZwhvLSIlbxcLIoRdMxSIAAB8bw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 401E0841A2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:03:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254590;
	b=p137nYMp8VC5xJuFtSaAbZYMh6U4VYqCVMGCAg+9IRJKGr4Q+B6+nVbN5AQwopno4Gk+Pl
	FTSqTzJ33aM+ubsgZWwHErpPcL5v99iqxs70qX9W+aVIXiVIqNBXykbwKlPL9M68TYhmpv
	37AiMkyo2crVu2ke8aEjQXQRqsTz21s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=T4vFapAHPaF374bPR3eYINYBDzss07TJ9IlpC2tg7C8=;
	b=sgmhSNGxor68JebrYw/D9quWePMB1msV33GNsQZ72Oehkhh3034rPGcQ3dlczNc4ttVYIY
	z+Z33//+7BzcHr9lrgpTZFeoGxrxuA1xSsgKc285mOFbAwcrNYzGL+teT7owVm1ey0hQ6M
	bnl1Y6umhuSKOlJm/5lQykSw0LnEcnU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CApOmpFl;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DA4AB200D8;
	Tue, 28 Jul 2026 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4vFapAHPaF374bPR3eYINYBDzss07TJ9IlpC2tg7C8=;
	b=CApOmpFlFQBjNlJZCY5EJZU5Qpvb62E+Bs3rzhg3ndSWCxOMUuoYAixpIq3uIqITgpVtbU
	WvyclaMqXJyHv4yScSteSEtmzDdhLjx+UuhUyCOXGcdMk2COEuDF1OnbhFIhvVVbyr6stQ
	M3YP6R1amqEomj13W4p/OyG/zpeUWVg=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:34 +0200
Subject: [PATCH 5/8] alfred: vis: report failures while reading the answer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-5-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3291; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ichfczipp0frJZ2E7fdXIToxVaMh4Uq5YabaaDbL6A4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2IyX/BceCnoGHXuYtm7i9uXfRfpPux/99QR7Y9lv
 wTnG/1L6yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMRG8/w38P9x/b/+rzrn2a
 4Sz/r+BJQcumg/tMW14Wvj0qtkT/OMMcRoZO/o2WT7YxzTr9xsyn6fu1zB2X92mInV++mOEW27q
 Lp/ewAgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: P66UAOCQMIJ7VJOV47BXYHCO4ZHNUFBJ
X-Message-ID-Hash: P66UAOCQMIJ7VJOV47BXYHCO4ZHNUFBJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P66UAOCQMIJ7VJOV47BXYHCO4ZHNUFBJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

vis_read_answer() returns NULL for a:

* closed connection
* read error
* malformed packet
* unexpected answer

All of them were indistinguishable from the latter regular end of the
answer. Even on errors batadv-vis printed an empty (well formed document).
An error could not directly be detected by the return code.

Report the error state of the packet parsing separately and use it for the
exit code.

Fixes: 2e3e312f7757 ("alfred: add vis")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index 33fa692..451d79c 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -718,7 +718,8 @@ static ssize_t read_full(int fd, void *buf, size_t count)
 	return read_len;
 }
 
-static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
+static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len,
+						int *error)
 {
 	struct alfred_push_data_v0 *push;
 	static uint8_t buf[65536];
@@ -727,15 +728,29 @@ static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 	int ret;
 	int l;
 
+	*error = -1;
+
 	ret = read_full(sock, buf, sizeof(*tlv));
-	if (ret < 0)
+	if (ret < 0) {
+		perror("read from unix socket failed");
 		return NULL;
+	}
+
+	/* end of the answer */
+	if (ret == 0) {
+		*error = 0;
+		return NULL;
+	}
 
 	if (ret < (int)sizeof(*tlv))
 		return NULL;
 
 	tlv = (struct alfred_tlv *)buf;
-	/* TODO: might return an ALFRED_STATUS_ERROR too, handle it */
+	if (tlv->type == ALFRED_STATUS_ERROR) {
+		fprintf(stderr, "Request of vis data failed\n");
+		return NULL;
+	}
+
 	if (tlv->type != ALFRED_PUSH_DATA)
 		return NULL;
 
@@ -763,6 +778,8 @@ static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 	if (data->header.version != VIS_PACKETVERSION)
 		return NULL;
 
+	*error = 0;
+
 	return (struct vis_v1 *) data->data;
 }
 
@@ -995,6 +1012,7 @@ static int vis_read_answer(struct globals *globals)
 	struct vis_iface *ifaces;
 	struct vis_v1 *vis_data;
 	uint16_t len;
+	int ret = 0;
 
 	switch (globals->vis_format) {
 	case FORMAT_DOT:
@@ -1013,7 +1031,7 @@ static int vis_read_answer(struct globals *globals)
 	ops->preamble();
 
 	while ((vis_data =
-		vis_receive_answer_packet(globals->unix_sock, &len)) != NULL) {
+		vis_receive_answer_packet(globals->unix_sock, &len, &ret)) != NULL) {
 		if (len < sizeof(*vis_data))
 			return -1;
 
@@ -1037,19 +1055,21 @@ static int vis_read_answer(struct globals *globals)
 	}
 	ops->postamble();
 
-	return 0;
+	return ret;
 }
 
 static int vis_get_data(struct globals *globals)
 {
+	int ret;
+
 	globals->unix_sock = vis_request_data(globals);
 	if (globals->unix_sock < 0)
 		return -1;
 
-	vis_read_answer(globals);
+	ret = vis_read_answer(globals);
 	close(globals->unix_sock);
 
-	return 0;
+	return ret;
 }
 
 static void vis_usage(void)
@@ -1176,8 +1196,10 @@ int main(int argc, char *argv[])
 		return vis_server(globals);
 		break;
 	case OPMODE_CLIENT:
-		return vis_get_data(globals);
-		break;
+		if (vis_get_data(globals) < 0)
+			return 1;
+
+		return 0;
 	}
 
 	return 0;

-- 
2.47.3

