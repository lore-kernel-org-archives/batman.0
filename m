Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DD606A321
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=qGKfIEbY
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 09AB781166
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:31:15 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478675;
 b=sW8pNrh7UzG5unxTZs/NJM1NXG2iOLxHqSUk74hD+mXqruBNH+x2MHRzsfQ8sjVERyPba
 Xlg3GofCqW87ywyvy+sqsV6yxcCfItG0E4x4/uLziK/uWD32AkekSy3z9NZJsQVSwrelb8b
 fHw24VacLarzUutFbLXzl1h4DBuB9po=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478675; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gnZse/QLs36KfjdemwDFj+2fWi8a89oC7FDHIeIxmjo=;
 b=Mtprrt2WYQi27swJgPjGv8l9+9naP7e2MzQ0VBwQa5R8aH7DPiI3utGenURjEeESss46R
 IQKf4aRMn4d0LkxjmXHCFp1Uk7ihxOTwQLGfFnLOY2kOXpISYmNRP/qn0qEHosSeqsQBubo
 ek2dJgZtoXrpvwCvRBht3M0huERz89Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0CD0B81F4A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478636;
	b=3rnl2H40k3224W2lQ+ctl2V8IKWysagaLRyrS5SInQQD34+GC6QLnxEeoEfREKdkzyuNTs
	5RaI8mEjdhI5qpI2v2KMRwhtZ+EWeume8ZBiRc6L+uM7VLKJfHKpnWDuX12aAvisLnxoSf
	MgNZacEqCGKM6kjl+13Agt6DtlIkcMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gnZse/QLs36KfjdemwDFj+2fWi8a89oC7FDHIeIxmjo=;
	b=vvty+H8NWFyXfaTCF9y/F1mBAV5z7j/Tv1TdGCoLpecQTPirGnwXAB57TVjClopnoBLeFk
	Fp2srDUFzJjyz054wYdirWVEjWWjSTyscJIaaqX2u9Q8slv/9sbXN87PJC1+wIkZKS6rLU
	/sNpDWaAomWAg0qA+5EeBe6XDQXIgXs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qGKfIEbY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 74BFB20FE8;
	Sat, 31 Oct 2026 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnZse/QLs36KfjdemwDFj+2fWi8a89oC7FDHIeIxmjo=;
	b=qGKfIEbYpozf6lVKDS3438d2SZvvxTlJjpM7yMLbWK/nDqyVlv6xxRNGSUUzxurDuPjFdx
	JrG9LuEQ7iIoYBsQFu9WtmxiIORxI5qLPFswraZGTUtaXrPm+JD/bpl+GLDLKTgW3OR5rC
	sTOOUlgEKClcbYccmteL3f68Hm6bld8=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:41 +0100
Subject: [PATCH batadv v4 1/7] batman-adv: bat_v: initialize
 last_unicast_tx on neighbor creation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-1-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=sven@narfation.org;
 h=from:subject:message-id; bh=NImmJVI5eRjyWjdZCSBumSG9P+wkgUETup79GsB3xmo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/Hddl1siFsbrvumew7OXpjlJidqNFtdrLjTO/Oz3V
 MnE+MidjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEjp9iZPjprme96/PjJzYn
 fHID7s0oWXwipOTbrfVlWTUnV833eibKyPBv4ZazPWGr56/IS0nfpeJTttP3uX/Xw4VsZuuDix9
 H+PADAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2NN4COBH5MBX4H7DRW22IFUBTO7J7P5G
X-Message-ID-Hash: 2NN4COBH5MBX4H7DRW22IFUBTO7J7P5G
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2NN4COBH5MBX4H7DRW22IFUBTO7J7P5G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Fixes: cdc4545350d1 ("batman-adv: keep track of when unicast packets are sent")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3..4a25e513 100644
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

