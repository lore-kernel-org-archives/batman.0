Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100BC5DF87
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 09:50:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5202681284
	for <batman-adv@archiver.kernel.org>; Fri, 21 Aug 2026 11:50:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787305800;
 b=x792Pmn6b5DjTFrgn8spB3X+rH9CYhjRt2MQznIc2fQ39JEpmeiap5BoF3ObM4Gc1vBQJ
 oJ+r+Is6Bh4HfyJ0rCKHrMbNHABae5lkvlED1Ar5PIefoBvSRlbcgUTSiSXzCMN3u/qEK4H
 vPldcQLoijc125Mkt+KhKnrK4MNPmuU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787305800; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Aja7fiIJvKCXpa16GphaKqJjcsN9uuEdrCwqvq/BhVU=;
 b=DPGbMpmpcnkUIfJAjKbwQxoSWQpVkeF6bHsRmX4Tq2y5W0g1zNFPgBqrlSdEhig1zxuqZ
 JEi96uhKl9cPjsj9F1uVmJJPFEwf7PXx/2LAMxvsDkOW3n2hPO1aDepkYzBhJ838rlzcdWl
 qq9QMk4MOtAU723inTBgjCj2rbESK0A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F13E78125B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 21 Aug 2026 11:48:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787305701;
	b=L48X0tTjyILHVGfgP93YaACfn0pmei5cqDtpby4Kk7RdeV4hyzsNu1Iz22uXuxXyxVU2+t
	ywiGiT00g5LH8wiwGbkq3pvytSPY5RJxzLaVx7ECay0bXmW0JR4KwExtoPW+7XC7vcavBv
	dua9iOfYtNt+UraQwyyVmN3Q0Mrp2YI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787305701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Aja7fiIJvKCXpa16GphaKqJjcsN9uuEdrCwqvq/BhVU=;
	b=mRvbmZWwm8uvUNv2HfyZJ4L7pUe0SfGzZexExRrA7de/P9ZAj1zfhQ8YblaJZb5GcpEvhO
	RNLKFAAMMrmHcPz/P1c83mkwTzJgdhCuxoQ0MkkBEd77bdeTqoLJUY6BQquwxEju+DlP5K
	cqdqCOb33RbHaXMVMWKI6S6UANZ71LE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="Tscumx/X";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714fCD8ec8C87C354003FEd.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id B3699FA115;
	Fri, 21 Aug 2026 11:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aja7fiIJvKCXpa16GphaKqJjcsN9uuEdrCwqvq/BhVU=;
	b=Tscumx/X9rJ21lWlos1k9E+4eBQIgjsD/Unf6ilOTDyxyeRWfoTRux2MsgUBsqF0dkkC1y
	LADv0UvHX9ST1UgOkGzpoQ/y5lzSk1b8qJ7uiQZfEITE9KqiecIp7Qhk7h/f3wB0nt63f9
	DFUw8UG3huG2ANQC6Ym09h0mocy1u8j50QbVWvEx/moX3he9rJUUDpSPIG17PbOlMtk4yO
	a0r7pfGv2V2sJC5A0RZT5lGtGQXlR5X7xNFh5S5Ym6LHJ5hYo2z+kCg6yZRD3hWSdzDZoZ
	S429QLtgFE2LKOmspZDzCTdn+McoG8SqNO+QKRNKcjHwBZAWa6iCGnd5EKqtvg==
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
Subject: [PATCH net 3/9] batman-adv: bla: prevent CRC corruptions after claim
 flush
Date: Fri, 21 Aug 2026 11:48:07 +0200
Message-ID: <20260821094813.201800-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BROST3AON5SFIZCZHXVOOZQBMOMUYD2F
X-Message-ID-Hash: BROST3AON5SFIZCZHXVOOZQBMOMUYD2F
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BROST3AON5SFIZCZHXVOOZQBMOMUYD2F/>
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
index a3530cc90c959..3194ccdbce607 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -325,11 +325,6 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
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

