Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0616AC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:40:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6A3E1843F8
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:40:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785246051;
 b=H/kuKoRibEZzkSt4M717YTAgvKtpU5WW4H1XGlM3q65GkfKVhPgjscOWXlQ21A1TJWp5H
 KwZ8SRo0v/GBqnjzbi/kCvqX5oQYEjre2dQJRwwmnwH4HMt/NlcGD+KsfZAY/JEpOUyl0lt
 Xz4ZZaRSJWSKa7QOehk2ucFYydhflOM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785246051; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ej5s2OSRHvIZjLqvBiyT+YuhTjdxsPjo3tAk5Fud2lw=;
 b=U87kzhSRd1cPi4kwF9/rCdatUcchC/A59zbo+U2wARlU1gW1DuFh+dnd0fKLgC3t7ZMHD
 vkvfhw3/dOmjciLQSOqME6XNmh/G6qY2u9fKvFuKNLQi/eC+DKl++Li7hKcaV/hPjZWO1CB
 /ry2+zN7Ks5p0FWDCaR54Qyx2rc1bcs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 505CB8453F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245961;
	b=L/TD8Uxlh6J7G+8dPAWc2rpvVVNr/sUncZ6lvNp4qKPwoEXZ3J2abdFBXw4vmtR4T7FToI
	v6wh73efR+ngt1IBekUwCHLmTD5oNGz1wgc1u1cQcNpPWZwUfu1U/iSVLCo9fmdKserHk/
	DynZGW7TrCPu+WV4nMzD9xceYhTAhb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ej5s2OSRHvIZjLqvBiyT+YuhTjdxsPjo3tAk5Fud2lw=;
	b=juP44KGA7yleZwX9Ry/Ealkd48doUu7KnKal7Fq3LIXpEwNXWQJTGZGjhkHLbz0RybJOxI
	0GdrvrIuCoM2ud6+A2ukRpe//7rUAR6T7Io0SF1JwlMsx4PRoAS1st9Z4auXA6+8jDabGl
	+cyKaqMtIxjGSXEhwt+DZOGEXtm3r+M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=UTfsJxeb;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717EaD808F168C97e5563a8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B3ADAFA03C;
	Tue, 28 Jul 2026 15:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5s2OSRHvIZjLqvBiyT+YuhTjdxsPjo3tAk5Fud2lw=;
	b=UTfsJxebQ2IK86DRs+eGMNdjQQ3beetuBKBJjEMKfmK/FmS1Oxjlrm200KS/HHlxMPloSn
	5GBVwbky6iplqQn2M0l+FKB5/H7SRc2Ub5/l3CGNng9dP1nwuBoh2p25aO4QXGJ1Q37HZU
	/5ScNNkpJox4WnY+edBqMjWv/+0TGoN9AAffWGI8f3QeCeFpMtUw3TpeI763jiDCCteI2Y
	aDfs6NmkFF+vgHWWrG2r8E5tW3wGfkgTxb0Q8SwF9y8K4RsysoktyuwA2kfx/E0uyA0wMh
	k/qG2pp6SGpbIJEuzrDRnBaNjI7qFb4kk6Xq42vQ/N1BkTENBKX+3V3tkBi0HQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: bla: prevent CRC corruptions after
 claim flush
Date: Tue, 28 Jul 2026 15:39:05 +0200
Message-ID: <20260728133918.643267-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SOZZFCLEWDVNGN6UG2XBVICEXGGB5L3G
X-Message-ID-Hash: SOZZFCLEWDVNGN6UG2XBVICEXGGB5L3G
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SOZZFCLEWDVNGN6UG2XBVICEXGGB5L3G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_del_backbone_claims() tried to remove all claims of a
backbone, it sets the CRC to 0. It assumes that the it had the last
reference of the claims because batadv_claim_release() (which runs after
the last reference was released), is XORing the crc16 of the claim address
with the backbone CRC.

If there would be a parallel holder of any of these references, it could
happen that the backbone CRC is (0 ^ crc16(delayed_released_claim)). Which
is the wrong starting point for the new claims it may receive when the
remote answers the claim request from batadv_bla_send_request().

This reinitializations can be completely dropped to avoid this problem.
batadv_claim_release() will take care of fixing the backbone CRC.

Cc: stable@vger.kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 79c482d24d9e3..8ee3ec5eb2c5e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -324,11 +324,6 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	/* all claims gone, initialize CRC */
-	spin_lock_bh(&backbone_gw->crc_lock);
-	backbone_gw->crc = BATADV_BLA_CRC_INIT;
-	spin_unlock_bh(&backbone_gw->crc_lock);
 }
 
 /**
-- 
2.47.3

