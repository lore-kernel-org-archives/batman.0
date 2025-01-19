Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD430C02183
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 04:28:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2718883E06
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 05:28:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737260927;
 b=sHZNpD0ry/4wbr5c1yJ0rkjU/FDMyvkpw/k7isj8aZ+2BJ/LuN1LHFuN9KDnC6ORFIqnr
 HNiklGatDu3JUa0YuHeq99torDQ45ljij/D3D8Ka+wX/5Y+zuEbRIDNBGLWKE86T5YveCxl
 4Sqz0gSxXUCdMncTPOcV+wzr8KUPxFk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737260927; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0iWx5QZ/j3iuIncyF2acDBzwwYd4olk4FBdRzPKOI3M=;
 b=Kk4eHn7c9M8G2DRpmLAeXIfp+6/xV61f6gIEb3iHSbP+VEGTGXrCEmT74YUQoZTtHudjK
 lswYEmGXVQH/HErWPvDN5WOKIymVMTH4I/biOZFR/rpHcYCz6tf+MhJh+6Kggfmd5zzdO96
 CKiP8UNIz/BQeL2MN0Gn7sKUGHioPWk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 23161806CA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 Jan 2025 05:28:39 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737260919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iWx5QZ/j3iuIncyF2acDBzwwYd4olk4FBdRzPKOI3M=;
	b=A8SW/pUQSyAH6ULuNhhvWztBo0YlJHrf0jrCr8lgX17WLrwvY8lQtupR0RmFrV4vbpEAGR
	p3R6iijcVOm7a+wDCRRSgNMAr31I0vjb+pifdRq1hxaTc0GycWE8P76Z/O/3/JdtqXP5Br
	LDrYARn/Hr72zwiacx7DQqJNtGJv5OI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737260919; a=rsa-sha256;
	cv=none;
	b=yCsWe+u4XAhbfLm1Bs76Vxr4ZAkXGoESZJsAhTRtzOSSD3mFrZO7k9aNP16veltZPhx5WA
	ejj2/2NBoFKud3GGaWwqQ2eaDslR/uT9O5bC2jcKe1+JCHzvQD/jUmjHnv/PcVW96JyhiH
	/LK2GwnvCM2Fm8x/Nn5wovwiNcie3dE=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 97F1454C82F;
	Sun, 19 Jan 2025 05:28:37 +0100 (CET)
Date: Sun, 19 Jan 2025 05:28:32 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Andrew Strohman <andrew@andrewstrohman.com>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?utf-8?B?UmVuw6k=?= Treffer <treffer@measite.de>
Subject: Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link
 metric
Message-ID: <Z4x_cHIYD-7sihlj@sellars>
References: <20250118003528.6843-1-linus.luessing@c0d3.blue>
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
 <6131569.pqZb4hCDXM@rousseau>
 <CAA8ajJnwrAidkea_tVDvRxJy6T_bJ9VQDKq2FW4SSdJfZxYKqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: 
 <CAA8ajJnwrAidkea_tVDvRxJy6T_bJ9VQDKq2FW4SSdJfZxYKqQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: CBPENFLOXN6U4O5OB6ZIYYHKNEC24IDE
X-Message-ID-Hash: CBPENFLOXN6U4O5OB6ZIYYHKNEC24IDE
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CBPENFLOXN6U4O5OB6ZIYYHKNEC24IDE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Andrew,

Thanks for your feedback!

> Currently, that means tx rate / 3 (which is an under-estimate).

I think if I recall correctly this was intentional that the
fallback typically under-estimates. Generally speaking better to
under-estimate than over-estimate for a fallback mechanism which
uses a worse approach. The tx rate / 3 fallback is more pessimistic
by design.

> 
> This results in my network perferring 2.4ghz paths when it should be preferring
> 5ghz paths.

Makes sense from the original design idea. The 5ghz radio does not
provide us with an accurate expected throughput from its
locked-up, hidden rate control, so we are better safe than sorry
here and under-estimate it.

But shouldn't this also mean that this patch has a high chance of
fixing the issue in your setup? With this patch you should get a
higher, more "realistic"/comparable estimate for your 5ghz radio?

> The problem is that throughput calculation method is not consistent
> across radios.

Full ACK.

> 
> I know that both these methods of throughput estimation are trying to estimate
> the same thing, but they are implemented differently.

ACK.

> There implementation details
> can result in a bias to over or under estimation.
> 
> I'm suggesting that we make an effort to make the throughput
> calculation method consistent across radios. More specifically,
> if one radio doesn't support sta_get_expected_throughput(),
> then we shouldn't use that method for any radio -- all radios
> should use the same fallback mechanism.

This one I'm not sure of... different radios can still use
different rate control algorithms. One radio might prefer to use
higher WLAN bitrates and tolarate more loss. While another radio
might be more cautious and might generally use lower WLAN bitrates,
to maybe achieve less loss.

And I'm also wondering if that would result in the wrong overall
incentives. Should vendors who give us more useful information
really be punished for that, by us falling back to the method used
with the worst, most locked-up vendor?

> [...]
> In my case, I also found that sta_get_expected_throughput() delivers
> over-estimates.

Or the other one under-estimates ;-). Another thing to keep in
mind I think an expected throughput measurment would be closer
to a UDP than a TCP test. I guess your measurements were with TCP?
On WiFi UDP and TCP throughput can differ quite a bit, at least
from my experience.

Regards, Linus
