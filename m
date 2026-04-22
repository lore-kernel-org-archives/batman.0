Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B3BF9EDD7
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 13:47:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 49319857AF
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 15:47:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776865624;
 b=xU6+8ck2cXw2dwICBgb8WoqxRBOjFjuDg87wInXca02fM3/F6zVemVxpmQtBWk+73knh8
 BXt67WchYVDftc5juHHIqneAm+ws0w8yOXmw0jkza4MfZdJYUmyYIa9msZWIYO76hhahcSs
 BPnCu44D8vzPGXE+19/5FtR3KkhmM+g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776865624; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vGUN2lmQzglPKip/Yg8XUsGtRI5Zaiy6QOTEHVktYz8=;
 b=wpCCqSsZTJ+EzLBTJ/F4KzE+0h59/RYBaec9JU+51qGwW62dpFI94ahDGWGdRhBfl9w+T
 KcqF5D/sHC9aNSIk7BplORSNc4zc/iisJ9PP88XU2oLGkwxvkE8aJtiqWCD0k6TLyvmtGXx
 glovOhgEp6WhU6hpxX9FhxlQwyQZ5b4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=fuzzinglabs-com.20251104.gappssmtp.com;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=fuzzinglabs-com.20251104.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6627982382
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Apr 2026 15:14:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776863655;
	b=XMSN9+0gyQLSdFIlrKDcwDJVgHXa3xmYECqTlf3TUqjAazQET//uWzVVeFpLCW6jFUZzNH
	sQyugbUJg8Yd/aTqu8FEhQcGbrDNUDcRuplfk0T+mHewg9M97ILwif2cIaub/XKo4m85Vx
	B/IthOdpShG5Q5V80aD9K9tlVGtmQH0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=fuzzinglabs-com.20251104.gappssmtp.com header.s=20251104
 header.b="TZPsFl/Q";
	spf=pass (diktynna.open-mesh.org: domain of lbourennani@fuzzinglabs.com
 designates 2a00:1450:4864:20::332 as permitted sender)
 smtp.mailfrom=lbourennani@fuzzinglabs.com;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776863655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vGUN2lmQzglPKip/Yg8XUsGtRI5Zaiy6QOTEHVktYz8=;
	b=gYlBUKf4OoatrK4vIPhkaS/9QX6EScNjGwHi5/96JuI6FQquL38/mdepd9EMFRUZa8Y55k
	i4/AnoqRyI93nLaAg6SpNhvyVdKElonqRI86JRaxft9GqO0oYzazTGGFeDIdjvb7HivVte
	CbYrwMYillSzXyKO3AJWUPzACt3SsbE=
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so50361985e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 22 Apr 2026 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuzzinglabs-com.20251104.gappssmtp.com; s=20251104; t=1776863643;
 x=1777468443; darn=lists.open-mesh.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGUN2lmQzglPKip/Yg8XUsGtRI5Zaiy6QOTEHVktYz8=;
        b=TZPsFl/QntfGZtmtUvxVuB8x5YrRq2NathI6AywSkFGGXfx7iZRB5SNxEWF9EbGTZW
         QRYcd+jIMqKIJkp7qp8Wu6nZX/0v197+VQ/H2aG/v/lMbljGH6xWzHuONIG0uCzYwB7f
         NdqQFRC7+vYNqiW+V+jB6J3SV9F6tw0seH4uvrRFPpxLLuqCKQVOccafNQIYquZJHbP6
         eN7GSxZ5IiRMVkntCaNiMzV7NwR/zTTm8D+sTDhlXAIzZqqgxjvwXonPqTY0s8o5rwZ0
         xtpUu60rR9RR1wu6UqQJ7QgSYIFehEbPQykZ1uTa36WzPHxlJs+88t9DYhxCf2w/pV++
         3Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863643; x=1777468443;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGUN2lmQzglPKip/Yg8XUsGtRI5Zaiy6QOTEHVktYz8=;
        b=ny2wKK9/MLcAFSHwc8Z7EKxQKBLs1t9LuJGrloZuiSswEoP3OOrMYoYcy8LM3135Gn
         TJUHb0SxgLnxhud/MUlQMUVIJZGd7ex1aME4vrUajFC0tqErjAjeDZmcZ92cHagyKKTd
         lpk4ba3UeV10WMnvl94pZvRLQqADQ7VgZpV2xcSTjKCNoJUi0jxJYAxJvd4EzDAKLpsg
         8Pc5sXz+3pj5whFfU2p5TaNLPSwhbwaAngSheaeudMScPUzjDYRHrlGbtVUDqEC4XKD/
         iWRSVpNiTRnDI9mbFQmiO/ANqp45el61vvfqk+PcUGIMBkvuGCDOXRlsLIUwW6pWRZ/D
         fhZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/thrKRExFoBzo1TRA4e3p/3txQ1dDDPgUln5ysIGm3/+1RFp0kP0emBA+vhlCH39IPZOJlYb/pQpwv9w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyc1plQnOaf08RMP//XHtyUXR6ISdfqvPeWDq8SLU5xqr185q6i
	YuiVI4/wTWC7UxKDiDwPyv7Tljj7XEgM2QBnXgtM30/Xh8eCGeDPiSI34s82tDaLkg==
