Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFEACFC500
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 07:16:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3374B826CC
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 09:16:43 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728890203;
 b=Eq0ZERUDEX5eMl2LDD8cl9mLdX16sTCLMws1tzJMbqFGR+vH7M9X9sBXKgrVk9Q6EkTbX
 Dwx/mhf4udhodDLQuwY96PVtq5cuEQW5lXLZnTa1sx8NYxtIFlVcC9ShnQIkKk6nouWeyuo
 vWovfBxMcdD6Eom6gqpGSP5HUWeeL34=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728890203; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=H29/uZYFImOCL15YMDLKrJt+SdKdMFtmd5jkG29BNgg=;
 b=qkB0zousK9UR5TQIy5JsFvm42iUbvacxZXF6wLieUKrCLJlP5mpjII1t554f0OHUQJ/Fu
 sM4B4s7CE+gFSBTQJmBMDtJ8hEHAflc3UpSqL+3b0iPhaxNdBybKBvHhnWKYkmlZ0klTb/3
 0hbf9/LulKtbtA+pYDRl1eqS8PiWPzw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=inria.fr;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=inria.fr policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=inria.fr;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=inria.fr policy.dmarc=none
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4E2B81222
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Oct 2024 09:08:31 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728889711; a=rsa-sha256;
	cv=none;
	b=ntvBz2AFo16eMztQ2g6/HBk+NkaaEd5HBEoc6t4glkZjnUiIVGKTZIXRJj5JCw8j/7qE+P
	2rSF2JJYnzfimvuXH4uRa/KElsPqrwQnY+v1af1RHnR7x9dGu0VWF7pIoNiqkFsjrvygKf
	td7yc3NI3YT59wNCHRxNpgdBIq2JYC8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=inria.fr header.s=dc header.b=cX9EIuEy;
	dmarc=pass (policy=none) header.from=inria.fr;
	spf=pass (diktynna.open-mesh.org: domain of julia.lawall@inria.fr designates
 192.134.164.83 as permitted sender) smtp.mailfrom=julia.lawall@inria.fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728889711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=H29/uZYFImOCL15YMDLKrJt+SdKdMFtmd5jkG29BNgg=;
	b=nUsiUbUAbhOElxpDQPrQ5NT6YAmB26ThuefzIOIMXOf7bXSBH1ZPwuwJgV2Hkzy+S2VIyL
	Er6wECgBs3nYLnmZgRKRRbv3Jbu6KmwkW04eIb8/kMVB8VTXVd2/SuFD/zDjUVCPSdG9Rv
	JWVNTCXvjMVMph+AMB/XgR+Ca7Vj1O4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H29/uZYFImOCL15YMDLKrJt+SdKdMFtmd5jkG29BNgg=;
  b=cX9EIuEyDMi+CHBxADYDHfM2+/1wX3FVb1/+L8MshIVOb86jvWVFagVR
   94jAncDEoguSuWgxf2KGzvFnsfUivSBMlaxG7kRes6zypVg2aRED2yf7S
   YH0/Y/OY0yIXudU8I4Gxj8u4WV3zbQZHwrw9AwugjsA9cc5CaFShyoy1y
   A=;
X-IronPort-AV: E=Sophos;i="6.11,202,1725314400";
   d="scan'208";a="188585391"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:08:31 +0200
Date: Mon, 14 Oct 2024 09:08:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sven Eckelmann <sven@narfation.org>
cc: Julia Lawall <Julia.Lawall@inria.fr>, vbabka@suse.cz,
    linus.luessing@c0d3.blue, Marek Lindner <mareklindner@neomailbox.ch>,
    kernel-janitors@vger.kernel.org, paulmck@kernel.org,
    Simon Wunderlich <sw@simonwunderlich.de>,
    Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
