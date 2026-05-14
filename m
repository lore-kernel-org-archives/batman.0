Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A1FCD4F25
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 10:14:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 55EED85AA8
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 12:14:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778753668;
 b=DKK5m7APrUINls+pVxVTGxYnxSS0kN1we0jMnnhiDQmIjTEUb/a18wWUbMl1BE6HZb0nP
 TW9Z+VhQI76/IFc2n4qF8qWHTLB25Am/Rz31A3wO6fszemfm/1RFFy4OMvXuFtwsD9ZDsZt
 KNBU1GeUu0aT+ooz+SfNcWBEIdvN1oA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778753668; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=U0zTgYxHdD1m6RbaTPl+7No2tF/0kskVY+L8MaWEnIQ=;
 b=NR881znLa0+bWdHr+vTVblMYyffX2WqkJO39mGJi7jZ4amXmhEtFwOyagbpkumlmjjUiU
 XPiWepgTw95MmFUWXxwNZlRjCA1JniBrqWqXFdoYyTtxANiWquw9wIHKBd8woultuCXbg72
 bun31LHnux1df0Y/CyZpPIpcjq202+U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 138B0845D7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 12:14:04 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778753645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=U0zTgYxHdD1m6RbaTPl+7No2tF/0kskVY+L8MaWEnIQ=;
	b=UayCy+y0UwWCVlADYYvouXNEtjOWRDY16AawNYFpS0jmuW5G5te4pene7jZ9AQpKYhL5kq
	b7dnM9RbNqmrVhflIM2EaByH5JBL62HcFRxC4YwRMYl8KOdayhynW5hPgH84ra79hPoMGg
	zmT1ITsnVw86uUk+a1H4N2+ZUHMtgTk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xyMULtZD;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778753645;
	b=PUkwbQE+TGa/+O/nG9t+4km2tt2lMMaiY9Jo+81UWSvYwoxzzWe+egC26huvxUsAlMQZi7
	xCVVU4eEO4y81kJui+SUgbfDgnaVIgV6oQCTiwoCPaxCJpmdehro7uFiib1NNXCOaWpZXf
	NNgPPrJqZRlrSueDc1+meoOws13W2XM=
Received: by dvalin.narfation.org (Postfix) id 3AAC41FDDA;
	Thu, 14 May 2026 10:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778753644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0zTgYxHdD1m6RbaTPl+7No2tF/0kskVY+L8MaWEnIQ=;
	b=xyMULtZD1b3zUdo4TZMIbW2z3ZKXlMc3J32xVd+/4IL+YXEFVF0MOQ++kY/R7qsTmh4woV
	bhRb2GMs+YQvxyM+8o7B/yEdKj5Sit1dadlghsOr6xVDIXVAoIdF4HSqkPARbg3L+Mih2X
	a2tpjV7gP+rdqRIS0vLTkPWNHw3aRmo=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 2/3] batman-adv: split DAT cache into DAT cache and
 DAT DHT
From: Sven Eckelmann <sven@narfation.org>
To: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
In-Reply-To: <20250117021348.2021-3-linus.luessing@c0d3.blue>
References: <20250117021348.2021-1-linus.luessing@c0d3.blue>
 <20250117021348.2021-3-linus.luessing@c0d3.blue>
Date: Thu, 14 May 2026 12:13:15 +0200
Message-Id: <177875359527.23013.13660542318783039992.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6159; i=sven@narfation.org;
 h=from:subject:message-id; bh=RHbDLfrqO/aAVDpGEOZOFZM5VeoES6aXi0X9vZVIMRI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmsC9L17r1dveJbr7Oh6Bf1N3N+TRXLmpypmHRnsXDhv
 e8nv77e2lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYCKcSI8O9sM1sXydwdMhy
 cXTqnqoObl84lSvkpYzgn9TW0EvR118zMqxhmlzvfVR7r+C5d/usfCZMqfafdGXOPqZTvX9f+r7
 r/cQHAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZDQT46AIZU7ZG7OGIT3ACFBJFT2QVD4P
X-Message-ID-Hash: ZDQT46AIZU7ZG7OGIT3ACFBJFT2QVD4P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZDQT46AIZU7ZG7OGIT3ACFBJFT2QVD4P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 17 Jan 2025 03:06:36 +0100, Linus Lüssing <linus.luessing@c0d3.blue> wrote:
> Similar to the translation table split the (mostly) locally maintained
> DAT cache and the DAT DHT concepts into two separate tables.
> 
> This eases the monitoring and debugging regarding the origin of DAT
> entries. And allows to apply differing properties to entries in the DAT
> cache and DAT DHT in the future, like distinct timeouts.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

