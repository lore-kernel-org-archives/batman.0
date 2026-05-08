Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC9ACD3445
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:46:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 46DBD85C82
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:46:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255204;
 b=k7yofaOeNRojXsr8+jp8q2fCABc/BIVVHViSIW5DUZh+LBEvt1uwlBQ+S0AbGgspGddfo
 0bG6q+T3wYZBORyHUkoZuuCgyUpz84L5mBlrVqwzivuqsfx00GjSuePEhsry1j5/0+pfirK
 jXmdXOXLgpHeCgVT+0oXW9r2feb/gcE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255204; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rnpguk5kWeeiPMWnYmoJrWVYQWeHIgM9Bw9lqx5btd8=;
 b=WzjgGEQp2JrEgkbyXJoFseFdhTrH6Di0EeDIseIu5ps1GXJupQCDVxNxo7vjRLGKNtTym
 G4iVGoZlbNAoTTUis+kYLYuM2h/ImweQFW29tDXsgZ7I7AO14myswociZx0GdH4qf3pInnC
 JqI98yASz3959HHscnihMuH3E2mYa2Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 89C778581F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rnpguk5kWeeiPMWnYmoJrWVYQWeHIgM9Bw9lqx5btd8=;
	b=1VjfudXkw5o/k19XIYFrnMcPQjWLbgpohmGCnddUpeusfdGkOsQdSbK3lDczq81KqDTv04
	Rms04zNGFf3Q5O9cHhBpdnf1Yc08fXyxx6+Jd057vFTfpwFs12joXEUQ6qGWadBIxKAGZ6
	G9CRL576aAZ1aMiONz3phjWg/YwxL/s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=p4+LF1Sa;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255013;
	b=hkD+aa+7UE6dSUxZA23UP+yriFYphNddh33XUhAO24qq7l26WIcCTx3PcThsjNIS8CsPC0
	djDIJlxC7JCdsLrKc0LMLjguSt8sVC0QMcyaYQ4bTGb+UXkfdY/HCl2ttHje+3F0nt64Ok
	Mi8/AfHzTR/+g2YEYROhVt7eWhewsi0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnpguk5kWeeiPMWnYmoJrWVYQWeHIgM9Bw9lqx5btd8=;
	b=p4+LF1SaGzSqq95SIiJjAFZpQZEZ5JI/fpKPr+uoXjKGXWhJl3/zGW/HbZu+rleL4SSx2/
	BX7HtEvWdhhUfsmjZ4a03+6BBNQD2/B+5GRD3sVvSBA2lu/H2MUU7tMlbmsQIcPscRyztx
	bdr/EPFCy4SLxzR5d0VdDyBEZrwJAOGqBDadWIORfddHkOQR8Qyc6KgYXYQVVz4N78Ak80
	A0dJAaloRPrgbk2+9zD5Nf8shToYQRpl1gXpqXZbMjKX5TS7SfePcvhl9SpXV/7FnQ/vJd
	L8aFUEtzK2HA0eZVaIUM39lW6vNpcWRIC9xOCjEZDrhL3Hhqtc1E2Nwrp35dNg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Lyes Bourennani <lbourennani@fuzzinglabs.com>,
	stable@vger.kernel.org,
	Alexis Pinson <apinson@fuzzinglabs.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/8] batman-adv: fix integer overflow on buff_pos
Date: Fri,  8 May 2026 17:43:07 +0200
Message-ID: <20260508154314.12817-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NMIZEZ54GYLODKUAFCGFXWOCWXSKF62W
X-Message-ID-Hash: NMIZEZ54GYLODKUAFCGFXWOCWXSKF62W
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NMIZEZ54GYLODKUAFCGFXWOCWXSKF62W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Lyes Bourennani <lbourennani@fuzzinglabs.com>

Fixing an integer overflow present in batadv_iv_ogm_send_to_if. The size
check is done using the int type in batadv_iv_ogm_aggr_packet whereas the
buff_pos variable uses the s16 type. This could lead to an out-of-bound
read.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Lyes Bourennani <lbourennani@fuzzinglabs.com>
Signed-off-by: Alexis Pinson <apinson@fuzzinglabs.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index f28e9cbf8ad5f..618d1889c04e7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -335,7 +335,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;
-- 
2.47.3

