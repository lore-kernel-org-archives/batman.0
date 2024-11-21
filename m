Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77525D75BD8
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 09:04:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C18CB83BCA
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 10:04:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732179876;
 b=D2UFHclxU0EB8mJ02g1JJeQs1OyUQgUhjfeiyB3ovSzbiXZlrOHlWZ9PANUnQoE+paXli
 +lK8LTDwUI0LwJTr7Bj/R+XENoNewsfaRH9wWQT46WOFvxwifuNRBLTvuMGlEwp/3XTNqXX
 fHNwYPTa/VEsk6cnDmc1Ps3vU89OvW4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732179876; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jIJyztn42BBs/G9RbqUaM2ai3o0sgYKtAlB1gJm0+5A=;
 b=yBFSYv5SJ+NgjDyDF0ZyV8CRoGzUjkYiRkfHlOHu+ATPkyzZCUplEDWBB2ai2/iwf2Fuh
 ZmdKgYCAH/PzufDGq6+a/2khh98FOCcMsGXOZoep0lxFKftPJ8YNmc1BmMlKzecanNgTA4s
 cgj0nluXlwWTudqXu+RSF0whPBkGDp8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0F8E982600
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 10:04:23 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732179863; a=rsa-sha256;
	cv=none;
	b=olK2oLee4GipGcW3HJ1txHmHgVk5z2p40F0d9bkyygpgFeL73XU54+661IvehC8xXfefqb
	5PC1c6VAJ1T6ujZfnHVLKlflNRAZsa3rs2veyLEPQzB7UiKnZ3r6fwClbDHo5UjL1thGjB
	6iwM6okA/uyV6UPWzEJm8kioMcnJTXY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qvbi9kdL;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732179863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jIJyztn42BBs/G9RbqUaM2ai3o0sgYKtAlB1gJm0+5A=;
	b=4KGbzeE6RC7sOcD8IUhhRqd8fDUIMycQSinBLl1tbbGRpNcxcXKz4/Ob0NkqE2lTFjk/fl
	DEFGzuucYIWiJDMSBR2wN9kbLHtB1S90PNrcRFWgqHO/dsxtM41gTtaR05SO6WZhfScqz9
	IgKy279b6D/CUhYkp0q1C6uVMqxiKek=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732179858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIJyztn42BBs/G9RbqUaM2ai3o0sgYKtAlB1gJm0+5A=;
	b=qvbi9kdL33caACEtwZ62V0XoASjo0kzyy/u7/dh2QSYPHE36fkkvCigTOL59UuC0aVxBO/
	66TF2TMBYiL78mYc0M5D9Hm6u6+o/iPLbWZFdk5yb0w6404kzJjsodexUfWIFkfyfaBBFW
	Ke3le2f260V8PdpSJJU3P3Tsu15ENnA=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Subject: 
 Re: [PATCH v3 4/5] batman-adv: Remove atomic usage for tt.local_changes
Date: Thu, 21 Nov 2024 10:04:15 +0100
Message-ID: <9417646.rMLUfLXkoz@ripper>
In-Reply-To: 
 <8f60847b19a3646e13fd9eaa13cf8bca488b45f9.1732124716.git.repk@triplefau.lt>
References: 
 <cover.1732124716.git.repk@triplefau.lt>
 <8f60847b19a3646e13fd9eaa13cf8bca488b45f9.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3124670.CbtlEUcBR6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: WTJPLMO34XEOVNLVZ4X5SCKBLLO45FFK
X-Message-ID-Hash: WTJPLMO34XEOVNLVZ4X5SCKBLLO45FFK
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WTJPLMO34XEOVNLVZ4X5SCKBLLO45FFK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3124670.CbtlEUcBR6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>
Date: Thu, 21 Nov 2024 10:04:15 +0100
Message-ID: <9417646.rMLUfLXkoz@ripper>
MIME-Version: 1.0

On Wednesday, 20 November 2024 18:47:17 CET Remi Pommarel wrote:
> The tt.local_changes atomic is either written with tt.changes_list_lock
> or close to it (see batadv_tt_local_event()). Thus the performance gain
> using an atomic was limited (or because of atomic_read() impact even
> negative). Using atomic also comes with the need to be wary of potential
> negative tt.local_changes value.
> 
> Simplify the tt.local_changes usage by removing the atomic property and
> modifying it only with tt.changes_list_lock held.

The overall change assumes that the compiler never splits writes (store 
tearing) [1]. Of course, writes are protected against each other using locks. 
But the reader is no longer protected from partial writes. I haven't checked 
whether store fusing might be a problem.

Kind regards,
	Sven

[1] https://www.kernel.org/doc/html/latest/core-api/wrappers/memory-barriers.html

[...]
> @@ -783,13 +783,13 @@ static int batadv_softif_init_late(struct net_device *dev)
>  	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
>  	atomic_set(&bat_priv->bcast_seqno, 1);
>  	atomic_set(&bat_priv->tt.vn, 0);
> -	atomic_set(&bat_priv->tt.local_changes, 0);
>  	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	atomic_set(&bat_priv->bla.num_requests, 0);
>  #endif
>  	atomic_set(&bat_priv->tp_num, 0);
>  
> +	bat_priv->tt.local_changes = 0;

Would need WRITE_ONCE (just to be consistent)

[...]
> @@ -508,21 +507,17 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
>  del:
>  		list_del(&entry->list);
>  		kmem_cache_free(batadv_tt_change_cache, entry);
> +		bat_priv->tt.local_changes--;
>  		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
> -		event_removed = true;
>  		goto unlock;
>  	}
>  
>  	/* track the change in the OGMinterval list */
>  	list_add_tail(&tt_change_node->list, &bat_priv->tt.changes_list);
> +	bat_priv->tt.local_changes++;

Needs more complex constructs with WRITE_ONCE or 
__sync_add_and_fetch/__sync_sub_and_fetch (which were handled before inside 
atomic_inc). The latter are not used that often in the kernel, so I wouldn't
want to introduce them in the batman-adv module.

> @@ -1022,7 +1017,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>  	tt_data->flags = BATADV_TT_OGM_DIFF;
>  
>  	spin_lock_bh(&bat_priv->tt.changes_list_lock);
> -	atomic_set(&bat_priv->tt.local_changes, 0);
> +	bat_priv->tt.local_changes = 0;
>  
>  	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
>  				 list) {

Would need WRITE_ONCE

> @@ -1438,7 +1433,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
>  		kmem_cache_free(batadv_tt_change_cache, entry);
>  	}
>  
> -	atomic_set(&bat_priv->tt.local_changes, 0);
> +	bat_priv->tt.local_changes = 0;
>  	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
>  }

Would need WRITE_ONCE 

Kind regards,
	Sven
--nextPart3124670.CbtlEUcBR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZz73jwAKCRBND3cr0xT1
yx2NAP4mtaY+na08C40ihsndpGmuBAbivQ/9d4IQwJaJ/5ymLQD+IHxPX11MSYA6
LOo/KbmkmoiB3fJZS6jzsggro50uHw8=
=p6R7
-----END PGP SIGNATURE-----

--nextPart3124670.CbtlEUcBR6--



