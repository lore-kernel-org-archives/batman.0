Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E461C02183
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 05:16:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 66F1683E6E
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 06:16:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737263760;
 b=lm4VIoXig+wXQt90dKStok51d4CvCb/GSSClHGOyNz2wuFhiAgo9qy3m+YdskcOIiSwZM
 /MvELd5VX5GqIRQ0la9Iraw7Jdw87TVCEOZ1v9oiRbLO717cNsbAK6fx8vwuJmN6lK5uvAr
 viMNTS0eJnl5GOtzwkxJLKISzvB59Yc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737263760; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7MGApJ3lcAQmxY+qMMQCodvG1EfllhUNERJAJTIr8cM=;
 b=IKHoZmtx2e91Q8qHGmJ1ipziPr4O0cz3kzdN7Werwma4utKjkD5RNJ54nr/RYeeuhjwsN
 3oeYXdA3EPCa9tFaICqIeT0x/NOk3myIo0TS5nMCrh20EZxzwXkm0A0olc2lfWtaMzZlodl
 +tA3e+NY4t/47bLsYz5AIRvcN0k9lOY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4BBFF8200D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 Jan 2025 06:15:52 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737263752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MGApJ3lcAQmxY+qMMQCodvG1EfllhUNERJAJTIr8cM=;
	b=nTYMYC8ohxgKR3fP1HZJJ29fUELkfhkN+jmoRlSJYHnUQAROvzkOaSMtnQltiWqPoT7cIV
	QB43inakiTl7Rx8mlvE0SfK44PptJwdTN2QhW+3d4F6vNj/RPx+ipPdW0TaeSDqCPJy07o
	cjGnzcsSEvIRz+3sG124+041vj/PsoI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737263752; a=rsa-sha256;
	cv=none;
	b=gpa8rxJEsY93OewNAPASpPXXxbX1pkw/v3rFn5QqH0ugjevStE9HLQpYs7D4x7OYsvEJjO
	3aRCtTtU4nXQa5mtAR3fgYFMhDvg/Hx2rx6d3kp5ynb7/otYRXc3Kajx2UECbl74ut1NN7
	MImuXUc9IfcXp0F7twDGwEbe707z8NA=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4EE66540FD4;
	Sun, 19 Jan 2025 06:15:51 +0100 (CET)
Date: Sun, 19 Jan 2025 06:15:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Marek Lindner <marek.lindner@mailbox.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	=?utf-8?B?UmVuw6k=?= Treffer <treffer@measite.de>,
	Andrew Strohman <andrew@andrewstrohman.com>
Subject: Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link
 metric
Message-ID: <Z4yKhoN0x_Ckdu-u@sellars>
References: <20250118003528.6843-1-linus.luessing@c0d3.blue>
 <CAA8ajJnqXBuUmBzAHVjyEchD2CU9E7SmqJXXvy0V7QAQF9536A@mail.gmail.com>
 <6131569.pqZb4hCDXM@rousseau>
 <Z4yIKYsFvLyGpmjt@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4yIKYsFvLyGpmjt@sellars>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: VB2APQPNNSSQCPKIWYXH7UIKXLYIM5SG
X-Message-ID-Hash: VB2APQPNNSSQCPKIWYXH7UIKXLYIM5SG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VB2APQPNNSSQCPKIWYXH7UIKXLYIM5SG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Jan 19, 2025 at 06:05:45AM +0100, Linus Lüssing wrote:
> On Sat, Jan 18, 2025 at 05:59:56AM +0100, Marek Lindner wrote:
> > FYI, expected throughput and also 802.11 throughput estimation are taking 
> > congestion into account.
> 
> Are they? At least in minstrel_ht_get_tp_avg() I don't see it:

On the other hand, if the channel were fully utilized then this
should likely, indirectly reduce the average transmission success probability
a bit. So in that case I guess congestion / channel utilization could
indirectly be factored in.

But still if a channel is 90% utilized / has 90% airtime usage then this
wouldn't mean that the expected throughput from Minstrel will be about
90% lower compared to an fully free channel, I guess?
