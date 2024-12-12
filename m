Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B075E77180
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 09:57:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0572283FA9
	for <batman@archiver.kernel.org>; Thu, 12 Dec 2024 10:57:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733997456;
 b=QD20H1VJPqJ5wfTb6hsUvJ0XDag678o/nzh0ydRq3JVNacpCw++/frln9cUutxL3i+dMH
 P+g9k5f3BekjOUqcvyeHvUUYSpIxYWXsFx/BKxyPBHHaRKABtkrgAh2t4yeCKm0vX/9Cy9D
 PZhYj4sMBlPf9DyxBE8TXYnjrGnI1Ig=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733997456; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
 b=FbasJnIfXig/tUNwWx6RvqQhaf/prtP6LGwFe68tp+3Ba8dr0dVRkqaKTZp69+hxFfBd7
 zdiz2+S+2jFtMwT2YHfi1K4fux97Cnp2xKuo31/dDTQbLqkgfmMjw2KOfWWWS/ucC3gSpvn
 bfD2OmkBWdrupNSK3pTnjy+YT+lqmVU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=none
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 88DEC81D87
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Dec 2024 10:40:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733996460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
	b=BmN3YUhsmjRsY4xw/rGZkUQQ5sQ3lqH5GyO+y81ptgw3507lCy450iphHGgH7llzwgBEPc
	ggwy6n0srovWw4+HE508OBIMGbk96jsoaAaS9x2W8r+zomWfgFCtn6f8K7TT0isY21gUBc
	dOznFSxTpojcuFKNkzpWC6RTVEzTY9k=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733996460; a=rsa-sha256;
	cv=none;
	b=P4VY/qZYG8K49wRTMczuiLqTgAPfi1SDrrY57nzJm2YX79VzfbxBmYh5vepvSNhmh9SY9q
	0fDjr1w10Z10qCBunA8H2GnuAYtB6thwU2nqQUdPJ+VT7L4GfSAlZ1HFJAMAOrndWygGxT
	wnLcJ66PKPDNcZ9kxayFIWQty/8z6J8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UwlDR4wP;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.129.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=none) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733996458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
	b=UwlDR4wPRD6Eb4DFKgZ9fdxy8jAxr4kXYjZjFN/zmkEFJ9w3k/zX/cLiYvBzK/alfpc/Hb
	rAbdn+t+LjOQXYLJspmbchLoDiRJY7zo3f8HOOTgiYiOc542STFiuYx+glNIYF+rQeeWW0
	vV7y+ITjtmpKvXxrKp2DyZ68bPmzkM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-EBA0DTBZNSOfhtVe4phQtg-1; Thu, 12 Dec 2024 04:40:57 -0500
X-MC-Unique: EBA0DTBZNSOfhtVe4phQtg-1
X-Mimecast-MFC-AGG-ID: EBA0DTBZNSOfhtVe4phQtg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9d23so3732055e9.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 12 Dec 2024 01:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996456; x=1734601256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
        b=r+8gn4myH6eesr3n218MybdSkmPhPZutN9dv3oisggt1S8o7Xm32XeCIq80IcA2lEz
         qOLFzn1lJoG3wp7c7D8MiDVyEAJ7q0DwjFzmnYPktv0p+DHpX3L2vUQ72IkAtQkckCXH
         3JH4RTuxCQoItGWrXfcyTIF8FDNK/DJfYbPLlCwCRgHm2aOStYoCtgST/bVNC8ryLfJE
         RcrxjcRRNLhYN5xnroW80dR3n2A9PADYmfvYaLrmgp+PdfDVtFVBum/YiWlDkOlUOpRd
         3/nRBCAuBXCzz8N4Zy+MRoDRF4iLe70v0tWd8LcCO4PKH/graQKDBSpa9Y43+ksuN1x8
         ORww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVDoBJ6RzQXT5I825+ct7R8nCfryWPr6hkcX8PlPbS0nw+qEG+AE7WM9b4Sf9eIBaVr6aSNQN5SY1t6A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Ywqvd0D2yuEgBd+8/jNdeA7FLzfJoLBBCeQeppfsuL6jYEu96ry
	PUS/Xy/S7ywJ1Ee3jPZM+qkA091j9cVIgalpTCxDQP0fs74dSwM5+Ted/rpXBkZxo1rf9TWetsR
	fCjl2GuMUY8OwOtZu7uiK3Vm7WS90JB7tlozp3v1AOb3Le8Q01sZnxO+1KOHMHctUgg==