It applies find on 2cff5b1c6bba ("batman-adv: Use mailmap to fix old e-mail
addresses") but not anymore on the current main. This patch has various minor
conflicts with the rename of softif to meshif. It looks like the conflict has
to be solved like this

--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -144,13 +144,8 @@
 }
 
 /**
-<<<<<<<
  * __batadv_dat_purge() - delete entries from a DAT hash table
  * @hash: the hash table to delete from
-=======
- * __batadv_dat_purge() - delete entries from the DAT local storage
- * @bat_priv: the bat priv with all the mesh interface information
->>>>>>>
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the dat_entry as argument and has to
  *	      returns a boolean value: true is the entry has to be deleted,
@@ -319,14 +314,8 @@
 }
 
 /**
-<<<<<<<
  * batadv_dat_entry_hash_find() - look for a given dat_entry in a hash table
  * @hash: the hash table to search in
-=======
- * batadv_dat_entry_hash_find() - look for a given dat_entry in the local hash
- * table
- * @bat_priv: the bat priv with all the mesh interface information
->>>>>>>
  * @ip: search key
  * @vid: VLAN identifier
  *
@@ -397,12 +386,8 @@
 
 /**
  * batadv_dat_entry_add() - add a new dat entry or update it if already exists
-<<<<<<<
  * @bat_priv: the bat priv with all the mesh interface information
-=======
- * @bat_priv: the bat priv with all the soft interface information
  * @hash: the hash table to add to
->>>>>>>
  * @ip: ipv4 to add/edit
  * @mac_addr: mac address to assign to the given ipv4
  * @vid: VLAN identifier
@@ -865,13 +850,8 @@
 }
 
 /**
-<<<<<<<
  * batadv_dat_hash_free() - free a DAT hash table
- * @bat_priv: the bat priv with all the soft interface information
-=======
- * batadv_dat_hash_free() - free the local DAT hash table
  * @bat_priv: the bat priv with all the mesh interface information
->>>>>>>
  */
 static void batadv_dat_hash_free(struct batadv_hashtable **hash)
 {
@@ -1068,27 +1048,11 @@
 		u8 cmd)
 {
 	int portid = NETLINK_CB(cb->skb).portid;
-<<<<<<<
 	struct batadv_hard_iface *primary_if;
-=======
-	struct net_device *mesh_iface;
-	struct batadv_hashtable *hash;
-	struct batadv_priv *bat_priv;
->>>>>>>
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int ret = 0;
 
-<<<<<<<
-=======
-	mesh_iface = batadv_netlink_get_meshif(cb);
-	if (IS_ERR(mesh_iface))
-		return PTR_ERR(mesh_iface);
-
-	bat_priv = netdev_priv(mesh_iface);
-	hash = bat_priv->dat.hash;
-
->>>>>>>
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
@@ -1112,12 +1076,8 @@
 out:
 	batadv_hardif_put(primary_if);
 
-<<<<<<<
-	dev_put(mesh_iface);
-=======
 	return ret;
 }
->>>>>>>
 
 /**
  * batadv_dat_cache_dump() - dump the DAT cache table to a netlink socket
@@ -1128,20 +1088,20 @@
  */
 int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	ret = batadv_dat_dump(bat_priv, msg, cb, bat_priv->dat.cache_hash,
 			      BATADV_CMD_GET_DAT_CACHE);
 
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 	return ret;
 }
 
@@ -1154,20 +1114,20 @@
  */
 int batadv_dat_dht_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	ret = batadv_dat_dump(bat_priv, msg, cb, bat_priv->dat.dht_hash,
 			      BATADV_CMD_GET_DAT_DHT);
 
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 	return ret;
 }

>
>
> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
> index e5a07152..8d6d5e33 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -785,19 +851,57 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
>  }
>  
>  /**
> - * batadv_dat_hash_free() - free the local DAT hash table
> + * batadv_dat_hash_free() - free a DAT hash table
>   * @bat_priv: the bat priv with all the soft interface information
>   */
> -static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
> +static void batadv_dat_hash_free(struct batadv_hashtable **hash)

function parameter 'hash' not described in 'batadv_dat_hash_free'

> @@ -1332,7 +1486,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
>   * packet has to be delivered to the interface
>   */
>  bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
> -					 struct sk_buff *skb, int hdr_size)
> +					 struct sk_buff *skb, int hdr_size,
> +					 bool is_dht_put)

function parameter 'is_dht_put' not described in 'batadv_dat_snoop_incoming_arp_reply'

-- 
Sven Eckelmann <sven@narfation.org>
