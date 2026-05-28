Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CADCD6E44
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 14:33:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8D45E841D2
	for <batman-adv@archiver.kernel.org>; Thu, 28 May 2026 16:33:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779978817;
 b=UrQoOUv5/Tq+mp9blcI9Q8PhjNVkFB/KR9tLFH1v9reRTdQCiC/uBUGXm91jLaF4SbR+L
 yAFmoEHghJmIwjEp0vi7gmH6pbMbpJ8eAMvLK0S9yh3gOlZneU3fHSy+gsOcYtV3PLNHVQW
 E6Awc5zGOMQh6uvU5FhvdwUMK87h3GY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779978817; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Oh7Iga6kezW1PnsL9zoSfhgAn0KI160ZKJycdSegy3U=;
 b=0h8DgmxbpRylCBtlWomeWWDaUIn26pknMWv99PxWnx0pKPeeiBL6aYAz3taTAavS9Dx1y
 dwyecIgzqdyCaqSgMqstAqhJpQd57qyiqRhFxvAP8P0iB8UpSFnbWXolyJ9dP8NBkmhcx4a
 tu3jWS5mTj3jC2snKIi3apZc+4XTBIU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 31DBD83BB6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 May 2026 16:29:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779978571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Oh7Iga6kezW1PnsL9zoSfhgAn0KI160ZKJycdSegy3U=;
	b=xU0eXlevHOxJJrDfJjaBajtXqwX9dG4U27rZ3mZKin4YYCiwnR+3wJ4RyFIG+kM/nkZ3GG
	pAIjQvOxU8VqFkgDtoLpNn8cpleHPakr8mk6Ca+V9hsiDjuF7HawXnX8acQwDbJBbFPzDN
	Zdv9IQtsLvAaoXai/w8bJh8Ypqbh0+c=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779978571;
	b=mZR2PSzkU50grqpmVM/IV6xXabPBPgPx6hC+p0iyG6ZOe4qfUCzEZTA2LBpfIo8WHW3LAU
	XhqgKxLjk7jXU90DVnvdMD056+CQCBzs/Qbon5xsz/JH8RfuczK4LjyE/LTsgIpVJQIbMr
	4JyYMO9ktN+l/F+Wutrsn+GRgL5LnTk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Ej6rbXPT;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779978570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh7Iga6kezW1PnsL9zoSfhgAn0KI160ZKJycdSegy3U=;
	b=Ej6rbXPTxWnk5kZ8kRsr2s/otAH03O+tGZgDwFdEEXyPmQeC7/lewDRKRHLVpmdsK/ldWI
	J/xxzcfxjqXTb3HQY6Pd4vccesXVG9aAm78aqUKcVZQwJYc5PgcPyRCJ/e728NNsWb0iWR
	g8zxqALgFkODfPg6P27gCWJfPAMEhjhWEieZ7LYV2azwrQp3J+pP8evfCGzv+jxdO4pfK4
	0R1jOpjm162ywra6RqZKThOOI0ueQ1qjdOJ+GXUIog7wWzijh3YQ72dJAbS/SItrsVM+NY
	sLC+qLTIcLdQZao0xfd8LBHvLnWNz1tRf3tkUQkqfAZQ/FK+RouAsc2blm3hzg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 05/15] batman-adv: use atomic_xchg() for gw.reselect
 check
Date: Thu, 28 May 2026 16:29:14 +0200
Message-ID: <20260528142924.329658-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528142924.329658-1-sw@simonwunderlich.de>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LEENVQS4DANIVFCKWFYFFFHKT3R4OH5G
X-Message-ID-Hash: LEENVQS4DANIVFCKWFYFFFHKT3R4OH5G
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LEENVQS4DANIVFCKWFYFFFHKT3R4OH5G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_gw_election() only needs to test whether gw.reselect was set and
clear it afterwards. Replace the batadv_atomic_dec_not_zero()
[atomic_add_unless(..., -1, 0)] call with atomic_xchg(..., 0) to simplify
the logic and make the intent more explicit.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index ec743ce39be47..026627c8ba45b 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -211,7 +211,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	if (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr_gw)
+	if (atomic_xchg(&bat_priv->gw.reselect, 0) == 0 && curr_gw)
 		goto out;
 
 	/* if gw.reselect is set to 1 it means that a previous call to
-- 
2.47.3

