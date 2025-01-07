Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFDFE77197
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 12:32:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CE1448409C
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 13:32:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736253158;
 b=anQ2TdrywQnUgdPIDE/jDKBGR/g9dZlLHi0dr+T6lBRdEofrIpMt5SAsrRg3iKcl6NuLj
 Hx3l0NV8DBj3oT/gY2wfb3hcLRCSu7/9+sjAn57kWAzNmL1gKmN+bYm4od1JTi85uLuklZ1
 3dhDciD7TE0pd6BeNKLSQEmIaCxh4V4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736253158; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
 b=xIuJoefBRTMDtCbXfcD/FJTU0x75i6WyD0cfbjgWEk+OJNzaBuwtKWkrLoWHhj1WmxSJS
 vpTBqicuv/CYsZ1u3k44h6UGqR90yIHqnSsZzZEiDwKQF0shXGEJwizdWbq7l5M5WrhUzHV
 0oO0hHaOdPC9y9/p/tWzAwrDeGs7xBI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 654E38181D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 11:47:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736246836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
	b=K7JCaBSuK0NINRD9pfaKUMb3TJjmGbsa3MiQeJoxfP/l2go/64iog5VSYI3hbmbctwECos
	2oEIS1awl35LWbk7OLzhplOx0lAJH+0r66MHZ92GZRM6eSad1PhRfSGntQaPq0nz1VPhpU
	IQZ6oh6YqtQ+BzQr9pVdEsqarY8FPvE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=agh9OYss;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::333 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736246836; a=rsa-sha256;
	cv=none;
	b=p4u3QEgJlwTcbP59bOcjMBlCEx6LBdCE23sYoKIw2sDTOHicspmM0JpDEKKodTnPGsrGx/
	C8FShqiqqYZRvGpt7Bm3kRlJnfy4axSXuSe7rax223tl+Lvbv35rFpbw1KniQxk5f+pf8w
	E7i4JONcS75qWJO4ZUHIC4XcVsgm1hU=
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so109838415e9.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 07 Jan 2025 02:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736246836; x=1736851636;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
        b=agh9OYssAdgX5G0lONZNJWB0Esf39xpYdhwDzWSRfda71RoJ3Q2SOVfgqWMDW00yOc
         52TjPW8BWjl/g2ShJVsmbULElBPfgqsMaAfbcP1DbI94H0fck6O0hvOvtybO+TdBxRKD
         aXkZgUbSCILG4ezYkfyKx3OrRHoy5FfYssC+kA7zPZFsOO/F/t7g6Ci45BxTWtV7epRO
         ReKI1cOUr7yrjOkC/vF5zo41GzBQhCuMRenIxmAsZIPLcqg4WOIKC1IxnZpBlKYFG2qR
         tfasI++u6DmOS1GAIK+3lCU5pfdJg9U09Hf13RkNHzggxJpY79ptkDv6meG51SRPzNVm
         jsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736246836; x=1736851636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
        b=bSZW2DYLymk+ONwqzE+Je4OiKkOAAlOMpENOZyCqGsHULDGkzRZAyLveva5MISm/qf
         JAze7x3T3Cluu7/WSz85T+u1GgllIqq12X54qonQc8GIZV8Spfm/6ZHtwx/YK7Qi5K+O
         Ph2xnBQU6J4d0wOdZTnCIgaCJmK0iPLnN5+MGL+Qozf6avGOof4b8sE1BfoZ+CkrC/qd
         VE9fdPa13wUlemsdlSbAq4oynnJVrj1w6I7NoS5RGbI8hDExtQIlKj6ogj1v7g0OLY9a
         J5Q4zCTfckJbJh+1JYTIm7eqsjUyI4IpIPH4WtC+pR87+GHE2iC58X1reAYu/sp8Ml/t
         8DCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVb+RKsbARvLuWBfJB4bYJCOgnBijHM3U7d1byD0bcO2pHKhz2fODbQsLGxMPo39rPMvS00qET0R996A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Ywa9iKlr1ihzgjnwxnGhXRLICOcgfX+VJICbvCAu4hi1PRFFk1I
	9DBZnjiXnbmB2PNR2z5d2/sSoungPmnsaNOKtnWEl8pYvb4FlRlI1AgBN/Ho5L7FtNCBWyKErM1
	YlOuLXRd2BAiryghsIbdy4Wthzlw=
