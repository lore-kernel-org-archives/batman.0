Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DB3CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:43:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F34B0847BB
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:43:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780461797;
 b=WpQEa8ccaZTENs3fBOR7Vyknnant6Agt5gwZaAupMaoxH06fjQmqG1UolJlvYzdFXGiIi
 tkcdN/tQ+Xl/SNFx6LWX6g8LpDH2gD3vklfx6269piLRyHRSejseLJKCPNv46qmztQLa5Cn
 eJT77dp6oM4tTNRFzN5WFddGrRQkwCE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780461797; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B+c3q4dlDScCtfMKIjJf1AyhDq4eXecPindyi/T9ve8=;
 b=11qAlYKroJBO3U6TJt/XoHFa3OFBdIVpEfTwaJDpIfEhLkRD259oQk+nrYCcwOzMkcHdg
 U4+ynDRXKmUp2tSWQsHwbp9f2DqT3NDuQRdUlAT4Kv5mGJcn/V6QZSkgAc2wn99rieQqeuS
 2cb69RArhxddajjG86uU28ioc5+QMM4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 355D98032D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:43:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780461788;
	b=op0vC8SdZBrpbNk8DsiPTe3lu9F4zqfXOcDyiy9vyNLVW7lC6FqP+um4h0+8p037sq6C3B
	DBI4a/EDI2CboHsJjF8D6+C1ZyxVS7tvrNp1uvWZlaqlt9XmgAEW5p2Fqhb9BdsxtTpbQy
	sE4kMraPb9mfwqfQmoRXRraD6e2E/QU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bCnMvX01;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780461788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B+c3q4dlDScCtfMKIjJf1AyhDq4eXecPindyi/T9ve8=;
	b=Dy4783ZDxxSRr3ICycv60kX3VcrhPLUB2iNV8xqCnMY6wNRZRCEfz8RoDfUJCJyebJsAAA
	8U4VZuGfGYra9GU175mSdFgamJI2IgvnG8c57IJK6dsd8p0ra/TPWjbkY2esoHcn+Dm3ax
	HDxx2qx6LSyszNGfOrPKQuCQoIw2a24=
Received: by dvalin.narfation.org (Postfix) id A49F520131;
	Wed, 03 Jun 2026 04:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780461787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+c3q4dlDScCtfMKIjJf1AyhDq4eXecPindyi/T9ve8=;
	b=bCnMvX01CaoBkD9xS6zw841pikUAwYAvVRnR91VcrjrMmjp9U4X1z1DYifyu1UNv5dxIsu
	6WapbY4WnE26cNIILM6+c6cjqsMSUehrfpv+kxYmmWcGNZ7nCNYsbeYk8ixm0gSBm50F4a
	PlnXvCIXHO4HVdWbjOLQ3BAgRfCtfWM=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nora Schiffer <neocturne@universe-factory.net>
Subject: Re: [PATCH batadv v2 0/5] batman-adv: drop global hard interface list
Date: Wed, 03 Jun 2026 06:43:04 +0200
Message-ID: <4745445.LvFx2qVVIh@sven-desktop>
In-Reply-To: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
References: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5082715.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HRZSYWWTMYJPE2IOA4BJL2CT4CM2WIQO
X-Message-ID-Hash: HRZSYWWTMYJPE2IOA4BJL2CT4CM2WIQO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HRZSYWWTMYJPE2IOA4BJL2CT4CM2WIQO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5082715.GXAFRqVoOG
Content-Type: multipart/mixed; boundary="nextPart2419460.ElGaqSPkdT";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nora Schiffer <neocturne@universe-factory.net>
Date: Wed, 03 Jun 2026 06:43:04 +0200
Message-ID: <4745445.LvFx2qVVIh@sven-desktop>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart2419460.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 3 June 2026 06:28:59 CEST Sven Eckelmann wrote:
> This RFC is on purpose not Signed-off-by

Looks like I forgot to mark it as an RFC. Anyway, just consider it an RFC to 
get the discussion started again and make sure that both sides are ok with the 
adjustments.

Please make sure that this is not yet an endorsement of this specific version 
of the patchset. I still have to sit down again and make sure that it makes 
sense (tm). But I am at least convinced at the moment that the idea behind the 
patchset is good.

> I will later post an range-diff which contains all the changes.

git range-diff v2025.3..ecsv/schiffer-netdev-orig 3f5b367f76482a714b4263bf2b1bddb0d49831ca..6b1570a75d32eceb827d5dd826681126205f87de

