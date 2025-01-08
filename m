Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C50EE77199
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 17:32:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9E8A48425D
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 18:32:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736357520;
 b=RWnMjCck+5ZaycV7q10/BCCKz64XuT8EUHY843c6olvRDjBpF8c8uwlK1/dqoyE7CL8Pr
 OnoKEf/XUtUtElqPnpkFe5mHHFpwEXR7VPoVTzIuWEo8GagkBisuNX3MCGfhSMEaRlsgkvT
 o/gJJNZc9Pw1tZmqY6gndDiAEgAk7Rc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736357520; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=COBirtzEZT5ICu9dWIyHsiOheP6bnlp5lUb1cM14oHc=;
 b=XqrHuNhRDG6PxlviV5i2lC0Q2K/Rn2nHEVYh/iYQC5aSIKO2I5fKYcwpzh4pmbQ/aLGDq
 9ZbSMyDffYd/llmjj7B84SmLXBXcg0Ui4hchmde2pMkf9S/juluxbUT4T+M4KP9kU6MZHCF
 rKx3ilK7tfl4cAxpLjoJ435X/5UIO3U=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 89BB1825DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  8 Jan 2025 18:31:42 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736357502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=COBirtzEZT5ICu9dWIyHsiOheP6bnlp5lUb1cM14oHc=;
	b=ZbVZ6InKMbzCJJUGHZSLyWDU61Xj5EuCKa8gPT41/uZw+jQmZCzl1OnhU9ikbcodmt+3g3
	3VL0N/PNsVV83QH7F584Glb84nbrmfl3mlCxFhG8wuIST/xqK4sJhmAd9Q9I0HGmxUAtQZ
	XQlmJH38lloLCSObPJK2DaRUaGdpAbo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=dHciAqjY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 147.75.193.91 as permitted sender) smtp.mailfrom=kuba@kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736357502; a=rsa-sha256;
	cv=none;
	b=KhuFh8p2naeKPP+/qhPhRQf6CCzdqHA0FJg3kn4KA+uClS7aBOjJt4XkKi3fdcBAQB8wET
	FarRh8adrqAU7PlB9Bwa0pl5CQ1Dyz/wHF/LRXOr3jvuFQ7VYUPuCdl7c6BkWVIQj1wGy9
	nzD6mb8Wv6msKKNlt/RK3e1J/K9eeqQ=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9978EA40C9E;
	Wed,  8 Jan 2025 17:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A24C4CED3;
	Wed,  8 Jan 2025 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736357500;
	bh=nFNghkqYK0OyBrmna6riJjtdRf/DJ2kks0ygjdBlGVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dHciAqjYDmfJ4f1GrLA+k2mHdvH/PcVoEoaHp5l6oKUNCl2H/rGngM0bwH32RiDGA
	 RKqyu4tcA5nz7uUemz8c9pBwQy5/Yl8okpkaljtV2r2hG4AolL+jj/8d3xoqFgJj/k
	 A8Gm9TIsj/lz+b3kQ9boVv/nZhWvr6TKHL4QkMBonYptSr9cZeQpQoKuXcOHybpkHo
	 e98f1a4tvA5J5nyWISRW/K9JoOD2UBjXudUvXF9tlj/7wrEctr/u5Qqq3QhEk/fT8p
	 UuTt5BSsN/f7ZpDAzFwxdIWvEiqXFx0/T5vxvOySo2ialJKoOi0JYP1ThEhqIye8Rl
	 dB8lzKIIuuacA==
Date: Wed, 8 Jan 2025 09:31:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into
 struct
Message-ID: <20250108093139.126716e9@kernel.org>
In-Reply-To: 
 <CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
	<20250104125732.17335-3-shaw.leon@gmail.com>
	<20250107123805.748080ab@kernel.org>
	<CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: X4GYPPDQZL3C6WJ7IW2GEAGOQGEMWNL7
X-Message-ID-Hash: X4GYPPDQZL3C6WJ7IW2GEAGOQGEMWNL7
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X4GYPPDQZL3C6WJ7IW2GEAGOQGEMWNL7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, 8 Jan 2025 16:36:26 +0800 Xiao Liang wrote:
> On Wed, Jan 8, 2025 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote: =20
> > > -static int amt_newlink(struct net *net, struct net_device *dev,
> > > -                    struct nlattr *tb[], struct nlattr *data[],
> > > -                    struct netlink_ext_ack *extack)
> > > +static int amt_newlink(struct rtnl_newlink_params *params)
> > >  {
> > > -     struct amt_dev *amt =3D netdev_priv(dev);
> > > +     struct netlink_ext_ack *extack =3D params->extack;
> > > +     struct net_device *dev =3D params->dev;
> > > +     struct nlattr **data =3D params->data;
> > > +     struct nlattr **tb =3D params->tb;
> > > +     struct net *net =3D params->net;
> > > +     struct amt_dev *amt; =20
> >
> > IMHO you packed a little too much into the struct.
> > Could you take the dev and the extack back out? =20
>=20
> Sure. I thought you were suggesting packing them all
> in review of v3...

Sorry about that, I wasn't very clear :(

What I had in mind was similar to how we define ethtool ops,
(especially the more recent ones which have extack)
for example:

	int	(*set_mm)(struct net_device *dev, struct ethtool_mm_cfg *cfg,
			  struct netlink_ext_ack *extack);
