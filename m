Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F0E77197
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 12:47:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2F9EA84277
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 13:47:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736426857;
 b=edEHf/Kji88CR+/2hx5AnZ3TFVPQHVODhB/r1pzljC+FKlud5t/GULbocs+B+2ne4eVL3
 +Tig1zaWnUVuGPMdmzCXeT4C2q3EI0xE4q81j3oqdHkEKYK27cKcHR2fQ7CX+GXxSfTT08s
 mwCSiDe8NPLizS7GGyFdJiIosvsL1os=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736426857; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ChbER8aalSxrj4FhTqplVeVstqIATrcTE25ntRw0EkU=;
 b=V1sy2YH4Jy/N25Gqgcd9Iupubjblm4IpEKbbSWeCMsXdBtpg7ZLZ9A5LVubotbwGT6jDF
 LjbocB5o495PXT+2X+OUmqrMtKrEJGSMyGp4mdQwdjCblMA2DzK4XeF5Az2o2ffQ8l0gnaO
 puwt8gss6NGXtCtpazq2wXA4bIEImO0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C996F81D4E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 13:47:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736426838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ChbER8aalSxrj4FhTqplVeVstqIATrcTE25ntRw0EkU=;
	b=Jt0je5feLNTr1o1A8DGVTeI9r+nzEnKlMz76Gp45o8zR/VeNNNCphpuAG0En0FfaC430+V
	3ZIjj+aV/qGqbobj3g+XxUo+stmc4LU0s1GXAvQ2i3u0cR+5LFp1Y+STBCEaFq5zH7wZwt
	Df7UimdKbYBhVxevfPtd0F5Fe8RQCMs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=JPKJLc4j;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of matteo.fortini@gmail.com
 designates 2a00:1450:4864:20::32a as permitted sender)
 smtp.mailfrom=matteo.fortini@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736426838; a=rsa-sha256;
	cv=none;
	b=X04Qlamz4pheiPnSmoc6MBxb0JCrVZrffp/VY6HHC3Ac9q6img09oGv9HV6H1oYOnpbMw0
	LuT5fA5gLo+fFisjmQNthhPo6jCLwZRu2hd+qiyLs+KaHLyaIiVZQh8JP3I1ojAaN/nXae
	UUy8Zc3fmA515RIZUrchQgriGuRM3Rg=
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43618283d48so7081135e9.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 09 Jan 2025 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736426837; x=1737031637;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ChbER8aalSxrj4FhTqplVeVstqIATrcTE25ntRw0EkU=;
        b=JPKJLc4jx/0iR4XDYGkSzf7rqwu6hpdgmRDIokmSErlRxSrx7xdA25rzMdU93iR/ub
         EcBIRGfpKlz8KxlbMCATZIcTVxK3cvan52i7iKCBc0sdtwi1hL6t8PDdxkimjA3HAeA+
         b+amJE+Md3rgeibMt0sJ1Ws7EvKBcyF71Rf2gYS4IEVuaxJHTNBHT8P24WZyr7AkmKBE
         t7PGEgpPeAbH0a7qb/McQUF1BKBuiXGjA4QDZlDX6Mw12QNyM1ZfFX9Mb9B+f1pJzwSM
         ng8M0ef0gvI7TGd/bqae87vibB0Y99BbPZmkL5ATPyxvsrKeDz2xOpFwVfAI5pFI088x
         O+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736426837; x=1737031637;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChbER8aalSxrj4FhTqplVeVstqIATrcTE25ntRw0EkU=;
        b=qtvSxok2QfoKKnRIjVsaPnx1O7t7CyiM+gKApZTMZrxxQrLzdx7Sad2oqCTmb9rMiV
         tG1x9HOJ98SibJRUMikfGcR/aSajJezPAblYwWRVhqOpDIeGTPe3ieLKp2iI+L/gLEDH
         ZVyxbtugykXUZ8NAozzkplH/LXzmEE7Ue8FtkbgXaDSkEwgJ9YKHOITSaCWk9ceahGNs
         HFrz/0jsve5jtP1IiJIgUXFdHewfQKYlqqUDd3WW1jhJpHLskmiRUmfdqFQkGv0UPJmq
         zy7uioWdIxx7xP1ANzxdKVnOILknKcgaqndB+FTiNsP+MViTW/GFCGNQaD1NG1ZSyJk/
         u3Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4645YhKKEe9Vux5tzEPAf8RI5ebvUvdz+80PHYnY7/Fqu4y3IvnIHkOxtQ3st6m+yaQwN31m2tITNpQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yw1v4m0BvhCLAvyuW2pV+96eecVM2cgQOmATA8SetgXRxv/QojG
	aN84ffzSkXJrBKnJkhouowLxZKvrCesvpKJ2/5ReTu5ZMUeo+WSztuDcfA==
