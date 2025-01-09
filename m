Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BED2E77199
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 11:32:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7CB278426C
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736422378;
 b=TB6BxzX6e5af7OLKDH1yL5s3xTq9fNL3Xk3RH9wHqKmOE20rfmKR62phCOPaxqI0Rr9d0
 xAbitTOvQDAOXjtzlu95qOYBlAd4RgAOP2QiykNOl83U4Ur0ypR//xlhFFU22tPQ/eEj+js
 gWn7HzNHTY0860QIPH+bSZQfOmhKpPM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736422378; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Pg0TCbv6nUZ2tgLRqRDcmEXX4dc5+tHga4DQd4eogMw=;
 b=UVV3X3wXfAb4rJDSVI3tiG+KUfQgFmTKEfkdgflOnLQZYhN/gnCbYl0vvUcSA3sVBybkz
 QwI+Z/ATbEb3gQeXbe60U2+sgiuKWzraDkGLZaWlHWrPmdP2hFPk/TCj1YTlsvVANUFZb9x
 p4slrIi3w4pO22y5OGIKAllpw6NFrag=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D319E82482
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 12:32:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736422360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Pg0TCbv6nUZ2tgLRqRDcmEXX4dc5+tHga4DQd4eogMw=;
	b=DpIvGgAa9HUdIwe2gCFHchl5qusdbbu2zaqaOJ7vU8451oDxFe3NVxPyzOt1RE4W68aYtZ
	VYHyZg9HaVfvO8RopToHglg9kJXAWB92yxwtPF10yPBoKJP3+o7TfIXhnYGuLdJ8dDyc2g
	D1dVpP8nPoGe9UMqSAps42jUawrXLDM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=ND65Cqv8;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of matteo.fortini@gmail.com
 designates 2a00:1450:4864:20::430 as permitted sender)
 smtp.mailfrom=matteo.fortini@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736422360; a=rsa-sha256;
	cv=none;
	b=ik+M3GZvQX+XziM0hOpzdZWulSrjNi7JHhB1GP38At1zcnV0Rsa6jBVFjR0QE6+Ygl+YyY
	kC+TFv7No7c/hX6Xtd3IUhL4HE2TME3CCytxTU3grCBtb29Oh2pXNwBr0BlIoILqmY0Bbu
	zZ6YYktlg6a7HV8fHt7RpKeCwEj1XzQ=
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so492619f8f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 09 Jan 2025 03:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736422360; x=1737027160;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pg0TCbv6nUZ2tgLRqRDcmEXX4dc5+tHga4DQd4eogMw=;
        b=ND65Cqv8EsKy1qoft13htzbXdCxheiAtOtycLIzPsqHfHVzOeAfM6uQogS7SHuzBQN
         z2cosWTy51r52K+tpqjzyy5kG+bOHqim0vzlU1nIifpCChk+/6+y2fsT+AHpJnSWT3Si
         I6n3oVYRXXMH7NqtmZXmwEu6e2yVk5Ww36N3WbQaUAy3moI35xiDEZnbiOn7rGYuhsO1
         xhKlLxKJIeLbn2M8dPH8uT0DYRToTtOkMNxbZxhZxCuc+NxldRZbOCE/lHxMWlOZOx9l
         eJKXiXlEj6MYtnK9iskdRZO0SBLscSvKmmHs8Jx83qv4HNXOE5fbeycNn+UsvkgoICq2
         fZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736422360; x=1737027160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg0TCbv6nUZ2tgLRqRDcmEXX4dc5+tHga4DQd4eogMw=;
        b=YZGNHyqZd7GFqQVAEy3K8k8duTbGmeFl/zHzyZzdSWzuxuMgd3bC5Dy595fPx0yU/5
         1J3nfB4fbbGny0RuhEWeWwd7/pOSBGBKL8dL/vDysFjDmtRunFgnsO7j9dAyBamOvw69
         8NsZ88qf7PjLeonGXxSvuI0n8pobhfJSEN53Mxq32CzEgaSznNXPZ3yxWAx+K4jsQbB4
         CRMGbHAAcozcCKAxbcyZIHTsh1fSJVvgrJ7nDxLreB7LrJyEZGyeZqNmY/W4ih9S6tzX
         SR6JPpyN9t/Y3UhBUGh92EFYi9C+npxCFoqzli1S5gFsHFdFcA/bFg1kYSEJQNFfsVDg
         C7Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwtUBbFEBISOJ7M0pr0AeWlLs0RdUGiksFdrv75e9SeVjqilV8f+f0WWeBPczxtWGwqEw44gFMiefUzQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwGYWUkMgRfq5dVRH2e2IqXmALpSqxPtBTiqfxRTCkk+05CEWz2
	oFVTI3RqyikqHLCaR8ZuQlsOLhTNEO3ImYlyp1m+QHmRVPJ1J5W8
