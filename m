Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF488F433E9
	for <batman@archiver.kernel.org>; Thu, 16 Apr 2026 05:47:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 354318562C
	for <batman@archiver.kernel.org>; Thu, 16 Apr 2026 07:47:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776318431;
 b=xwkp/V/uTGRkXPiZIausoAxmBewtqlh7hYjPk/m8qYzaVTsZr15decERKa810WJj52P+s
 CJ/UUKeSo/ihvmHfqECuZ3LWxaZqDiSsfQMjGpdJv6ef5lWKvmS3EO/QWTNTXTfTfvopA0q
 4ICh2ybM9q/3yZ4JyrNxUmOb4wI776Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776318431; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pYf/DV86EtMa/BhdUoYXh7hWbYU7DhF3ikWLRESaWr4=;
 b=FaQZgHqUoDO3m5Kk8BNvdOKIw42VqE9SOauQsHT++QLQJHIRVUa1rwzSeT2jjdFkwXXJv
 m16ELwUg3pN0sVSTHpWUDAM5bBImBJEeBWFVF6nrArZesp8FOsYbh/h1aL9MnWo8BMXyh4o
 WwTcLDSyk9cIL0zLFwqj5azKLPpY8eY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1F75683DCC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 16 Apr 2026 07:46:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776318400;
	b=nsO8ry7NjBNW/tNDs9w4JKebki/MET3YIqTl4bNXXj3BPvlP/rdUqDvMPb2a/eJ522mAU5
	6IwekqkGc6iESKkfVDF4YzRkm/1m/dlXeQqL9ZRw2BEyGnxOFbNHnFuvrzDTcWqwNnCqY/
	2gf02PZ4fPQ77uSf7j2dewhOw/g1DQk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=e2otKBYZ;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776318400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pYf/DV86EtMa/BhdUoYXh7hWbYU7DhF3ikWLRESaWr4=;
	b=zewB5hmdrklcX/604WbtYERCC8uzdkrVJ8GZds/HhELCrErw1xKP9uyCoQtncKFW2uqWCC
	R046DFfrtKawR5WS5ObzhsadFTxOrpemD9Urhc3veAduL7OeABueWpX9VFOWsOpbT+ExrH
	gg2TUYtAOu8dU4Ys68jcvCqMLq2+gwU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1776318389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYf/DV86EtMa/BhdUoYXh7hWbYU7DhF3ikWLRESaWr4=;
	b=e2otKBYZ4128Prxgx3qAXcLuULCCknK1nwI6fCc7+uuTavVXWNeqS2LpbRWeb0e7u0lqjZ
	k4FJx572lkImvkBpxOeTaTMmL6W9eXUE0B1DSGVA8fLKD/ZdMH7r3T8QMNCyPXprLtga3E
	gjbFRDXL6t8IQ0s9kq7rsvhX+5vwMABIqVJKuLMZ+bD5pW47SC1qghYaBlVBXLEXkyi4Iu
	D6TDXdQ5V7jQIJ4GGwc+yx2KbSxYCS/twc3LNsGqNrpW9CjQ0B+K18Qf5u26Aw5NOXv9AP
	WfAPnYNG/KBakW2XIXR26axiDIQV2R5bIFV/tDjWw5z4bLOdEbIZVtScIU1UhQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: martinvdberg@gmail.com, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Gateway shut down detection takes too time from other nodes
Date: Thu, 16 Apr 2026 07:46:28 +0200
Message-ID: <3233879.U3zVgo479M@prime>
In-Reply-To: <13667793.EVyyLHbfrO@prime>
References: <3735338.hdfAi7Kttb@prime>
 <177556961939.1631.5621807886524407791@diktynna.open-mesh.org>
 <13667793.EVyyLHbfrO@prime>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: QUUYOV7HBB6KBA2TBB3ZTYALEXY3C4LA
X-Message-ID-Hash: QUUYOV7HBB6KBA2TBB3ZTYALEXY3C4LA
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QUUYOV7HBB6KBA2TBB3ZTYALEXY3C4LA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wednesday, April 15, 2026 5:10:23=E2=80=AFPM Central European Summer Tim=
e Simon=20
Wunderlich wrote:
> Hi Martin,
>=20
> On Tuesday, April 7, 2026 3:46:59=E2=80=AFPM Central European Summer Time
>=20
> martinvdberg@gmail.com wrote:
> > I think I have a similar use-case as the original poster and ran into t=
he
> > same problem.
> >=20
> > Let me try to explain:
> >=20
> > - Given a mesh network where each node is assigned a *static IP*.
> > - In the mesh network there are some nodes acting as a Gateway.
> > - The other nodes in the mesh are clients.
> > - Using BATMAN-V
> >=20
> > Each client node has a script running, when it detects "batctl gwl" to
> > elect another gateway, the script will set the gateway's IP-address as
> > default route: "ip route replace default via $gateway_ip dev bat0".
> >=20
> > Now whenever a mesh-gateway is turned off, it will take 200 seconds bef=
ore
> > it is removed from the originators and only then "batctl gwl" will elect
> > another gateway. This results in some client nodes have no internet for
> > 200
> > seconds.
> >=20
> > So far, I haven't been able to get batman-adv (using batctl) to switch =
to
> > another gateway sooner, e.g. after 10 or 20 seconds.
> >=20
> >=20
> > Using DHCP is not an option in my use-case.
> >=20
> > Is there somehow a way to reduce the 200 seconds? Possibly by switching=
 to
> > BATMAN-IV?
> >=20
> > Regards, Martin
>=20
> that's an interesting use case, although I would like to make clear that =
the
> gateway feature was designed for DHCP in mind, yet you use it with static
> IPs. The main purpose was to re-route DHCP packets to the selected gatewa=
y.
> Nethertheless, you could still use this mechanism for "signaling".
>=20
> The gateway selection can be based on TQ or on bandwidth parameters, but
> there is no option to speed up the "dead marking" from the 200s of the
> originator timeout. you can decrease that number in the source code, but I
> would actually advise to use a completely different method independent of
> batman-adv - for example by using a layer 3 routing daemon, or another
> application which regularly signals their availability as a gateway. For
> DHCP (which it was originally designed for), lease times are typically 5
> minutes minmum, so the 200s timeout are not really a problem there ... but
> I acknowledge that it's not really useful for "fast" switching.

Perhaps one more practical idea: You could parse the gateway list and the=20
originator list yourself (batctl has json output options). Then, you could =
get=20
the "last seen" value from the originator list, and combine it with your=20
gatewaylist. In that way, you could easily filter the "best gateway which w=
as=20
last seen <20 s" in a script. This doesn't help with batmans internal DHCP=
=20
forwarding, but since you use static IPs anyway and probably already use a=
=20
script to get the current gateway to look up the IP, this may be an easy fi=
x=20
=2E..

Cheers,
       Simon




