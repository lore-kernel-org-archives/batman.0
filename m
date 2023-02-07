Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DABC636CD
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 09:03:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ECA6E846DB
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 10:03:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E99D28075E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Feb 2023 10:03:05 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675760586; a=rsa-sha256;
	cv=none;
	b=TCsXUeWZOB1jOg1iqwE5JtcMcKzhuKLODeQU+HMO02udBe9LHvzzf+hF2WYmPQ1iKuuZsk
	LSQNVWTIMk8Dmt7K9cAlYb0hbDlHR7R7oHmgADsntVymLm5UlCASW2L8pazsY/O0RV5msz
	fn4xBhePsl+5/V8uBCzDd7wS1DqA+N4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ifr2F1s5;
	spf=pass (diktynna.open-mesh.org: domain of leon@kernel.org designates 139.178.84.217 as permitted sender) smtp.mailfrom=leon@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675760586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=e7+oYHc1/Mwz658nNjhMv1Lm2K8COXUo7g4bzMYQuOk=;
	b=owsftRApaHmn7YOfl4KctTj+lzWLs9vpc/7kIC07njKZBn8HzChOB04v/MCCLDDP84iNmR
	PETuisXLUa5aWaghpYBREJ4xjbI+1P7WD/L0yJQZ35xolw9z8l4e2SGyirOQipbMR76Sh/
	68aVgHW0Ej0Yi4r3uFktSKFcvpdoTmc=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D368461234;
	Tue,  7 Feb 2023 09:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B477CC433EF;
	Tue,  7 Feb 2023 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675760583;
	bh=XuwzWbuiv9PRXatJlaU27ApwiZpspE+xfbUMrMdXr80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifr2F1s53Be1i3fzNmU6/bW9QYAAdeGiOmVZijr3sG7Ir7aciUOrou7tJkmbAiuY3
	 SgS3d7giy19onhBPQNUAKmYnmVcnFn0B+F//XYtLK1znyvGAzAlM8pBWUyvEUZO8p9
	 3M/rF5fNruo86Sh6GqwuyfLg/GWK/AfJ6w9jN3PyzeZDuZCEjXFIS9p8c3KBbCji1F
	 zq21e3lSQ5WDxMRtX3GH+IoBa32fhhvJEnp2lVjyLvV1mgOO9WKlbFdWNee1lQYWXB
	 bBstrC28YASynsKtxXqd2Yx3T+fCfgPQH8gHejiPiGYe0B1ElTm5VrhTQkBt0WvibF
	 xx7/7xAOGN+ag==
Date: Tue, 7 Feb 2023 11:02:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Message-ID: <Y+ITwsu5Lg5DxgRt@unreal>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
 <Y9wEdn1MJBOjgE5h@sellars>
 <Y9zF/kEDF7hAAlsB@nanopsycho>
 <8520325.EvYhyI6sBW@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8520325.EvYhyI6sBW@ripper>
Message-ID-Hash: RR3PVTT2MLHVVEV6USJJOYLI6OLO6UTN
X-Message-ID-Hash: RR3PVTT2MLHVVEV6USJJOYLI6OLO6UTN
X-MailFrom: leon@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
CC: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RR3PVTT2MLHVVEV6USJJOYLI6OLO6UTN/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, Feb 03, 2023 at 10:38:07AM +0100, Sven Eckelmann wrote:
> On Friday, 3 February 2023 09:29:50 CET Jiri Pirko wrote:
> [...]
> > Why kernel version is not enough for you? My point is, why to maintain
> > internal driver version alongside with the kernel version?
> [...]
> > >Also note that we can't do a simple kernel version to year
> > >notation mapping in userspace in batctl. OpenWrt uses the most
> > >recent Linux LTS release. But might feature a backport of a more
> > >recent batman-adv which is newer than the one this stable kernel
> > >would provide. Or people also often use Debian stable but compile
> > >and use the latest batman-adv version with it.
> > 
> > Yeah, for out of tree driver, have whatever.
> 
> A while back, my personal opinion changed after there were various Linux 
> developers/maintainers were trying to either remove it or wondering about this 
> bump. The idea which I've proposed was to:
> 
> * still ship the "backports" like out-of-tree tarball with a module version - 
>   but directly in its "compat" code
> * continue to use in projects (which for whatever reason cannot use the in-
>   kernel implementation) a version which represents their upstream backports 
>   tarball + their (patch) revision: Something like "2022.0-openwrt-7"
> * for the in-kernel module, just return either 
> 
>   - remove the version information completely from the kernel module 
>     MODULE_VERSION + drop BATADV_ATTR_VERSION + modifying batctl to fetch that 
>     from uname(). But of course, that would break old batctl versions [1]
>   - or by setting BATADV_SOURCE_VERSION to UTS_RELEASE (+suffix?) or 
>     UTS_VERSION
> 
> 
> But this wasn't well received when mentioning it to Simon+Linus (but I could 
> misremember the persons involved here).

In cases where you can prove real userspace breakage, we simply stop to
update module versions.

Thanks

> 
> Kind regards,
> 	Sven
> 
> [1] https://lore.kernel.org/r/20201205085604.1e3fcaee@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com

