Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D69EE0211
	for <batman@archiver.kernel.org>; Wed, 11 Sep 2024 07:34:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 299CA83F0C
	for <batman@archiver.kernel.org>; Wed, 11 Sep 2024 09:33:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726040039;
 b=TN4yw/9uYi811VsdW35BHilss3MYC6PYaBLOQG9W70M5Om67lLngFf2yT4/Hl5qZmQEKy
 anMvagNobQJvp/Xl7jv5mrmbwXEo+TORKoluS/SxCQXlTkti5FisyKuCU9Dl/XBRmhr+428
 PLyb5s1wKB+cvt87pZBYLIdiz2jLZlA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726040039; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HoeL62Kx25xvyhdIjRpPTA3lL2OzazuPGd87A4NJfhM=;
 b=VFyqto6RRcV8HE7SUocDW4+Up447JZQDaF2U+xF2uChLuvjjXbw5LqvANFjg1v/HLgSYh
 1XbYb3/HxWqnD0v/Q9VHRMf+N9hRUnTFpWYMN1FZuxcxMCds9WhVOnSwm7T0XVtQdsuEq5k
 heM3W/ZuYVZD+lMNeSVBD+jMmZ6EaA8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0524D81FB4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Sep 2024 09:33:22 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726040003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HoeL62Kx25xvyhdIjRpPTA3lL2OzazuPGd87A4NJfhM=;
	b=jYIIYlt0Yd78JE5108eDwbePX+78MxegszSdtN0QSe1WbtVor/VRSwkOXsuPMtXbrIzqGZ
	fAJu/uxV2uMtY7h9w86yzBO7/e+YJgnnprRhQvdrQCLFVbv4RFByT36KrlMLjgonnFt3XQ
	5Eenknsi0IoWiANFJ0BRAzUMnc99lS4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=OCsWqnct;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726040003; a=rsa-sha256;
	cv=none;
	b=zkjoPuO63lpavqjmhGPwbkywcChIEfP46yr+F65D4JYIz9/uIFQe6f1nASFofZVMkHXap8
	JtL6JmlNzx+ZFNu8kRI9BF+l3/NLiUqOR/Ln++o80r0/NpZCOppihfHNXlYpfoQOT9+LD8
	Fhnq7Lvvpirv9plmX2m8O95Ky5KlIGM=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 9BC17984;
	Wed, 11 Sep 2024 09:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726040002;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HoeL62Kx25xvyhdIjRpPTA3lL2OzazuPGd87A4NJfhM=;
	b=OCsWqnctw+Ob3SkjnyBD/c7pplz4YAgvvZQEpfkDrKliSWrozF3SeHAjz9loBZ9q
	m7eoU4x53GuQlSuMybcMCZAv6qJxKjkM5OlNGDQV4SqKRLSdZTEXoQbAKkzfZfqtWws
	ROYDhKlGElAtMg0NOx/D2jb7afB7lt/g9NvlXndS4M8whHIfoZ+4bzbyQ9PUwBJVwL7
	4OaInOzwYCSO8C+RPibKIbTrVGCvcO0Nqf0QJsPyegZvvVFQpYPiKLC66M5orOPhd1O
	uImYF65ghZBdiKJXeqlAr2F349ZCu6gTqeX3JjJVRJhKBrVDWtA3psJQFClXbSwCffp
	YtEPnFS7SQ==
Received: by smtp.mailfence.com with ESMTPSA ;
 Wed, 11 Sep 2024 09:33:19 +0200 (CEST)
Message-ID: <0f7c0a9f-6577-4d37-8ad3-2a6b1369b539@unstable.cc>
Date: Wed, 11 Sep 2024 09:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] batman-adv: split DAT cache into DAT cache and DAT
 DHT
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 b.a.t.m.a.n@lists.open-mesh.org
References: <20240911051259.23384-1-linus.luessing@c0d3.blue>
 <20240911051259.23384-2-linus.luessing@c0d3.blue>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20240911051259.23384-2-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: GPBKAVDG5YMMHMVS7HRBVZWTPG56QNJQ
X-Message-ID-Hash: GPBKAVDG5YMMHMVS7HRBVZWTPG56QNJQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GPBKAVDG5YMMHMVS7HRBVZWTPG56QNJQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Linus,

On 11/09/2024 06:57, Linus Lüssing wrote:
[...]
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index 00840d5784fe..fe0b9b229bff 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -1231,8 +1231,11 @@ struct batadv_priv_dat {
>   	/** @addr: node DAT address */
>   	batadv_dat_addr_t addr;
>   
> -	/** @hash: hashtable representing the local ARP cache */
> -	struct batadv_hashtable *hash;
> +	/** @cache_hash: hashtable representing the local ARP cache */
> +	struct batadv_hashtable *cache_hash;
> +
> +	/** @dht_hash: hashtable representing the local DAT DHT */
> +	struct batadv_hashtable *dht_hash;

I haven't followed previous discussions, therefore my question may just 
sound redundant, but if "cache_hash" is for ARP what is the "DAT DHT"? 
(the A in DAT stands for ARP).

Moreover, it seems with this approach you are converting the DAT concept 
into something "type specific" - am I wrong?

Is it truly required just to have a different timeout?
Wouldn't a mark on entries be enough to instruct the subsystem about 
what timeout value to use?

Cheers,

>   
>   	/** @work: work queue callback item for cache purging */
>   	struct delayed_work work;

-- 
Antonio Quartulli
