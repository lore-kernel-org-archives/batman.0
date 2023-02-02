Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B31C61DA4
	for <batman-adv@archiver.kernel.org>; Thu,  2 Feb 2023 18:44:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0D34684540
	for <batman-adv@archiver.kernel.org>; Thu,  2 Feb 2023 19:44:39 +0100 (CET)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F1BDC80223
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  2 Feb 2023 19:44:11 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675363452; a=rsa-sha256;
	cv=none;
	b=K9I85l1daTCLeRe+9GyC5Y759on2q5mqwEi/kC2bvsKYd3rHfiJpqDlYZoBVXN+wZTo6Yc
	kgzkmhOzyu4BQ3Sv+Hc1cGc6F6jawC52nRJD3NKebcgRxQqTqilcCVNjyqOT0U2d1+vS2K
	Vnd7y2h1zaendjl2iHA9G8JQAvPo+oU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no SPF policy when checking 2a01:4f8:c2c:665b::1) smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675363452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJxb8YUvR6cmrLqGCxuADrHC1iU2bH8LF+hCBLW9wOw=;
	b=Yr1y/KGKmi0XVTM1bdkXVlmEZozhfm4ngu/4+48oUwLQTI4yaFaYbJWpIrvlvkOFXYbEDq
	I7AvmfLeQbk/ZKG79fEjRtcxhGtiH5uqanNl9FZK4JktZfQRRrkjw601myUv4oaoTrTQXt
	IN90Is4mWTOV+zXELijDMBRYCn6xMjY=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5C9D417DD;
	Thu,  2 Feb 2023 19:44:09 +0100 (CET)
Date: Thu, 2 Feb 2023 19:44:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Message-ID: <Y9wEdn1MJBOjgE5h@sellars>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
 <20230127102133.700173-2-sw@simonwunderlich.de>
 <Y9faTA0rNSXg/sLD@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9faTA0rNSXg/sLD@nanopsycho>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: QL5LQV5RTU6HHYL4YQKFLZQGKTY3WPEN
X-Message-ID-Hash: QL5LQV5RTU6HHYL4YQKFLZQGKTY3WPEN
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QL5LQV5RTU6HHYL4YQKFLZQGKTY3WPEN/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Jan 30, 2023 at 03:55:08PM +0100, Jiri Pirko wrote:
> Fri, Jan 27, 2023 at 11:21:29AM CET, sw@simonwunderlich.de wrote:
> >This version will contain all the (major or even only minor) changes for
> >Linux 6.3.
> >
> >The version number isn't a semantic version number with major and minor
> >information. It is just encoding the year of the expected publishing as
> >Linux -rc1 and the number of published versions this year (starting at 0).
> 
> I wonder, what is this versioning good for?

The best reason in my opinion is that it's useful to convince
ordinary people that they should update :-).

Usually when debugging reported issues one of the first things we ask
users is to provide the output of "batctl -v":

```
$ batctl -v
batctl debian-2023.0-1 [batman-adv: 2022.3]
```

If there is a very old year in there I think it's easier to tell
and convince people to try again with newer versions and to
update.

And also as a developer I find it easier to (roughly) memorize
when a feature was added by year than by kernel version number.
So I know by heart that TVLVs were added in 2014 and multicast
snooping patches and new multicast handling was added around 2019
for instance. But don't ask me which kernel version that was :D.
I'd have to look that up. So if "batctl -v" displayed a kernel
version number that would be less helpful for me.

Also makes it easier for ordinary users to look up and
compare their version with our news archive:
https://www.open-mesh.org/projects/open-mesh/wiki/News-archive

Also note that we can't do a simple kernel version to year
notation mapping in userspace in batctl. OpenWrt uses the most
recent Linux LTS release. But might feature a backport of a more
recent batman-adv which is newer than the one this stable kernel
would provide. Or people also often use Debian stable but compile
and use the latest batman-adv version with it.

Does that make sense?
