Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A2C02198
	for <batman@archiver.kernel.org>; Fri, 14 Feb 2025 09:33:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF0CC8422A
	for <batman@archiver.kernel.org>; Fri, 14 Feb 2025 10:33:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739525633;
 b=m2eeyETSXbQJHKFHHho81iQEg8m2iTWPO56gApNqdajtSWpKgP6xj0yiDIctIP2MWciIM
 D+fH/LNL9u77ueEqxS4jl8PZ1V8hrCMkSXm4K67NHGkSrTX6TOzGQDjk9BwLsInOQfeuqcB
 THAmx+u4Yz5y3wuKRMZxo+KgV4twuT8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739525633; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
 b=cAXJbV9+PEf/zNIFb6/ODSheDDZs9VhfyGGRY+DHbJPrq+mLYPvXp1kWWzDqUKLSNgX0z
 uo8frHBBG4XJG65oZdrDUut73PFIL1uqxmZ2U8+D/1qzwQdwbkuDsvjuFVBgj5RKM5ocydB
 2gwK6n80kzm/J1jx4ajk3HKNvLbZwsM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C7BFE81888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 14 Feb 2025 10:23:06 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739524986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
	b=RyklVl8pUnb3AAl81otK7AalCM3bfiACDguzu1AAE5ymxtOpGpnGeXaezXkuoNaPYalrMo
	z/uFWbfGFat+eoSnqCLG0/Vh7C+UUL7k9SGvG4Fog06z7hSHri70unwyr8TVUtm5KMdeYq
	31qnIa2n4YJMYec5niwXlg8Ptvh23iY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739524986; a=rsa-sha256;
	cv=none;
	b=xP4yUnQWkuBaSQ3IXcK5p88o1Wg8oDpCcSkyXly71UaZCmo7Fc5TbkEcT1FSF2fAvlQHR0
	f34Ma3JfmspzzxZfCDO25z2gNG/ykDCPSIhvMNj7JNKZzimq1fPGYhX6EwRN5NB7yKxuR6
	DvwnKq94G7l+0BDbInJe+07B3PT0kkA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=kE0naCfV;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::42e as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so664765f8f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 14 Feb 2025 01:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524986; x=1740129786;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
        b=kE0naCfVtkgQdUB4mJ4K2x3M9McrrFk3IHbPKyHKCr59RnO32W0uggH3UkaW0bLYwY
         X0obMxt/MYD2ne7DQvdGd0+UPOgdfQJHr64XGC6s4GQMGyIdDJS03+GybUIv4klMxe9l
         V3oxlAgl1EkhUDroWcfjgC1nshQgHHhvhCMALj91aXBRLk/ft3h5B37XylyO2DNURNHr
         s4S7YVTLwOeMcy4ajVCjR5C+ZvVj3D0X+cMnSlb+Ud6aA+rSQimlQ6CMwCsGntKXwV7k
         5ba6XEcNkc7KSyiR4PyCSJDjEbIIv3uNM5AuLhhTuD9lUFkMdtv+6U8SdSoVLUgQvOA5
         7teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524986; x=1740129786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
        b=Y97ReIpIQIV30B3W9DQCfR7x+83ZZ5Fd/zYO13hT+8WvKFzb9b+GTjIEIKNM7Ya6ND
         TTvtJJjzxcC2gTjwLZYTQlF+VZunrpaghXBnmpCMCQtwogCGao8ggV1VvylJVxRSoMks
         /w0jOY1PFfp8UkSQGtY/IjJ1UyWqxwYu7Gmcm+vXlrpcwxngMMV9fuLlrjBuviJlHzTo
         hGuYrfVUS1CBS1mLMlGeHWfdnO517TOLE6hw4FCru6AQ+kLXd+hNaARI1+XVXXMvVosH
         RGzN6QwWdgJUpiPBA2uU35fQIp9nYmyWnTLWZCDhbruAUUADcSf6+m4yB5I8XgoFK/Jz
         tRHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXov0r1Qch2L9VcGz03lr8J138erYwERVaadm7DxiL8QL858IaOo85477/upb9lCgE0AJMk66UuDjCQXw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwJ1x2zWJCzyWVX5/RP38rEbQQ2OOP9O9X1UGvwjvIfLGbXa5oo
	URsL2mJk0neGPkshZANtJyeK04PAkvvy21hoHgGYO6pOHQ8pIgf+zCRj2uC5qD/Q2CqhpkBw21v
	9pac7b0T8rkr+W7qBJCGOmhDPUyk=
