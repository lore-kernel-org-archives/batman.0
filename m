Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD59C0219D
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 10:09:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D6F3842EE
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 11:09:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739441368;
 b=rg6o4JYTwlV3Ep/ETrEHPmqio7LBub9Sxylq4s+FALFj5iU4AzaMLEpDwiYoHAfcghj+I
 1BcxMUkZ+NnGnodQGzy0RcRXbmOsdg7/3kuehte0Zskde+k7BZughGkN51Nz3DoZ1S9RfY8
 5l+PIVEDtE1l2rv80Qbn0J1ihNThVFU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739441368; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
 b=IgmKU6hPr3SVy2ZnodxcvrNA7xYs/dHVRfWvAAhkqf4pjgZCwKJz5BmSrGSAfFwHzpjWq
 VHFYfaic7QNWh3YmWTf0xuVxHDZ+CCrN+7N9SSHLR1VNm3jq8YAAmKav7HBDODd/CU04lee
 aZCNtA8W/2kWfBlyGrkylddyBH3aIME=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2A48883EFE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 11:01:38 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739440898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
	b=Kloj5/675fgNaSpHSGyx1bespIYehZ8z4nxZZfmD3L4ZEpRpzm68u9gZJKVS4aUzgsyj4o
	YGb/bOujyTXPN7AMhuu92kHmv/Lvl/PGym+/3zqL2WiRmJFWJin2lzBm6kcNQpien6zfmt
	TvTiawPRJdZTDO/qlRqid3sLND982Pc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739440898; a=rsa-sha256;
	cv=none;
	b=qNg85ATmDftXFiC7zt7xRgVoaropNF7dyHHE4UuKZFig30tLsNpfX0t6siBmiZpFnC8KAb
	l2ld3PHrLbp1bUBrvgkqF0H+3oUpeC3pxuJhqgJEATofUipr5oJcxUNdMjs0e+YfONApUH
	dW7he8G7AKpNaj3lkcEiB0B7J3ROaSo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=e6VYtrvJ;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::32f as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43964e79314so718715e9.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 13 Feb 2025 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440897; x=1740045697;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
        b=e6VYtrvJPc3qYanUeO+xAcxUNkVrVw4HwJxjW46YzxBGcME0Ur6YNgP1wvIRXsa+/x
         rRlXWz6hhWiK1rHELPPKlEvwLnP8Kkbx/dz2UPxzLZS/jAhQZ7pcLk580fqaLsuirPxR
         6UpQcQoyVN1aQDJ+7orsPt7PlDlRKGuapifOMC0Mdp6lknMK0BJAgJNZPPva4TGqF3O/
         OKRwDB10/4/dGbBp/9NtrbK2QzKor5Y1TAv5E+zZ1a8xYTl80zcH5hM4Qi+Lg1JZF/Bq
         2HfggyQe/2mP1EarHiz6cAGOazr5MZc1N/jLK21RCqf6gVF6hK9wKM1MedPlsl7CDFZe
         S39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440897; x=1740045697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
        b=Y5EP9OhrDcjwJ0UvlT+VkjHPJQUAkYpKEENt1PmWBx2QYfPQ/AJD1SzxP0sFLrQfvf
         q5d9U/lGfLdn3jHqfiRPkc/3T305DzLNQ93e4TYKldnbQ6TRIIq9irnEttIfQQfK1KbT
         JTtOW0RBME0JwTLSawPLQYXtVLOvw9N2F/VEiIntM0DTA9ys66dT3URdun3Zp+Ep8bcS
         RwjuzEQJ17MYcUcc7K/L3iQgVT/0gO4UNotTBeiFQthiLuF1N4J5c8/IUd995lm3+xsF
         qxBAoNuAjdjoHVCEkBKSDDhGx5UmnFykVK1bBj4W/Cnmkj1oMdGnHtfaBlhg9+KUBY9V
         paIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH5m8XMqQ/+vtfX0EnywZ6xxjiB86En6eNzOLk0gWP0DPU5VdE4nDVdduu+G3eO61+y8SzQGSnHMXzUQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyd+0Qny03DqlcfHhgGdgbnynyCtBH1sz67FZbmnDNM8Ae9dg2G
	AlQRUrdsF/rcXz9L6fPeOCJNIpGD/1/iXJxQNVCulu6LCgNagipgInKzIKa5lcaRbm/UMLF1v15
	RsZmq/rnQGhDU/wL+8LD7UC/VfCU=
