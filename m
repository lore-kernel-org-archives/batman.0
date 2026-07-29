Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32755C54FCF
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 07:24:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67D4F819F6
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 09:24:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785309879;
 b=04f4NQiUvbX8e+ojYWI80AXyLlJ/0BAeKRE1Nh1Y0E15wy3e+SlSLI/eQqzpcgRCB9GmD
 4q/4VbVtPYjOhhA+V8KKoXnNil1XhQ4Y4fJKeVn7HHWlHnezy0tMC4k73BESuAj0D5m4Tqu
 OFo32zw00dg/oi6hsx4Xb+vj93iorXI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785309879; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dJYdryMPBOhwmk58Ru+hFoH6pyzpeuJVrBYmHhtCAZM=;
 b=CJ5WLfOR+DHHIfD1NXobLGaRVzf7v2xeRI0od/xNPIdYCffUBnbUNJ+qjur8wh9ibA6fE
 V1DWx15f5ZpJCL0Vsjms+fw7vfxBXG2RKVtNK11bKJCX3sxDp+v3vkgegpMA9PuVcEQTejh
 ZTEvDZvodI6+lQrGMj/Vt0nDU6UoodU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9C9B2819B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 09:23:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785309829;
	b=M5zSN/MUlRWAvqIlA1L9faFKlLAuBtmpIpTMLw8NtCGvcGg3Oobg+LIBVn2dMaFGEcYfIM
	8nF+5gng6Z4Bwjp+3UAEiWzLKOslXPGpgZ3qMo93pWswo6r2T0NMy4DpWZpM6pMw5Y5Ec3
	tedWchUVkmYF8oVLk/Lt+iv6RS97y6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785309829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dJYdryMPBOhwmk58Ru+hFoH6pyzpeuJVrBYmHhtCAZM=;
	b=EiHEsZ5yjziPcFAL+VHY0i0GbiSSOs3wt1VzhGCONkONB9BMs1clCpxtVglJlti4KEPf+i
	aPDUuGxAe7IT0/8cDJxsvi+uZrRS55PSAwoa3bn5kGoC2JhZcKbMrnP0Yg3n5pfKPkDZ5W
	U7efJHZYcrdX7/1lNN6GJKcU3QD4+pU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mwbQPh2V;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 368B31FE7E;
	Wed, 29 Jul 2026 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785309825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJYdryMPBOhwmk58Ru+hFoH6pyzpeuJVrBYmHhtCAZM=;
	b=mwbQPh2VgaVqUXKyIkZg647aXVSO9GXmQHUENAJ3OyUnCaTLBZ0ZBPhgrn+6eTMFS5Af0l
	wOGvrh9phAUJlfDtVYtTh06mLhFaSkgzs2fW2hGgkUnS4d7Mv4O2wrkB6Fqz1VR7R5mQWS
	kjHdk2H5DA6K6iNaivRYgbJfJkUVyIQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jul 2026 09:23:28 +0200
Subject: [PATCH 2/2] alfred: fix type of sendto() return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-bugfixes-txrx-warn-v1-2-cf9beb8de0bd@narfation.org>
References: <20260729-bugfixes-txrx-warn-v1-0-cf9beb8de0bd@narfation.org>
In-Reply-To: <20260729-bugfixes-txrx-warn-v1-0-cf9beb8de0bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=694; i=sven@narfation.org;
 h=from:subject:message-id; bh=ejjLsKKSvYXhk2b3qkqTSyiBj5+CdCplPZ3XbTSwiXM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmZqwrD/aw6d+kk7LNc1fIx8Ffk7CtsCyUl9EpnvP7EK
 2Y9+fahjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEtp5m+Cs6JUtExTTwbaZS
 wV7pHsvC15veOsyt/7nTduv+t4HdD4QYGR56hhoGT3g6gy9vie0q8V7RMu7DV/e3Fs63CSi45Kr
 4lAEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LJY25MKGV3SLAIHQJDYSPVJSDT4LNAVJ
X-Message-ID-Hash: LJY25MKGV3SLAIHQJDYSPVJSDT4LNAVJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LJY25MKGV3SLAIHQJDYSPVJSDT4LNAVJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The function sendto is returning -1 on an error and not an errno code. But
since -EPERM is -1, no functional change is expected.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send.c b/send.c
index 8290c98..bd5b9a3 100644
--- a/send.c
+++ b/send.c
@@ -189,7 +189,7 @@ ssize_t send_alfred_packet(struct globals *globals, struct interface *interface,
 		return 0;
 
 	ret = sendto(interface->netsock, buf, length, 0, dest_addr, slen);
-	if (ret == -EPERM) {
+	if (ret == -1) {
 		perror("Error during sent");
 		close(interface->netsock);
 		close(interface->netsock_mcast);

-- 
2.47.3

