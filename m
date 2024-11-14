Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B57ED6A221
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 18:06:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 76B1E83CA9
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 19:06:10 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731607570;
 b=W3yBxge6j/gasYzgZnZ3UBHfDUaLlu51qmVhslnXxr5ix2RVx+2nmMjoKhvkIe+RU8FOr
 RtB8RX3AzZ4yzEvYd2T5XX1CRo8EcWhmzNk9uRJij/Vg15IC0jFO3U+ubDZwQOoB//Zkv1s
 DuGIL5KGhwopdQ+UZ/EtxG4J/cvPIHY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731607570; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9TdbLtUZrOhEER6T2wRe2qOs3Mv6gRj5mw3IHl6hFIM=;
 b=nw1uok+KJh08Ke/3dHx/689O+vCMKjayvRURIysNldVyI6dazD4hBysA1x4Dv6FfPIrQY
 aB4ZbG4clFtPjcZBeIFWQw+nJ5VW19m7E1Cgay5pY5wrjHD5EmDIoMvc5Mf9SszKiXhGGdY
 75xALGvH2a21XhJbuOldOd7x8mRqgTs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 163DB81D61
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 Nov 2024 19:06:03 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731607564; a=rsa-sha256;
	cv=none;
	b=sVLm4+G7Gag349TEUlcItbNE8xKmMC+fCCO6tb/psjjPBUesON71IxcLSPdAzv9a8Xbz82
	7LpRXoM99LHFitQMlTsomoYIiuqHIsWthwjaFIboRgne5kowMB+rQ/WlX8n6tsG6NTiECk
	4gyDbXrxvtbNMrMZYr8ljYStU3G4nvo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731607564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TdbLtUZrOhEER6T2wRe2qOs3Mv6gRj5mw3IHl6hFIM=;
	b=EDs8+rtECLmpBcQ2yA3tZbFodgR1rk9ctD3z3/+6DfR48zZOoPoofKcKKKzbli04OFVEFi
	A5p5zxeT3beYTs7HaoUIQUSnadWuDW5toDnbVh9YmNvvO3fc9P25Fw/0GUzqff+5/Yno2q
	0SaywooQWUcka85prh1Uedb4xWed5Vc=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2882A54223C;
	Thu, 14 Nov 2024 19:06:02 +0100 (CET)
Date: Thu, 14 Nov 2024 19:06:01 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v2] batman-adv: add dynamic, bridged-in TT VID detection
 support
Message-ID: <ZzY8CdiUV_sYsHul@sellars>
References: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
 <6100761.lOV4Wx5bFT@ripper>
 <D5LZJSJADA7Y.35OPLU5VTB46Y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D5LZJSJADA7Y.35OPLU5VTB46Y@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: ZJ67UHSSITHEJ23OLPPCDS5FS5M73XKY
X-Message-ID-Hash: ZJ67UHSSITHEJ23OLPPCDS5FS5M73XKY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZJ67UHSSITHEJ23OLPPCDS5FS5M73XKY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Nicolas,

Many thanks for your feedback!

On Thu, Nov 14, 2024 at 03:53:11PM +0100, Nicolas Escande wrote:
> On Thu Nov 14, 2024 at 2:58 PM CET, Sven Eckelmann wrote:
> > On Thursday, 14 November 2024 14:48:52 CET Nicolas Escande wrote:
> > > Hi there,
> > > 
> > > We've been running this for a few time and it's very usefull. So is there any
> > > news on merging this into the kernel ? Or is the BLA thing blocking ?

Yes, I think this is at least one of the blocking issues. I didn't
quite get my head fully wrapped around the BLA code yet.
(Any help/guidance still appreciated :D. BLA is the one code part,
other than network coding, that I haven't really looked into and digested
so far. And what clashes right now is a specific internal that
isn't fully documented on the BLA wiki pages, unless I overlooked
it?)

> >
> > I am not in favour of changing the behavior of batman-adv. Now everyone can 
> > increase the number of managed VLANs without any control by the node admin.

Valid concern. Especially as each added VLAN is quite costly for
an OGM at the moment. A VLAN with one MAC address adds 12 bytes to
a 24 bytes base OGM IV length (excluding ethernet header and other
TVLVs).

However in a way for non-VLAN TT entries this is also partially a concern,
right? Someone could also flood source MAC addresses in an uncontrolled
way, too. (Though would likely have to actively keep roaming to create a
constant extra overhead.)

Maybe it would make sense to check how the Linux bridge approaches
this?

It seems there is an admin configurable limit of
BR_MULTICAST_DEFAULT_HASH_MAX = 4096 entries for the MDB
(multicast MAC addresses).
And a configurable fdb_max_learned (disabled by default, for
backwards compatibility reasons according to bdb4dfda3b) for the
FDB (unicast MAC addresse).
Thirdly, it seems 4096 VLANs are allowed (VLAN_N_VID), the maximum
amount. Though this one does not seem configurable.

Would it maybe make sense to have a knob and by default set the
limit to 8 or 16 VLANs? A default which could maybe be increased if the
OGM size was decoupled from the amount of VLANs in the future?

---

The two reasons I would like to have a dynamic VLAN feature,
especially for wireless community mesh networks:

Allow a group of people to setup and use their own address space
when the centrally managed, default one does not match their
needs. -> decentralization

Allow to get rid of the unused VID=0 and VID=1 entries by default,
only dynamically learn them, to typically reduce the OGM overhead
by at least 2*12 bytes. To partially mitigate the overhead regression
we introduced by adding TT in compat 15.

---

Just my overall, conceptual thoughts on this feature. Will look into the
refcount issue later, thanks for reporting!

Regards, Linus
