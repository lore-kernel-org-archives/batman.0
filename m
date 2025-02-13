Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65F2C0219D
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 08:30:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2A0568279B
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 09:30:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739435457;
 b=bVIP2yDaE22WzJFL29jBnPkaJbyMj/4CnfTScGW3a588NQOlmE2Wto1Ym1jaBgNHE0yw/
 VMBzXDX0oo7YyRZ5Ddf4FItAGm5pF12uRxoKBBvOi/p2611978XGp0XCfIOp44qo1H5r/D9
 o8AAK7SuCWT4uzJclOPA1AdmxJZ4NuA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739435457; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
 b=kWaWySmvFkldLcTTyGyCghNY5dxKb6ZqxFXBkxI552I1W0pHIFfQvotHje28RPwYC2dZR
 0phkMuATtBoEpqKWZN9jNxFQ6RMCNXaPja6c4BTzMQyjdLgOnVT8mQiRrbCRwFILD5/T2hv
 sLxc83m/qFcYVg0syfBY/JdGK83YrBc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 08B2C83B26
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 09:27:58 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739435279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
	b=oBRBmxl6rNR49f9sE7/GVBXqeGI3QbqMpM6zo1r1g+BYKQkeggks0eOEQMnsyIXKSBiKN8
	JhUvwxuggkzQU8iUdMUVvK038akZFu1enDH9uv+u7OLR8s0A1SWbrLIHduUmOxVm2ZHQ2T
	E+hHQUrYpNahhmWCuTtJJVU5aFJU1t0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739435279; a=rsa-sha256;
	cv=none;
	b=fSYWiAU1rMrjgqesiKatI5WS/YcfT9Wr/AVsl4FUCmvjohxDTi2xTofhg7zyOXdDjcOd9e
	QJp8yGwIwIX0ANZPQ5t4hR0DuK7X8JLHRh0XKiVW/dqXP14cJ/pJuCl9JBK3veWGc5XFpC
	XmO32HsEZQR48N/RTQogC3mKbjcR1OU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=ex0bzSTj;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::330 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso3636315e9.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 13 Feb 2025 00:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435278; x=1740040078;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
        b=ex0bzSTjA53WLBH3w167W1emA1eS4Na1uz3w0Kjth09QsMEhfuOILwthsSjYTIKYv1
         5ejIjeMCNmnsf3TQQmm9EN0vShlhfod9d74gCSWgFxZppKENiPf1P5C1BDuVnK6gKRkf
         i/kUrqXZ8BzAcROXApOXa/wA7YNepqg4HA/oOhaRWLYLJDRrE1Ssa2wucdQv/QK7miyj
         EjnGvgnV3aYTeSzhHxMT/0BLyJm7yCsSCAj9lMDS/nPdXYw75Gb37xUUsDXHGymycTpU
         l54bI66sBiJKALtCa4hxGkBA97+XBMkANqO5/C8GprgUW6dLTyMJJbLY012WJBgOVzX/
         n9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435278; x=1740040078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
        b=XP/qjVVZTZBk1IPWkfl5MDHLymXs+yIo8/8xtKTqSPDgxoGWGRDmltC04QSdVjGwP4
         HJ7Ezf0JyGEs1GfuoZk3AML/ORhbK7hmwRV4ndNaPl23GLVoNC3a+CevjL6FgrixKRpa
         LuppZbwtQFdWuqlc+oeAaQJnCo80vnsAdy6XhwS67+pox6505cHX65Kql/VRY3tlqvdw
         9+sFK8dS7fhiPzWwnQl66grvitI+xnwVgfC7y09pEXxhhMQH0/VSXHmq361YfyZgEw5u
         v1QFfKzIUR8VmPcfEP2iTqkhK7emgEtrZ9SObOJ7FeVhbgYdzwgjsWdKog8bM/syVwww
         gVMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX14DmCgCtd82paQjdh76d+p0BNXwFYxfH418LrVhsHmz7IrT+mvv+wwhOZAQyN/vRX75D5CJIDTtW89A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwNSx62Uy3NnM6X3nKq8Ucr0ZU+UWc2nFZtBAhNSIUI7ay6bYpG
	QESB/eS1X1nU4IZ6/XTtmL6O24x7SVqAsdrispSAOZilBlI0gTC0WrFXkG6u91hUUvBJSls51FP
	e9nbNFVa7rroVvznqDXilWV6QOzU=
