Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B08BC54F51
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 07:25:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8AD478273D
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 09:25:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785309910;
 b=WLl4/ySF4fGScwkaYu511YNMo7uIJwASmmA/PSwKj5UIZEYsKBUg8ecHjp9E5ZJqtSFct
 RQurEDtBGwz1W8G8+iN8LwnNb9i5lBnAkYuG3KRCdGWkNlC48LOUuRxS2JLkZS5NOzRBKgS
 Qu75aV8SSamQh+ZjWAcJja+8VSaS/oM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785309910; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IpFLVMadQGGOpTa/0zotZURv2T9mtiFfjgCzNWahd8M=;
 b=BsvyfdgN8v0qiDiKeblWxGD8tyrmhzOXVRILOuUmOj+TuLfZ3aAhzEmIChs/JGOhX4FVz
 y2OX61SB1n7K6El4AqKjoD6gwxJnukaAQlqNDJqrE0/DgPMPvhhX4NB9cddXXlEdJdqZPa2
 6IE2xoljkO7m73r8YW5EjUrGO4dKN/I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0E46681ECC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 09:23:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785309833;
	b=vewM6Vz0UfIMIAB6M/vG5bPddOB+z4DPGeKXdeNlKTmdeyTKdH01uPh45Jtmht7w8gFlmk
	cVqjX+XLRXO0ojm8ucmilZKIE1C6Fj4o6xb5kMh6ZbqtIN4gP5y5s3sVJfBi74PBr4Ujsk
	faHZYBusfyxNBfT1rEMdomu/wcc0u70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785309833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IpFLVMadQGGOpTa/0zotZURv2T9mtiFfjgCzNWahd8M=;
	b=ni/ZZtIG5ro5Dj0TtCHkMYV1QU5lFO0Cc30t1EuYhJNF6KL1utlvH618yAe2ONQ+PqKl8w
	gewDEz0xmzSSxDy8XhwhYRsbY/dc84uuj38RNOHIsg4r+8Lgt7GLus/MPiGmoNu5dubyI4
	avYqybPkH2YlhM1sHs9fglihdygXWR8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=g7TlLvFl;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7BA46200C4;
	Wed, 29 Jul 2026 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785309818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpFLVMadQGGOpTa/0zotZURv2T9mtiFfjgCzNWahd8M=;
	b=g7TlLvFlMzVt/0pHML7i1lzBZodS3b6jqoxjunVM8Gvu09RON9sNlPDBZdQKpI/rOMXqjY
	GLdV4QdKOSNohfD42+F503xlSrrDq8mVUxvzXOj/bG4u8lgzg/0brZl6jWz0ftok1gw1J5
	1AzbmdnBxXUvpyVGccoSnYZfI+2rZcE=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jul 2026 09:23:27 +0200
Subject: [PATCH 1/2] alfred: don't treat empty datagrams as a socket read
 error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-bugfixes-txrx-warn-v1-1-cf9beb8de0bd@narfation.org>
References: <20260729-bugfixes-txrx-warn-v1-0-cf9beb8de0bd@narfation.org>
In-Reply-To: <20260729-bugfixes-txrx-warn-v1-0-cf9beb8de0bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=sven@narfation.org;
 h=from:subject:message-id; bh=odvOqpLDO5ismjleIZ6U/wDw1auEOn2jJ7KNlH9SER0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmZqwpYF/DPvPNr4j6nTdXm0z9dmXIk/ceLprJHdc73z
 K0V5qrzdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmwl3IyNAelC3r9enryt0B
 uSblcrLM9753XqhaIjdZPFtK7n9Z6C9GhoPnVjunPU/7ldu10m/vXZ+dXo9TzT9/e3hSZY1ouhL
 nFz4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HCDXIOE3S6UFJTQ6K2M5JPKJIJQ4WRB7
X-Message-ID-Hash: HCDXIOE3S6UFJTQ6K2M5JPKJIJQ4WRB7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HCDXIOE3S6UFJTQ6K2M5JPKJIJQ4WRB7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

recvfrom() on the UDP netsock returns 0 for a validly received zero-length
datagram, which is not an error condition. In this case, it is not
necessary to print "read from network socket failed". zero-length packets
will be handled later when checking for the minimal size of a packet.

Fixes: 23359bbf72aa ("alfred: initial commit")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recv.c b/recv.c
index 76bfb30..7d4e147 100644
--- a/recv.c
+++ b/recv.c
@@ -403,7 +403,7 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 
 	length = recvfrom(recv_sock, buf, sizeof(buf), 0,
 			  (struct sockaddr *)source, &sourcelen);
-	if (length <= 0) {
+	if (length < 0) {
 		perror("read from network socket failed");
 		return -1;
 	}

-- 
2.47.3

