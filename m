Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B352ACD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:31:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 63FA78427D
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:31:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052279;
 b=DaJl4scShXEweGoms0BCLTrdp7KR7MUfM8+z3Gc0oXz5JUINLiHZDr85sZEl8ALRg3Wm0
 kkXOFGtRiwmHu8+m2EwwR2BaMUPcB1znKx44PuF/unOnFwReIp9Ked2eIKL0DwPlyec1IMU
 0ykvQuf6bpvq6y/ezk7K626qCySW7Bg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052279; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xfFIHVyRd75M3t1TKpC3QzrIceM9uQzubeg3M2KDdRE=;
 b=aN36Pzh2TK9A38Iq1mM/zBiT5as3mnh23/ZWLdZVTKIEerROyX27wFxicL5CXR1ZMy3IP
 lK4anME+hx8ojiO8zRikXkPpStN56ln/mycJVXREO5u0zP9OQXAR98aJsdsEGXyQz85gTG2
 f20F/BSykSTFcu5QnLIo12X8zkOzV4M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8952481ADF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051901;
	b=1JiR/bCVHD1Y8OJ3i85frPs3bDnqA0X8laGyQMM/0+v+slzpu/6C6nEGVcOffwRXlHyI+e
	ArtJRkLi1SLE/PWkCCNf54kKiq3z9JIp5tNnU1t4Pv2xiBhgyWOMMxZLVLPvNRF0/xlfMe
	2Ic1hZUx8z4C0eXOUYb0ekU/nn+PGEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xfFIHVyRd75M3t1TKpC3QzrIceM9uQzubeg3M2KDdRE=;
	b=Bgi4PyHcJekj5rGjppCXbbP+ZM6WP66V3wsy/zOA3jk9tJbpkCqdvkDtHyQs+/qXIu1DRn
	LCTIZA8nHhvDtygVzBm9I4EmrW3vxzt6A3uJLhhxCjq9B8pZpctzyZBVsVe/NoxRAOS1q8
	IEtHoFGpAbznczLXR3Nze/JHOpZKs8g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=u6qCFYHK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 41F5420059;
	Sun, 21 Jun 2026 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfFIHVyRd75M3t1TKpC3QzrIceM9uQzubeg3M2KDdRE=;
	b=u6qCFYHKvIufU9HABwlkp4bHFfSZY1Glj87EFc2qmFXstw2m2t4a3yc3195GiysVDvCDz9
	zaQjwbdiVhJg0JmKIsFRvtTmKuhvlHkrUAhZMRgqNIxSBCCxLq4ZPCYao14E0LR1WcQsIJ
	gMx8qvy4z6vtS/GGJCR8nO1JLwHFaBA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:23:59 +0200
Subject: [PATCH 09/28] batctl: tcpdump: fix coded packet mac dest mac
 addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-9-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=sven@narfation.org;
 h=from:subject:message-id; bh=KYCLdg6TmqRzVHcjbPGpSALPkjcYGbF77jOev869/mU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX1j5Egwvy+csP6w/O0Lqsema9v1BNuZr2ln+upWtu
 ZO37/61jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEPhoyMlzZ+22tMR/f2blx
 n14JHQpczn+joONfs5hhUqXHxSna3w8w/JX6qiL8XSm3b5pmzuO65etKEjctmfIgMXFDbi6TtN2
 tKGYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JP5HKXNFVN5HSG4BQ5A4FW4VCJPNM2ZL
X-Message-ID-Hash: JP5HKXNFVN5HSG4BQ5A4FW4VCJPNM2ZL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JP5HKXNFVN5HSG4BQ5A4FW4VCJPNM2ZL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

get_name_by_macaddr uses returns shared buffer. The content of the buffer
must therefore be processed first before the next get_name_by_macaddr()
call is performed.

Fixes: 9aae3c9f27b8 ("batctl: tcpdump: Add support for coded packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 3409e59..aced4d3 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1152,9 +1152,10 @@ static void dump_batman_coded(unsigned char *packet_buff, ssize_t buff_len,
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost,
 				   read_opt));
 
-	printf("%s|%s: CODED, ttvn %d|%d, ttl %hhu\n",
+	printf("%s|",
 	       get_name_by_macaddr((struct ether_addr *)coded_packet->first_orig_dest,
-				   read_opt),
+				   read_opt));
+	printf("%s: CODED, ttvn %d|%d, ttl %hhu\n",
 	       get_name_by_macaddr((struct ether_addr *)coded_packet->second_dest,
 				   read_opt),
 	       coded_packet->first_ttvn, coded_packet->second_ttvn,

-- 
2.47.3

