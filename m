Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E324C47DDF
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 11:02:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CE71C833D0
	for <batman@archiver.kernel.org>; Thu,  1 Feb 2024 12:02:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706785364;
 b=kFU/bEH4XHBnbI5iAIBbce3DdU5whW6VQSt49LwU1Sxx5v8a4ZXZjgOH/ax+prH+tK8aJ
 JeTELVJ9O1VU7VhEuFGnkdbV2vCZJ7VBBly8yNh2l2pc7XH2v4W5/i9T+2TW+ZcIT3Il0hX
 LDAq5/pO2dsSvY037oj2d4JGdX+Vzno=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706785364; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LpxrqSXgvA8rC9xiZHYB/eBo5c3KrDE+RHmhCsQBD8E=;
 b=I4nMFswXhpMxPWwdq50/4uvkBK00g9udj1MMGX4v0jPoXr+uRv1gs6dXRb1YTYq9AhW2T
 8K+a0htJMOcAZLRtny82kbF4+VfRUhl2vbH1VA1vD57bAhgcHY8IqYeeUO4Y6RXVV39E7fO
 Bcykg81/b2uCkLKsHIqvYSSthYN/RU0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B701982C2B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  1 Feb 2024 12:01:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706785277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpxrqSXgvA8rC9xiZHYB/eBo5c3KrDE+RHmhCsQBD8E=;
	b=1g6TdbxMMRFDO9ZXl9gEfWTAal2yH1jcNHBCFduGSozGycca6pR6ap42IN1hvwJcjGdn7e
	x3mVlq5Rz6c0Iwme/2KyNyz9NOyaWjDS5+SYcOISZ7y/ylgEh4mqmChRjjunA6lyhEvlAS
	cTInBdJmQsYqlQkY+C2rt1D1TNgZiy4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706785277; a=rsa-sha256;
	cv=none;
	b=Hf4IeIVySqxk77LcAYRfD5CRSd18x6XAyc5WHW6G6Nx/ifsAv8cLt0IQx4/CEsUBHNIrgb
	2xmca7ZmnxzQ9QAlX6IygaHKeHRhbhsev00rrR6ZcXOxNbISUi/HkvyXeKeDMBKGFP+YaM
	7k9Ghud1Qc80A4uAGnG8XofD17vP4bE=
Received: from kero.packetmixer.de
 (p200300C59712C7d8D89318FB9d63b559.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E868FFA9A3;
	Thu,  1 Feb 2024 12:01:16 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/2] batman-adv: mcast: fix memory leak on deleting a
 batman-adv interface
Date: Thu,  1 Feb 2024 12:01:10 +0100
Message-Id: <20240201110110.29129-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201110110.29129-1-sw@simonwunderlich.de>
References: <20240201110110.29129-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4U6CXUHPMYBZ3VRGARNAVURAKDHDMRXH
X-Message-ID-Hash: 4U6CXUHPMYBZ3VRGARNAVURAKDHDMRXH
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4U6CXUHPMYBZ3VRGARNAVURAKDHDMRXH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

The batman-adv multicast tracker TVLV handler is registered for the
new batman-adv multicast packet type upon creating a batman-adv interface,
but not unregistered again upon the interface's deletion, leading to a
memory leak.

Fix this memory leak by calling the according TVLV handler unregister
routine for the multicast tracker TVLV upon batman-adv interface
deletion.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Reported-and-tested-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000beadc4060f0cbc23@google.com/
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index b4f8b4af1722..14088c4ff2f6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2175,6 +2175,7 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	cancel_delayed_work_sync(&bat_priv->mcast.work);
 
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
 	/* safely calling outside of worker, as worker was canceled above */
-- 
2.39.2

