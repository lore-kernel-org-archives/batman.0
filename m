Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C82CE7B1E
	for <batman-adv@archiver.kernel.org>; Thu, 28 Sep 2023 19:17:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 075B683461
	for <batman-adv@archiver.kernel.org>; Thu, 28 Sep 2023 21:17:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695928650;
 b=UI24ddCHX1QIr/zvQtcg8d/aaIOxluTW/7YUSm8vTRescVe1xjpLriOB0d8xj1UegguRB
 At9fUrPYI/Lk0Vq7jiXLlj8trCPf1O1j9KMWN9n/RGLTIc1XT2NchQ6MhlKSxIUfHaIw6lN
 pHx6QM9fhqrzu7HNtYKCzzyjFsxyS4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695928650; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=H3rQAImZaWC4FK4VSHASnW8i2ZiDT3NP/PXLFgdhTfM=;
 b=vnL+vJNpeRFaSTis/JMIDrXK9s9CY652DYgklNb/+ZDzEAOqy782hHsQU/Mg1w+uCzH7Q
 tqs2KR2kCGEJjKWoE4rygAOMOE4FR1RE5AkXyuVvfJfK1tkLrRxGbMxl/gxAFAof5FjJElV
 BDUAod0D65d4x6F2lJ6IF8pQWcbhPic=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AEFFE80038
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 21:17:22 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695928642; a=rsa-sha256;
	cv=none;
	b=NQ0XDkHlDyCSwkbI5tvduUoIAqu5HsQaSIxSK50nlyGYRO8oGjAGMU316tE4p/PD7DJyEK
	uxCGpSc3hDrXVOGLWtMCnPFbKhuHW0efXfjvLQGosaEKkvFktgfwmcV/M63Wxoca/xdQ3E
	I62IeAfXTHrnC3odxFQ++YAMEYUkpow=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=p619GZ5z;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.11 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695928642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=H3rQAImZaWC4FK4VSHASnW8i2ZiDT3NP/PXLFgdhTfM=;
	b=ak+iKEPvUDRJXNhy/Oc2a0rhqKceWxobF8uGn1+H7vyc5RSSNAASpBZdUmz5csKhQYV9Xr
	qye5eyaE8xxg7AvhdOpc7PIF5Gc/vwM65XBtXWG/7m20SH2yuck7ikS+qCm9kt8d4XskdG
	fseLH6RjDBBkQ55JKSAICN2K/fSfcYU=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1695928642; bh=0dx3ltEAl4drsth6fUpAOsxLHSLYpU4309AX6A0hzsM=;
	h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=p619GZ5z4hqi13KTBuW4TQ1tE+mB9SoKPvt8qZWXvBRcty3RzOjbiG9J/1ZRTeMfX
	 ueepsSjY7sp3yV6pFWesSffkTeQvFWcE9z89CjmtoDsrN8LdeGjls5L1REpIpwoZ5t
	 nivJlKrk0FpzUGyCpTgQIi632iW/hbMzgvmrTBPA=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Thu, 28 Sep 2023 21:17:22 +0200 (CEST)
X-EA-Auth: 
 todaQYcpaj71Mffm9KIgYnZpgzJAR3qyBY6LYbiQrtaxR5loWyC1IEBwZWND/YV60vgYbxAXHzdQZdZ6o4kVdqkGbC8sojQw3op5FkHXEOQ=
Date: Thu, 28 Sep 2023 21:16:36 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Message-ID: <ZRXRFFATYjEvIeVb@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <4312005.ElGaqSPkdT@rousseau>
 <ZRWuVBZuzD7cdd_-@pilgrim>
 <15370864.uLZWGnKmhe@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15370864.uLZWGnKmhe@rousseau>
Message-ID-Hash: HQFTGDFI3C4A2FOX6Z677EYQ7KPZO7NZ
X-Message-ID-Hash: HQFTGDFI3C4A2FOX6Z677EYQ7KPZO7NZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HQFTGDFI3C4A2FOX6Z677EYQ7KPZO7NZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Sep 28, 2023 at 08:10:48PM +0200, Marek Lindner wrote:
> On Thursday, 28 September 2023 18:48:20 CEST Remi Pommarel wrote:
> > > If the direct path from Orig0 to Orig2 is better than the path over Orig1
> > > the metric should reflect that.
> > 
> > In the example there is no direct path from Orig0 to Orig2, the only
> > way for Orig2 to reach Orig0 is by going through Orig1.
> 
> If there is only one path, the computed metric does not matter at all. 
> 
> If there are alternative paths (as you saying below "Orig0 and Orig2 are 
> connected via a 100Mbps"), batman-adv has to find the best of the existing 
> paths.

Yes and it currently fails to do that as explained below.

> 
> 
> > Let's say that :
> > 
> >   - Orig0 and Orig1 are connected via a 200Mbps WiFi mesh link (mesh0)
> >   - Orig1 and Orig2 are connected via a 110Mbps WiFi mesh link (mesh0)
> >   - Orig0 and Orig2 are connected via a 100Mbps WiFi mesh link (mesh0)
> > 
> > With the current implementation the originator table of Orig2 will show
> > something like the following:
> > 
> > $ batctl o
> >    Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
> >  * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
> >    Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]
> > 
> > So best path for Orig2 to Orig0 would go through Orig1 with an expected
> > throughput of 110Mbps. But such a throughput cannot be reached because
> > Orig1 has to forward packet from and to the same WiFi interface.
> 
> Correct. Looking at your example where is the problem with the store & forward 
> penalty?

The problem is that the wrong path is selected.

The best one should be the direct one. Because going through Orig1, 110Mbps
would never be bereached due to the store & forward penalty on Orig1 and
the real throughput will be below the direct path (around 80Mbps).

> 
> Or in other words: What scenario are your patches aiming to improve?
> 

With both patches this

 * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
   Orig0-Main-Mac   0.220s  (        100)  Orig0-mesh0-Mac [  mesh0 ]

will instead be

   Orig0-Main-Mac   0.220s  (         80)  Orig1-mesh0-Mac [  mesh0 ]
 * Orig0-Main-Mac   0.220s  (        100)  Orig0-mesh0-Mac [  mesh0 ]

Fixing the best path selection.

Thanks

-- 
Remi


