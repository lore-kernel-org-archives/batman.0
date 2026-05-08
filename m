Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75133CD3436
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:46:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0189085BEF
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:45:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255158;
 b=dWsoXULaQJNaRNOG8t6XRBTXfjuv5HseaP2iE3c486O5Z7wPHd5aRpwnVGiHvmrfsjIMc
 sikH6YWan3iBFK7ISlQW7bC2F1u2zYNPVZDSJFqUmPOW0MJSO7jQMQjqg2w57zCiYGcHKHb
 cx5myDG6vY8j4Gw3FEhK4YLlW0yCg7A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255158; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gT0WzvsqKfNLDNGa8/igrkbGhshlJ0I9ZNwvbkIgM3Y=;
 b=f/Ur51KvH+rvs3AotBMjH/pW1xIfRIq4FxTvZuJbn1i4krFcayqnX03ufFc5Yt+82THNJ
 ScSLmqN0pKoT0pwx/gollia3rlyxvR5qxdf171A3SYGJuyMS2IafBHfVulfm7UG5lhkZN2T
 VN2V5/j8Rcv+IDWar3ciKbzW3iWwZPY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9DDC085A9E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:33 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gT0WzvsqKfNLDNGa8/igrkbGhshlJ0I9ZNwvbkIgM3Y=;
	b=InsuFsOhQwkNY6OA1qJWF4W07h8aNCY99/c4Qxqjp6MjFFAx7peiEgsv2PnoQ5bD7S8QIs
	UYhNaFiU+jaoH+V+vDUQyddBaToVcDt+7VGYGyMbHQ9CBIogDjJcdGeN8P/8VryNPpQVWV
	mgF3rDE2oHDWL0YMsYpbXhfm5PowcGE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=GRrctEcg;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255013;
	b=WxDpr7LnB5mWZdeHEgIat5k9ndUcGptkThHnjki3gFE7hcDciqb9gmgPB5aK7uBdj/sjgD
	ZOQ6Siy/qr6Iv8wQrOmilwBr803nhKbQkVWnQRVCajdizFtwyG9tImaFXiWbwGORPZ4gz3
	a9QMin+PfvVPUYufHL3a7bvZ0lL+iWw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gT0WzvsqKfNLDNGa8/igrkbGhshlJ0I9ZNwvbkIgM3Y=;
	b=GRrctEcgVJDPJ99svo8+dnPotaofCSBXBk/gSWYVq1f9CT5kApRniSZH1+q6+kNvzPI3aE
	UsYAEEGLEywUaWtnfW64x/rhY4lcFuBf7j16xij9I5AzgEK59Zy1e4vNjgs4LIauGnZBAD
	5y8YUH8DXA+biMYB4oHMVd8Zwk5nIomaip40JJeTei4LEDs+ottKnF9oEKiTapD25/QxfS
	xPtavNgHeTDUzTR39H27DgdsqNA+C3gDpPe45Ns0jnsSrA5PLcjYccLEs1QoQ9hZyHN5NG
	KiPxWSoQz/I/4VMoTraUjpLxEgoZIddlCMDPG04OY2rT58r8AQvwfX1+kq5F4w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 6/8] batman-adv: bla: prevent use-after-free when deleting
 claims
Date: Fri,  8 May 2026 17:43:12 +0200
Message-ID: <20260508154314.12817-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SEGSOJ5WJQ3EH2KB626I6OMC2VT73QMS
X-Message-ID-Hash: SEGSOJ5WJQ3EH2KB626I6OMC2VT73QMS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SEGSOJ5WJQ3EH2KB626I6OMC2VT73QMS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_del_backbone_claims() removes all claims for a backbone, it
does this by dropping the link entry in the hash list. This list entry
itself was one of the references which need to be dropped at the same time
via batadv_claim_put().

But the batadv_claim_put() must not be done before the last access to the
claim object in this function. Otherwise the claim might be freed already
by the batadv_claim_release() function before the list entry was dropped.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 51fe028b90881..8b77dd2ecfa41 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -318,8 +318,8 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
+			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
 	}
-- 
2.47.3