See v1-v2.rdiff. Please double check that I actually addressed my old 
comments.

Regards,
	Sven
--nextPart2419460.ElGaqSPkdT
Content-Disposition: attachment; filename="v1-v2.rdiff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="v1-v2.rdiff"

1:  cfcf1328 < -:  -------- batman-adv: store hard_iface as iflink private data
-:  -------- > 1:  0c1926bf batman-adv: tt: directly retrieve wifi flags of net_device
2:  d97e5558 ! 2:  add14bf4 batman-adv: only create hardif while a netdev is part of a mesh
    @@
      ## Metadata ##
    -Author: Matthias Schiffer <mschiffer@universe-factory.net>
    +Author: Nora Schiffer <neocturne@universe-factory.net>
     
      ## Commit message ##
         batman-adv: only create hardif while a netdev is part of a mesh
    @@ Commit message
         batadv_hardif_enable_interface(), and batadv_hardif_remove_interface()
         can be dropped altogether.
     
    -    Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
    -
      ## net/batman-adv/hard-interface.c ##
     @@ net/batman-adv/hard-interface.c: batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
      }
    @@ net/batman-adv/hard-interface.c: batadv_hardif_deactivate_interface(struct batad
     +	struct batadv_hard_iface *hard_iface;
      	unsigned int required_mtu;
      	unsigned int hardif_mtu;
    + 	bool fragmentation;
      	int ret;
      
    +-	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
     +	ASSERT_RTNL();
     +
     +	if (!batadv_is_valid_iface(net_dev))
     +		return -EINVAL;
     +
    -+	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
    ++	hardif_mtu = READ_ONCE(net_dev->mtu);
    + 	required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
    + 
    + 	if (hardif_mtu < ETH_MIN_MTU + max_header_len)
    + 		return -EINVAL;
    + 
    +-	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
    +-		goto out;
    ++	hard_iface = kzalloc_obj(*hard_iface, GFP_ATOMIC);
     +	if (!hard_iface)
     +		return -ENOMEM;
     +
    @@ net/batman-adv/hard-interface.c: batadv_hardif_deactivate_interface(struct batad
     +	kref_init(&hard_iface->refcount);
     +
     +	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
    -+	hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
     +	if (batadv_is_wifi_hardif(hard_iface))
     +		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
     +
    -+	atomic_set(&hard_iface->hop_penalty, 0);
    ++	WRITE_ONCE(hard_iface->hop_penalty, 0);
     +
     +	batadv_v_hardif_init(hard_iface);
    -+
    -+	kref_get(&hard_iface->refcount);
    + 
    + 	kref_get(&hard_iface->refcount);
     +	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
     +	batadv_hardif_generation++;
    -+
    - 	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
    - 	required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
    - 
    --	if (hardif_mtu < ETH_MIN_MTU + max_header_len)
    --		return -EINVAL;
    --
    --	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
    --		goto out;
    --
    --	kref_get(&hard_iface->refcount);
    -+	if (hardif_mtu < ETH_MIN_MTU + max_header_len) {
    -+		ret = -EINVAL;
    -+		goto err_put;
    -+	}
      
      	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
      	hard_iface->mesh_iface = mesh_iface;
    @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct batad
      
     -	hard_iface->if_status = BATADV_IF_INACTIVE;
     -
    --	kref_get(&hard_iface->refcount);
    + 	kref_get(&hard_iface->refcount);
      	hard_iface->batman_adv_ptype.type = ethertype;
      	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
    - 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
     @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
      	if (bat_priv->algo_ops->iface.enabled)
      		bat_priv->algo_ops->iface.enabled(hard_iface);
    @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct batad
      	return 0;
      
      err_upper:
    -@@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
    - err_dev:
    - 	hard_iface->mesh_iface = NULL;
    - 	netdev_put(mesh_iface, &hard_iface->meshif_dev_tracker);
    -+err_put:
    - 	batadv_hardif_put(hard_iface);
    - 	return ret;
    - }
     @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
      	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
      	struct batadv_hard_iface *primary_if = NULL;
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct bat
      		goto out;
      
     +	list_del_rcu(&hard_iface->list);
    ++	batadv_hardif_put(hard_iface);
     +	batadv_hardif_generation++;
     +
      	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct bat
     -	if (!batadv_is_valid_iface(net_dev))
     -		return NULL;
     -
    --	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
    +-	hard_iface = kzalloc_obj(*hard_iface, GFP_ATOMIC);
     -	if (!hard_iface)
     -		return NULL;
     -
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct bat
     -	kref_init(&hard_iface->refcount);
     -
     -	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
    --	hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
     -	if (batadv_is_wifi_hardif(hard_iface))
     -		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
     -
    --	atomic_set(&hard_iface->hop_penalty, 0);
    +-	WRITE_ONCE(hard_iface->hop_penalty, 0);
     -
     -	batadv_v_hardif_init(hard_iface);
     -
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct bat
       * batadv_hard_if_event_meshif() - Handle events for mesh interfaces
       * @event: NETDEV_* event to handle
     @@ net/batman-adv/hard-interface.c: static int batadv_hard_if_event(struct notifier_block *this,
    - 		return batadv_hard_if_event_meshif(event, net_dev);
    + 	batadv_wifi_net_device_event(event, net_dev);
      
      	hard_iface = batadv_hardif_get_by_netdev(net_dev);
     -	if (!hard_iface && (event == NETDEV_REGISTER ||
    @@ net/batman-adv/hard-interface.c: static int batadv_hard_if_event(struct notifier
      		if (hard_iface->mesh_iface)
     
      ## net/batman-adv/hard-interface.h ##
    -@@ net/batman-adv/hard-interface.h: bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
    +@@ net/batman-adv/hard-interface.h: u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
      bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
      struct batadv_hard_iface*
      batadv_hardif_get_by_netdev(const struct net_device *net_dev);
3:  61023efc ! 3:  9f62d7ce batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
    @@
      ## Metadata ##
    -Author: Matthias Schiffer <mschiffer@universe-factory.net>
    +Author: Nora Schiffer <neocturne@universe-factory.net>
     
      ## Commit message ##
         batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
    @@ Commit message
         With hardifs only existing while an interface is part of a mesh, the
         BATADV_IF_NOT_IN_USE state has become redundant.
     
    -    Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
    -    Acked-by: Sven Eckelmann <sven@narfation.org>
    -
      ## net/batman-adv/bat_iv_ogm.c ##
     @@ net/batman-adv/bat_iv_ogm.c: static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
      
4:  aaa80559 ! 4:  f35d12ce batman-adv: remove global hardif list
    @@
      ## Metadata ##
    -Author: Matthias Schiffer <mschiffer@universe-factory.net>
    +Author: Nora Schiffer <neocturne@universe-factory.net>
     
      ## Commit message ##
         batman-adv: remove global hardif list
    @@ Commit message
         use netdev_master_upper_dev_get()+netdev_lower_dev_get_private() to find
         the hardif corresponding to a netdev.
     
    -    Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
    -
      ## net/batman-adv/hard-interface.c ##
    +@@ net/batman-adv/hard-interface.c: void batadv_hardif_release(struct kref *ref)
    + 	struct batadv_hard_iface *hard_iface;
    + 
    + 	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
    ++	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
    + 	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
    + 
    + 	kfree_rcu(hard_iface, rcu);
     @@ net/batman-adv/hard-interface.c: void batadv_hardif_release(struct kref *ref)
       * Return: batadv_hard_iface of net_dev (with increased refcnt), NULL on errors
       */
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_release(struct kref *ref)
     -		    kref_get_unless_zero(&hard_iface->refcount))
     -			goto out;
     -	}
    ++	ASSERT_RTNL();
    + 
    +-	hard_iface = NULL;
     +	mesh_iface = netdev_master_upper_dev_get(net_dev);
     +	if (!mesh_iface || !batadv_meshif_is_valid(mesh_iface))
     +		return NULL;
    - 
    --	hard_iface = NULL;
    ++
     +	hard_iface = netdev_lower_dev_get_private(mesh_iface, net_dev);
     +	if (!kref_get_unless_zero(&hard_iface->refcount))
     +		return NULL;
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_release(struct kref *ref)
      }
      
     @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct net_device *net_dev,
    - 	hard_iface->mesh_iface = NULL;
    + 	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
    + 	hard_iface->net_dev = net_dev;
    + 
    +-	hard_iface->mesh_iface = NULL;
      	hard_iface->if_status = BATADV_IF_INACTIVE;
      
     -	INIT_LIST_HEAD(&hard_iface->list);
    @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct net_d
      
      	mutex_init(&hard_iface->bat_iv.ogm_buff_mutex);
     @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct net_device *net_dev,
    + 
      	batadv_v_hardif_init(hard_iface);
      
    - 	kref_get(&hard_iface->refcount);
    +-	kref_get(&hard_iface->refcount);
     -	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
     -	batadv_hardif_generation++;
    - 
    - 	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
    - 	required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
    -@@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct net_device *net_dev,
    +-
    + 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
      	hard_iface->mesh_iface = mesh_iface;
      	bat_priv = netdev_priv(hard_iface->mesh_iface);
      
    @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct bat
      		goto out;
      
     -	list_del_rcu(&hard_iface->list);
    +-	batadv_hardif_put(hard_iface);
     -	batadv_hardif_generation++;
     -
      	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
      		    hard_iface->net_dev->name);
      	dev_remove_pack(&hard_iface->batman_adv_ptype);
     @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
    + 	/* delete all references to this hard_iface */
    + 	batadv_purge_orig_ref(bat_priv);
      	batadv_purge_outstanding_packets(bat_priv, hard_iface);
    - 	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
    +-	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
      
     +	batadv_hardif_generation++;
      	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
      	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
      
    +@@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
    + 	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
    + 		batadv_gw_check_client_stop(bat_priv);
    + 
    +-	hard_iface->mesh_iface = NULL;
    + 	batadv_hardif_put(hard_iface);
    + 
    + out:
     
      ## net/batman-adv/hard-interface.h ##
    -@@ net/batman-adv/hard-interface.h: struct net_device *batadv_get_real_netdev(struct net_device *net_device);
    - bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
    +@@ net/batman-adv/hard-interface.h: u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev);
    + u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
      bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
      struct batadv_hard_iface*
     -batadv_hardif_get_by_netdev(const struct net_device *net_dev);
    @@ net/batman-adv/main.h: static inline int batadv_print_vid(unsigned short vid)
      
      extern struct workqueue_struct *batadv_event_workqueue;
     
    + ## net/batman-adv/netlink.c ##
    +@@ net/batman-adv/netlink.c: batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
    + 	if (!hard_dev)
    + 		return ERR_PTR(-ENODEV);
    + 
    ++	rtnl_lock();
    + 	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
    ++	rtnl_unlock();
    + 	if (!hard_iface)
    + 		goto err_put_harddev;
    + 
    +
      ## net/batman-adv/types.h ##
    -@@ net/batman-adv/types.h: enum batadv_hard_iface_wifi_flags {
    +@@ net/batman-adv/types.h: struct batadv_wifi_net_device_state {
       * struct batadv_hard_iface - network device known to batman-adv
       */
      struct batadv_hard_iface {
5:  0d0b32d8 ! 5:  6b1570a7 batman-adv: move hardif generation counter into batadv_priv
    @@
      ## Metadata ##
    -Author: Matthias Schiffer <mschiffer@universe-factory.net>
    +Author: Nora Schiffer <neocturne@universe-factory.net>
     
      ## Commit message ##
         batman-adv: move hardif generation counter into batadv_priv
     
         The counter doesn't need to be global.
     
    -    Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
    -    Acked-by: Sven Eckelmann <sven@narfation.org>
    -
      ## net/batman-adv/hard-interface.c ##
     @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct net_device *net_dev,
      	hard_iface->mesh_iface = mesh_iface;
    @@ net/batman-adv/hard-interface.c: int batadv_hardif_enable_interface(struct net_d
      					   mesh_iface, hard_iface, NULL, NULL);
      	if (ret)
     @@ net/batman-adv/hard-interface.c: void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
    + 	batadv_purge_orig_ref(bat_priv);
      	batadv_purge_outstanding_packets(bat_priv, hard_iface);
    - 	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
      
     -	batadv_hardif_generation++;
     +	bat_priv->hardif_generation++;

--nextPart2419460.ElGaqSPkdT--

--nextPart5082715.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCah+w2AAKCRBND3cr0xT1
y/o3AP4jGZ7Hi+iagwtyEm+wrzb5qje0G9zBMAHplu4eUkIMIgD9GbCR+fise5pQ
i42S7CD3euKRg/YxMR+RSmna6G6pkQ0=
=ujmo
-----END PGP SIGNATURE-----

--nextPart5082715.GXAFRqVoOG--



