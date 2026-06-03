Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9729DCD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 07:30:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1624783B11
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 09:30:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780471849;
 b=PNpG0SSScjcBzjE0AjCfqbIbIVP8OCq9hATuwbrfMLYXobBXBB6U3ZHkL2IBlggWAMUGH
 llpGsJs98IHctETdiSm7lERGAPoFYUUNyzIlsra5/PYP+6bc6E+uBX67F7YxKv6HTp83ZpS
 yJKIKfHq6iRbhmVraS3/oW3xEWUHr+Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780471849; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WDF86/s12Hcq7URPeYXLwBebd69VHUBVLakWo5c4jsI=;
 b=A2Vt/xkLJmK3Sm8muvFXKskNhQsNQJVzKoMqBA6Avuuetm/GtC3WdU0YRNEqTLOLCd4Ro
 1HeWy5t9z5smlWidK6JoC3xWFIfZ53oNjW1cBpK+91tScvh4Z5/rYNpXEDZaOFhdyg8MytM
 l5XQ8joCZQbcbU62W3yB1Ok1Go3iPgw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E67A784639
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 09:25:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780471534;
	b=ZheyjgVKF6H8djhO+1ymEYck7znRfiR5ESOq3IjJ+FULDMwh7UMb/q8q/qoZ5Xs29M5azo
	MsxRD0ucsMIcTdtCivjfx6n+uulreWMP8ZHpP7w4RZ6+1FrgnhcZyFrOS1I8x8tbQCsHQM
	YPUuVIZDPeURdcQ8/f64cAd9nIHc5Ho=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=RztcarUb;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780471534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WDF86/s12Hcq7URPeYXLwBebd69VHUBVLakWo5c4jsI=;
	b=RmuPmAby2Ehru1ZLbGFerhsrIObjcw7r41mK5b4OZoIqfSP1ck1ZSLe+LWVWsRxmDCcaaC
	83RbRrInvvSwKN5mlOsDdcHPCxKm930O0JmeMjKEHyr/QXUV2CdOtPOgLh/H+YRTiQNIdP
	r9MisSZnUeeX5nVGUV/mHmUOEdEaHbo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDF86/s12Hcq7URPeYXLwBebd69VHUBVLakWo5c4jsI=;
	b=RztcarUbW5Q5EFPM8K8dMVhr7qrnm6kHJA9UyOMuAI+1YfyFwkpN1/eBmWlrNz2N8vDtzW
	lFpCz+6R7l36AA9tEr2sTTWbijEa4ssWGjGN2/47rhvn1qXCi7jMzK56te0oi/u6v7ecpP
	z00i8LT6GXzwayVQO1lkzAoKC51ndi17Cm11Q9sISJqaGLe8g8+3ZTy8BMvadP1Ig5IiWZ
	DoHxzhIYJALQxd0i5mexCP9xPTB+u+7ZLBuEC9WzMLsZvgq+Q30n5clo7ai6N2GyeZDYxn
	ncqRdiTpBLOTDY4NRhuW4TdH+hf/i08GVvDoD2Qp9de1G8BtpHljsC4GQOQ7UA==
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
Subject: [PATCH net-next 07/15] batman-adv: tp_meter: handle seqno wrap-around
 for fast recovery detection
Date: Wed,  3 Jun 2026 09:25:18 +0200
Message-ID: <20260603072527.174487-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BVWP3OMD3IYHQWXZRISTJSC46PWWEHCY
X-Message-ID-Hash: BVWP3OMD3IYHQWXZRISTJSC46PWWEHCY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BVWP3OMD3IYHQWXZRISTJSC46PWWEHCY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The recover variable and the last_sent sequence number are initialized on
purpose as a really high value which will wrap-around after the first 2000
bytes. The fast recovery precondition must therefore not use simple integer
comparisons but use helpers which are aware of the sequence number
wrap-arounds.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ae6acbc60c8ed..3d3d06c88e1c9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

