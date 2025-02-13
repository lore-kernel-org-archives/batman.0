Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6E8C0219D
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:41:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C673283FC2
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 09:41:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739436060;
 b=HjPvf7rX70S/zK54ToW1nmZwRWyaewd2HqKTfqLnHjvUMUTjGgoyN9UolnkFI5wbauLhi
 wcfFnnM70qQUmlqVSWy+xkuRh5UnUdSJmbscPFK8wBx2bbeZM+PulmyMA5BuZN3KflhXKg7
 mzedONXY3yxw+4uotSZEgF7WbZOwKqM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739436060; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
 b=XIjDGXoOqb9ese0GaD/fTSl84DJi/j9SsdjFS5sWDpxJsoSpqQLw3u2xiQX6kdLRDn7dS
 /r1Jxie0hrcG1lTRjyYnB8dsLsnoyX/xfWW4odiytwRyT8smbz4Eso73jlisW31f13WHOzM
 bCAVi3pma+rdu+C287HzJrBawpeaQ2k=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EE1C8819D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 09:36:42 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739435806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
	b=fpGdEcUiLOVdwoO0uCigxdutMjE38p30egDR9y785GVMV4HwlKU9Ws0Qct9dmw3zmrULAC
	Elg+ZctX73l1K/l60aeJRILd6DWk1eUwxnZGakHwel6MllPZymRgyk2LQwtxHlIPy/dyOT
	57huZY8WmoBXxQfLJRM+RPyHNpSRQ1s=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739435806; a=rsa-sha256;
	cv=none;
	b=ioUR0vjooX6dw03D6A2EtCTadTopT2H1mOzrinacTEGGDIPNDv/RST0SBJfPpqoLesfuYo
	ZNnefakZYH0rpldT0IpH3L09iynfuasKNPJgpM4Z775mNoBGlgHS0o4BfbgaZz9sV4wqen
	+7jyQ+1G6R1B1Pq9sVHGmhCA+3DxuOM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=DCPmZvPa;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::335 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so6361965e9.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 13 Feb 2025 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435800; x=1740040600;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
        b=DCPmZvPaqMYKvJ1DGXvSPaTYWSLD8hrPkvfRIOtwYlfl9qVRH2Hl+JQyGQ7vERiWXL
         cJ97gNMrFn56rkLEVMPPwMzTiSZOEJmMSbZnJguraFdOb645nAxfWTFXex4WRjtOtVbx
         rr6SDBatZk+2AQbrQNCwsf8TwcwJOKZYjqTr9iLg9XjEO5b4BT6+A3xyj6v2nP8LRUmN
         q/4oQK1RJi8ltHLQuIEsdVmgthLnsJdcBz6c5gQz9OVianJBPrM/7NvmI5TL5bwoGsLh
         ZkVckGnNBm7Tspi/nhWSVHIQRx93Yc1FuwulPBp9ZqwGfBl48TK8Y/1RthNAcwdKjPb7
         7qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435800; x=1740040600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
        b=SmUgLeT/IoSYmDsprvgcoh1/nhTw7M5csqZw+bATHjjPWjU00zn6aiP5mFn/l1Ju6F
         HVnm3vbrZ87bfeysKcY/kXPcWM6/lzz9qS+2CTBm+mQJ1dknC0wOs2imvls1wfSB1q/5
         pe94Jqj4budejNl6dMM3bumY4kI57LNxYD1PqKZULSJcPykIVHmltq6FQx6q2GQLrXmD
         5y5+/cFJhVeQv6C4mdsAuu5Uk0Hw8GKkh5vIFEOUIDdPZtkGYKg7UurlF3tmM+QBKbgV
         cumJTrcC4WhDRK9I/gRxC9kTjM9Pvv4pESf8jk5E6YaFjLFF6WOPLUduRHknCAo63sDI
         DC/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk4kmbwF/iYVS+0Xvx+cD4baKRMIVhhzl55A/BM9i4ikymjoD7jYz3HX5CyNk7ua4cVoslFkWqvey2Vw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz2ndHjdL5vnYBKJhIRUh1UusZDzEWkl+VDCrFFOZDfbAZkqxZM
	C4KQb7mp9mfy8xxqgYdueYV7m/QRpmopcsEwNPmiRvzhj4ZsFgJidlrSwrhZE7IduXSk7JPB3vN
	nA9GKBLRwMfnNApS8PqBPrltvuuA=
