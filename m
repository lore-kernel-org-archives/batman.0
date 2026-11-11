Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA7606A31C
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=jGpwnbn1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A5E785ADC
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:35:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393303;
 b=SKP0uOa0CFwOzQ+WtWup971ktfl8bQsAzELDobZ6cOuHCQVnpR96UAlWrRUXAKacU++/1
 d5dGM6hzMF41RU6X+PaxgA2B81Rb1Qa1CayeehoubFFgbNRMKhcrR49kktFeQaSo1VyBiN5
 mRB/+usbuYwylnE5xwN4U0iTKiLoI7E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393303; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9QKOMeV0vIGITZxOlcL8FwOZGUAIGR/9wBMhtY2e9ao=;
 b=AvmdLrtfj9rrQDRAgLU/pYPGEmz9b9MhCrulVkGYxX2hDNQ0AzFZBfkwkOLNoroNhB6wR
 4kRJd9WN4sOzf4WWx2tQvw1odAphbdQ+D3qlv50KvFtWSkPijS1U55uRUWh/M0Ojj1nhH42
 GVXmBdhoaeWAhGw8JfOKJNNPfPyoGGU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 70D6D80F54
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392874;
	b=ADyzT4zI+oMv3hXD6cdlNNmcXaCRBOuXmsTrZnUsNC5GNpo4w63ZIeVWiT+Wy5p0SbaLaF
	dTuqhtZass64Rih1hQpvYgoyY2YZyGSrq6RbozpBbJwQ75n9qqW5y5QDDpHbzbHGkA6fTm
	KrnEhTGu9bJH4PgcebzA3CRXS6UQBK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9QKOMeV0vIGITZxOlcL8FwOZGUAIGR/9wBMhtY2e9ao=;
	b=a3EDb/0GZ0XAzA7Kt+vPLxpPbYyjHdb+6HM5/f1judJ3UQuB0Q5SGsvVhyXbTCzSQQpKaG
	N7KP3rw0iEHPmZvpob90KzES0x9Bn4/ojmlhbS5bG85SyiwQ647f0H4QqwazJdQgghQTkj
	2zom+uUEl042fh9bnpgkNJLH0oHJNXM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=jGpwnbn1;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740deD843BE7e4a980E9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id D0BF4FA2ED;
	Wed, 11 Nov 2026 11:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QKOMeV0vIGITZxOlcL8FwOZGUAIGR/9wBMhtY2e9ao=;
	b=jGpwnbn1W+NnSk9/c/bB3FaXWXWdTR7fh2m8d9vQxaZmLXqmyWAPslA+PhtlCc5ihQx00i
	m/2BUldDx6YoPWAeuha1uCy1rXQ4ob8Cwr7rJlp03Qg/64niyROjpFDJNApSQyCKmaIiFV
	uvrVw/pxP1XGjsqTvz1D/WXV7OVgdRx19cKAx8eFoVTRL/S7+l0X4sA3ZD1aPT+oH/gTW0
	WU/kk5kY+NtTwky/6aoKxAqr7OVC9o2Unkd7kpGmsX1eiF4Z98pTPqOZDMiht7KMcAd9EZ
	o7vo282k+PVNpmv+4o9WvLtJwOtUCQMShCpTo8yJ/azAjNILfqplD04vTR8lHA==
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
Subject: [PATCH net-next 10/15] batman-adv: annotate neigh_node last_seen with
 READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:24 +0100
Message-ID: <20261111102729.2096241-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MP66NMWQ3IJQBAEHOCZG3UD672PNLVIH
X-Message-ID-Hash: MP66NMWQ3IJQBAEHOCZG3UD672PNLVIH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MP66NMWQ3IJQBAEHOCZG3UD672PNLVIH/>
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

The last_seen field for batadv_neigh_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-6ad653e2-1ce9-4124-bdf2-2187de5a2c16
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 net/batman-adv/bat_v_elp.c  | 6 ++++--
 net/batman-adv/bat_v_ogm.c  | 2 +-
 net/batman-adv/originator.c | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index ee3a5ac465012..d4b6c09db8c7d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1169,7 +1169,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (!neigh_ifinfo)
 		goto out;
 
-	neigh_node->last_seen = jiffies;
+	WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 	spin_lock_bh(&neigh_node->ifinfo_lock);
 	batadv_ring_buffer_set(neigh_ifinfo->bat_iv.tq_recv,
@@ -1289,7 +1289,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 
 	/* if orig_node is direct neighbor update neigh_node last_seen */
 	if (orig_node == orig_neigh_node)
-		neigh_node->last_seen = jiffies;
+		WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 	WRITE_ONCE(orig_node->last_seen, jiffies);
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6ad6042a5d9b6..cf84aed0c947e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -506,6 +506,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_orig_node *orig_neigh;
 	struct batadv_neigh_node *neigh;
+	unsigned long last_seen;
 	s32 elp_latest_seqno;
 	s32 seqno_diff;
 
@@ -531,8 +532,9 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	if (seqno_diff < 1 && seqno_diff > -BATADV_ELP_MAX_AGE)
 		goto hardif_free;
 
-	neigh->last_seen = jiffies;
-	hardif_neigh->last_seen = jiffies;
+	last_seen = jiffies;
+	WRITE_ONCE(neigh->last_seen, last_seen);
+	hardif_neigh->last_seen = last_seen;
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 03c70d91e64d1..cf3c1d22761b9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -658,7 +658,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 		goto out;
 
 	last_seen = jiffies;
-	neigh_node->last_seen = last_seen;
+	WRITE_ONCE(neigh_node->last_seen, last_seen);
 	WRITE_ONCE(orig_node->last_seen, last_seen);
 
 	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3b925ba9c9723..352a88056e334 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -698,7 +698,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	kref_get(&hard_iface->refcount);
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
-	neigh_node->last_seen = jiffies;
+	WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	ACCESS_PRIVATE(neigh_node, orig_node_id) = orig_node;
@@ -1126,7 +1126,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node_tmp,
 				  &orig_node->neigh_list, list) {
-		last_seen = neigh_node->last_seen;
+		last_seen = READ_ONCE(neigh_node->last_seen);
 		if_incoming = neigh_node->if_incoming;
 
 		if (batadv_has_timed_out(last_seen, BATADV_PURGE_TIMEOUT) ||
-- 
2.47.3

