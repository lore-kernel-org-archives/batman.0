Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38D6C3601E
	for <batman@archiver.kernel.org>; Thu, 10 Apr 2025 09:44:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 152D784231
	for <batman@archiver.kernel.org>; Thu, 10 Apr 2025 11:44:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744278295;
 b=YlnSTWV7ydgA6T5NVnuqNIPaO6npIDGn30MvGYhBqmY9rmXzycCHzGgjPwBSJgwnStuYx
 IGciaFz2uZBzkpiCcdm7zAUeTgrPwpw2QZptxmzp0U8WPSTMI2gXlDz8SM3HwlAHal336GQ
 Z6QWPqp5g1QYRX5CYbNWbUmRexvVnRw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744278295; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5nAtlRD1SD1FnueD/4933Lhj4YikOMo+7K9M6mX4gb0=;
 b=ZgW/NzQMLjK4xLlcEESTy5SjjAdERV88lgvJpkRXQtuEtASiF4Vk0WMaWVTeTNuBEfx2f
 jFaOEexR/2IeDgbCYcJVS3v6B29Wk+9Hizl+x81GKqVY/O7zqW4avCXX/aHy8zwPCFu1nBh
 XlfsKcxNAZProlQJ0kb3nE1bB1h6p5k=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0942D8095F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Apr 2025 11:38:11 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744277892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5nAtlRD1SD1FnueD/4933Lhj4YikOMo+7K9M6mX4gb0=;
	b=lN6PR1zia0oKHoL43vIbotAQwH6XMW/w10EYwEdL7nOZ0PWnrz6P3ABz8ir86xVx21yHoM
	kpY3JIj0WHfn3dA5e11jUZofc4/W8pVZOZuuLIzY/clxowUsS/05U7K3KmMGqbb+47YGYj
	z1fwi6OACNtoFUEJF8n3anBqeVh9DlQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=abj0I8FQ;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.129.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744277892; a=rsa-sha256;
	cv=none;
	b=IpdVe1/XLdHF6NtfRpU1b+cMCSEDt+FlhMLTGipdindfEyS74SgPQQFWUUs4/1bko+0NDi
	DQ8A22v0US1RoJWvC1y5B5sPS4i/RRW/kC37aPOB/Oq1AGaMF/tEWIPSDzK2XtHaBAgf+8
	25yXyWlFXU6ypxgJNOtdx+jayo7/eXw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744277889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nAtlRD1SD1FnueD/4933Lhj4YikOMo+7K9M6mX4gb0=;
	b=abj0I8FQl5qV6nmWLSfBFgVPoqtAP42NYvnHGm0+0tWhkdkK4ALW0BZifPw/2tCvkrXqoi
	lSZ9wI32sc7BvW0BDsFA4wY3pUNU3pOToxhd2AAf44bErvFNGgaoB0FozmNthv7fNx8GHh
	LVllEmBGkZlapKwCW67ltM+u63oG/60=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-Y9wYd3H7Pfu7JlihD2gHEw-1; Thu, 10 Apr 2025 05:38:07 -0400
X-MC-Unique: Y9wYd3H7Pfu7JlihD2gHEw-1
X-Mimecast-MFC-AGG-ID: Y9wYd3H7Pfu7JlihD2gHEw_1744277886
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391345e3aa3so319452f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 10 Apr 2025 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744277886; x=1744882686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nAtlRD1SD1FnueD/4933Lhj4YikOMo+7K9M6mX4gb0=;
        b=R+OuCKQOqHRP/CJ/0wx2YD/sQFqjFHUde5X7y+tgMAJOpXWpYFd7KEWBBYqblUDSsk
         E+N7R/wsEZkHLvuF0I/bE9js6diIB4C3KmKt0/eM7+l8RGY920VsnKwQYhRNkkZRVhA+
         oYaU1rwimUqRqaCFLi7557iAg9hWO5iqrUmuAIz/Vx3KtGonRWKi2MQam6+HP+oHrjp/
         cTNU3dlNou6XG/JXXdX4UL19FZVuVZ8L1AJ48ohXg56LHab3urK1h0ezoHMcoV6dfvnc
         ZgBB2vXSJkxPJcWByY40VlmedCUuS+2xncbRpAXkk6viOJ2bzjeOoGaDUB+6GGe7MPA3
         Q2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg7R58dzwWg1dntTPtuRZvflm2nR+6jZ2o8nAo7Uzhlp31B/+x6nAggym5HNKVRj0sAG6aKkLSDxtB7A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxqDNJO04kqy/yZnI9PuJwwl6SXtwf/Vr76ajJVkqaqJUfgTNvD
	Rq3V/+e07G2KxII33N3e+abz3bvA5JysoEeIEnjEAe7wp3B/EuCCPcmU8VEA8Pe4ou4Q02piMhP
	VfZeiss+jn3y87FBZzjMkM1Zzw+/mPt2OKEkrhOgNQ8jIH8Hp/I+d30cEkTe6b9YyzQ==
X-Gm-Gg: ASbGncsCzakHYypXIiBjpx48FRW6fBJDlU1K0X/6FsprzGqVxrDn1LwJlyuOURcL0ET
	kZyqXyqi02tUydoY0IGC6KJBX1vItzBLuBI8Jg6ION1smDSsb3VUupl4eu40hdZt6bVq00QINL+
	J9xkW3Q8649zunfu3w8L/+b+LtXGH3IxRjj+PAFDkdv+rqm4Q6erXYjAy5705RDof7HlwEWtf3R
	uc45T07PrHRdLhalhiO5yKP1S5VWgegbsiYNlm+8LkAsrLbbuBDMuaP6Ffp+qtlHwZQDKhiSVIs
	hXQ77J/Kjyo0MHRVbQmFP8jZ+oa1miah0//EgT8=
