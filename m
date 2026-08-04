Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0671C55ABA
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 19:52:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E50178405E
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 21:52:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785873134;
 b=SXMFzbADQ7g7hX4hJ8QGUQkrkQLs+rAhp0+KoxQg2yJGTZCkRZolfET8J6LeXuzvHgYvZ
 NhELs06IUBeU/PT7Q4kWruN5NShOwT/Mt9qcFZN9VHWAPdodgyW/KA8ZQUV0a+Wy7rVKT9C
 spY4kNA5SbLYN9GnlrGyYGlg3VcMzSw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785873134; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
 b=3dKKTtDZw+FRFfUP67thuRhU6Fg8mOinWPauwa/AkWgXt2uzy8/YpP5uXFWyRLHLxWgeJ
 fFHAE4NHUC+IePreT3a+kSl6MrcGW7jrlxMcNjydl4FoZX+pMV1kxFaSiZmiunXrk+CtfZ2
 lXT6EePGapPOiZrN2u/Y2+6kJbQTrPg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass header.from=redhat.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C850481271
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 20:32:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785868358;
	b=XTPcfsso6Kx0Ew8AhmINp+xxag1r3NfTVUQ/VB9aIhjqtN+VKX2VUiIPxpeAW5J/CDE7/P
	e2ZHl52CIwFU2UINgEWdzwdPnTF9u5QJSo8tD1yMXJ4H88YxMRPuOE+TD90ZMR2LlyMof4
	aQrj3h+GULIk/Ae043Uya5OE7GhdCR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785868358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
	b=PJ7aym6rfc+XkC03yPEAHgesujD2wbBR9AfhuYZ4w7oeoMN8j2IRyrWVKoiCuPrDcwrqCP
	oMcQAJ3kZfRgeUNRt+1GGqUkcj1ACTn/vpqmxZ7H1QWlAiMm3iTnyK6OMs2Tzn6KQ8VkMg
	fSrJMrHqlqHCVvGmrYindxf8/DIOgVI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aDgCd8P+;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.129.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785868346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
	b=aDgCd8P+SE/y1faczPg0I00IbNPB9FpA96zT0wNDZLLyJgllqOiaY9QkCF7u7+x5ceEz0e
	HEvtPZ69Z6OSLM94GsaVOegZXTa7/mR5Re8NKOPMmmGkBgvGhVgSN1ZUpabzcIzsmbgNPB
	bRDV7WtqoTmiJpqEdnyp7JsQmJsgFvc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-bWJZiXrcNx6bhMnvzdbYnQ-1; Tue, 04 Aug 2026 14:32:24 -0400
X-MC-Unique: bWJZiXrcNx6bhMnvzdbYnQ-1
X-Mimecast-MFC-AGG-ID: bWJZiXrcNx6bhMnvzdbYnQ_1785868343
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f83450a8eso109403f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 04 Aug 2026 11:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868343; x=1786473143;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
        b=M5JV3b5W0yeJIWcQYk6c3e8g7pSdfUOBqABXCEoAKmSiHYPyeB4kyPcn+ijwAAntPl
         yGV1kEmIJ5uGrfVOAJ/rGXeqScnBVHLwbntJ3QHmSg4P8D6lpkxL02tIivmjH4lotGr3
         rKvDMXGGezdIAHb0c0K40c/70wi1qwrFYDepbcxITiPrYltID+7Krtj6Bm52L+5IYExk
         q37ZD6rn8QLgSyCCNYbqB57ppHI2L71IS/D5l7wq3jT5JjbWr5t5MCrEIld8rA2Ri+Fc
         mXyGbelxHUHTeudMJhXlrcinP9EBZ8ovVPL1lmlsm6TH+X6m/mmfodVcOzNR7tO058aE
         ws0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvUYuYpWBWVcyfOSn1rU5wpLXXFnztaEpsOVnoD23WeoFhKHtjL2YbjbqWwQ2tv4uimOWxcvRCw1rdbw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzVajUlGLhlnr0Qjr8dwkXYTCAlroiFNZeo8QOKALv+B4BjzMrf
	LUgqu97AeiQULlOBXm/YIQaCG3F4e5q1OsXWIN7tpABT9nRC8t430efbk9hmMC4kcXNZEs86yeS
	TX1UTcb3J0//KQ15AEP401AMlf3DxHqjv1pcwTI72J0bKiKgdd6T5QA0rJk/B2bWd/I36fA==
X-Gm-Gg: AR+sD11pXRQC0PObQKPlrdtuyKl2JUeX3J3YOkQOPrsjEuj1luMFtvr3AUVlT3oN0Fr
	KYylggNpd5sRpXOvF4b1JkaslSlRb6yXX50UJXB0vGWItZApWomB5qC+BaWw/Ljwkxq/QkcLgAy
	bo5zh+MxDaMwq9OnH7FeaTm6XizLUHZ+Y+IrdvMuAfSH47SbGDHM/VTb6NOo/vo+LQYeqJm8/X9
	1wyMB+5O68hZe8grjy12nbBj69vEb1Rv4ixW0tbL9E/V+H2F/vjRyynyxA9mCcEWYjAmhd87WH2
	DuHcDgdqwEHWSZTQ6I20c2SE+YWDNEOptcDiM27CLO8pbqa00obQvdC8FU3I3utctfDt01pgD7V
	LpkAquUb45W4mgomYwsR2GWuPbCRFrOPFZ/UpPVTXOOgzSZcHdQQqAPELuYZSy3ESPoVqpxM4be
	Q=
X-Received: by 2002:adf:fec7:0:b0:47e:81aa:3832 with SMTP id
 ffacd0b85a97d-47fec519ff8mr1867050f8f.16.1785868343479;
        Tue, 04 Aug 2026 11:32:23 -0700 (PDT)