X-Gm-Gg: ASbGnctvO5nZ7xUOKk5vv6xHS2Vh/FFFKnmchvMDwjNs8WTVdgQ7ryGOf9LjaXj8uW5
	NcMKDIQzksPf2ulpJ5zLP90lfHmHmb2zu69CaD2Mp+Fa870/hQFBgPYlAQRbgrVVtsQNrJBA=
X-Google-Smtp-Source: 
 AGHT+IEezeJ/RlI8/fvqsCpwdXF55uEWmtOYc3P4zBx3ojP1z2I7SGCdQ1/EUaOR3dd1EY2OITuGZF4nnmEaOHg8QZ0=
X-Received: by 2002:a05:600c:19c8:b0:439:55fc:81a9 with SMTP id
 5b1f17b1804b1-4395816f13dmr68016965e9.7.1739435800139; Thu, 13 Feb 2025
 00:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20250210133002.883422-3-shaw.leon@gmail.com>
 <20250213065348.8507-1-kuniyu@amazon.com>
In-Reply-To: <20250213065348.8507-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:36:02 +0800
X-Gm-Features: AWEUYZncbGUNO7oNcYsuGlVcwlKbEKWZpPvVt5uCQTeloMATtiMLOZ95K2VoEX4
Message-ID: 
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
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
Message-ID-Hash: 2A7LY2RMFSCJJWFIK4TIOICKYYHBDLUC
X-Message-ID-Hash: 2A7LY2RMFSCJJWFIK4TIOICKYYHBDLUC
X-Mailman-Approved-At: Thu, 13 Feb 2025 09:40:44 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2A7LY2RMFSCJJWFIK4TIOICKYYHBDLUC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 13, 2025 at 2:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
[...]
> > diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> > index 523025106a64..0f7281e3e448 100644
> > --- a/include/linux/if_macvlan.h
> > +++ b/include/linux/if_macvlan.h
> > @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct mac=
vlan_dev *vlan,
> >
> >  extern void macvlan_common_setup(struct net_device *dev);
> >
> > -extern int macvlan_common_newlink(struct net *src_net, struct net_devi=
ce *dev,
> > -                               struct nlattr *tb[], struct nlattr *dat=
a[],
> > +struct rtnl_newlink_params;
>
> You can just include <net/rtnetlink.h> and remove it from .c
> files, then this forward declaration will be unnecessary.

OK. Was not sure if it's desirable to include include/net files from
include/linux.

>
>
> > +
> > +extern int macvlan_common_newlink(struct net_device *dev,
> > +                               struct rtnl_newlink_params *params,
> >                                 struct netlink_ext_ack *extack);
> >
> >  extern void macvlan_dellink(struct net_device *dev, struct list_head *=
head);
>
>
> [...]
> > diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> > index bc0069a8b6ea..00c086ca0c11 100644
> > --- a/include/net/rtnetlink.h
> > +++ b/include/net/rtnetlink.h
> > @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsg=
hdr *nlh)
> >               return AF_UNSPEC;
> >  }
> >
> > +/**
> > + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink=
()
>
> The '\t' after '*' should be single '\s'.
>
> Same for lines below.
>

This is copied from other structs in the same file. Should I change it?

>
> > + *
> > + *   @net: Netns of interest
> > + *   @src_net: Source netns of rtnetlink socket
> > + *   @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
> > + *   @peer_net: Peer netns
> > + *   @tb: IFLA_* attributes
> > + *   @data: IFLA_INFO_DATA attributes
> > + */
> > +struct rtnl_newlink_params {
>
> [...]
> > +/* Get effective link netns from newlink params. Generally, this is li=
nk_net
> > + * and falls back to src_net. But for compatibility, a driver may * ch=
oose to
> > + * use dev_net(dev) instead.
> > + */
> > +static inline struct net *rtnl_newlink_link_net(struct rtnl_newlink_pa=
rams *p)
> > +{
> > +     return p->link_net ? : p->src_net;
> > +}
> > +
> > +/* Get peer netns from newlink params. Fallback to link netns if peer =
netns is
> > + * not specified explicitly.
> > + */
> > +static inline struct net *rtnl_newlink_peer_net(struct rtnl_newlink_pa=
rams *p)
> > +{
> > +     return p->peer_net ? : rtnl_newlink_link_net(p);
> > +}
>
> These helpers should belong to patch 2 ?

I was trying to split API and driver changes. Can move this to
next patch if it's better.
