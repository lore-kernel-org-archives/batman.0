Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B2CC001B0
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jul 2023 12:28:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DADC781F73
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jul 2023 14:28:49 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689164929;
 b=Yo5eBwki7hyDzf+rh6ytaCG0OpOuDtfjnBTIw1jBO5iJUAi85mhUvyb6jKS9+xB8j76ju
 1Hpms3lNzjldgkFwqHlfpICSl4Ejwu9GnlEgiit1iczXYr0hZ8tWCn8diZtIH7e/in1eqII
 1oAoQqf53OnvBbFiHL7fVcJbEmh7BYU=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689164929; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dr+X2kCy//mXGgk1nU5GpAC5zd7TkB6w8WDNPo9HMrA=;
 b=RzI2KhOVRh431WDV3vwaHRvnjK0+BYxR5Z9paPT35LbjvvddzkvIrD7HcmoBe8p0z+3oM
 fPUT5B6Lf4A6fzNjAJXeeDp95DM9lMIjoNjq850XRdDrXQXj9liKHx31p1jhCCQ7Gz+vM0n
 vJyQTsQUEfDnpDfg8C7AqAKRqc4a2Z8=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CE0E580688
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jul 2023 14:28:34 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689164914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dr+X2kCy//mXGgk1nU5GpAC5zd7TkB6w8WDNPo9HMrA=;
	b=Pg2NpqHp/8ye5hxk/cU47cR03r55fjTaPQSWWaaice9WZtkc3KICRKv5EKEl39JOH+7ItB
	M2KOrtLfWVqhAx9O2T2T3aD/vAfQZC9J1hN184aBm7Cyz1pu6xFGWDiNvHDNNMYKll8pgl
	WHwCDKD5JKmXCCYGRP6G45j+p/DhdaI=
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1689164914; a=rsa-sha256;
	cv=pass;
	b=PS+DPDwOClJGR3/XFC/Q493fWCsTffybmqiVPE/wukySIfgcCJ8kZriMsFVYpWyAp4sN4P
	mvrdYzegptkYBN4r4sL04p7u0IDiLLIuN0BVp+GflG77GsYQufECpBQlAmpByPttKUrPcf
	OlgJn5i8T1vgJ3o87evolBVFnpnjEDo=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=vVi6+YmY;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from prime.localnet
 (p200300C5970AE0D8a773bCc64f7760B0.dip0.t-ipconnect.de
 [IPv6:2003:c5:970a:e0d8:a773:bcc6:4f77:60b0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2E0A6FB581;
	Wed, 12 Jul 2023 14:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1689164914;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr+X2kCy//mXGgk1nU5GpAC5zd7TkB6w8WDNPo9HMrA=;
	b=vVi6+YmYMUGrMQIUq+kjhCY5w43ztkMEdRjzc1IAz7Hkn7QVqtDcwIzXHEUtaQBRBTU5gP
	/cZ03dZFxMa7/HfBoU2rBByWfEuFNotXAKMVkdZFLeCzJtZPIUO9C13s/GtcbicqKB/7PM
	YBdVgx3zlOis7Yqg7TTpHL8tt821Mr+bwe6OjgjXFnY8bP8lVcDDqr2WtO+XgLHGPONOze
	9/tOlha+0HAhMSv0DQ+ZMhRLOeWN0dPV3iODbEaEkcEbeWcBxZd+v+JTdHQrO/hjCeYYPl
	NB0bCsIfauShjc5SPgUxuLwAcBVh5dtOU2ajfydMozwul0TWaNA1Dts0r4ykAA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Peter Milani <petermilani80@gmail.com>
Subject: Re: Using BATMAN over ppp interfaces.
Date: Wed, 12 Jul 2023 14:28:33 +0200
Message-ID: <7752715.gsGJI6kyIV@prime>
In-Reply-To: 
 <CAB_9twWTs3dxT97ze2YP44_6vgJBdXw5yQcDUO=M=RvNP27D1w@mail.gmail.com>
References: 
 <168913619024.1040.2149557919065248797@diktynna.open-mesh.org>
 <10972843.BaYr0rKQ5T@prime>
 <CAB_9twWTs3dxT97ze2YP44_6vgJBdXw5yQcDUO=M=RvNP27D1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1998544.kXSN5OTJKJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1689164914;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr+X2kCy//mXGgk1nU5GpAC5zd7TkB6w8WDNPo9HMrA=;
	b=L+4dZzYwxm0Uj/KAJCsnphUHezn8w/2heC1P1GlzAJC0cnie+XQNybVD83H2bnefeDx5Qj
	2HSwPHn7y8dCDfa1lQQNef0bdMyA7GRPZnrR5UckE+d/5B8krEu36cakAHOg1Zt0Hb/pGQ
	gprQ8Qm5a8guER+bvEUKo8ZAanhuOSVxAdH5LxTt28VHfPsaPJfFiBTEz1Ievec3y2v2VA
	3+iwL+GCrjEwFOzE+mcC8xl4UGv5MrdASicV/Bk5L1i0IOh7B6n1LMxKSHVEmdTtYH3ebw
	D+aZPX4Ofx7yzr8kuciyMPsCrMrN5bFLcyAbplMRLpCSz4KCU2CHlfFbbNvBzw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1689164914; a=rsa-sha256;
	cv=none;
	b=Kpdzxdofq1FqX+EU8xuV5ZnN9K4o4f2VOQNDAylsSBlwZ4nxmG4BV7P547eQ9RV3sXAbiK2UzcCcmYApZWu1gN+uAglwXqvUZlTkykT2xGEBySV99T+s8ariMZbXFYZQHyFtEh9ByMhGtujXlwy3tOB57pSz6M+xqxbsJGTedxZgJuOq2zAlsHntFPSaSnYpja/Tnrs7j9f1ewg0FDh1WvXw4eyHqtjF+LEKupuh12h+xOjtWDFEyLx5DQTqCcrvV8dD825FimLVqsA5dVKlStxNYISPMHN0bm6cakxcsyAFCPTXtMEr2bzRGcjeRkNWd2BjsgdCHhiOfFg00IlkaA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: MN3CR44DXBYNIVJJ2SBRYJLWCBQSOWQ4
X-Message-ID-Hash: MN3CR44DXBYNIVJJ2SBRYJLWCBQSOWQ4
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MN3CR44DXBYNIVJJ2SBRYJLWCBQSOWQ4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1998544.kXSN5OTJKJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Peter Milani <petermilani80@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Using BATMAN over ppp interfaces.
Date: Wed, 12 Jul 2023 14:28:33 +0200
Message-ID: <7752715.gsGJI6kyIV@prime>
MIME-Version: 1.0

Hi Peter,

you have to create a Layer 2 interface somehow on top of your serial link - 
L2TP on PPP may be one way to do it, but you stack quite a bit of headers and 
can't really use the broadcast nature of the medium as you say. I'm not an 
expert on those serial drone radios, there may be some better readily 
available solutions. You could send the Ethernet frame as is with some 
checksumming I guess. Channel access is probably not ideal either (there is no 
CSMA/CA or arbitration). 

How fast is your drone radio? I hope its more than 9600 baud ... :)

Cheers,
       Simon

On Wednesday, July 12, 2023 2:14:48 PM CEST Peter Milani wrote:
> Thanks Simon,
> 
> So to clarify, PPP relies on a higher level layer than what BATMAN uses? So
> you have to create an ethernet layer 2 interface using l2tp. But are more
> or less restricted to point to point routing in that case which l2tp will
> be travelling across.
> So there's no alternate method you're aware of that can make use of the
> general broadcast nature of the underlying radio... e.g.. from an
> application perspective, I can transmit a serial message from one radio and
> pick that message with multiple receivers?
> 
> cheers
> Peter
> 
> 
> 
> On Wed, 12 Jul 2023 at 21:55, Simon Wunderlich <sw@simonwunderlich.de>
> 
> wrote:
> > On Wednesday, July 12, 2023 6:29:50 AM CEST petermilani80@gmail.com wrote:
> > > Hi All,
> > > 
> > > I've just started using batman and was trying to see if I could get it
> > > to
> > > work over a serial radio link such as the simple serial devices commonly
> > > used in cheap drone telemetry. The goal here is to enable low bandwidth
> > 
> > but
> > 
> > > adhoc ip networking.
> > > 
> > > I had set up a pair of radios to connect using pppd and I was wondering
> > 
> > if I
> > 
> > > could utilise batman to try and create a mesh. An example of setting up
> > 
> > the
> > 
> > > serial ports as ppp interfaces:
> > > 
> > > $ sudo pppd /dev/ttyUSB0 57600 noauth nodetach 10.42.5.5:
> > > 
> > > That works fine but applying batman to that interface was unsuccessful.
> > > I
> > > think that was due to limitations in the ppp and interfaces created by
> > > pppd: e.g.
> > > 
> > > $ sudo batctl if add ppp0
> > > Error - failed to add interface ppp0: Invalid argument
> > > 
> > > The interface ppp0 was specified as POINTTOPOINT e.g.
> > > 
> > > $ ip link
> > > $  ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
> > 
> > fq_codel
> > 
> > > state UNKNOWN mode DEFAULT group default qlen 3
> > > 
> > > I'm not an expert in this so don't have full visibility of all the tools
> > > available.  I was wondering if there were better ways to set this up,
> > > possibly not using pppd? Any guidance would be appreciated.
> > > 
> > > cheers
> > > Peter
> > 
> > Hi Peter,
> > 
> > batman-adv requires an Ethernet compatible interface (Layer 2) to operate.
> > PPP
> > interfaces are Layer 3 interfaces (IP Layer), so that will not work. You
> > could
> > make a L2 tunnel over your PPP interface such as l2tp or vxlan and use
> > that.
> > Or perhaps there is a different/better way to enable an Ethernet Link over
> > your
> > drone radio directly ....
> > 
> > Cheers,
> > 
> >         Simon


--nextPart1998544.kXSN5OTJKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmSunHEACgkQoSvjmEKS
nqH41w/9FvrVLxtrX4+kNqecNc+hDw8fKg40LtjN4jP2Ao6b7HGgpj9/ZGvkHzko
GFBUlI1Qdt7qCuB0c2222qjVcrIyt4mQERBwpZawUPy9gsLH+ewiGgwIddZQsEYd
iPqP3/nB7lTNJqOpBJ0OVkDB8ox1ht4ZUSLscBhStwgoCJhEBuM8bKan1jI4fJsk
URloHBgwEncEPCHDnp+2JGuv9ap69ZPBHNRm3rPwulUWzQMO1daVX1l1yUcuraRX
CoDOTRYXT+DC4ykZL9gdzvuwnNIKdvVOYNrUCHi+9V8dqmueEeYUvq000I10ymiB
RBMv7y24JGKiXQ/OOxTLqTFecu7O//aRmQCgGgdgjSfVMGTj+DirKqHbC3/FAxCh
jNRnLPqPXsxcOlTQEg9tZaTvwYUliVGyKZB//a5RfiizGUThCfTr95xuNMgQKnJV
CpflvQyxYVHRkY45+U1FmdSUU3VKC00OHuYGG9/fsmSC0SpOxbasJ5qt3gYIXbPe
h6ZCzAOR8yPz80mEMn88P41UaG5AKRZuUeAFw2HXX1DJnnwehzK0QT/zZTF6+gnR
OZ2apgyY0e6zFOIcz5srF3Gtwh6yHST7VDxed0sq2jboGljz5bCg6hvi9cns/jv3
R91AY9vWhWvFbAldE8N6Cos0Oh2Ypj1P+5TlVjEYKBvqm9MOK50=
=soDe
-----END PGP SIGNATURE-----

--nextPart1998544.kXSN5OTJKJ--



