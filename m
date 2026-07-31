Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1259DC54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:45:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2E1C8403B
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 08:45:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785480329;
 b=an5q7c28WfPlcyqG6AFvG7pWFa1IBXD9AGqk6qlvvdvn0fI9UEOcEu6e43nKmpsayQL9k
 efhKtrRU9axIDNt/XlXkNLN6YOGViOsALAV8V2KJBrFqav4G+aRKRZtzF9uDCWnqVnTYPXY
 rtAv8w2UPyRKXHUQxVbq+Cz0a/Hzb0A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785480329; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PxJjSntzOjOqomEFItvrhxrhxVS/uvQuBLNNk7q08W0=;
 b=14fstu46CsHn8qdXXEr/PEZiIVeYfeYFwc/aDHFnXlN/W3Ogml15v4OoP6OW3aBuyGZn3
 V3y1o5a5tSYl/TdX4nilTyYx7MYoEJE2e1JwlR7j3xe2vaB+gsjxzC966Od8uQhiiLm0Ieu
 YQfX+uG8OcZ0oP4lWO/klXPDC0jI6XU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3A9B482003
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 08:44:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785480281;
	b=l/G1Sd4VbKUmdhtl0VOybQU/rvfiFGn/DFOITMBIEOVlf5M7Hdr3BwSnANWy/IamQ4mttU
	OdFsNpxNomxsnkk/g0e92M5yofZY5+8cMdadpkws6wEpBXnuOHUeGxxSPCp7IVHkjQUZxb
	1Oe5VfYbB+qdFuKp/wIyCSxP3Ul+ogA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785480281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PxJjSntzOjOqomEFItvrhxrhxVS/uvQuBLNNk7q08W0=;
	b=R+oN+UxBnvu94j+5Ru3V/O5wJGrV8ME0tcRVJMV3q8SebqL8adKyi710S3A/CgJbxxoM9a
	QyCaTw9Pn28yH1CmntzvejrneigweTsHOSmVfk81jTX29oraIkvV6b5aKI408l1lGikRSd
	rsADFqR9Y//R8STBHymzt/mhatcRBNI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CtL9UqAO;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9589120CD9;
	Fri, 31 Jul 2026 06:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785480276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxJjSntzOjOqomEFItvrhxrhxVS/uvQuBLNNk7q08W0=;
	b=CtL9UqAOTx9JNSLJrSSnmFP0uOCKTEEh2oG6ZbGzrLxXGWqsL+kHfB6Twg2IYPIewZQuJg
	MiaFb6+HNxesfP38UdgIfZM1QCf6grzW7bzOhToNkKVvJTvtOtHm2DyBG3Ch16EKMkvPud
	oYl7fSddMlbcPfENgrJXlZsboWysu1U=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 08:44:20 +0200
Subject: [PATCH 2/3] alfred: dlose the client socket on unix_sock_req_data
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-bugfixes-leaks-v1-2-19e1cd3e7fd2@narfation.org>
References: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
In-Reply-To: <20260731-bugfixes-leaks-v1-0-19e1cd3e7fd2@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=sven@narfation.org;
 h=from:subject:message-id; bh=Hm9X7ImRs/wYC4VdfbB3zKLFL5lMiuyRdyxAF8AbUgY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5Lq4vT/oIrvpavHPXjdUbtd7M3Wd0eskZ6d9Lotvt/
 tyYrVLA2VHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYSMUXhn/aJ1OcFr9Zqc66
 MfCajnyH+izBGBPOXX57T3rYHf04IWUvwz/VK5MSE8z3PFXNCopM5BE5XlcyyzhyifZ/rpPFPi0
 xRkwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MFPDJWUSN24NEWFIH52MFDHWBSFRV6H5
X-Message-ID-Hash: MFPDJWUSN24NEWFIH52MFDHWBSFRV6H5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MFPDJWUSN24NEWFIH52MFDHWBSFRV6H5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

By the time unix_sock_req_data() runs, the accepted client socket has
already been detached from its struct unix_client and removed from the
epoll set; each request handler owns the fd and is expected to close it on
every exit path. Two error returns did not: a request whose header.length
differs from the expected size, and a failed transaction_add(). Both
returned -1 without closing client_sock, leaking one file descriptor each.

Fixes: 5b8c4d4ad44f ("alfred: Don't block server when waiting for master reply")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unix_sock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/unix_sock.c b/unix_sock.c
index 07552a2..b93feb3 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -263,7 +263,7 @@ static int unix_sock_req_data(struct globals *globals,
 	len = ntohs(request->header.length);
 
 	if (len != (sizeof(*request) - sizeof(request->header)))
-		return -1;
+		goto err;
 
 	id = ntohs(request->tx_id);
 
@@ -281,7 +281,7 @@ static int unix_sock_req_data(struct globals *globals,
 
 	head = transaction_add(globals, globals->best_server->hwaddr, id);
 	if (!head)
-		return -1;
+		goto err;
 
 	head->client_socket = client_sock;
 	head->requested_type = request->requested_type;
@@ -290,6 +290,9 @@ static int unix_sock_req_data(struct globals *globals,
 			   request, sizeof(*request));
 
 	return 0;
+err:
+	close(client_sock);
+	return -1;
 }
 
 int unix_sock_req_data_finish(struct globals *globals,

-- 
2.47.3