X-Gm-Gg: ASbGncsEJWgQY7i8F2ayX0puHV897g/XBEnXKfI1cQzwwona6V5VxRqOEtu7SgAceKq
	pBg4W/xDRctheRfnMP0cYKub1nQCuJ4EBC7rwGqNMFAwye63r/lzRC4QlghmvNOM/2bM0gXU=
X-Google-Smtp-Source: 
 AGHT+IGNZlywLnJxQSbfEuVU5lxBk1mvVT9ugQLIpGpywWHBNNSM0YY4phrOkk812RGul4zBJlRkLm/hRcXNfYkCEHg=
X-Received: by 2002:a5d:64e2:0:b0:38f:21eb:5d02 with SMTP id
 ffacd0b85a97d-38f21eb5f2dmr4477949f8f.22.1739440897336; Thu, 13 Feb 2025
 02:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20250210133002.883422-3-shaw.leon@gmail.com>
 <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
 <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
In-Reply-To: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 18:01:00 +0800
X-Gm-Features: AWEUYZkc6f7IS5VLx0dDxpZ4gB9UzsINfw32PuUeMd1tOC9C9cBZAvSRCBGNkQM
Message-ID: 
 <CABAhCOQLHgiwkydm9vQAkVYZRyrCCu=E9Nh=wwkWFXox0x5uvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alex.aring@gmail.com,
 andrew+netdev@lunn.ch,
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev,
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org,
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org,
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org,
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
Message-ID-Hash: LRQISXGMITDC5VOEZXDUMIIMXKI5ZRI7
X-Message-ID-Hash: LRQISXGMITDC5VOEZXDUMIIMXKI5ZRI7
X-Mailman-Approved-At: Thu, 13 Feb 2025 11:08:28 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LRQISXGMITDC5VOEZXDUMIIMXKI5ZRI7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Feb 13, 2025 at 5:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/13/25 9:36 AM, Xiao Liang wrote:
> > On Thu, Feb 13, 2025 at 2:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > [...]
> >>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> >>> index 523025106a64..0f7281e3e448 100644
> >>> --- a/include/linux/if_macvlan.h
> >>> +++ b/include/linux/if_macvlan.h
> >>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct m=
acvlan_dev *vlan,
> >>>
> >>>  extern void macvlan_common_setup(struct net_device *dev);
> >>>
> >>> -extern int macvlan_common_newlink(struct net *src_net, struct net_de=
vice *dev,
> >>> -                               struct nlattr *tb[], struct nlattr *d=
ata[],
> >>> +struct rtnl_newlink_params;
> >>
> >> You can just include <net/rtnetlink.h> and remove it from .c
> >> files, then this forward declaration will be unnecessary.
> >
> > OK. Was not sure if it's desirable to include include/net files from
> > include/linux.
>
> I think we are better of with the forward declaration instead of adding
> more intra header dependencies, which will slow down the build and will
> produces artifacts in the CI runs (increases of reported warning in the
> incremental build, as any warns from the included header will be
> 'propagated' to more files).
>
> >>> +extern int macvlan_common_newlink(struct net_device *dev,
> >>> +                               struct rtnl_newlink_params *params,
> >>>                                 struct netlink_ext_ack *extack);
> >>>
> >>>  extern void macvlan_dellink(struct net_device *dev, struct list_head=
 *head);
> >>
> >>
> >> [...]
> >>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> >>> index bc0069a8b6ea..00c086ca0c11 100644
> >>> --- a/include/net/rtnetlink.h
> >>> +++ b/include/net/rtnetlink.h
> >>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlm=
sghdr *nlh)
> >>>               return AF_UNSPEC;
> >>>  }
> >>>
> >>> +/**
> >>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newli=
nk()
> >>
> >> The '\t' after '*' should be single '\s'.
> >>
> >> Same for lines below.
> >
> > This is copied from other structs in the same file. Should I change it?
>
> https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/mai=
ntainer-netdev.rst#L376
>
> In this series, just use the good formatting for the new code.

Got it. Thanks.

>
> Thanks,
>
> Paolo
>
