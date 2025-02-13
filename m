Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB94C021A0
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:41:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC26F842BD
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 09:41:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739436102;
 b=1d4ycfoUdN7BVnE/IAJV1nnyr9LU0YP46LX5tVkCFi2Rq6L9bzTgcm/mOv5NWTSURn4cV
 4s58+QCz1mbYcMtsmVhyNUbmlaPgoBJya8ta2RO+Bcm1iXJJfpYY85heMJFbovnjvBslXLc
 xdeBiFMdV2c4G6fJndliU/EUG2QLURI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739436102; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
 b=Q6cwIpahkjF/6GgAbd68tNAoRQm+8kv9i/hZiRrrG8k+DNlA2uf19inpRjZBcgyzSShdj
 6f6j75YqI+iLDYk32gwa7V2Cb+/5MjK0k/hPfdZkmz4TnyTXvu8guiTgjEes9jU4ALyFkhG
 d2xAb1QJXjDrrC8eu/6MgQwynm6Gyg0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9AFFB81888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 09:38:11 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739435891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
	b=OoVR87/EvEqSmH8Qghv/s4f+2XJRAkjR/RTVodWBt+jq1TJi5XxYJdO4wFD9vIis6wXVlp
	hD5N5ZPaLQYVAcKV/wQzEO6iz5MWSptiHne9IZNVKKVlNp5x5lGYAEuBN4idRwX4/iiG0l
	PgNUwo271zfCzMdfFpCFcL3SQ6tzhNo=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739435891; a=rsa-sha256;
	cv=none;
	b=dn1ls/TnfpmpxwLSs3vs9QjdSbCGFC1H/Ugm+043hEVn8pGwzRbvyUiFYs3b99Z0+5EeDj
	i9Nl7+muF3kjPlIETNaj0f4G68GYd3vHIdAlehOS1SUgP1LXQa5jNPMGSUsZmj+x8dFxvb
	fApMAlODWgrDgQs8Urt507++RAYHDUs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=ATTqoTp8;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::432 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so362332f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 13 Feb 2025 00:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435891; x=1740040691;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
        b=ATTqoTp8Y7iDmtcd9CX1EKLApng2QGOLXl6K9Eo2wqXeJSLS2nbamq1flsTR9EeWK0
         KVl24tkO4+Vv7BR1iO4tCouqtln6yyvoqAsmfjPg6FymRHA+UjKIv7XL3A5VlegdL+AB
         GaZI1/PU6ZKPDp3+9mWQN0O2vxbKLxKJspm6wJSZ5roweXUtDmHfo5pBC+tH5N3LExfn
         IqxdhHyhvqx1TAKqeh/O5bagOsK0lH5TEB9ed7clHeTy3Ujl/JPThGkKNLM6XedGJytV
         /BhhABMZ5AoCuD+97BV2GQnzV7W2qhJ/uvJimXQJwR/VOdYR/75eZ4cA77t2azuqUxba
         fg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435891; x=1740040691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
        b=lD7Pk41azGzG/9HPWkFK5dNwMhnStVH05j79SjNBgFhzBkO66VVY+AzglwCdJqFn3Q
         zAYmHNSzkw9HbzzAs1r2/hqIG/OKwqo9Ok1N/VKIzyZxgpsRSGQkCbleq3fXcSR+uutI
         BdNtX+I556wSUKTltNL1JugQu8DA7LBi/myzoTyAdF4xXhjUQv3nfYXq4UnqxvYFIzm3
         fIBj7hMHEt3fZ22CUPX7iDgEYaUJLiB07W0tG8vStQheTnwovQ6gyhSD5EoNRjsH52Ab
         QC/0sYUfbI3OWdzdbHyJr06wqa8apuqPE2TBsWAkHhtRjnYyr976F9Xuy9/3YioEl4wW
         dKSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkZpWHT7M3A/9Ljzdv/MZd+nfk8fKiH3zM7EXj+O88y/tRdrq2VdFJjJ+qrIzbBwjJ2aCC1dJm0cy91g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzD8J4k4eDbcksCYbK2kWx8ZBHdZ/B5xUS7dEvKT6bo4kDvruqw
	Paj3DZ3o61W4d3bs4LmmXbTF5Lsu3/uZwapwlTpCSAjXGmn/PqwiLqs1xaRgt7X8r/f8kcIIAsE
	YGGHOpcEgQpqB17L/Qx4JxIzO3Jk=
X-Gm-Gg: ASbGncv6SocVlN5iNpGITvPyckROhnDMCWgexSAteJSOhBnqS8Oigg6eSCLOUs0ARj5
	Yj3Cw6x2/TOu11idypjeyqbjBiVS6YOo7EYwQqtVHt8E6L4ceLbG/YdQt8LVVP/RL+g3U3Nc=
X-Google-Smtp-Source: 
 AGHT+IGWOHKGGlDa4+BOJnu+aApZc9NQsBvpdTnebLsDtomfgfUQKAEsY8KxAxXyKMsTrm9S+vIZHhG3h4B48IT9F4E=
X-Received: by 2002:a5d:47a1:0:b0:38d:d299:7098 with SMTP id
 ffacd0b85a97d-38f244d4b2fmr2390520f8f.10.1739435890988; Thu, 13 Feb 2025
 00:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20250210133002.883422-7-shaw.leon@gmail.com>
 <20250213070533.9926-1-kuniyu@amazon.com>
In-Reply-To: <20250213070533.9926-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:37:34 +0800
X-Gm-Features: AWEUYZmLH4fO7VI_1h6eRsVKRwr1I73htkPFG-ZDVD1uQ9yC1n8P3g2_7anIJyE
Message-ID: 
 <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch,
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev,
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org,
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org,
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org,
	stefan@datenfreihafen.org, steffen.klassert@secunet.com,
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 64K25MBC5OIMVSCQ2TDPCPIDDMUUDEGU
X-Message-ID-Hash: 64K25MBC5OIMVSCQ2TDPCPIDDMUUDEGU
X-Mailman-Approved-At: Thu, 13 Feb 2025 09:40:44 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/64K25MBC5OIMVSCQ2TDPCPIDDMUUDEGU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
[...]
> > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > index 863852abe8ea..108600dc716f 100644
> > --- a/net/ipv6/ip6_gre.c
> > +++ b/net/ipv6/ip6_gre.c
> > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_d=
evice *dev)
> >       tunnel =3D netdev_priv(dev);
> >
> >       tunnel->dev =3D dev;
> > -     tunnel->net =3D dev_net(dev);
> > +     if (!tunnel->net)
> > +             tunnel->net =3D dev_net(dev);
>
> Same question as patch 5 for here and other parts.
> Do we need this check and assignment ?
>
> ip6gre_newlink_common
> -> nt->net =3D dev_net(dev)
> -> register_netdevice
>   -> ndo_init / ip6gre_tunnel_init()
>     -> ip6gre_tunnel_init_common
>       -> tunnel->net =3D dev_net(dev)

Will remove this line.
