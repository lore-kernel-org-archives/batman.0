Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A2C021A4
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 09:25:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2CCC482714
	for <batman@archiver.kernel.org>; Thu, 13 Feb 2025 10:25:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739438753;
 b=LxbgQf/rihb4x0h6FQ/GzbJwbSdiBKJ+aFbC4gIUbSOjKGLg0hAKOPFTwm50RTrH/PmI3
 v6JFr4gAqTDtO36yV9jAvwdRqVh9ZWB4wmZiNSAHB4hvnatVZC+ciq7JwnH35uOU5QSIhel
 V07JXqyBlBIj7QHqXQIhiiInzhxoAu8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739438753; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
 b=hiv/sL9+Hngp7X+Ia/+0nbH7mCcPUoxipLz3tiAXVxQSPDVkSkq/ItHpFPlov3q/lkb3i
 QIki3dVtGf6TtlgjjiK2HNHlivWHO5vGQw1CepxIs/+StA5tnGJ/HPo1tjJUZQzryN6yqJQ
 M0W1iwOYAmAS0nnSunD5+bEk68p5VL8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=none
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BDC2F80364
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Feb 2025 10:17:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739438280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
	b=WaxkIAREXlwg5buH9M5vvP3LUoyrYHOgbw6W8XeMbf4gzuXtWG7m/OfzniXbMMxdP8I3t5
	NJdRSEieiW3sEGqF0Y16cWZFFlDtviuVdfRVmMFEw84iO0BjFZDtCg3Ig/M5aDmOtm4L96
	9Q+333ZW9TwF1vwXVpUWAIclgIJMG1k=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739438280; a=rsa-sha256;
	cv=none;
	b=sKn+KkR9gcBhHWabOZ1P2Wc2Ko6py4V2AFzeKAMuWfDjhJ00hhhmATMnZalrpEKuVup0Wt
	7XdlMQaQ7kWpt+2jK+iVULUbG78IYyD2GbYRz3TtF1rMF3uVSF4poJakYtsRmpSoceXj+t
	bRgR2U8kh1bXDDAKmI4KffWfsr4tqiU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PDS3twiU;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=none) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739438278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
	b=PDS3twiUXT7kG3kZRHfQHEf3ZlRWS5CRBFp/KaL629RmVEHFAOi39oMMqTAXw00+/87XkL
	jqd9hb7qGOVUwxhGwFxixjlfibJUbSlaRwFnzlHrHFvDAOXYtlqsyVj5J0uKHYdd9KF4Yy
	6mOD3XvdCz9ORg3DRanl1O0iTpAVirs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-FXxkMR8yMISU8vk5gBaDRA-1; Thu, 13 Feb 2025 04:17:56 -0500
X-MC-Unique: FXxkMR8yMISU8vk5gBaDRA-1
X-Mimecast-MFC-AGG-ID: FXxkMR8yMISU8vk5gBaDRA_1739438275
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dd5031ee7so318701f8f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 13 Feb 2025 01:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438275; x=1740043075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
        b=ER6PFOPP010WouYa3HIF+7XcJwzBW4TbuwgYVJ7FHW3NrJ/4N+MMueKyBWN780sQNF
         XiFnHDnK84aldTtZbalkkytAv4OATiFxqlUhW3XtYmaun4IVolUg8l+GDdoO4XxBKYsV
         azSggxpJmqE/pUSqOdS1XO6U/Y9aFM42xPp1Z+JKftqn53tG8x2/ABKXeAGnoSxgfDvC
         uRIUb9gp9kcJxic2jeAl2513/A6LjAMzaMZVspKgpNRpPkrsWd9oCy1iHm+Gs2yWhjuf
         Etbsa34akC/+55dbtFEzM9oqY4ek8vFwQQEfWrYZ6502kns97tF4ZJrPxHzGJp3o4hqA
         vy+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0fkTzQw7CuoexVf+vJ2fL1KYVdIjLfvi7oDKwjDWdn+BbQ1AWWFE76mjqVn/8F0W0xUf4sKfC7+qG7g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxtS2vpkbTPEi9OIhPip+9yElmvG3QfEDSR7DbNKRGQDagvrWN/
	D9UlRSoWOl+ngUcgDczTTPALtd1Nk0QCnfUBldKUO1/s7GVJPAzOYq62W9eHIdMfk1RcT+Rex5h
	ggDOEvGHjlYg56FpLM0zIoQ5E/YtIguUbNvDQB7VE6f7dIWoLWXvwLaAVjQAbjxtklQ==
