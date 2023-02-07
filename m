Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291ECC636D6
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 10:42:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D52C80CE1
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 11:42:24 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2BD43807D7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Feb 2023 11:41:59 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675766519; a=rsa-sha256;
	cv=none;
	b=zIgTbJAJl2TktMKXg6CZoEesZA4wuVFkfp34aauv0GxkplbSN3DxxSXa5KTjFltU4ZQ94P
	JedoB77Rpc9BbyNFemYDGxUphtKb/tDZ7RCEP0d5rc+argBPYQ8iQ5Irj30K6h9tDaBpQW
	r0cx3PHLMVqlYi8EfZQzzHqW578tcoE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=NxlqtVkw;
	spf=pass (diktynna.open-mesh.org: domain of leon@kernel.org designates 2604:1380:4601:e00::1 as permitted sender) smtp.mailfrom=leon@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675766519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aYz8Ua//PcT5aSANktmxMVOnqE8lWYmzvjdTu1jjN8M=;
	b=I9XXOydUnKjE4tYgn3x291ePVt0fMwAkxWeEsOXJFqweoy7oCBCtBNUOU5T7xT4UJXxN7R
	Ok7vsIv/ZjodtsBp6JLDPl9tqLiRLCGJRktXgHbFPdvRaGzdj1A7Q8ORY1DmBIU4q/BmJj
	G2Ld2esCFny9TUN/gtJyCnQbJhIhHZo=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B739DB818FE;
	Tue,  7 Feb 2023 10:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9495C433D2;
	Tue,  7 Feb 2023 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675766517;
	bh=aUSmtgnWVb7wapkd+R2YMWg8E9kOVmhJ1RtnucI9Yj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxlqtVkwbTej8nugq4SMgKr65sQ98cjS+F3LBxRz5YeryxuYudXA8DqXtTDfKkjU0
	 vN9AT0hRllddhCv8abdNObULEJof0bTkBvP72rExIhYIRtNs7FAGtK1Pfsr0BBEF6s
	 8ULyG2rP00vjGQwmq39COLohhfpM2AK+LCht9pL3EGbWNarljtoIivUTsEUAptmgla
	 1JKxPWD1+Fn4yNUTkcha4Ve6sVP52kVDDTRHbHhpdG7fhcMmMS3nlB8i3YlYlQDm+v
	 0n+sCd7DT9r2cFQ3CzhBpv8D6p6QjsMdjY9oaYpfCu81hcDmZkhOKq36t5uCG2iJHg
	 Xpf+lQjHyZMng==
Date: Tue, 7 Feb 2023 12:41:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Message-ID: <Y+Iq8dv0QZGebBFU@unreal>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
 <8520325.EvYhyI6sBW@ripper>
 <Y+ITwsu5Lg5DxgRt@unreal>
 <4503106.V25eIC5XRa@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4503106.V25eIC5XRa@ripper>
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: RQNLZ5X7QNO4TNX33SJOHQEJ6LYJFGQL
X-Message-ID-Hash: RQNLZ5X7QNO4TNX33SJOHQEJ6LYJFGQL
X-MailFrom: leon@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
CC: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RQNLZ5X7QNO4TNX33SJOHQEJ6LYJFGQL/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Feb 07, 2023 at 10:50:08AM +0100, Sven Eckelmann wrote:
> On Tuesday, 7 February 2023 10:02:58 CET Leon Romanovsky wrote:
> > In cases where you can prove real userspace breakage, we simply stop =
to
> > update module versions.
>=20
> That would be the worst option. Then the kernel shows bogus values and =
no one=20
> is helped.

The thing is that you already show bogus values.

Most users don't compile their kernel, but use distro-based one. The
latter is a mix of base kernel, fixes and sometimes backports.

For example, on my system:
=E2=9E=9C  kernel git:(wip/leon-for-next) modinfo batman_adv
filename:       /lib/modules/6.1.9-200.fc37.x86_64/kernel/net/batman-adv/=
batman-adv.ko.xz
....
version:        2022.3
description:    B.A.T.M.A.N. advanced
...
name:           batman_adv
vermagic:       6.1.9-200.fc37.x86_64 SMP preempt mod_unload

As you can see both of us have 2022.3 in version string, but are we
running same code?

The answer is no as you run debian and I'm running latest Fedora with
different kernel version, which means different batman_adv feature set.

Once you stop to update version, you will push users to look on the real
version (kernel) which really matters.

Thanks

>=20
>=20
> And how should I prove it to you? Is that enough?
>=20
>     $ lsmod|grep '^batman_adv'
>     batman_adv            266240  0
>     $ sudo batctl -v
>     batctl debian-2022.3-2 [batman-adv: module not loaded]
>     $ sudo batctl if add enp70s0
>     Error - batman-adv module has not been loaded
>     $ sudo ip link show dev bat0      =20
>     8: bat0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode =
DEFAULT group default qlen 1000
>         link/ether 7a:8b:21:b7:13:b8 brd ff:ff:ff:ff:ff:ff
>     $ sudo ip link set master bat0 dev enp70s0
>     $ sudo ip link set up dev bat0
>     $ sudo batctl n                        =20
>     Missing attributes from kernel
>     $ sudo batctl o
>     Missing attributes from kernel
>=20
>=20
> Expected was following output:
>=20
>     $ sudo batctl -v
>     batctl debian-2022.3-2 [batman-adv: 2022.3]
>     $ sudo batctl if add enp70s0
>     $ sudo ip link show dev bat0
>     $ sudo ip link set up dev bat0
>     $ sudo batctl n
>     [B.A.T.M.A.N. adv 2022.3, MainIF/MAC: enp70s0/2c:f0:5d:04:70:39 (ba=
t0/7a:8b:21:b7:13:b8 BATMAN_IV)]
>     IF             Neighbor              last-seen
>           enp70s0     50:7b:9d:ce:26:83    0.708s
>     $ sudo batctl o
>     [B.A.T.M.A.N. adv 2022.3, MainIF/MAC: enp70s0/2c:f0:5d:04:70:39 (ba=
t0/7a:8b:21:b7:13:b8 BATMAN_IV)]
>        Originator        last-seen (#/255) Nexthop           [outgoingI=
F]
>      * 50:7b:9d:ce:26:83    0.684s   (255) 50:7b:9d:ce:26:83 [   enp70s=
0]
>=20
> Kind regards,
> 	Sven

