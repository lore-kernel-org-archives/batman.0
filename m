Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B95CFB43F
	for <batman-adv@archiver.kernel.org>; Mon,  7 Oct 2024 08:22:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D5D3E83E15
	for <batman-adv@archiver.kernel.org>; Mon,  7 Oct 2024 10:22:30 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728289350;
 b=Z2/7dS3xwZ4kqAn4qtb68TRqF2vCC9RIGOCj1BAD2M2wbO7C6z5sifrCa6hqD/WCk48/4
 jDV5cvcQg2WggoSAJ9QZjPa4WpR2BFsuHHPMl+l/fr1f4eex3F8nRoDNDeLDjl6hww963A0
 IbcXaKStuRSr3zmBUwT86RvJK2uYL+A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728289350; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sQvOnPFl4miAleHRljaFxDr9I5XCEBMa7UW6Qto32zE=;
 b=U4lykQqYN7WhTOES35MLfUmMpnSWlky4uRL6kSQWcH9ZRgh0eL7QmLYvAOAD+ER+m3uXz
 8n+fXXBCXk7o7ETGAITzxBPG1OK9MixPC95Sc30AnUegyDGmNNG0FInCvw5RkRkLS/QeGvw
 5YG3lHazRhSBbhwgp9BRgxfyzA84Gb8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail;
 arc=fail (ARC-Seal[1] did not validate); dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5688B818C5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  7 Oct 2024 10:22:12 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728289332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQvOnPFl4miAleHRljaFxDr9I5XCEBMa7UW6Qto32zE=;
	b=l3w5ovug6KHuxPZ7lXLwgkfNMctfImrGKpzJaYywzSDONUI2jPbYnOT5dfYj2aKRe5+Q27
	ak6tUeL5AlkkrKundRJkCxuAZGZK+ywe0alWvXL82txsrK9PuK+v9sLnXwhowxgB8COEuE
	3FV1Eb1tNTxCJRQ8pmdk6PCOqVEhjpc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728289332; a=rsa-sha256;
	cv=none;
	b=3Hd+o12sVcaF4A6/ii82wMdZjCxM4j9jHkPf2dTtrMxrdz24OaF3+EJvsfmZJR2twfeUJU
	Sk2H1FFYeKw4ZrD+xq/zQeywhETW8HQvZpFm4qEwnLfHFdJAqVHkswDl7BrZsUnRghNoPq
	pPKHokH1miz7hBlMrs/zkucEopED7Yk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E4A53EFA3;
	Mon,  7 Oct 2024 10:22:11 +0200 (CEST)
Date: Mon, 7 Oct 2024 10:22:10 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: mcast: add option to forward MLD reports
 only to mcast routers
Message-ID: <ZwOaMrlWzdXNjFBq@sellars>
References: <20240831194528.1932-1-linus.luessing@c0d3.blue>
 <1944646.tdWV9SEqCh@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1944646.tdWV9SEqCh@sven-l14>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: APXNW2XKBCHITXPY3HCJ3NPG3NQCXWTB
X-Message-ID-Hash: APXNW2XKBCHITXPY3HCJ3NPG3NQCXWTB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/APXNW2XKBCHITXPY3HCJ3NPG3NQCXWTB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, Oct 05, 2024 at 05:37:19PM +0200, Sven Eckelmann wrote:
> On Saturday, 31 August 2024 21:45:28 CEST Linus Lüssing wrote:
> > In most setups it is sufficient for us to only send MLD reports to nodes
> > which have a multicast router attached. Which reduces overall overhead,
> > especially in large batman-adv mesh networks, where broadcasts are
> > particularly undesirable.
> 
> What is the situation before.

For Gluon the situation was that IGMP+MLD is filtered via ebtables,
because it otherwise would have a significant broadcast overhead.

For batman-adv the situation was that IGMP+MLD got flooded so far.

> How does this change try to modify the behavior. 

With this option a node would only send it to detected multicast
routers instead.

> Why is this good?

I would like to enable layer 3 IPv6 multicast routing between Freifunk
communities / Gluon domains. But without the broadcast flooding
overhead, to stay somewhat scalable.

And the reason why I would want to do layer 3 multicast routing:
Right now multicast has a chicken & egg problem: There aren't many
transmitters or receivers for it (other than ICMPv6 Neighbor Discovery or mDNS).
However one strength of multicast lies in the significantly
increased throughput when there are many simultaneous receivers.

So I'm hoping that while at Freifunk Lübeck with its ~200 nodes /
~200 clients domain I'm basically the only one using it that
if there were all 40'000 Gluon nodes connected on layer 3 that
the chances of a multicast stream being received by multiple
people would significantly increase. Also more multicast content
should then become available for everyone.

> 
> It also doesn't mention anywhere that the old (multicast filter) behavior was 
> just to handle IPv4/IPv6 messages and it is now expanded to 
> IGMP_HOST_MEMBERSHIP_REPORT + ICMPV6_MGM_REPORT. 

Ok, maybe I should have written that more directly in the first
two sentences.

> 
> 
> > 
> > However there is one specific, known issue / broken scenario with this
> > setting:
> > 
> > If the IGMP/MLD querier is configured directly on the bridge on top of
> > bat0. But there is no multicast router on or behind this node. Then this
> > bridge will be unable to detect multicast listeners on/behind other
> > nodes which have the MLD-RTR-ONLY setting enabled. (A workaround for this
> > can then in turn be to set multicast_router=2 on the bat0 bridge port
> > on the node with the IGMP/MLD querier.)
> > 
> > Therefore MLD report flooding is kept the default and MLD report to
> > multicast routers only forwarding is considered experimental and
> > warned about.
> 
> Most of the text here seems to suggest that (whatever reason you want to 
> enable it), you should most likely not do it because it just creates more 
> problems.

Right, in most cases I wouldn't suggest people to enable it. As
can be seen in the wiki page examples it is not trivial. I would
only suggest enabling it in setups where you have thoroughly
checked your use-case against the ones in the wiki. And then only
if you care about layer 3 multicast routing in the first place.

> 
> 
> The commit message doesn't show me why I should apply this change in the first 
> place - especially when it just causes more headaches in the end.
> 
> 
> Another headache I get is the "Warning: MLD-RTR-ONLY is experimental and has 
> known, broken scenarios" part. Which seems to suggest to me that there might 
> be changes in the future which will cause more problems if I just apply this 
> patch now - and in this process create ABI incompatibilities or "no 
> regression" conflicts later.

I don't have any future ABI changes for this in mind. This was
more thought as a warning that the list of examples in the wiki
might not be exhaustive. I could only find one setup where
enabling this option would not work, but despite having spent
several days thinking about these scenarios I can't guarantee right now that
it's the only one. That's why I wanted to mark it as
experimental.

> 
> Btw. BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED seems to suggest that it is 
> about MLD - but it seems to be also about IGMP. At least I didn't expect this.

Yeah, it's a bit annoying that for IPv4 it was named IGMP and for
IPv6 it was then renamed to MLD even though the protocol is 99%
the same thing. I'm not sure if it would make sense to make two
separate knobs for IGMP and MLD? (I kind of more and more have the
stance that where "legacy IP" creates extra hassle to ignore it
where possible. And multicast with IPv4 is not as much fun as with
IPv6 anyway, where you have things like embedded RP etc.)

> 
> Kind regards,
> 	Sven


