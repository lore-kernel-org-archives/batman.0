Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF851C001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:37:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1D10280920
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:37:22 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692203842;
 b=M/awqjBJy877l8C2MO/ifJS3Bu2rk7opPZ6rLCzvZsj+Rv1IrM6cfOtKDZyfssABHULC6
 q+djrfIZOtfxFSLE7pGOQ0113acNcSsJr902717PrUiTjqGO4Eo391ogpUWglItDYrEewOD
 OZbg+HVaDCX5k78Wm3W6+dy6NC8UL00=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692203842; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tWJjm22J4n2farjLKQ2JALJubJD+AmAphywPy0CjxeE=;
 b=SH+lW6mY0EfWNd1wBIIU4FclPzZLSKzfkP4nt+BoyFMafJBtsjBgYtUJHTc/BJrk9ENaI
 S5MS8y8gMa99L+nUA24otijCDqsy2qGdBdA5oLBcC1sKR7e4FNipu3kyIkNPPfM5DdLnn+K
 mmVG0zeSuJLUoZg5lVsLIl7BvNhqVx0=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 47BC982EE4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:33:23 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692203603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tWJjm22J4n2farjLKQ2JALJubJD+AmAphywPy0CjxeE=;
	b=xQLj9gMAn9iX0LaeNiKhXQWKxy8+DwWUpCupif+dc/Fsclc6olbl9a21EZOxb/fIYoD/b6
	3uijLBp0UwMz0ey1iy9tS9bu+kZbXNoz0ZiXd/YHHxEx/w7/e01UGorOhwssbaiSfcSscE
	LI8upslsgXZ7FZr03JtDLPiv+8XJGvo=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=sOIpOAt7;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692203603; a=rsa-sha256;
	cv=pass;
	b=uOvCthA6Vs5WDAgfKPNkPj4sJXFmMGWMMgWsqE7laJjJfv0e814mV34Ma4UxFtJD6Ocf9X
	8/jugxJnEC2/EvHsaAGdzM6vDgkRDo8E/wQij9MDf0z5nV6/jUbi8mOdyz6DQ++mFdXT7F
	Dn2wIRlGHo4pmrhHtBzFTZCta25AE/4=
Received: from kero.packetmixer.de
 (p200300FA272a67000Bb2D6DcAf57d46E.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 10E88FB5BB;
	Wed, 16 Aug 2023 18:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203603;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWJjm22J4n2farjLKQ2JALJubJD+AmAphywPy0CjxeE=;
	b=sOIpOAt7xFjzl5mZKYlVPnsMdSoU2zGdai60iDENgeRQ4ofK2lu9nzrLRezA+t5XxfaAjU
	/OnrgBdY8K7BwNY8u1mZd65wgI5wom9KbFHICZ7K6ApW1ZzAfNLe4ssFtEwieBc7ih4rMo
	cGm7n02Q8g/NRWNkkSBdeJwZXiFgZtGEmrDagZevQ+BEVpS1MGr7h2+xxRdOX38CQODti+
	0X9z8sF9HNdn8XNLQClB8OFMGa6pa0vXTwiR7HdKuH941BwAnJ9IKcB4Mi1KDunDDAwf9x
	rjV57ALjTLx8+LU93ULAmczOi0xusmrYDiu/QLOmczN2gQQ2RjJZAqjgV1d0sQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH 5/5] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
Date: Wed, 16 Aug 2023 18:33:18 +0200
Message-Id: <20230816163318.189996-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203603;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWJjm22J4n2farjLKQ2JALJubJD+AmAphywPy0CjxeE=;
	b=05gDzm+7Bk0y9EcIvLVx8SyVtVrunguWJXAotzRRhSiNBOnIFMkredSMRXEnD4g4IQYOHT
	jsPWkfxRgZGYaaGDvTTTkA32KdSW1/k+GzJEyJnxFbfC/stYXpT546j7dy2UVoKut3GU8J
	EgSKP1bTtJ6pg/+dkSKzr4idH9wKbN/ZL4zeHH1Z6ERcwJOicch0TS7ZwWfFse13M7PkfF
	xKlt9UjKGP5DASVXKlFMuOcP7qEsAbGXec4uIudax+9gYT8xkTzU13+QnaSXjSZzFDlZnr
	xjTBrjndlIO/kKJKoXnd0VMcPRaeoeGvG77+DNneuaxi2oTqGiZBufwFTA56pw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203603; a=rsa-sha256;
	cv=none;
	b=Ux25l/wyk4uz0vjixhwRzPIVELEgQ4BEm36PxW+Sb+M7c7xv2dfilbKWSZF3lSQLCs/+I9cuAexF6pfknBHAis4Hpuei2+pxUHsMsYesV8IgHYcZjNKWUnhrS2gU5PCBUvd/O2NndMDy+Zxrb7n7fsvtheVwcGjaRrWkiYlt4ehCPz5FilySFobXyLvjpqXNsYFUXZ74fNJyPnJIiAqBhdSgHj9hxMWlAjuQEvrrfamX56q7vgjmEUCTFpzW5QuvxjKYcuIAAciTcSHs5hAbDpz4D0pbzSKLly4C0jcWA2WR03dUkMk93p9KhjmHrV/QWgzWlJFQmHRYIE3rNR0wbw==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: SFZ4I6Y6X6QVZSZXUBP2HA7DQNNDHPRC
X-Message-ID-Hash: SFZ4I6Y6X6QVZSZXUBP2HA7DQNNDHPRC
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SFZ4I6Y6X6QVZSZXUBP2HA7DQNNDHPRC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Remi Pommarel <repk@triplefau.lt>

When batadv_v_ogm_aggr_send is called for an inactive interface, the skb
is silently dropped by batadv_v_ogm_send_to_if() but never freed causing
the following memory leak:

  unreferenced object 0xffff00000c164800 (size 512):
    comm "kworker/u8:1", pid 2648, jiffies 4295122303 (age 97.656s)
    hex dump (first 32 bytes):
      00 80 af 09 00 00 ff ff e1 09 00 00 75 01 60 83  ............u.`.
      1f 00 00 00 b8 00 00 00 15 00 05 00 da e3 d3 64  ...............d
    backtrace:
      [<0000000007ad20f6>] __kmalloc_track_caller+0x1a8/0x310
      [<00000000d1029e55>] kmalloc_reserve.constprop.0+0x70/0x13c
      [<000000008b9d4183>] __alloc_skb+0xec/0x1fc
      [<00000000c7af5051>] __netdev_alloc_skb+0x48/0x23c
      [<00000000642ee5f5>] batadv_v_ogm_aggr_send+0x50/0x36c
      [<0000000088660bd7>] batadv_v_ogm_aggr_work+0x24/0x40
      [<0000000042fc2606>] process_one_work+0x3b0/0x610
      [<000000002f2a0b1c>] worker_thread+0xa0/0x690
      [<0000000059fae5d4>] kthread+0x1fc/0x210
      [<000000000c587d3a>] ret_from_fork+0x10/0x20

Free the skb in that case to fix this leak.

Cc: stable@vger.kernel.org
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 84eac41d4658..e503ee0d896b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -123,8 +123,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
-- 
2.39.2

