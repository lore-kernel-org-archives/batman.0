Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9226E7717F
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 09:56:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1E82E83F6B
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 10:56:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733997405;
 b=LZ8cGkqKE8/8iu9jCe5Zaxgw8XvZeNZSQHTF4O2iGGlWHoi8ITAQTPWRixdKgglRK25BA
 IpnQLdiJBdHA9Kipd5Oavzhrk70JPMST8STwMlZcs0zohWHukZi2EQ2PCMMOumAvqRQdmaY
 /3m8Xa/6AeOOH4le5Gk9o4Wh1PDSEic=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733997405; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YQDLEldT18Fc0IWLf1h2y9YzeGe3KbZy7EnSjmgH5Ac=;
 b=Zhhhh+dDZBcvdSjPtVKJIgb5RuqtIzPPdIf7fwDv/mYduMY6H8CUSVyQJNbfrpUJG1e62
 T+8VPXmxN553D+1/x7ziIyeaTWPuO+1xs14qI1hK/KuR96VArU7cZy0YFZn4HaPp8SVHG6i
 3s3p9DVMPTVy3Pe3CR+F7Fv0nK9Tey4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=none
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D05328233A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Dec 2024 10:27:54 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733995676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YQDLEldT18Fc0IWLf1h2y9YzeGe3KbZy7EnSjmgH5Ac=;
	b=n+MqwWLuQZF+XHD+LIs5L+JOlE3Q2YbbYSH342bdIkPN6QWsTEi0RBMDGHELHA6xNYS5Ht
	ys6MUko5BhE2KhdiMV6nt068D8uDxgEOye/BYYaa8GQOCbcbL/9su96IaTZ3m4lkKO8BQv
	E8jQppIZq/2VMc1rK+DJ9fBfh/q8Dwk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733995676; a=rsa-sha256;
	cv=none;
	b=crMODa6xnjnfO8Dkaez2XjUOPrOyw+uU1nHJ5n9U8wVLcFd4n+6q2S/qtz0rDf5S6HPwAv
	jE/l1zjBLxnEp2R/DNK86zR935Kj2X1u7ljfO8rVDvipi+/PdcOVYbEllIJtcnAO3VsLwa
	+sQusXit50o/4RXis1xGCKV1L1tIt7Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=c87EtkV6;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.129.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=none) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733995673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQDLEldT18Fc0IWLf1h2y9YzeGe3KbZy7EnSjmgH5Ac=;
	b=c87EtkV6eYaUI8u387TMDiiFfhEPpYXq+7Js0ftv7XrrdVSAewFJozVdeBZipmXtche6+F
	lxsaMfZizWIo4ZpPWuLhJAcFhK37BMzxZ8vXmyeMC+Kvs5pqFJbsmOh13vs0vZxH2kXCWi
	M8Ns+xqwNWwAPX8HuKvFjRktYTnBV9Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-_SWf8Y0DN0uy4gZEV4639g-1; Thu, 12 Dec 2024 04:27:52 -0500
X-MC-Unique: _SWf8Y0DN0uy4gZEV4639g-1
X-Mimecast-MFC-AGG-ID: _SWf8Y0DN0uy4gZEV4639g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434f387f346so2309945e9.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 12 Dec 2024 01:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995671; x=1734600471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQDLEldT18Fc0IWLf1h2y9YzeGe3KbZy7EnSjmgH5Ac=;
        b=GMPkcZhqZUfD/QCru+KzzQsE+XWa/A5SocShpPmnej4j9SyvWlhCDDDK9uwr9mvQfZ
         Sp0J7whfmAdDRZnfhA3rwi6W3dPpZVRh2lXsxW1xDfoZoGsTQkVHKakL9hGeuQAZIJxv
         TkGeLwDrm41E1lR8bS2O/kZwVoIppb7gxDBTxPK+BufueroGxph36ucn1Ob29j+zlWcv
         t8HanJ05HJuKaGPVK4RSCfDxTbbRzumyJlUNMaNVw9nn8xjMgwg5yX/NhGVkgApJXgjJ
         9jTWUy4cA1Zp3LdN2f8KRPu2Z0QpLNcXuTJnhEpNHrkA+JlPy+IjmG/lpRohF/6zOuuw
         CJrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl55WAS8jlS8jwLc1kf+Y16DA2Lvr7Hk0GhCmIUhJRhieTSfUrXvVFMDj4kLBdztn0Vl8bVjMB2kzadg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwB3ePfoxATcTNi8C5WBhXllS4I/hCyigVz6w0s2fHn1nSpXI/f
	5HxGR7G+bNh7xXUs+Kcj6A9x+6golx9o+91nmjrrTyYjG6YC4inwWaS+oH/Oazad/YOGp28ma8J
	rVcX9061QhwHQauLrOSWocz8B6MtfRVCqO3lcW7J3DAhrsBjB7z1zUJTuIAlf+a+esg==