X-Gm-Gg: ASbGnctk64jOAvt3feZV7OkS8/BMvk6Aexl+eaKGGLxrZsZIFitQpAUmbVKBUQCRoVq
	YenEQ5LFa1UH0OafcW13AdWvv7Z/7XW/auyhdDZ02h45XycR3HlN/mft5WTDP3j48A6E9WTioZ3
	/A4RKnBN8lTGzaJ6eZCGWN+zrJCtbffS8S7uxoVa9AB//2knnrmzeCTkYRweGf++IEuHpg61VNe
	hZL37E8G/NsRXYlGtfVgJ2tIiy+QkR1mYg1Jxm97H/4if85/dKuRxzZbjNSRVNcABmmWNOFoslf
	8SjXEnVZbOGn
X-Google-Smtp-Source: 
 AGHT+IEXlo89HO4170HOBg9wPuElumKEHwJwMrPawniNfuNadNWItgDdFAf87sKmiz1ppsLeOhoG9w==
X-Received: by 2002:a05:6000:1883:b0:385:ef14:3b55 with SMTP id
 ffacd0b85a97d-38a8b0ee755mr2011315f8f.19.1736422359963;
        Thu, 09 Jan 2025 03:32:39 -0800 (PST)
Received: from [192.168.99.198] (77-32-84-83.dyn.eolo.it. [77.32.84.83])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3853b6sm1564758f8f.44.2025.01.09.03.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 03:32:39 -0800 (PST)
Message-ID: <219e2ebc-af2a-4704-9ac5-8fe97b65c4f8@gmail.com>
Date: Thu, 9 Jan 2025 12:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Multiple ARP replies for same address on openwrt module
 6.6.69.2024.3-r3
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
References: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
 <4646493.cEBGB3zze1@ripper>
Content-Language: en-US
From: Matteo Fortini <matteo.fortini@gmail.com>
In-Reply-To: <4646493.cEBGB3zze1@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: EHDWXVYCR2CJXUZKW24DGGKAOHEWLWNN
X-Message-ID-Hash: EHDWXVYCR2CJXUZKW24DGGKAOHEWLWNN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EHDWXVYCR2CJXUZKW24DGGKAOHEWLWNN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I apologize, the issue is still present even if I downgrade everything 
to 23.05.

I don't recollect having modified any batman config. Maybe it's been 
sometime since I hadn't tried a nmap

DAT is disabled, I've always had issues with "incoming packet with same 
mac address" and that was the only way to make it go away.

Here's the batctl mj output on all batman nodes.

