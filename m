Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D36E7717F
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 13:09:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 00B2783FC1
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 14:09:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734008991;
 b=S2aBSj4Wv1xItkqpXi1i6XzA+VDjJQd9wxAJ4/fzlGVEfn7i/5guMMgijoS7eivLV3rgK
 XXmrDGWNywIa4H/MWREK7vM0vrehyYoie0J4jUjjQOLP5H+pIzmDXhkcVH8RPBtyIbcVYSZ
 oSjqZp8ZrjBiOP7lQcKDOMJMNKjBkk4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734008991; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
 b=0PYdc+re/iCQiMNL3nrYQOyQRFuZM3t9MeppGwxyehNv/TtEJJxDH3DUNOVbvH+qRflqO
 dmRdJKDTwN/4dDhFbTiliXdCxHDpx3VSd2zn0Rk/7WEm2momEzVUphoAaaONGPZ90lwL7OG
 2pzjQYiUXR59KnFoVLBB0fkyMJQwti0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 222528205B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Dec 2024 13:41:44 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734007304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
	b=cinYegs6wWyHUvbsDk7JNl5kLjhteQmS4umoEqS9T2T0kh/S979vzdWYw/nRQQKeXPSPRI
	La1XXpGhPBzAIZGtmcJikSjSRBPq+qRghxoZ0cM4/TcGQFmmwPh8ldPLlZ7+duKDXy8X9B
	1vAZFW+3N8hQHxl1kqjs4NFtkKTB59o=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734007304; a=rsa-sha256;
	cv=none;
	b=PUsHAuegzKRZX5vkSGQ15VgGyvPciMuS8MG1gQaOEN+1nWqS9TE24In4qn6g5424XFBH2d
	X8zrpT/sCPsVZY08flHPyXLMUb3uxaL4T4VRmTxx97JtCCE8+0KGTVrPUIOeNEeOZcwaRs
	7CswaAbDUaaoGCil61kCsFvNlqpl1hg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=a4opUMTv;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::335 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso6020235e9.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 12 Dec 2024 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734007303; x=1734612103;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
        b=a4opUMTvlKC6gdkRVfFuIFEPDJVndf/uYwUlllxta8R7jXSK5DdcvUMozAry1J3ChV
         cbYxxr24iMJzTqNUIqmY/YISUQWPWTtL8kR/FxRt18obOyk6noib6hUIaQ/wA/bIerO5
         ZqnCzr6a6KJ+hBXYw2/PzBxt2BEv389UMGAq8avmxtmXbsXWnFtL4mquIVkxLIBP6BtB
         Owj8PKNReS4IMliK3vDcJDuRgNR3Hg4WUeH5vmBem2g5xS8xQjiCgiG4MeoxXJjSVsip
         2r4mgfRkpw7rVXMq4wvXQ57swy/PrfN4E8gwl8paDXto3yAP/qIYHJNqW5IgbzjbXMBL
         vlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007303; x=1734612103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
        b=cQlFVodAeCKDk0RxaV1vUv04ITZJ9EYjD8sl9wGZ9LjHG+ltmegoi3nPmRd4wtS8TK
         fRuzi3Ci4aSn5guISwRS8VOhPDjp6XSxl5mSn+rgmj/vU5BpEr4+t7FQV+eKkcqsfNAp
         92dUuKeNpQmwus0LQPRae4mXPaksuYOhq/TkM/4yLWZOjeJfXLYs1GevldJS5/68Bqab
         wOpPbh6xErqqeQ27ib+Nv7G0TBaA4J4HlMm87lZ6kGPmjNkJIpz3GCIAekgPkx25sAxA
         fWMA6j/4JzdODsvVsrAPtD3+6o58n/btkSXgpW+Hx8xdjM3OJ1Gps2ra2V1aCVvRUPiY
         n1UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW65OhS3FSfQfrIU6PV5FmE4D6m41GvZDBCrVUnh5/PlHiA8Kb79wSr7QESUeea7jem6NRItmRetO9BQQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yy52Y6mMkzFVs4oA88cRVSKFwfBTG3CHWoUQNjzmcSVzPDQMlBQ
	sOQhSHPUxbAVOekcZURc4v75/4Xn74HEsDn8zmkXs3MZddYE7MDxFq1GaSVAHmrTRzBa7NxjKaK
	a6YXFCgmit4LJzhCjCyv1WLjA00Q=
X-Gm-Gg: ASbGnctAJf2hZ987CA2zog6xZbVvG7Eh8szL0iiEymddsujqHh6TxwqDhFhoanRGDsq
	F8jz+CjJcm/3fuQK8fzFaTaFhprOv+qlJATdU
X-Google-Smtp-Source: 
 AGHT+IFqFk9dpKGWg1iKfKEea53yF0KmGIqYqHw17PI/mHu0HdGMd6qhUvlxmt/ZCzWy1qtAEPF2qQKT7Apiv7Ssc/8=
