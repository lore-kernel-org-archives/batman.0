Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC73F36C5C
	for <batman@archiver.kernel.org>; Mon, 20 Apr 2026 12:06:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DB98F858C9
	for <batman@archiver.kernel.org>; Mon, 20 Apr 2026 14:06:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776686813;
 b=DrhCjy/JoVv6H7n6oabRIydt2GsFfa68OMpwcrf3WR5F0rBEbDcjsAVdHcdEz7exyOMsE
 +foP1rhvxOcgdoAaFfhjeXOKzw29dJBV89PhR/709sZuT0eyHULfXlteKl0PKFHdh4fpGv0
 49JsAc7IYozL+iEpfmZDYKJ4DwE4GMs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776686813; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HwD+ieIXBMkELbsH7yoJMBlZvdZwoUCke5Jryc1Sl2Q=;
 b=G78mgCzBFwF/KENmIcNdqLDffVdfUjb2vFVLyfzfEhDjnlO87vD8iG+iBobPK9WdQ8tvg
 Pxf0TqYUIu/lTJIdzwnuP3wg3Wxz/oTB7QrwTEHe9EmA00pRuSywmkZWEmZjE2MQK/yoPYn
 FA60KRcbR8O4dyp7Q2EWBoX+jbnfZAI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 38EFD8033A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 20 Apr 2026 14:06:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776686783;
	b=kR2gJED9OoBw5/6tv1m8roFm2MBsZDzFUtLrDNeOPUSMrQyCaKu37HYwOBaXSMh1h5c04N
	fdQxBG7cDKNs1VRvYzro5yjcm0wTXX8jsAjrlIwVUMDuLtiCv7VQrbPrX7QbCVM+9PDBX8
	gWkgNfsjRI5zET50VGgcVNbnzPSeSoU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=HgKq3uRs;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776686783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HwD+ieIXBMkELbsH7yoJMBlZvdZwoUCke5Jryc1Sl2Q=;
	b=yiZiiQnDwwUjk5swpl9sdtLWsIMxz7PMWzKkKC+2owQpOUo6b4B1Soj7gPDfe1kTYmxjl0
	rwtaPlzQauA657h+k6oWmST7Htiz+O5khCHVKePKr8D8jiqn2qBo+HFyEfSk91LlYRHlRX
	cayDi8h180amnmS3M8SrETDKkNHs/xI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1776686770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwD+ieIXBMkELbsH7yoJMBlZvdZwoUCke5Jryc1Sl2Q=;
	b=HgKq3uRsySOQEkxwu8+YNfeW7KaNFlUXCiQYWtV8vDFna+obyztBKByBcrGKL3RW+Lg77f
	WDDbTLqvxYFUKqiJ09Vt2Vxlus1be3xuhzLtanE8OAOldxSgGGwnxdF/lIQ0xI39bLIgyk
	AnMVtdQ4W0GLeNWRHZMoSX5lH4uVU2odo2AqnFJwnn8hLwykjfg/ePI/pyyVdDsLgn+0sE
	J5qoAx7RUXom5Dvmn2bbgOOGiutDhzWGB45Le7hCr9zkbxg++HarqZO0AU+Vy2URPWyuHQ
	8f7XWhQAs+vaX5rsE6nMJgPTJfpRFb1BajF2rgU/xvT7+144HRhLdHgsnH/dtQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Martin <martinvdberg@protonmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Gateway shut down detection takes too time from other nodes
Date: Mon, 20 Apr 2026 14:06:09 +0200
Message-ID: <7831023.jRhZ6ZUK3Y@prime>
In-Reply-To: 
 <Y7MSNnrQG9nc9mStihbiD3_QRV6QRc7K_7cBn5fJo-2Zzvu-XnKJ2E_z0wElZXZUrPGnpBKDasjjLryDqg5z8Y9jHdf7M4696K_kFweOlsk=@protonmail.com>