X-Gm-Gg: ASbGnctenuf66fY5vhmcBSRWdlA4f4CTiQFBIDODwcJVbeMD+c4o+wzLKWnAPhlyT6w
	N/a/e19L7/YMyi3rkPaZ0s2udMmn46PrIqIu2
X-Google-Smtp-Source: 
 AGHT+IHp1K2L48YKiIQv0pwnQlZPYX8cMCBbRBU/fwg+IEmnnlA8QF5/odQWLMrNcSpCZK0F/LO3cHqTWVNEZ39orXM=
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38a221fa8c6mr57843141f8f.33.1736246835555; Tue, 07 Jan 2025
 02:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com>
 <20250107085646.42302-1-kuniyu@amazon.com>
In-Reply-To: <20250107085646.42302-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 18:46:38 +0800
Message-ID: 
 <CABAhCOQAqspiaFO-486UtZpEWsua51f+1f6-LocNhHVfAqW=NQ@mail.gmail.com>
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
Message-ID-Hash: 4ZPU37TID4HPDHRMCMINPGCRYJ5GW7CT
X-Message-ID-Hash: 4ZPU37TID4HPDHRMCMINPGCRYJ5GW7CT
X-Mailman-Approved-At: Tue, 07 Jan 2025 13:32:20 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4ZPU37TID4HPDHRMCMINPGCRYJ5GW7CT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Jan 7, 2025 at 4:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Sat,  4 Jan 2025 20:57:21 +0800
[...]
> > - In amt_newlink() drivers/net/amt.c:
> >
> >     amt->net =3D net;
> >     ...
> >     amt->stream_dev =3D dev_get_by_index(net, ...
> >
> >   Uses net, but amt_lookup_upper_dev() only searches in dev_net.
> >   So the AMT device may not be properly deleted if it's in a different
> >   netns from lower dev.
>
> I think you are right, and the upper device will be leaked
> and UAF will happen.
>
> amt must manage a list linked to a lower dev.
>
> Given no one has reported the issue, another option would be
> drop cross netns support in a short period.

Yes. I also noticed AMT sets dev->netns_local to prevent netns
change. Probably it also assumes the same netns during creation.

[...]
> >
> > - In gtp_newlink() in drivers/net/gtp.c:
> >
> >     gtp->net =3D src_net;
> >     ...
> >     gn =3D net_generic(dev_net(dev), gtp_net_id);
> >     list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> >
> >   Uses src_net, but priv is linked to list in dev_net. So it may not be
> >   properly deleted on removal of link netns.
>
> The device is linked to a list in the same netns, so the
> device will not be leaked.  See gtp_net_exit_batch_rtnl().
>
> Rather, the problem is the udp tunnel socket netns could be
> freed earlier than the dev netns.

Yes, you're right. Actually I mean the netns of the socket by "link netns"
(there's some clarification about this in patch 02).

[...]
> >
> > - In pfcp_newlink() in drivers/net/pfcp.c:
> >
> >     pfcp->net =3D net;
> >     ...
> >     pn =3D net_generic(dev_net(dev), pfcp_net_id);
> >     list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
> >
> >   Same as above.
>
> I haven't tested pfcp but it seems to have the same problem.
>
> I'll post patches for gtp and pfcp.
>

It would be nice.

>
> >
> > - In lowpan_newlink() in net/ieee802154/6lowpan/core.c:
> >
> >     wdev =3D dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK])=
);
> >
> >   Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
> >   in link netns.
>
> I guess you mean the ifindex is defined in src_net instead.
> Not sure if it's too late to change the behaviour.

Yes, it's source net for lowpan. I think it depends on whether
the interpretation of IFLA_LINK should be considered as part API
provided by rtnetlink core, or something customizable by driver.
In the former case, this can be considered as a bug.

Thanks.
