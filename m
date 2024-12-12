Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ADFE7717F
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 13:10:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 49E18840C1
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 14:10:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734009040;
 b=CxviJRgSU/fnVJfqdgaZuj0NYdklyP7cSXdJa+P29MYTBfsh3Zj3tEBaZ7OiaLzTHTIEB
 lf/wOdYWYpd6Gq1c03bXvwlkjHsOUDifT8aQrStYrmdUQSr7c/K3tDbgpFJQZl6fvVxnMkS
 1E1RzA68WcibrzycyVF+TI0ouV11eO8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734009040; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
 b=VAGPmbuyFgEAyRLBnZIdraPVdxZDAUGuVQTovS+cCjAtxixtMErJUDRTwWM+ADH2Nvlio
 icx52oIkCj76x/Y9G0voDWrzaxCn6KSs6dW9/YkA7DJoi5IzkNzrom55FTjN5sT+3zkgvGO
 DkW+qNU3brozlbE9+GaBBAqg6Hu3BXA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5BA87836DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Dec 2024 14:06:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734008800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
	b=cT6zzGJmPZYLbLhokjO9i7JqCpvxQubHcQ/Zba2xw4QPrH/VFw4HiDsSSmmCx4gw33kq1G
	VqKxQNQW/RWyxYrie/gPLK+b2oYsY+bwIXqmOABVKhviK5Hd59mGBOOBHR0Zr6Trhiao+5
	dyMLXweAI3n9yOh7At7SBeKE7i7rH6c=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734008800; a=rsa-sha256;
	cv=none;
	b=dfNNSLKtHLl2NVkz6XPYtlgtexKYXY5apKe8hPvrlEm4Djo7C65Mt22sXYD4UYZqVgG8zK
	PEQTNMsbdS7oPwI7/XFySMxjkubDxl1tZoA5UOlziT8XWuJzDa/S3Wh7gb7Uo+j0lhphkY
	gm5PtFO3pEAMvMFB6XXP39c2C+/uABw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="W/eXlpGN";
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2a00:1450:4864:20::32d as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso5919705e9.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 12 Dec 2024 05:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734008800; x=1734613600;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
        b=W/eXlpGNXeGvmEN9fiiVbqEfYzdc1TjAGtl+J/Emn6TSX5yaATkG2v1CBgMe5hFwRh
         8CcIJ21d60QiFUe9Hrn1Zpyyq3EftOltlAtFppdRoitOQkBbsf5Vpk68c5sLKOkdNbHk
         RYYl50STrCKhhRlCmoQLO0nofcBTzF51GsR2GO1eHY0vP7Vg/cUh/dt1TC3isXB7u52d
         3R/AJIIFXZ4JoHuuF12x9wI+O6c3s9qYFMbaCLAqGm0viI6YR3v1O18pWfr/ohiJwMi2
         WReF7VK5FTQdWzYKuAt9xa7IKOScEInwg4LmCXxT8roCMwexmlHuu/eInH3Aut/5ofm2
         8h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008800; x=1734613600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqYxTqAiECe9wyyAXaPuVyEXlxRKQjZazVAEQa5Qpbg=;
        b=qurDeFQ4fT7+o3kpENP2lxPLY4sPOdTjlGHbCVbXlcgWysjaF1X85yNZ5wec4cXXlb
         saUjCnMGX3ON4FTdFB36uX0Qkkrq5hpXf98OjQFfRsok93iwlny6dSayOjOyJ48M7EM4
         0rxuZByjpqUy9miS3bfNu21GmVvjRP2IH5NxX02pJFqC6JQHJ2gw1LLj85l8y8V4+5IU
         Jnk7R9eRln6BJuQy2BzdSr0eCICtYwdN8JumZs/FK4ltP5ubHBqw70K3ZI6za+tEiYUn
         7BC5VCtxDjdpNvnjh3oyy1CskNeIS8v9H+LUrNJw3FH+P97SvpAMExQVW4bOGTX2H/F5
         BDRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1H0vG1Q2MZUWDmh3y9bh4OK12F7b56JW7y8yY9q3yObSoPz/3Su0i/4y6NWEicnNWYBPOnhPUHJMr0g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwfYGowKKSfJAifbNzl41xBrBgJpBUrgvtHcRZhMeA8hgt+TW+e
	9Iry5oLQ1k2BsW2PNTCOkQUeRUYfd+DYQqosToOKMSmVDcA5/HUT7u1O5QrIZiDE1NJ5M8LlqC1
	ieUQliqXyDupD3vi9jmDktr6ksK8=
X-Gm-Gg: ASbGnctJU4owJHwLKaonujFj0EfNImeHlxHYK/x3MttQu6pKV425LgkhwpyHjJ5TUz6
	Dhtk8SYiDlULoghcXRFizl8+eQWLvhxsfrVbx
