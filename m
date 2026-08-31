Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983E2C624C6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:57:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 33293845CA
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:56:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184619;
 b=fZZNxBw15lEi5CgDx7Pyey0TIpH3GaE7eH7BMh4PAQCckhQQByAOqdWmKaEipXDx+Z97A
 gGetOY/b1py27gXbEXXs5tOOg/1jQQkWzELNR0N6fEhJdZRMX0oOOpGYmmrIce4ki0lxjmj
 jRFLr/CNsq45+i9dgtHJCdlx8bFYMqc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184619; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=T2Ryi/QeX7FdJbC48aswsJlSSwRqMY+uinrprrTyKPc=;
 b=lPhLpEmA6SmcL9mfAf7XKRR00iWk7Ndw6QCpnoWf6VGPZBgH3ZLOxgqBAChoBdjxDp2Yj
 cqCRMDpN01NkbhAvvgRn+RwaWlT+bxEtLZ9X/szFkhCGk07uh5BvcMzp4SsXMNgUTuaVCJw
 p9Pb5sQib/9YEDDQiTHp6CQ8bWfu7rY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 123BB818DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184302;
	b=KlQd/7WRxj8UzUCxkZFfX+QdRo0M/GMVXt5L7MnSdOgEyBIdgPLM7jeeqUXVXMnCswKhQO
	E7KXHomA1UL93L19QxtChlOADmDWuYecLYYWdaS9v2t03X9KHQiAEzY03bkU26b+BcsEvc
	djSVXc9TTJZdBsA526/DIofes4nakNs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=T2Ryi/QeX7FdJbC48aswsJlSSwRqMY+uinrprrTyKPc=;
	b=XtK9Qr19S2TtEEBR/7tzVFsBMwFhD6atlaMeMJ2gW7jVLb0yQl7jfqhRgXr5SIJDXEzTuA
	kpiV9E00VnFtpKqFSKblVpykAFuhOKI/A0dLQuGYpgXiQmkfALJkOCUNEelY8VkrVdN0XY
	lmJdSrnyUA5JrH1I/9eyzJY/uS5sU6w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=xloLjshu;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A2CFAFA13B;
	Mon, 31 Aug 2026 15:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2Ryi/QeX7FdJbC48aswsJlSSwRqMY+uinrprrTyKPc=;
	b=xloLjshuGQXZrUK9dBSgus5hnPemouYW6EhQhftHd/nKcz8Gm0hVjZygdg4J9GGOS3Ox1e
	mHBBoQqLOXeIuFLvwNSqxwO252TpdR8FjMmvwoDMCbj/v9+JYyXuQ2YMMiHaGjopZuiG0m
	iOy8ZBC3CuEzovdi5ejQrMG8pdQCNQViWFVTo9zneogEar4sgrOrRoIYqjQ4b4akToj1Wp
	Urp4KHeQQSkzyhVvms7EWVzHzngrALQfhtNCIQBjYFIybhfEyCU3G6PVXG+UnEve9Giyvt
	2yYLBxxt/zdtyoNfAjwlJJ66oxU04q2DEmx2nI33SWaUfyOz2LeSf0SFZBifFA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: drop direction in
 _batadv_is_ap_isolated kernel-doc
Date: Mon, 31 Aug 2026 15:51:04 +0200
Message-ID: <20260831135117.574836-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZMGH7UROJTSGOZM7NL6ONTPIHW7CJJHL
X-Message-ID-Hash: ZMGH7UROJTSGOZM7NL6ONTPIHW7CJJHL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZMGH7UROJTSGOZM7NL6ONTPIHW7CJJHL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The _batadv_is_ap_isolated() is called by

* batadv_transtable_search()
  - tt_local_entry is the source
  - tt_global_entry is the destination
* batadv_is_ap_isolated
  - tt_local_entry is the destination
  - tt_global_entry is the source

It is therefore incorrect to document the tt_local_entry as sending client
and tt_global_entry as the destination client.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 68f79853032ed..88aeefa97db6e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2437,8 +2437,8 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 /**
  * _batadv_is_ap_isolated() - check whether two clients are AP-isolated from
  *  each other
- * @tt_local_entry: local TT entry of the sending client
- * @tt_global_entry: global TT entry of the destination client
+ * @tt_local_entry: local TT entry of one local client
+ * @tt_global_entry: global TT entry of the remote client
  *
  * Return: true if traffic between the two clients should be dropped because
  *  either both are WiFi clients or both carry the ISOLATION flag; false
-- 
2.47.3

