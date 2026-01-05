Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C78C2A072
	for <batman@archiver.kernel.org>; Mon,  5 Jan 2026 09:08:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BB402858BD
	for <batman@archiver.kernel.org>; Mon, 05 Jan 2026 10:08:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1767604098;
 b=GOPt4IqjmATa0Q2jNOxGP1St1/VAIV5tUjKYwY6eXYGlLwIz2IcwaylZEre4GpImacl5J
 tYPyeToU7OZzmr7jR7en7rUO1KSc/ieRH9/alsZrbj2S85S4oM5B8gUQw5toHGNOTmdKk+C
 PJ/quAXxssTDM3OrEzIfX8kz/R77NIc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1767604098; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qWTGlUp90WDXb6MFSuLdKdK+Nrp8Zx+2kOVO+PwAxfA=;
 b=MFYqy0r/1CxAf3bK4B5cSazJ91gr0g+fJyOuBuIcKpTa4CWTs4wvHknkSsrWQICdlQKaT
 1tZpKjEd5y6dzZbIlaaySwO0lMjOAYQ4VUyUquoeDxETx9j3sRQuRH+EVfo42u6rB0uTDZR
 0GJqknrCy2tqSDzTFqD7w0NI3G5RIYQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 53B7585587
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 05 Jan 2026 10:07:45 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1767604076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWTGlUp90WDXb6MFSuLdKdK+Nrp8Zx+2kOVO+PwAxfA=;
	b=okc73HSbrGwpNjO9jU5Pr0HVjxT37OfbhDAVf86oBA6HBMdDUOtFWI1XBrmxvEei0pXY+c
	bwyNKv8GINTn7Mln0YitNXGnz2BWa9V4/8SYNN7H/AmoATmAvBj7REuN8tt91LI8wKLWgJ
	92Csgg0gU//bxSUVb3I6aud9yY3Izcs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1767604076;
	b=yVdfrN9IZ0IBKEnNXRfmZubONUYSVPO7eYII/JrrBtVQUXntbZZqRDlgIpD63IEDcQF432
	EijZGFS6zwMOVZNibniXgcbcizwILaheRDFNnezBF4lQXovN7UxU/7LzudCfv27hrsJl/7
	k9CtJuR/0YWFEZSjrBspJ2dvyl623rg=
Received: from prime.localnet
 (p200300c5974Ad8d8a778D970b1253618.dip0.t-ipconnect.de
 [IPv6:2003:c5:974a:d8d8:a778:d970:b125:3618])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BEFD7FA130;
	Mon,  5 Jan 2026 10:07:44 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: "Valent@MeshPoint" <valent@meshpointone.com>
Subject: Re: Restarting MeshPoint =?UTF-8?B?4oCT?= seeking advice on routing
 for
 crisis/disaster scenarios
Date: Mon, 05 Jan 2026 10:07:44 +0100
Message-ID: <4760451.kQq0lBPeGt@prime>
In-Reply-To: <em1e8ae4ba-b0f7-4a25-8bf3-1964f746b2ef@meshpointone.com>
References: <7007a140a5226e6283b848128d97ca03fa49f1e8@meshpointone.com>
 <em1e8ae4ba-b0f7-4a25-8bf3-1964f746b2ef@meshpointone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: CLL7YYKEZEPR34V2I5S66CLZJUGDVNNT
X-Message-ID-Hash: CLL7YYKEZEPR34V2I5S66CLZJUGDVNNT
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Valent,

thank you for your interest and sorry for the late reply. The time before=20
Christmas is usually a bit hectic ...

I would suggest to look into the "gluon" Freifunk Firmware [1], including t=
he=20
batman-adv parameters made there. There are setups with a couple of hundred=
=20
nodes, although some sparsely connected over cities. Those setups have been=
=20
used and tested for a long time on different types of hardware.

A few general suggestions for tuning for those scenarios are:

