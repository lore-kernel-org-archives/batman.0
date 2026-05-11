Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34483CD4840
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 17:34:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BFF2385BE4
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 19:34:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778520871;
 b=my7qh7jCudk3/upuu9TUy0D0qgmgeodvbFza9FWXVvxE/PkEIaJFWlmf8ypyk9Qr0fIZK
 Z6GD+A2zVCG0G5RVq0CFcFHQ5QF5s0Dib0FEzpfBfZih8e+SEia0/p7aFiRyWwncwcln4pc
 xWHyUdZ8HQyweCn8TxzMBRGZPlF+VsU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778520871; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AmYz1xVN+EAbin6zsVL9Yeu6tLfoKwKip0zE1eEXVh8=;
 b=E+FA0gUHNGsZ9Bz56pF96gOL+xqjkiWi3Okqz9QVdnuRP4KsdO0OpU3D4v82T44iB09/v
 +bzNwPzzYTUOz1336hsg+1qz3dfsppt+dyIaHb9lrVUK9zddr9W91PAO2edeQ0vaGCaGmM5
 39HscjkIoZMqJkVWtrsFJigorhPXzyE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3D073859C9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 19:30:20 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778520620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AmYz1xVN+EAbin6zsVL9Yeu6tLfoKwKip0zE1eEXVh8=;
	b=OCTB+QNxlipHkzR7VznxhCnYnr8Wdjg5a2xkF5Y+ZFCBMq+QZHWlxQCKSfK1Fhv1n3MYQR
	K2O+NWtjQ55kZG7VDiddZr/EEqoMawEDZ2DJhVchGuL4Lnb+q/nGDjaH63pFwDTTuI5QAU
	Z515c82BDyf6m9ZeYovCtZB7lgr5kI8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ehpI4Lma;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778520620;
	b=0S0vr/u6Ym3VswcXJbweK1HuR+6zDcqdINjAcKQWyTNM0p8MeOJYS0ypqP8vGow7RxtbfO
	qGVu6Ajk4HJii283DCqPINRVGih+g5U+c/93WRC2HYpbHSQlSKufMUk6KgoTWv+ZlqqepI
	4kXeqTildSWhG277Di9JFT1xwi57m9s=
Received: by dvalin.narfation.org (Postfix) id D2B5A21977;
	Mon, 11 May 2026 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778520619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmYz1xVN+EAbin6zsVL9Yeu6tLfoKwKip0zE1eEXVh8=;
	b=ehpI4LmaFo7cwA1YPTJ+XJtxxc/7bW2uNfPRIcezc+u+41dYLIrsg50csmVcu3SCSJ/F/m
	ff1CdiMx9DlXRCly1WhWiy+OEaKnTPMq3QfK1ue7cQQ5GQnYFTA9i8PSvymrsbp5g74pyw
	bsMGyUpzozCGgq5W8Y9vxB2Ds4SajKM=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 May 2026 19:30:03 +0200
Subject: [PATCH batadv 5/5] batman-adv: v: stop OGMv2 on disabled interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-yuantan098-bugfixes-v1-5-6adf6965f2b3@narfation.org>
References: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
In-Reply-To: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2626; i=sven@narfation.org;
 h=from:subject:message-id; bh=FUa5+Q2q3nkqdHMgp03WEEe8UAS1+NSZwIOSTWRtaFs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlMQtKMu15bOcyu7+fR9omzq3xxMbp56oeNoeklx06e7
 xNRPmPTUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZgIkxbD/9C3jkfd+9eZT9Td
 s+PnrdinMbvXhxp3BLF/rwuYPmn9Z2WG/0F6MdlvNmSVK+0qqdy60zHH6fm7ugstpjcWJZ5ICbe
 KYwAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QQRP56XF6IVOHM4KMO3RM2U2UWKSMR2H
X-Message-ID-Hash: QQRP56XF6IVOHM4KMO3RM2U2UWKSMR2H
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QQRP56XF6IVOHM4KMO3RM2U2UWKSMR2H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a batadv_hard_iface is disabled, its mesh_iface pointer is set to
NULL. However, batadv_v_ogm_send_meshif() may still dispatch OGMs via
batadv_v_ogm_queue_on_if() for interfaces that have since lost their
mesh_iface association. This results in a NULL pointer dereference when
batadv_v_ogm_queue_on_if() unconditionally calls netdev_priv() on the
now NULL hard_iface->mesh_iface to retrieve the batadv_priv.

It is necessary to ensure that the batadv_v_ogm_queue_on_if() checks that
it is using the same mesh_iface for which batadv_v_ogm_send_meshif() was
called.

Cc: stable@kernel.org
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_ogm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 9914346a..99a2ce9f 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -232,13 +232,16 @@ static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_queue_on_if() - queue a batman ogm on a given interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to queue
  * @hard_iface: the interface to queue the OGM on
  */
-static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
+static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb,
 				     struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
+	if (hard_iface->mesh_iface != bat_priv->mesh_iface)
+		return;
 
 	if (!atomic_read(&bat_priv->aggregated_ogms)) {
 		batadv_v_ogm_send_to_if(skb, hard_iface);
@@ -344,7 +347,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -579,7 +582,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);

-- 
2.47.3

