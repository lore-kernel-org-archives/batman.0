Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B158EC021A0
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 10:08:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3AC12841D8
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 11:08:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739441325;
 b=qIu24HjDWIHn4t2XRdpso3R7xyCbiTdswmpmApCv/tH4MzZ7oGRLF+Oe1B2TsWA/VCNcg
 NhzfIeE7y9ZjIpJYXpeKfBES6lTK4ABmilC/z92dErmohRvPF7kh0AfoV6ilbgIAAWzfwUF
 Z9bT389V84bw6Ylg3LOaKTZXipkB/mI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739441325; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
 b=Z687+SdaJAn+eDEDpy6p7o494QYPs7f+iBWQTC6eikbtjw4mShn574tTu/6EE1UZYwTe/
 VtwzP0wBRe02WOwL36h8Tf9fr5VlIbT8ACLlyh78aIyfwxsCVz5CstMRFO5zDDONgNXB0/S
 nlJT/jqu0XBrPjnH1+uNovyaxF7JhQ8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3816382714
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 10:56:10 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739440570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
	b=P3sN29GwIVCWjOHpgWhbwBc27ixyQKJayjGDT76Wmoutt8a99ImwhHqjUUpG0H1PmIPuzZ
	SkAT4lRfyRRA/nd/sQ5sFh8wssvLxFCVXYuW69aozVhiTZQTMCaHqBZB9SsV4z6TNwSexN
	bt1cavoiYem+Z3+OLZ4HDbDJBSZy4C0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739440570; a=rsa-sha256;
	cv=none;
	b=d3I+UqKJtSwOlI7WhvoL0ua7caH8YD46C2Q5kOicj2KqFnisl/AAYXEQWQeQqN2bHKyYCp
	dvTpMcucmnPXgXqthF6KAFrNqKNQ/2f5xBj/OrnxwSo6hMln7bYnSqC59NSp1kMDKy76Gu
	wjmO8d6z1Yhot2va3pNOGzKurEaMOrE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Dic16Ges;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::32f as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4395a06cf43so3983905e9.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 13 Feb 2025 01:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440570; x=1740045370;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
        b=Dic16Geshh7FtiqjbdR/oTPaiCib2WTa/BIsptjkE+N+Kel8uhqZJeubvZT15ogW9D
         S+7rPV+VCm1q/YuG8gnqmQ9n0d8CPQ45pSJxBT1vk4jPwDMhnLb2FjUCbktoPZhKMBCx
         HxfFMePE7giema9t1ERyFS/UfFW0KnQjMHakLJi6nXmRltqmjEjrlazKjJnlDr3YxSlI
         ZtBgdyaQSF5E6bN6CYzkQZJacCdtBZTBocprCjiUwKg/rZX1gtJufK2aADhVEbfGcsBj
         ghh6m83P0/NFiadOq/WdyP/pt7nSlZ32aTY0w29ajJeJyg8j9vgtUeZRDJ2HUuIf0yGM
         OYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440570; x=1740045370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
        b=hKJbGwqvs170qLbv6hpna5ilvvXbveZNWm/q+g+8vtg+Yvohf/CtbK5NYDyZ1rT3wR
         hZOyehAMD0MrfYJU1mxAkNaceYBgAhq9so/Zm2i2OjyWA00T9whbchKeGYm9kKW+isuv
         5Jh0xBi/4wAh3UtdpF2bLtETBQkWATqdr5TCla+x87LNZ5FgGfOjXBgbxGtb2OEkgi70
         ZwOGw1mvDuw5nmJqakjkBJia30B1l9pX3weWCso181I0fJNaydHtrKXWhhGDZH4rQvER
         lPINeyHotc7xEbe4OT5zlKb7exxeuKaZpyRSBHGh6B3UoIiv5kTZfcbVA3VQaNfh9E96
         oNBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW62SU0fot9J2fStuZMqAeDrNu0ODnbmjfWMi/hhoCDbsBOkHgtyqN6odrsb4HHt2BR0OFRZDAwgSrmxQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yzhjp3QmYgS4JyPnZAGNm/SEbs1cLs06L+ImhBvZ1jiq0wHXb8k
	fTwi1oChga8d2pVGU17ztrAf29VG6UDMmUGrXnjyWaQNdD8Gzq0Bwcauq1hv+b2qYSrjiu7qcF7
	EOKolyOziOExui29gyodCz3b3F2I=
X-Gm-Gg: ASbGncsn5RsIiXQUDW8jCXf5wgqlIm0X/MwgK/ycMh4/VTtF+QOx/B14lv9gQN8iwkE
	gzTaiQYrVgONNhvZop8a0uB+o8U0k9BKC/9Zqi0mPA3Q5EVAjFXgy8QfqEyTRi6ZqPyRylk0=
X-Google-Smtp-Source: 
 AGHT+IF4vz9ZMNWiLlURtMBrw7f64+VQaaApf4FQsQ85yq8rGSoIhlhaKmw+1l1LVh0uOeuQn3pwG9KU0hl60Rc/heo=
X-Received: by 2002:a5d:5889:0:b0:38f:24f9:8bac with SMTP id
 ffacd0b85a97d-38f24f9912fmr1885857f8f.23.1739440569419; Thu, 13 Feb 2025
 01:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20250210133002.883422-7-shaw.leon@gmail.com>
 <20250213070533.9926-1-kuniyu@amazon.com>
 <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
In-Reply-To: 
 <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 17:55:32 +0800
X-Gm-Features: AWEUYZkW9l6r7KSPGBGbQx_PCRCw6eQRHHUgG_KYRCauok2SpPFULcU0b728Vqw
Message-ID: 
 <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
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
Message-ID-Hash: YLX7FALWKK4J5QORUJIDOCE6SBI67BVH
X-Message-ID-Hash: YLX7FALWKK4J5QORUJIDOCE6SBI67BVH
X-Mailman-Approved-At: Thu, 13 Feb 2025 11:08:28 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YLX7FALWKK4J5QORUJIDOCE6SBI67BVH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 13, 2025 at 4:37=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> wr=
ote:
>
> On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> [...]
> > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > index 863852abe8ea..108600dc716f 100644
> > > --- a/net/ipv6/ip6_gre.c
> > > +++ b/net/ipv6/ip6_gre.c
> > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net=
_device *dev)
> > >       tunnel =3D netdev_priv(dev);
> > >
> > >       tunnel->dev =3D dev;
> > > -     tunnel->net =3D dev_net(dev);
> > > +     if (!tunnel->net)
> > > +             tunnel->net =3D dev_net(dev);
> >
> > Same question as patch 5 for here and other parts.
> > Do we need this check and assignment ?
> >
> > ip6gre_newlink_common
> > -> nt->net =3D dev_net(dev)
> > -> register_netdevice
> >   -> ndo_init / ip6gre_tunnel_init()
> >     -> ip6gre_tunnel_init_common
> >       -> tunnel->net =3D dev_net(dev)
>
> Will remove this line.

However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
tunnel->net =3D=3D NULL here. Take ip6_tunnel for example:

ip6_tnl_init_net()
    -> ip6_fb_tnl_dev_init()
    -> register_netdev()
        -> register_netdevice()
            -> ip6_tnl_dev_init()

This code path (including ip6_fb_tnl_dev_init()) doesn't set
tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.
