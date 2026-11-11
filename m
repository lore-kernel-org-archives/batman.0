Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C860A262C
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=rP54EsoB
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4831885BE7
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:36:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393369;
 b=Ttidt2lya2ya2+t64xVLkf57c+I3iOABAG5+CmSLZMcUzAny5sy7vnzxDy0SXTeJ1CVM3
 shF+jeQ59fOQOHs/FBHqjZEfT/8I+XBLiKUar2qp9GDAwJPV6uojRUPqDSzu9hS5HFQfbtB
 vbLY01Se3GM/7bpL5sCEch9BHZ2ID6o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393369; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=k0B3UfgQB/D8vYRdJmCukT9HrfQad+gn9eBgWfJ7V6I=;
 b=0pBsCFpqocfF9quCbnqgpWzhScJvCl0cROcLMtAGtSOXad9o/99x4naovfHTowSKRcVI2
 ADqKdGndajXyHxuGxTorHYt9btlPAsvszqaKOj8JPfL7jn/uIDyNPgqU2HXgMGt4SLCKw7T
 jXKaOYzokBdrLh7E+3CtlFsGQaltgrU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3670F80725
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392875;
	b=YlmsA6q6aAQNanca+ewvLij2F36Pvi9abRKt7A7Jt5eaeOMe4gLkVM7v2wEkj3rCwxgLtV
	QjKvO1cZrG+UK/T7ikOt/jYB1V5l4R68dCOMVx0HeWvF4mfuzYJ0pRrFKP5/LgqlOKtIE/
	xsFKw+ghtdeJmn/CQLWYkSYZdQYkOJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k0B3UfgQB/D8vYRdJmCukT9HrfQad+gn9eBgWfJ7V6I=;
	b=ZoQbMyVT58LBSdabFUtPRxresXcBwi10Uo+YIeDrHSVv0jYvRYNainkeYOBzg02FbEnp8G
	7Ut3ulL1iWkyPvdbTQk4e+40yYvr5NaqeoHf+eVNyk4g2tQyXW/LobYcNvWQmhCd9hwDR1
	ufFFnH66Ddq9zAqc9tHaWN9R8hcVeSo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=rP54EsoB;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740deD843bE7e4A980e9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9241BFA2F1;
	Wed, 11 Nov 2026 11:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0B3UfgQB/D8vYRdJmCukT9HrfQad+gn9eBgWfJ7V6I=;
	b=rP54EsoBoKySbRouSkdQwtz/NnxKTDKb/tdp3ZVF5VMUkxro3oiGoLu5ToDuLpzgOi1vwM
	CFP7KJSLqboDYHsmZl8IYXYRNi4uk5np5zQHLQZl09r4PGf/7id0DFIqoE9v3ztvtvy48C
	yMzRhWMXn+tu3X6w28boyPK50vU++4qLlaMjGhvJYOVdq2RJ4wCESjKv/S+QPFM7zL/9xQ
	1flOBQs/POKUEurdN4UjbvuZhwvQE6lYvBtWyeYYQ7+9ZCXpN4rk5bmnwhS1kjvxCmxvzy
	NbD9vcVfx6vZjA/NYgxneHDWKcyPJhMfLqn2QJp53MDyh016ouFaKYnKnfBsng==
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
Subject: [PATCH net-next 14/15] batman-adv: use bool for boolean flags
Date: Wed, 11 Nov 2026 11:27:28 +0100
Message-ID: <20261111102729.2096241-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5N3RD7KPQJW7ZOWVC4GUBVIRQ37E5YFO
X-Message-ID-Hash: 5N3RD7KPQJW7ZOWVC4GUBVIRQ37E5YFO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5N3RD7KPQJW7ZOWVC4GUBVIRQ37E5YFO/>
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

A few flags are stored in int or u8 although they only ever hold true or
false:

* the own_packet parameter of the B.A.T.M.A.N. IV OGM queueing functions
* batadv_forw_packet::own, whose kerneldoc already calls it a bool
* is_old_ttvn in batadv_check_unicast_ttvn(), which stores the result of
  batadv_seq_before()

Use bool for them, and pass true/false instead of 1/0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 10 +++++-----
 net/batman-adv/routing.c    |  2 +-
 net/batman-adv/types.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9e529215a7908..0b2134a8f963a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -623,7 +623,7 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
 					struct batadv_hard_iface *if_outgoing,
-					int own_packet)
+					bool own_packet)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_forw_packet *forw_packet_aggr;
@@ -716,7 +716,7 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
 				    struct batadv_hard_iface *if_outgoing,
-				    int own_packet, unsigned long send_time)
+				    bool own_packet, unsigned long send_time)
 {
 	/* _aggr -> pointer to the packet we want to aggregate with
 	 * _pos -> pointer to the position in the queue
@@ -843,7 +843,7 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 
 	batadv_iv_ogm_queue_add(bat_priv, (unsigned char *)batadv_ogm_packet,
 				BATADV_OGM_HLEN + tvlv_len,
-				if_incoming, if_outgoing, 0,
+				if_incoming, if_outgoing, false,
 				batadv_iv_ogm_fwd_send_time());
 }
 
@@ -955,7 +955,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * respective interfaces.
 		 */
 		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff->len,
-						    hard_iface, hard_iface, 1, send_time);
+						    hard_iface, hard_iface, true, send_time);
 		if (!scheduled)
 			reschedule = true;
 
@@ -972,7 +972,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 
 		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf,
 						    ogm_buff->len, hard_iface,
-						    tmp_hard_iface, 1, send_time);
+						    tmp_hard_iface, true, send_time);
 		batadv_hardif_put(tmp_hard_iface);
 
 		if (!scheduled && tmp_hard_iface == hard_iface)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 79fad88cd039c..e2951bf047024 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -891,7 +891,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
-	int is_old_ttvn;
+	bool is_old_ttvn;
 	u8 curr_ttvn;
 	u8 old_ttvn;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0fece14c7e7f8..b3edfc71af4a7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2047,7 +2047,7 @@ struct batadv_forw_packet {
 	 * @own: bool for locally generated packets (local OGMs are re-scheduled
 	 * after sending)
 	 */
-	u8 own;
+	bool own:1;
 
 	/** @skb: bcast packet's skb buffer */
 	struct sk_buff *skb;
-- 
2.47.3

