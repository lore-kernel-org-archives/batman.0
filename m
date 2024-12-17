Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F48EE7717F
	for <batman@archiver.kernel.org>; Tue, 17 Dec 2024 13:53:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4081F83F04
	for <batman@archiver.kernel.org>; Tue, 17 Dec 2024 14:53:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734443623;
 b=cQ3qq11K3ZieWJG5mum8mFzPldSRjNhPATfKwMIFu7UpPOrzpPBFRGZtJDH0Tg5wldsVt
 a5oleEivUHLL8dYO5IZrtYvvLxz+Jp2VTUASZlttaaZ7xt0s2F2GTD7ntrwOmswh744kr1s
 iAgeHvM5LsAe484wdZ4HHcjnGWZ8KPc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734443623; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qjHvfiUl0skHRnGesg4wkOW4piGHtH/yZynKfjU6wF8=;
 b=xibjU3tZrhs6Xyiq+u4l9rduHwALTzC4fFQHnzHnaUwEfAp4pkOwNkwaEtGP/xFthPkR2
 CTjgIg+oGKxU6qPBhmUtTpmb17kZb2flrV7Gbmjq5eS9ihaOu0OYRjA8sacey3FRVuuZZmo
 SLyh6Ssd1/CiurnxtlWxhJHhlvwD0co=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D5F4180EE9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 17 Dec 2024 14:53:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734443605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjHvfiUl0skHRnGesg4wkOW4piGHtH/yZynKfjU6wF8=;
	b=RbSduAhKTkkNgJqVWM20npp1YrrLeX1hUvw4jsot0E0qFufpQHa6Bb6gSDxrcyNBm7ICgL
	OQBar7lMcnRKBLzssgPqmmk8rsHEw/11vfrKLWMKliRBei6Iowr6lUSUTlj882T48fXxvK
	sgebVD6eYSEopPjtNe9+WIometqFWB0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734443605; a=rsa-sha256;
	cv=none;
	b=cKty+TlruaNAFw5Ql9B64jyd7G7wxOql4rtBZkbqCP8Lil576IW07z94Dug4nDGdQxXwDi
	MWd5EpgUUbA4W8Kmfx74AS9ZaR19jDYNEjLIrLgkXFF8H9waWxO/tT+O+ypG9IOZ1Ggx6x
	OWi16DQKf1xwvQxRr1hLMShowklA2rI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0ABB454C5B6;
	Tue, 17 Dec 2024 14:53:23 +0100 (CET)
Date: Tue, 17 Dec 2024 14:53:23 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: Map VID 0 to untagged TT VLAN
Message-ID: <Z2GCU5mOICMJgiwc@sellars>
References: <20241216-no-vlan-0-v1-1-62586f97fd88@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216-no-vlan-0-v1-1-62586f97fd88@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: HPIZP6KIKVMUV57PEN76BGAPNZUHI34R
X-Message-ID-Hash: HPIZP6KIKVMUV57PEN76BGAPNZUHI34R
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HPIZP6KIKVMUV57PEN76BGAPNZUHI34R/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Dec 16, 2024 at 07:37:12PM +0100, Sven Eckelmann wrote:
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 8e0f44c71696f642d80304ec2724e8b5e56a5d93..333e947afcce7ca4128be8406f23295df723515c 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -637,6 +637,13 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
>  
>  	vhdr = (struct vlan_ethhdr *)(skb->data + header_len);
>  	vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
> +
> +	/* VID 0 is only used to indicate "priority tag" frames which only
> +	 * contain priority information and no VID.
> +	 */
> +	if (vid == 0)
> +		return BATADV_NO_FLAGS;
> +
>  	vid |= BATADV_VLAN_HAS_TAG;
>  
>  	return vid;

I guess with this patch all TT entries previously in
TT VLAN 0 would be moved to untagged/NO_FLAGS TT entries, right?

Wouldn't that technically break compatibility? Let's say someone
uses VLAN headers with VID 0 to be able to use priorities / QoS.
What if some old nodes still announced+used VLAN 0 in batman-adv
while others used it after this patch, with the mapping to
NO_FLAGS?
