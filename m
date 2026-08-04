Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835A2C55184
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 13:25:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ADA0F84212
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 15:25:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785849926;
 b=R2q3FpQd3CF5rDBwNO3zEiJyWYpFL/8Hyfpa/XvX2txK+EoBidZm06eTlVWOXtU8s3s1M
 H0McFXO2cN2aprhthpnsvLzS79CZrafeYBojgwRHPb465es/Hw8ziZA7QPqm1tewm3n+E75
 cwO79YPv34iXrp+cHnfqJWRcaL17QyY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785849926; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
 b=MFxZEebcF+oP50jvjM6BVxORcfEi2LEj9AgODlB3EhRPQLmbLtpY/bI0Wkvb8jMTpafRe
 I8qplNrXNnyL0mcu5VcXd/ochu0MnsuT4Mp1hLmsA5949XgXNYUw0m+t51OyBg4PzxZkBpu
 t1H72QhjJeluZskOeCaxVMYZdSOHsYc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass header.from=redhat.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1E07480758
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 15:17:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785849422;
	b=joaldjahkUE3V7Nbv2SFUCrCnZinreFAzwfY7D5ugt6zLVh2fwBhEmNtPjkCvkl0eHBgXp
	ffiddf9XI9qlU911QAn746bCo1mZW2wWHkakAdXJl+7JiyTuRTmCmEm/7zr1dNjVDtMmh5
	t+ikgu4S7orpv9kDUZEPGNqzJHR8YZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785849422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
	b=b3v5ZZJkKzIzqmWm4lrBf+erdgS82sggkT6Kl2daoNCOxZYf0Jb5Y8u467yAV8BEGrs4c0
	PKi8ag8soXHZGUpFgZL+JhXAxser4gurlqhKX8eWTRWgGFQNDwgSCLB5J4mroyazm4zzLR
	BjdGL0eb6UjDmcoRz6qRdJYCKIPCAMA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Xq8cMZYN;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785849421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
	b=Xq8cMZYNwiPsjvbOKV4/B6WH8Pb7nfhCpyx4cc2bzf1z85kQb3JWvs4jVzXVegJfpn7B1W
	s3F1L3UoalxBIAyBoV4bY2PkuV4of0LSb27sL+gpOq7/D82K6Us5fIUEkbYr5y2oM495h7
	BixE60R7/GooZbXa2qTpv83QCCQ8rwI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-3mYfcYbqNRGKt3gbN-vrwg-1; Tue, 04 Aug 2026 09:16:57 -0400
X-MC-Unique: 3mYfcYbqNRGKt3gbN-vrwg-1
X-Mimecast-MFC-AGG-ID: 3mYfcYbqNRGKt3gbN-vrwg_1785849416
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c1c4715cf0eso498074166b.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 04 Aug 2026 06:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849416; x=1786454216;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgKDAwfYkCsBa1/O9slq+N/Od4IInZ7YxbXYIKaLNVI=;
        b=MdHnjXsW/47gw3AbDozrCfGxf+/3xpS4pKX66QAeTKG0YlzIzCNOCb6GVeBwUWA1MO
         RjreKRKGEZR+qf1bWuwzTzK8hGNibKBnNDJ9mj5MdvOrEQhj2YiVft7mcUXykBV8LrYk
         5NDui3jhJyoM7CZfF9GTbNBusRolWY6i5XlX/AZGka8EAuutUfmoh1197m7H/hvl2hI8
         g/rAMFnZ2bJrTWZ3yfEgvOrJvgNxGwpqwY9Kp79GrTHbzgyBpCsPHCk7iIZSetMXvm1L
         rGijLmS8cZuDMonkYvgcb1XndiC3IQyh9hq3Ro9d6WB812XjKnbPgxm0i6C4UWJIvSUd
         vYjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoK1iEPnh77b4kaYZ4p6lnoCebqxUNfC4PgyNugr9WpQYsbYuqq+DVe/y6txKHBRnQqLjSZcExGmdgPdw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzszLv7k+i588D6/FAxDAInR4sO/o49nEAQ2mS4vb4R6Kq5MlSM
	2XHTw1Cggh0JAfM4dbnuL0tRKqZ+DE4yszo/C4wrkexUUHHCgYIInCPQINSLqpwshNSSjjcHijG
	wDvVO1enD5wRs1FuGnZVl/BZUlNAtIMLLLZbw86UJ7P4uWwJEDPNHHqizuLkhIRC0kq6WTA==