* set up a high multicast rate, at least 12 MBit/s, perhaps 24 or more. You=
=20
will trade scalability with range

* choose a higher than default OGM interval, e.g. 5 seconds instead of 1=20
second. This makes batman-adv reaction time slower, but helps scaling with=
=20
many nodes. Each node would repeat any other nodes OGM messages, which resu=
lts=20
in O(N^2) OGM messages per interval.

* if you don't need encryption (SAE), turn it off. SAE by default does a pe=
er-
to-peer handshake, which can kill a dense network with many participants in=
=20
one place, if everyone wants to handshake with everyone else at the same ti=
me.

There are a few more things (e.g. reducing basic rates) which you may find =
in=20
the gluon firmware and other places.=20

As you can see, some of those suggestions are more Wi-Fi layer specific tha=
n=20
batman-adv specific, and would help with other protocols (e.g. babel) as we=
ll.=20
=46rom my experience with network simulators/emulators, you may verify prot=
ocol=20
specific behavior (e.g. number of messages, failover time) to some extent. =
But=20
testing Wi-Fi specific scaling effects like failing SAE handshakes, effects=
 of=20
multicast rates, etc is rather hard - even if you use emulators based on=20
mac80211_hwsim or so which partially emulate 802.11. For those experiments,=
=20
it's best to actually set up 10-20 devices ...

Cheers,
        Simon

[1] https://gluon.readthedocs.io/en/latest/

