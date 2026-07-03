Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA52C43458
	for <batman-adv@archiver.kernel.org>; Fri,  3 Jul 2026 18:48:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D9B0E84035
	for <batman-adv@archiver.kernel.org>; Fri, 03 Jul 2026 20:48:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783104507;
 b=AkrWF2VeWvE/2aA4xaCEeDjsJcUsbugctSwovnf3jMegzVENQ7yu7QkeM7A5Tv54L7VFU
 JoMEm71NbBhgA4wM711T3ysdGlrOdL0bKOF+AdEhm8fyfkefM9MDkvHDcIP0als5tE3rc3r
 pLvzXEmqV2MlI5S/+bk1XfH8d4B0qqs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783104507; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tQN+Gn1rU4zL4QKDCNwlXP6xXqqnDvegrr9I9PiIkLY=;
 b=SSisLxdQvnzVd/Op/PC+F3fM1L8cAOOsmf2OeMQEFRYSqsexXnUcLCcu+Da6Ur097dEyo
 up0neBlFCGgFBN4d7jFmANJFa7AxNgIdUPhOPEyqa54qFzxITw2tK/v0BCcMGiTejCqDzEH
 VxlJMQoqoMt4HSZfsPVGNh+qixCZVQo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E8D58800CB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 03 Jul 2026 20:47:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783104486;
	b=afxXIgel9oSTJ/aWCxjbxMCobfR42x9jG4LJhIcwK0HJTgaEsWuLg6wulOI+rP7q/Jp8zR
	QOZz5jaQLI036MyOcREJGVy5mm2Ymd1qlxlryQ/caX3JsPjXBlPNDuPSOBFfgrB00h3igo
	oLIRNkpMcdbR6GOOpCk8clJMQU+RYFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783104486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=tQN+Gn1rU4zL4QKDCNwlXP6xXqqnDvegrr9I9PiIkLY=;
	b=Pcu7IdlCQMM0VnrEVNhRqIQkHkHZ8+pz+PnXjDpGBb8EIqvbEFlb/G9eRl8jwxfuPT00Y2
	BgjNgiRSFBX0Gj8t6y5gUDHhoViWmps2N5sg/AurWjl7YYeefdES00EnvTbb2EtQzTxm/8
	m4bSjKPdqsObuzwODcVCgIv+goRot6g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UUik9jOS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C736F1FDF9;
	Fri, 03 Jul 2026 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783104474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tQN+Gn1rU4zL4QKDCNwlXP6xXqqnDvegrr9I9PiIkLY=;
	b=UUik9jOSw+KSpBsKL0D1aKqQeqqCGDJZVzoPrxMPSkU4fLZ+JqO0+t2s1IWZ4T+xA7QXI5
	6A/imdu++O4l553GSZEjolgAukzbOrjCjZi5NlMvPQQMqVVWROhdsGdc9A/dUgEMmCNkVb
	/gSdZmtL82oqSqpI8z7GjLnqAgeYY/s=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Jul 2026 20:47:45 +0200
Subject: [PATCH batadv] batman-adv: mcast: avoid OOB read of num_dests
 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260703-mcast-num_tests-access-check-v1-1-278075e2873e@narfation.org>
X-B4-Tracking: v=1; b=H4sIANADSGoC/yXMUQrCMBCE4auUfXYhpmDFq4jIdjO1URolmxah9
 O5GffyH4VvJkCOMTs1KGUu0+Ew19ruGdJR0A8dQm7zzB9e5licVK5zm6VpgxVhUYcY6Qh8MHzo
 MR9QrqBKvjCG+f/yZeikSFrr8d5v7O7R8bdq2D2sDX++IAAAA
X-Change-ID: 20260703-mcast-num_tests-access-check-e2d7ef8e607e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=sven@narfation.org;
 h=from:subject:message-id; bh=9K7U2YfMHJgITTgMvzoVhYtsGUHUeXdNSqjFLkhYt6E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkezJd4LT5IZ+ZnZzrMWBEo3JRu5hvi6u+xN//v44dXX
 714GHmqo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRRd8Z/udtC5Yo9b8nqMZ+
 f4WqRdzZHyaVK2Z/2F0xM0FvH+ecS48Y/kdvmL/a59RWDpF5Gx+8qM+az6anEeLUEbzi3bW7+W8
 /e3EDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IU5ANGDR3OJYADOY5XA4K2FBH2XKGAFZ
X-Message-ID-Hash: IU5ANGDR3OJYADOY5XA4K2FBH2XKGAFZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IU5ANGDR3OJYADOY5XA4K2FBH2XKGAFZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Before the access to struct batadv_tvlv_mcast_tracker's num_dests, it is
attempted to check whether enough space is actually in the network header.
But instead of using offsetofend() to check for the whole size (2) which
must be accessible, offsetof() of is called. The latter is always returning
0. The comparison with the network header length will always return that
enough data is available - even when only 1 or 0 bytes are accessible.

Instead of using offsetofend(), use the more common check for the whole
header.

Fixes: 8ed36122d709 ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast_forw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index f2e53c7c..60ad3a55 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -926,7 +926,6 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_mcast_tracker *mcast_tracker;
 	struct batadv_neigh_node *neigh_node;
-	unsigned long num_dests_off;
 	struct sk_buff *nexthop_skb;
 	unsigned char *skb_net_hdr;
 	bool local_recv = false;
@@ -941,9 +940,8 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 	/* (at least) TVLV part needs to be linearized */
 	SKB_LINEAR_ASSERT(skb);
 
-	/* check if num_dests is within skb length */
-	num_dests_off = offsetof(struct batadv_tvlv_mcast_tracker, num_dests);
-	if (num_dests_off > skb_network_header_len(skb))
+	/* check if batadv_tvlv_mcast_tracker header is within skb length */
+	if (sizeof(*mcast_tracker) > skb_network_header_len(skb))
 		return -EINVAL;
 
 	skb_net_hdr = skb_network_header(skb);

---
base-commit: 22b12d005035f37f898e5bf80480719fe1ef4fba
change-id: 20260703-mcast-num_tests-access-check-e2d7ef8e607e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

