Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AD606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=vnhlXKFx
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 188EE81BF3
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:34:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478861;
 b=a7YU5NXK+Ebkfi8YIqEqHyfycat2iuVCHgLt10YhNAZtJWkBDSQ4hxVYQ01B0GHzrVerX
 9qeYd+3T7Fg0MjG0K7pB/ollEmg23eSBhf8HPEP6nD8xDWndzWMnL2fM+yGNJUkug6ToI5a
 CHLy03wRHAj75wJy79Zya2o2wG/4SFw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478861; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4YIOPmx5XgAK6SNbwBEC2En/p7Qdc9V01jehnWisTuQ=;
 b=rC8kQKGOvvOJ+rBDUFYCfqadO4Pg8BPzQHYsy0rjgNeoXvYFTCkZgRUN14SvMUQCkbvuU
 gqB0veAUQB+QIg20YbyJ+b8qTe4INVxKGKV+sil7T5hRcNIwUg7GruzRkjx4ItjFHC1Ed+Q
 PT1rfty5GFxnzVw0iNWobzDce3g7Y9A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EF1C3842E0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478646;
	b=oqk4PPvhOFy5kD+V7+8g82wykRcaRK/bLdJZZdcQfNOgpgi19NdpQ7ELU6SUvau5Ihh0y1
	E0RejcRibJP425jki23tmaPtJI1Fo624+9e8Gjbj+yKwa1qg2K/2NDUdUF2mSUMnTTBFP7
	KiQFMPOro7skFwBzPR89LAmTCniuK8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4YIOPmx5XgAK6SNbwBEC2En/p7Qdc9V01jehnWisTuQ=;
	b=GENgy3feSjpz60UoDDp3IT55PcQ5lUFYRQI3BqyPagDKohBxf9H9DG7MXWfdm6h4cRI1u4
	QXnCUSuA7wLar6FHTe7VrZiY9UOiFzOVDCRMd0PHnkt6+6YvOxLfsIWKVSpebIkrxecz4y
	Bf1bO7JesnVArsoY/dcSnosMpKGYZBA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vnhlXKFx;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8C97B21015;
	Sat, 31 Oct 2026 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YIOPmx5XgAK6SNbwBEC2En/p7Qdc9V01jehnWisTuQ=;
	b=vnhlXKFxgbyDC+oWM1uxm78Hh2LVWH8kPgkfeJaQvDrZxTOPV54K8ElD+VVkgaAmZIKECJ
	3yQrF9YAYL+mbFUflqmq57+3YTvi16OfpGrE7zwcerG0ctcYWPGjIzSwHEC80o6Rj4R3yR
	J3UqUMFRgAsPB7S7z3rJyhWVHHtQNS0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:44 +0100
Subject: [PATCH batadv v4 4/7] batman-adv: tt: annotate last_seen with
 READ/WRITE_ONCE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-4-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022; i=sven@narfation.org;
 h=from:subject:message-id; bh=n5fjmYQM+0eXql0YPJU4PYDnggue+djjABjx/E1xlzU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/HetOy0xz2uyUOLy6BW8T4I23M8UtVnxMvSgyqdzv
 j1Nd5VTOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATeb2BkWGd1YmIND7PrNMS
 kXNuqXbLvVcz3aUxRfeiH4/RLI6I9y8Y/rt9elP8enmyVPHn4p7PaQo7DgoqdG4Q4k7ID4ydtHi
 WJzMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EIFJ45JMIVDMUI3AJQDWCGK2EKO3UURR
X-Message-ID-Hash: EIFJ45JMIVDMUI3AJQDWCGK2EKO3UURR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EIFJ45JMIVDMUI3AJQDWCGK2EKO3UURR/>
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

The last_seen field for batadv_tt_local_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 29ce2b36..8e43de5c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -970,7 +970,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	bool readded = false;
 
-	tt_local->last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, jiffies);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
@@ -1024,6 +1024,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
+	unsigned long last_seen;
 
 	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
@@ -1053,8 +1054,9 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
 
@@ -1530,12 +1532,14 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
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
@@ -1868,7 +1872,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
 				break;
 
-			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
+			if (!batadv_has_timed_out(READ_ONCE(tt_local_entry->last_seen),
+						  timeout))
 				break;
 
 			batadv_tt_local_set_pending(bat_priv, tt_local_entry,

-- 
2.47.3