X-Gm-Gg: ASbGncu0xN0DBwcZPGUq6sYwL1aVKbBMokxm7Qa0WH1Pgk21509RGv9/zDdEvS5euJJ
	4ZAiat4sdnoGwhX+yuNsNz18qO7UqWH1JTRN/8Pq6CpICVAopzqS9EXRU087sFSUGSpypB8u5ow
	tOOL+5XjHrfHXo5n89zJbULNzy4WODqVVaDlxyiWqrdmEbqdyNFl9+nUrWykXYeGXCwntVYQK5W
	TfNW/eidmiK+j6Y9UjC0a4FJak5syi1z8q4UDftwxx1lxSpM1qu54c3w+CDPiP2SFCze+pO/UCS
	AOrMcft8mJ2+ZO0200M7AqBdGPdgoBCaFXs=
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id
 ffacd0b85a97d-38dea2e8252mr5537697f8f.42.1739438275346;
        Thu, 13 Feb 2025 01:17:55 -0800 (PST)
X-Google-Smtp-Source: 
 AGHT+IEvdEpVIGWCwTdkiFI9VeLvCiv6OrrtGDZTcFYpY+kBOdDZTqd8HRvUuOkaOwq9itdXLKF4sg==
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id
 ffacd0b85a97d-38dea2e8252mr5537666f8f.42.1739438274976;
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccdesm1314704f8f.26.2025.02.13.01.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Message-ID: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
Date: Thu, 13 Feb 2025 10:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
To: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch,
 b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, donald.hunter@gmail.com,
 dsahern@kernel.org, edumazet@google.com, herbert@gondor.apana.org.au,
 horms@kernel.org, kuba@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-ppp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org,
 stefan@datenfreihafen.org, steffen.klassert@secunet.com,
 wireguard@lists.zx2c4.com
References: <20250210133002.883422-3-shaw.leon@gmail.com>
 <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: 
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EAGh2EWb8PB6zM6wvlztsJFQn41w5TxJ56vLa2v6ccw_1739438275
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: ZSQHITGFI2SPOVJQHIVWOV4NWH5V65JE
X-Message-ID-Hash: ZSQHITGFI2SPOVJQHIVWOV4NWH5V65JE
X-Mailman-Approved-At: Thu, 13 Feb 2025 10:25:35 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZSQHITGFI2SPOVJQHIVWOV4NWH5V65JE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 2/13/25 9:36 AM, Xiao Liang wrote:
> On Thu, Feb 13, 2025 at 2:54 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
>>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
>>> index 523025106a64..0f7281e3e448 100644
>>> --- a/include/linux/if_macvlan.h
>>> +++ b/include/linux/if_macvlan.h
>>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
>>>
>>>  extern void macvlan_common_setup(struct net_device *dev);
>>>
>>> -extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
>>> -                               struct nlattr *tb[], struct nlattr *data[],
>>> +struct rtnl_newlink_params;
>>
>> You can just include <net/rtnetlink.h> and remove it from .c
>> files, then this forward declaration will be unnecessary.
> 
> OK. Was not sure if it's desirable to include include/net files from
> include/linux.

I think we are better of with the forward declaration instead of adding
more intra header dependencies, which will slow down the build and will
produces artifacts in the CI runs (increases of reported warning in the
incremental build, as any warns from the included header will be
'propagated' to more files).

>>> +extern int macvlan_common_newlink(struct net_device *dev,
>>> +                               struct rtnl_newlink_params *params,
>>>                                 struct netlink_ext_ack *extack);
>>>
>>>  extern void macvlan_dellink(struct net_device *dev, struct list_head *head);
>>
>>
>> [...]
>>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
>>> index bc0069a8b6ea..00c086ca0c11 100644
>>> --- a/include/net/rtnetlink.h
>>> +++ b/include/net/rtnetlink.h
>>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>>>               return AF_UNSPEC;
>>>  }
>>>
>>> +/**
>>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
>>
>> The '\t' after '*' should be single '\s'.
>>
>> Same for lines below.
> 
> This is copied from other structs in the same file. Should I change it?

https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/maintainer-netdev.rst#L376

In this series, just use the good formatting for the new code.

Thanks,

Paolo

