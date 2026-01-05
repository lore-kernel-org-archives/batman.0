Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8829C79F8B
	for <batman@archiver.kernel.org>; Mon,  5 Jan 2026 13:14:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F140A858E3
	for <batman@archiver.kernel.org>; Mon, 05 Jan 2026 14:14:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1767618842;
 b=wC4wbbj2QSxWmTxqFOGaPIjzo/RSGgrbeaXVc+LWuVifS7glCZL1Gw0q9Yl0kHftnU7Px
 JjCTX8478astf6LD4z1FuBNIcNm0MXkrRPCYureqMCgebhfOiAKDhfZpgxjCLoglG0TcV8g
 OgoFwxFFVjKBJ+2oQlKU0PW0IZiO4eg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1767618842; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rp04kI3Su9hWiJ3p6p13aMrffMO+YW0CaLzgd5asCt4=;
 b=o5fLT8V8HRGfj4SX0c7oY+IG248jFusVPuA2kXorcjNOVU1gxH/sTuhH3NDqtpCCfrqEj
 wkfNse4sRML3a3mO1IDp1gX4P5nNxL+sB6XidgwwugEnwEumcFr9xRj0RRBJP9lCjjnfC2q
 2im/bTHGXPN/097MMYZNGfzKcbV0qRg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9BF4D81AB9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 05 Jan 2026 14:13:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1767618820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rp04kI3Su9hWiJ3p6p13aMrffMO+YW0CaLzgd5asCt4=;
	b=WIRJxctrrJTJfuyPyVsWBkq+r2lVdlmElQSeZ+dxWH6nh5Ntmo6oc3+hisxZeMNp6pbYy7
	f0xsNzf0DtExleZSEgdBBrFijaMk3EwXVW29hQ5uh3/bGeE2bbjh1lfHtFs4I/LveBo8f7
	GAwfHIq+Y8A/nQ9lvPs98NPy5ygr/w8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1767618820;
	b=zVOGYlwa0uQdKTsFgFiP/Qg9nN+wGBcSxdhQViy0rneZKvjUqX2OUIGv7bZlUNg35YGZ00
	6aqpHqZcVXtbSUeICly6V8r7yZ32gchwvsAvk6p/abQ86Ug9l6HXWldV/ABTsV7+cOY+Yc
	0Hrkgtb2ZJfno3O9g1ZflLGDdoWq0rc=
Received: from prime.localnet
 (p200300C5974Ad8D8a778d970b1253618.dip0.t-ipconnect.de
 [IPv6:2003:c5:974a:d8d8:a778:d970:b125:3618])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D28EBFA130;
	Mon,  5 Jan 2026 14:13:29 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org,
 "Valent@MeshPoint" <valent@meshpointone.com>
Subject: Re: Restarting MeshPoint =?UTF-8?B?4oCT?= seeking advice on routing
 for
 crisis/disaster scenarios
Date: Mon, 05 Jan 2026 14:13:29 +0100
Message-ID: <48614633.fMDQidcC6G@prime>
In-Reply-To: <em2c0588dc-358e-4dc1-95da-134fdb2c3195@meshpointone.com>
References: <7007a140a5226e6283b848128d97ca03fa49f1e8@meshpointone.com>
 <4760451.kQq0lBPeGt@prime>
 <em2c0588dc-358e-4dc1-95da-134fdb2c3195@meshpointone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: 776Z5ZCQSKIW6JSDSLGUJ7ZPZ45CYNI5
X-Message-ID-Hash: 776Z5ZCQSKIW6JSDSLGUJ7ZPZ45CYNI5
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

On Monday, January 5, 2026 1:12:43=E2=80=AFPM Central European Standard Tim=
e=20
Valent@MeshPoint wrote:
> Hi Simon,
>=20
> Thank you very much for the detailed reply and the practical
> suggestions. The timing is no problem at all =E2=80=93 I completely under=
stand
> how busy things get around the holidays.
>=20
> I should mention some background: I was an active member of wlan
> slovenija and the Otvorena mre=C5=BEa (Open Network) project in Croatia. =
We
> are now restarting nodewatcher =E2=80=93 our system for node monitoring a=
nd
> firmware generation for community networks in Croatia and Slovenia.

Ah nice! I remember the name nodewatcher from WLAN Slovenija, although I mu=
st=20
admit I haven't used nodewatcher so far. I think Mitar and others were talk=
ing=20
about it in the past ... Since battlemesh in croatia is coming up for 2026,=
=20
now is a good time to revive. :) We might have met in Battlemesh v8 in=20
Maribor, but I must admit, my memory is a bit blurry ...

