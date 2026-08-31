Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5E0C624C6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:52:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8646381958
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:52:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184339;
 b=vDN983RtDZn2wtNpag7mlr/na6cxTaHa+1CpZ3EVp3gftkifBb2ofwNL9MVNMeOhy03Hb
 b5Y3Y34yO9UqNsbEGS5ruz6ubSTW3E5gh+GMMLgzb9gzlHSw4s3VMZ7/2oal9Y1J4obN4TA
 R8JehGjZ5nxEcRmWhgGqLmYlYvvdVgI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184339; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NJI+Pl5vMT3PeoeRx+lSOsYoU3O+98uwWK2tI6SxqaE=;
 b=eiXVToEFJzamSWhGi50+k/VewECW7DlUUWppwudQ3RSOmlFdiCUlJFj+zAhAaxnnL8tLw
 niuPiJLb6UG05crjAkEHkijzBRuzJk4kLqNsUEz1yWmjyn4QhnnBffGJq22OAAWs7zgJfiW
 q8fn5N08B5PvgCaf6qWwH7EKHjHgecI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CEB6D8046A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184299;
	b=s9h37Es9pc1aWqRXbSB2uPF+qIMmDGNqUlw/njE5qkaEfcft4q6KSwOvyvVCdKmKLIEcXU
	ihZXS4O4t4kZzG074MGO+4Aq1zPVqbuCx7ECoD6A+dvIBHt+Ne9/M/U7FO9P1YQBnXQLhg
	+qG9EEfJRhY9PgnIQwd2JM1qKDIspSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=NJI+Pl5vMT3PeoeRx+lSOsYoU3O+98uwWK2tI6SxqaE=;
	b=E5UAb2YJl/vdR/ei/nQ3RBbUws/B3x3NCMSMOSPRysp0rQ9UHu4KbFRX3Bo3hQs8CCBFJN
	Hq7mbDKFnbFt1EIMcRXL9eEhQ0XdgZTl1gix+D41RAhRFE/eVWghLyX8ru97SQJ9QGNrGM
	bq3xGVDvF1/QEiWN0g9p9Nm49SXzLl8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=BG6MOK07;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970eEDD85F51f1fAa919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id EC9B9FA156;
	Mon, 31 Aug 2026 15:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJI+Pl5vMT3PeoeRx+lSOsYoU3O+98uwWK2tI6SxqaE=;
	b=BG6MOK07AHvo0rVL6cFFUzaXP8SDkuYD1dFmzho1Wcg/2oAxnlXLekQv5oeMMD5BRIr2kn
	tgMK12Y0139R/6hAFjm1rSzjtr3Chpx/5lU/+BTo1EP0kDKhUwEJFul1QgLLOowez0bFpH
	7eXjQXe/ChrM+88+X7rI78QiGqsLp9ix52XyR3OKq55bXIyweHXAdbk3XSqhpCQwzP7Hb6
	n45VhttPgyvfBK3TZEkLGE7Ij3v5qUi3aWwUCi72ygHrx902hq+NOiWXHbbqal922HfREK
	Sl9jW6gP/ff0BdADfyUbQMJKCoW/bvFzVPwvD7I6iHUqrwS4Pf91/HG5HGsKYw==
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
Subject: [PATCH net-next 04/15] batman-adv: clarify cut-off in
 batadv_v_neigh_is_sob kernel-doc
Date: Mon, 31 Aug 2026 15:51:06 +0200
Message-ID: <20260831135117.574836-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KATWIT4RK7UM2DTEERVBC624OTETE6KU
X-Message-ID-Hash: KATWIT4RK7UM2DTEERVBC624OTETE6KU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KATWIT4RK7UM2DTEERVBC624OTETE6KU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The neigh1 throughput must be more than 3/4 of the neigh2 throughput. Just
3/4 is not enough to return true.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2d3045733db1d..0d0a226c3fd0c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -519,7 +519,7 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
  * @neigh2: second neighbour to compare
  * @if_outgoing2: outgoing interface to use for @neigh2
  *
- * Return: true if the throughput of @neigh1 is at least 3/4 of the
+ * Return: true if the throughput of @neigh1 is more than 3/4 of the
  *  @neigh2 throughput
  */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
-- 
2.47.3

