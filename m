Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C7FC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:36:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E5D1284683
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:36:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245781;
 b=3zW7+VqlOxzq36NSKAn98VeDYRk5wlM1KqDFyi/Zy5zaUDlAKiQvfzmsPKcl3cakgYdcO
 Uy++FgwCNWomkdSRz9yIQBen2H5KotKc/kOzTsDlzmoUoCc4o3gPb8CzuY5IhVH1mo2EvGJ
 uprpDDcFFSpJp0dIzE9RW96m4LTnkzo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245781; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=V49/6qOnBd7wMXgpNzX8J7fVY5pfCPqapNO0hvpdMKw=;
 b=3b2DJA51ifllEx7Q1AAQ2d366GI0aL8NN6OOwvFn2A2g7cx0nUZNqjIBPWJ/DPaseC33X
 kYVoNn41mCBopQhF57x9/NhBi0JvmvxW+p8Rr7xFpLFIOux/O/AzJFtty6GQEiTvndrSwsr
 AZ8vdJQvToUeOzoiwzCyD2zcwjhLzDM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8B239841B2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245619;
	b=TC3KhoFjlreJRXlHEG+NH9LqQ3I7RwX227vc0l5gfas9NP4vhzFNwnCSlFHExlgGj8ZPgw
	VY6uuS1q1okXJNb4i8Ikc4B7uqI4dsTd5fek7KmKXO8KPRet67XAPNVbhegLMlVR5sQn95
	kH9AYaioKp3AgFSb417FwJcHBZD6WeU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=V49/6qOnBd7wMXgpNzX8J7fVY5pfCPqapNO0hvpdMKw=;
	b=ePMKhZ3qh+5ygp+I4tfWBdcceiLYBfV52y7sU2xI8UxFO6RDnR+kRvKlnGlSjMWR3HuWEy
	ddZTXCPKCOMHbWVuCVQJs9R7sAPAAsTHIxbIRe1lP3gmcmimj8iU7jRgmVIkvl4M8pIL/p
	wEj38Stor65AHmf9X1fQOFh0vmhnlCQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="FcL/L3bF";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2AD751FF8D;
	Tue, 28 Jul 2026 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V49/6qOnBd7wMXgpNzX8J7fVY5pfCPqapNO0hvpdMKw=;
	b=FcL/L3bFk5odKGXz5XUREKMVW0mMVYdt/0uj0hwQV6VO5WhsiYdDozHMfszMRcdH+tLA2z
	3uORat2SD43rqZphJuWq6A6ROG/suYK6aoCqRInkk51rdF5PHJ4RVLv1oWmlgILoOOvLrG
	84W9P4U17YTkeZTD3piA5NhHzhMgzR8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:13 +0200
Subject: [PATCH 4/7] alfred: gpsd: handle short reads on the unix socket
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-4-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=sven@narfation.org;
 h=from:subject:message-id; bh=WqoCGfzh5yLxYoAnWm6eJS15eKZC55cVMpHCxgVRg1A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61vq39fobry11r1ci/FL5G2GhYEZbY+zAg4tzIsKk
 FYK4m3vKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkiTvDH87T14XSpl561Gzz
 RWDvX5E7Feov3uwqWbY9KcTEzGDuF12G/77CgsWu36Me9rUdl2mP8W1SlDQ7bqTv9SQ+7tHP7d2
 v2QE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: L6R5TPIIFEJCEOP7MSIQ3SE3KD3HPBSL
X-Message-ID-Hash: L6R5TPIIFEJCEOP7MSIQ3SE3KD3HPBSL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L6R5TPIIFEJCEOP7MSIQ3SE3KD3HPBSL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The answer of the alfred daemon is received over a SOCK_STREAM unix socket
which doesn't preserve message boundaries. read() can therefore return less
than the requested number of bytes. Such a short read was treated like an
end of stream, the current packet was dropped and the answer loop
terminated.

Retry the read until the requested amount of data, end of stream or a real
error was received (ignoring temporary interruptions EINTR).

Fixes: 2b901d69d8fb ("alfred: Add support for passing location information over alfred.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 6456e74..43a3a83 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -139,6 +139,30 @@ static int gpsd_request_data(struct globals *globals)
 	return globals->unix_sock;
 }
 
+static ssize_t read_full(int fd, void *buf, size_t count)
+{
+	size_t read_len = 0;
+	uint8_t *pos = buf;
+	ssize_t ret;
+
+	while (read_len < count) {
+		ret = read(fd, pos + read_len, count - read_len);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+
+			return ret;
+		}
+
+		if (ret == 0)
+			break;
+
+		read_len += ret;
+	}
+
+	return read_len;
+}
+
 static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 						  uint8_t *source)
 {
@@ -149,7 +173,7 @@ static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 	int ret;
 	int l;
 
-	ret = read(sock, buf, sizeof(*tlv));
+	ret = read_full(sock, buf, sizeof(*tlv));
 	if (ret < 0)
 		return NULL;
 
@@ -171,7 +195,7 @@ static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 		return NULL;
 
 	/* read the rest of the packet */
-	ret = read(sock, buf + sizeof(*tlv), l);
+	ret = read_full(sock, buf + sizeof(*tlv), l);
 	if (ret < l)
 		return NULL;
 

-- 
2.47.3

