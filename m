Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7855CD37BE
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 17:32:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5A81885A9A
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 19:32:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778520726;
 b=F2qb/VQFdHjqQuE8PT8tARncpEkLsHfFj8hnUoXjub+MqkcC11zqcS1CS3Mn+KXNfqRac
 ETgod/e0a7PZI3iQGZ64aS0UBXbz0GoXD5RF8AW0ztkDcndZ6PAzbhg4KtF7PE3sBCyP250
 b+ZgN5zQ6KAfZfI3cCA0fFYhJYiQN1Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778520726; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3OvGm4xhcF7+HztPj/kSKQhzpN6xNesOVrGxZcXnlro=;
 b=g9U73nfSsHJ6fZYoATSguMwhlLAvviIj4ZC4B/6Ki4kJlgpqHdhNhPurD4l8OLmn/HeV5
 /GOTp7gi7dpLqBqPRi39xZKJdJC3ok2JVCCxWhkjkaxJgnFcL9H3JZx/CElAiAcyV/fDALI
 mjka+w8MqCNzZD/ES04ObScmM+rBDfs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1D2B4853E0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 19:30:13 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778520613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3OvGm4xhcF7+HztPj/kSKQhzpN6xNesOVrGxZcXnlro=;
	b=I0a1iPo2gNDg3P0lpgs7NfAi7JvSRZ4EkIVXZMMiKaF8WCSYgLOSMnDGCbSrz+F1bHKOM1
	4yczQ1izn2FeXdlk2mXBzuNZLk5GaxjwX6imJrqqaf3RAYi8CDXSc1GkW2lkCoXl2EE2++
	sooiRtlUE/UIOFtdQzkU6SXUTE9HdoQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=x6Q0rvx9;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778520613;
	b=kl9YNaM6pSAkeopyXobbcjomz3FE1+BqS+LcZO9IjgkJ4nz0Yejv2PgjtC0X8aStSmfWif
	NkslP6RpB3Ewx+eMNkxZWGTpnpAXO+xt2gFhGOqlfyCbYOWOJvTc+sJ5vclF9e0+NciwJ0
	85ROole1DMxareqklJyTwOEvyIw6/dg=
Received: by dvalin.narfation.org (Postfix) id BE78121977;
	Mon, 11 May 2026 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778520612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OvGm4xhcF7+HztPj/kSKQhzpN6xNesOVrGxZcXnlro=;
	b=x6Q0rvx9LBlXJWwMAVaypmwxgLWkucGtY4Eiu7Co+Itf0bGjRahzJuFheoEthghkmcPCuM
	Gin1W3Ixvf+LAifDO+qNdpTFMhAP423H+mw1SWtJSDZ21iNTKXrvprX7P78P9haDZBizH7
	I6cct6adRM0h1K4pDgPm3q3WbO2nULo=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 May 2026 19:30:00 +0200
Subject: [PATCH batadv 2/5] batman-adv: tp_meter: avoid use of uninit
 sender vars in recv_ack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-yuantan098-bugfixes-v1-2-6adf6965f2b3@narfation.org>
References: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
In-Reply-To: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=sven@narfation.org;
 h=from:subject:message-id; bh=aY4mfR+K1VRxFYYx44eBTsmzkT8oCkrF3dGavh9KqrY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlMQlIqmSlFP2WytJZzyig/vXPMf6Lh9qa4NwuEfdIML
 m2PUo3oKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEzkoRDDP1P3Sf1bCiukLdtk
 F/ZEnWeu0dvWfbBaNPtS058rEXtmvmRkaD99/l3VpKvT/sYwMQTf75yT8uVHtFiVO0/ealXGbWt
 n8gMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FKUSLKFANZE3A2E3J3VTEABRS5BU2XVW
X-Message-ID-Hash: FKUSLKFANZE3A2E3J3VTEABRS5BU2XVW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FKUSLKFANZE3A2E3J3VTEABRS5BU2XVW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tp_recv_ack() is only valid for tp_vars in the BATADV_TP_SENDER
role. When called with a BATADV_TP_RECEIVER role, it proceeds to read
sender-only members that were never initialized, leading to undefined
behavior.

This can be triggered when a node that is currently acting as a receiver in
an ongoing tp_meter session receives a malicious ACK packet.

Guard against this by checking tp_vars->role immediately after the
lookup and bailing out if it is not BATADV_TP_SENDER, before any of
those members are accessed.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 759ae923..84af22fa 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -664,6 +664,9 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(!tp_vars))
 		return;
 
+	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
+		goto out;
+
 	if (unlikely(atomic_read(&tp_vars->sending) == 0))
 		goto out;
 

-- 
2.47.3

