Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE4DE77184
	for <batman@archiver.kernel.org>; Thu, 19 Dec 2024 08:20:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 06DF583F9F
	for <batman@archiver.kernel.org>; Thu, 19 Dec 2024 09:20:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734596439;
 b=ExyOnKsc9yujU+FL9m2pW6O3tjf+wAy1KIYqUOldfwsFce5LdkoZcWePxdVf+bKDXNqAP
 oQXrDjRZwc4v4GzdCnHWykfIAFIKPgFDC1vxaZEc9+zLLv40zJhVskT/SykU/tZiWZ5MYjv
 sMj3P7eyGkKriQUru2WO6HtlfbhZhIk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734596439; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
 b=rkHWfj2q/sAZwI5XhcStVaFVB+SpI+wXvKSu6ah9Z/3PMJmY78HjqBANaM6vpkkpKH+C2
 jt1Q0hHBYr2ZQUJQGypDf7D8L2liwkwaTrwegLTlP2j/hIx5aPwpa0jLa6wjSK6V7XvokhE
 Y2JyhSfjpHETYwMLXDHtjfc34DpUrsg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 34C5781CBF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 19 Dec 2024 06:54:42 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734587682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
	b=cC7fRU5j8HXJQjJ7rL1tO8GYh5tTpMcsyit7KxG8yX8uqEZ4psC50/pa4+HI5XPIDT/v0P
	PDsCLVFYWjkXu9jSqjclxF9MKYES7x2S9z6pmXlAaXrklM5+QE7khJll67NaewHIQriHxW
	558IWwySkJh4zFfjVAbr32huv5BR9Fo=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734587682; a=rsa-sha256;
	cv=none;
	b=IKVqY1VsTCWigl0a+ZMI4QPLPxKK0whiDUC444BsqQwgPyy7oM9DvYBuEOn6SNUcfvLVZe
	xsXRX1KENP2pE2rU0Lu0fiphw39xSAvtyyrLvGtXz+F+xT2xNy3OiAH4x2bRJ9NUwhw1Nc
	gpEhDUwPhmjACcwkTgNsBTVPprBywto=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=FFTs7tZt;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::32f as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so4487345e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 21:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734587681; x=1735192481;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
        b=FFTs7tZtSWnXNeSEPBs+mWVWeuUQ6quypiJRy0Hy6bWcXmEjWNTuogcwDVpnAk/sSV
         QwoYVKFOtNhHaxsGsz1iYG0kuvkACKfzafEXDioIfnA94pO//t+UJRQFsxLqqbHK7mY2
         WeGaGG6soXGtQAcHMYNBAH+eQfC7GGurD5jMSgaTENVVLlXeX9nhw8wFqx/rnNrL6+ss
         Ax6d5ovcYET2iMQ3eCgPddwmckP4/w88hve96V68NZJ875FJ0MKDPGheJ4d2SZcGneOG
         A/0v/BBr/7ilIU4F0P6FPQ/j6kZmYrXvAj5kOpNehtGp79WwmQvG44TI0x1IpJ3lhoJ0
         1cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587681; x=1735192481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
        b=RjRnUtkMGi+28SyEO9g+FBAFnAIOhM0iAVGch+TFntU9rUooxV2oB6nQx0rjOSew6p
         GI8pa9MiiLXTue2WBsRSB5wwNsOiBsvQeI2PIIPohRCx7XOeAk+pv0EsYSBdp6LM5uJL
         QwAAzLRSFQuI+1jhTNcAaqWTtFIB4FB6mx3fPEAB/Lyo+dhndBPFPXupBYkJOvUceQFh
         5ifAKm8MO4gR+pkWvJg+NzGH+cVk4z7Bi6fJpCg/5QUs21s/cD3tbgo6F/xcjoHpALDf
         VQnRp5ZtIMsVFJAShrc/TH5Ly7B81D0F5Xp0XVKilkUhZuId3A7UObrst+LLOWxK5way
         dhCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmX0U+bcfR5SNcvAliq0KY3mDUzLaBE8I1dCnT7X0+YQB2ttv1qI+jRI2ieLyn0LHlkhQmroCnOOghYA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyq2hzVOpEr2jfJR46799Wk6IDCHUtvQlDackxeNizJzAgC7MLw
	sbwqbYEsw60jgCw920maHxEcwEJ4Q9bFJIXcYZPqYC5hUl0Ef19cHJ61o4xF0AE8MN9xBKE5ePJ
	Ce0j8ua85+W9cDolu7rpKeoTus6M=
X-Gm-Gg: ASbGncssRDCI2xBMoyAIDCyhGwuN9zWOVTNXJE4UDmnoV0PrEwBNrr5aBH56Bgbra4A
	ILb4+lfNOODVgWtBoUI/xVGhopeBv3SqSql+L
X-Google-Smtp-Source: 
 AGHT+IFXswhNY3wf74HiVRQ6mWtI+LQ0dYPzH2WDbrTkg0k3vCjw9PHsmFSj9uux2yKPzKWzDIYRJF3gX8R2i5iXHRM=
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id
 5b1f17b1804b1-4365535c6a3mr52447275e9.14.1734587681279; Wed, 18 Dec 2024
 21:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20241218130909.2173-1-shaw.leon@gmail.com>
 <20241218130909.2173-12-shaw.leon@gmail.com>
 <20241218153759.672b7014@kernel.org>
In-Reply-To: <20241218153759.672b7014@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 19 Dec 2024 13:54:03 +0800
Message-ID: 
 <CABAhCORszq9ao3OCVW-1EBsxsnLxbQ096eV+cbs12Es2HvCgUA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/11] selftests: net: Add test cases for link
 and peer netns
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
 Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
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
Message-ID-Hash: E62QVSRAUXOYFKEWYK7HN4TS3POFYFTV
X-Message-ID-Hash: E62QVSRAUXOYFKEWYK7HN4TS3POFYFTV
X-Mailman-Approved-At: Thu, 19 Dec 2024 09:20:18 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E62QVSRAUXOYFKEWYK7HN4TS3POFYFTV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Dec 19, 2024 at 7:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Dec 2024 21:09:09 +0800 Xiao Liang wrote:
> >  - Add test for creating link in another netns when a link of the same
> >    name and ifindex exists in current netns.
> >  - Add test to verify that link is created in target netns directly -
> >    no link new/del events should be generated in link netns or current
> >    netns.
> >  - Add test cases to verify that link-netns is set as expected for
> >    various drivers and combination of namespace-related parameters.
>
> Nice work!
>
> You need to make sure all the drivers the test is using are enabled by
> the selftest kernel config: tools/testing/selftests/net/config
>
> This may be helpful:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style#how-to-build

Thanks for pointing it out. And vng is really cool. I will add
the missing config in the next version.

> --
> pw-bot: cr
