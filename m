Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD28606A88D
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=dGDQGE8Z
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CC70385566
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:31:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393118;
 b=wqBiJSkABLM6LHj7n38o6D3ZVwm9yh5R4I/MUHRHPvBdropmgVPDbjPUMf34dTs/WM0Fx
 6s4NODpYkK1CgHfvu/1zl4Zju/XGUQOF2jhITErZS7Zma57I9/7yJxIx/ThozWr3fKSjpAH
 0TO0tjJ4wEHQi0O/LTJKq4xOrJpRq6I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393118; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9S+d2M18RQfWHvx8jt1sd6SSt8G845pD8JNi8Ep67Bk=;
 b=gnciTRwSwBrWf1ZiGj3e7CkfuVBh12n5wuFw+OddKaaex3ahM/pT7NWnSg583Z/x787mm
 CeZmXFn1W8wVn2k6PeOvyrdVY9pQD7dC1AdzL6qGnxqdUUzmJqi35l9JpiBXD1gN3iIRcor
 QD4szqaQPper2vuINj+eyQMMsi0WbN8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 991F481D11
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392873;
	b=dt77j0WozZskBqu8qz51+ptXp2FF3k+K13MqZtNLRENdPyvShZaMrFywgthznn9VMkA0lO
	lzSi9bWcqVcQQ7gb7CI+M3VrfwBGHQsMmGT6A5qI/X+OkHyGMA6C8pNJNuIf9SGv9CClbi
	nZjXKDdIqUdDF4AW3FGH+xVXs5/bRcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9S+d2M18RQfWHvx8jt1sd6SSt8G845pD8JNi8Ep67Bk=;
	b=aIFREKURjs7g8IGwiksOmkvIpvOw7z0cmqQQEn6Dwoq8ZWYlDNxW0UTJTjT6iZXlXEJaJX
	+lO7XvuLcPakiqyT2uaDM3ToRESnauwQrSYpmYQ1oHq7tasn6xSAWjB4V51haWyAhIS+AX
	LmQebXqz1Tqind8sANKFP0+D4+Ep/PM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=dGDQGE8Z;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740DED843bE7e4a980e9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2E3EDFA197;
	Wed, 11 Nov 2026 11:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9S+d2M18RQfWHvx8jt1sd6SSt8G845pD8JNi8Ep67Bk=;
	b=dGDQGE8Z7LxRQpbYS32JYxEfMbGKNPEzgPISZa8ZzSlPzxbcwFPO4F1WPf+JIbvU+lGDku
	KUD3GST9DKb3r4VzTaRocFWP9anQuNZwmEU+dfliBvOEVi5Z7jiUyRd5L37nfrGHQXqGEZ
	/lhXmJOT1vKx/moUhA5LmjY9VoT90zQN8XzvfcHxQ57j5ZTWbZ/B00ZL23QUH12RLHd7S4
	794WiUPYl5w6HJ91yQuGR7V/GcHX6Q+0LsBLSRI6P02sT9VdUrgW/rpkBA+G1uvUCFI4xS
	oyyt3w0iPSQPNH4PAWnINfC2fn6GhBxrcQvEOgvJR4qwSwelvOaS+ceCVtQfsQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 05/15] batman-adv: bat_v: initialize last_unicast_tx
 on neighbor creation
Date: Wed, 11 Nov 2026 11:27:19 +0100
Message-ID: <20261111102729.2096241-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HLIMYBHESGB7Y7PX4MK7US6QE4BOLY33
X-Message-ID-Hash: HLIMYBHESGB7Y7PX4MK7US6QE4BOLY33
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HLIMYBHESGB7Y7PX4MK7US6QE4BOLY33/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

hardif_neigh->bat_v.last_unicast_tx is implicitly initialized to 0. As long
as no unicast packet was sent to a neighbor, the delta computed in
batadv_v_elp_wifi_neigh_probe() is therefore relative to an arbitrary point
in time. When the truncated millisecond delta happens to fall into [0,
BATADV_ELP_PROBE_MAX_TX_DIFF] (for example when jiffies passes 2^32 about 5
minutes after boot), the throughput probe for this neighbor is skipped for
one ELP interval.

Initialize last_unicast_tx on neighbor creation to a defined value to
ensure that new neighbors behave the same way - at least independent of the
time when they were created.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3522d0..4a25e513864ca 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -143,6 +143,7 @@ static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
 static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
+	WRITE_ONCE(hardif_neigh->bat_v.last_unicast_tx, jiffies);
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
 }
 
-- 
2.47.3

