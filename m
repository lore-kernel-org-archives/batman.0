Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637E7E7718B
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 23:38:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8B67F83FB9
	for <batman@archiver.kernel.org>; Thu, 19 Dec 2024 00:38:23 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734565103;
 b=0RWPuV+yZdwRdVpgIb/nnzkKXrd28FKrs/KN9L9D0inqxz6BRzMsvtBzf9JGb5aEzW3/3
 d2JJpRdEqQiWBkujvROsPelSLbpq+0A2eCVyes/PM8Y7osaAWfmGdkkAp4LbZZWNj11WtMF
 mSEomC7EO42i0sMHWeT7cBMCPnK6CzI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734565103; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BW+cwMYC16q1L4/R/3BysbLqj4sSSnIqpYrohFBE6HQ=;
 b=HN0v8r3ntlBJC0D6vKpuGFB79mPP0wBJtWFP8bnpWNUTtr6ic9EvvtLhG+4qsu0HOEolp
 qz5VrdGNuWmz5VP5aGC8Vat5RZPqHRp4Uav6/L79wkQKy6g/cncgFh/KVpiDP5a47zl2qFD
 7k9u6GDv1d0vRfawqaQ5pXyqsech3+A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 79ADE81BB4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 19 Dec 2024 00:38:02 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734565082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BW+cwMYC16q1L4/R/3BysbLqj4sSSnIqpYrohFBE6HQ=;
	b=yDKbVPZgJtV3BK66jggIHl8NVBOYAOB/l0XXKwg+1hN69SwVGTs3CY6De38aypm10gbMjz
	DIO0cgtag1Ef7eB9QNtGxB8yDHW7A+aDZ1JxweY7wJKXmGjilodQrE75YMPDAo8sSw5aw6
	NlQoJd67bPrizT9IdODKBmPkPPwHOG4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734565082; a=rsa-sha256;
	cv=none;
	b=gHUk9XyD/osSE6/+nsGdPX5edwtu22MZSQwYA2H3DHDbNJXqSdSGyEwv/DLQlTnEQOjSbo
	xopPg3Aa+2c25H+FOuGiuHwGsBNPQ0sFezT77zE5KNg6OfAW2V/WmLltuyFUDccKxORTXs
	HrAWbGr9Y8Ldmv09OT5gqA4N5YEO0qY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=SMB95StF;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 01A465C59B3;
	Wed, 18 Dec 2024 23:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9872C4CECD;
	Wed, 18 Dec 2024 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734565080;
	bh=TE9MeQggFrUNHk7GnpsPc1qOO621qZHYt6YKXQvYGUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMB95StF87lMswBTmoy5w+GFfz3iCmebU4gbeFCJK7sk9+I16C9cplpIYLf0W9Qul
	 QxmbLpIR7/E6R0kf5eKkyEYZx8mBxxIidhrnHdr7M4IeFwaA3J5y2wWv4oQmfmxORv
	 D1j6lmCsAMuKx+jWknHgUh8GEb58788JfHfg1N+UuccR+d6b8ALbB6vzMOTnfrbNpk
	 nrbFqHQ3vUtoVAGtl14Lhqr/MD+oEcAwxAPHEo6k2fp/JS6ZLbq87qH4FknN0j6i1c
	 yDKA9jZ2UNpUbRlqHX4gnIrK03GFSOZ91dNOO2mqCDLBVJi/w2/4kNnX7grOmVIZvb
	 15jS4zu2mRPLw==
Date: Wed, 18 Dec 2024 15:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 11/11] selftests: net: Add test cases for
 link and peer netns
Message-ID: <20241218153759.672b7014@kernel.org>
In-Reply-To: <20241218130909.2173-12-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
	<20241218130909.2173-12-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: L3AKGUYTMCACLH3B3XWLNWISOKFRX7UE
X-Message-ID-Hash: L3AKGUYTMCACLH3B3XWLNWISOKFRX7UE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L3AKGUYTMCACLH3B3XWLNWISOKFRX7UE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, 18 Dec 2024 21:09:09 +0800 Xiao Liang wrote:
>  - Add test for creating link in another netns when a link of the same
>    name and ifindex exists in current netns.
>  - Add test to verify that link is created in target netns directly -
>    no link new/del events should be generated in link netns or current
>    netns.
>  - Add test cases to verify that link-netns is set as expected for
>    various drivers and combination of namespace-related parameters.

Nice work!

You need to make sure all the drivers the test is using are enabled by
the selftest kernel config: tools/testing/selftests/net/config

This may be helpful:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
-- 
pw-bot: cr