X-Gm-Gg: ASbGncuEjD/EVBMoawjzobgQECbCTkysXAVdI64mJe8x52ndLaWNNlvlktTkjxAt4Jc
	R3saaekqIlF33Y4INxyTibLwBZ2nkOLshWiGz7w8/iHVsMb5j1mphP1FUf6VtN7VDGwnnCFuy+S
	LEIA9vCBv7xQCR0SnvHqLsMMP2fiKsCGiBfoAFDyvi44sizlWkGdc27YFwpPzKENRk315Ksc9Bu
	Nft3SXK2+jAK7Dg0liLe+rpEQYrpIqLjs5VqOMdkJRUzr8Ul9Nq82aW7Akd1nKPlFBCiDprpHkS
	uN7uM4dXFUTB
X-Google-Smtp-Source: 
 AGHT+IEvTM53j+lDSWbYeGxsG2TfuiOgDw8bpzcvoPZLsuncL5w/+5mCd+ikICIngixIG12lHWGjsQ==
X-Received: by 2002:a05:600c:3584:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-436e26f4ef4mr56151775e9.29.1736426836831;
        Thu, 09 Jan 2025 04:47:16 -0800 (PST)
Received: from [192.168.99.198] (77-32-84-83.dyn.eolo.it. [77.32.84.83])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcc8f8dfsm59474515e9.0.2025.01.09.04.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 04:47:16 -0800 (PST)
Message-ID: <25c252e3-3478-4d0f-80b9-dad7ae604df4@gmail.com>
Date: Thu, 9 Jan 2025 13:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [SOLVED] Re: Multiple ARP replies for same address on openwrt module
 6.6.69.2024.3-r3
From: Matteo Fortini <matteo.fortini@gmail.com>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
References: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
 <4646493.cEBGB3zze1@ripper> <219e2ebc-af2a-4704-9ac5-8fe97b65c4f8@gmail.com>
Content-Language: en-US
In-Reply-To: <219e2ebc-af2a-4704-9ac5-8fe97b65c4f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ULSF5YL6KWAHF5F34LLKQNUL4MNTHGP7
X-Message-ID-Hash: ULSF5YL6KWAHF5F34LLKQNUL4MNTHGP7
X-MailFrom: matteo.fortini@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ULSF5YL6KWAHF5F34LLKQNUL4MNTHGP7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Turns out during some updates I had re-installed mesh11sd and, even with 
default config, it was messing with the network configuration in many 
ways. I found it complaining in the logs at some time.

Thank you for your support


