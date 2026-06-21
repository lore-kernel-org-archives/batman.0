Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ADACD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:35:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C610283EE5
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:35:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052501;
 b=yDgVCZ74uvB0VENQeUWhvzH/tXjujniJTr3mvWm1DaSh0KdUFU4ec/B9wcRL8BZLNAlLj
 1hL4bKeNi2tIeKdCrnsx8tTMoQYXhTZFkM71XLPRJZcKEAeYoZy2ROZoNW5UH3bcFbaTR/o
 xmP1puf/0fi9L0dLOkaFB1sXukQO6Kc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052501; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Oog+h8G+rl7vK2kIedlCQXJV1O+4WFXfJlgCeLKToQc=;
 b=hM9qpZoLW42lTEnQZrHVL0CFQn8SFEMExUM6N/NFjyEz74C2MpIA9i89+Sv8x5wRGkIw2
 WFMgVO4ZiF8lVoI2y/xUg0WyaC6u5bL8QPMgh6qx5R72tGmxfdZdGnL7PcfjYy/3BQh2CD9
 Gg6iNnUpmvXpPPk9DD/ObHbVlhDML7g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AA0AA80CC7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051912;
	b=XPOLcn3l575OavlbhR8zR54fVvWalWAHLJOQZv2YJIxMc8aT9zFuN6M1whIokiJIrUg5U/
	RTWdT95zkx69yOLF+jaBYc1QLaZxI3ATFnqO+RdH1C6FKDHe/OnTzkhO2ZY8lDy+U9yC/c
	1jR4PwSpxJr6EfIGCvyThcpfatvWJcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Oog+h8G+rl7vK2kIedlCQXJV1O+4WFXfJlgCeLKToQc=;
	b=wCwM+Sx9vdpkNFtgHfiRn3gqdvnravoYRWaWQgONb8LLyCLlT8Q915npqEd20WvuvCIVNb
	/1IHFI+0Alzxhji28YaagOrckbaCHl7kH1pz5xmj6qsP+obiZIdsjGk91pRv8fw1pth7hF
	NqaaR+678jlTIwAjCffe8Zd1OKw/0ck=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2NSXWbFh;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2CBAF20059;
	Sun, 21 Jun 2026 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oog+h8G+rl7vK2kIedlCQXJV1O+4WFXfJlgCeLKToQc=;
	b=2NSXWbFh6UadMWoPhSviKjJ+TlR4fT8xewYkFwY1Jw1/6ZEWDiNxtZkJxKLeF7eIRmpfh5
	8BSdhFjQx0taAoWLocolB8i/V/fFc4ZnlUmKWCb5Ry1lLv7MpUGj+pHzr5s9pGtHRnGU+g
	D3PnDTTgppL3Y5wHj+vT6evjmBlTTmA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:04 +0200
Subject: [PATCH 14/28] batctl: tcpdump: handle TCP packet with bogus data
 offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-14-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=sven@narfation.org;
 h=from:subject:message-id; bh=rIWxfV5wtiyt+LHhBhZFV2Amuk7UfXaIVhQW3xHIQag=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9hyG5Ta3qXGe54y5/9e08rBNava7emR6b/19pu8u
 9v8O/hDRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiO4UZ/tnmNzvb/9x/yenA
 7bI26ZmzJLxXd0/e7qZilaPzIcaQ/yLDX9GN+TM3T7u/YuHLTSqTTNKWVL99M/9Fl9ss1nXMSwR
 eCPEDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4MV6MQY6KII4XNMKKH2U3E26LPRMAGBQ
X-Message-ID-Hash: 4MV6MQY6KII4XNMKKH2U3E26LPRMAGBQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4MV6MQY6KII4XNMKKH2U3E26LPRMAGBQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

dump_tcp() computes length as (buff_len - ip6_header_len - tcp_header_len),
but the only bounds guard ensures 20 bytes, while doff allows a higher
header length (60 bytes). With a doff of 15 (60 bytes) and only 20 bytes
available in the buffer, the calculation would underflow and show a bugus
length of the TCP payload. For now, set the payload length to zero for such
a packet.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 9c90f36..7769cbf 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -537,18 +537,20 @@ static void dump_tcp(const char ip_string[], unsigned char *packet_buff,
 {
 	uint16_t tcp_header_len;
 	struct tcphdr *tcphdr;
+	size_t tcp_len;
 
 	LEN_CHECK((size_t)buff_len - ip6_header_len,
 		  sizeof(struct tcphdr), "TCP");
 	tcphdr = (struct tcphdr *)(packet_buff + ip6_header_len);
 	tcp_header_len = tcphdr->doff * 4;
+	tcp_len = (size_t)buff_len - ip6_header_len;
 	printf("%s %s.%i > ", ip_string, src_addr, ntohs(tcphdr->source));
 	printf("%s.%i: TCP, Flags [%c%c%c%c%c%c], length %zu\n",
 	       dst_addr, ntohs(tcphdr->dest),
 	       (tcphdr->fin ? 'F' : '.'), (tcphdr->syn ? 'S' : '.'),
 	       (tcphdr->rst ? 'R' : '.'), (tcphdr->psh ? 'P' : '.'),
 	       (tcphdr->ack ? 'A' : '.'), (tcphdr->urg ? 'U' : '.'),
-	       (size_t)buff_len - ip6_header_len - tcp_header_len);
+	       tcp_len > tcp_header_len ? tcp_len - tcp_header_len : 0);
 }
 
 static void dump_udp(const char ip_string[], unsigned char *packet_buff,

-- 
2.47.3