On Saturday, December 20, 2025 11:43:20=E2=80=AFPM Central European Standar=
d Time=20
Valent@MeshPoint wrote:
> Hello,
>=20
> I wanted to follow up on my previous message. I did not see any replies,
> so I hope it is ok to share one concrete finding from recent testing in
> case it helps the discussion.
>=20
> To move beyond purely theoretical arguments, I have been running large
> scale tests using meshnet lab
> https://github.com/mwarning/meshnet-lab
>=20
> The main reason for choosing it is that it allows replaying real world
> community network topologies, including Freifunk graphs, instead of
> relying on synthetic grids or ideal meshes. This makes it easier to
> observe behaviour under sparse, asymmetric, and imperfect conditions
> that are closer to what actually gets deployed.
>=20
> One interesting observation so far is that results can vary
> significantly depending on how nodes are brought up and how control
> plane load interacts with the topology. In other words, the same
> protocol on the same topology can behave very differently depending on
> timing, churn, and scale effects, even when the underlying links are
> identical. This was not obvious to me before testing at this scale.
>=20
> I am curious whether others here have used meshnet lab or similar
> namespace based emulation tools for BATMAN adv testing, and if so,
> whether your observations matched real deployments closely, or if there
> are known caveats when interpreting the results.
>=20
> Any feedback or pointers would be appreciated.
>=20
> Best regards,
> Valent
>=20
>=20
> ------ Original Message ------
>=20
> >From "Valent Turkovic" <valent@meshpointone.com>
>=20
> To b.a.t.m.a.n@lists.open-mesh.org
> Date 16.12.2025. 16:37:01
> Subject Restarting MeshPoint =E2=80=93 seeking advice on routing for
> crisis/disaster scenarios
>=20
> >Hi everyone,
> >
> >My name is Valent Turkovic.
> >
> >Between 2015 and 2018 I ran the MeshPoint project =E2=80=93 a simple, ru=
gged Wi-Fi
> >hotspot designed to work in very tough conditions.
> >
> >During the refugee crisis in Croatia we deployed these devices in camps =
and
> >transit centers, providing internet connectivity for humanitarian
> >organizations such as the Red Cross, UNICEF, IOM, Greenpeace, and many
> >smaller NGOs. Through these deployments, more than 500,000 people were
> >able to stay connected. The same system was also used in flood response
> >and other emergency situations. The project received the =E2=80=9CBest
> >Humanitarian Tech of the Year=E2=80=9D award at The Europas in 2016.
> >
> >Unfortunately, financial constraints forced me to pause the project after
> >2018. It was entirely self-funded, and the prolonged stress eventually l=
ed
> >to long-term health issues.
> >
> >Over the years I stayed in contact with first responders and field teams
> >from organizations such as WFP, UNICEF, the Red Cross, and various NGOs.
> >The feedback has remained consistent: when disasters strike, whether
> >earthquakes, floods, or large-scale displacement, teams still struggle to
> >bring up reliable communications quickly. What they need most is a mesh
> >network that works within minutes, not hours or days, and that continues
> >operating on battery power when infrastructure is down.
> >
> >I am fully aware that in active conflict zones Wi-Fi can be jammed or
> >restricted, for example due to drone countermeasures. However, there are
> >many other scenarios where Wi-Fi mesh remains extremely valuable:
> >evacuation centers, field hospitals, temporary shelters, flood-affected
> >villages, and coordination points for responders. In these environments,
> >fast, robust, and easy-to-deploy networking makes a very real difference
> >for coordination, family contact, and medical or logistical data sharing.
> >
> >Because of this, I am now restarting the project as MeshPoint V2. The fo=
cus
> >is updated hardware, improved battery life, and even simpler deployment,
> >while keeping the original goal: crisis response and off-grid or
> >underserved communities.
> >
> >In the original MeshPoint we used Babel. This was largely driven by
> >practical constraints at the time: our deployment tooling was based on
> >Nodewatcher, which was Babel-only. Technically, Babel served us very wel=
l.
> >It converged fast, was reliable, and worked nicely for small to
> >medium-sized networks.
> >
> >At the same time, I am well aware that many community networks and
> >real-world mesh deployments successfully used batman-adv, often through
> >Gluon or custom firmware builds. In larger, more dynamic, or highly mobi=
le
> >topologies typical for crisis scenarios, the layer-2 approach and seamle=
ss
> >mobility properties of batman-adv are very attractive, especially when
> >nodes are frequently moved, powered on and off, or replaced in the field.
> >
> >For MeshPoint V2 I am evaluating batman-adv and would appreciate insights
> >on the following aspects, specifically in the context of crisis and
> >emergency deployments:
> >
> >Behaviour at larger scale in real deployments
> >In crisis scenarios networks often start small but can grow quickly as m=
ore
> >nodes are deployed by different teams or organizations. We are interested
> >in how batman-adv behaves when scaling to hundreds or more nodes in
> >non-ideal, real-world conditions, without centralized planning and with
> >limited ability for on-site tuning.
> >
> >Performance in sparse or highly mobile topologies
> >Nodes in the field are frequently moved, turned off, replaced, or
> >temporarily isolated. Vehicles, backpacks, and mobile command posts
> >constantly change network topology. We are looking for practical
> >experience with how well batman-adv handles frequent topology changes,
> >intermittent links, and sparse node placement without requiring constant
> >manual intervention.
> >
> >Suitability for battery-powered and intermittently connected nodes
> >Many nodes run on battery for long periods and may sleep, reboot, or
> >disappear entirely when power is lost. Low overhead, predictable
> >behaviour, and fast recovery after reconnect are essential. We are
> >particularly interested in any known trade-offs between routing
> >performance, control traffic, and power consumption in such environments.
> >
> >If there is existing work, documented limitations, field experience, or
> >design guidance relevant to these constraints, pointers would be greatly
> >appreciated. The goal is to build a system that field teams can deploy a=
nd
> >rely on under stress, without requiring deep networking expertise on sit=
e.
> >
> >Thank you for your time, and thank you to everyone who has contributed to
> >making mesh networking viable outside of labs and into real-world,
> >high-stakes situations.
> >
> >Best regards,
> >Valent Turkovic
> >https://www.meshpointone.com/
> >
> >Technical specifications of the original MeshPoint (for reference):
> >https://www.meshpointone.com/technical-specifications/




