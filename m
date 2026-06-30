Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FCCC43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:11:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A039B83FD5
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:11:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828679;
 b=s1cUQkWLUCrN370HfJYqyZD+d+JUUarV8WQ/JlbPb8+WrWZOmA5PRVroI0wF/OnngzCj8
 8c/JJVmEqw6BnUgL48CvTs1JBHdtFEk0cu0XGEH/DIRP3nbrvtnNODqFK4vzhiTRo9QGsAf
 7OvyGSAF80GH1yodZ3hdwAoM6afn7Zg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828679; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FnvUe6Opebjp4crldOSLq+segpIbxB7KcINVcKbi988=;
 b=vsJEebVccl9koiMMam850r6l8exEJCpa75+Tq4w9LhwpNYdlPUnH1+4I83rWHD6QIGIkI
 hYCKnzj6In2/Lh4GJq48LafSNGd236E+kTXIGuAxgJQxVyEEvGAEtuAs6LwK26bh+oGycr1
 /Vh4X4u/MlTHvZyGgFnoLyEoYs+J/vU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 758E1810A7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828391;
	b=UM1c5UQ/yAA6Mh71bXHj2nvpEKSU/UGJjMbrsBX2iR9D+smKnjbvqJm4mA+grNiEjnskgQ
	ciq3fNDIgm0jbpNT9EK8UrQrVFVuDpVdZCWvdxDwkIB+Rk1qnHpxao3BfJcSJkP5DYzDVF
	ToJlKhWZjoPpYJ05sLSDbM4CBaJx//w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FnvUe6Opebjp4crldOSLq+segpIbxB7KcINVcKbi988=;
	b=Sxxe8R4vllAAxj1tcD3OV0HkTAWEHmNKz2c8PSntrKOUisdE9rlSoWAc9kDHgHFY8QgJCP
	a04M8DRvQ298gY9E1FKBz3bhbx63n0el+n+wC4AAImdtbq9+peKmctTxYExf8B8UjWs71Y
	SR33PQrUqy9Ritiet95vEY4RZJLwyqU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=SKTFjl3M;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnvUe6Opebjp4crldOSLq+segpIbxB7KcINVcKbi988=;
	b=SKTFjl3Ms0ChEgAsHn86Nb4VmGcqFWSfGsZpfpZLpAJ/a/nYvVLsVXE6t23xaWtIkEwAtY
	RhaVAtHJi1fGAaFxcTROeddqeTe9mUZFxEEkteKtBlDNhcqcDtMG5L9Z8+jBqKhgvMKczL
	OkGuSwC4IM69z9xYNzQ4qNdwdHQTz49LsZITaFKBL+aUlOfD74aNY/p6jURZ+CIBgnE1V8
	0arhCbEtpFenn/9i+uw3c5q3mIlP+jFm4ro/nzp9BLor0PIlxUBlasOWE2rOtS+neMWH6H
	usEx6/uhB1GvT1lPXmdSYlPpa09YaZKkSm5dqZ38KHR85N6Gn2WxkHbJmv/Oig==
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
Subject: [PATCH net-next 08/15] Revert "batman-adv: v: stop OGMv2 on disabled
 interface"
Date: Tue, 30 Jun 2026 16:06:16 +0200
Message-ID: <20260630140623.88431-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AHCH5FJEOFHAIGEVL2RMZNRALAZDJQPV
X-Message-ID-Hash: AHCH5FJEOFHAIGEVL2RMZNRALAZDJQPV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AHCH5FJEOFHAIGEVL2RMZNRALAZDJQPV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface doesn't work anymore and is also no
longer necessary. The extra (complicated) code for the sending of OGMv2s
can therefore be removed and the original code can be used again.

This reverts commit f8ce8b8331a1bc44ad4905886a482214d428b253.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 037921aad35d5..e921d49f7eced 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -115,14 +115,14 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
- * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to send
  * @hard_iface: the interface to use to send the OGM
  */
-static void batadv_v_ogm_send_to_if(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb,
+static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
+
 	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
 		kfree_skb(skb);
 		return;
@@ -189,7 +189,6 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_aggr_send() - flush & send aggregation queue
- * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: the interface with the aggregation queue to flush
  *
  * Aggregates all OGMv2 packets currently in the aggregation queue into a
@@ -199,8 +198,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  *
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
-static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
-				   struct batadv_hard_iface *hard_iface)
+static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -230,26 +228,21 @@ static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
 		consume_skb(skb);
 	}
 
-	batadv_v_ogm_send_to_if(bat_priv, skb_aggr, hard_iface);
+	batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
 }
 
 /**
  * batadv_v_ogm_queue_on_if() - queue a batman ogm on a given interface
- * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to queue
  * @hard_iface: the interface to queue the OGM on
  */
-static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
-				     struct sk_buff *skb,
+static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
 				     struct batadv_hard_iface *hard_iface)
 {
-	if (hard_iface->mesh_iface != bat_priv->mesh_iface) {
-		kfree_skb(skb);
-		return;
-	}
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (!READ_ONCE(bat_priv->aggregated_ogms)) {
-		batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
+		batadv_v_ogm_send_to_if(skb, hard_iface);
 		return;
 	}
 
@@ -260,7 +253,7 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
 	}
 
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
-		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
+		batadv_v_ogm_aggr_send(hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
@@ -357,7 +350,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -397,14 +390,12 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
 {
 	struct batadv_hard_iface_bat_v *batv;
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_priv *bat_priv;
 
 	batv = container_of(work, struct batadv_hard_iface_bat_v, aggr_wq.work);
 	hard_iface = container_of(batv, struct batadv_hard_iface, bat_v);
-	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
-	batadv_v_ogm_aggr_send(bat_priv, hard_iface);
+	batadv_v_ogm_aggr_send(hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -601,7 +592,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);
-- 
2.47.3