>=20
> Our approach is a bit different from Gluon. Instead of a unified
> firmware image, nodewatcher generates custom firmware per node with all
> parameters pre-configured: subnets, channel assignments, interface
> roles, etc. This lets us handle complexity on the backend so that end
> users just flash the image and everything works =E2=80=93 no wizard, no
> configuration choices that might confuse home users. We will certainly
> look at Gluon's technical choices for batman-adv tuning, but we prefer
> this 'keep it simple' deployment model.

OK, that's interesting. Gluon is also made for simplicity, you can get away=
=20
with just flashing the firmware and no further configuration. However, typi=
cally=20
you may want to enter the setup mode to set coordinates and a name of your =
AP,=20
though. IPs/subnets are automatically assigned from a centralized VPN serve=
r.=20
Either way, keeping it simple is definitely a good idea.

>=20
> Some history: when building the mesh networks in Slovenia and Croatia,
> we started with OLSR. It worked well initially, but once we crossed ~300
> nodes we hit serious scaling limits. Around that time (6-7 years ago) we
> were aware that Freifunk communities in Germany were also experiencing
> scaling issues with batman-adv, so we chose to migrate to Babel instead.
> Babel served us well and we never looked back.
>=20
> Now, as we restart MeshPoint and consider protocol options again, I am
> genuinely curious:
>=20
> 1. How has batman-adv addressed the scaling problem over the past 7
> years? Since it operates at L2, there is inherently more broadcast
> traffic. Do larger Freifunk networks segment into smaller batman-adv
> domains connected via something else, or has the protocol itself
> improved to handle hundreds of nodes in a single domain?

There are a few mechanisms in batman-adv, such as DAT (distributed ARP tabl=
es)=20
and multicast extensions to keep traffic at an acceptable limit. There are =
also=20
some changes to only send broadcasts only once on VPN links, or omit re-
broadcasts entirely those links.

However, the general scaling issues still apply. Therefore, gluon applies a=
=20
few parameters as outlined in my last mail. Hundreds of nodes are possible=
=20
(we've operated ~300 in our local Freifunk community), but with those numbe=
rs=20
there is quite a lot of "background" noise. Since we had a few slow DSL lin=
ks=20
within our VPN servers, we saw a bottleneck there already ...

In our Freifunk community, we segment into smaller domains (per city/town),=
=20
and I think others do the same - we are targeting up to ~100 -150 nodes per=
=20
segment.

Gluon also applies various firewall rules to avoid service discovery (e.g.=
=20
Avahi), Multicast DNS, etc over the mesh network, which are often way too=20
chatty with a few hundreds or even thousands of users.

> 2. Are there established patterns for combining batman-adv with overlay
> networks or L3 routing? For example, batman-adv for local mesh segments
> with BGP or Babel connecting segments at gateways?

We use a couple of VPN servers which run DHCP with different subnet per seg=
ment=20
(e.g. per town/city). Subnets are connected with each other using layer 3=20
routing on those VPN servers. We use bird to for the IP routing part, and G=
RE=20
tunnels to connect to our upstream Internet.

>=20
> 3. For mobile crisis deployments where topology changes constantly, is
> pure batman-adv still recommended, or do experienced operators use
> hybrid approaches?

That I can't answer, maybe someone else has experience. :) Setting up the=20
layer 3 network requires quite a bit of engineering I would say.

>=20
> These are deeper architectural questions =E2=80=93 I understand if the an=
swers
> are 'it depends' or require longer discussion. Any pointers to
> documentation, mailing list threads, or real-world deployment writeups
> would be very helpful.
>=20
> Thank you again for your time and the work you and the team have put
> into batman-adv over the years.

Those answers were mostly around gluon and our local Freifunk network=20
(Freifunk Vogtland [1]). Since this is open source, you can easily review a=
nd=20
perhaps adopt some parts for your case. Other gluon and Freifunk networks m=
ay=20
operate differently. Perhaps there are other mailing list readers who want =
to=20
chime in with other projects. :)

Cheers,
       Simon

[1] https://github.com/FreifunkVogtland

