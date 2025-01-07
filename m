Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C06E77197
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 15:11:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96505840EB
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 16:11:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736262692;
 b=NYLH0hyGSJStGjKWzs9ibQk3Ew8vqGWpKVqrfCQsAw2NT8yysBzRQIV0ykkcRyUsHMWN7
 Jo5Q6XE10SvB2hoFdAnUL5tqN+A5MF24PlSWTJOHTqZDqop3TNovU7XTyYzEvredlz9QjaM
 pgcjH5UcbH1OhUXGsuZSr/o1pUbkRbg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736262692; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
 b=gYav4qCqqiC2m0c/oIzdJY9cs+Bq5j+AX9pyjUWy+GU0TcF99X/nkYoos3anALB3gH3Zx
 YjiVLhy9DFik59rKbIWluuvLOXrv5glgd9koEngTF3NAZAFDzWbYtsILtxJNqzD2OgRXhcK
 SB+ScpihbIkyMu8aUnhI+K3XVRNGsP4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8B73481721
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 13:53:57 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736254437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
	b=bJ965bBXcQqTYSF30TdR5IRo+ZRDXL0At+ERwqUcrUgA0mtFN2ZTvC1MyuGGXHyQqzYBhz
	vp5rrg2vQl39+Jsrcqbi5ovFsKhcEn9wFIh6O9ojPH8xvgLHA+6ieMxlyqjc7or4AlktqJ
	r3leoq6BwEdsITx4naAsPxjmsENERuM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=dUeEEqp0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::333 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736254437; a=rsa-sha256;
	cv=none;
	b=cfmLckH7iFZSN3OxxoIGNF2AQlbHTYJRj6Q4Lc8hTr5GhzJ1Yo0JtdQkb9vknlrRS34V5q
	bPd4H9tZNYvrLVrahGYTAG2luD9TeiMe8FFkzcR+SK2jnaWtWeDrLicMTB4Z25Xf8eCRyE
	aqKXLXkSiRgmrznszCcroGDn33k+Cc0=
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd730so110878845e9.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 07 Jan 2025 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736254437; x=1736859237;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
        b=dUeEEqp08NLmcrHxBdPpkQe1xj8uRbWxOwvi+6Cr4zNH8aqmkZ3gdn4bOu7s+5etdA
         2hp+EptG5VYDSPtj9R4NLgbI/Yx+8JQIdAytWZeMo7au0Rktb6vjb4S4vbFkOU6dnLWG
         9ofm5YgmL9QxSiDyiAgkQpw9jPlKrTHnzQy2r+KCaGHr6nZ0x3XS04IRZnfstHcJA0RS
         KJTr8EujBMcmTtHRCNREu98X/C42iHuV1E5TK6asDGyDzA7D1cDUEwdGbGkXVn+OKBAy
         fp2Sm0WR3eS/XUq/eQpRe0+AueYJi8V+tdZBTBCSpzstIY5PX1JG4hL5zc0QPm2sI+fe
         SoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254437; x=1736859237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
        b=F2oOaOUpv/vp2W12kAzz0CL8zk6k28YIeln0cd7YmLOLLNN417vojPCNQKZhuEAX82
         53UGc1xfrfSndlzVO1sOCy6H/MR5qeBxcfuGVTYQ+nWNBs0iQ/BGYlCUNpxnA0xDs6gb
         K+0TsQ73NydecC2VIsF9v44iJtw5dtZhAp/xOcG84nc56pB/9F36+T99sX0ui5AEhtUR
         0jpeyN4FMZrD6aoBrUqo9FTnhHBGzorhuBbBEDslcLxHsWBTfwb1ebWnHGyuLiF9MHgj
         W0ggwOJVGL79HCfZu2EJUu1k6yz9gFpV3J3HVeWpFpfrmhCBKK5f0H2x/G4ZRx5SGjvg
         ANYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSjjIB7g20nWTc4m6FCziYIQt1wg7GJR5/WjAEdxnrOOfoqbVTCOikf8q4rT8z89tKnDzdL+QtKJ4SFA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yy0Wng1aV54NkVK0xsj37Api++FkFhvtNOn/BnEOjfZhfXa2aou
	PB/A83tTKuyrVO56Rjff7CcsMa8aJO46s4NqtSPjODTDSPQwrsFIQOtRPoIRnZ7+HfFPtdyEYDE
	IXhuXF1yI78oocRKiXb+fh9NXBFE=
X-Gm-Gg: ASbGncvd/BZyEjRYwOXZJgHKXMlpFHtOzVV041l8RLM+19eroNjCgk/HKgtue74agrE
	i2/2zAPXpRkQCQhpMrv7EDd//FkZ0NGENxqjF
