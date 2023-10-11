Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF256CD6E48
	for <batman@archiver.kernel.org>; Wed, 11 Oct 2023 08:56:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CE4D581F03
	for <batman@archiver.kernel.org>; Wed, 11 Oct 2023 10:56:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1697014599;
 b=K6ihMktOihssMQu/a6UyaSU3a1v0VBjWAJDmFKQthRev8UPwVwAoawWOLjJqxbmvl7zIX
 FWsUwNtkz8U+l4IJbWlXUIIbLAY6G/eww3eBAMTyxJ+CI6jKj4X8PuN1Q4wf6rFSWhUw6A2
 PSeuNPE4lhrdEI1DUOAjRwG207A7UEA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1697014599; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4T419dDAYsBoFiWw9lswzmqxw9mweclZmqjwFwcKm0s=;
 b=Bhkf7TAvZiJjg2dipFNQRveY8U4pBXZjkWQ4PpIjIWNu/WLFP6AKX6YErd9Ah0079udsi
 knDQBij1Ag+Q9p8VoI459PiUVm4F4qw62uufgBOosySFDjJpKZwwPF3pVhA3LtSkFROhkzz
 N0LWGdRMHlv+EmMtMg1U18OgmLQ6heI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 82DD58018C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Oct 2023 10:56:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1697014576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4T419dDAYsBoFiWw9lswzmqxw9mweclZmqjwFwcKm0s=;
	b=o5F0ehaGvhbuGK/BzICuMM/N3qQLnaSlXTamus9pHWDc3D8BLK2ZT75GOZOlJ5SvxPwY3L
	XqLZS7jaswkO52bkHGok5mbVyAISoKF0CF1+TMs0X35i5Ea2Zc2Ef6p5V0EcVs+eE9pUiF
	VG/pTbu0z9RB5fs+YhGDdV4dU2H6sF4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=SJthTSZW;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.12 as permitted sender) smtp.mailfrom=repk@triplefau.lt;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1697014576; a=rsa-sha256;
	cv=none;
	b=k1i7VIjNXHX495IGIXwSfECuHxIZyqViArjfuQRgaiA2eDSsXaXZXsPjd9nw/GwYl10Zbu
	1WXfba7P9cMhlphaim46W+JVGgP94PefcQ1fzWFpm1eA4gcBsB97LDpiEvths/g5OxZAQZ
	2pkhDMQBMeCJEHFRaZCmh0sOIrz0rnQ=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1697014576; bh=BXMEJ7F3Fh6/VYKdQv/b+sZEtieSEsy3o3o49XwJ/wM=;
	h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=SJthTSZWIzfNZ7dOqXSZmfk3FsA6dJ6vJqgZPu7m6FZlSVCmqUq/mnnIomA0Ktfqw
	 i8zL074ebYjqjTv1uwmNj8WJmE2wVBjLSLQFetA5Y6HWVocQhf/xleXiXcGPiKmnSC
	 6jw8HRQiwgnxUr1dcvQzromvsm2HjuGTqQQ2MpO0=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Wed, 11 Oct 2023 10:56:15 +0200 (CEST)
X-EA-Auth: 
 wAiPk/IZtQcE2e/U1Pepbhl7tLW0MeYlrzYTWqdPSxWUR2vc9cmMH69rDtwHUIggF4SF5f6m6oMVjo9yFhgAWiCuTC6nuJVQ
Date: Wed, 11 Oct 2023 10:55:01 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Message-ID: <ZSZi5VvgWHLqXJbL@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <15370864.uLZWGnKmhe@rousseau>
 <ZRXRFFATYjEvIeVb@pilgrim>
 <3744588.QkHrqEjB74@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3744588.QkHrqEjB74@rousseau>