X-Gm-Gg: ASbGncvFBPmHDLXkUuIVgukYPSWjXpAEukwxcdzsom7v/a2fLQ3OZez8KKmFJE5TtUV
	k3+sDYSROXUDDsNWCh+fBF0FSBzWwqCXXQqTGelUREbQSg5htEdI4WsVWAPgq/mr1TyoIN/U=
X-Google-Smtp-Source: 
 AGHT+IFc4q5LtCR4oH56B/JnsUWjOnr2P8qnhLaQaAQF/xsTMWgc84lPizP0lboCQWCd1BP4FsSRkQxEWx0I5MF+EcM=
X-Received: by 2002:a05:6000:18ae:b0:38f:23bc:c19e with SMTP id
 ffacd0b85a97d-38f23bcc233mr9719529f8f.29.1739524985787; Fri, 14 Feb 2025
 01:23:05 -0800 (PST)
MIME-Version: 1.0
References: 
 <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
 <20250213110004.38415-1-kuniyu@amazon.com>
In-Reply-To: <20250213110004.38415-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 14 Feb 2025 17:22:28 +0800
X-Gm-Features: AWEUYZmC-_4d4WbO4zj0CDnf9myDuv_5df2UqBnW8RiGwAq7tiZ7QonxxL4s5P4
Message-ID: 
 <CABAhCOSsZqzrsqct+c613TVhGJdubv+_wTDxmjH8z6-PL1Mu2A@mail.gmail.com>
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
Message-ID-Hash: HSFJTGHJTVVW4QH4QVTNWI3OVDLEENXI
X-Message-ID-Hash: HSFJTGHJTVVW4QH4QVTNWI3OVDLEENXI
X-Mailman-Approved-At: Fri, 14 Feb 2025 10:33:34 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HSFJTGHJTVVW4QH4QVTNWI3OVDLEENXI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 13, 2025 at 7:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Thu, 13 Feb 2025 17:55:32 +0800
> > On Thu, Feb 13, 2025 at 4:37=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com=
> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >
> > > [...]
> > > > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > > > index 863852abe8ea..108600dc716f 100644
> > > > > --- a/net/ipv6/ip6_gre.c
> > > > > +++ b/net/ipv6/ip6_gre.c
> > > > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct=
 net_device *dev)
> > > > >       tunnel =3D netdev_priv(dev);
> > > > >
> > > > >       tunnel->dev =3D dev;
> > > > > -     tunnel->net =3D dev_net(dev);
> > > > > +     if (!tunnel->net)
> > > > > +             tunnel->net =3D dev_net(dev);
> > > >
> > > > Same question as patch 5 for here and other parts.
> > > > Do we need this check and assignment ?
> > > >
> > > > ip6gre_newlink_common
> > > > -> nt->net =3D dev_net(dev)
> > > > -> register_netdevice
> > > >   -> ndo_init / ip6gre_tunnel_init()
> > > >     -> ip6gre_tunnel_init_common
> > > >       -> tunnel->net =3D dev_net(dev)
> > >
> > > Will remove this line.
> >
> > However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
> > tunnel->net =3D=3D NULL here. Take ip6_tunnel for example:
> >
> > ip6_tnl_init_net()
> >     -> ip6_fb_tnl_dev_init()
> >     -> register_netdev()
> >         -> register_netdevice()
> >             -> ip6_tnl_dev_init()
> >
> > This code path (including ip6_fb_tnl_dev_init()) doesn't set
> > tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.
>
> Ah, okay.  Then, let's set net in a single place, which would
> be better than spreading net assignment and adding null check
> in ->ndo_init(), and maybe apply the same to IPv4 tunnels ?

Tunnels are created in three ways: a) rtnetlink newlink,
b) ioctl SIOCADDTUNNEL and c) during per netns init (fb).
The code paths don't have much in common, and refactoring
to set net in a single place is somewhat beyond the scope
of this series. But for now I think we could put a general rule:
net should be set prior to register_netdevice().

For IPv4 tunnels, tunnel->net of a) is set in ip_tunnel_newlink().
b) and c) are set in __ip_tunnel_create():
ip_tunnel_init_net() -> __ip_tunnel_create()
ip_tunnel_ctl() -> ip_tunnel_create() -> __ip_tunnel_create()
So net has already been initialized when register_netdevice()
is called.

But it varies for IPv6 tunnels. Some set net for a) or c) while
some don't. This patch has "fixed" for a). As for c) we can
adopt the way of ip6_gre - setting net in *_fb_tunnel_init(),
then remove the check in ndo_init().

Is it reasonable?

Thanks.
