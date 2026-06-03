Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411ECD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:35:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC44C843AD
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:35:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780472123;
 b=toeo7rnZ00ezcjLGV686+5yhEc8CTI9WJw6au7jXHRlBi++20YWc6pD9fNWAlZE3kDCSX
 504PcXRXVN2Uxi4cHvqzm3SqP1bQuLAItt36XLX+EIX+UdMDjTvfszxWtMAvdSbD3CEQqpD
 ESck8Vjx4thK/XB+EOpnRuIN47fj8rE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780472123; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=p2P6Y0aH38DpvKQoICwjpsy1mIH384HVW9QTFrseBuE=;
 b=FQJeYoqXYpcI+6hWvcaHS1dqOf4xZjzcPNXpTlURCDiAlFvKNUN+HwTFMHi/txUE9mkMY
 tiQX+F47DhqgUIIlTiTKsdnmBWLDpvT03g+v02uQxvfoDjCmy/pA3Kupoh8YTlI/+a2hC/X
 DtSbkAowYUmQQXElbSI9MF+tfa8Ov3Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B358584692
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471538;
	b=odcbXg8+qdKgbwQtmiBfdbmbTzLlUUYF6aCN3phsSu4niWA8/qXWWQsSy0Lnm+xZrLmXsa
	BOskeBg1eDj4tTmmy6Hyy20UrcNd/Dtd5F4TwYl5hPVSzruiZr2kPBAtpk3qDnqxa+IP4e
	5detfOsIaM9KUPOKlAWjKIOYTx4CbKE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=aYdthSkC;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=p2P6Y0aH38DpvKQoICwjpsy1mIH384HVW9QTFrseBuE=;
	b=l257eS2M83uLTO+NI07E0VUm9Zhbg3HCa3avYEkiNFto4leJayQHeuX85bP+bVIqy6jH5p
	TxBweCb62z7jnos22IA1OZ/mIDa4Ov9nnwSTa7FHhTwNZ4Hfqs3ZAoRej0/l41727bDmPk
	HdlGxPEMaGYXbpZsx+BxKTiQOCcxHGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2P6Y0aH38DpvKQoICwjpsy1mIH384HVW9QTFrseBuE=;
	b=aYdthSkCp8OU051eI2IthHUTCcqmhcBmIZJU0340OdG+cutQ4oVMDcXEiHlWZqfRejOneT
	Bqi+UkEd5hGr3cPSjDH/jabelUOYVSl6JbfKsXooJJ28esAh4ErUhqX0o/pUO4eXcl14T0
	pASwngCUyr3MP7selr8P6U9EHZSztuJuA8UlkFUYGOhbSd9eb+ScVqEhoyZ1zTZnkAPea7
	SPrYRK9LfJ7NCYI1io3WZC3s3Gn0jbBBMbImOSBRok4TqaUlHYBXYB7KbyALOrtgyNiyXc
	5xxkF+vqjxe2tgbuQWjgPUn3Gegz675EgxZ02Mf73pFjVcvTpYmXtKAeOfNgIA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: prevent ELP transmission interval
 underflow
Date: Wed,  3 Jun 2026 09:25:24 +0200
Message-ID: <20260603072527.174487-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: M6LAPYIUGM73RCUSLIAV2FNXTX7JQHVT
X-Message-ID-Hash: M6LAPYIUGM73RCUSLIAV2FNXTX7JQHVT
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M6LAPYIUGM73RCUSLIAV2FNXTX7JQHVT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_v_elp_start_timer() enqeues a delayed work. The time when it starts
is randomly chosen between (elp_interval - BATADV_JITTER) and
(elp_interval + BATADV_JITTER). The configured elp_interval must therefore
be larger or equal to BATADV_JITTER to avoid that it causes an underflow of
the unsigned integer. If this would happen, then a "fast" ELP interval
would turn into a "day long" delay.

At the same time, it must not be larger than the maximum value the variable
can store.

Cc: stable@kernel.org
Fixes: a10800829040 ("batman-adv: Add elp_interval hardif genl configuration")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e5463003a3bd6..1ba206e402733 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -919,9 +919,15 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		u32 elp_interval;
+
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
 
-		WRITE_ONCE(hard_iface->bat_v.elp_interval, nla_get_u32(attr));
+		WRITE_ONCE(hard_iface->bat_v.elp_interval, elp_interval);
 	}
 
 	if (info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {
-- 
2.47.3

