Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1149ECD343F
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:05:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9AC4085E89
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:05:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839541;
 b=0tQ0vsoolW3qhtCNQJvWhJrRDFpaCvYXcbwVIdi9DFJdP5VAGVKlyxVekVjNl0XWuMCSR
 tDV4Tw5j65qnA8Vpvzii5WJy7IyLH4iMA6xY7NbSEgXt55zL9FmhvyNGFu+qt92Yw583mN/
 WriHG2JiAl0aipVD8ybQpipRhZreEjM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839541; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0K7x5d0HnCXiyQuckQHY2w5gbSJ9qlIcYYGqaA5h0nI=;
 b=a6UzT0XibBESdKfv4HqA6oRc1o3Sl6DPq8MRiA0UhiwSo71wHM1BavNZFJ4r2+xhxvfqs
 g9isVJbObuFRSaUCAS64hqhITCHEj1kWM5wuQNVShFNa/Uep0Ul46X/XeKu/ZACO9tQcSsJ
 EEeE0LxQGn21LtxSTBChGLGGuKwKxFA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 106AC853C1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0K7x5d0HnCXiyQuckQHY2w5gbSJ9qlIcYYGqaA5h0nI=;
	b=YDk+54zhMz9cAOO0Qkyr4uuMHiow9362h6/Se85WReTySGdTF86cfUHEPKY44mar5ssbKt
	SoAd2waxTY+clU6Ifc0mCJUhZupG74in5qJaA7snjUSYb1O61flMKF3pUFjpUQuq2ooM6f
	6zMXxMgQqP3CdPL53lS8GpiSV2Dylvs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=fpyH5y9D;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838958;
	b=CShbiKn9jCkCCfkLLR+e1O81qgY79w8938Eq7oEMlnwXZiipVoDHHWIEm0c87Iy4KEA7bi
	347jG/IYIJrs2c5etQ+hsliiq46nl+CyTWmja71dsDghCJ59MG3QfF+OocRJTGUrHiZhcU
	lWO8L6MMCuJzcNF50kva4MIHscx4w5s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K7x5d0HnCXiyQuckQHY2w5gbSJ9qlIcYYGqaA5h0nI=;
	b=fpyH5y9DbZs5JfNlSpeKGgKA2yCoiAbOeeN5N2PCbKsRBxeizRQiCDCpPSYalLVcP90Kso
	eCxoEKiaQ8YNA8Fqssh0su02bqCEv/k4OlBYha/y0Xod3PoS2gmX36+bCkYcJcoXetJVHG
	QrU3/PSESha0H7I5xnFkUT8hlBuGsYt31P7v83FqEvUZnLH7U4eUqdxMxnXMaX7qhgWjDo
	RE0Qt4ffIBtxbiHRqeRYxQ0WMA2d15MQMoTh1CYHUSg43ac/I0FHtKhbaE1WwnbnWXgV+V
	FdaApkO86eamjjOvH5cWtyGC5jtxAx0+JMW/LcLBYWN4yX2SMu8QLf6ZYd9nsw==
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
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 12/14] batman-adv: tp_meter: avoid use of uninit sender
 vars
Date: Fri, 15 May 2026 11:55:37 +0200
Message-ID: <20260515095540.325586-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QBYJTUYH3O55I3S54ZSF6HED7IMRUSMV
X-Message-ID-Hash: QBYJTUYH3O55I3S54ZSF6HED7IMRUSMV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QBYJTUYH3O55I3S54ZSF6HED7IMRUSMV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

batadv_tp_recv_ack() and batadv_tp_stop() are only valid for tp_vars in the
BATADV_TP_SENDER role. When called with a BATADV_TP_RECEIVER role, it
proceeds to read sender-only members that were never initialized, leading
to undefined behavior.

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
Reviewed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ca6c3f6374bc5..a3593d104caa5 100644
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
 
@@ -1101,12 +1104,16 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!tp_vars) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: trying to interrupt an already over connection\n");
-		goto out;
+		goto out_put_orig_node;
 	}
 
+	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
+		goto out_put_tp_vars;
+
 	batadv_tp_sender_shutdown(tp_vars, return_value);
+out_put_tp_vars:
 	batadv_tp_vars_put(tp_vars);
-out:
+out_put_orig_node:
 	batadv_orig_node_put(orig_node);
 }
 
-- 
2.47.3

