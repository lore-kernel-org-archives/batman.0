Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2973CC43458
	for <batman-adv@archiver.kernel.org>; Tue,  7 Jul 2026 18:55:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BB4E680C65
	for <batman-adv@archiver.kernel.org>; Tue, 07 Jul 2026 20:55:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783450511;
 b=uUTsaUVmc8/Qi3SQkj3EHze2hcIQSZMfZR7kI0EWTYucB3OIDBTX+mA7Gqx+Lp2Go4RH6
 0dw22ybW3b8o0pOc28KBSLwCOpdVxpSXkee2u8pZZI9OrkMjsBhxU91ID72Z5rE/Sqr9Puh
 jEz60yjJoIwGdeiXsZeaXPGrfD+8+Pk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783450511; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XVb43KfsVvFcg9k+EQvJqROneRDZ+avzaHbPo/cGfr0=;
 b=DU36dsVXQ2MoPcPlCZfRq/jxpRwKICNfK3Dwy1tCOQcan1dOZvg7B+7kKFYz6nWRYF8xH
 Z28yMBevLHjO92a9wBEjgm/13lFko7MsuzVulyQ8snWgqiurmTjjI3P887xEfMpu/X/vHXo
 icGCzyP+upsIq35lvSS0b225iU6mMyE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 55E3684228
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Jul 2026 20:47:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783450036;
	b=kLpekI45LXTVPFzlGv85Ri/vGc2u4OQzIxaeiDMyUqR6ib5gBvZe9k8saUGetsr50pSX52
	9x+n1+FNOacnbXBlBTbT5QCimuApM5ileszG87Vlajvq4xJjSU2v6oMyhTLsduJhHkkQ65
	OfVnSSe6985bUoI7Tumn3Fz13URG0RQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783450036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XVb43KfsVvFcg9k+EQvJqROneRDZ+avzaHbPo/cGfr0=;
	b=QFPf5NKq+pt7A+JTlGzCgaQ07+AVvfhYMLsCC/VJ+DtGsREpgAZqN/9+jRwwVET3W6ZCYW
	FMdzmEIfO06cdRdg8nVHoQ4NlsrUAX+BzRHLpRX1Pe+6qa5hyjfnf9HHdopXplIn82Tgny
	OIWamMGhkHrY3J67TkYjCyDTBi9DSP4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BTZvdDTT;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CCD64202D1;
	Tue, 07 Jul 2026 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783450036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVb43KfsVvFcg9k+EQvJqROneRDZ+avzaHbPo/cGfr0=;
	b=BTZvdDTTZZsy9XA/uxmr9GsyQtX++zIpPukrOlsxqC9ykGP87NCXYMOr4/bygPILxBLS68
	WQ6SBnnfQgWpbbUu1T8hflD9d6tkZAT5TD51mywlZmoDY7iZRzAroJWWmMo+QfO9AyiR0K
	iZ+j1Oio/hDzXBMwwmTLNrZhToonxZE=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Jul 2026 20:46:53 +0200
Subject: [PATCH 11/11] batctl: icmp_helper: attach socket filter before
 packets can arrive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bugfixes-icmp-v1-11-ee563a984acf@narfation.org>
References: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
In-Reply-To: <20260707-bugfixes-icmp-v1-0-ee563a984acf@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=sven@narfation.org;
 h=from:subject:message-id; bh=6qsfORjjC9hs3/5EI7UUpfJq3WpI+v+xQAkgIBfitXU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm+ntNKvtSyhP2c2VLeZLcs/WqO9uygT1dcvmk7PvqmG
 ez2QPFRRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi4jKMDNdn/ecQf2q9fnWw
 Ymflo2dXi+N1Nqb/kD09yd34Z6txnjTD/5wLG3exHVfdLs0WnT9Hyqxuu+wFkzkVaWpN4Ux/vnV
 sZAMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ORHLUXLOXE4MWIKGHRI2KSAFOWTC4MNV
X-Message-ID-Hash: ORHLUXLOXE4MWIKGHRI2KSAFOWTC4MNV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ORHLUXLOXE4MWIKGHRI2KSAFOWTC4MNV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The raw packet socket is created with ETH_P_ALL as protocol, which
registers the ethernet packet hook immediately. Frames from every interface
start queuing the moment the socket exists. The BPF filter that restricts
the socket to batman-adv ICMP packets with our uid is only attached after
bind(). Frames received in the window between socket() and SO_ATTACH_FILTER
are therefore queued unfiltered.

Delay the start of the capture by:

* create the socket with protocol 0 (no capture)
* attach the filter while the queue is guaranteed empty
* then bind() with sll_protocol = htons(ETH_P_ALL)

Only after the bind, packets will be captured.

Fixes: 4bd751eed4dc ("batctl: Implement non-routing batadv_icmp in userspace")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 icmp_helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/icmp_helper.c b/icmp_helper.c
index 52ac22d..570f0b3 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -176,7 +176,12 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 	strncpy(iface->name, ifname, IFNAMSIZ);
 	iface->name[sizeof(iface->name) - 1] = '\0';
 
-	iface->sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	/* create the socket with protocol 0 so the kernel does not start
+	 * capturing yet - otherwise frames would queue unfiltered between
+	 * socket() and SO_ATTACH_FILTER. Delivery only starts at bind() below,
+	 * by which time the filter is already installed.
+	 */
+	iface->sock = socket(PF_PACKET, SOCK_RAW, 0);
 	if (iface->sock < 0) {
 		perror("Error - can't create raw socket");
 		ret = -errno;
@@ -194,6 +199,12 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 		goto close_sock;
 	}
 
+	ret = icmp_interface_filter(iface->sock, uid);
+	if (ret < 0) {
+		fprintf(stderr, "Error - can't add filter to raw socket: %s\n", strerror(-ret));
+		goto close_sock;
+	}
+
 	memset(&sll, 0, sizeof(sll));
 	sll.sll_family = AF_PACKET;
 	sll.sll_protocol = htons(ETH_P_ALL);
@@ -207,12 +218,6 @@ static int icmp_interface_add(const char *ifname, const uint8_t mac[ETH_ALEN])
 		goto close_sock;
 	}
 
-	ret = icmp_interface_filter(iface->sock, uid);
-	if (ret < 0) {
-		fprintf(stderr, "Error - can't add filter to raw socket: %s\n", strerror(-ret));
-		goto close_sock;
-	}
-
 	list_add(&iface->list, &interface_list);
 
 	return 0;

-- 
2.47.3

