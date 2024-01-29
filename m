Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368FEC47DB3
	for <batman@archiver.kernel.org>; Mon, 29 Jan 2024 20:53:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 61114828CF
	for <batman@archiver.kernel.org>; Mon, 29 Jan 2024 21:53:24 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706561604;
 b=O3X1qiD1zpwIMoxwTqxbxp9lDYTKsc6n33EPJqrNsRt7CM7cdW0N4Aw3rBcmm6e1uOiRn
 9862VZfplUB09Enukb3uFrS9gEPLgsX+uVKY/mFB4WfzqzPwycIzZ5zu5Cd4hQ0ZBGjUaP1
 nwZP/lanqWtFexdkx2fsqF2gUX73eF4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706561604; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FqMMQHU4+t9DBVStojrhvzkVaD4RrxRtg9am1K3NZTI=;
 b=lQxX4Rw2KwbMhj5CystgfqwUi3wZ63Ed4ZMxXlP77K20vki4ybrsgCfAYoJd7C7mStAsm
 qMU/f8A7flRxkOktSK70AUq3KQnPz3ClMAhz+zaSghvU04hjDuiNgfmPfyP+SjD3hnZ0mBG
 s8dM2bUomb7Ikn9ypHw0X0/1X64CxLg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3AFF2815A4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 29 Jan 2024 21:53:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706561597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FqMMQHU4+t9DBVStojrhvzkVaD4RrxRtg9am1K3NZTI=;
	b=BzY3Ux04gfHRLongdrsIX2eYG/uTQvouxNjH9OEbzuHJAyrw6QbMmDT/0u7vNwP/hKrsMX
	wBgk46IYsaNHoRe6TqPCPzSnYVDpXEtvDp++K+C3h1CSyX28qweOlXq8sSZy0FRW7e9lU/
	Y4GMPpTHOsU1EoAXKw674i5r/blvzUc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=C65RZpGY;
	spf=pass (diktynna.open-mesh.org: domain of doug.fajardo@gmail.com designates
 2607:f8b0:4864:20::112d as permitted sender)
 smtp.mailfrom=doug.fajardo@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706561597; a=rsa-sha256;
	cv=none;
	b=p+gCq3u2pZDUP3zm56/gOg1TRLcndOyCZByk7uyPQSmL1b8frkMrrO+sTsReAP+vUidEL0
	JVS2FWTQ14I4rVInIXeleWNmb0vSuGj0w9sV4ogK4WfJfKa13kWhSvBdLQjy2ob1z1MLHo
	zEcQlQAkqGkQfhwlfs3tjZFip5kx61Q=
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-603c5d7997aso19754357b3.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 29 Jan 2024 12:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706561596; x=1707166396;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqMMQHU4+t9DBVStojrhvzkVaD4RrxRtg9am1K3NZTI=;
        b=C65RZpGYcpio4bRDV51aC0tIjw02d/HdXQ8iWlmgy+w9XxrpspinbMQQm0lBYDFfRj
         YiYxOE5JlDqKHmCAvvZ/aCUNqJI6HYgDEJKPl5YE+NUlwAgiErK+i9nu65GyuBtDjBwA
         PotQKW1EDEJLtk4bU6R458FzT2foMjtP1tbdWpL5zJONi+IGoxcYqDu38b+WZyROptd/
         xnJfei9DP3z9DYeh+REiuNVbMh4m5sIL13LyWV82kLVF9ttPx6xQBS6TawCtNFTJzOaN
         7PNvLeek/F0rSK6hf3OoFKwi6/qwbwW1D94r2UdkjMrBiFIKeyhZuSu7SjMof6ZQuD97
         KSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706561596; x=1707166396;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqMMQHU4+t9DBVStojrhvzkVaD4RrxRtg9am1K3NZTI=;
        b=QopYjfJRII9g2hbeYe+omE5UO2+VdlkY2m8ZBkxM67Eg+T2hYJ+jpLXxzdg1oT8Wzs
         FsWlCdROoeVkCsImYk47mjTXstmcn7nRWjAKrLufk6rp8vqUXaRE9t7xtthXx4T/5stG
         MjguIdrXecBMVEFD1c/3soyKQEj/OJtce3CD8guIGjaiV0HNE7KvgMcWCdqW+8cfwu4i
         tZZxbzya+VHsutAH1xVpKLuSiv16WuGR/DVS3h5g8Ny/rgN4MWOYAzuAGUBXnjHGAuF+
         x0fwiT3Cp4QZfT/sRZgi5ZOQyguI+2TDkzdlSPHTy3jB5eODG3F7pE72lKMRX/wVSYN3
         Sm6A==
X-Gm-Message-State: AOJu0YwGV/i977T73tqHIcqugj69JXAf2NfZDNz/aO7qZalPvQrTbZH1
	KiwzBGKN1OJv0A9H1rbfJoY1Hj6Iw5EMBHbnPGRqGOOrmdbii/aKV0UyqpHG
X-Google-Smtp-Source: 
 AGHT+IGSxZGeuGVVJ5nPXc34zdJbtax89sJfHLy5Z83DJeMwG9SYkfFtOl15jG+1nTWZD/pzii67bQ==
X-Received: by 2002:a81:4419:0:b0:602:cf62:6590 with SMTP id
 r25-20020a814419000000b00602cf626590mr4094732ywa.34.1706561595865;
        Mon, 29 Jan 2024 12:53:15 -0800 (PST)
Received: from [10.0.0.59] (c-71-57-181-236.hsd1.fl.comcast.net.
 [71.57.181.236])
        by smtp.gmail.com with ESMTPSA id
 j131-20020a816e89000000b005ff6c19a15csm2732007ywc.98.2024.01.29.12.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:53:15 -0800 (PST)
Message-ID: <70836e07-a1e8-46e3-8b57-f314bd63a1f2@gmail.com>
Date: Mon, 29 Jan 2024 15:53:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem starting A.L.F.R.E.D on batman-adv?
Content-Language: en-US
From: Doug <doug.fajardo@gmail.com>
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
References: <170648094014.1056.17522976996217024998@diktynna.open-mesh.org>
 <ZbcVQNKlNso0D9l9@sellars> <2fd7c965-3e7d-4919-9239-a64034f5dd21@gmail.com>
In-Reply-To: <2fd7c965-3e7d-4919-9239-a64034f5dd21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XPE6GYDTEUG6E6C7SUKITEAD52L6ZRCB
X-Message-ID-Hash: XPE6GYDTEUG6E6C7SUKITEAD52L6ZRCB
X-MailFrom: doug.fajardo@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XPE6GYDTEUG6E6C7SUKITEAD52L6ZRCB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On 1/29/24 15:03, Doug Fajardo wrote:
>
> On 1/28/24 22:02, Linus Lüssing wrote:
>> On Sun, Jan 28, 2024 at 10:29:00PM -0000, doug.fajardo@gmail.com wrote:
>>> I cant seem to get A.L.F.R.E.D. to start:
>>> doug@dougwork:~/sdshome/alfred$ sudo alfred -b bat0
>>> Can't start server: interface missing
>> I think it's complaining because the "-i" parameter is missing.
>> Try using "alfread -i bat0" instead.
>>
>> Regards, Linus
>
> Linus - Thanks for your quick response. I tried this,  but it didn't 
> work... Response was:
>
>    doug@dougwork: sudo alfred -i bat0 -m
>
>    can't bind: Cannot assign requested address
>
>    Failed to open interfaces.
>
> *** Doug
>
Uh, never mind - I just realized I didn't assign an IP address to bat0 
!  your solution worked.


Thanks!!!

*** Doug F.

