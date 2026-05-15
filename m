Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5904FCD4F25
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 16:02:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B5D0B85C18
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 18:02:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778860940;
 b=JGje06a70LBsSzQQZuabPV21zpZ5g1owTVH5gZRKMPK1sWCkBLb7zRG3qgBoT3mb2MZAC
 3B2EFusAbCP2jRuZGzdbomiiu8kbjxCB5eQ8TPWxPo87hLt/QDMIbWCkZ3jJpBqGeDxbxzN
 dvOPhMQZERulx6YuBttYldQm6t4gEzM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778860940; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+Y48N0bHOIz3Ctf93I0QubR/c4EVO4zqiMdg4Fh5eRY=;
 b=a8tP9N6ICvn/maKgSj1bwENmUNM96Tb3TqyxzmulcIztjsTo1gGyTY7HOyR2hnAkRC381
 ALLmpMI8eBc7BeBZ6eL0uMYMro0l0sPk0zq6DJ7rnnGWchnmkgZjU57/w9xELAHAmT0/9kB
 9dnPJLZb2SyT+W993TPXcDNiU0jjsTw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 78C138264F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 18:01:02 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778860872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+Y48N0bHOIz3Ctf93I0QubR/c4EVO4zqiMdg4Fh5eRY=;
	b=xiePm0cXCMov7yUSxG1o2BLhw9vwMinCEpIxl4Ag0LuTEInFABwTklkzkgeM9q92MKVx8Q
	htSQ2KgjC+TrU+W0eN57ZSb01LKFy99PFVsdDt19rEDXAlHeCa7tVeIkv9FCpnkaywpNgQ
	FSiB2f4KwkH2bUoqdagJES4DixXcBbY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=H7oIvQl7;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778860872;
	b=20E1pl9te4Z6N5m3VY/W0FAEb0eqnZ9rlpQxEH4UHVd9boo14GT1v9op0ebgOtz1rqy4a7
	VJ9g7ZqKiQ3jnkBOyR5Oq52XWyoQbGJBuUJi9CF9kQWcw5HGqN5pHtL4DS7Go0qsNi+nv7
	jhKKbJefJGUJsZwTSkHhkBLNa5wVRH4=
Received: by dvalin.narfation.org (Postfix) id A64E921D8C;
	Fri, 15 May 2026 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778860861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y48N0bHOIz3Ctf93I0QubR/c4EVO4zqiMdg4Fh5eRY=;
	b=H7oIvQl7hSW0OzmXOib/JOGIgTxdxEsHqYJ+CDPMamRZlFOYI5siBVjMECRkgNCMQczfVh
	8iwpVnS6xAIFtX3Q+OcdOjmqBLTx9qabtiQ+rrG9pk7OlHYD3IDmupKxrSK7/FGs2yApU2
	tzxhCTcMVs9/Ld9EiuO/CrjrDgnr9OM=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 May 2026 18:00:10 +0200
Subject: [PATCH batadv v3 1/4] batman-adv: v: stop OGMv2 on disabled
 interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-yuantan098-bugfixes-v3-1-5a5a91924562@narfation.org>
References: <20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org>
In-Reply-To: <20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5385; i=sven@narfation.org;
 h=from:subject:message-id; bh=3IdIfm5C3nqdia6dMzDFXprM1RwTzdv9oIsF+4OXLRY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnszubadnOTbPTnGKXvEJnnObXI0aB61fri2p8O2/8o7
 lw0kZe3o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRK1MZGd7djtM6rCKx8EGs
 kNvtb2/lLuqZKDGm7zaecfbWFJ2QD5qMDPs0b0d3pPZcuJmupt3vE9oW1xAd+Y/vQWJEKef/vc1
 POAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XXJ3ZNCC3AODCNF3LMZTO7HPEQ6J5YOD
X-Message-ID-Hash: XXJ3ZNCC3AODCNF3LMZTO7HPEQ6J5YOD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XXJ3ZNCC3AODCNF3LMZTO7HPEQ6J5YOD/>
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
 net/batman-adv/bat_v_ogm.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e3870492..e955b494 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -113,14 +113,14 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to send
  * @hard_iface: the interface to use to send the OGM
  */
-static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
+static void batadv_v_ogm_send_to_if(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-
 	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
 		kfree_skb(skb);
 		return;
@@ -187,6 +187,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_aggr_send() - flush & send aggregation queue
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: the interface with the aggregation queue to flush
  *
  * Aggregates all OGMv2 packets currently in the aggregation queue into a
@@ -196,7 +197,8 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  *
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
-static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
+static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
+				   struct batadv_hard_iface *hard_iface)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -226,27 +228,32 @@ static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 		consume_skb(skb);
 	}
 
-	batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
+	batadv_v_ogm_send_to_if(bat_priv, skb_aggr, hard_iface);
 }
 
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
+	if (hard_iface->mesh_iface != bat_priv->mesh_iface) {
+		kfree_skb(skb);
+		return;
+	}
 
 	if (!atomic_read(&bat_priv->aggregated_ogms)) {
-		batadv_v_ogm_send_to_if(skb, hard_iface);
+		batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
 		return;
 	}
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
-		batadv_v_ogm_aggr_send(hard_iface);
+		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
@@ -343,7 +350,7 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -383,12 +390,14 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
 {
 	struct batadv_hard_iface_bat_v *batv;
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 
 	batv = container_of(work, struct batadv_hard_iface_bat_v, aggr_wq.work);
 	hard_iface = container_of(batv, struct batadv_hard_iface, bat_v);
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
-	batadv_v_ogm_aggr_send(hard_iface);
+	batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -578,7 +587,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);

-- 
2.47.3

