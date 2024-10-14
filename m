Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D93CFC501
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 07:03:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2100482544
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 09:03:44 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728889424;
 b=A2f4fN9g8GQuff8DixyN2oDrIv4V8b5AyeJuw4GoIE+NZEiLnutXQVGpnVa26gxu5hC4g
 ZzY30+p+qQGZzn+VS1BtbgQeRZtmENB47lHnfVcgSSRfztR/1QuC9G0kRFsn4y7mn7gYDSL
 zgKOCU0qBzyvKEUhB3fUQy96eQMXh1I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728889424; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=httTAT48fu+3mO0g6dqX16B/PSb/AZaAB5kFQ49ZHpw=;
 b=zW8C/O25LBzeKEvwqcM07ulbVgVJij/rkPqU0j7lU0CFHR6U8WbKvBwZC+uDb/sidvJLt
 AmiJFNVcD7YUzLtL5k/B3joVRqGhW61qwqIlyJjXfUDu8UTSHCdUdRSrFnz2MQSJjXZ5DnF
 cB4WARmR2v+s75GRAhVH4+oiVwtsEnE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 133BC8174C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Oct 2024 09:03:40 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728889421; a=rsa-sha256;
	cv=none;
	b=XevQCHUByBMClz3dJnIKOfaOo7UTdLL0R9LE1GAdxfCm205Z1P/vEm+o8VJw4ywVUdY57w
	dcr8nYqY2NnejpfzaRgydHzzjZ0yPtvbDyQobxKJUhfXCoC3zZtqxlVDM3Mgjl3WT0B9kw
	h/ctw578zqfBMPyJEiS+nbGW7XD/inA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xe54NCsc;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728889421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=httTAT48fu+3mO0g6dqX16B/PSb/AZaAB5kFQ49ZHpw=;
	b=uUlavU1+Ya+N/G9lNSzE1OTUDd4zFHE9RpifOMfzkVV4GwQ8AQgobSZTAH1sMA6+hrR9A/
	RQhrdnQOqIMxbHa785qiwMRbTqjro5Q4qko9OiRkJagMDpHKENr2gsvZASZQzI+rp8mgQv
	zmvtgSOhzZyFtaLrRZcVZZOPjHKYieE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1728889420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=httTAT48fu+3mO0g6dqX16B/PSb/AZaAB5kFQ49ZHpw=;
	b=Xe54NCscJgu36LAoRk5nICKys82aNg3+GsjFGnInFdAafoHCnhLMlKiQlH9O9rDNupMsmm
	/gCyhwOm/RbFmKrvS8PEkAkjJHf6xiJMhZO9BSLdAZ/l8T36cBzyTFNdE+PqZhdfV+RWWB
	5M1lZzm3KwY8vIO/cfRIt4BhpcJeJdI=
From: Sven Eckelmann <sven@narfation.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, vbabka@suse.cz,
 linus.luessing@c0d3.blue
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 kernel-janitors@vger.kernel.org, paulmck@kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Date: Mon, 14 Oct 2024 09:03:30 +0200
Message-ID: <6091264.lOV4Wx5bFT@ripper>
In-Reply-To: <20241013201704.49576-7-Julia.Lawall@inria.fr>
References: 
 <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-7-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4957463.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: W6DAGSGAN3PXO274RTV22T7ISTCX26QB
X-Message-ID-Hash: W6DAGSGAN3PXO274RTV22T7ISTCX26QB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W6DAGSGAN3PXO274RTV22T7ISTCX26QB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4957463.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Oct 2024 09:03:30 +0200
Message-ID: <6091264.lOV4Wx5bFT@ripper>
In-Reply-To: <20241013201704.49576-7-Julia.Lawall@inria.fr>
MIME-Version: 1.0

On Sunday, 13 October 2024 22:16:53 CEST Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  net/batman-adv/translation-table.c |   47 ++-----------------------------------
>  1 file changed, 3 insertions(+), 44 deletions(-)


This was tried and we noticed that it is not safe [1]. So, I would get 
confirmation that commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() 
from kmem_cache_destroy()") is fixing the problem which we had at that time. 
The commit message sounds like it but I just want to be sure.

Kind regards,
	Sven

[1] https://lore.kernel.org/r/20240612133357.2596-1-linus.luessing@c0d3.blue

> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 2243cec18ecc..b21ff3c36b07 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -208,20 +208,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
>  	return tt_global_entry;
>  }
>  
> -/**
> - * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
> - * @rcu: rcu pointer of the tt_local_entry
> - */
> -static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
> -{
> -	struct batadv_tt_local_entry *tt_local_entry;
> -
> -	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
> -				      common.rcu);
> -
> -	kmem_cache_free(batadv_tl_cache, tt_local_entry);
> -}
> -
>  /**
>   * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
>   *  for free after rcu grace period
> @@ -236,7 +222,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
>  
>  	batadv_softif_vlan_put(tt_local_entry->vlan);
>  
> -	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
> +	kfree_rcu(tt_local_entry, common.rcu);
>  }
>  
>  /**
> @@ -254,20 +240,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
>  		 batadv_tt_local_entry_release);
>  }
>  
> -/**
> - * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
> - * @rcu: rcu pointer of the tt_global_entry
> - */
> -static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
> -{
> -	struct batadv_tt_global_entry *tt_global_entry;
> -
> -	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
> -				       common.rcu);
> -
> -	kmem_cache_free(batadv_tg_cache, tt_global_entry);
> -}
> -
>  /**
>   * batadv_tt_global_entry_release() - release tt_global_entry from lists and
>   *  queue for free after rcu grace period
> @@ -282,7 +254,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
>  
>  	batadv_tt_global_del_orig_list(tt_global_entry);
>  
> -	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
> +	kfree_rcu(tt_global_entry, common.rcu);
>  }
>  
>  /**
> @@ -407,19 +379,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
>  	batadv_tt_global_size_mod(orig_node, vid, -1);
>  }
>  
> -/**
> - * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
> - * @rcu: rcu pointer of the orig_entry
> - */
> -static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
> -{
> -	struct batadv_tt_orig_list_entry *orig_entry;
> -
> -	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
> -
> -	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
> -}
> -
>  /**
>   * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
>   *  queue for free after rcu grace period
> @@ -433,7 +392,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
>  				  refcount);
>  
>  	batadv_orig_node_put(orig_entry->orig_node);
> -	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
> +	kfree_rcu(orig_entry, rcu);
>  }
>  
>  /**
> 
> 


--nextPart4957463.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZwzCQwAKCRBND3cr0xT1
y7i+AQDVLdYz744YITcGjxNtokduQbc/TMXye8cDpvnUIRqeswEA3w/Kg7zDNvz2
rI43KEYfCJOuJv0+vY4mZmhJob37RQw=
=/WZq
-----END PGP SIGNATURE-----

--nextPart4957463.31r3eYUQgx--