References: <3735338.hdfAi7Kttb@prime> <3233879.U3zVgo479M@prime>
 <Y7MSNnrQG9nc9mStihbiD3_QRV6QRc7K_7cBn5fJo-2Zzvu-XnKJ2E_z0wElZXZUrPGnpBKDasjjLryDqg5z8Y9jHdf7M4696K_kFweOlsk=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2205804.VsPgYW4pTa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BKETKKDTWNQDGAHOBVQMU7HXJNX6WYA4
X-Message-ID-Hash: BKETKKDTWNQDGAHOBVQMU7HXJNX6WYA4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BKETKKDTWNQDGAHOBVQMU7HXJNX6WYA4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2205804.VsPgYW4pTa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Martin <martinvdberg@protonmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Mon, 20 Apr 2026 14:06:09 +0200
Message-ID: <7831023.jRhZ6ZUK3Y@prime>
MIME-Version: 1.0

Hi Martin,

I'm answering without PGP - your previous mail was encrypted so I guess oth=
ers=20
can't read it. I hope you don't mind. Please see inline:

On Friday, April 17, 2026 9:49:13=E2=80=AFAM Central European Summer Time M=
artin=20
wrote:
> Hi Simon,
>=20
> Thank you for your reply.
>=20
> I=E2=80=99ve considered your suggestion, and it sounds feasible. The only=
 issue I
> can think of is how to select the best possible gateway at the application
> level in this scenario. Wouldn=E2=80=99t this result in duplication of lo=
gic?

You are right, you may end up having some similar logic compared to what=20
batman-adv does internally. I don't think this is much of a problem, since =
you=20
would be re-using the same data but have a (slightly) different interpretat=
ion=20
of it. The original batman-adv code doesn't (directly) care about the last=
=20
seen time after all.

>=20
> For the time being, I=E2=80=99ve patched the batman code to reduce the ti=
meout from
> 200s to 20s. This works fine.

Glad to hear! If you don't mind that the originators time out quicker, then=
=20
this could just be sufficient as well. Some other users may have even stric=
ter=20
timing requirements (e.g. less than 5s or even 1s) which may not work with=
=20
this approach, though.

>=20
> It would be great to have this timeout configurable via batctl. Is there =
any
> chance that such a feature could be implemented in the near future?

Personally I don't have plans to do so. This is quite a corner case, and we=
=20
generally prefer to expose only few defines/variables to keep things simple=
=2E In=20
a typical community network (Freifunk etc), 20s OGM timeout might be less t=
han=20
the TQ window size (5 entries * 5s originator interval), and create other=20
problems. I don't see a general case where we want to change it, and I gues=
s=20
you have two options now (change the one line in the source or indirectly u=
se=20
the gateway list), so that's satisified too. :)

If there is more general interest to this, you can also write a patch if yo=
u=20
like.

Cheers,
       Simon