In-Reply-To: <6091264.lOV4Wx5bFT@ripper>
Message-ID: <f343355b-eda9-8527-ee2c-60f1e44e6e0@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-7-Julia.Lawall@inria.fr> <6091264.lOV4Wx5bFT@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MailFrom: julia.lawall@inria.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: PTQA7ZLU23TZWNZVSH2RUEQW4WJY3TLB
X-Message-ID-Hash: PTQA7ZLU23TZWNZVSH2RUEQW4WJY3TLB
X-Mailman-Approved-At: Mon, 14 Oct 2024 09:16:39 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PTQA7ZLU23TZWNZVSH2RUEQW4WJY3TLB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>



On Mon, 14 Oct 2024, Sven Eckelmann wrote:

> On Sunday, 13 October 2024 22:16:53 CEST Julia Lawall wrote:
> > Since SLOB was removed and since
> > commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> > it is not necessary to use call_rcu when the callback only performs
> > kmem_cache_free. Use kfree_rcu() directly.
> >
> > The changes were made using Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  net/batman-adv/translation-table.c |   47 ++-----------------------------------
> >  1 file changed, 3 insertions(+), 44 deletions(-)
>
>
> This was tried and we noticed that it is not safe [1]. So, I would get
> confirmation that commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier()
> from kmem_cache_destroy()") is fixing the problem which we had at that time.
> The commit message sounds like it but I just want to be sure.

Thanks for the feedback. I think that Vlastimil Babka can help with that.

julia

>
> Kind regards,
> 	Sven
>
> [1] https://lore.kernel.org/r/20240612133357.2596-1-linus.luessing@c0d3.blue
>
> >
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 2243cec18ecc..b21ff3c36b07 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -208,20 +208,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
> >  	return tt_global_entry;
> >  }
> >
> > -/**
> > - * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
> > - * @rcu: rcu pointer of the tt_local_entry
> > - */
> > -static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
> > -{
> > -	struct batadv_tt_local_entry *tt_local_entry;
> > -
> > -	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
> > -				      common.rcu);
> > -
> > -	kmem_cache_free(batadv_tl_cache, tt_local_entry);
> > -}
> > -
> >  /**
> >   * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
> >   *  for free after rcu grace period
> > @@ -236,7 +222,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
> >
> >  	batadv_softif_vlan_put(tt_local_entry->vlan);
> >
> > -	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
> > +	kfree_rcu(tt_local_entry, common.rcu);
> >  }
> >
> >  /**
> > @@ -254,20 +240,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
> >  		 batadv_tt_local_entry_release);
> >  }
> >
> > -/**
> > - * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
> > - * @rcu: rcu pointer of the tt_global_entry
> > - */
> > -static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
> > -{
> > -	struct batadv_tt_global_entry *tt_global_entry;
> > -
> > -	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
> > -				       common.rcu);
> > -
> > -	kmem_cache_free(batadv_tg_cache, tt_global_entry);
> > -}
> > -
> >  /**
> >   * batadv_tt_global_entry_release() - release tt_global_entry from lists and
> >   *  queue for free after rcu grace period
> > @@ -282,7 +254,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
> >
> >  	batadv_tt_global_del_orig_list(tt_global_entry);
> >
> > -	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
> > +	kfree_rcu(tt_global_entry, common.rcu);
> >  }
> >
> >  /**
> > @@ -407,19 +379,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
> >  	batadv_tt_global_size_mod(orig_node, vid, -1);
> >  }
> >
> > -/**
> > - * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
> > - * @rcu: rcu pointer of the orig_entry
> > - */
> > -static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
> > -{
> > -	struct batadv_tt_orig_list_entry *orig_entry;
> > -
> > -	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
> > -
> > -	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
> > -}
> > -
> >  /**
> >   * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
> >   *  queue for free after rcu grace period
> > @@ -433,7 +392,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
> >  				  refcount);
> >
> >  	batadv_orig_node_put(orig_entry->orig_node);
> > -	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
> > +	kfree_rcu(orig_entry, rcu);
> >  }
> >
> >  /**
> >
> >
>
>