>=20
> Best regards,
> Valent
>=20
>=20
> ------ Original Message ------
> From "Simon Wunderlich" <sw@simonwunderlich.de>
> To b.a.t.m.a.n@lists.open-mesh.org
> Cc "Valent@MeshPoint" <valent@meshpointone.com>
> Date 5.1.2026. 10:07:44
> Subject Re: Restarting MeshPoint =E2=80=93 seeking advice on routing for
> crisis/disaster scenarios
>=20
> >Hi Valent,
> >
> >thank you for your interest and sorry for the late reply. The time before
> >Christmas is usually a bit hectic ...
> >
> >I would suggest to look into the "gluon" Freifunk Firmware [1], including
> >the batman-adv parameters made there. There are setups with a couple of
> >hundred nodes, although some sparsely connected over cities. Those setups
> >have been used and tested for a long time on different types of hardware.
> >
> >A few general suggestions for tuning for those scenarios are:
> >
> >* set up a high multicast rate, at least 12 MBit/s, perhaps 24 or more. =
You
> >will trade scalability with range
> >
> >* choose a higher than default OGM interval, e.g. 5 seconds instead of 1
> >second. This makes batman-adv reaction time slower, but helps scaling wi=
th
> >many nodes. Each node would repeat any other nodes OGM messages, which
> >results in O(N^2) OGM messages per interval.
> >
> >* if you don't need encryption (SAE), turn it off. SAE by default does a
> >peer- to-peer handshake, which can kill a dense network with many
> >participants in one place, if everyone wants to handshake with everyone
> >else at the same time.
> >
> >There are a few more things (e.g. reducing basic rates) which you may fi=
nd
> >in the gluon firmware and other places.
> >
> >As you can see, some of those suggestions are more Wi-Fi layer specific
> >than batman-adv specific, and would help with other protocols (e.g. babe=
l)
> >as well. From my experience with network simulators/emulators, you may
> >verify protocol specific behavior (e.g. number of messages, failover tim=
e)
> >to some extent. But testing Wi-Fi specific scaling effects like failing
> >SAE handshakes, effects of multicast rates, etc is rather hard - even if
> >you use emulators based on mac80211_hwsim or so which partially emulate
> >802.11. For those experiments, it's best to actually set up 10-20 devices
> >...
> >
> >Cheers,
> >
> >         Simon
> >
> >[1] https://gluon.readthedocs.io/en/latest/
> >
> >On Saturday, December 20, 2025 11:43:20=E2=80=AFPM Central European Stan=
dard Time
> >
> >Valent@MeshPoint wrote:
> >>  Hello,
> >> =20
> >>  I wanted to follow up on my previous message. I did not see any repli=
es,
> >>  so I hope it is ok to share one concrete finding from recent testing =
in
> >>  case it helps the discussion.
> >> =20
> >>  To move beyond purely theoretical arguments, I have been running large
> >>  scale tests using meshnet lab
> >>  https://github.com/mwarning/meshnet-lab
> >> =20
> >>  The main reason for choosing it is that it allows replaying real world
> >>  community network topologies, including Freifunk graphs, instead of
> >>  relying on synthetic grids or ideal meshes. This makes it easier to
> >>  observe behaviour under sparse, asymmetric, and imperfect conditions
> >>  that are closer to what actually gets deployed.
> >> =20
> >>  One interesting observation so far is that results can vary
> >>  significantly depending on how nodes are brought up and how control
> >>  plane load interacts with the topology. In other words, the same
> >>  protocol on the same topology can behave very differently depending on
> >>  timing, churn, and scale effects, even when the underlying links are
> >>  identical. This was not obvious to me before testing at this scale.
> >> =20
> >>  I am curious whether others here have used meshnet lab or similar
> >>  namespace based emulation tools for BATMAN adv testing, and if so,
> >>  whether your observations matched real deployments closely, or if the=
re
> >>  are known caveats when interpreting the results.
> >> =20
> >>  Any feedback or pointers would be appreciated.
> >> =20
> >>  Best regards,
> >>  Valent
> >> =20
> >> =20
> >>  ------ Original Message ------
> >> =20
> >>  >From "Valent Turkovic" <valent@meshpointone.com>
> >> =20
> >>  To b.a.t.m.a.n@lists.open-mesh.org
> >>  Date 16.12.2025. 16:37:01
> >>  Subject Restarting MeshPoint =E2=80=93 seeking advice on routing for
> >>  crisis/disaster scenarios
> >> =20
> >>  >Hi everyone,
> >>  >
> >>  >My name is Valent Turkovic.
> >>  >
> >>  >Between 2015 and 2018 I ran the MeshPoint project =E2=80=93 a simple=
, rugged
> >>  >Wi-Fi
> >>  >hotspot designed to work in very tough conditions.
> >>  >
> >>  >During the refugee crisis in Croatia we deployed these devices in ca=
mps
> >>  >and
> >>  >transit centers, providing internet connectivity for humanitarian
> >>  >organizations such as the Red Cross, UNICEF, IOM, Greenpeace, and ma=
ny
> >>  >smaller NGOs. Through these deployments, more than 500,000 people we=
re
> >>  >able to stay connected. The same system was also used in flood respo=
nse
> >>  >and other emergency situations. The project received the =E2=80=9CBe=
st
> >>  >Humanitarian Tech of the Year=E2=80=9D award at The Europas in 2016.
> >>  >
> >>  >Unfortunately, financial constraints forced me to pause the project
> >>  >after
> >>  >2018. It was entirely self-funded, and the prolonged stress eventual=
ly
> >>  >led
> >>  >to long-term health issues.
> >>  >
> >>  >Over the years I stayed in contact with first responders and field
> >>  >teams
> >>  >from organizations such as WFP, UNICEF, the Red Cross, and various
> >>  >NGOs.
> >>  >The feedback has remained consistent: when disasters strike, whether
> >>  >earthquakes, floods, or large-scale displacement, teams still strugg=
le
> >>  >to
> >>  >bring up reliable communications quickly. What they need most is a m=
esh
> >>  >network that works within minutes, not hours or days, and that
> >>  >continues
> >>  >operating on battery power when infrastructure is down.
> >>  >
> >>  >I am fully aware that in active conflict zones Wi-Fi can be jammed or
> >>  >restricted, for example due to drone countermeasures. However, there
> >>  >are
> >>  >many other scenarios where Wi-Fi mesh remains extremely valuable:
> >>  >evacuation centers, field hospitals, temporary shelters, flood-affec=
ted
> >>  >villages, and coordination points for responders. In these
> >>  >environments,
> >>  >fast, robust, and easy-to-deploy networking makes a very real
> >>  >difference
> >>  >for coordination, family contact, and medical or logistical data
> >>  >sharing.
> >>  >
> >>  >Because of this, I am now restarting the project as MeshPoint V2. The
> >>  >focus
> >>  >is updated hardware, improved battery life, and even simpler
> >>  >deployment,
> >>  >while keeping the original goal: crisis response and off-grid or
> >>  >underserved communities.
> >>  >
> >>  >In the original MeshPoint we used Babel. This was largely driven by
> >>  >practical constraints at the time: our deployment tooling was based =
on
> >>  >Nodewatcher, which was Babel-only. Technically, Babel served us very
> >>  >well.
> >>  >It converged fast, was reliable, and worked nicely for small to
> >>  >medium-sized networks.
> >>  >
> >>  >At the same time, I am well aware that many community networks and
> >>  >real-world mesh deployments successfully used batman-adv, often thro=
ugh
> >>  >Gluon or custom firmware builds. In larger, more dynamic, or highly
> >>  >mobile
> >>  >topologies typical for crisis scenarios, the layer-2 approach and
> >>  >seamless
> >>  >mobility properties of batman-adv are very attractive, especially wh=
en
> >>  >nodes are frequently moved, powered on and off, or replaced in the
> >>  >field.
> >>  >
> >>  >For MeshPoint V2 I am evaluating batman-adv and would appreciate
> >>  >insights
> >>  >on the following aspects, specifically in the context of crisis and
> >>  >emergency deployments:
> >>  >
> >>  >Behaviour at larger scale in real deployments
> >>  >In crisis scenarios networks often start small but can grow quickly =
as
> >>  >more
> >>  >nodes are deployed by different teams or organizations. We are
> >>  >interested
> >>  >in how batman-adv behaves when scaling to hundreds or more nodes in
> >>  >non-ideal, real-world conditions, without centralized planning and w=
ith
> >>  >limited ability for on-site tuning.
> >>  >
> >>  >Performance in sparse or highly mobile topologies
> >>  >Nodes in the field are frequently moved, turned off, replaced, or
> >>  >temporarily isolated. Vehicles, backpacks, and mobile command posts
> >>  >constantly change network topology. We are looking for practical
> >>  >experience with how well batman-adv handles frequent topology change=
s,
> >>  >intermittent links, and sparse node placement without requiring
> >>  >constant
> >>  >manual intervention.
> >>  >
> >>  >Suitability for battery-powered and intermittently connected nodes
> >>  >Many nodes run on battery for long periods and may sleep, reboot, or
> >>  >disappear entirely when power is lost. Low overhead, predictable
> >>  >behaviour, and fast recovery after reconnect are essential. We are
> >>  >particularly interested in any known trade-offs between routing
> >>  >performance, control traffic, and power consumption in such
> >>  >environments.
> >>  >
> >>  >If there is existing work, documented limitations, field experience,=
 or
> >>  >design guidance relevant to these constraints, pointers would be
> >>  >greatly
> >>  >appreciated. The goal is to build a system that field teams can depl=
oy
> >>  >and
> >>  >rely on under stress, without requiring deep networking expertise on
> >>  >site.
> >>  >
> >>  >Thank you for your time, and thank you to everyone who has contribut=
ed
> >>  >to
> >>  >making mesh networking viable outside of labs and into real-world,
> >>  >high-stakes situations.
> >>  >
> >>  >Best regards,
> >>  >Valent Turkovic
> >>  >https://www.meshpointone.com/
> >>  >
> >>  >Technical specifications of the original MeshPoint (for reference):
> >>  >https://www.meshpointone.com/technical-specifications/




