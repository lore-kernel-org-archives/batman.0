Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BBFCE7AFC
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 17:59:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2E3D8346C
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 19:59:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695923949;
 b=aF2p/uC5oO9dYt/hI9D/DatGLkNp/U4MVFwXvAowhuaE3b83YFLw60kmAWpVgxKG68HE/
 NpdUpbTMdDJNs6ngVs8sj7AFSxBbfw991xrMoN1K+GBK+sECcSdzi6q5XAVVEzUoxjIFLuC
 8HRKmHV+czKuPb9pYN2+SAyvZYEjenQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695923949; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kPL2OW5oXLb4+jHelYyyrdCQRa9syEYhLSFoYOOO+YY=;
 b=F7bs/76qSORgdvjEkCeWw0SNtQhm+W5Z/7Y8ALyvfJpS+VhaSHqi55FBqzDccdAlpLgIg
 R8pSS46nUviG9RNWeCt0uLyUe/5No1sKTUCNpXyzsn51F+1e8UtWKNHUv4nl60kjsG+lRWB
 V2QM8J+1mFa2wjWFIPcJoTEXUEoh8kg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7B7AD80088
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 19:55:26 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695923726; a=rsa-sha256;
	cv=none;
	b=z/0hIQP6FURmjNLrqlY7NObjxb33j/5RDbTSPsBUSToY83JABn+GqtV4jrUaFY0uFF+02J
	OXqRWRtDeSek7PEaKxdUQf99scd4CWACTBhdrT07OvFcuMuQS5f6d2O///bwhlNOoODLK9
	uXHb5D8VdMek5CqeugGtnpolHu1f560=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=KvqaY8Y3;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.11 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695923726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kPL2OW5oXLb4+jHelYyyrdCQRa9syEYhLSFoYOOO+YY=;
	b=e5wIw7R6wSgXYgSyCAVfC6pbM4lsRGCnkS3XTEXSwzrZyFpcTHK4nuiIVcBMFF8uo8Q8CV
	aPZNVpjma3hFhC0Igejxp4SRSAPYQUMGh9ju6ymapGgn8RGEMTB7p3jRnLvL02YxmYhsaV
	mnUcVR1UcoSSf15+Y670ZVA4PlM3Id4=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1695923724; bh=q+au4S16t/JKhnP4nSbZK1V6J5Wm42qsPiptfwXLuEA=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To;
	b=KvqaY8Y3jcwHP6C1PfwUtjEiEergDRvHgkGFY02oyfRfZoGlJrGuB4s66/3dlp4T3
	 x27j/EoL7dMcldOM1qjx+nr7rqGQu335tdzio539yk0BZx/VJBvEAgAmj76vrYPNJ0
	 gF3yWSxIWKPqnd0YKvVuVy+FD64M838aykAIBhFI=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Thu, 28 Sep 2023 19:55:23 +0200 (CEST)
X-EA-Auth: 
 Ql8qIfodYyjUTNj6wOh7Trvnm9jwezFVZiOtElIehVL16rDBfEp0kT4KesTBuzoEIsScUrFE3hnoVEijNw0fR6sPUkoIest4TL8byTjoaFM=
Date: Thu, 28 Sep 2023 19:54:38 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Message-ID: <ZRW93njVI0eRKI2O@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <4312005.ElGaqSPkdT@rousseau>
 <ZRWuVBZuzD7cdd_-@pilgrim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRWuVBZuzD7cdd_-@pilgrim>
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: NKKLYOVVOS4DNZQOZO6NUGUV3TYVYQ3Z
X-Message-ID-Hash: NKKLYOVVOS4DNZQOZO6NUGUV3TYVYQ3Z
X-Mailman-Approved-At: Thu, 28 Sep 2023 19:58:54 +0200
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NKKLYOVVOS4DNZQOZO6NUGUV3TYVYQ3Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

And of course I messed up both batctl o outputs.

On Thu, Sep 28, 2023 at 06:48:21PM +0200, Remi Pommarel wrote:
> On Thu, Sep 28, 2023 at 05:33:46PM +0200, Marek Lindner wrote:
> > 
> > Maybe you can add throughput metric values to your example and then expand on 
> > what you find problematic?
> 

[ ... ]

> 
> $ batctl o
>    Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
>  * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
>    Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]

Is in fact

 $ batctl o
    Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
  * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
    Orig0-Main-Mac   0.220s  (        100)  Orig0-mesh0-Mac [  mesh0 ]

(The last line nexthop was wrong)

and

> 
> So best path for Orig2 to Orig0 would go through Orig1 with an expected
> throughput of 110Mbps. But such a throughput cannot be reached because
> Orig1 has to forward packet from and to the same WiFi interface.
> 
> If the throughput between Orig1 and Orig2 were to be 160Mbps instead of
> previous 110Mbps then the originator table on Orig2 will look like that:
> 
> $ batctl o
>    Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
>    Orig0-Main-Mac   0.220s  (         80)  Orig1-mesh0-Mac [  mesh0 ]
>  * Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]
> 

Is in fact

 $ batctl o
    Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
  * Orig0-Main-Mac   0.220s  (         80)  Orig1-mesh0-Mac [  mesh0 ]
    Orig0-Main-Mac   0.220s  (        100)  Orig0-mesh0-Mac [  mesh0 ]

(Same error here)

Sorry about that,

-- 
Remi


