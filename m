Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8E8CFA742
	for <batman-adv@archiver.kernel.org>; Sat,  5 Oct 2024 15:37:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 780F483C93
	for <batman-adv@archiver.kernel.org>; Sat,  5 Oct 2024 17:37:44 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728142664;
 b=p6XakoUSHpqnuc/W/MhR78areTo8qqegF+GStJnXMovSzuNEfrFxFCdyJ81DbQmw/0h2f
 xEbzLquVQKAYrcV7mv4eWjYOCxb9TEUkcaIgigzlJ84I3WnuLaa0LZMhR2Pd9pPZm8gzfGT
 Yyx40DFlvbC3yy2/HtLcMda796oyLSw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728142664; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gYhQcjjQR1M/3oPaA4KbHCrzcvH4T8IN8XreD/CxFqw=;
 b=fGuD4kDxckvxtJ2ItTt9vMyC1eQwaR6frejFiclxrfr8OK9hewSyx8RXiHHvha5vSQYRm
 9yMd3l5QjoLUFrEPgs1HYdHIO0DBM63LXaiW3EAb0RkYNyQSV05+uSIGsA2C/ikN4AHYE4J
 2LPS2TWsPmIH4TW1uAKET/9ufHkM0OY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 703148115D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  5 Oct 2024 17:37:26 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728142646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gYhQcjjQR1M/3oPaA4KbHCrzcvH4T8IN8XreD/CxFqw=;
	b=K23D9zw5TnnleWcrNozDLDy9HUP0cHJrE+Cfqs4WXoUiS3peVcJCYxrYId25FK5EIIJl/t
	he56o/B+2RwlgwUxbm7hGs9nePrMe4cgF4Af5gIze+P58wq7Ov3F9wxROUOi45OxFmuiL6
	IMkOtYKPA8wo9ny0kTNZyDYDDcmPWX4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728142646; a=rsa-sha256;
	cv=none;
	b=jPFMX+M2zmFOFZM2k1muDRsnKYcDOcfNH3YNm3tLZ7cCDW7whLQ4hhPoum7YcxjQatRVdi
	qtXXhTIhzfl9DzI5GMeMqiHHv7m4sqV/z3+thqRJO4EaJNjfe+hGS0FjbeAs88wrkBRCqU
	EvB3EYjF1uFva67hRNDtU0qbFyz6ceU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=b7r1phKF;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1728142645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYhQcjjQR1M/3oPaA4KbHCrzcvH4T8IN8XreD/CxFqw=;
	b=b7r1phKFlpIwdpBXAQFqbag462L8ozwbqBQAF2IApYcXPYWmlP/KgbBT0kO2Hjy+IHccWq
	NMmESzVYx69dDyaPIH7au9Nx063zvKkrRP2OYKQmtRf/GnH5LYoNFhptTEV+dhaHj/wcWC
	QgjLidX/C1I4jgIl+7q0lchods1L/yM=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH] batman-adv: mcast: add option to forward MLD reports only to
 mcast routers
Date: Sat, 05 Oct 2024 17:37:19 +0200
Message-ID: <1944646.tdWV9SEqCh@sven-l14>
In-Reply-To: <20240831194528.1932-1-linus.luessing@c0d3.blue>
References: <20240831194528.1932-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2243534.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: TNJG6C6ZQOI5S6RGOJXSDRPPBEOJEN5U
X-Message-ID-Hash: TNJG6C6ZQOI5S6RGOJXSDRPPBEOJEN5U
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TNJG6C6ZQOI5S6RGOJXSDRPPBEOJEN5U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2243534.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 05 Oct 2024 17:37:19 +0200
Message-ID: <1944646.tdWV9SEqCh@sven-l14>
In-Reply-To: <20240831194528.1932-1-linus.luessing@c0d3.blue>
References: <20240831194528.1932-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Saturday, 31 August 2024 21:45:28 CEST Linus L=FCssing wrote:
> In most setups it is sufficient for us to only send MLD reports to nodes
> which have a multicast router attached. Which reduces overall overhead,
> especially in large batman-adv mesh networks, where broadcasts are
> particularly undesirable.

What is the situation before. How does this change try to modify the behavi=
or.=20
Why is this good?

It also doesn't mention anywhere that the old (multicast filter) behavior w=
as=20
just to handle IPv4/IPv6 messages and it is now expanded to=20
IGMP_HOST_MEMBERSHIP_REPORT + ICMPV6_MGM_REPORT.=20


>=20
> However there is one specific, known issue / broken scenario with this
> setting:
>=20
> If the IGMP/MLD querier is configured directly on the bridge on top of
> bat0. But there is no multicast router on or behind this node. Then this
> bridge will be unable to detect multicast listeners on/behind other
> nodes which have the MLD-RTR-ONLY setting enabled. (A workaround for this
> can then in turn be to set multicast_router=3D2 on the bat0 bridge port
> on the node with the IGMP/MLD querier.)
>=20
> Therefore MLD report flooding is kept the default and MLD report to
> multicast routers only forwarding is considered experimental and
> warned about.

Most of the text here seems to suggest that (whatever reason you want to=20
enable it), you should most likely not do it because it just creates more=20
problems.


The commit message doesn't show me why I should apply this change in the fi=
rst=20
place - especially when it just causes more headaches in the end.


Another headache I get is the "Warning: MLD-RTR-ONLY is experimental and ha=
s=20
known, broken scenarios" part. Which seems to suggest to me that there migh=
t=20
be changes in the future which will cause more problems if I just apply thi=
s=20
patch now - and in this process create ABI incompatibilities or "no=20
regression" conflicts later.

Btw. BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED seems to suggest that it is=
=20
about MLD - but it seems to be also about IGMP. At least I didn't expect th=
is.

Kind regards,
	Sven
--nextPart2243534.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZwFdMAAKCRBND3cr0xT1
y4FUAP9csX5EKsTdh6t4SoGGIHvo0g16Mm/bkTHFpW+Hm8osaQEAkbZNRD3C9YMd
NcVguK0eOzEvkptpYQOPMDmD7BnwvgE=
=Uh+z
-----END PGP SIGNATURE-----

--nextPart2243534.irdbgypaU6--



