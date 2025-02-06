Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC70C02194
	for <batman-adv@archiver.kernel.org>; Thu,  6 Feb 2025 14:14:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E8BEA83F00
	for <batman-adv@archiver.kernel.org>; Thu,  6 Feb 2025 15:14:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738851242;
 b=fEta8RrpZygb1OYTqDf89HUheuTDJN/2ERCCKxex7tI9NqQMZHPun2JEFHhyzPPpePxEG
 O+0tMrn6UtwexFO+xYh/LFhPsbSw3XrPdgTjCvsZDWDslRucwEOZhzm8NIBcwf4gacm2jx7
 v1ohJahBdmdTqjJpCh4a5jbpROD/X+s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738851242; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m+yP7O2OoLUgMMYnKp9PRAYvDDAEHKsr5IjQROK+U1U=;
 b=LRozrNpX+sGiA39xKkWzS6UIdKErLjqmJxDEetp6qlTxPwjNVltycE/etcZrvZvijv7Uo
 S3Ad3Bp0Zgb7fjaf6swX5zSmkYwyDeDTFIQ8WT9prKFKUFPAjedTEvJyJ7bFM3CFdWXgLUz
 gS4rqfufMDk76B2nD8/8XWdJEWR8b7c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3F3938150F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  6 Feb 2025 15:13:54 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738851234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m+yP7O2OoLUgMMYnKp9PRAYvDDAEHKsr5IjQROK+U1U=;
	b=OlpaJlJRMvU8XyM8yMg9ksIfx/1yJIJV6oY8VuVMgiSwwwmn53afneIIgn5iOIiA1cpX+S
	e+vdHskm4Vob49ZqPHo9ppAMCElZhiIO7AL7Fs2bcS+rIyUAstSGXonfczHgdbwD1gb3xd
	m6F97Mvtd3Zkon6b0D/GY+IA5f08GGo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=J7sh+k75;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738851234; a=rsa-sha256;
	cv=none;
	b=RetBqXhY7TR2HGzWQSFLrOegZ1fls8jVuHXVtrw+eD12/Hd5wPWmLdYAMV6Bk0wlghfffw
	P0pP+AvRg4Qzy1uUOelmI4gQxb/+6vkDtjKp6G5bccTKLWVsK6ck6jyy4LHLKE3/jGDKKM
	Xeay0eaVOGs/393mNsqILkBncpUvpz0=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id C9F9D3FA5;
	Thu,  6 Feb 2025 15:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738851233;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=m+yP7O2OoLUgMMYnKp9PRAYvDDAEHKsr5IjQROK+U1U=;
	b=J7sh+k75BnlKCJg0TBWxHaMSDEpLhXB3lp0P9/pwH8cFmSnkl18e2+zZBJ7DBpwQ
	gZcWamBRFsuj1bHTWu/vW/qG8wwySTbd7d9Pq47f7aPAPz7T219lGBP2L6SLEKqRO3F
	Bk+o81KkgqQSpvh4hHXNja0m0C9aKpXuSxNO3f27VRemtBXkpqlkL3K1ebj6/BJvwVq
	9hRNvgBHQTQVmL/yv5vdVG2KcOh2C7tkM1opMjv+cvU0qbhGPALoKnKYyNmlmf4aOqv
	M7LaAzjw4UqroY+TPvn0Akwx7q64r/OftoQUlvmiEiNfJIXAzSexOl50S9JKvvKvyz4
	rsBHxY8OvA==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 6 Feb 2025 15:13:51 +0100 (CET)
Message-ID: <d729f05a-e5e6-4d67-8fe6-888e1e761b34@unstable.cc>
Date: Thu, 6 Feb 2025 15:15:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] batman-adv: adopt netdev_hold() / netdev_put()
To: Eric Dumazet <edumazet@google.com>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250206140422.3134815-1-edumazet@google.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20250206140422.3134815-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: FP3JCOT4CS5U5E325MLKANYZ6UW6GBJC
X-Message-ID-Hash: FP3JCOT4CS5U5E325MLKANYZ6UW6GBJC
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FP3JCOT4CS5U5E325MLKANYZ6UW6GBJC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 06/02/2025 15:04, Eric Dumazet wrote:
> Add a device tracker to struct batadv_hard_iface to help
> debugging of network device refcount imbalances.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/batman-adv/hard-interface.c | 14 +++++---------
>   net/batman-adv/types.h          |  3 +++
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index 96a412beab2de9069c0f88e4cd844fbc0922aa18..9a3ae567eb12d0c65b25292d020462b6ad60b699 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -51,7 +51,7 @@ void batadv_hardif_release(struct kref *ref)
>   	struct batadv_hard_iface *hard_iface;
>   
>   	hard_iface = container_of(ref, struct batadv_hard_iface, refcount);
> -	dev_put(hard_iface->net_dev);
> +	netdev_put(hard_iface->net_dev, &hard_iface->dev_tracker);
>   
>   	kfree_rcu(hard_iface, rcu);
>   }
> @@ -875,15 +875,16 @@ batadv_hardif_add_interface(struct net_device *net_dev)
>   	ASSERT_RTNL();
>   
>   	if (!batadv_is_valid_iface(net_dev))
> -		goto out;
> +		return NULL;
>   
> -	dev_hold(net_dev);
>   
>   	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
>   	if (!hard_iface)
> -		goto release_dev;
> +		return NULL;
>   
> +	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
>   	hard_iface->net_dev = net_dev;
> +
>   	hard_iface->soft_iface = NULL;
>   	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
>   
> @@ -909,11 +910,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
>   	batadv_hardif_generation++;
>   
>   	return hard_iface;
> -
> -release_dev:
> -	dev_put(net_dev);
> -out:
> -	return NULL;
>   }
>   
>   static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index f491bff8c51b8bf68eb11dbbeb1a434d446c25f0..a73fc3ab7dd28ae2c8484c0d198a15437d49ea73 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -186,6 +186,9 @@ struct batadv_hard_iface {
>   	/** @net_dev: pointer to the net_device */
>   	struct net_device *net_dev;
>   
> +	/** @dev_tracker device tracker for @net_dev */
> +	netdevice_tracker  dev_tracker;

There are two blanks between type and member name. Is that intended?

> +
>   	/** @refcount: number of contexts the object is used */
>   	struct kref refcount;
>   

We also have hard_iface->soft_iface storing a pointer to the soft_iface 
(batX) netdev.

How about converting that to netdev_put/hold as well?
See batadv_hardif_enable_interface() / batadv_hardif_disable_interface()


Best Regards,


-- 
Antonio Quartulli