X-Received: by 2002:a05:6000:a0b:b0:385:f44a:a68 with SMTP id
 ffacd0b85a97d-3878769805bmr3014357f8f.35.1734007303234; Thu, 12 Dec 2024
 04:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-4-shaw.leon@gmail.com>
 <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
In-Reply-To: <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 12 Dec 2024 20:41:06 +0800
Message-ID: 
 <CABAhCOTv1tDOXBEE56CL1-S_J6ADZTcvso5GHtkarzJMqOC4xQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] rtnetlink: Decouple net namespaces in
 rtnl_newlink_create()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: SBZJULL6VXJHX5T7B2HVYNLUIUZXKBO3
X-Message-ID-Hash: SBZJULL6VXJHX5T7B2HVYNLUIUZXKBO3
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:09:32 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SBZJULL6VXJHX5T7B2HVYNLUIUZXKBO3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Dec 12, 2024 at 5:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/9/24 15:01, Xiao Liang wrote:
> > There are 4 net namespaces involved when creating links:
> >
> >  - source netns - where the netlink socket resides,
> >  - target netns - where to put the device being created,
> >  - link netns - netns associated with the device (backend),
> >  - peer netns - netns of peer device.
> >
> > Currently, two nets are passed to newlink() callback - "src_net"
> > parameter and "dev_net" (implicitly in net_device). They are set as
> > follows, depending on netlink attributes.
> >
> >  +------------+-------------------+---------+---------+
> >  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
> >  +------------+-------------------+---------+---------+
> >  |            | absent            | source  | target  |
> >  | absent     +-------------------+---------+---------+
> >  |            | present           | link    | link    |
> >  +------------+-------------------+---------+---------+
> >  |            | absent            | peer    | target  |
> >  | present    +-------------------+---------+---------+
> >  |            | present           | peer    | link    |
> >  +------------+-------------------+---------+---------+
> >
> > When IFLA_LINK_NETNSID is present, the device is created in link netns
> > first. This has some side effects, including extra ifindex allocation,
> > ifname validation and link notifications. There's also an extra step to
> > move the device to target netns. These could be avoided if we create it
> > in target netns at the beginning.
> >
> > On the other hand, the meaning of src_net is ambiguous. It varies
> > depending on how parameters are passed. It is the effective link or pee=
r
> > netns by design, but some drivers ignore it and use dev_net instead.
> >
> > This patch refactors netns handling by packing newlink() parameters int=
o
> > a struct, and passing source, link and peer netns as is through this
> > struct. Fallback logic is implemented in helper functions -
> > rtnl_newlink_link_net() and rtnl_newlink_peer_net(). If is not set, pee=
r
> > netns falls back to link netns, and link netns falls back to source net=
ns.
> > rtnl_newlink_create() now creates devices in target netns directly,
> > so dev_net is always target netns.
> >
> > For drivers that use dev_net as fallback of link_netns, current behavio=
r
> > is kept for compatibility.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
>
> I must admit this patch is way too huge for me to allow any reasonable
> review except that this has the potential of breaking a lot of things.
>
> I think you should be splitted to make it more palatable; i.e.
> - a patch just add the params struct with no semantic changes.
> - a patch making the dev_change_net_namespace() conditional on net !=3D
> tge_net[1]
> - many per-device patches creating directly the device in the target
> namespace.
> - a patch reverting [1]
>
> Other may have different opinions, I'd love to hear them.

Thanks. I understand your concern. Since the device is created in common
code, how about splitting the patch this way:

 1) make the params struct contain both current src_net and other netns:
        struct rtnl_newlink_params {
                struct net *net;        // renamed from current src_net
                struct net *src_net;    // real src_net
                struct net *link_net;
                ...
        };
 2) convert each driver to use the accurate netns,
 3) remove "net", which is not used now, from params struct,
 4) change rtnl_newlink_create() to create device in target netns
    directly.

So 1) will be a big one but has no semantic changes.
And I will send Patch 1 in this series to the net tree instead.

>
> > diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> > index 98c6205ed19f..2f7bf50e05d2 100644
> > --- a/drivers/net/amt.c
> > +++ b/drivers/net/amt.c
> > @@ -3161,14 +3161,17 @@ static int amt_validate(struct nlattr *tb[], st=
ruct nlattr *data[],
> >       return 0;
> >  }
> >
> > -static int amt_newlink(struct net *net, struct net_device *dev,
> > -                    struct nlattr *tb[], struct nlattr *data[],
> > -                    struct netlink_ext_ack *extack)
> > +static int amt_newlink(struct rtnl_newlink_params *params)
> >  {
> > +     struct net_device *dev =3D params->dev;
> > +     struct nlattr **tb =3D params->tb;
> > +     struct nlattr **data =3D params->data;
> > +     struct netlink_ext_ack *extack =3D params->extack;
> > +     struct net *link_net =3D rtnl_newlink_link_net(params);
> >       struct amt_dev *amt =3D netdev_priv(dev);
> >       int err =3D -EINVAL;
>
> Minor nit: here and and many other places, please respect the reverse
> xmas tree order.

Will fix this.
