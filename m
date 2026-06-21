Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88721CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:36:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3FB0980585
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:36:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052588;
 b=dVbxxMpCUsQJWY4xQ/XidgcGFlxhNAXfuYpTT421rkHrdD1mNMfi4KIuT8HemmxkzTKn6
 YmdA2W4TVHQWDN/PtRJDz2aD0hKMUakVnHSAPCScRRF76HT7zXyf+BZSolapaHbXZG1tyKk
 Ew1UBsLsI4jOa1LpzD+L6CheDPDyZ54=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052588; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8+jbYC5H6qAdYSW6GRrTmSH/GOiuikWbQbaMKHKAUwA=;
 b=H9YpyfPiyDIiA42qTtumrFK71djkZ8MexpIAqQ8qZv6zNw4zfXoyxkKJeeikUgTiHMqbP
 tCUTUwQXw2PMJjGb/cZA4S+tDkKsBvmGvbUvLuTRNHAownGcbfgpuMOIjYeot89YpCZT7IO
 TRLirweenr11gaZqTEw7maFrXTGSB+Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0BB0884194
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:25:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051917;
	b=bWM6qXHLQdBkWIJHhMTC+qcYNEM5nj8NJVTVj9opQSgUonNSt3VlB30NSpG/4jDn5TFVri
	Sf52nCJjGSPNIvnrp4g3Dz+UO0E7svI6smg2B3Lsnhlhdmj+hHAw+JEd7sGTOhKKlwhrou
	tcZatNkVWacSGaKUde/W5ldbYrjvS6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8+jbYC5H6qAdYSW6GRrTmSH/GOiuikWbQbaMKHKAUwA=;
	b=Bbq/BjMHcJ0AIDBQJFs+5yJBcm76Xzg058ihMLShc8HBINjDsmToay2uKvkttaqTf9jjrv
	IfKqwDUBZKhdT4Ac2/ssQryjsfBErg9NchWWtljkOrCn+RZhH56rN6V4xorcotG+oQ4DKU
	9a1Tbjt3szm98rEHXAOAA+NO0gJ7Ur8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rdlT1m00;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 991D4200C4;
	Sun, 21 Jun 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+jbYC5H6qAdYSW6GRrTmSH/GOiuikWbQbaMKHKAUwA=;
	b=rdlT1m00l7uO70H/jbxsSfAvEu0rlBeKupN9sVTM8JhWc9ic7rFSr8ESBCQoKE1cygchmA
	h5d2xQZRQ/794XsWXi9BFVFO4pEd15qCeU4UxB/7pWgscROP4H++RR4VCB2WBleGuU6xlJ
	ccItrUZMtSpaRuWbiuSAdAuTjSv0IWM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:06 +0200
Subject: [PATCH 16/28] batctl: handle netlink callback object on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-16-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396; i=sven@narfation.org;
 h=from:subject:message-id; bh=AlnhnMZkMFRtWhbquSvRyeWB3czo5KQZV/1rRchBnao=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9jWy9pc8bGdZf5AzadrT9+fY/5H6t5Pid66qfp/0
 fkV7gmbO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATeWPL8E9359FLK9951Pw+
 zTjzdE3UigP3tBieRKdxG8vHst5/Iy7CyPBb33Wt1PSddZJJqqXR3Uen1CuwyNyt6TiUk6y2g7P
 mIgMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YODOKIF4XF2NZZAV6KVV2XI755THYRGP
X-Message-ID-Hash: YODOKIF4XF2NZZAV6KVV2XI755THYRGP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YODOKIF4XF2NZZAV6KVV2XI755THYRGP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The libnl callback object is allocated and must be deallocated when it is
no longer used. This is especially important when an error happened.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Fixes: f109b3473f86 ("batctl: introduce throughput meter support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c         |  6 +++++-
 routing_algo.c    |  1 +
 throughputmeter.c | 10 +++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/netlink.c b/netlink.c
index 1121956..5f78602 100644
--- a/netlink.c
+++ b/netlink.c
@@ -488,11 +488,15 @@ char *netlink_get_info(struct state *state, uint8_t nl_cmd, const char *header)
 	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
 
 	ret = nl_recvmsgs(state->sock, cb);
-	if (ret < 0)
+	if (ret < 0) {
+		nl_cb_put(cb);
 		return opts.remaining_header;
+	}
 
 	nl_wait_for_ack(state->sock);
 
+	nl_cb_put(cb);
+
 	return opts.remaining_header;
 }
 
diff --git a/routing_algo.c b/routing_algo.c
index 1c2c2b4..167bd22 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -107,6 +107,7 @@ static int print_routing_algos(struct state *state)
 	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
 
 	nl_recvmsgs(state->sock, cb);
+	nl_cb_put(cb);
 
 	if (!last_err) {
 		netlink_print_remaining_header(&opts);
diff --git a/throughputmeter.c b/throughputmeter.c
index a45eb08..23a6027 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -158,13 +158,18 @@ static int tp_meter_start(struct state *state, struct ether_addr *dst_mac,
 	int err = 0;
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		return -ENOMEM;
+
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, tp_meter_cookie_callback,
 		  cookie);
 	nl_cb_err(cb, NL_CB_CUSTOM, tpmeter_nl_print_error, cookie);
 
 	msg = nlmsg_alloc();
-	if (!msg)
+	if (!msg) {
+		nl_cb_put(cb);
 		return -ENOMEM;
+	}
 
 	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0,
 		    0, BATADV_CMD_TP_METER, 1);
@@ -200,6 +205,9 @@ static int tp_recv_result(struct nl_sock *sock, struct tp_result *result)
 	int err = 0;
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		return -ENOMEM;
+
 	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM, no_seq_check, NULL);
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, tp_meter_result_callback,
 		  result);

-- 
2.47.3

