Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34225606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=I94oO1lJ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B35DE855F6
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:23:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454585;
 b=qPioHSFaR3Yg+ZO1vMWQOtUCpJsZGNtSRUTYobZdtsZ6skMO+sjqGwEkE/xKm7UyLnKhO
 nIX4KZ3ESh2lWTyw2Th2+Ad2bbcb94W17ADW1QTt911q5M+nEfEoR8U9CltOBbTPsyfvghq
 FLUlxol7pCrE7dB81gEaM/AnxGoYAVY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454585; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=89BApgqYz11D87S6DGoBfXEeIp+QnnRQ5WgQc0ueIG8=;
 b=dD57Y7pc9C2aZ9OP2yOuxsdMktUq45m6w6ThnFdt+Hdh1U6fUFV9magwe+aBSP2wwx6XY
 wpHKgCke7bXn4G0CugDtMrbE7hrZo1s48G1nuSLvjiY57QPGkm+i58WTe+TJjZfuCUuH0Qd
 07qUxUyWGcWfOa5IbzAkQBIHemfJhLY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 42DB484515
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454326;
	b=iGb4ZlK40tafOEqbvhtvvN5WwNjT3kMaTSKeRPs2D8+9ROTR7Jr1jdEAk/VGmYoX7eZWbr
	TDyEaqbzOruILx/kiQhkv8nGPiGsgcEFV31XCQOIGYimRvR/uUMQdPQlk3wcBWsZq8n9uv
	/voYgdlLoM9/yE0V6SzfXT4+hgiWNtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=89BApgqYz11D87S6DGoBfXEeIp+QnnRQ5WgQc0ueIG8=;
	b=bhDzgVZ/wILoH3nIQYRo8inoO6+EY9oMMi6KctvvIZYDVDF2ph1BeE2dqiIyW8B2NC3ziS
	M0f3I5pXlZLUO4UUGS+yQqmAZRkmHHMbEYhOyduNHNdqmOQGYaCloUJgsGyMN87KvFIUm9
	R60n0Z6xBdgS5nRzvv3IkWULTxadZIs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=I94oO1lJ;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59714c2E05a704819b6BA2db4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id B0D82FA384;
	Mon, 23 Nov 2026 18:18:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89BApgqYz11D87S6DGoBfXEeIp+QnnRQ5WgQc0ueIG8=;
	b=I94oO1lJGCg5mBC7Zh5cqSF9BEsjLdkYXz9GdFy6WWR6GnpBlezc8a0oERv7+Ur2NN9DF5
	mEqXYaZ+VArgNRPz/xX0E5HVUPiOIqClSc9V6Qscux9b1x2WPyaKtACLvmOsA5ZwTunhLd
	gnS96YKeCdl5aQXDHHnWJoITbMT+T909wH0n6g7M0w4l+bp1WknIuYN8XDb1yYMefOoLEt
	ejrWV4GLryD/vQ9G0eXy9TdoTHpkL1GFpDico+iC3/lHLwl3aml9YLhsP/TVcyMw9al2kK
	Kut1XzgN56CME7PKQHt5oa7WtBWuPYMV2TOE8yZ/9DuWWnxABeS9fVuV4FE9Hw==
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
Subject: [PATCH net-next 04/15] batman-adv: bla: register own backbone gw when
 claiming for local node
Date: Mon, 23 Nov 2026 18:18:16 +0100
Message-ID: <20261123171827.3294525-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZIYU5OJ6OBX6RSW2SGCH5DUEO2GIAURG
X-Message-ID-Hash: ZIYU5OJ6OBX6RSW2SGCH5DUEO2GIAURG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZIYU5OJ6OBX6RSW2SGCH5DUEO2GIAURG/>
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

batadv_bla_rx() claims an unclaimed client (or a client which migrated to
the local node) by calling batadv_handle_claim() with the address of the
primary interface as backbone address. batadv_handle_claim() then registers
the backbone gateway via batadv_bla_get_backbone_gw() - but always with
own_backbone set to false.

When no backbone gateway entry for the local node exists yet on this VLAN
(for example due to an earlier error), the entry is therefore created like
a foreign backbone gateway. No initial announcement is sent and the entry
doesn't enter the BATADV_BLA_BACKBONE_GW_UNSYNCED state with the startup
grace period (wait_periods and bla.num_requests). The following call of
batadv_bla_update_own_backbone_gw() finds the already existing entry and
returns early without fixing this up.

As a result, the first announcement is delayed by up to one BLA period and
multicast traffic is not held back while the local claim table isn't
synced yet.

Pass the correct own_backbone value to batadv_bla_get_backbone_gw() by
checking whether the backbone address is the address of the primary
interface.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-dba9d95d-5eeb-40fd-abf4-e054aee1f735
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 68ff2f94cf49..3da070a087da 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -986,18 +986,22 @@ static bool batadv_handle_claim(struct batadv_priv *bat_priv,
 				unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
+	bool own_backbone;
+
+	own_backbone = batadv_compare_eth(backbone_addr,
+					  primary_if->net_dev->dev_addr);
 
 	/* register the gateway if not yet available, and add the claim. */
 
 	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
-						 false);
+						 own_backbone);
 
 	if (unlikely(!backbone_gw))
 		return true;
 
 	/* this must be a CLAIM frame */
 	batadv_bla_add_claim(bat_priv, claim_addr, vid, backbone_gw);
-	if (batadv_compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
+	if (own_backbone)
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
 				      BATADV_CLAIM_TYPE_CLAIM);
 
-- 
2.47.3