X-Gm-Gg: ASbGncsGgD3dVoOJxLLjR7cFkMJYXQJ9SN+BdWcborKJV4LzFMdkUjjcuxwliuSIQOl
	dNsU+CP5fbMa6hLsI1fxSp+cLUDE5OowReg/2Er+QMmt06CU5Vn0WgSo42HsFFQgxVSb5+nhlN4
	f/1AN0r8wpAAvLp3sQCH7d2YfBafZNehWqo7wwWc74fA/wMrR1MIfvgQw3x1bTsdIhR56DD80G9
	eS/YqfBKCqP1IiC56sNbTYcqpKVQtO++Y70hjEXW3AeAa4Tiz7I6yHuxF9Ei69Hbe+T+C1WM+JX
	/ApyJYA=
X-Received: by 2002:a05:6000:1fa9:b0:385:f23a:2fec with SMTP id
 ffacd0b85a97d-3864ce88e29mr6040202f8f.11.1733996455832;
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
X-Google-Smtp-Source: 
 AGHT+IFPT0KYgGEFCZGrqybSALsE3Qqj+pmWswO0HlvX3IBSNS8HmdA5fJvJjIK2Fq1iEV0Tr46sRQ==
X-Received: by 2002:a05:6000:1fa9:b0:385:f23a:2fec with SMTP id
 ffacd0b85a97d-3864ce88e29mr6040187f8f.11.1733996455462;
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c462sm11164015e9.14.2024.12.12.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
Message-ID: <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
Date: Thu, 12 Dec 2024 10:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] selftests: net: Add two test cases for
 link netns
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-6-shaw.leon@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209140151.231257-6-shaw.leon@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6n-6JD1OyDGbTpf9UM2VhVbQFroRwqeivbOoBoAzKc0_1733996456
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: YBI5EWTNUMSLOJHPJBORRW65X4FJCQWE
X-Message-ID-Hash: YBI5EWTNUMSLOJHPJBORRW65X4FJCQWE
X-Mailman-Approved-At: Thu, 12 Dec 2024 10:56:22 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YBI5EWTNUMSLOJHPJBORRW65X4FJCQWE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 12/9/24 15:01, Xiao Liang wrote:
>  - Add test for creating link in another netns when a link of the same
>    name and ifindex exists in current netns.
>  - Add test for link netns atomicity - create link directly in target
>    netns, and no notifications should be generated in current netns.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile        |  1 +
>  tools/testing/selftests/net/netns-name.sh   | 10 ++++++
>  tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
>  3 files changed, 50 insertions(+)
>  create mode 100755 tools/testing/selftests/net/netns_atomic.py
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb2fc601de66..f9f7a765d645 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
>  TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
>  TEST_PROGS += netns-name.sh
> +TEST_PROGS += netns_atomic.py
>  TEST_PROGS += nl_netdev.py
>  TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
> diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
> index 6974474c26f3..0be1905d1f2f 100755
> --- a/tools/testing/selftests/net/netns-name.sh
> +++ b/tools/testing/selftests/net/netns-name.sh
> @@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
>      fail "Can still find alt-name after move"
>  ip -netns $test_ns link del $DEV || fail
>  
> +#
> +# Test no conflict of the same name/ifindex in different netns
> +#
> +ip -netns $NS link add name $DEV index 100 type dummy || fail
> +ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
> +    fail "Can create in netns without moving"
> +ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
> +ip -netns $NS link del $DEV || fail
> +ip -netns $test_ns link del $DEV || fail
> +
>  echo -ne "$(basename $0) \t\t\t\t"
>  if [ $RET_CODE -eq 0 ]; then
>      echo "[  OK  ]"
> diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testing/selftests/net/netns_atomic.py
> new file mode 100755
> index 000000000000..d350a3fc0a91
> --- /dev/null
> +++ b/tools/testing/selftests/net/netns_atomic.py
> @@ -0,0 +1,39 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import time
> +
> +from lib.py import ksft_run, ksft_exit, ksft_true
> +from lib.py import ip
> +from lib.py import NetNS, NetNSEnter
> +from lib.py import RtnlFamily
> +
> +
> +def test_event(ns1, ns2) -> None:
> +    with NetNSEnter(str(ns1)):
> +        rtnl = RtnlFamily()
> +
> +    rtnl.ntf_subscribe("rtnlgrp-link")
> +
> +    ip(f"netns set {ns1} 0", ns=str(ns2))
> +
> +    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
> +    ip(f"link add netns {ns2} dummy2 type dummy", ns=str(ns1))
> +
> +    ip("link del dummy1", ns=str(ns2))
> +    ip("link del dummy2", ns=str(ns2))
> +
> +    time.sleep(1)
> +    rtnl.check_ntf()
> +    ksft_true(rtnl.async_msg_queue.empty(),
> +              "Received unexpected link notification")

I think we need a much larger coverage here, possibly testing all the
update drivers and more 'netns', 'link-netnsid', 'peer netns'
permutations for the devices that allow them.

Thanks,

Paolo

