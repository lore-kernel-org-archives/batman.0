Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E258CD98CC
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 18:37:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6B41583D1C
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 20:37:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781116622;
 b=g+LTAlT1lt/2SXT54xBQab/a0dJZdzO0RT1oTZ3TA5XLCm++qjs0LQ8+8F8ipvA9iKQsw
 Icp0IZJxYSGnXcAscZtHviXlY60TPlUGQnSGkAC+FS3Z9q9sWWI/5NBVdotpqyLDM6QPgkM
 MkLeaaxBR2z0llzXOxWfEu+b+PlGpkI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781116622; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Lcq7x01AFOAsOBmf/radJ1N6xxoViPuimWg8PHRj0oc=;
 b=QOGX9Y57jXVghNoILonRoAiDXU+Rqyy6V84ON2QXAokQyzsjgO1nPjHS3h2ZICoD7tmbL
 G4UPrMReL/nIp5RpthiWMUf39wV7qBBrHznGO3VQUAV3ESAh69cuITHLVdikvBV0LRfebsA
 RWWmywxwZUQd2IH4zGjttx32C1XyuPY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7B98E81C55
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 19:50:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781113816;
	b=mq15itHehgluDIUrUwvx1wgbSVjKhv04MfBeRrBwVG5x1rhz7lFEXl+Kfw6TYpRPZCuVrg
	T49OaXQaKHBX1FhF5stLq+RKqs8xdhufSJIhS77hHV4cBKdr00bVwr9Np+2M94x1qESo7B
	3bTgHIi/2+XeF5Ve48DPdOf4lBmpN+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781113816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Lcq7x01AFOAsOBmf/radJ1N6xxoViPuimWg8PHRj0oc=;
	b=e/947x8Qd7l9jgLD3ccSCTcvM+3UFFb2atZa9TYFt2XWRzBJuXlP18gV/LpWsGpZNoeoMR
	K7bJ76z5CoDuFu3AVQW27ZPRGzo5lotR94Pm1jkwj6P5ZtcC/u4n+Ib7BIR+POcpaIbfDm
	VsSdkAYWOySUICCTw10zGxlLfczuehE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=KSR3R7D5;
	dmarc=pass (policy=reject) header.from=universe-factory.net;
	spf=pass (diktynna.open-mesh.org: domain of neocturne@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=neocturne@universe-factory.net
Message-ID: <658521a4-cbcf-4f71-b5ee-586bec229bd4@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1781113813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lcq7x01AFOAsOBmf/radJ1N6xxoViPuimWg8PHRj0oc=;
	b=KSR3R7D529eN+UVtLfRVXEFx5TFDlKuGI5usRUdVBwE/bm8cz48Gsf3s2iSbXwvcvi9PS1
	Sy7V/D2mDyRJG4SQh5txlq822ruTbiFJVZ1v4WHwjrgY0foDv/JBpCyYA+km15IO9iO1xU
	KA8e9IWamOb1ZNp5oARQx/Nc++Wfkm59FR9jP1HGcWTMQFN7MeBHmFxkvb7q6jXq3VKFwd
	caSK2gu79B9KoVDEqCYm8AM0B5jp72T5qt8oitfmBCTbTSI92q1Ioqmy6Zi5sh9t6nagne
	ZFjOlNkXqzlq/mkuSpG/dFa+Ql8/c+FBEOS5KH1RJdmOQm6cOIVTe/BKtJW4Iw==
Date: Wed, 10 Jun 2026 19:50:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH batadv] batman-adv: gw: don't deselect gateway with active
 hardif
Content-Language: en-US-large
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260607-gw-disable-check-v1-1-d156beb975ce@narfation.org>
From: Nora Schiffer <neocturne@universe-factory.net>
In-Reply-To: <20260607-gw-disable-check-v1-1-d156beb975ce@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ---
X-MailFrom: neocturne@universe-factory.net
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency
Message-ID-Hash: VBZZHR3DHVM2UDKGMMQVVRZUGU4WGHFI
X-Message-ID-Hash: VBZZHR3DHVM2UDKGMMQVVRZUGU4WGHFI
X-Mailman-Approved-At: Wed, 10 Jun 2026 20:36:21 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VBZZHR3DHVM2UDKGMMQVVRZUGU4WGHFI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 07/06/2026 14:57, Sven Eckelmann wrote:
> The batadv_hardif_cnt() was previously checking if there is an
> batadv_hard_iface->mesh_iface which is has the same mesh_iface. And since
> batadv_hardif_disable_interface() was resetting the
> batadv_hard_iface->mesh_iface after this check, it had to verify whether
> *1* interface was still part of the mesh_iface before it started the
> gateway deselection.
> 
> But after batadv_hardif_cnt() is now checking the lower interfaces of
> mesh_iface and batadv_hardif_disable_interface() already removed the
> interface via netdev_upper_dev_unlink() earlier in this function, the check
> must now make sure that *0* interfaces can be found by batadv_hardif_cnt()
> before selected gateway must be deselected. Otherwise the deselection would
> already happen one batadv_hard_iface too early.
> 
> Fixes: 702c52a87eab ("batman-adv: store hard_iface as iflink private data")
> Cc: Nora Schiffer <neocturne@universe-factory.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>   net/batman-adv/hard-interface.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index 60cee2c2..ae19f144 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -879,7 +879,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
>   	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
>   
>   	/* nobody uses this interface anymore */
> -	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
> +	if (batadv_hardif_cnt(hard_iface->mesh_iface) == 0)
>   		batadv_gw_check_client_stop(bat_priv);

The change looks correct, but this is the only remaining user of 
batadv_hardif_cnt(), and it's only checking if there aren't any hardifs, so 
this could avoid counting altogether and just use

	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))

and drop batadv_hardif_cnt().

We are holding RTNL here, right?

Best,
Nora


>   
>   	hard_iface->mesh_iface = NULL;
> 
> ---
> base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
> change-id: 20260607-gw-disable-check-f3393c3a4989
> 
> Best regards,
> --
> Sven Eckelmann <sven@narfation.org>
> 

