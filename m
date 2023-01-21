Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF72C27C76
	for <batman@archiver.kernel.org>; Sat, 21 Jan 2023 13:16:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 78D3583E60
	for <batman@archiver.kernel.org>; Sat, 21 Jan 2023 14:16:21 +0100 (CET)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5577C805AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 21 Jan 2023 14:15:58 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1674306958; a=rsa-sha256;
	cv=none;
	b=jRk2mwf/WEKJ3DRPmZu/oXtPp14jY4oIzVCeaQDHh9roRuUhwm+Eb1puLbkBnNc9Tbv58E
	ysSvPYwe0cSMqWrrPMan9IDyMrB9rbzZZmT3NrOfrfb2/Y9J6rUugCfkBWzEkC+OK0+C4+
	3K6K1DeYNca28waI0IqHN5fwn2MtxfY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no SPF policy when checking 116.203.183.178) smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674306958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLLgDbQ7qc4g4Y4JoKC9h3xk5UiXYgjNBZ0RBcpQweI=;
	b=G3LJIZhX9mLh7ZJQ9oBwpp56/ceL5fbJTkFsY+2QWRCPhAwkhwOeZn78P9PiHVeo5GBxfA
	heabYHDzktX7qn++cT1/9Pi/TK/6Iczh6+YKumnv3JRzbgITDqXg+7Bv0694XgYbcQcQQu
	wlTaoS1coecOLkxhJZBUAMX5Uv6k5p0=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 549FD4129E;
	Sat, 21 Jan 2023 14:15:57 +0100 (CET)
Date: Sat, 21 Jan 2023 14:15:55 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v4 3/5] batman-adv: mcast: implement multicast packet
 reception and forwarding
Message-ID: <Y8vli4sEYcl75iS9@sellars>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue>
 <20221227193409.13461-4-linus.luessing@c0d3.blue>
 <2927983.YVBx59ikfs@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2927983.YVBx59ikfs@prime>
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: SDTZJ74T25GOX5NFA2P5VS725YSAAJT6
X-Message-ID-Hash: SDTZJ74T25GOX5NFA2P5VS725YSAAJT6
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SDTZJ74T25GOX5NFA2P5VS725YSAAJT6/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Jan 19, 2023 at 01:47:25PM +0100, Simon Wunderlich wrote:
> On Tuesday, December 27, 2022 8:34:07 PM CET Linus L=C3=BCssing wrote:
> > +/**
> > + * struct batadv_tvlv_mcast_tracker - payload of a multicast tracker=
 tvlv
> > + * @num_dests: number of subsequent destination originator MAC addre=
sses
> > + * @align: (optional) alignment bytes to make the tracker TVLV 4 byt=
es
> > aligned, + * present if num_dests are even, not present if odd
> > + */
> > +struct batadv_tvlv_mcast_tracker {
> > +       __be16  num_dests;
> > +       __u8    align[2];
> > +};
> > +
> The one thing which I really don't like is to have the alignment in the=
=20
> beginning, and depending on the number of entries. Normally, such align=
ments=20
> should be at the end of the structure so it is straight forward for a p=
arser=20
> to omit it.
>=20
> My understanding is that the alignment is due to technical reasons (mac=
=20
> address list is assembled by pushing the data to the front), perhaps to=
 save=20
> another memove/memcpy. However, the data is collected by traversing var=
ious=20
> lists, and if performance would be a concern, then this data should be =
cached=20
> and this "technicality" wouldn't be needed either.

The technical reason was to have the payload data from the IP
header 4 bytes aligned. To allow efficient access in there once the
payload is decapsulated.

>=20
> So please, skip the alignment in the front and have it in the back.

The reasons to put the aligment at the front are/were the following
two:

1) We do keep a count of receiving nodes, however it might change
while we are pushing destinations. So it is at the moment easier
to push the padding to the front, when we know exactly how many
destinations we have added to the packet. As discussed offline, I
guess that is what you were refering to above.

2) Alignment changes during routing everytime a router removes an
odd number of destinations from the tracker TVLV. Changing
alignment more to the front would in theory less memory movements.
Example for an ideal case:

[MC-HDR][pad][dest1][dest2]...[dest100][PAYLOAD]
-> dest1 is deleted
[MC-HDR][pad][00000][dest2]...[dest100][PAYLOAD]
-> move only MC-HDR:
[MC-HDR][dest2]...[dest100][PAYLOAD]
=20
If the alignment were behind dest100 then everything would need to
be moved.


Even though it's unconventional to have the padding in the front,
I found the idea quite tempting and useful to have the padding in
front, saves quite a bit of code and potential bugs I would hope :D.
And would hopefully (potentially allow to) make the packet routing
a bit faster. So from a "purely technical" point-of-view it seemed
advantageous to me :D.

Another idea would be to have the padding at the end by adding and
keeping a zero-MAC destination entry if the number of destinations
were otherwise even. Disadvantage: Might waste 4 more bytes than
necessary.

>=20
> The rest of the packet format looks good from what I've seen.

Thanks for having a look at it!

Regards, Linus
