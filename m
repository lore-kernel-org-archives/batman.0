Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E73DC61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:29:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E17C180337
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:29:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103742;
 b=lOO/VatEJKQETZ3weKc8ub6triTWqsLd8mIYrcZ/6WxIH3i+9pB3CkunBgqcURi24xFzn
 rQojR1r3cz0kNeWJsW8/2nOuTsEnmJATY7xWtneb6d0KX3BMOLnIzPKkmA2LsvAyhecTT0a
 rX6a8Yh3eUkvuZGrieUQu2k2+ncVk7I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103742; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2TBA3OBh+Ak5kokGccUsJz0FXzfRFMdBlb05ExkVL58=;
 b=GIsPcr/UhMJ+UBXcioUeNEJ2vsenQh7pSjrQ7Rmgw34iHqF5MDZwofnr2FralrdOs1jjQ
 Md0OP8vAYX/61tKyX8S4DtQtozvfMHO3Zve5aTlMvvz898iaHRMGC3NAJhrjaNfh6izqpzP
 NVi96g/M2GLN0EFGjhbiVepoeGH7Elw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 03CDA803F9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103369;
	b=J1oIY3Bz3YsQWB5zqzfYAOcIRluh36h9zDtSkmuPDybniauzsTzz0pdOL46S+A05XSMX2b
	TLbCMXSbXcemQOU9pzeX5HSKaczcAisbkK0blzCl4+8WBBGtPC8bLter5UnZArIGRNH/Ig
	3Sd9zcWvtJxBFutaB9eM0FvdZiYrRjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2TBA3OBh+Ak5kokGccUsJz0FXzfRFMdBlb05ExkVL58=;
	b=NBUENKXAYEYJQS+pPDv8FzdvDdEjsGEFHwb44dc7sTG+txsDDm60yYA9ubFgtftfgk/e6c
	jvEGEMbptDnnLnw88w6HX4kE0T/yBLc9gRkUCjpuaQitIL0qTdxENT5G7LNb4sF4vd5vT5
	rDfQ80ij6hvsz4r3Ty9lq5rf5dlJGtE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aXGKJnoZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9D4042083E;
	Sun, 30 Aug 2026 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TBA3OBh+Ak5kokGccUsJz0FXzfRFMdBlb05ExkVL58=;
	b=aXGKJnoZy1J3dYNGlYBaqOXCWIIPq4rCDvcX4GJamWvCZ87h2PmsA/FHWcfcH75ckY4v3E
	BrHj0nE6RH6P/oBeLIPeZXXbeoi6Y72YbznHQ70Qm2kKZWeiimgwCzj8oaq/aYOIjTjHeh
	FtkdNkUbJSiYGJwFI/ov3fdoOoA25hk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:50 +0200
Subject: [PATCH batadv v6 13/20] batman-adv: tt: extract update of dynamic
 client flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-13-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4426; i=sven@narfation.org;
 h=from:subject:message-id; bh=HwmlzKVWrv0BIiYqhaj1Z/ldPbO24aczi39rJzoWmQs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpvxyj/v71iWky18lnfT1Kbn5Qfqlt48PqNg5/UT
 WJ/Lj5T1VHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiLcAw/+wvi8+luL6UU4W
 l7n7V+668ZGvd9l++9rMcHPxmBamh1oM/0snZP8OPR7Ks319BMuEKqcSRaNF/WK8Vy/t/ntersf
 0CTsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2P5LUCVFOAXLFW46MJS57LQORJ5EYJHV
X-Message-ID-Hash: 2P5LUCVFOAXLFW46MJS57LQORJ5EYJHV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2P5LUCVFOAXLFW46MJS57LQORJ5EYJHV/>
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
index 8065b2b9..cc4c4963 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -900,6 +900,55 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
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
@@ -923,10 +972,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
-	u8 remote_flags;
 	int hash_added;
-	u32 match_mark;
-	bool modified;
 
 	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
@@ -963,35 +1009,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
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

