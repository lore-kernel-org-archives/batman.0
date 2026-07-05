Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E974C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 17:32:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1D20F83E4C
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 19:32:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783272764;
 b=simelLAOZMAGqg7Crbu+NbFENVQaKxo9GwG8Slj4CXWHPKb09HbEAgxGsio3n0ch8EymP
 oPKHyFJTaUdh5GfmkXj5NeoUG2Dc5VgfPktGzYJm2I3bsQlE0dtMl/eji216YKVMVwRKyrH
 7w7u6wXeaXeSjJLLUGmQY/0MZQxe8lQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783272764; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fSv2VWEzh7vbMyoZq8qUziP64axAYnTpZQ3barC72mc=;
 b=nRbeIm3EKt84hO2HuvBMzDm8LxD3RnfDetUyLwlC9P/41y4bCrEfFn8s7NrDVM/0QcduG
 wviguf3YKO44ghkiO5evcZCFXYj3z+Hq23eEbV1VwTT+IMagC99ZgimBsGFpEyT9ENaOA4h
 dk9gHrqa7MXiDYWBW7FQ/g5f0UkleS0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B59828239D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 19:30:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783272616;
	b=uiWwr/fbNvfkkaZl8ozuIdcOGasKvE78v6xWijUYODailittvwQhD6Rm6uafj65RVtMiiS
	704tMNiZtMRWMTxcbMfx8jQ5oIdNH1RtCOkSRXtkW76Gnpx6dwSX+tZhmn+nT+1KZEh0eU
	Vh9titGDPqffb9xN1YUZecla3IQPP2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783272616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fSv2VWEzh7vbMyoZq8qUziP64axAYnTpZQ3barC72mc=;
	b=mHWfamQm9IR6v+m+46/LVqvUA1+/PEMhkZsZ/Qgjxy2jasdM8WEPsWcSFpQJBqfBsQY1nC
	JKx9exsH22qWqfvJl/hwdhxIil2HSAMHug3L8gTJjR/JSz6TvoQl4F/UxLR7c78TR/vgPY
	vws41DumTjNNX10PsbN8P917bKpEr2Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UUWkwXEF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4540D1FEE6;
	Sun, 05 Jul 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783272616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSv2VWEzh7vbMyoZq8qUziP64axAYnTpZQ3barC72mc=;
	b=UUWkwXEFWTlrdOyguYeQyyIyfTKfBB+YRiMm4kHOVJHQ8uLWfJLjEU1NKE2J/bzZcI6IzT
	kBrIRLxVoARz/GmIs9UIE8HmUmDu6QQYhb1f1HaIKliDUvO5d7rtyIk3FRb8cxt/p0fv4Y
	7WtHmtEtVGdSVuzCkWpygK/pti35TaM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 19:30:06 +0200
Subject: [PATCH 3/9] batctl: tcpdump: check frame length before reading the
 ethernet header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-bugfixes-tcpdump-v1-3-c37f6f82eed1@narfation.org>
References: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
In-Reply-To: <20260705-bugfixes-tcpdump-v1-0-c37f6f82eed1@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=sven@narfation.org;
 h=from:subject:message-id; bh=8divBEm/68qu6UVcvbQAVMQ2fAUl+Bjg26AvC7RdgQQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleU+ZdrVma5blkjrRB0btVTtx3T+86didkl3bOrdwGq
 bX20+Ye7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZMsNhn9KIpMWTP34YSHv
 r5O98tUuqs0msrdOH8gITn5QN4OlNSKZkeHErFXnHBL3NHFwqKaaS315mdHKdWtRW5FKuL7Mo/v
 CU7kB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GIHCIQ37JCAYFDIZUNRQBJOGVSLRXMV6
X-Message-ID-Hash: GIHCIQ37JCAYFDIZUNRQBJOGVSLRXMV6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GIHCIQ37JCAYFDIZUNRQBJOGVSLRXMV6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

parse_eth_hdr() reads ether_type without checking that the buffer actually
contains a complete ethernet header. Use an header length check like in all
other functions.

Fixes: 3bdfc388e74b ("implement simple tcpdump, first only batman packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index 33b7226..b6305fd 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1200,6 +1200,8 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len,
 	struct batadv_ogm_packet *batman_ogm_packet;
 	struct ether_header *eth_hdr;
 
+	LEN_CHECK(buff_len, sizeof(*eth_hdr), "ETH HEADER");
+
 	eth_hdr = (struct ether_header *)packet_buff;
 
 	switch (ntohs(eth_hdr->ether_type)) {

-- 
2.47.3

