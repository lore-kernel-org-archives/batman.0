Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339CACD4F3C
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 07:11:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BBB4680C52
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:11:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779174705;
 b=q1Gzsm1dKTN7yt0ldP3v/+qsqCutXtlyxQzTQ5oQsIfgQUq6bswi85LfegPTdvn2yemYE
 qXLGbEnoPigv/NYT8lT8UJgHI46+Sksn+N7UENgedJ8L13A2XIHx5s4+nJidtH1rNmNd8YC
 gKsZ/cVE2o/KPu3P8c8R+uN3r5WNG8A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779174705; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2zFg2tKHAVuwDCRHVssocRcS0Pz6hMyzI4BTjJn/7d4=;
 b=p06Q7+Roc997tJ5XyHN5zFN/PVeRlrxQiLO8q07TIQ10Y+fUB0fLGv00M16LlK3HgaM1c
 8oKHEyplJC6T1VJqWbN9zhldpGxDsXYepy8OtVq5IuF+rbJbvc5OGv9X7cRKiPyJEj9NmC9
 bxbnb7ChnxCRsOfWhUGHevLcVMH/Cqo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AC7C380DEB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 09:04:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779174289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2zFg2tKHAVuwDCRHVssocRcS0Pz6hMyzI4BTjJn/7d4=;
	b=hiectq/wjBlWO+1cW/E+n6dUm4Q0y516GgsOtHeZAndXEgdto3uFzgUKVGan9ytCMEitdM
	fsyKnP75AYRfR7x/LdY6APJTPcMFlUa7tymtXeHAUm50PyRzubVh9jr0gRZPP8Yi4ORdt1
	Sa/up6qJoy5a4jKAHrZBNSFpvDMpHw4=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779174289;
	b=wjN+Nlmxswqm4UiDi7lzRLZ+QZh9t29wqkP/1URTU3OXUH2OkQsaO+X+2zoL4zoClYCHXq
	eroGg6DQH6hi82lYzZu0dY6mWDpn8MbRJO7kFkUdpRjTZrMqmAzQY6THMgA+3T+uSntPxm
	EP3jVjyOd2hdaoePJBtoP6A/RpDLsnU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YLEYetzX;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 326E11FE24;
	Tue, 19 May 2026 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779174289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zFg2tKHAVuwDCRHVssocRcS0Pz6hMyzI4BTjJn/7d4=;
	b=YLEYetzXcwLQeYltyHYMDQdEJ5JmvYuhQAcbS/aNecQDl1PR5cDSA7T4wcDlOWwGT72ER2
	vcsnLwmIjQ9kNVQ0XZVxKDoP5UqwENAIE5OQXXTueYygYLSCkdq25hBSw0GpYtMGa0Gf1H
	ZdkDEPZDkBNADjEtfEEXSKVxYC1M/wA=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 May 2026 09:04:38 +0200
Subject: [PATCH batadv v2 3/7] batman-adv: replace non-atomic vlan config
 fields with (READ|WRITE)_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-atomic-to-write-once-v2-3-1b643e847a56@narfation.org>
References: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
In-Reply-To: <20260519-atomic-to-write-once-v2-0-1b643e847a56@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; i=sven@narfation.org;
 h=from:subject:message-id; bh=EBsQSqvY1VpZh+FMxIZad8I+/b2VcB+ggvNcbPWu9Xk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk83K2mMXX3fzBt5m2xyN6/rWRuKmPHtEncGe62W78w9
 efeOxbXUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIqesM/9RlN1ectLl+zXcW
 Z3+ekv35tzrnZ+UJzj39pCxF6mVJ0DuGf+ZGrxy4dh+54aO430Fi2vYmDRavidx7j616I78mdb7
 iXxYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LAPAGA6JLJV3YRGVEOBQXWNMGRPCGE4A
X-Message-ID-Hash: LAPAGA6JLJV3YRGVEOBQXWNMGRPCGE4A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LAPAGA6JLJV3YRGVEOBQXWNMGRPCGE4A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The vlan configuration values are only accessed as plain loads/stores and
do not require full atomic_t semantics. Convert these fields to native
integer types and replace their users with READ_ONCE()/WRITE_ONCE() to
avoid load/store tearing.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c              | 2 +-
 net/batman-adv/mesh-interface.c    | 2 +-
 net/batman-adv/netlink.c           | 8 ++++----
 net/batman-adv/translation-table.c | 2 +-
 net/batman-adv/types.h             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a4d33ee0..4ee2b14d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -614,7 +614,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	 */
 	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
+		ap_isolation_enabled = READ_ONCE(vlan->ap_isolation);
 		batadv_meshif_vlan_put(vlan);
 	}
 
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index d1f50b8b..0e63fad0 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -565,7 +565,7 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	vlan->vid = vid;
 	kref_init(&vlan->refcount);
 
-	atomic_set(&vlan->ap_isolation, 0);
+	WRITE_ONCE(vlan->ap_isolation, 0);
 
 	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->meshif_vlan_list);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 64e26313..711746c5 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -180,7 +180,7 @@ static int batadv_netlink_mesh_fill_ap_isolation(struct sk_buff *msg,
 	if (!vlan)
 		return 0;
 
-	ap_isolation = atomic_read(&vlan->ap_isolation);
+	ap_isolation = READ_ONCE(vlan->ap_isolation);
 	batadv_meshif_vlan_put(vlan);
 
 	return nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
@@ -203,7 +203,7 @@ static int batadv_netlink_set_mesh_ap_isolation(struct nlattr *attr,
 	if (!vlan)
 		return -ENOENT;
 
-	atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+	WRITE_ONCE(vlan->ap_isolation, !!nla_get_u8(attr));
 	batadv_meshif_vlan_put(vlan);
 
 	return 0;
@@ -1021,7 +1021,7 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 
 	if (nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
-		       !!atomic_read(&vlan->ap_isolation)))
+		       !!READ_ONCE(vlan->ap_isolation)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -1109,7 +1109,7 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
 		attr = info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED];
 
-		atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+		WRITE_ONCE(vlan->ap_isolation, !!nla_get_u8(attr));
 	}
 
 	batadv_netlink_notify_vlan(bat_priv, vlan);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d72adda4..bfd0e720 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3769,7 +3769,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	if (!vlan)
 		return false;
 
-	if (!atomic_read(&vlan->ap_isolation))
+	if (!READ_ONCE(vlan->ap_isolation))
 		goto vlan_put;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c4b220fa..d5f9d130 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1432,7 +1432,7 @@ struct batadv_meshif_vlan {
 	unsigned short vid;
 
 	/** @ap_isolation: AP isolation state */
-	atomic_t ap_isolation;		/* boolean */
+	u8 ap_isolation;		/* boolean */
 
 	/** @tt: TT private attributes (VLAN specific) */
 	struct batadv_vlan_tt tt;

-- 
2.47.3

