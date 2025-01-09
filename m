Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD76E77199
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 10:15:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4429F8402C
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 11:15:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736417702;
 b=pQpa2fuLfICAypp1wCgLJ5WVaUZemtIw42wZT39D5OurwH4XK/s/4QPdUXr+AMOQZTPvv
 kL9iKiok5NEjzt1bMC8WUCAmMuEK+MrqHa5aJe2x+IqKDxhCUKsf5pOS1d4IoTmEWOMUjpt
 s+gJUyIdGCkSPClnURgupvKYnQtuv5U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736417702; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=86sncF/jT14VebpC9sLpron8SM1Z0MJ3KMXVFBBGIZ8=;
 b=n+/4LAeJB9dxJTRf/WuBnsa7H6fppPwjr6ZDht7eqh2pR+1r739BeDufAS7Xty7bdo+3E
 0vZFLW6TL2ljmyFQcovCq4hvI+Pz5MwWdCZdGf8ZLTmrWSk1/CVLQjC8JS4eqeUdBhrwBaf
 OP2YyjDv5IOGLXsXwfParnTsT3oOzfU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5B00081619
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 11:10:52 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736417452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=86sncF/jT14VebpC9sLpron8SM1Z0MJ3KMXVFBBGIZ8=;
	b=GMpmIIeMOnYTtyxFJyYFDuC21IkO4YdkqWqb+OiX7puLP7hzZL6v4KgsSCcVzBQP/MxYyk
	SRxINQaSsEBt3Ud6QO8V4DyYOZigiOlFXA7d0z/UMXtGuUIV0lpYR/lmVgqZjYWrbl/9U+
	N/+l7SwMZsCe+GkuF6ACTvegumBwqgE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=jLlXsEIR;
	dmarc=none;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::b29)
 smtp.mailfrom=andrew@andrewstrohman.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736417452; a=rsa-sha256;
	cv=none;
	b=x6fEfP+EjETpKcPOsFMklWD1+usWP29f/DmekceI4p3TGNPrBKd9TA/EcWvHUpOdlqk7g6
	76QnpvOMFrOJmFdsZebHMM8ctQ5rzMlWIRJOOxiN4wBTXqlBYgb16MeXUPY/N0AohDbcnU
	peDpR8qNaz/z9aFpzF4VPWlMCJYp28k=
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so949380276.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 09 Jan 2025 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1736417451;
 x=1737022251; darn=lists.open-mesh.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86sncF/jT14VebpC9sLpron8SM1Z0MJ3KMXVFBBGIZ8=;
        b=jLlXsEIR+Y2y9VI+9CAlFGcz40K67mdIL57eewsBgtEN9KNxsGBbALHXgJjMZ7wYIk
         xzxoAm8r5WxnusZZo2i8vTL5MF6Uc7GLlO9bVlx+y4kuoV8m52r8s4hlSmOEdLH6WIIP
         ypgc8a1s/HKwBhlRaBWUFKlNprhx6bFfhqMfUaUdRYGZ7hcgki4ROWBQP1o/KO0TJeh+
         MluxJFkETo7eRJ9ZbVglaxpWpchMic81dBDcdsjP3JTZ/4Fzy46yCimY9h5to8FItjAB
         L2+LzaIVbtW8Wd42YgBZh/w9MMcR/IigUnJG9ut81vmWAiI/4jl3qCunO9ph8svaA4OV
         HW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417451; x=1737022251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86sncF/jT14VebpC9sLpron8SM1Z0MJ3KMXVFBBGIZ8=;
        b=qZeUwCfl49jb8Yw9LR25/M2Ln7rRRDY8zndKOxU2Bad7YFwojysprjKikTaWsLwx2l
         u1dLWXtLQ03kTYLXF4+AgI3TZr21FEdFZllYFpj4SwiN1NAQphpX7vrgNz2mDHXS32NC
         CSkW2PdW9xpNk0AYaC74PIZbgKoxvuUilJDLmHpDAmcpDpq0P0naxoi+/KhT8CoR6XPk
         QA4NnUa0p5/TEdFw0zEpIg43WWOD4z4Qn9i/gr78WN7QQjr8+IolH9t/zIPafRbHKBhy
         HaVNCCJYoQbKa/n0ZLzJnTpUffhO5OLAHAD7NBG8xTayksPKl8R2+plC9GKx2SVKP2WP
         ksFg==
