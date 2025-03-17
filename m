Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20253C28B30
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 12:41:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C5C3816CB
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 13:41:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742215274;
 b=y1VBc/nXEWufcBaU9h3vIddLFcchurD5T2XAyhYu171lXaBQ4zd0cqfLF+A+YUbgsW7M7
 I0gqldanhi/HhMgBgWcGA9MohfLq+3j79dDReAKLhpUkL70bXeJ3nPvAjXw1wOIi2G2IQlS
 NDCXeZXurME1+ueMG4Lk3BEE7G9gfEI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742215274; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9JLi6mjRKPSWr6p66pnw6OZi0C4VrzRLi4rPEARGF2E=;
 b=PtE+b56yxl+zNGecKRJq3QSNxUU3qDXKnl1vxuLpVVXvAvZN7C0HG0N7QCJv1gd/xVmH5
 jCc58O41ks5Fwd1c+h67mnYnhQ/6Au02h4MmoZHddqAYVrVCN7BjWbWo7qyRiw9WOXm7Oah
 Xv2xZ5bzJAXTsfSo4CTNKhXcfSNXZ9Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mandelbit.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=mandelbit.com;
 arc=pass; dmarc=none
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E4E4B84394
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Mar 2025 13:41:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742215266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature:autocrypt:autocrypt;
	bh=9JLi6mjRKPSWr6p66pnw6OZi0C4VrzRLi4rPEARGF2E=;
	b=gYBp5+YxUYALf+7EW1VXffkgrEUQjIHKc/9hHgFyzf6Oa2HdfbBJInJSxT4u+cgyvAMvef
	/x/oLx2lZdiiZGjePBLA88kYlGFHkSSzahz0btu72Eb/KrHmylLYvDYRfsrQITSNWmUSkX
	016WTX7SUL7U16VHn+faBbutoUJ209o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mandelbit.com header.s=google header.b=j6+JpqKO;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of antonio@mandelbit.com designates
 2a00:1450:4864:20::42b as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742215266; a=rsa-sha256;
	cv=none;
	b=vh5KbM+1L18tfAOaMhT8BZRAkMtTapZ9f7A/ietVfCpQ3kcZ5lu4tlpckjnLRVzNeBri6H
	WDsG8f09qJ/UeWLnhpLaudm0/dCk0g1zYrdoMwsxjHlVumRtMwBh6Isg04+dtJsifPjosp
	AppnEHk5EiSjUx/X0E+dc5xbUbauz9I=
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so4105300f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 17 Mar 2025 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1742215265; x=1742820065;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9JLi6mjRKPSWr6p66pnw6OZi0C4VrzRLi4rPEARGF2E=;
        b=j6+JpqKOw6Prc6rkyaXpc6a6Hr7CNX7CtV60W5zZfhBcKY5i+sIkYVZC5UTwIZvQrr
         JxaVwKD9Kz2qU/JW9lvhL5K8tYPaOZ8jXpPvSyn+gRDHsETcClvjmAWmT+SOUqaFztak
         oN6dSHOOSIIjTBBAmD6v9TsaLm3FloVFetGj2O/te2pC9ywtKDLuREweII2lTzo+Nns5
         kauWAotBlIy1Q+Yl0vjeOc1WRT9qc+lVTrOPKr2TNCZsRP2ByEAPiAlNWFfLteAckmnl
         C1aXX9TuyivRqdRD9mr1XE5/+WEoYyi2Wp5tcoTRdRVa5+6e6OzzyhrjRgFvQS7YImcq
         yicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742215265; x=1742820065;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JLi6mjRKPSWr6p66pnw6OZi0C4VrzRLi4rPEARGF2E=;
        b=GO73InFddhmF+QkbXQbwCUHUQfftPCKGkltXW2QqqGXYpEo0PHUIVo2s85RoaeHxJZ
         jQmblm8eJ+EwL/exHAbpd9sb11d7rt+zy46iQzgj84OriUYbRox7hkV34EyhO8W7dWgU
         d4s2tEKPBfTY84hRHwD4hEm6eRjCdT/UXYATGjXoOScMz+iEtXcJXfQvoyRmSya/O7oQ
         TSQAxkCCvWzdUex/QwSXSF0JSqrq9lItxd5cbdfnDCEAOa7hWoZz/Y5xe48BmY61+whG
         3HbPzFRgpqtsPmSpaF/wBmpGV3UoxEM/EEoBPpGv2JAIof+WrS3/2ppn0vB0gDfIzi1x
         xUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6wwU6NplYJ/MqgDNqJnxb5GHHPpTGMl76n7LMP5fpQnEAuYUgf5sIg90s+WviBEGfmxSQ2pVcLRnVwg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yw4lZPD0sR6E9A/69bCYvsZqfeX+kZHIu1CBGTC82nYgHljf7DR
	fqp8EPrO7ee1RaqWIJpi/T9sBwy5gSGThbrbr8bzq1hsA3QCNuTVrk3ggZuZAZjT15PMltN/dvM
	Z
X-Gm-Gg: ASbGnctb+maIatEpLnducMTAW51S1VBTgrUHU9/Ev9fAIkqmi8UVyBSA2TP8kc3G7lc
	hP6ErD97n4ikV8UsWfT9l5XHF3MmE9EjIE9/77bU/AOqQPDwUNQGJnRTWumep8fS5exygIM3myl
	2BjcdgRkaEQEVWxvpCkBMtu5w7L2by1jxX4EqYdzrf4wYgLnKzTqVSv7WXCUVV9lBljXm6lfkbo
	UurbSNVRk9zTJVBufWdaQ6yNlp26/H6u33Eeiav5rP74uqbVUClrmjyKObF0ZJpytE3GT43h40C
	TXSpfrZHlhYGUdpeKjnWSZgR6/b/p966SWdGqY/G2c631upQjr2cj6mwvB68Y2mapwphN6Pam/1
	dt8ks/thX9qkcX9esa1bO
X-Google-Smtp-Source: 
 AGHT+IF2P4AEW2tJbSYZHb2cnE7bnLVQ+p7Iydh5zydI/9yRywAFvlebRA3PSZF8VpwGQmp9UEVpEA==
X-Received: by 2002:a5d:64c2:0:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-397202a1acemr13749277f8f.37.1742215265142;
        Mon, 17 Mar 2025 05:41:05 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:23e9:a6ad:805e:ca75?
 ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df385bsm14694385f8f.4.2025.03.17.05.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:41:04 -0700 (PDT)
Message-ID: <880332a3-b227-40a3-b6c0-3e3955be73e2@mandelbit.com>
Date: Mon, 17 Mar 2025 13:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] batman-adv: no need to start/stop queue on soft-iface
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20250317105434.17545-1-antonio@mandelbit.com>
 <5871015.DvuYhMxLoT@ripper>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <5871015.DvuYhMxLoT@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: UJ4FDJOFM4TYTD2UROHTCZTFPBXZFMEW
X-Message-ID-Hash: UJ4FDJOFM4TYTD2UROHTCZTFPBXZFMEW
X-MailFrom: antonio@mandelbit.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UJ4FDJOFM4TYTD2UROHTCZTFPBXZFMEW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 17/03/2025 12:16, Sven Eckelmann wrote:
[...]

> Applying: batman-adv: no need to start/stop queue on soft-iface
> Patch failed at 0001 batman-adv: no need to start/stop queue on soft-iface
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> error: net/batman-adv/soft-interface.c: does not exist in index
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> 
> 
> 
> Might be related to the fact that soft-interface is now called mesh-interface.

Yeah, it was based on old code.
v2 incoming.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

