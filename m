Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023CCD98CE
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 13:03:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8F99F80952
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 15:03:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781269402;
 b=DdkCiwK+sPZS42N0IxFn3NecU8XRzlkeAMSkhqYau3n8fclDuB2NIIKcdGNgbWI/gVzLw
 CalZuDJEO3Pt06LHCFPE6+kiW/n77Y/N84CyQdwhLhkorJp9rVAJLhnOcyrOqpCIIkmU0m0
 wtQg8R9GJcZeh/AcBWuMg9ZXKc2hZBU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781269402; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4diyvnqhgOUNMQfIAlESBojOlh4+pNx6VEhema+pSMM=;
 b=NVLEyHPNvTRQ/tgbHppXbZZ5sWQgqXl6Jp1BFNB8t1CQ9YutRT6q3m92pEswjI4fP5YV1
 dJ9/xA6CSP96xCEgt8btD5mekQQ4+2gdDO14DeRmm+OaSv4oqs1PkKGqXaWymMcHoi3KK9o
 6ZT8PCMs2n7TiPQ0yTe2JWLQX84155Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1B03980C12
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 12 Jun 2026 15:03:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781269392;
	b=IBVtYlSoh5tEoVjvgY0TMfrU/CcpX1UoJGe3sQVxHCI/t6EjcAkcX18YlZDGMMd/fkqUYY
	uDhYCk192fN4MNVu3H5yZjTldiY53jOrXuqFIrxyeRdz05VCfXv57es0R0VhUmVAXoNiBH
	MQip+J0GKMJ23z+ODJ6iMvthKif2AGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781269392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=4diyvnqhgOUNMQfIAlESBojOlh4+pNx6VEhema+pSMM=;
	b=s3HCnovmR6ChErZ7IJIcYS+HyXEypQqyKGebx7XtN2kpxbh1jn3rjBe/dsGVwL43Zd4rkg
	Ades2IL4reF5bVBLfILNsPXlXftegJVclQ39f/uXxssAl8oTi/tf5O5jar+reGaBSTvLe/
	ntSsq5A4QziWiDuKXeLTSFL49VgcoD0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RbmHhs9M;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 0B2001FD51;
	Fri, 12 Jun 2026 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781269378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4diyvnqhgOUNMQfIAlESBojOlh4+pNx6VEhema+pSMM=;
	b=RbmHhs9MJx6DhtgHy2XpwRWbkbRQuAaAMtCYeEza6gFy2Aqw7z9KuV0AfD5xhyBEA9vKgw
	9td08HeFhBAeFonA1bHMr3gS4uNX+wDnqNl8wCWW+iqmw7TvRnOG4TxrM5JvieWE6HErrx
	56Y9ewXtbHcqNnpvV2wBKYbgxU3sVRY=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Jun 2026 15:02:51 +0200
Subject: [PATCH batadv] batman-adv: v: prevent OGM aggregation on disabled
 hardif
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260612-bat_v-disable-aggregation-v1-1-4c4e17654ea0@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHoDLGoC/yWM0QrCMAwAf2Xk2cA6sTB/RUTSNq0RmdLUIoz9u
 1Ef7+BuBeUqrHAcVqjcReWxGLjdAPFKS2GUZAzTOPnRO4eB2qVjEqVwZ6RSKhdqVuE+5tnlOfk
 DB7D+WTnL+/c+gWWUOpz/Xl/hxrF9x7BtHwbiPumFAAAA
X-Change-ID: 20260611-bat_v-disable-aggregation-3cf91f9d65eb
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674; i=sven@narfation.org;
 h=from:subject:message-id; bh=DiPDS2sv16jo+WUtAufeyEvq7u5Ws9Jk97fLRrqJ9Ds=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk6zNVPT6pODnupsLLAU2lydXT3pT23S2Ldqss2qV3Ok
 fHsbK/tKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEykU53hD9fvNSl9QWY8d04q
 lfkuF+i7cf/nu8XTnYVeL9djVZ5jc4/hv+8ZFpUlW0MYv2QpTWwPCFJg+vCjXu7/iyn6TJ8ZJ3r
 2MgEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XJTIIUDZXRCSUY44V7LGWSE3SS5G4X6I
X-Message-ID-Hash: XJTIIUDZXRCSUY44V7LGWSE3SS5G4X6I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XJTIIUDZXRCSUY44V7LGWSE3SS5G4X6I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When an interface gets disabled, the worker is correctly disabled by
batadv_hardif_disable_interface() -> ... -> batadv_v_ogm_iface_disable().
In this process, the skb aggr_list is also freed.

But batadv_v_ogm_send_meshif() can still queue new skbs (via
batadv_v_ogm_queue_on_if()) to the aggr_list. This will only stop after all
cores can no longer find the RCU protected list of hard interfaces. These
queued skbs will never be freed or consumed by batadv_v_ogm_aggr_work.

The batadv_v_ogm_iface_disable() function must block
batadv_v_ogm_queue_on_if() to avoid leak of skbs.

Fixes: 2a5267fa7490 ("batman-adv: BATMAN_V: introduce per hard-iface OGMv2 queues")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c     |  1 +
 net/batman-adv/bat_v_ogm.c | 12 ++++++++++++
 net/batman-adv/types.h     |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index fe7c0113..db6f5bdc 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -817,6 +817,7 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 
 	hard_iface->bat_v.aggr_len = 0;
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
+	hard_iface->bat_v.aggr_list_enabled = false;
 	INIT_DELAYED_WORK(&hard_iface->bat_v.aggr_wq,
 			  batadv_v_ogm_aggr_work);
 	/* make sure it doesn't run until interface gets enabled */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 81926ef9..95efd8a4 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -254,11 +254,18 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
 	}
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	if (!hard_iface->bat_v.aggr_list_enabled) {
+		kfree_skb(skb);
+		goto unlock;
+	}
+
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
 		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
+
+unlock:
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 }
 
@@ -415,6 +422,10 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	hard_iface->bat_v.aggr_list_enabled = true;
+	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
+
 	enable_delayed_work(&hard_iface->bat_v.aggr_wq);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -432,6 +443,7 @@ void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 	disable_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	hard_iface->bat_v.aggr_list_enabled = false;
 	batadv_v_ogm_aggr_list_free(hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5fd5bd35..5e81c93b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -145,6 +145,12 @@ struct batadv_hard_iface_bat_v {
 	/** @aggr_list: queue for to be aggregated OGM packets */
 	struct sk_buff_head aggr_list;
 
+	/**
+	 * @aggr_list_enabled: aggr_list is active and new skbs can be
+	 * enqueued. Protected by aggr_list.lock after initialization
+	 */
+	bool aggr_list_enabled:1;
+
 	/** @aggr_len: size of the OGM aggregate (excluding ethernet header) */
 	unsigned int aggr_len;
 

---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260611-bat_v-disable-aggregation-3cf91f9d65eb

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