X-Gm-Message-State: AOJu0YwPO/L6Z2AbKTnCmXrkntGP28pr0mP/epV806DhT7Pq7syQ73js
	6hkeSSCFL3XcF8rgQp/Ai7GKIaXqTHLpSGgcLA8Wi91w9XupmufjYBwIMUDVCQ6ilaZX3mHVyVQ
	ig1YyB39/9LAltLFuM/snDORA0+b5wzZaPRnJDIns2VxniAQXWHE=
X-Gm-Gg: ASbGncuIzm9o52uI3Y77/WHge4TJ3H4UYiEWNgsKLveJJXb9BraecQQ6ETUuxKeZblK
	u9GfYRHFUF/+vv2pY0DAUrNDw3LlMsOQF8u8I3w==
X-Google-Smtp-Source: 
 AGHT+IEyR+qu4wEBA/cXkd0ujgO/9Mr/FdjIPIcp2k3daWrV58mL+KjzZsNp4kAoEfZXsEYm4LhRkeBBfSXEjrGJDsc=
X-Received: by 2002:a05:690c:998c:b0:6ef:7640:e18a with SMTP id
 00721157ae682-6f5312dd1a3mr50620917b3.31.1736417451048; Thu, 09 Jan 2025
 02:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
 <1882889.atdPhlSkOF@ripper>
In-Reply-To: <1882889.atdPhlSkOF@ripper>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Thu, 9 Jan 2025 02:10:40 -0800
X-Gm-Features: AbW1kvZvnIau5WGAbALmlGrDKCGVSfk3ifgF2X_ZxeGucYhOG03HetWYvlVodmc
Message-ID: 
 <CAA8ajJkhd=CaNoqZ+juKHh8PV975s_vEfLU4xLfwn-Yj+caEPg@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: andrew@andrewstrohman.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: TKQL2357FLHUTKONTH7QBH76MMC2PS4F
X-Message-ID-Hash: TKQL2357FLHUTKONTH7QBH76MMC2PS4F
X-Mailman-Approved-At: Thu, 09 Jan 2025 11:14:44 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TKQL2357FLHUTKONTH7QBH76MMC2PS4F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,

 Thanks for the review.


> I am not 100% sure how you build batman-adv but when you've used the external
> kernel module then you can use [1,2]:
>
>     make EXTRA_CFLAGS="-fno-inline -Og -fno-optimize-sibling-calls -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining" KERNELPATH=...
>
> to get actually useful backtraces. Unfortunately, compile time checks
> sometimes need inlining and compilations fails or some kernel configurations
> with '-fno-inline'. If this happens to you then you can at least try to use
> the rest of the extra flags.


I'm using openwrt. I'll give this a shot.

Thanks for those links. I completely overlooked the devtools section
of the wiki.
There is a lot of good information there. Thanks for writing it all up.


> Please add before your Signed-off-by line following extra line:
>
> Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")

Will do in v2.


> I would prefer something more explanatory instead of adding more conditions at
> the end of actually interesting checks. Something more like:


I agree that this is better than my original idea.

But this got me thinking about the unlikely scenario where the soft if
netdevice is
destroyed before this work is run.

Do you think that's possible? I can try to add delay in the work to get
this contrived sequence to happen.

If this is a problem, I think grabbing RTNL before the check of the
soft inerface and
releasing RTNL after calling batadv_info() would fix it.

What do you think?
