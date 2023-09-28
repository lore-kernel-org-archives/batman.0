Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD0BCE7AFC
	for <batman-adv@archiver.kernel.org>; Thu, 28 Sep 2023 17:08:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C219683508
	for <batman-adv@archiver.kernel.org>; Thu, 28 Sep 2023 19:08:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695920937;
 b=ZCxF267FRlOJ8vksNguIc3BZXPGdUfiqQlWQZcH1MZqhfu442VAMYnB2IQ5H8/U1RMxpa
 dEkxKz74ZhMRghEJnrxmbcC80sBG2gR+8Z/25PYNHMoPxkM9A3DNNtIH/ptKmz3y6Q+zx5X
 0cV8cWOi/6sywuqRcml3xiIHPjjrriA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695920937; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CAEt02YgsIrKbf8DDhck90U8bkH+UaG+lySO+UmY2H8=;
 b=vFMvuT7R8qn4s9jc13u/1PeMmStVu48u5LELuv51S31j637wfhNl7bpd2jxuKSNvsLLfs
 2IG3fEC1WJMTUTeCLDGuAu8dElY9salUUkf3ceZEgbnGAWi+Urk92zOmBQbnNzpfLcPHA3w
 GQN/EOyZZiU+3hSFnK+rUvVPJKQ078M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1036080BA0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 18:49:08 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695919749; a=rsa-sha256;
	cv=none;
	b=dFAEYNeh34sZfai1elqDkJ/T5YWE56vZAPpwgoSvqjnoRv/mLInfDYruLpMhHuX4cAYDCg
	xe1dJ+ecV8jnI91VFUX95TN9E4OBCYgaZj9+6joxPs5FI+d7I5WAvElBIkiDvyQ2n7tx63
	67skqGYnFQPXq/pkF5ZfwacQALYTEhQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=Inaf0nN6;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.11 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695919749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CAEt02YgsIrKbf8DDhck90U8bkH+UaG+lySO+UmY2H8=;
	b=xJPcRrYDHl+2YbRWZwd1Fb7Ncub4lNCKg6sM+01xC0xzMpAJMqHh9swPXKb5dokpBocCV7
	m8hfQNFN0+UAIw3w6p4XVOanFy4/VhcrYyFlFxI4suDZqaP7f/Rj/nyNLJFUUODeLq247H
	7Hbc625vbPGiAfuIiSVXYN83HYLz0j8=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1695919746; bh=8CvO2UVlpAu/lPilrt3aS8SGYmU8R3li0siseyUEuIU=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To;
	b=Inaf0nN6hD0ZaGYH8fv+rP0mUnMCIkCNGNZGKoQvhKnip/A8FDVMdBIUrObW0lIqW
	 p3Si0APhEYV3YPV0FUUAnOYT7VUo0xFYJcU9kmMqTs3eQzZVxFRd6exFX4DyvBGAOK
	 AnEnnn9lwKejP/oZ4LuX4s4kjmEh6O2xlttbsqtE=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Thu, 28 Sep 2023 18:49:06 +0200 (CEST)
X-EA-Auth: 
 mU+4BK/Sho7rT0SUCFu4mGixjUT+7W6qa4OVagQ6r5zUSvULkkcTLpBC5UKiHLSVbgn/trVFVJqkeiAnt2SXixIsVBRTt5z9
Date: Thu, 28 Sep 2023 18:48:20 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Message-ID: <ZRWuVBZuzD7cdd_-@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <4312005.ElGaqSPkdT@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4312005.ElGaqSPkdT@rousseau>
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: KEN7UMDMAAY3RPLPYTXTMWUQLZVNC57O
X-Message-ID-Hash: KEN7UMDMAAY3RPLPYTXTMWUQLZVNC57O
X-Mailman-Approved-At: Thu, 28 Sep 2023 19:08:41 +0200
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KEN7UMDMAAY3RPLPYTXTMWUQLZVNC57O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Sep 28, 2023 at 05:33:46PM +0200, Marek Lindner wrote:
> On Thursday, 28 September 2023 14:39:34 CEST Remi Pommarel wrote:
> > Then Orig1 first adapts the Orig0 OGM throughput to T01/2 then forwards it
> > on same interface it received it. Orig2 receives it and first thing Orig2
> > does is checking if T12 is lower than the received OGM throughput (i.e.
> > T01/2), and if that is the case T12 is considered to be the new end-to-end
> > path throughput.
> > 
> > The first issue I see here is that Orig2 does not know the path to reach
> > Orig0 has to get half duplex penalty because it is forwarded on same WiFi
> > interface on Orig1, only Orig1 knows that. Thus if T12 is lower that T01/2,
> > T12 will be chosen as the Orig2 to Orig0 path throughput (i.e PT02) and the
> > half duplex penalty is lost.
> 
> I am not quite following where you see the problem. 
> 
> The half duplex / store & forward penalty is for situations in which batman-
> adv has to forward packets from an interface to another. In your scenario that 
> only is Orig1.
> 
> Why should Orig2 need to care whether Orig1 does store & forward or not?

Because if Orig2 wanted to reach Orig0 through Orig1 the overall throughput
would be impacted but it is not if the expected throughput of its link
to Orig1 is lower than the expected throughput of the received OGM.
> 
> If the direct path from Orig0 to Orig2 is better than the path over Orig1 the 
> metric should reflect that.

In the example there is no direct path from Orig0 to Orig2, the only
way for Orig2 to reach Orig0 is by going through Orig1.

> 
> Maybe you can add throughput metric values to your example and then expand on 
> what you find problematic?

Ok here is an example:

+-------+         +-------+         +-------+
| Orig0 | <------ | Orig1 | <------ | Orig2 |
+-------+    300  +-------+    110  +-------+
    ^                                   |
    |                                   |
    +-----------------------------------+
                     100

Let's say that :

  - Orig0 and Orig1 are connected via a 200Mbps WiFi mesh link (mesh0)
  - Orig1 and Orig2 are connected via a 110Mbps WiFi mesh link (mesh0)
  - Orig0 and Orig2 are connected via a 100Mbps WiFi mesh link (mesh0)

With the current implementation the originator table of Orig2 will show
something like the following:

$ batctl o
   Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
 * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
   Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]

So best path for Orig2 to Orig0 would go through Orig1 with an expected
throughput of 110Mbps. But such a throughput cannot be reached because
Orig1 has to forward packet from and to the same WiFi interface.

If the throughput between Orig1 and Orig2 were to be 160Mbps instead of
previous 110Mbps then the originator table on Orig2 will look like that:

$ batctl o
   Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
   Orig0-Main-Mac   0.220s  (         80)  Orig1-mesh0-Mac [  mesh0 ]
 * Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]

Best path being the direct one as it should be.

Thanks

-- 
Remi


