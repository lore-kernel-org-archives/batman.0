Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860B606A327
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=XWOXunOD
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5F5FE8592A
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:33:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393211;
 b=PZ+WrLh4fE0VMLOgLWT10Cnu2YMX91d+XsZ9szMH9XaleKh0ecQOq6xs02p59qCif+/US
 jacNCLE9KmrMvSzR6T7QaLIXIkcV1/7nUi1/2MCiNkue/Rrst8x5JBWulFmpJllMRqtlr80
 650YxgI7k2KmbTzVsMX9SwQxC/1HC6Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393211; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lOIbN1WC9f3tYk8ODaLG/icVZKFBVBuOQ0N3217s/zM=;
 b=eRhQ5U2f++j7LipcUCY4xcUWtnSj/EphA0uFvqwurEnmeGv2xfWTmXkJnr4R8xkTsKUIt
 q7pU+xO6tI6sS1nCCYMSsOThjgBr60SAjL3PBEU4MHolNu/WGNe6dhGJC98W2xrePQDjCl1
 u9h0A6XwK1wbyMvwHBePFupGH7Gk5xA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0393781D11
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392874;
	b=U55uv+8bXhgYVSYWYP9fBdbuDqpwDXBT9tVbRU4/bsGWL260yOWa3OMKOSK959BpCg6t0G
	+qf7rj4f2kk58j087S7dugFjGDYQFRumCpa6jx10f0US/TrvzRsEOC7YN1fH0rgKGjPMpj
	cLL7dX20X5NjgRratvGq3CbBxrvz0HQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lOIbN1WC9f3tYk8ODaLG/icVZKFBVBuOQ0N3217s/zM=;
	b=gfWgg+yWF7mWJkMrXfgJjDV6v4kGYLRIgXwQ7C3nlT1bfc/y4rQmwo8IFqQVdFC4UmCXMk
	sx4d8Fr3/1s1WBSNlm7BUVK8ucnuGSwbKlkfpORth3GdGc2ulSqN+Vfkv0I8KGIh8uq0hb
	jLDh4Filv2FSBySx+JUBJu7ruHTrEZ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=XWOXunOD;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740DeD843BE7E4A980e9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 7EAECFA272;
	Wed, 11 Nov 2026 11:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOIbN1WC9f3tYk8ODaLG/icVZKFBVBuOQ0N3217s/zM=;
	b=XWOXunODgWFI2kPC8eaN/q4DOJQzKG3IhUVsS23aG4TBCz151GkJ2Qa6RMoDVkKvkZXDDs
	HA0QKzAcb7SLzUO8D0o/GjHkPZz0IoD5hzMFOLaTw4l22XwqG8D2EQ7P0K3TkjEBO7KPww
	5VPzaYW3C/Rx6G3YlJULZfAJ1GQHKYov6u5bM+zMtS5wBzzU9m1gFM0cmlYEkKFfnhZIlb
	7RBMjv4cNRYallN6FxxcOakSyGGrJbbow4JZq0LbWNAq7v+O/A4Vk0ll5gM8qGNH1iYuEL
	irxwqHKSm1EqKQTxiMkS2K7GN2sRUbAnTY3oI90Kr3ippVDvXqK5/dPkPeTuHQ==
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
Subject: [PATCH net-next 08/15] batman-adv: tt: annotate last_seen with
 READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:22 +0100
Message-ID: <20261111102729.2096241-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CT53B5AK4CYD2VUAZ2YHQKGPUQITL23H
X-Message-ID-Hash: CT53B5AK4CYD2VUAZ2YHQKGPUQITL23H
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CT53B5AK4CYD2VUAZ2YHQKGPUQITL23H/>
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

The last_seen field for batadv_tt_local_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 46304069b3b75..76635ae82c84b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -917,7 +917,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	bool readded = false;
 
-	tt_local->last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, jiffies);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
@@ -971,6 +971,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
+	unsigned long last_seen;
 
 	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
@@ -1000,8 +1001,9 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	ether_addr_copy(tt_local->common.addr, addr);
 	tt_local->common.vid = vid;
 	kref_init(&tt_local->common.refcount);
-	tt_local->last_seen = jiffies;
-	tt_local->common.added_at = tt_local->last_seen;
+	last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, last_seen);
+	tt_local->common.added_at = last_seen;
 	tt_local->vlan = vlan;
 	spin_lock_init(&tt_local->common.flags_lock);
 
@@ -1477,12 +1479,14 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	struct batadv_tt_local_entry *local;
 	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 	u16 flags;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
-	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
+	last_seen = READ_ONCE(local->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
 	if (!vlan)
@@ -1815,7 +1819,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
 				break;
 
-			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
+			if (!batadv_has_timed_out(READ_ONCE(tt_local_entry->last_seen),
+						  timeout))
 				break;
 
 			batadv_tt_local_set_pending(bat_priv, tt_local_entry,
-- 
2.47.3

