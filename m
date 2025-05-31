Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B65C5AE59
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 09:17:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7075284783
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 11:17:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748683025;
 b=mm81gr6n5OUawst+0KSrHBthIRx4pe7ebse9xc62/UHy4SFaGVSujLvu3CYGbPVQD6uAP
 FUNIvnmiQDIOGwfbMmPZDWaLEnnRcG/zvXHpFtWfm15czaWIR8RrCsuP6hKksWCiQ2cHWhO
 0OvbP0btZ3L9idHT9r9M09FUxKwecKQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748683025; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9e3ygM0jvmbE7HN2UFSQMTGTErfuZibV4CLp7vHuGEQ=;
 b=uENzee7i4MR2fvI4sHiB2QxWnnfDV8EjBzZGOSftHFqIM9YF8hRc26yTm2fgR/HXNvs8M
 vY+fhvIeLknAmSV29vx7/lxWQSjwWn06c1zAmg51Lvc0i5y9WuHMHTkOMN2ZWs7xuOBrAYp
 x40yRAJ2LnTSxF8VjJ/9OktKLiUHWlY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8794384289
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 11:16:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748683015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9e3ygM0jvmbE7HN2UFSQMTGTErfuZibV4CLp7vHuGEQ=;
	b=tCicr+FvutYQYlG/XvBehufzWkpbGSZZoiml1fR82MWGrraoZhHm3IJXKnP8Oa7g2gvVkC
	Oa/v2up3geQzozTacSzRQrFxPBzYzkd6WcOMyOwC35kQ3+0oACzOp3JWGY7VKPx5TnJoWp
	TNAvMwgA7rIKrgLDOVK6TYpLntD6rHI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BG2WZ1dD;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748683015; a=rsa-sha256;
	cv=none;
	b=v9t+6q7mfDiYnyNHhY9KYZDQj69SU7mD1ZZRYUPY7LmOHxRa42O4FuR9/k3IT29FSK6nf4
	7SvHSpCc9Bz7YLHMKpolNHgfJg8sDPkaik0WI9m1khs+aU8xLo3bDYZUZH/Ss1osc+J0Vc
	yJvKnWOwrR7E6sKjIB5N1IYbq7B7Irc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748683004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e3ygM0jvmbE7HN2UFSQMTGTErfuZibV4CLp7vHuGEQ=;
	b=BG2WZ1dD60ya0pAVPh+hdPXtTSW+DJ4yKrJtAXxJv5VB6kZTanThoKpm6xzDr05NLAd50i
	3sEQhHzXjCdJf3EXt6eG7jggwjYcirULko5Bavrq5loJU0hN/bURHq3QqE2Xq2c25ZBD73
	muErhrW/N+D390ue3h/ns6qNrrb33ac=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev is part
 of a mesh
Date: Sat, 31 May 2025 11:16:30 +0200
Message-ID: <7760123.MhkbZ0Pkbq@sven-desktop>
In-Reply-To: 
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3532761.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KPRA32YPFQ3J2D4CRYODLSM3XEDAW4PT
X-Message-ID-Hash: KPRA32YPFQ3J2D4CRYODLSM3XEDAW4PT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KPRA32YPFQ3J2D4CRYODLSM3XEDAW4PT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3532761.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:16:30 +0200
Message-ID: <7760123.MhkbZ0Pkbq@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:29 CEST Matthias Schiffer wrote:
> @@ -734,9 +768,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
>         if (ret < 0)
>                 goto err_upper;
>  
> -       hard_iface->if_status = BATADV_IF_INACTIVE;
> -
> -       kref_get(&hard_iface->refcount);
>         hard_iface->batman_adv_ptype.type = ethertype;
>         hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv

This is confusing. You remove the reference for the batman_adv_ptype but kept 
the `batadv_hardif_put(hard_iface);` after 
`dev_remove_pack(&hard_iface->batman_adv_ptype);`.

I think this should be added again and instead following code should receive a 
`batadv_hardif_put(hard_iface);` after the `list_del_rcu(&hard_iface->list);`:


> @@ -818,11 +849,16 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
>         struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
>         struct batadv_hard_iface *primary_if = NULL;
>  
> +       ASSERT_RTNL();
> +
>         batadv_hardif_deactivate_interface(hard_iface);
>  
>         if (hard_iface->if_status != BATADV_IF_INACTIVE)
>                 goto out;
>  
> +       list_del_rcu(&hard_iface->list);
> +       batadv_hardif_generation++;
> +
>         batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
>                     hard_iface->net_dev->name);
>         dev_remove_pack(&hard_iface->batman_adv_ptype);


And yes, this means that this needs to be removed in PATCH 3 again - together 
with the `kref_get` from this chunk (from PATCH 3):

On Monday, 19 May 2025 22:46:31 CEST Matthias Schiffer wrote:
> @@ -738,8 +735,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
>         batadv_v_hardif_init(hard_iface);
>  
>         kref_get(&hard_iface->refcount);
> -       list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
> -       batadv_hardif_generation++;
>  
>         hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
>         required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;



Just a question about this part (you don't really need to change it - I am 
just interested). Why did you move this MTU check to such a late position in 
the code?

> -       hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
> -       required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
> +       ASSERT_RTNL();
>  
> -       if (hardif_mtu < ETH_MIN_MTU + max_header_len)
> +       if (!batadv_is_valid_iface(net_dev))
>                 return -EINVAL;
>  
[...]
> +       hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
> +       if (!hard_iface)
> +               return -ENOMEM;
> +
> +       netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
> +       hard_iface->net_dev = net_dev;
[...]
> +       hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
> +       required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
> +
> +       if (hardif_mtu < ETH_MIN_MTU + max_header_len) {
> +               ret = -EINVAL;
> +               goto err_put;
> +       }

It made the error handling more complicated. And at the moment, I don't see 
the reason. For me, It would have been been more logical to just a a minimal 
invasive change like:

> -       hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
> +       hardif_mtu = READ_ONCE(net_dev->mtu);



Thanks,
	Sven

--nextPart3532761.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrI7gAKCRBND3cr0xT1
y07YAQDVyR/OScCqmjK6581lF8hCs9w6rB6o2vV6IV6R7NCsTQD9H6y3oePiuHOj
BvPM8kV+xcZ3a+jPr3egHm+0AQ4K5wg=
=9jGN
-----END PGP SIGNATURE-----

--nextPart3532761.VLH7GnMWUR--