X-Google-Smtp-Source: 
 AGHT+IEgToBDxS7Y2rJTQaW+KRxkcbBuEM1S3SQpzBBgB7EfM9NZPQ+SlbrHysoSI6mEreAZ9kYV8K51n0HSyiFVXHg=
X-Received: by 2002:a05:600c:3acf:b0:434:f8a0:9dd8 with SMTP id
 5b1f17b1804b1-4361c345006mr53002405e9.1.1734008799513; Thu, 12 Dec 2024
 05:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-6-shaw.leon@gmail.com>
 <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
In-Reply-To: <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 12 Dec 2024 21:06:01 +0800
Message-ID: 
 <CABAhCOQnMGm8y5bVj_fg5veJqim1PEEa02oZHqFt7ZPEQMpFzw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/5] selftests: net: Add two test cases for
 link netns
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
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
Message-ID-Hash: FTRBBMI5QTQRGLYV7ASSTOHCVQJ75C3X
X-Message-ID-Hash: FTRBBMI5QTQRGLYV7ASSTOHCVQJ75C3X
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:09:32 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FTRBBMI5QTQRGLYV7ASSTOHCVQJ75C3X/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Dec 12, 2024 at 5:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/9/24 15:01, Xiao Liang wrote:
> >  - Add test for creating link in another netns when a link of the same
> >    name and ifindex exists in current netns.
> >  - Add test for link netns atomicity - create link directly in target
> >    netns, and no notifications should be generated in current netns.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> > ---
> >  tools/testing/selftests/net/Makefile        |  1 +
> >  tools/testing/selftests/net/netns-name.sh   | 10 ++++++
> >  tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
> >  3 files changed, 50 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/netns_atomic.py
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index cb2fc601de66..f9f7a765d645 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -34,6 +34,7 @@ TEST_PROGS +=3D gre_gso.sh
> >  TEST_PROGS +=3D cmsg_so_mark.sh
> >  TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
> >  TEST_PROGS +=3D netns-name.sh
> > +TEST_PROGS +=3D netns_atomic.py
> >  TEST_PROGS +=3D nl_netdev.py
> >  TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
> >  TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
> > diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/=
selftests/net/netns-name.sh
> > index 6974474c26f3..0be1905d1f2f 100755
> > --- a/tools/testing/selftests/net/netns-name.sh
> > +++ b/tools/testing/selftests/net/netns-name.sh
> > @@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &=
&
> >      fail "Can still find alt-name after move"
> >  ip -netns $test_ns link del $DEV || fail
> >
> > +#
> > +# Test no conflict of the same name/ifindex in different netns
> > +#
> > +ip -netns $NS link add name $DEV index 100 type dummy || fail
> > +ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy |=
|
> > +    fail "Can create in netns without moving"
> > +ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not=
 found"
> > +ip -netns $NS link del $DEV || fail
> > +ip -netns $test_ns link del $DEV || fail
> > +
> >  echo -ne "$(basename $0) \t\t\t\t"
> >  if [ $RET_CODE -eq 0 ]; then
> >      echo "[  OK  ]"
> > diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testin=
g/selftests/net/netns_atomic.py
> > new file mode 100755
> > index 000000000000..d350a3fc0a91
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/netns_atomic.py
> > @@ -0,0 +1,39 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import time
> > +
> > +from lib.py import ksft_run, ksft_exit, ksft_true
> > +from lib.py import ip
> > +from lib.py import NetNS, NetNSEnter
> > +from lib.py import RtnlFamily
> > +
> > +
> > +def test_event(ns1, ns2) -> None:
> > +    with NetNSEnter(str(ns1)):
> > +        rtnl =3D RtnlFamily()
> > +
> > +    rtnl.ntf_subscribe("rtnlgrp-link")
> > +
> > +    ip(f"netns set {ns1} 0", ns=3Dstr(ns2))
> > +
> > +    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
> > +    ip(f"link add netns {ns2} dummy2 type dummy", ns=3Dstr(ns1))
> > +
> > +    ip("link del dummy1", ns=3Dstr(ns2))
> > +    ip("link del dummy2", ns=3Dstr(ns2))
> > +
> > +    time.sleep(1)
> > +    rtnl.check_ntf()
> > +    ksft_true(rtnl.async_msg_queue.empty(),
> > +              "Received unexpected link notification")
>
> I think we need a much larger coverage here, possibly testing all the
> update drivers and more 'netns', 'link-netnsid', 'peer netns'
> permutations for the devices that allow them.

OK, I will add more cases. But I'm afraid I don't know how to build
valid parameters for all of them, and some seem to require hardware.

>
> Thanks,
>
> Paolo
>
