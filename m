Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE20BC0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 11:40:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0FA0983F0C
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 12:40:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738496431;
 b=LLRYqC8IpCE2X7/w1UEGNlFxEEX5GC3XMWl4TgMugsYGbi7AUtqg/CNsBfgVO+cV7QORY
 ffc8+R8UE2eyj4YLcjSeoeVypAE3NvRRgiYsd7yTbiIKG6OCM82LBtBJh/droUVNZmKEyPt
 1fgnpYoZ8VJoPZt0qyv7r5IPc76uzCg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738496431; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=szE7kZna/TZJgzji1p5jfkcUY1WIUbdB9CMt8bROuS0=;
 b=FWDgqEnn3R0Ap+Kp9ExE+zJLcgJQ2VMLaQ/HloqsC3fRsrlofQGbbBWt6ceatL0h7dwDy
 bLxnXngNk2kNfasrRjMb1fQLKoIDlI3IY1FhHXVg2lOEMm0JbjIpiYnN6QnJNvyZi1l4B2k
 riJK7WvAlLyvmDEYB2gefop7MWKDhWI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 241D38218E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 12:40:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738496420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=szE7kZna/TZJgzji1p5jfkcUY1WIUbdB9CMt8bROuS0=;
	b=zNKoHMil/leZLkjORfhNd80uXVSckTySyZ7kVSjpO8s+YEJbEDHh1vr3c5EJdNkw5Ca4gF
	M5amjQ55FxmR2x8e4UHsr9K8uvKA61zQZHfUhffUlzg9cfrIyDCGf7KnGpJf5qWfhEHKLr
	+e0x4QKs+Cfi2YY7A/1AXivdK6XtbWU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YD9a2QIE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738496420; a=rsa-sha256;
	cv=none;
	b=SB4dsEd6Q3uecRDKJOhqcRc3GqXcQQhhx0oBpGZbPwi7DJcuxo5o9Qd9WxXSeDgRbgkGtW
	F8GTYuDQFXDqhgQeutDY03tJ5K4FZjeSa79kRic3CtDJ1G8FJTDRUsgHTzRaIjbzVBrJQg
	J12JQAOujvv3h4kirV87fEA6dRDNq8E=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::8411])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 2714F1FE9B;
	Sun,  2 Feb 2025 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738496419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=szE7kZna/TZJgzji1p5jfkcUY1WIUbdB9CMt8bROuS0=;
	b=YD9a2QIEMO0B3TwKjvLVr3f7N2wttQ3hkaQp0Bs+5a6gGHLWPpGQ1l+5zT4nSWazfKsbkO
	pBv2JiOuKZoFUOiV9WD/aSd/GZzI69GLXrfR9bgliWez++/wyo6Oql4uKnQwOpmTP1hbpD
	VWRcyISj8WS9YH+HTbwN5nHaqwdr1jk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Feb 2025 12:39:57 +0100
Subject: [PATCH v2] batman-adv: Add support for jumbo frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-jumbo-mtu-v2-1-d13764999d75@narfation.org>
X-B4-Tracking: v=1; b=H4sIAIxZn2cC/22Oyw7CIBBFf6WZtRgeCurK/zBdIJ22Y9LSACWah
 n8Xu3Z5Tm5O7gYRA2GEW7NBwEyR/FxBHhpwo50HZNRVBsml4kYa9lqnp2dTWplQnVGan6/ucoK
 6XwL29N5bj7bySDH58NnTWfzsv0oWjDOutENhNSrl7rMNvU31x9GHAdpSyhdZiWFdpgAAAA==
X-Change-ID: 20230727-jumbo-mtu-13d736059c84
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?utf-8?q?Marek_K=C3=BCthe?= <m.k@mk16.de>,
 Rich Chase <rchase47@proton.me>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=sven@narfation.org;
 h=from:subject:message-id; bh=JabEc5NaNyE3fLicOAqa8XavEJRD2eFpb7swux9DlxU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnzI2feknJ2ZfmvKriYR9Olud1wkfW7l0XH9NJjJqg7r
 Zl1K3ZGRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiJe8ZGd7n84V+myAix/Uv
 vWj3puZb842DGj9vnLEhaNt257WR674zMkxd82lvNk99fN6b7+WqV92i40Rf3qwqSz19fatpY4b
 3YzYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LRAFVJLNUVAUAQ6NLX6AJUZ5SGILRXU4
X-Message-ID-Hash: LRAFVJLNUVAUAQ6NLX6AJUZ5SGILRXU4
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LRAFVJLNUVAUAQ6NLX6AJUZ5SGILRXU4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Since batman-adv is not actually depending on hardware capabilities, it has
no limit on the MTU. Only the lower hard interfaces can limit it. In case
these have an high enough MTU or fragmentation is enabled, a higher MTU
than 1500 can be enabled.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
There are from time to time discussions about supporting jumbo frames
with batman-adv. While the changes were known since a longe time [1], 
reviews/tests [2] by the interested parties would be appreciated.

[1] https://www.open-mesh.org/issues/365
[2] https://www.kernel.org/doc/html/v6.4/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
---
Changes in v2:
- rebased on current main
- Link to v1: https://lore.kernel.org/r/20230727-jumbo-mtu-v1-0-036ce1a6e33c@narfation.org
---
 net/batman-adv/hard-interface.c | 4 +---
 net/batman-adv/main.h           | 2 ++
 net/batman-adv/soft-interface.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96a412beab2de9069c0f88e4cd844fbc0922aa18..717bfa03e03a3094a4a80ce5e86765d603eddca6 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -618,10 +618,8 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 
 	/* the real soft-interface MTU is computed by removing the payload
 	 * overhead from the maximum amount of bytes that was just computed.
-	 *
-	 * However batman-adv does not support MTUs bigger than ETH_DATA_LEN
 	 */
-	return min_t(int, min_mtu - batadv_max_header_len(), ETH_DATA_LEN);
+	return min_t(int, min_mtu - batadv_max_header_len(), BATADV_MAX_MTU);
 }
 
 /**
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 964f3088af5b52d3ad1d709fb964dc2c3d79d7a5..1c336814579df6d90e8c020d8e79bc294a8a3b66 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -22,6 +22,8 @@
 #define BATADV_THROUGHPUT_MAX_VALUE 0xFFFFFFFF
 #define BATADV_JITTER 20
 
+#define BATADV_MAX_MTU (ETH_MAX_MTU - batadv_max_header_len())
+
 /* Time To Live of broadcast messages */
 #define BATADV_TTL 50
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 282a8f9b144471b12f62a547b3e57666cbb22c6d..e5b99776d61b8c4c5fa143d27abcbeae795844cc 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -790,7 +790,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->log_level, 0);
 #endif
 	atomic_set(&bat_priv->fragmentation, 1);
-	atomic_set(&bat_priv->packet_size_max, ETH_DATA_LEN);
+	atomic_set(&bat_priv->packet_size_max, BATADV_MAX_MTU);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
 
@@ -1047,6 +1047,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	 * have not been initialized yet
 	 */
 	dev->mtu = ETH_DATA_LEN;
+	dev->max_mtu = BATADV_MAX_MTU;
 
 	/* generate random address */
 	eth_hw_addr_random(dev);

---
base-commit: dfdce35d69c55b6b5d017a7e800e553089a26eb9
change-id: 20230727-jumbo-mtu-13d736059c84

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

