Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E3E77199
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 08:47:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 63E49841CC
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 09:47:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736326055;
 b=imBWTfiH+3TBl0Oucq4YjtmE+HpXck15HmHEp6u2D3u+Tko0RSi4bQZEZSOG5tNVpAiJo
 3OIvYc/ntJa4ovhJmCJzMvSRGHWgERekrEqZsDL/wjcSRHkkQ0yp76Ecdy4u5c1ur99CtCY
 8l0y0SbKhRVGqE+WO/NDsf1Py3MUtJI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736326055; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
 b=c3nxKC/CecmCqrZXh8OSSJHd8LbkneoeGZ4pZT7GNFC+EML2zOBaQTVyv+9r9mJXESr9w
 XnBb1SLIsCn9HUcDOAbSzcmQ1shXY3XiC8WBsagdwV9jKNqwhb76aWJXM3bXodqeukvuEU9
 kfiZD5gMBOQ2uo7DpP7x2R5Z1mbkoeg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B55F183551
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  8 Jan 2025 09:37:04 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736325425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
	b=Tsih8r8EN9IxzfLBSe/jxwm49hlVG50xP960h/jSUnRSZt8vrlnAYQ7rT4KneGjRNpIa1U
	1gqPMhXpKAy9CZeiAI52T204TErMAuYOcfVopir9M42v7PZ1gbM7VbILdPBrLx4DL8dQiy
	LmkOZvBd1aAvFZyRZlimmgNpq81XUiM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=LnZnYcmp;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::42e as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736325425; a=rsa-sha256;
	cv=none;
	b=u/rAH4mX3v02MxZYf43bK1sLv3iyX+aHXMQGg12ge4EppMD+us0ujvRwuL0ErTGHKTV2g1
	jlT3r6fBd3Sv1gsmC4+2BxXZ/RyH9snqWhp1SUpQrQCs+y3cXKHyJAWob0MaAM5hZsOInq
	iyct0ojE5qR60JvjEWPagFzGkWuuvVc=
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so6239027f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 08 Jan 2025 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736325424; x=1736930224;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
        b=LnZnYcmpQbMBMAypiLrSAzmAhUDafX7WMxo7dU/d88JqPJWSZLC3+IkKxOdZWhsEAI
         RwnA1ugWE7ce6FWApDOTpjGxC3MHgLrSnJQ9s776+Oouf/kYI/hrNleO6biJprwTZFB9
         BbA1dV8xfAbnVc0WW7koRGTYt4BUYkb6bn3pKGeTNLSC9mXlELJdsOJB3MMxkNUOhq+6
         WVKmlCxf285Y9+0EO/yuI9rrHOGJ5QphlKQQaYYtQ5t/PMcHkyunpIt+B0ErOu2Mqu7g
         BGb0UHPglsIyojWae64dxsNE2N10vHe3oProoRyOZAo3u4Pu24QwoOI9S/hpc068XKCB
         y+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325424; x=1736930224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvettVxfJ9lYY3or3UxLpfyl/cdkwWLgR9kVNnFx6ho=;
        b=wsz72zuxMaVxo/8ChOxMlIgdXT/kg9pr3bEqLng4DGQuhaRlpcavwLV+Og1Bj4fCz9
         wX+ESHfcJSWOWRBN6uEQMYXzPS5ER/La0TSOrur0LK0yhyBfTGH25VLF5P50Z1BvTCbY
         HiTIlJTqTE28OH1CkZlwEtQhbe8oxLv5gdSRpq20HQ/siOLLGByUgaXv5cdbQauFzCrL
         rN9D9i+OF50pemaS5GrSnJQj8BCnzdTsPvr1eFEEOWwnD67SyJ9UszflSKWf5/wUj+eT
         CjitMiH5KGllE4ZVeoyHdBLNw/nh/3iwlCuMqMnq+yCTYAQ3amRK1RL1CUTx4x+bJbYC
         sBQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFOHmGZPjy4pUWGbbdajPkSLkNou79+CFESNq2w2vBY970vJyUzuGjF/ojY6MsNudeSfritShemOaBSw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz2EBYcslQh8hCN0wr6G5Qaay3niv2G9mU8GlnKLDRtQsdO62N4
	jDouPyMz3wEG4j0Lg0rzMwBmSYr1H1b7I6x4U2AsjDR3EOKdV+vELB8IlNPCLREi/WLtX2I6r6E
	sNvSm8Vsrst7BXLPd6hD6Hq5B0IM=
X-Gm-Gg: ASbGncuCLstD2p3PP1LydSCup2/RE/nt7VRRbOBFdYVSoSnOHZfseFTYAii9Se3xg2f
	knBX6wG0E+lpI04D67tuveP6XtWZ0kNfSCX2E
X-Google-Smtp-Source: 
 AGHT+IFnmy3aEmpEtSYOMGcp/W5oHyWUG1cZe2OhDShkb+8U3jvy3oPHzekY3BLrSLnXQaOhfCodhl5ttnW21/EGgAw=
X-Received: by 2002:a05:6000:4712:b0:385:f38e:c0d3 with SMTP id
 ffacd0b85a97d-38a8731a4d3mr1171129f8f.58.1736325423889; Wed, 08 Jan 2025
 00:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com>
 <20250104125732.17335-3-shaw.leon@gmail.com>
 <20250107123805.748080ab@kernel.org>
In-Reply-To: <20250107123805.748080ab@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 8 Jan 2025 16:36:26 +0800
X-Gm-Features: AbW1kvZots7MSnDo6hVFO1pdLy0jTDp88J1frKk6l9Bo0g1-dsYfw260dsxsY30
Message-ID: 
 <CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into
 struct
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
 Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID-Hash: 6DNK4CG6MGFZ5Y5BLLUBP4TJRVFLV3AK
X-Message-ID-Hash: 6DNK4CG6MGFZ5Y5BLLUBP4TJRVFLV3AK
X-Mailman-Approved-At: Wed, 08 Jan 2025 09:47:15 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6DNK4CG6MGFZ5Y5BLLUBP4TJRVFLV3AK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Jan 8, 2025 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote:
> > -static int amt_newlink(struct net *net, struct net_device *dev,
> > -                    struct nlattr *tb[], struct nlattr *data[],
> > -                    struct netlink_ext_ack *extack)
> > +static int amt_newlink(struct rtnl_newlink_params *params)
> >  {
> > -     struct amt_dev *amt =3D netdev_priv(dev);
> > +     struct netlink_ext_ack *extack =3D params->extack;
> > +     struct net_device *dev =3D params->dev;
> > +     struct nlattr **data =3D params->data;
> > +     struct nlattr **tb =3D params->tb;
> > +     struct net *net =3D params->net;
> > +     struct amt_dev *amt;
>
> IMHO you packed a little too much into the struct.
> Could you take the dev and the extack back out?

Sure. I thought you were suggesting packing them all
in review of v3...