X-Received: by 2002:adf:fec7:0:b0:47e:81aa:3832 with SMTP id
 ffacd0b85a97d-47fec519ff8mr1866989f8f.16.1785868342939;
        Tue, 04 Aug 2026 11:32:22 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it.
 [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23e5efsm1936070f8f.27.2026.08.04.11.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:32:22 -0700 (PDT)
Message-ID: <dbd0dc17-d097-4254-b6f0-59eeb6e69579@redhat.com>
Date: Tue, 4 Aug 2026 20:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Sven Eckelmann <sven@narfation.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>,
 netdev@vger.kernel.org
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <5248054.31r3eYUQgx@sven-desktop>
 <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
 <4072288.fW5hKsROvD@sven-l14>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4072288.fW5hKsROvD@sven-l14>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zl2dU_N-gSqhNSCj3qDNeSWVFpEWQwvkoKii7zUdTLI_1785868343
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
Message-ID-Hash: PHBJYZ7VTJ2B5N7J3HEQIUHV6WBLWOYJ
X-Message-ID-Hash: PHBJYZ7VTJ2B5N7J3HEQIUHV6WBLWOYJ
X-Mailman-Approved-At: Tue, 04 Aug 2026 21:51:58 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PHBJYZ7VTJ2B5N7J3HEQIUHV6WBLWOYJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 8/4/26 5:05 PM, Sven Eckelmann wrote:
> On Tuesday, 4 August 2026 15:08:01 CEST Paolo Abeni wrote:
> [...]
>>>> Note that it's preferred to avoid fixes and stable tags for changes
>>>> targeting the net-next tree. If the fixes are really minor, both could
>>>> possibly safely dropped. If there is some real problem behind, such
>>>> changes should instead target the net tree.
>>>>
>>>> Can you easily rebase your tree and adjust the PR vs the above?
>>>
>>> I have a different statement from Linus:
>>> https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u
>>>
>>> This is why we started to not send out net.git fixes PRs for things which 
>>> aren't highly critical or for Linus' "just merged for this release commits"  
>>> late in the development process.
>> I actually think netdev preference is consistent with Linus'ask: move
>> the "fixlet" to net-next.
>>
>> The additional twist is the ask to drop the stable and fixes tag
>> (otherwise stable will be flooded, too).
> 
> I find it quite unusual to drop the fixes and stable tags - just so Greg+Sasha 
> have to use their tools to figure out that these were maybe fixes and need to 
> be backported? This already caused problems in the past and had then go 
> manually through literally years of changes (LTS releases!!!) to figure out 
> what was lost in the backporting process. Yes, the years in which it was 
> disallowed to use Cc stable@
> 
> But to be honest, I have no idea what "fixlet" means here. Is for example 
> https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260731023333.70727-1-heminhong@kylinos.cn/
> meant by it? Because this is for example something i don't consider worth 
> backporting. It is definitely fixing something but I never was interested 
> enough to do it myself when two or three other people tried to send 
> incorrect/incomplete patches for it and then disappeared after promising a v2. 
> Which at least makes me think that it isn't worth the effort.
> 
> But maybe you are talking about something completely different.
> 
>> PR are a bit apart from plain series, hence my initial questions WRT how
>> problematic would be stripping such tags and how impactful are actually
>> the things addressed in the first 6 patches.
> 
> Sorry, I am lost. There is stuff for which people have actual PoC code. Afaik, 
> nothing for an RCE but enough to locally be a minor annoyance. The things 
> which have no "Reported-by" are things which I have problems with on my 
> installations.
> 
> And about the others: The "bla: avoid CRC corruption due to parallel claim 
> add" + "prevent CRC corruptions after claim flush" were a problems I had (next 
> to another which was not yet posted to netdev) but has a "Reported-by: 
> Sashiko" because it was also reported by Sashiko when posting other bla 
> patches and I think I've stolen the example from the commit message partially 
> from the Sashiko report.

I'm sorry this is getting more complicated than really intended. The
rule of thumb is that real problems actually bothering users go into the
'net' tree, and other stuff goes into net-next without the fixes tag.

Jakub is actually the one usually more strict about the 'no fixes in
net-next patches' mandate, but he actually did not raise the point here.
If he is fine with here, I'll not insist.

> On Tuesday, 4 August 2026 15:16:54 CEST Paolo Abeni wrote:
>> Please be aware of net-next commit c82ff94592fb: the expectation is that
>> submitters reply proactively to AI review comments.
>>
>> Specifically it would be helpful an evaluation of how critical is
>> problem reported and if it could safely addressed with a follow-up.
> 
> The LLM situation is really starting to get 	unbearable. It is like cutting of 
> the hydra's head - it will directly bombard you with 20 more "and now for 
> something completely different" reports. But preparing proper fixes is now 
> also not ok... And at the same time, LLM tools are becoming a must-have for 
> posting patches and now I even have to start to write rebuttals/explanations 
> for these reports. I get why it is helpful for you do see comments from 
> authors/submitters about the Sashiko reports - otherwise you have to go 
> through the reports and figure out if it is unfunded or even already fixed in 
> one of the next patches in the series.

You are not alone in this painful situation. AI reviews are striking to
everyone. LLMs improvements make every day harder get "all green" reports.

>From maintainer's perspective the most difficult and time-consuming part
is assess the impact of the AI findings, especially for code
subjectively less-known. It's not a matter of simply reading through the
AI report text, is requires context information and analysis that should
be more easily at hands to the patch's author.

Providing feedback there really helps a lot with patch processing.

Thanks,

Paolo