Il 09/01/25 12:32, Matteo Fortini ha scritto:
> I apologize, the issue is still present even if I downgrade everything 
> to 23.05.
>
> I don't recollect having modified any batman config. Maybe it's been 
> sometime since I hadn't tried a nmap
>
> DAT is disabled, I've always had issues with "incoming packet with 
> same mac address" and that was the only way to make it go away.
>
> Here's the batctl mj output on all batman nodes.
>
> {"version":"2023.1-openwrt-7","algo_name":"BATMAN_V","mesh_ifindex":12,"mesh_ifname":"bat0","mesh_address":"02:00:06:aa:00:00","hard_ifindex":16,"hard_ifname":"m-11s-0","hard_address":"b4:4b:d6:22:55:1c","tt_ttvn":6,"bla_crc":24857,"mcast_flags":{"all_unsnoopables": 
> false,"want_all_ipv4": false,"want_all_ipv6": 
> false,"want_no_rtr_ipv4": true,"want_no_rtr_ipv6": true,"raw": 
> 24},"mcast_flags_priv":{"bridged": false,"querier_ipv4_exists": 
> false,"querier_ipv6_exists": false,"querier_ipv4_shadowing": 
> false,"querier_ipv6_shadowing": false,"raw": 
> 0},"aggregated_ogms_enabled":true,"ap_isolation_enabled":false,"isolation_mark":0,"isolation_mask":0,"bonding_enabled":false,"bridge_loop_avoidance_enabled":true,"distributed_arp_table_enabled":false,"fragmentation_enabled":false,"gw_bandwidth_down":100,"gw_bandwidth_up":20,"gw_mode":"client","gw_sel_class":50,"hop_penalty":30,"multicast_forceflood_enabled":false,"orig_interval":1000,"multicast_fanout":16}
>
> {"version":"2023.1-openwrt-7","algo_name":"BATMAN_V","mesh_ifindex":13,"mesh_ifname":"bat0","mesh_address":"02:00:03:aa:00:00","hard_ifindex":18,"hard_ifname":"phy1-mesh0","hard_address":"86:af:ca:1a:6b:3b","tt_ttvn":37,"bla_crc":17083,"mcast_flags":{"all_unsnoopables": 
> false,"want_all_ipv4": false,"want_all_ipv6": 
> false,"want_no_rtr_ipv4": true,"want_no_rtr_ipv6": true,"raw": 
> 24},"mcast_flags_priv":{"bridged": false,"querier_ipv4_exists": 
> false,"querier_ipv6_exists": false,"querier_ipv4_shadowing": 
> false,"querier_ipv6_shadowing": false,"raw": 
> 0},"aggregated_ogms_enabled":true,"ap_isolation_enabled":false,"isolation_mark":0,"isolation_mask":0,"bonding_enabled":false,"bridge_loop_avoidance_enabled":true,"distributed_arp_table_enabled":false,"fragmentation_enabled":false,"gw_bandwidth_down":100,"gw_bandwidth_up":20,"gw_mode":"client","gw_sel_class":50,"hop_penalty":30,"multicast_forceflood_enabled":false,"orig_interval":1000,"multicast_fanout":16}
>
> Il 09/01/25 11:55, Sven Eckelmann ha scritto:
>> On Thursday, 9 January 2025 11:31:06 CET Matteo Fortini wrote:
>>> I am noticing random unreachability of hosts in my network, in
>>> particular if I just nmap -sP the whole range.
>>>
>>> I traced it down to ARP poisoning, and the source seems to be two hosts
>>> running batman-adv which are claiming the same address.
>> [...]
>>> issue is, 02:00:06:bb:00:07 is not the right node and the host is
>>> unreachable. The other MAC is the right one.
>>>
>>> If I clear the ARP cache in my source host, then the remote host is
>>> reachable again as it gets the right answer.
>> Might be DAT related. But I am not sure of it. Can you please add the 
>> output
>> of
>>
>> $ batctl mj
>>
>> to see the (batadv interface specific) configuration.
>>
>> This might be helpful for Antonio/Linus. If it is enabled, you could 
>> also try
>> to disable it on all involved hosts via:
>>
>> $ batctl dat disable
>>
>> Just to see if it has any influence on the behavior (to see if there 
>> is any
>> ARP poisoning in the long run - not to solve the intermediate problem).
>>
>>
>>> The problem started after updating to the 24.10RC series of openwrt.
>> When you used 23.05.x before, then this would suggest that it was 
>> introduced
>> somewhere between 2023.1 and 2024.3 (or OpenWrt) somehow.
>>
>> I didn't test it but a quick check in the sources suggest that the 23.05
>> batman-adv sources (from the routing feed) should also work with 
>> 24.10 - so
>> you could actually git-bisect openwrt routing from
>> 6afc0452c2534ed0bc65b59b1fb6fd74439ddf27 to
>> eaa4aba30b017de66bece8ef9d3dde5299fc787d
>>
>> Kind regards,
>>     Sven
