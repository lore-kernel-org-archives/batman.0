Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E107CCD8C8C
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 11:59:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8374884326
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 13:59:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780833562;
 b=0+KBBshK67+R+U8Qp4ZAIftzCOvx+hK7c1h4E7vt4KPwEnozT0lt4bj4FK9Ybp7JQ7qmB
 o614h20paxuCTHZIh2qaVMXKeRqBq9ig0QPC9S1Z3qw2YT0SI2Eg9f0D954YuglhQhMjyw+
 TAo0XwOmUP0S37s+m/yBquRQ/2Nvz0c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780833562; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9EEcAQDzOKYXuJ9+tTt4QVbctPup0V7SEAVt/EljlYU=;
 b=RuKhgtsGYwF6oHcE3q0Fd0qgHkJywldKO+BYqZWEg0nGvt0fbnFK8IxujUeghJUjrPita
 eGt8W2SD2iz+wgOzjouGAhxFmlsjKKJsSU+yHGq6gUcXpOJOVjv5WOmWa/YNwuDsMBePxH5
 DGdXch3T1NXiz1lePI32DvnINlbLW+8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8DC878431F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 13:54:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780833285;
	b=wzT1C5mrRdhD9M+L5asB2tXIVZ4T6vDVRyxRv0KB/fda+YhRm2nE/UIQt3T+n911tmDbpI
	y/3EGqp5x7YSBy/Nznxl0DYOmX7I4hyQzx/tXK0+tx7v3eUQTOrUmt93LBdtS11xMAc9Js
	Ow/kNGegkKiVbNdbBdmhxcmfrOOSv94=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AFmRz9jP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780833285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9EEcAQDzOKYXuJ9+tTt4QVbctPup0V7SEAVt/EljlYU=;
	b=ZijpqE+bfReSGj+M69MfKbOIT5rCIgTgRhU4tPWtjZxCdprkbrw/DG8bxGQVSblP+ApDtC
	RouZ3mFYUCb3c1Q4cVOZeFvaSl2uQYFkfLG/GYzjuw/T53dEBksgxG3LQMNJAUufYKS6KL
	Z784B+nHMtnfraqZbtJvXsxPrxtsgdo=
Received: by dvalin.narfation.org (Postfix) id E2FD21FE06;
	Sun, 07 Jun 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780833285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EEcAQDzOKYXuJ9+tTt4QVbctPup0V7SEAVt/EljlYU=;
	b=AFmRz9jPeYBNMGmHuEndm+yYnOp/CLXzXvnhx3czXYH7x7/UGUcs57umYZfgLVxNWU0m1O
	iJDPXkXRVxujrpxcTDyCADBWdarKvapJ2fSucsWjmw0aWI3HqiNEAXdAtadDx6Uk3wsZnd
	xSDr5MGLTIOR2LAe2BCx0hP4mtsUjqY=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Jun 2026 13:54:00 +0200
Subject: [PATCH RFC batadv v4 6/7] Revert "batman-adv: v: stop OGMv2 on
 disabled interface"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-drop-hardif-list-v4-6-ade2931db295@narfation.org>
References: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
In-Reply-To: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4877; i=sven@narfation.org;
 h=from:subject:message-id; bh=1dqulA9Rh0WFOI4fGjJefvUlWfS3UlnZE53LAx00zlY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmq0bciqhoupE5001h07HXAStOdE6ssd6R95E/8OnH+t
 SuldWdkOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+b6Y4Z/Z/wlrGF4+jpTa
 /fAi7/8+32I9rZnLLarihJKvM8zKeXmAkaEjqCNi1X1WMalTs2fHXQi+P1ftSq7AWwH5zKNPGWd
 wL2ECAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AB2OHB246AITCWRRUIKTBSEAQNQV5CDI
X-Message-ID-Hash: AB2OHB246AITCWRRUIKTBSEAQNQV5CDI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AB2OHB246AITCWRRUIKTBSEAQNQV5CDI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface doesn't work anymore and is also no
longer necessary. The extra (complicated) code for the sending of OGMv2s
can therefore be removed and the original code can be used again.

This reverts commit 3d550f6440fc5b1e699120253d3673eee7d05c0b.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_ogm.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 81926ef9..6092f8a3 100644
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
@@ -230,32 +228,27 @@ static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
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
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
-		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
+		batadv_v_ogm_aggr_send(hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
@@ -350,7 +343,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -390,14 +383,12 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
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
@@ -589,7 +580,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);

-- 
2.47.3