X-Gm-Gg: ASbGncvYFez+R8zjhbwrew5Z6WvCxU+ahHw6vKiXz+tzyg1zl6zwC/tGcT8gUXhPh2V
	fKoe7I79tJ871ieEyZr7V28a/TVKifNxxiVg+BcgcMvKDB7db/EE/+5J0P+O2niK3i/hsU3c=
X-Google-Smtp-Source: 
 AGHT+IGZE6zJIuhM6pmlASWXo0USdC2hFnASTias2WRNOVzNleb2xd7k0p6fviBFvki3FKkZ15YNMXus/cLozeOxCp8=
X-Received: by 2002:a5d:598e:0:b0:38f:21ce:aa28 with SMTP id
 ffacd0b85a97d-38f21ceb0famr3670345f8f.36.1739435278200; Thu, 13 Feb 2025
 00:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20250210133002.883422-6-shaw.leon@gmail.com>
 <20250213062031.4547-1-kuniyu@amazon.com>
In-Reply-To: <20250213062031.4547-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:27:21 +0800
X-Gm-Features: AWEUYZkYMDLgFWGQwQihDPwSk4qrLNJu_sLyRJOyUa3GWsERW-M3HJO2WaC6w5g
Message-ID: 
 <CABAhCOSqruMoMTg_=6Apo=gvnfe1j2fptADzoi=Gb8cdJqhgVw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in
 newlink() of rtnl_link_ops
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
Message-ID-Hash: 7IV2ZYJPCVKHZN42R66GNVAUSOXYEF7U
X-Message-ID-Hash: 7IV2ZYJPCVKHZN42R66GNVAUSOXYEF7U
X-Mailman-Approved-At: Thu, 13 Feb 2025 09:30:39 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7IV2ZYJPCVKHZN42R66GNVAUSOXYEF7U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 13, 2025 at 2:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Mon, 10 Feb 2025 21:29:56 +0800
> > When link_net is set, use it as link netns instead of dev_net(). This
> > prepares for rtnetlink core to create device in target netns directly,
> > in which case the two namespaces may be different.
> >
> > Convert common ip_tunnel_newlink() to accept an extra link netns
> > argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().
>
> Why... ?  see a comment below.
>
>
> [...]
> > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > index 1fe9b13d351c..26d15f907551 100644
> > --- a/net/ipv4/ip_gre.c
> > +++ b/net/ipv4/ip_gre.c
> > @@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
> >       err =3D ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
> >       if (err < 0)
> >               return err;
> > -     return ip_tunnel_newlink(dev, tb, &p, fwmark);
> > +     return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, =
tb, &p,
>
> This is duplicate at all call sites, let's move it into
> ip_tunnel_newlink() by passing params.
>

Existing tunnels use `params->link_net ? : dev_net(dev)` for
backward compatibility. But I think we can leave the choice of netns
to future tunnel drivers because rtnl_newlink_link_net() is preferred
in general.

>
> > +                              fwmark);
> >  }
> >
> >  static int erspan_newlink(struct net_device *dev,
> >
> >
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 09b73acf037a..618a50d5c0c2 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *ne=
t_list, unsigned int id,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
> >
> > -int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
> > -                   struct ip_tunnel_parm_kern *p, __u32 fwmark)
> > +int ip_tunnel_newlink(struct net *net, struct net_device *dev,
> > +                   struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
> > +                   __u32 fwmark)
> >  {
> >       struct ip_tunnel *nt;
> > -     struct net *net =3D dev_net(dev);
> >       struct ip_tunnel_net *itn;
> >       int mtu;
> >       int err;
> > @@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
> >       }
> >
> >       tunnel->dev =3D dev;
> > -     tunnel->net =3D dev_net(dev);
> > +     if (!tunnel->net)
> > +             tunnel->net =3D dev_net(dev);
>
> Isn't tunnel->net always non-NULL ?
>
> ip_tunnel_newlink
> -> netdev_priv(dev)->net =3D net
> -> register_netdevice(dev)
>   -> dev->netdev_ops->ndo_init(dev)
>     -> ip_tunnel_init(dev)
>       -> netdev_priv(dev)->net =3D dev_net(dev)

Didn't find a path that can leave tunnel->net to NULL either.
I think we can remove this.

Thanks.
