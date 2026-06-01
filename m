Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23190CD6E56
	for <batman-adv@archiver.kernel.org>; Mon,  1 Jun 2026 12:44:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B0FA1845CB
	for <batman-adv@archiver.kernel.org>; Mon, 01 Jun 2026 14:44:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780317860;
 b=IPct2MPNMFlpIx3fJ8Fbav/r5LG5TlpArtnuR1Irf6gauP/N97GBmPMZ5LCJXq2R/X08q
 vCZwxN0S/hwX5PyWobtx2NX0sQQ4kB4J3GuzewhQyXKQWgAJRkLXWJTDlywiV8FmzJXG8r7
 oBlnLvh6eOCIxYug7VSdW3ISeXw/6S8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780317860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0vpRjqjY2w5mS544bDCKDeT51ksrzBuRmx9pJ3+DYKs=;
 b=2YIkMug0KuaOQXDU9beK7PljSNQ7+uV7ppFxut1+f72D3kHMi3VDlC7Uc3VkfstpxFDQ6
 +am5rctuc+yJsX5lA35foN0ypUZTl9lixUSStQW76hBPrJg5KKN0FhIe8sWUwOST7ozcRl3
 QkP+IbKWizmvtyJDFx9cfIHXVag2ijg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 59F3C8050E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Jun 2026 14:36:51 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780317411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0vpRjqjY2w5mS544bDCKDeT51ksrzBuRmx9pJ3+DYKs=;
	b=TcFcHyzfupqi+sfJvhZ9DsoURyHs3C2Lu40JBKB7uOaIz2kwgqdBBmXDFq39Lb0FZJTVjl
	ujmFOyDBtoOvNJ0rjFx8sGtWXbVmw6kS0cxoX3AgEDGLLxjaIGrAhLqhuZ96NGjywsNC6W
	dD5whr1yjSwWDIu3WvNsOwC4eJr9U/E=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780317411;
	b=UfNw7nZ4ZrK5/Zi36oXzWt9vIVV8t7xb/K+wSzpG/oeB/NeM4qKHDXJ56rpqx1okMHGskw
	/K48bhqOQIy+BBzIv7G19zpb5sS7Ks8v9v1pMk6H6boHhjyCNqwqCsNJ8Vrd/H4MSdztcS
	93iVcxvHx3OWXa3H7k5NnTI8ZYMQ8to=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=j+9m7xBh;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vpRjqjY2w5mS544bDCKDeT51ksrzBuRmx9pJ3+DYKs=;
	b=j+9m7xBh1bIm+MWPXQWFQU/H0GJnoelDN/xmZkutrAC0sy9GbynfLWXOZyQrqCflD7kRd4
	V3RFWVjmPCpuFxxCmsfmxZANZorO9AN/DyJh39KbudYMcPQEEMCADMsSWWhvZDAwuRSLqA
	tc/l8BIiWxn1lHsshdFKw5eoliwPX2mJn6fezbmpS2/Gg5vGyG0fYlAp6Rba1ZzoXk6P/g
	vQZbO3CtgYNZe9zYllfiFI4akGDg7qfc+dQ2lfkBdokpoGpriPx44MLyLBJdM/ZZsDsVjr
	RyqU2orGaAA1CPYLAsrMO4W6Zq5mKqAf1kkwGWu8noMQPg8gt6yPdJ1LWg0BSg==
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
Subject: [PATCH net-next 09/15] batman-adv: replace non-atomic vlan config
 fields with (READ|WRITE)_ONCE
Date: Mon,  1 Jun 2026 14:36:23 +0200
Message-ID: <20260601123629.707089-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VSVRE2RQ7CKRYJVJWEQ77L2QP3ECOQG7
X-Message-ID-Hash: VSVRE2RQ7CKRYJVJWEQ77L2QP3ECOQG7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VSVRE2RQ7CKRYJVJWEQ77L2QP3ECOQG7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The vlan configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c              | 2 +-
 net/batman-adv/mesh-interface.c    | 2 +-
 net/batman-adv/netlink.c           | 8 ++++----
 net/batman-adv/translation-table.c | 2 +-
 net/batman-adv/types.h             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d529014857c90..a5398c5df2632 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -627,7 +627,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	 */
 	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
+		ap_isolation_enabled = READ_ONCE(vlan->ap_isolation);
 		batadv_meshif_vlan_put(vlan);
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 071cbf1c1d317..58cbb4f8a5abd 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -567,7 +567,7 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	vlan->vid = vid;
 	kref_init(&vlan->refcount);
 
-	atomic_set(&vlan->ap_isolation, 0);
+	WRITE_ONCE(vlan->ap_isolation, 0);
 
 	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->meshif_vlan_list);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 368072f0513c2..e5463003a3bd6 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -181,7 +181,7 @@ static int batadv_netlink_mesh_fill_ap_isolation(struct sk_buff *msg,
 	if (!vlan)
 		return 0;
 
-	ap_isolation = atomic_read(&vlan->ap_isolation);
+	ap_isolation = READ_ONCE(vlan->ap_isolation);
 	batadv_meshif_vlan_put(vlan);
 
 	return nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
@@ -204,7 +204,7 @@ static int batadv_netlink_set_mesh_ap_isolation(struct nlattr *attr,
 	if (!vlan)
 		return -ENOENT;
 
-	atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+	WRITE_ONCE(vlan->ap_isolation, !!nla_get_u8(attr));
 	batadv_meshif_vlan_put(vlan);
 
 	return 0;
@@ -1022,7 +1022,7 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
-		       !!atomic_read(&vlan->ap_isolation)))
+		       !!READ_ONCE(vlan->ap_isolation)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -1110,7 +1110,7 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED];
 
-		atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+		WRITE_ONCE(vlan->ap_isolation, !!nla_get_u8(attr));
 	}
 
 	batadv_netlink_notify_vlan(bat_priv, vlan);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 28869f65ada09..515f26ff8c269 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3730,7 +3730,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	if (!vlan)
 		return false;
 
-	if (!atomic_read(&vlan->ap_isolation))
+	if (!READ_ONCE(vlan->ap_isolation))
 		goto vlan_put;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index dd63cd28914d7..cf01a670d8250 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1459,7 +1459,7 @@ struct batadv_meshif_vlan {
 	unsigned short vid;
 
 	/** @ap_isolation: AP isolation state */
-	atomic_t ap_isolation;		/* boolean */
+	u8 ap_isolation;		/* boolean */
 
 	/** @tt: TT private attributes (VLAN specific) */
 	struct batadv_vlan_tt tt;
-- 
2.47.3