X-Gm-Gg: AR+sD11TF9qkgONxm976V3q4d8XRYHT5kktoX83phiivJOMPqUGbon3IsOCgN1RkvGs
	MiuTQTpdE1C+2BlyODeSJ0wjGTYY/lnjWQF+C6ll9oPVUQ8NvO6/trurE4vgLvcPTaDk4yLymYJ
	Jw72DidyUV1joyzfJC5a+hRshZXOShsTkHIbr+7L8umbDnfEi881l9YUv7PktepQjIiVXPTzXhc
	vTn6Cx75cVSm8uBK7wVkHaBCuv0IFTsDurv/rVWLE/l9ZtqB6jmVXLjhQegyr7R+52ieteYKkuE
	8vuV2RYN2dP3jZqZCXrzGQh/BP9wTI9sB3ovSmWlECvDOcv/VlQylKhzXq/ohSJlTNDOEWEMR2G
	MXfaHIPvvDULed/yHCJVD2YabJEzucv0HNEc1ObyoFFMktNQodVCwDYd/SpW3A0Q2xPC3AqP2EB
	k=
X-Received: by 2002:a17:906:34c3:b0:c16:209f:d48e with SMTP id
 a640c23a62f3a-c1fe8250ff3mr1087595066b.30.1785849416467;
        Tue, 04 Aug 2026 06:16:56 -0700 (PDT)
X-Received: by 2002:a17:906:34c3:b0:c16:209f:d48e with SMTP id
 a640c23a62f3a-c1fe8250ff3mr1087589966b.30.1785849415843;
        Tue, 04 Aug 2026 06:16:55 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it.
 [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20361312eesm12924466b.4.2026.08.04.06.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:16:55 -0700 (PDT)
Message-ID: <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
Date: Tue, 4 Aug 2026 15:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <20260803191920.0e6c5a2c@kernel.org> <3386526.aV6nBDHxoP@sven-l14>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3386526.aV6nBDHxoP@sven-l14>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v2vlQha8s0VQI0eYwuIshu9yExEnu4XxzIUOc09q6hM_1785849416
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: M7ZTS3VDJFN4LOENELXXOJQKNFZ2SJT3
X-Message-ID-Hash: M7ZTS3VDJFN4LOENELXXOJQKNFZ2SJT3
X-Mailman-Approved-At: Tue, 04 Aug 2026 15:25:10 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M7ZTS3VDJFN4LOENELXXOJQKNFZ2SJT3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 8/4/26 8:55 AM, Sven Eckelmann wrote:
> On Tuesday, 4 August 2026 04:19:20 CEST Jakub Kicinski wrote:
>> On Tue, 28 Jul 2026 15:39:03 +0200 Simon Wunderlich wrote:
>>> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
>>
>> Can you look thru the Sashiko comments here (especially Medium+
>> severity)?
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-11-sw@simonwunderlich.de
> 
> https://patchwork.open-mesh.org/bundle/ecsv/pu-main/
> 
> We were just waiting for a verdict. I am guessing it it a "no, will not 
> merge", correct?

Please be aware of net-next commit c82ff94592fb: the expectation is that
submitters reply proactively to AI review comments.

Specifically it would be helpful an evaluation of how critical is
problem reported and if it could safely addressed with a follow-up.

>> At a glance patch 14 does not inspire confidence. I guess patch 15
>> removes the worst part - but is there a real reason not to use locking?
> 
> In its current state, you would need spinlocks over larger (op-count) portions 
> of code in the hot-path. 

I'm not sure if the following is well known/helps, but performance wise
slightly lager critical regions are usually preferable to a larger
number of atomic operations,

/P