>=20
>=20
> Regards, Martin
>=20
> Sent from Proton Mail for iOS.
>=20
> -------- Original Message --------
> On Thursday, 04/16/26 at 07:47 Simon Wunderlich <sw@simonwunderlich.de>
> wrote: On Wednesday, April 15, 2026 5:10:23=E2=80=AFPM Central European S=
ummer Time
> Simon
> Wunderlich wrote:
> > Hi Martin,
> >=20
> > On Tuesday, April 7, 2026 3:46:59=E2=80=AFPM Central European Summer Ti=
me
> >=20
> > martinvdberg@gmail.com wrote:
> > > I think I have a similar use-case as the original poster and ran into
> > > the
> > > same problem.
> > >=20
> > > Let me try to explain:
> > >=20
> > > - Given a mesh network where each node is assigned a *static IP*.
> > > - In the mesh network there are some nodes acting as a Gateway.
> > > - The other nodes in the mesh are clients.
> > > - Using BATMAN-V
> > >=20
> > > Each client node has a script running, when it detects "batctl gwl" to
> > > elect another gateway, the script will set the gateway's IP-address as
> > > default route: "ip route replace default via $gateway_ip dev bat0".
> > >=20
> > > Now whenever a mesh-gateway is turned off, it will take 200 seconds
> > > before
> > > it is removed from the originators and only then "batctl gwl" will el=
ect
> > > another gateway. This results in some client nodes have no internet f=
or
> > > 200
> > > seconds.
> > >=20
> > > So far, I haven't been able to get batman-adv (using batctl) to switch
> > > to
> > > another gateway sooner, e.g. after 10 or 20 seconds.
> > >=20
> > >=20
> > > Using DHCP is not an option in my use-case.
> > >=20
> > > Is there somehow a way to reduce the 200 seconds? Possibly by switchi=
ng
> > > to
> > > BATMAN-IV?
> > >=20
> > > Regards, Martin
> >=20
> > that's an interesting use case, although I would like to make clear that
> > the gateway feature was designed for DHCP in mind, yet you use it with
> > static IPs. The main purpose was to re-route DHCP packets to the select=
ed
> > gateway. Nethertheless, you could still use this mechanism for
> > "signaling".
> >=20
> > The gateway selection can be based on TQ or on bandwidth parameters, but
> > there is no option to speed up the "dead marking" from the 200s of the
> > originator timeout. you can decrease that number in the source code, bu=
t I
> > would actually advise to use a completely different method independent =
of
> > batman-adv - for example by using a layer 3 routing daemon, or another
> > application which regularly signals their availability as a gateway. For
> > DHCP (which it was originally designed for), lease times are typically 5
> > minutes minmum, so the 200s timeout are not really a problem there ... =
but
> > I acknowledge that it's not really useful for "fast" switching.
>=20
> Perhaps one more practical idea: You could parse the gateway list and the
> originator list yourself (batctl has json output options). Then, you could
> get the "last seen" value from the originator list, and combine it with
> your gatewaylist. In that way, you could easily filter the "best gateway
> which was last seen <20 s" in a script. This doesn't help with batmans
> internal DHCP forwarding, but since you use static IPs anyway and probably
> already use a script to get the current gateway to look up the IP, this m=
ay
> be an easy fix ...
>=20
> Cheers,
>        Simon


--nextPart2205804.VsPgYW4pTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmnmFrEACgkQoSvjmEKS
nqGVyg//fOnFClpxD+eDi3w4EsbTWh7JqxYzWFFZUwefmaLcYoIlRx83tpq6fhC+
/9ViE5ofuhlBQBwxrKPde0jq9SBwUORrsm1Yttx6W+i5NRTO23/DxuN7waVYhGef
GpsjGq1n0IBicteq8dJ9z/pQqr8tcJmuhWz5rvR42HYFGVR4FfSpwapr5RxrV3V7
DvHfNUqHzLCu6oRbS9t+TI7+11H7JI+GAcS14tAyBc/UWI6UaGhJfUT+PFlkKDzO
DL4Obb3oOG+pw2w1G6CrhaX+aAdH9i9ieQzf+8Aq4vHnIufDOX323J8QG9sIKyzN
Rls3YOylmYJ7L6eMGB5od7wQlQr/auRokejKXluA0vbAC5XwmLBPEhZY5M5awJ6t
J/dFXaFs8fm8jGC3ZP+x1RDk6UIG90d3OArKqUhQ7+DX0kHSoagU14RpS0nIbDUm
+mYOF0ewM/TV/9S5p27cp3DmBzHB6pHIXyBM4LlIekajxR3TI75PbfHyNC6AfA4/
44G3u/jx19iQ7HvfL5MvAs0PLQVZW1Mfv9Ho9dl9WOPNO8fXUEPtsYz+IlFzlKNN
pTfdj47uHjUmA2yXiV8R34Ot3bGflLnvT6jS6VJmLW9QGWmFFHZ4QkGkEJV+zwSa
yOenMhcvLSVSoweZx01A08SJX7ye2i8DKQPqTkSNGWkTZPKCC6g=
=IqYk
-----END PGP SIGNATURE-----

--nextPart2205804.VsPgYW4pTa--



