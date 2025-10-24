Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB68FCCD1A5
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 10:03:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3AC798190B
	for <batman@archiver.kernel.org>; Fri, 24 Oct 2025 12:03:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1761300216;
 b=WSnYCdQlXkwML4j1VrDzhTOsLPKm7Gt4ILTKb7DNLJY2SWlctITZW0cJ7PB4U7ILLgtfp
 2ogkM9/hwNLDCeZlAyZY2sCqeIjCplCAsIo+QJc+aZ45Ssq9pDggCQnol7yXA4P5kHaCQSW
 PLKVHNBI5Nly90lG+30ucbabgz+9DhQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1761300216; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2/QaDQ6D4wsdtaHzsCyAZeip4UsZW1l+inN7auHlcOw=;
 b=4IT2I00X3gQ3bJFJbFl8sIswh1XxzTegiY0wirx9u7aEsEbT6au16sRZPicu1PbU4W4WN
 /en58q+MDsL1z+Q2S0Th5JEx9JKhZfCGR4sFZGheyImiwKUBplzrrI9JoZIt1iGkMYThQvz
 dsZLITwGbG1SifYXrJwVN2UvKNsPJ0E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CC89B81067
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 24 Oct 2025 12:03:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1761300213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/QaDQ6D4wsdtaHzsCyAZeip4UsZW1l+inN7auHlcOw=;
	b=s7OjwdUqYHPOK1gGAnMDua0zFur+nXK+PeXOEEBtwd8RU7u/sva1WuAJWSF4JRB6IAxr6C
	9AXpPVR9sIwbRIuilhz7EMDhsOp1oNuT4tH0uMEVWbXp1j7NkXPqtlI5yHWpA6Cr+DQF5H
	kE8z2Qe10RgfLZWsZz/HFUW0XR+Tcuo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1761300213; a=rsa-sha256;
	cv=none;
	b=EFYFOsVGSjSFmljSw6aCg8y3AtDIhdKybT01ehNEKu5AZ/Hlub2p1FeRiCgK+grwVQnDDV
	mn/fp1S0nLXA5+U7YKqlWG6E5jbBmvA5UKalti+R61w6XisLkHcSC0x3HL0QqgbvzD5DA5
	zDKxHu084ai1Y/2dtwb6SM0f6Glgc3c=
Received: from prime.localnet
 (p200300C5970781D8B076411Bb4C554a3.dip0.t-ipconnect.de
 [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 49734FA130;
	Fri, 24 Oct 2025 12:03:23 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: mbiglari4@gmail.com
Subject: Re: Gateway shut down detection takes too time from other nodes
Date: Fri, 24 Oct 2025 12:03:22 +0200
Message-ID: <3735338.hdfAi7Kttb@prime>
In-Reply-To: <176122249070.1493.7302683075039006895@diktynna.open-mesh.org>
References: <9767419.DvuYhMxLoT@prime>
 <176122249070.1493.7302683075039006895@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: O565IWXPBY4MAPF46ZYIUU5AES2ULSPF
X-Message-ID-Hash: O565IWXPBY4MAPF46ZYIUU5AES2ULSPF
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/O565IWXPBY4MAPF46ZYIUU5AES2ULSPF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thursday, October 23, 2025 2:28:10=E2=80=AFPM Central European Summer Ti=
me=20
mbiglari4@gmail.com wrote:
> Dear Simon,
>=20
> I have a mesh network with three nodes that use 802.11s for the PHY and M=
AC
> layers, and BATMAN-adv on top to provide routing and mobility. Two of the
> nodes act as gateways, and the other functions as a client. The client
> selects the best gateway based on throughput.
>=20
> Currently, I don=E2=80=99t have a DHCP server in this network =E2=80=94 e=
ach node has a
> static IP address. The issue I=E2=80=99m encountering is that when the se=
lected
> gateway node turns off, the client takes too long to switch to a new
> gateway. All nodes are using the BATMAN V routing protocol.

The setup is still not really clear to me. If you are not using DHCP but us=
e=20
static IP addresses, how do you do the selection of the best gateway? Is th=
is=20
a functionality of batman-adv, or a script?

batman-adv has the gateway feature [1] which optimizes the gateway based on=
=20
throughput, but this is useful only with DHCP enabled - because it redirect=
s=20
your DHCP requests, nothing more, nothing less. This mechanism is rather sl=
ow,=20
and changes will only happen when the IP address renewal is due.

You may also have interconnect your gateways with Ethernet, use a bridge, a=
nd=20
enable BLA (bridge loop avoidance) in batman-adv. But it's not clear whethe=
r=20
you do that.

Please explain your network setup in more detail, then we may be able to he=
lp.

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Gateways

>=20
> I believe this delay could be reduced by factoring the last connection ti=
me
> into the throughput calculation. For example, if you=E2=80=99re using an =
EWMA
> filter, you could treat a node that has been disconnected for more than 10
> seconds as having a throughput of zero. This would cause the EWMA value to
> drop quickly, allowing the client to select a new gateway sooner.

I can't really comment here unless I know which component in batman-adv wou=
ld=20
interact with, as explained above.

However, if you have an idea, you can also go ahead and implement those thi=
ngs=20
yourself in batman-adv and try it out. Please note that BATMAN V is still=20
considered experimental, and most networks I work with are running BATMAN I=
V.

Cheers,
      Simon