Message-ID-Hash: CU4YAIYMHMCHXHHG7XSGMXOES37HOM7N
X-Message-ID-Hash: CU4YAIYMHMCHXHHG7XSGMXOES37HOM7N
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CU4YAIYMHMCHXHHG7XSGMXOES37HOM7N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Oct 03, 2023 at 11:06:45PM +0200, Marek Lindner wrote:
> On Thursday, 28 September 2023 21:16:36 CEST Remi Pommarel wrote:
> > > > $ batctl o
> > > > Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
> > > > * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
> > > > Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]
> > > > 
> > > > So best path for Orig2 to Orig0 would go through Orig1 with an expected
> > > > throughput of 110Mbps. But such a throughput cannot be reached because
> > > > Orig1 has to forward packet from and to the same WiFi interface.
> > > 
> > > Correct. Looking at your example where is the problem with the store &
> > > forward penalty?
> > 
> > The problem is that the wrong path is selected.
> > 
> > The best one should be the direct one. Because going through Orig1, 110Mbps
> > would never be bereached due to the store & forward penalty on Orig1 and
> > the real throughput will be below the direct path (around 80Mbps).
> 
> To summarize the problem you see: A path traversing a half duplex node might 
> not be penalized enough when the weaker throughput link lies before a stronger 
> throughput link because the half duplex penalty is not be applied before the 
> packet is forwarded.

Yes, in fact currently it is even not penalized at all. This is what the
first patch proposes to fix.

This issue could also be looked at from a different angle, which is
maybe more convincing.

Let's say there is the following setup:

sta1 <-------> AP <---------> sta2
      275Mbps       720Mbps

Then the BATMAN_V current routing algorithm is going to compute the
following:

 - a 275Mbps path towards sta2 on sta1
 - a 137.5Mbps path towards sta1 on sta2

IMO, there is no real reason to have such an asymetry.

While the first patch fixes this asymetry by estimating both paths to
be 137.5Mbps, the second patch is a proposition for a better throughput
estimation.

> 
> The underlying assumption is that this indeed is an issue in terms of 
> (measurable) throughput. Are there any numbers / papers / experiments you are 
> basing this on? Is the store & forward throughput limit determined by the 
> throughput of the weakest link?
> 

I haven't found any paper on that matter, if you have one that shows
that dividing by two is a sound estimation I would be genuinely
interessted though.

However to support the theory of the second patch I did run some iperf3
tests on the setup above.

Results from iperf3 measurements:

    - sta1 --> AP   : 275Mbps
    - AP --> sta1   : 221Mbps

    - AP --> sta2   : 720Mbps
    - sta2 --> AP   : 704Mbps

    - sta1 --> sta2 : 193Mbps
    - sta2 --> sta1 : 152Mbps

The sta* --> AP and AP --> sta* asymetry comes from the different WiFi
hardwares characteristics (i.e. AP WiFi card is better at TX than RX).

Now let say that B.A.T.M.A.N-Adv has perfect throughput estimation for
direct neighbour links (e.g. sta1 <--> AP and sta2 <--> AP).

Here are the path throughput estimations with different methods for
sta1 <--> sta2.

Estimation from current B.A.T.M.A.N-adv BATMAN_V:
    - sta1 --> sta2 : 137.5Mbps
    - sta2 --> sta1 : 221Mbps

Estimation with Patch 1:
    - sta1 --> sta2 : 137.5 Mbps
    - sta2 --> sta1 : 110.5 Mbps

Estimation with both patches:
    - sta1 --> sta2 : 199Mbps
    - sta2 --> sta1 : 168Mbps

I have created a NS3 simulation test [0] that also seems to show the
proposed throughput estimation is a closer estimation most of the time.

Here is an example output of this simulation:

 $ ns3-dev-wifi-duplex-penalty-default --pos=10
  NS3 simulated throughput sta2 ---> AP:                  156.321 Mbit/s
  NS3 simulated throughput AP ---> sta1:                  323.139 Mbit/s
  NS3 simulated throughput sta2 --> sta1:                 102.888 Mbit/s
  Current BATMAN_V estimated throughput sta2 --> sta1:    156.321 Mbit/s
  Patch 1 estimated throughput sta2 --> sta1:             78.1603 Mbit/s
  Both patches estimated throughput sta2 --> sta1:        105.355 Mbit/s


[0]: http://ix.io/4IG4

Anyway thanks a lot for your time.

-- 
Remi


