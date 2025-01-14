Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C59E77188
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 12:33:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 89A1B83D06
	for <batman-adv@archiver.kernel.org>; Tue, 14 Jan 2025 13:33:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736857988;
 b=MU/Zo6GyiFmPRwMJOYeuVnGkzSNOCmVZ75xJFXAjgdC90pCU0HY2mOb3frCpPm3cpsM9D
 d65gA3x1KFloCfFa6U4Sd+S3XKwuXJp8iYwumVP4ZKEPmzlyjG0PcgZTdIrfyQyfmWECPX5
 DBY1643KiDAzXXG+ylAFqrt3MQrG2go=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736857988; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RJdpc5af8GraPbTvgj2FYJk8F44uMY7sTK/kVSc+LHs=;
 b=vyhllDd/mR12w48Wltew3SJbCyJ8YzGbn9/h5YqNRz1aqbegB4eoXblH6+7ebZswpj9gA
 pTlmYENfQRvd2ScTYekNqTps4HnbapZkuBQBW+2GWAwsbnEPa7lT8C7ppYio3kN+EV+hAs+
 pW6aNg72FPAR0ReW9TqpyKaez6P72b4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5CFE681F24
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 14 Jan 2025 10:03:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736845398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RJdpc5af8GraPbTvgj2FYJk8F44uMY7sTK/kVSc+LHs=;
	b=B8TXNjRTj2/l1JHlEnkv8CIXar5fNcazyVZ5efRAze1srhXamsZRQ4vB8ORCI1gVjBn4Oj
	oAbdcF+LlERoyqZ/YwoxqAbeTfd5Ieyc+UB7zIEJBxphvSEC60W8PWe4XOV8Alb8auuDxR
	4lDGbqRrZr2keVHSLw/xJJ9H9jiyq9A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=QokUg2DP;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::32d as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736845398; a=rsa-sha256;
	cv=none;
	b=LHhBibuJBvPbuhfDoJOUe+SBZdw05mrtJ9PJB4iVc7QaZYApzadK6LQ8a+gprdeC0/Ok/T
	JbTe9VQcraWB8KJGojqZJ1QQdcRMmLjAZ6IrylG9JwikRDBeJGJ+KgTUj12IDB5Xo8fUrr
	LBOHrK602SKUn40E0DQ+APAY2ltxNFM=
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso37018305e9.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 14 Jan 2025 01:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736845398; x=1737450198;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJdpc5af8GraPbTvgj2FYJk8F44uMY7sTK/kVSc+LHs=;
        b=QokUg2DPh9aKOUVGs+lul0VV7tLR90EBTJ02Asq7kroGZrK4NbuhMEefvh5DjeiSaM
         06wrxkByEjzW7Xl90/INFYVNojhHgjyydkRV4GjDCjUsQzYJ9c9Eu/gxTQtdaxUgNBzn
         eNZ9QCFGP2IcCvvSidEON/RB8wFzmF8GEFgiy9XXoWYLJ5k8yg/YDBxg3K3RASYTx1Ke
         jg6Uo/Z50khnwNn9IMiB5qTFkLe4NGG4M3p0zVuiKjNrLRdJUyfzZ7U4Ewg5ddjWD5E9
         tFlrp+W3f9I7TbV6S3zQaCfK96ZPHOl7Sjhi0kwDYzxwnGHvXfVhPY/Z7LKqi3V/ZSQS
         h+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736845398; x=1737450198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJdpc5af8GraPbTvgj2FYJk8F44uMY7sTK/kVSc+LHs=;
        b=N31vQIAjt3OWdMgm8G/acqFyGgPInmgvx4sh8VPqMWFIEgfsb1ge1EdYZHDhn3Gnu1
         eFB+ia4aIBFCqbI2CLWVI41HcN8s8i2vtwYON7g3ezSKLui5ztr7o+RCsjOWXgxGSVVN
         veR+Lkw0sFvqWI7JB/dJOzAs2zM3iopsXidMXrSPfNrHFTSK62MGPEqTyXL45hux3Ykj
         +qh87VysvE6BOVjAPMPpOTsEfhdbU65m40xc0VLitVXeeOlKF2QtK2VRiGzHmewFzIWW
         e4+sxjZoMggVeBpdaq0DwDLqDWbtF1jIepxCj6dbw+4PPqMzw2lUI4sgLl92JIUER4wx
         QcNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmui6qcOEeVClq2zWreK1ja3MvsoInoJPZKzCRvzown2dzzG/EaN4GPoIebD7ZIcaZ9frSQ+aTXTrz0A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yx3qhAC5R1n2l1qgvvSUVJ3RHVsCwz5gfz7Pl7QFsmkUJKm4ik0
	pwvdPi87MPB2dxoCQY2SYEEU/7UrnDemnjogOmOBrbobx/GUJ9Ghsw93wMCrvhUlmjl9qs4jrEj
	ksRSTjZXBFT0EgMVXVNZDsXqyPIM=