X-Google-Smtp-Source: 
 AGHT+IHLmQYT6Nfe/TxqetejkNmjRWULhNkXti9Y+FoSO0oNz6JKWmwppacRVdUE20hj8uvdZwuWTQu822tlGBPGUFc=
X-Received: by 2002:adf:a15d:0:b0:38a:615c:8222 with SMTP id
 ffacd0b85a97d-38a615c828emr14509037f8f.4.1736254436561; Tue, 07 Jan 2025
 04:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com>
 <20250107085646.42302-1-kuniyu@amazon.com>
In-Reply-To: <20250107085646.42302-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 20:53:19 +0800
Message-ID: 
 <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in
 rtnetlink
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org,
	bpf@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
	donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, kuba@kernel.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-wpan@vger.kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org,
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
Message-ID-Hash: 66NFHEEEMZF6PZSO77LPYCCSDOK2GVYW
X-Message-ID-Hash: 66NFHEEEMZF6PZSO77LPYCCSDOK2GVYW
X-Mailman-Approved-At: Tue, 07 Jan 2025 16:11:15 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/66NFHEEEMZF6PZSO77LPYCCSDOK2GVYW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Jan 7, 2025 at 4:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
[...]
>
> We can fix this by linking the dev to the socket's netns and
> clean them up in __net_exit hook as done in bareudp and geneve.
>
> ---8<---
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 89a996ad8cd0..77638a815873 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -70,6 +70,7 @@ struct pdp_ctx {
>  /* One instance of the GTP device. */
>  struct gtp_dev {
>         struct list_head        list;
> +       struct list_head        sock_list;
>
>         struct sock             *sk0;
>         struct sock             *sk1u;
> @@ -102,6 +103,7 @@ static unsigned int gtp_net_id __read_mostly;
>
>  struct gtp_net {
>         struct list_head gtp_dev_list;
> +       struct list_head gtp_sock_list;

After a closer look at the GTP driver, I'm confused about
the gtp_dev_list here. GTP device is linked to this list at
creation time, but netns can be changed afterwards.
The list is used in gtp_net_exit_batch_rtnl(), but to my
understanding net devices can already be deleted in
default_device_exit_batch() by default.
And I wonder if the use in gtp_genl_dump_pdp() can be
replaced by something like for_each_netdev_rcu().


>  };
>
>  static u32 gtp_h_initval;
> @@ -1526,6 +1528,10 @@ static int gtp_newlink(struct net *src_net, struct=
 net_device *dev,
>
>         gn =3D net_generic(dev_net(dev), gtp_net_id);
>         list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> +
> +       gn =3D net_generic(src_net, gtp_net_id);
> +       list_add(&gtp->sock_list, &gn->gtp_sock_list);
> +
>         dev->priv_destructor =3D gtp_destructor;
>
>         netdev_dbg(dev, "registered new GTP interface\n");
> @@ -1552,6 +1558,7 @@ static void gtp_dellink(struct net_device *dev, str=
uct list_head *head)
>                         pdp_context_delete(pctx);
>
>         list_del_rcu(&gtp->list);
> +       list_del(&gtp->sock_list);
>         unregister_netdevice_queue(dev, head);
>  }
>
> @@ -2465,6 +2472,8 @@ static int __net_init gtp_net_init(struct net *net)
>         struct gtp_net *gn =3D net_generic(net, gtp_net_id);
>
>         INIT_LIST_HEAD(&gn->gtp_dev_list);
> +       INIT_LIST_HEAD(&gn->gtp_sock_list);
> +
>         return 0;
>  }
>
> @@ -2475,9 +2484,12 @@ static void __net_exit gtp_net_exit_batch_rtnl(str=
uct list_head *net_list,
>
>         list_for_each_entry(net, net_list, exit_list) {
>                 struct gtp_net *gn =3D net_generic(net, gtp_net_id);
> -               struct gtp_dev *gtp;
> +               struct gtp_dev *gtp, *next;
> +
> +               list_for_each_entry_safe(gtp, next, &gn->gtp_dev_list, li=
st)
> +                       gtp_dellink(gtp->dev, dev_to_kill);
>
> -               list_for_each_entry(gtp, &gn->gtp_dev_list, list)
> +               list_for_each_entry_safe(gtp, next, &gn->gtp_sock_list, s=
ock_list)
>                         gtp_dellink(gtp->dev, dev_to_kill);
>         }
>  }
> ---8<---