X-Gm-Gg: ASbGncsQWjSH9KMSUDpqDoQ5kU9FQB4+SlUFUiEuKNQFlwWQq9Ob5iBdCgUhwTXAKqI
	pkQnC/JlPqfs89HdJKIh8HxtU4AhonqcNVDcS8txRFMKEjlBY4eoSGvEBrzC9O4db4UipsYc//p
	tegKe0F7gg3z1QRi2h3+S1D9Vl+Xz4lNEnTvoy9UhDHuvKQTUNcJCHh7FHhlsdNEf0fxwqv2cWq
	DU/iA4aNZohom3vrivi0N7Jfx23peCzt3d4f7ZFAeNyW08g7LEE0oCaJcElBcy7Ee9bbNsSM2Cz
	ddntu/c=
X-Received: by 2002:a05:600c:548a:b0:434:f609:1afa with SMTP id
 5b1f17b1804b1-43622823a9bmr23142055e9.4.1733995671088;
        Thu, 12 Dec 2024 01:27:51 -0800 (PST)
X-Google-Smtp-Source: 
 AGHT+IGfecq/fvmxWbZmLr9mwKSJq21xM6RVRZ1wSoCEsNQjvNePz0TX5CuMdaiXcW+mTqnLDcuA8w==
X-Received: by 2002:a05:600c:548a:b0:434:f609:1afa with SMTP id
 5b1f17b1804b1-43622823a9bmr23141765e9.4.1733995670687;
        Thu, 12 Dec 2024 01:27:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256b42a3sm10746345e9.28.2024.12.12.01.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:27:50 -0800 (PST)
Message-ID: <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
Date: Thu, 12 Dec 2024 10:27:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] rtnetlink: Decouple net namespaces in
 rtnl_newlink_create()
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-4-shaw.leon@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209140151.231257-4-shaw.leon@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bd7QRMuOz1bopKZbxGNB8GcuePfqSR9cayQLfRT10Ow_1733995671
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
Message-ID-Hash: PROXYY43LXOVQ5Q635MBRAWJ5KHR57KQ
X-Message-ID-Hash: PROXYY43LXOVQ5Q635MBRAWJ5KHR57KQ
X-Mailman-Approved-At: Thu, 12 Dec 2024 10:56:21 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PROXYY43LXOVQ5Q635MBRAWJ5KHR57KQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 12/9/24 15:01, Xiao Liang wrote:
> There are 4 net namespaces involved when creating links:
> 
>  - source netns - where the netlink socket resides,
>  - target netns - where to put the device being created,
>  - link netns - netns associated with the device (backend),
>  - peer netns - netns of peer device.
> 
> Currently, two nets are passed to newlink() callback - "src_net"
> parameter and "dev_net" (implicitly in net_device). They are set as
> follows, depending on netlink attributes.
> 
>  +------------+-------------------+---------+---------+
>  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
>  +------------+-------------------+---------+---------+
>  |            | absent            | source  | target  |
>  | absent     +-------------------+---------+---------+
>  |            | present           | link    | link    |
>  +------------+-------------------+---------+---------+
>  |            | absent            | peer    | target  |
>  | present    +-------------------+---------+---------+
>  |            | present           | peer    | link    |
>  +------------+-------------------+---------+---------+
> 
> When IFLA_LINK_NETNSID is present, the device is created in link netns
> first. This has some side effects, including extra ifindex allocation,
> ifname validation and link notifications. There's also an extra step to
> move the device to target netns. These could be avoided if we create it
> in target netns at the beginning.
> 
> On the other hand, the meaning of src_net is ambiguous. It varies
> depending on how parameters are passed. It is the effective link or peer
> netns by design, but some drivers ignore it and use dev_net instead.
> 
> This patch refactors netns handling by packing newlink() parameters into
> a struct, and passing source, link and peer netns as is through this
> struct. Fallback logic is implemented in helper functions -
> rtnl_newlink_link_net() and rtnl_newlink_peer_net(). If is not set, peer
> netns falls back to link netns, and link netns falls back to source netns.
> rtnl_newlink_create() now creates devices in target netns directly,
> so dev_net is always target netns.
> 
> For drivers that use dev_net as fallback of link_netns, current behavior
> is kept for compatibility.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

I must admit this patch is way too huge for me to allow any reasonable
review except that this has the potential of breaking a lot of things.

I think you should be splitted to make it more palatable; i.e.
- a patch just add the params struct with no semantic changes.
- a patch making the dev_change_net_namespace() conditional on net !=
tge_net[1]
- many per-device patches creating directly the device in the target
namespace.
- a patch reverting [1]

Other may have different opinions, I'd love to hear them.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 98c6205ed19f..2f7bf50e05d2 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3161,14 +3161,17 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
>  	return 0;
>  }
>  
> -static int amt_newlink(struct net *net, struct net_device *dev,
> -		       struct nlattr *tb[], struct nlattr *data[],
> -		       struct netlink_ext_ack *extack)
> +static int amt_newlink(struct rtnl_newlink_params *params)
>  {
> +	struct net_device *dev = params->dev;
> +	struct nlattr **tb = params->tb;
> +	struct nlattr **data = params->data;
> +	struct netlink_ext_ack *extack = params->extack;
> +	struct net *link_net = rtnl_newlink_link_net(params);
>  	struct amt_dev *amt = netdev_priv(dev);
>  	int err = -EINVAL;

Minor nit: here and and many other places, please respect the reverse
xmas tree order.

Thanks,

Paolo

