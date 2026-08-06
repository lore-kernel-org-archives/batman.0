Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB38C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:47:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E455D842AC
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:47:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009663;
 b=wjtzI9m7DJX9wrA2cypkHekYD1n1AYDlSSPCNlPwuGiCc4JqRllHDUBH5igVkO934aPAh
 Z9aXh/jAErqLhKBtVQph3yBqT/o1wQSNqyOC3oTBfV1mUKZVYf9UX4KLXWvup8wJ6avNc9s
 w6qo6NLjAeDNWISwQzDfXgtboG85lyg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009663; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DGJwFA5zBR1CjKT9UrLElQ9lrJqWDJ7qVPMQ2zu1b40=;
 b=kVe4+X6G1EEWpXtLIjkZeg2XGkv1uolQCvI4jV64m1Uj0EtJMFa14sckCI/l3sLqIUPS0
 rbXR4i3cSJO5tpzskwFGeOyKahy81PhnW9QMgZEDQEryMdxs+XbmmTcRD3BaJe0oDc1MsOz
 4PnEyhodQXmMBmwTIl/2XkyG8+bWwuw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B6DEF84262
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009519;
	b=u03QUajITd9OD6dRr6T95ja04X8kBidwQhCOUTs4Bj5ah2UEkx6EjRKoEPU//f3cQACS4h
	hamO/a+HBGjuxLbMJ4OxKa/P8VJ/p5DRVQu4lIBqt5o3SP0X0om8Le1pweKahE7u0xS5lK
	eH3AEACQSO47QwyFJNRXFQUS12VVfA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DGJwFA5zBR1CjKT9UrLElQ9lrJqWDJ7qVPMQ2zu1b40=;
	b=2Pzwl2+5awL+/WwyvMuwcJqJjoOiE6N2r8KrBmiAQHopaAQlRsRsugAbkGaC0f9UnF9KOe
	8lZjlNByX5tN2iKaxpmE1AFpnr00NnHtYVdFTNwBGP4FC6JEsN8pdn7TUDwhmW0Dq1qfS4
	aQCWTID/8J6LOYracAKZD8mZKbA9C/g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=l5hDfuS9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5DEAC20590;
	Thu, 06 Aug 2026 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGJwFA5zBR1CjKT9UrLElQ9lrJqWDJ7qVPMQ2zu1b40=;
	b=l5hDfuS9UZYYDXEf7crJVRa2763kWcYGtx9D3DlToypMeSE6BkncwKotQPWMxKqIGuMIIn
	a4u7qQuyICAxpxy7ffBvYvySUgVRPU4VCVO6v28S1KTUY1y0wZgth4zFbiVh8HJ4P446uR
	rxdBXiM2e18RyINriFqfq41SDD9NKyA=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:18 +0200
Subject: [PATCH RFC batadv 05/12] batman-adv: tt: extract update of dynamic
 client flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-5-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4426; i=sven@narfation.org;
 h=from:subject:message-id; bh=2OtbvmeYAnaTSJQK4i5Q84FgKKj+F0q0AEpc+OBb3R4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4c0ptz6/FT/wZ+Jf5++yz2XXBS558FvvX77oBYV7z
 8IcVnyW6ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZE0cw19hpjvLQ5cFiYhm
 zBF8ftJk51WttTyv5M5qqdasvRbFcrCO4Sdjji2XfeU8RuEuzw2VHoJ2rLme2y37ag02T973NUn
 rBQcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WXKCQXBMUUXZZGKFWJYNTZES7XCULSM2
X-Message-ID-Hash: WXKCQXBMUUXZZGKFWJYNTZES7XCULSM2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WXKCQXBMUUXZZGKFWJYNTZES7XCULSM2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The WIFI and ISOLA flags are re-evaluated on every batadv_tt_local_add()
call, no matter whether a new entry was created or an existing one was
refreshed. It is mostly isolated from the rest of the
batadv_tt_local_add().

Move it to batadv_tt_local_update_flags(). To allow the caller to trigger
the queuing of ADD events, it returns whether one of the flags announced to
the other nodes actually changed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 79 ++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ca9956be..ba2a5188 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -899,6 +899,55 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	return tt_local;
 }
 
+/**
+ * batadv_tt_local_update_flags() - update the dynamic flags of a local entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry to update
+ * @iif_is_wifi: whether the client is connected via a wifi interface
+ * @mark: the value contained in the skb->mark field of the received packet (if
+ *  any)
+ *
+ * Return: true if a flag announced to the other nodes was modified, false
+ * otherwise.
+ */
+static bool
+batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
+			     struct batadv_tt_local_entry *tt_local,
+			     bool iif_is_wifi, u32 mark)
+{
+	struct batadv_tt_common_entry *common = &tt_local->common;
+	u8 remote_flags;
+	u32 match_mark;
+	bool modified;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		/* store the current remote flags before altering them. This
+		 * helps understanding is flags are changing or not
+		 */
+		remote_flags = common->flags & BATADV_TT_REMOTE_MASK;
+
+		if (iif_is_wifi)
+			common->flags |= BATADV_TT_CLIENT_WIFI;
+		else
+			common->flags &= ~BATADV_TT_CLIENT_WIFI;
+
+		/* check the mark in the skb: if it's equal to the configured
+		 * isolation_mark, it means the packet is coming from an
+		 * isolated non-mesh client
+		 */
+		match_mark = (mark & bat_priv->isolation_mark_mask);
+		if (bat_priv->isolation_mark_mask &&
+		    match_mark == bat_priv->isolation_mark)
+			common->flags |= BATADV_TT_CLIENT_ISOLA;
+		else
+			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
+
+		modified = remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK);
+	}
+
+	return modified;
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -922,10 +971,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
-	u8 remote_flags;
 	int hash_added;
-	u32 match_mark;
-	bool modified;
 
 	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
@@ -962,35 +1008,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
-	spin_lock_bh(&tt_local->common.flags_lock);
-	/* store the current remote flags before altering them. This helps
-	 * understanding is flags are changing or not
-	 */
-	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
-
-	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
-
-	/* check the mark in the skb: if it's equal to the configured
-	 * isolation_mark, it means the packet is coming from an isolated
-	 * non-mesh client
-	 */
-	match_mark = (mark & bat_priv->isolation_mark_mask);
-	if (bat_priv->isolation_mark_mask &&
-	    match_mark == bat_priv->isolation_mark)
-		tt_local->common.flags |= BATADV_TT_CLIENT_ISOLA;
-	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
-
-	modified = remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK);
-	spin_unlock_bh(&tt_local->common.flags_lock);
-
 	/* if any "dynamic" flag has been modified, resend an ADD event for this
 	 * entry so that all the nodes can get the new flags
 	 */
-	if (modified)
+	if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 	ret = true;

-- 
2.47.3

