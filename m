Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30579CD3445
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:47:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB04685B83
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:47:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255248;
 b=0MjWIleRhLd3yS/RdyC0jjm4vCn+HSkJLkia9mXiZllDTXUY0GAjDryIDSDcwONEJjvIS
 m755nnpHQipyP5Q9sFoN4b2hCn5kzrbnaAXLmzP6xVR79YyCvgQFbwKNTQwKvIA2rQSVLEX
 L6F+Wdgjtf0Hzs8h/NnGV85UIErjTfc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255248; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6pMZnSJO2Mnt8efjF8Lj1cMux3mlQfMPVNEB5gMc//I=;
 b=cYmxgJgDQ9S/WtJQBnNnH8UTqdZ+BVFOMFytXHb5lvIuYrSdiaXV1ZnXHeGyZQUAOT4f0
 uONAlIVDJKfE0gYoPJApm+6+DFIRkA8JPTF28inLxXhHrUL6IfH5MudX1LLwMCO8EthWtFX
 KIPAxIFwnKCSnGjkCr+o3B8aVjCFNPA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8A13B85AA6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6pMZnSJO2Mnt8efjF8Lj1cMux3mlQfMPVNEB5gMc//I=;
	b=ka00AvQtRbEG0UKGloNjH22ITA1yZH5f1H+2aBh0eJ/f5jzrKpG29sExCRGtgIjgs++WcD
	qWu7fckMZfZdWfgLG/6uFM5clCPpfqxp1D09BrbXMX8iR6QBux5VRPOac3zcT9wtXsrOnL
	HEBjtx/p2yhSQkKNvy0u/3ige+5cgJU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=cSTIkrjC;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255014;
	b=A2UbJov9BMVOfC/qyBLJpWHIY6JX+wW8o0R7q8X2hnP4UABiNjnNUiqg3Ps+m6ImsDQEG7
	LjlM8DtX37XFLgAhu2Ll67LepsHZd/nqn7xHoHlCZlYVElbhVE+9iGtLMzD3VSkgVe2+9L
	eRrgPQAwEYsHqCJ1+HgfNOkVxKqrWf4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pMZnSJO2Mnt8efjF8Lj1cMux3mlQfMPVNEB5gMc//I=;
	b=cSTIkrjCXhyM8rPKb1iPiu73PwKLqh39ZBZem4/HbsUNN/i15tTFBdBdPTSzD+m4BMqq/Z
	BUOU+eWkTmYnMDcdvmyAJ2WkWh7n9N6NK5y9bE+QKFvqbfZHZ+vq11jhr7lnlv5Ep+r9tr
	H1Hw+TCaXqbLI+322Wt7G0vRhHTkp52n1shTXEjkW1xXm44OHPiRxfx8cz6Ux8LD9fVe0F
	yx9eiMPZq1ZJnHIEqlnpWMmiiq7AvfXteVP1Kvo73B7j4vkyxcusNqhBAxdj7IELex+4D8
	Ice7vji+0h/PflnrSUna1WI5nZrRL+4QTuFf2SO1uxR3rpzY3L89lxSKDnevtQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxing Yin <tr0jan@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 2/8] batman-adv: reject new tp_meter sessions during
 teardown
Date: Fri,  8 May 2026 17:43:08 +0200
Message-ID: <20260508154314.12817-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 43FXZRPCSP5USAVE6MHLI2GFHYYG7OYY
X-Message-ID-Hash: 43FXZRPCSP5USAVE6MHLI2GFHYYG7OYY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/43FXZRPCSP5USAVE6MHLI2GFHYYG7OYY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Jiexun Wang <wangjiexun2025@gmail.com>

Prevent tp_meter from starting new sender or receiver sessions after
mesh_state has left BATADV_MESH_ACTIVE.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 2e42f6b348c83..d9a80e459c2e4 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -947,6 +947,13 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+		spin_unlock_bh(&bat_priv->tp_list_lock);
+		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
+					      dst, bat_priv, session_cookie);
+		return;
+	}
+
 	tp_vars = batadv_tp_list_find(bat_priv, dst);
 	if (tp_vars) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
@@ -1329,9 +1336,12 @@ static struct batadv_tp_vars *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out_unlock;
+
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session);
 	if (tp_vars)
@@ -1464,6 +1474,9 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out;
+
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
 
 	switch (icmp->subtype) {
@@ -1478,6 +1491,8 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 			   "Received unknown TP Metric packet type %u\n",
 			   icmp->subtype);
 	}
+
+out:
 	consume_skb(skb);
 }
 
-- 
2.47.3