X-Gm-Gg: AeBDiet8tEXmGL5zpS6+b8F+yc43OxoGXLC9QQ/+FeNmBq1NBQSZNjVpayVp+Zx741i
	22nYdX2c+7dubttwO4IJEz2TNJ3kZ9RkFE14jE6o9FGXZV3K17uiOyvplCG6iPB71wM5Bg0WTVK
	bqaEd5ApWk789q8lmRxisu1mVOGFRoAwRDjE3tgDbxpAxMzIjj5tRTs7uS41a79hXWSB8I4lwIj
	68+n5mFPubrS57Z4RuZmLuIONk3fkb+IVkXkk1RQBsQFPN1jRvJqcXHgwpCztwXy4PQQTDGc17O
	a48xvQ9LTBVQhQARZp7SP9Yd9aIvLvtm4V+EGdZdWNeLIVPvY6wLVYAJUX/nbUEAKOfOO+1Ek1T
	w7rmYx5uRExyuJtIVVN4M+ACGA8HUvKfb3v24uitWm96ueVGRHnsL5IS2wM5aXQ4pWnXJu5MKMg
	a8qTLZjD7xuWDDKi87ZcX0zUUFD3U+pyoZ9AA/A0jIDsl5+x//Vi0weitWRZJp55WljVgumtO6w
	SIUssUJXcI5Nw==
X-Received: by 2002:a05:600c:3ba0:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-488fb73a089mr350402955e9.5.1776863643345;
        Wed, 22 Apr 2026 06:14:03 -0700 (PDT)
Received: from [10.99.0.195] (82-65-122-189.subs.proxad.net. [82.65.122.189])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm466942045e9.10.2026.04.22.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:14:02 -0700 (PDT)
Message-ID: <409410350c4ba7ae81136e1355d029d2a61be404.camel@fuzzinglabs.com>
Subject: Re: [PATCH] batman-adv: fix integer overflow on buff_pos
From: Lyes Bourennani <lbourennani@fuzzinglabs.com>
To: Sven Eckelmann <sven@narfation.org>, marek.lindner@mailbox.org,
	sw@simonwunderlich.de, antonio@mandelbit.com
Cc: apinson@fuzzinglabs.com, security@kernel.org,
 syzkaller@googlegroups.com,  b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 22 Apr 2026 15:14:01 +0200
In-Reply-To: <4755009.cEBGB3zze1@ripper>
References: <20260421222022.21231-1-lbourennani@fuzzinglabs.com>
	 <4755009.cEBGB3zze1@ripper>
Organization: FuzzingLabs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-MailFrom: lbourennani@fuzzinglabs.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 2GGIDSJ6XWL7Y6QKUM7KFFYDWO3NRW3U
X-Message-ID-Hash: 2GGIDSJ6XWL7Y6QKUM7KFFYDWO3NRW3U
X-Mailman-Approved-At: Wed, 22 Apr 2026 15:46:34 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2GGIDSJ6XWL7Y6QKUM7KFFYDWO3NRW3U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, 2026-04-22 at 13:38 +0200, Sven Eckelmann wrote:
> Overall, it is unclear to me how Alexis Pinson <apinson@fuzzinglabs.com> =
is=20
> part of the chain. Lyes Bourennani is the author and Lyes Bourennani subm=
itted=20
> the patch. See the documentation [1]:
>=20
>=20
>=20
Sorry for the inconvenience, we thank you for the help and the guidance.
We take note of the documentation and will do better next time.

Regards,

Alexis and Lyes
