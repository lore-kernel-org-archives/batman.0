Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B09C43458
	for <batman-adv@archiver.kernel.org>; Mon,  6 Jul 2026 18:09:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6E3BA83F73
	for <batman-adv@archiver.kernel.org>; Mon, 06 Jul 2026 20:09:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783361346;
 b=0iDwU9dRQHvVcEdhUHGCvsd6UTIcJnlyoUT8CDaAljdloTNFOrMgRJg2Gfx6tcDLhFXo2
 OyyoBaqGT3QnzvNjSvzFgRrOKDg206vzvUhujRi4+hPSt9dSlRXW8C5c3Z+2INlfzifTTIt
 vQvfS7D+qhYtckWS76g+bptDVcyv290=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783361346; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+zXgTP4EoRuyMLfnSNaac8+SrcqdEtr5jQ86S+RKK6g=;
 b=eztX1g1AZHoS5G7boCfCsjFe0pELy8OnSWfvu5nIqdKePSYqrniAZooB6SYhDhOKonSRm
 QAVFyt7H0UXFRM5wLaE9xTxprqBl7gfionqoIz+HX1WS+xlQ2WvvbHGgRPWZ0Rzpz3po+A8
 NcDRX8XIdecsQNv5W9NcUgPXIukJUJc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C95F3818CD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 06 Jul 2026 20:08:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783361334;
	b=3GSo1GYY143ChWxQ1AKHueVrHFEi5WjbWvQiATAjOIsBpuenHcpFe+FryrKY5Ba09tm2Ck
	DTw8nxgznYIPTJVREmcFKUzGQe02EoqGloQgvwooLXAouc7ijVcPqt8bXtTcc8PH03Fx3H
	m0j/Mr7lxKCOEZW8OcQkF382wx/4DDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783361334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=+zXgTP4EoRuyMLfnSNaac8+SrcqdEtr5jQ86S+RKK6g=;
	b=wTHljXwq1zt0+vtrrOPCf9spj1p9o9IYVgmvGOaki9NP3VIbhVrvWQFEBx88Lw/8yFFUvt
	NEJ5PJK+v3Nj+6hO87/tQo8fazCUFs7ZNIETBDV1l7/dWAgMIfGqe68WXTPBw8jhSx44qV
	/K9QVe/gB4Ju20ctefAd4WYrgHaxl0k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FuFemNrh;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2E45E2026A;
	Mon, 06 Jul 2026 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783361323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+zXgTP4EoRuyMLfnSNaac8+SrcqdEtr5jQ86S+RKK6g=;
	b=FuFemNrhfcugXKJJOkSYlV0D2K1PrtFmney+Jxzmpc30S4ODc39CnWeL2Xkm3eep+jYCkT
	SFrFM/oKLF8OJclhTl7uITe3fDDO79vlH5X22eKZ1DtrCJgJ5K+3bkgpSvPfGGcHfp/Qtc
	Tel6aBiEHq9xxI4a6nBvrLlPcqvzL2E=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Jul 2026 20:08:35 +0200
Subject: [PATCH batadv] batman-adv: dat: avoid unaligned fault in IP
 extraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-dat-unaligned-ip-access-v1-1-c86e560cc47b@narfation.org>
X-B4-Tracking: v=1; b=H4sIACLvS2oC/yWMQQrCMBAAv1L27EIMklS/Ih42yVpXJJZsWgqlf
 ze2xxmYWUG5CCvcuhUKz6LyzQ3Opw7ii/LAKKkxWGOd8cZhoopTpo8MmRPKiBQjq6IPV2+od73
 lC7R6LPyUZT/fIVClNMPj8DqFN8f638K2/QCkjrUwgwAAAA==
X-Change-ID: 20260706-dat-unaligned-ip-access-7b970a8682e4
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=sven@narfation.org;
 h=from:subject:message-id; bh=7Q4XpOSOK0NVaVHJL4NTCrfHSr5zfJJmdvjlPFDD4gI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFne71W4i3tUn0XkuFzdoWnxImDz5q0/z+tlHf9XZRm1b
 I9x4dGvHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJcBQwMmxvCl09w6M1JevE
 6U9HDil9Xyww3aH+J6/t2lO39tT+Y1Bn+GedYvlEgEm3/cFNdU3BtvMxlZ5he4070zSm7u6+eP2
 QJwcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HIB7KI2GUCMP6EQWGHMQBDOLDKQI6IDJ
X-Message-ID-Hash: HIB7KI2GUCMP6EQWGHMQBDOLDKQI6IDJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HIB7KI2GUCMP6EQWGHMQBDOLDKQI6IDJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Independent of the alignment of the ARP packet in the SKB, either the
batadv_arp_ip_src or the batadv_arp_ip_dst will have an unaligned access
(on HW without native unaligned read support).

Use get_unaligned() to handle this properly on all architectures.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 0591c25abca9 ("batman-adv: Distributed ARP Table - add ARP parsing functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a5c9b6d0..9e48077a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -316,7 +316,10 @@ static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
  */
 static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
 {
-	return *(__force __be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
+	u8 *src = batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN;
+	__be32 *ip = (__force __be32 *)src;
+
+	return get_unaligned(ip);
 }
 
 /**
@@ -341,8 +344,9 @@ static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
 static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 {
 	u8 *dst = batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4;
+	__be32 *ip = (__force __be32 *)dst;
 
-	return *(__force __be32 *)dst;
+	return get_unaligned(ip);
 }
 
 /**

---
base-commit: e281f6726677f7e8950dad1640d5386867e6d2e6
change-id: 20260706-dat-unaligned-ip-access-7b970a8682e4

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

