Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7408FC54F54
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 17:14:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF01D8418F
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 19:14:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785258888;
 b=dzBpUB2hFQwt6Q9JKu6KGnOBR8eDwK1zycfzfbNm7lHaKC3sU24ktT6dZ/pdwfi33bSoC
 ml0vccLpTRNqGML4um2NnSt3vo9ahJ+yYaqd/2xlrXbL0Qf1klqsUZQy1Md8ZiJfPpDzlbo
 5O/+tV6RUn8BG5emWaFrvhx5jRNDn/c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785258888; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5s/GydZj2WvSUIGaz8dDvgzQbpfv2fMPnFV0VlK23uc=;
 b=yeamE47jUJ+j+7Zot135DTjjTfkbw9qYonTi69R6uAxnB50OBkmgLypeU8UNdAnPKNTuL
 e6ERXsLjUvn9rsAsixKomePdQ3kNVej1BaCRtwd72jOHF2SkUZMalmXkVVSgfGN/dOik8FF
 9LoI5Wx+0yXDi1qX9RoJJqn6V7ecDL0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D74D7841C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 18:03:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785254584;
	b=b9wdjxygLNxR5f2aVuyidjGRZNvoSYxvTSvplToDFMzowu2YKzWktsg+8sUhbfRV1d/1WI
	LuwkyYNu0krqu3cefWoldQZqQSsTvOyBSzmlRjhsUGLxIySrBCYKCqUCZf1zHMRAKVBg0x
	3hoOPMAwV4RLf/KWW4WEU38xZoydyWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785254584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5s/GydZj2WvSUIGaz8dDvgzQbpfv2fMPnFV0VlK23uc=;
	b=Ei9KQa5GHunuzZdRWC/87kklK9ODGWbr3x7+HeJclf3nXGNWTgHEf98V+5Y3uMwCkgpYPh
	10ZsGz7bC/a9Z4qK20ji5AGBWCBirgT+OSiHgBpPVAy0QYDNgz0ga5aUOVPxCdkjWpJbj3
	rZa8yYye3e9GNVaZ8lz3uebWSg87XKw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DgLo+nuH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 17B0C1FF5F;
	Tue, 28 Jul 2026 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785254578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s/GydZj2WvSUIGaz8dDvgzQbpfv2fMPnFV0VlK23uc=;
	b=DgLo+nuHaXvhHwxPD168d4LTc9zgqZlGZnSoJF4lK1JZEFHSEbhHy4NbAk68Z5Ax2gp8wr
	s7pmaEOXiP1HuQASJFtv4slJgbtNoqLIp/BMqc7imL8R4QSer9fnOF329y+KjPt20mPFK6
	NdETqCK2gBqtKW18A4NGoP5A2TO7K6Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 18:01:33 +0200
Subject: [PATCH 4/8] alfred: vis: handle short reads on the unix socket
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-vis-v1-4-2540447c8a67@narfation.org>
References: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
In-Reply-To: <20260728-bugfixes-vis-v1-0-2540447c8a67@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=sven@narfation.org;
 h=from:subject:message-id; bh=TGNNlLqoz4dtslqH+8Msx6ruNwisbICVJOAkX2H+gNI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZl2L0zgSpHs4LKVgkMuvyJc7d9SaG1twe6h66ehLq5
 3gtZ9/vKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwkMoDhfxHrq3gGW6vX7OrG
 xxiZ+p/Ln3XxZT1wbOeLPcm8axmrPzL8j2HVcXBq7pKMDZoXfnsTu8zN3Ru7o39Pa06aZzDvfdg
 DTgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4MJSCE3QOJ7DWHXCGD6GN43ZSQVU22BR
X-Message-ID-Hash: 4MJSCE3QOJ7DWHXCGD6GN43ZSQVU22BR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4MJSCE3QOJ7DWHXCGD6GN43ZSQVU22BR/>
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

Fixes: 2e3e312f7757 ("alfred: add vis")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/vis/vis.c b/vis/vis.c
index d529583..33fa692 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -694,6 +694,29 @@ static int vis_request_data(struct globals *globals)
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
 
 static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 {
@@ -704,11 +727,11 @@ static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 	int ret;
 	int l;
 
-	ret = read(sock, buf, sizeof(*tlv));
+	ret = read_full(sock, buf, sizeof(*tlv));
 	if (ret < 0)
 		return NULL;
 
-	if (ret < (int)sizeof(*tlv)) 
+	if (ret < (int)sizeof(*tlv))
 		return NULL;
 
 	tlv = (struct alfred_tlv *)buf;
@@ -726,7 +749,7 @@ static struct vis_v1 *vis_receive_answer_packet(int sock, uint16_t *len)
 		return NULL;
 
 	/* read the rest of the packet */
-	ret = read(sock, buf + sizeof(*tlv), l);
+	ret = read_full(sock, buf + sizeof(*tlv), l);
 	if (ret < l)
 		return NULL;
 

-- 
2.47.3