X-Received: by 2002:a5d:648c:0:b0:391:39bd:a381 with SMTP id
 ffacd0b85a97d-39d8f49708emr1636509f8f.30.1744277886209;
        Thu, 10 Apr 2025 02:38:06 -0700 (PDT)
X-Google-Smtp-Source: 
 AGHT+IHP9qWEYHSTC7t96gFl7jps5HgUrG6cktSPOqd8D6me9EFDIqtGIAeX+QbvTYrXfC4tWv9DXQ==
X-Received: by 2002:a5d:648c:0:b0:391:39bd:a381 with SMTP id
 ffacd0b85a97d-39d8f49708emr1636481f8f.30.1744277885798;
        Thu, 10 Apr 2025 02:38:05 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893775b9sm4322609f8f.35.2025.04.10.02.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:38:05 -0700 (PDT)
Message-ID: <0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>
Date: Thu, 10 Apr 2025 11:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] batman-adv: fix duplicate MAC address check
To: Matthias Schiffer <mschiffer@universe-factory.net>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: 
 <c775aab5514f25014f778c334235a21ee39708b4.1744129395.git.mschiffer@universe-factory.net>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: 
 <c775aab5514f25014f778c334235a21ee39708b4.1744129395.git.mschiffer@universe-factory.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lMCXbMO-dpjHvA92wzVu--Axf_Nd5bJdMqWZQZkkIBg_1744277886
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: JKX7W2Q2FXEV733ASSDPNIHXLCGZ6EB7
X-Message-ID-Hash: JKX7W2Q2FXEV733ASSDPNIHXLCGZ6EB7
X-Mailman-Approved-At: Thu, 10 Apr 2025 11:44:35 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JKX7W2Q2FXEV733ASSDPNIHXLCGZ6EB7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 4/8/25 6:30 PM, Matthias Schiffer wrote:
> batadv_check_known_mac_addr() is both too lenient and too strict:
> 
> - It is called from batadv_hardif_add_interface(), which means that it
>   checked interfaces that are not used for batman-adv at all. Move it
>   to batadv_hardif_enable_interface(). Also, restrict it to hardifs of
>   the same mesh interface; different mesh interfaces should not interact
>   at all. The batadv_check_known_mac_addr() argument is changed from
>   `struct net_device` to `struct batadv_hard_iface` to achieve this.
> - The check only cares about hardifs in BATADV_IF_ACTIVE and
>   BATADV_IF_TO_BE_ACTIVATED states, but interfaces in BATADV_IF_INACTIVE
>   state should be checked as well, or the following steps will not
>   result in a warning then they should:
> 
>   - Add two interfaces on down state with different MAC addresses to
>     a mesh as hardifs
>   - Change the MAC addresses so they confliect
>   - Set interfaces to up state
> 
>   Now there will be two active hardifs with the same MAC address, but no
>   warning. Fix by only ignoring hardifs in BATADV_IF_NOT_IN_USE state.
> 
> The RCU lock can be dropped, as we're holding RTNL anyways when the
> function is called.
> 
> While we're at it, also switch from pr_warn() to netdev_warn().
> 
> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Even if marked for net I assume this will eventually go first via the
batman tree.

> ---
> 
> Aside: batadv_hardif_add_interface() being called for all existing
> interfaces and having a global batadv_hardif_list at all is also not
> very nice, but this will be addressed separately, as changing it will
> require more refactoring.
> 
>  net/batman-adv/hard-interface.c | 37 ++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index f145f9662653..07b436626afb 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -506,28 +506,34 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
>  	return false;
>  }
>  
> -static void batadv_check_known_mac_addr(const struct net_device *net_dev)
> +static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_iface)
>  {
> -	const struct batadv_hard_iface *hard_iface;
> +	const struct net_device *mesh_iface = hard_iface->mesh_iface;
> +	const struct batadv_hard_iface *tmp_hard_iface;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
> -		if (hard_iface->if_status != BATADV_IF_ACTIVE &&
> -		    hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED)
> +	if (!mesh_iface)
> +		return;
> +
> +	list_for_each_entry(tmp_hard_iface, &batadv_hardif_list, list) {
> +		if (tmp_hard_iface == hard_iface)
> +			continue;
> +
> +		if (tmp_hard_iface->mesh_iface != mesh_iface)
>  			continue;
>  
> -		if (hard_iface->net_dev == net_dev)
> +		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
>  			continue;
>  
> -		if (!batadv_compare_eth(hard_iface->net_dev->dev_addr,
> -					net_dev->dev_addr))
> +		if (!batadv_compare_eth(tmp_hard_iface->net_dev->dev_addr,
> +					hard_iface->net_dev->dev_addr))
>  			continue;
>  
> -		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
> -			net_dev->dev_addr, hard_iface->net_dev->name);
> -		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
> +		netdev_warn(hard_iface->net_dev,
> +			    "The newly added mac address (%pM) already exists on: %s\n",
> +			    hard_iface->net_dev->dev_addr, tmp_hard_iface->net_dev->name);
> +		netdev_warn(hard_iface->net_dev,
> +			    "It is strongly recommended to keep mac addresses unique to avoid problems!\n");
>  	}
> -	rcu_read_unlock();
>  }

I feel like the above code mixes unnecessarily fix and refactor
(variable rename, different print helper usage).

I think the fix should be minimal, the refactor should land in a
different patch for next.

/P

