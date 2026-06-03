Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B473CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:30:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4AAAE8040B
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:30:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780471806;
 b=l7tF/DPDNNU9FGpzIX/MX5/r43sv8+Ype+No8jCgBnoo4WlcRNQZmd4ldYu1MP7bQMx8y
 H5Pl9NYhSQF/uPYxu2zSG/nqobOmURC+pRwO9plSfGj0p37g0+IbDE9z7zPK2OhRZY/La14
 ABMa381Lcah8FHwxTWQrNElo4avEJS0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780471806; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DNPt4ar3dn4CAbmsfhCbcgmKlApMaNd5nDAF3TibFV4=;
 b=Ib3jZvDbNgeXTfi6DF/JsTXCqTznIUlgNOfFHI40xDMSSro4iz+bbMtV2xKa3V3Zblb6B
 Ki8AuT+hQCpeeYvHLlJQQUk6EsRiXK4YallAPdik8DYRdZ6tr735LOW26d8UAyDv5gnloLx
 RPRFTPV3rfRX2xqZC4De2joJG7pSFgA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1C8F6818C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471534;
	b=ARmyb4MZjOoEu9iO+8kt/Ri5D3sNHOpWM4GD/9wzLWSsLgtFOZf9qZOfl5/PKazWOs2miT
	uwaYQiaOs4/kP0xktepCLWHvkEZEiMKDycMb5FnO53oYFq4cezEFxa7SL9rRr0K8YJUZSW
	Rm8tHhUnG+wNyQrDi+UJWKQlgDy9xL4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=OaLCIkh+;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DNPt4ar3dn4CAbmsfhCbcgmKlApMaNd5nDAF3TibFV4=;
	b=IEjnKvieTCNlw+RyEg7F16QzPeKmnPzOSjAjOMEyki8E0PiUF0sCqWuqUvMjfsQ7/RyzES
	xSpb79yfDTGUqdulFfweOH6b76A52l7jmFIozswbvGKKnDY7/kFVp+QWDYFFWhUZ7Jb2CI
	un14tJykR3sE0esi54LxuLxrXlJo6z8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNPt4ar3dn4CAbmsfhCbcgmKlApMaNd5nDAF3TibFV4=;
	b=OaLCIkh+HwYBqXAwOP37DN506EdhBTARq5qsH6XjQiw5qdhRNQTNamEdWgvif63IyMWqhT
	HwVqmRFULX9O2MacuVfL8UuZQhe4fk9vfIxK0YgkSrX4u/qU0mr+qE3l20RlixIufAGD75
	IykulebofzGoOw3vjaeahHsoRac2GvMnM8rRYFVH/0Z1yCqZ2H3zX81SCNUqBSElD5mn7Z
	S/zF7MVLa/Nr8j+Ol8/qGHozCS8Fd8ayt5MVsQO1KrtbSu0Vl7mnkGqLu+kJ8bu76qdbPB
	bPxbqHnHqUbNh1LniJoMlDkwQ8zrHdleNdfm9jD8+i4JrweJ2VpAEtVMRuYUOw==
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
Subject: [PATCH net-next 06/15] batman-adv: tp_meter: fix fast recovery
 precondition
Date: Wed,  3 Jun 2026 09:25:17 +0200
Message-ID: <20260603072527.174487-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RNKJDMKM34O2BP5WONFWKL3RAM5NG27J
X-Message-ID-Hash: RNKJDMKM34O2BP5WONFWKL3RAM5NG27J
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RNKJDMKM34O2BP5WONFWKL3RAM5NG27J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The fast recovery precondition checks if the recover (initialized to
BATADV_TP_FIRST_SEQ) is bigger than the received ack. But since recover is
only updated when this check is successful, it will never enter the fast
recovery mode.

According to RFC6582 Section 3.2 step 2, the check should actually be
different:

> When the third duplicate ACK is received, the TCP sender first
> checks the value of recover to see if the Cumulative
> Acknowledgment field covers more than recover

The precondition must therefore check if recover is smaller than the
received ack - basically swapping the operands of the current check.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 1655f181c9293..ae6acbc60c8ed 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (tp_vars->recover >= recv_ack)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

