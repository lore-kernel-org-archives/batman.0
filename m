Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA606A326
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=TeFlIHpr
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 92A8585A79
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:34:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393272;
 b=OwVJDoMu5lJqBdoZQeYqweb+++NgEYxUhMgfrJ2dvLA1MLFs0ijMjL4/FcNPqMIyr20TF
 gcUI0Af5/WJpgHZbI4TDNtQa0v6RU2ub58Y0AsT7CMIv9uzzu7A7gGUES6AEGEwrj1m2Uh1
 rX3daz1k81td6TsrKadx0fkAu6Z+nWE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393272; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kqq7QJp+oe/MI0HfV6CR+NZX7tzpT/m/ilc9QLSDs5s=;
 b=3bKVetUV79AssTu+EcmUrMHwyBDlfUkuE2RkrIiVboheaLY6Mw5ieaayEId9yDET6/lQB
 /Vo+KT0ZUt/8B3+VnS50Po/jpAzYfpQAPgZ2vIKaeutWpMjbrHUukkxHritefkVykorFxuN
 oeaGKqoBur6LUl/boM3Z4QAH9VRGCSo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8487084631
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392874;
	b=Cvok+0mZcElzsBMVGoHX/m8LnCp/PySTfW9x0rdySgZ/aWaOMSQROF0nbP1Fqb9fCcxM4u
	1B/xqMEF/fOLu3Ha4NKMLmBd4OZkhnQo0DR0nNUzLz/R4xH13Crn9LFBpilK3jAsvlJCg4
	1F1LcYcXnqBlx7/M0sbJHqv/a2oFe3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kqq7QJp+oe/MI0HfV6CR+NZX7tzpT/m/ilc9QLSDs5s=;
	b=eV9JBk8jYguvlZ6tj6vJXPrq9z0SoADApoWwV8m6KKrFh4r47RNLXx9oZoIJJpUiFrFB2Z
	rVXrW4mpt2YSDMJf+lAkOTtDR6P3Ggwgeq6B9rArdRlIY1istq6LrEkAb8wWG1JuDiNmbl
	u286MhoMLgJJY7jU1RSefd5SU/t7ze8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=TeFlIHpr;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740deD843Be7e4A980e9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9989BFA2EE;
	Wed, 11 Nov 2026 11:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqq7QJp+oe/MI0HfV6CR+NZX7tzpT/m/ilc9QLSDs5s=;
	b=TeFlIHprzFyctCW3axtbf2Gixwcf3JCP4TRZSvCpNvBghbp4Izq8M+c5I0lJs8kGkjGipH
	+5YV+tvs4vTslxT/jFLz45Jxuj8/3fUiqzvJi8ToUd0uFMcTmKkApCxamSMVRL2gS2ZjGp
	1aticfZRQRIiiADc7YimhHjYbBn4SYeXAqaBbFjk63pOkJS5TNXLi7AZM8mW3jXvUAlbfF
	/xN7itJroOL0+mZQ+O/t8wK1XZMkmFhuJLhPsqntqksjzeAf/RP9uw3NZHQxfHdZlF1mnJ
	k2rqBPXo0iY4kK+UqdBoIZpVtzzl8UeivxbQ64f5yGlnuS3OXXItghHpG2/nJQ==
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
Subject: [PATCH net-next 11/15] batman-adv: annotate hardif_neigh_node
 last_seen with READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:25 +0100
Message-ID: <20261111102729.2096241-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YNMA65BVP73BNJOFZ32SOYSHOYOC3BJ2
X-Message-ID-Hash: YNMA65BVP73BNJOFZ32SOYSHOYOC3BJ2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YNMA65BVP73BNJOFZ32SOYSHOYOC3BJ2/>
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

The last_seen field for batadv_hardif_neigh_node tracks the jiffies value
of the most recent activity and is used to detect timeouts. These accesses
are not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be
used to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 net/batman-adv/bat_v.c      | 4 +++-
 net/batman-adv/bat_v_elp.c  | 2 +-
 net/batman-adv/originator.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d4b6c09db8c7d..4e15af1e245a5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1569,7 +1569,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		hardif_neigh = batadv_hardif_neigh_get(if_incoming,
 						       ethhdr->h_source);
 		if (hardif_neigh)
-			hardif_neigh->last_seen = jiffies;
+			WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 	}
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
@@ -2287,9 +2287,11 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
 			  NLM_F_MULTI, BATADV_CMD_GET_NEIGHBORS);
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2679090c3368b..bd2bf2b58635e 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -161,10 +161,12 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
 	throughput = throughput * 100;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index cf84aed0c947e..144bb30d608a8 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -534,7 +534,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	last_seen = jiffies;
 	WRITE_ONCE(neigh->last_seen, last_seen);
-	hardif_neigh->last_seen = last_seen;
+	WRITE_ONCE(hardif_neigh->last_seen, last_seen);
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 352a88056e334..0f47ac3ecc967 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -587,7 +587,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
 	ether_addr_copy(hardif_neigh->orig, orig_node->orig);
 	hardif_neigh->if_incoming = hard_iface;
-	hardif_neigh->last_seen = jiffies;
+	WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 
 	kref_init(&hardif_neigh->refcount);
 
-- 
2.47.3