X-Gm-Gg: ASbGnct7EQrRawr+6wpj4lW6IHk5MRG8eZik2LVk1hxdp4imEIX1xyVDQPLcg49otYw
	jbT+OHvPophUmu1237wsLEjammJ4vCkDoAzKH
X-Google-Smtp-Source: 
 AGHT+IE8ZeqfL/AgiOHI7JzByaRH/gCmdKgPWO5Hj9zc39/ATmbh/1nt9GKO3Q2GNRNSP3Oe53/t8se7t847Ok8yve4=
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr233515785e9.0.1736845397493; Tue, 14 Jan 2025
 01:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20250113143719.7948-3-shaw.leon@gmail.com>
 <20250114044935.26418-1-kuniyu@amazon.com>
In-Reply-To: <20250114044935.26418-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 14 Jan 2025 17:02:40 +0800
X-Gm-Features: AbW1kvbnYf6XKcEPFQ7StR4SBvDI6u3mnWVP_-_JSDczC5xWtD3eG1aBQEYey8A
Message-ID: 
 <CABAhCOQy-qw8pY+8XjHGPVz7jWZ7wqnadPXZrF-enAO0AEgXyQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 06/11] net: ipv6: Use link netns in newlink()
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
Message-ID-Hash: FN43BYEMKPQL5VNINKPUGDNSC3RIHC6J
X-Message-ID-Hash: FN43BYEMKPQL5VNINKPUGDNSC3RIHC6J
X-Mailman-Approved-At: Tue, 14 Jan 2025 13:32:59 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FN43BYEMKPQL5VNINKPUGDNSC3RIHC6J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Jan 14, 2025 at 12:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Mon, 13 Jan 2025 22:37:14 +0800
> > diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/b=
ond_netlink.c
> > index 2a6a424806aa..ac5e402c34bc 100644
> > --- a/drivers/net/bonding/bond_netlink.c
> > +++ b/drivers/net/bonding/bond_netlink.c
> > @@ -564,10 +564,12 @@ static int bond_changelink(struct net_device *bon=
d_dev, struct nlattr *tb[],
> >       return 0;
> >  }
> >
> > -static int bond_newlink(struct net *src_net, struct net_device *bond_d=
ev,
> > -                     struct nlattr *tb[], struct nlattr *data[],
> > +static int bond_newlink(struct net_device *bond_dev,
> > +                     struct rtnl_newlink_params *params,
> >                       struct netlink_ext_ack *extack)
> >  {
> > +     struct nlattr **data =3D params->data;
> > +     struct nlattr **tb =3D params->tb;
> >       int err;
> >
> >       err =3D bond_changelink(bond_dev, tb, data, extack);
>
> Note that IFLA_BOND_ACTIVE_SLAVE uses dev_net(dev) for
> __dev_get_by_index().

That's true. Bond devices have no "link-netns", and a slave
device must be in the same namespace of the main dev.

> [...]
> > diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> > index fed4fe2a4748..0c496aa1f706 100644
> > --- a/drivers/net/macvlan.c
> > +++ b/drivers/net/macvlan.c
> > @@ -1565,11 +1565,12 @@ int macvlan_common_newlink(struct net *src_net,=
 struct net_device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(macvlan_common_newlink);
> >
> > -static int macvlan_newlink(struct net *src_net, struct net_device *dev=
,
> > -                        struct nlattr *tb[], struct nlattr *data[],
> > +static int macvlan_newlink(struct net_device *dev,
> > +                        struct rtnl_newlink_params *params,
> >                          struct netlink_ext_ack *extack)
> >  {
> > -     return macvlan_common_newlink(src_net, dev, tb, data, extack);
> > +     return macvlan_common_newlink(params->net, dev, params->tb,
> > +                                   params->data, extack);
>
> Pass params as is as you did for ipvlan_link_new().
>
> Same for macvtap_newlink().

OK.

> [...]
> > diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> > index 1e1b00756be7..1e9eadc77da2 100644
> > --- a/drivers/net/netkit.c
> > +++ b/drivers/net/netkit.c
> > @@ -327,10 +327,13 @@ static int netkit_validate(struct nlattr *tb[], s=
truct nlattr *data[],
> >
> >  static struct rtnl_link_ops netkit_link_ops;
> >
> > -static int netkit_new_link(struct net *peer_net, struct net_device *de=
v,
> > -                        struct nlattr *tb[], struct nlattr *data[],
> > +static int netkit_new_link(struct net_device *dev,
> > +                        struct rtnl_newlink_params *params,
> >                          struct netlink_ext_ack *extack)
> >  {
> > +     struct nlattr **data =3D params->data;
> > +     struct net *peer_net =3D params->net;
> > +     struct nlattr **tb =3D params->tb;
>
> nit: please keep the reverse xmas tree order.
>
>
> >       struct nlattr *peer_tb[IFLA_MAX + 1], **tbp =3D tb, *attr;
>
> you can define *tbp here and initialise it later.
>
>         struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;
>
> >       enum netkit_action policy_prim =3D NETKIT_PASS;
> >       enum netkit_action policy_peer =3D NETKIT_PASS;
>
>
> [...]
> > @@ -1064,6 +1067,11 @@ static void wwan_create_default_link(struct wwan=
_device *wwandev,
> >       struct net_device *dev;
> >       struct nlmsghdr *nlh;
> >       struct sk_buff *msg;
> > +     struct rtnl_newlink_params params =3D {
> > +             .net =3D &init_net,
> > +             .tb =3D tb,
> > +             .data =3D data,
> > +     };
>
> nit: Reverse xmas tree order
>
>
> [...]
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index ec98349b9620..7ff5e96f6ba7 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -3766,6 +3766,14 @@ static int rtnl_newlink_create(struct sk_buff *s=
kb, struct ifinfomsg *ifm,
> >       struct net_device *dev;
> >       char ifname[IFNAMSIZ];
> >       int err;
> > +     struct rtnl_newlink_params params =3D {
>
> nit: Reverse xmas tree order
>
>
> > +             .net =3D net,
>
> Use sock_net(skb->sk) directly here and remove net defined above,
> which is no longer used in this function.
>
> ---8<---
>         unsigned char name_assign_type =3D NET_NAME_USER;
>         struct rtnl_newlink_params params =3D {
>                 .net =3D sock_net(skb->sk),
>                 .src_net =3D net,
>                 .link_net =3D link_net,
>                 .peer_net =3D peer_net,
>                 .tb =3D tb,
>                 .data =3D data,
>         };
>         u32 portid =3D NETLINK_CB(skb).portid;
> ---8<---
>
>
> [...]
> > @@ -1698,6 +1702,10 @@ struct net_device *gretap_fb_dev_create(struct n=
et *net, const char *name,
> >       LIST_HEAD(list_kill);
> >       struct ip_tunnel *t;
> >       int err;
> > +     struct rtnl_newlink_params params =3D {
> > +             .net =3D net,
> > +             .tb =3D tb,
> > +     };
> >
> >       memset(&tb, 0, sizeof(tb));
>
> nit: Reverse xmas tree

Will fix the style issues mentioned above in the next version.

Thanks.
