Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8062CCD4F54
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 18:25:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF8EB83F0E
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 20:25:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780079117;
 b=NwuO1gDajqYf1riggK0H3ojsqx3lhe0IyonjymFy8cbCMHhlAMCbd7+xl05Abu19epDuf
 wtu0sAd9l0otqo4TAt6sQ0UjvxiB3kVwaAi7sjry3tTalvGNin2FrSOTHknf4zYKMaOkbK+
 8IYyoNQVOSzuE1LA1wG+Uzlwf4c9W7I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780079117; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1sjeWKVlflwMhfQsa4hT1/XP4L2DOWkP9sxkSpmoiwo=;
 b=gd3l96beLFq99KHcckzl1UNU/zVSFpSbarUmLkTBT48FlONNZrkTPdSYPpqVWPU2QHM+O
 O2FpkB2uSfjWM3+Fx2gmztRibnUAe0XGUReDQ44kNI10ZD9FFqLehG3V2pj1PGczoinf/IM
 XNVhtFir4h6qc7TI2XA0xU5I0nQHuwM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0A291807F7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 May 2026 20:24:34 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780079086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1sjeWKVlflwMhfQsa4hT1/XP4L2DOWkP9sxkSpmoiwo=;
	b=DeDOR23f2JygVHdFHWrNlLJ7o0z384Bwmn4qQwJ6PHqzMAFUxqTR4z9+fn+PKXdOoUL7HG
	xsqZeeVtcPpRZSfxX5MLgJlBFyeS+NufdQQbroQzm+xavW4xcw9p5jfKgl+WzFotRzKFy2
	xeC8N4UHe2FAycMgR5h9avAQedu0FLs=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780079086;
	b=Lddos15YKzIrY08EfqlKO93GzSJOOdYjlPXNjMO4SURIy6Ufr8NVi1G0yA70Jb6LAa0ph9
	br+K9rFc5p+ptK6oHnOHgfnermd9PPRPrmTin3IF/ZtZcx/0WGYl0muBllLLTF5GTp7x1X
	EWtMtuwlfGQONQ67ISxZg8uXiKB3F00=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="S/uLafvG";
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B51B2401A2;
	Fri, 29 May 2026 18:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451521F00893;
	Fri, 29 May 2026 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780079071;
	bh=1sjeWKVlflwMhfQsa4hT1/XP4L2DOWkP9sxkSpmoiwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S/uLafvGPP+MzTCzEVTAnr/zB5MenAak4E8xYpBW8ZtOqarDyEax+MTsH1cOvIwh6
	 qMitNDOsYq9Siyip9meHkKULmwA2t6V9YRuTcWfLpSE6QhoTV4ex+YLpboF0xxTcWl
	 30Jmz7WnVUYAAPGEByzcjf/KLovs9isztpCKWIugIHlRUm4syhPqnTDLPT+2SCWGQD
	 zQtcoWSCEStKui9jiUsio+ziu4+stWkHfHwYcZ9HwVwZFlwLoPraaXng9NDDZyW6JV
	 yLUnOFMWns7KUs4T5mb1SNF+RBEhWPz0nFNPVhP9hQRgzeELOxMN9jUSTi8Py7+r0I
	 nYswPRYMw59VQ==
Date: Fri, 29 May 2026 11:24:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Message-ID: <20260529112430.09c1a08e@kernel.org>
In-Reply-To: <5075322.GXAFRqVoOG@ripper>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
	<20260528142924.329658-2-sw@simonwunderlich.de>
	<20260528171412.7a60e8f7@kernel.org>
	<5075322.GXAFRqVoOG@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: PMYJSSKVXWCGPNDVSYB2XYXI7WW7QQBE
X-Message-ID-Hash: PMYJSSKVXWCGPNDVSYB2XYXI7WW7QQBE
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PMYJSSKVXWCGPNDVSYB2XYXI7WW7QQBE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 29 May 2026 09:06:56 +0200 Sven Eckelmann wrote:
> On Friday, 29 May 2026 02:14:12 CEST Jakub Kicinski wrote:
> > On Thu, 28 May 2026 16:29:10 +0200 Simon Wunderlich wrote:  
> > > +#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE  
> > 
> > What purpose that does "linux-" prefix serve?
> > The unwritten rule is that the OOT drivers have to append something 
> > to their version to distinguish themselves. In-tree version is just
> > the pure kernel version.  
> 
> We don't have a real preference here. If you prefer UTS_RELEASE only then I 
> get rid of BATADV_SOURCE_VERSION and just use it in both places in
> version.c
> 
> https://git.open-mesh.org/batadv.git/commit/?id=8cc63db2462ad7d3ee213059025bf5fffe2e7982
> 
> > To be clear, definitely a move in the right direction. I hope we can
> > move _all the way_ in the right direction, tho, without still defining
> > OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION  
> 
> version.c and version.h are there to not recompile more parts of batman-adv 
> than necessary when the linux kernel version changes. Has nothing to do
> with OOT. If you consider this a no-go, I can also just place 
> generated/utsrelease.h + UTS_RELEASE in the three different files.

Ah! My bad, sorry for the accusation! :)

The re-compilation thing is annoying but it's solvable.
Please TAL at commit 3f9ed5f5aa9ecffd2 for inspiration.

Thank you!