{"version":"2023.1-openwrt-7","algo_name":"BATMAN_V","mesh_ifindex":12,"mesh_ifname":"bat0","mesh_address":"02:00:06:aa:00:00","hard_ifindex":16,"hard_ifname":"m-11s-0","hard_address":"b4:4b:d6:22:55:1c","tt_ttvn":6,"bla_crc":24857,"mcast_flags":{"all_unsnoopables": 
false,"want_all_ipv4": false,"want_all_ipv6": false,"want_no_rtr_ipv4": 
true,"want_no_rtr_ipv6": true,"raw": 24},"mcast_flags_priv":{"bridged": 
false,"querier_ipv4_exists": false,"querier_ipv6_exists": 
false,"querier_ipv4_shadowing": false,"querier_ipv6_shadowing": 
false,"raw": 
0},"aggregated_ogms_enabled":true,"ap_isolation_enabled":false,"isolation_mark":0,"isolation_mask":0,"bonding_enabled":false,"bridge_loop_avoidance_enabled":true,"distributed_arp_table_enabled":false,"fragmentation_enabled":false,"gw_bandwidth_down":100,"gw_bandwidth_up":20,"gw_mode":"client","gw_sel_class":50,"hop_penalty":30,"multicast_forceflood_enabled":false,"orig_interval":1000,"multicast_fanout":16}

{"version":"2023.1-openwrt-7","algo_name":"BATMAN_V","mesh_ifindex":13,"mesh_ifname":"bat0","mesh_address":"02:00:03:aa:00:00","hard_ifindex":18,"hard_ifname":"phy1-mesh0","hard_address":"86:af:ca:1a:6b:3b","tt_ttvn":37,"bla_crc":17083,"mcast_flags":{"all_unsnoopables": 
false,"want_all_ipv4": false,"want_all_ipv6": false,"want_no_rtr_ipv4": 
true,"want_no_rtr_ipv6": true,"raw": 24},"mcast_flags_priv":{"bridged": 
false,"querier_ipv4_exists": false,"querier_ipv6_exists": 
false,"querier_ipv4_shadowing": false,"querier_ipv6_shadowing": 
false,"raw": 
0},"aggregated_ogms_enabled":true,"ap_isolation_enabled":false,"isolation_mark":0,"isolation_mask":0,"bonding_enabled":false,"bridge_loop_avoidance_enabled":true,"distributed_arp_table_enabled":false,"fragmentation_enabled":false,"gw_bandwidth_down":100,"gw_bandwidth_up":20,"gw_mode":"client","gw_sel_class":50,"hop_penalty":30,"multicast_forceflood_enabled":false,"orig_interval":1000,"multicast_fanout":16}

Il 09/01/25 11:55, Sven Eckelmann ha scritto:
> On Thursday, 9 January 2025 11:31:06 CET Matteo Fortini wrote:
>> I am noticing random unreachability of hosts in my network, in
>> particular if I just nmap -sP the whole range.
>>
>> I traced it down to ARP poisoning, and the source seems to be two hosts
>> running batman-adv which are claiming the same address.
> [...]
>> issue is, 02:00:06:bb:00:07 is not the right node and the host is
>> unreachable. The other MAC is the right one.
>>
>> If I clear the ARP cache in my source host, then the remote host is
>> reachable again as it gets the right answer.
> Might be DAT related. But I am not sure of it. Can you please add the output
> of
>
> $ batctl mj
>
> to see the (batadv interface specific) configuration.
>
> This might be helpful for Antonio/Linus. If it is enabled, you could also try
> to disable it on all involved hosts via:
>
> $ batctl dat disable
>
> Just to see if it has any influence on the behavior (to see if there is any
> ARP poisoning in the long run - not to solve the intermediate problem).
>
>
>> The problem started after updating to the 24.10RC series of openwrt.
> When you used 23.05.x before, then this would suggest that it was introduced
> somewhere between 2023.1 and 2024.3 (or OpenWrt) somehow.
>
> I didn't test it but a quick check in the sources suggest that the 23.05
> batman-adv sources (from the routing feed) should also work with 24.10 - so
> you could actually git-bisect openwrt routing from
> 6afc0452c2534ed0bc65b59b1fb6fd74439ddf27 to
> eaa4aba30b017de66bece8ef9d3dde5299fc787d
>
> Kind regards,
> 	Sven
