Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB4EC79FA5
	for <batman@archiver.kernel.org>; Mon,  5 Jan 2026 16:08:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 717A085939
	for <batman@archiver.kernel.org>; Mon, 05 Jan 2026 17:08:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1767629334;
 b=dNVAmA/lDNb/vHtnBIGHf3ijv66jYrDViizUjFc7sjLLQVBf7BWrniac/HGOps5h5uDZV
 RPzafLznodZrIOor9xD7ZpYCHNB03c63zKeSZizpwWt0FAzoXVDr90ILJfuOP+5fKl8CkU/
 f+yyROAteWFGwjA4HYjBKszflJKqf/0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1767629334; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aDQvyNAUVHc22amiRaQvFsnJgkhc13RnJKir0ApujM0=;
 b=SJuVS+pv5lW+to73l1mRtCKG5UrPfw3PyYbYiOrlv43TTTwbtRNk17Cm9Ps4W+o5yEs1M
 nFwCV2YjsLGg1hSVIh13sj6X6ThDizkZi/XQZYXvNkbzvTFQMxqCuiPprOh8YBNLbi9lKej
 dboVAu0tQDMQ93PEbWntyoOsvTwTrhY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=meshpointone.com;
 arc=pass;
 dmarc=pass header.from=meshpointone.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=meshpointone.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=meshpointone.com policy.dmarc=none
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 98C5E84C8D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 05 Jan 2026 13:12:57 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1767615187;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aDQvyNAUVHc22amiRaQvFsnJgkhc13RnJKir0ApujM0=;
	b=QlE3YA/mniqgHe6e2GtOj9DWR50o0IkBSK1VJ5iC2BjBRMcA3DP2SnXenx5ntXpiTXVMk9
	ClgJBlaS3mRTmFNp1m/C/9Nm372pHhT3B94dRMzRLgPjgO/zrV0Ne0hnw4QTskJVYbppR0
	ig3FbFz+kpU97tC8EvzAGKpeAPKaJik=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=meshpointone.com header.s=key1 header.b=jElqumAz;
	spf=pass (diktynna.open-mesh.org: domain of valent@meshpointone.com
 designates 91.218.175.181 as permitted sender)
 smtp.mailfrom=valent@meshpointone.com;
	dmarc=pass (policy=none) header.from=meshpointone.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1767615187;
	b=QAPtAy7J/Xg9EeO4I4yb7m1BoJvsE/mAGEzMgsGvuVAxIhH3dyCjVHXlowKnBooCO8u4xT
	TYp1HKtWy30JR7oM7roVW/yx3bBmodM9YRN+wCQS/HapuzGozT2g+y6GFrfrikLUr33cpH
	XycgYVyGh32sgSojBD0dQrNNUaCnUfI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meshpointone.com;
	s=key1; t=1767615176;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDQvyNAUVHc22amiRaQvFsnJgkhc13RnJKir0ApujM0=;
	b=jElqumAzAc2wph9o303TArB0ntFlat7xIZX/6HPurVO3X6/xhgfsSV9rQgsKAyXBYzIt1C
	htKyp/cs7R/y0sA25sXQABEUYcT7k64sn+4QkQc+cxgSqJ/nuRQUH8dc09ZDuk6RfKY/up
	3QmjQEIuG98/12LdTPfsTp3TobpteSK6yLoSt8tPKafEK6f6kR5/shObDQy7o1++lr4vwt
	hgMB9d+UAJdpsF505O27j57S/bSuSrVuGb8CYOhUp6CAyF+6U7VOKgm8FBxCb9Yp1WykZp
	MoF+LYuql48/t7j4dK00g1dvEKPIkkvmJfAEhIaLSX9+jXkC6R2loo18ISmq/g==
From: "Valent@MeshPoint" <valent@meshpointone.com>
To: "Simon Wunderlich" <sw@simonwunderlich.de>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 =?utf-8?q?Re=5b2=5d=3a=20Restarting=20MeshPoint=20=e2=80=93=20seeking=20a?=
 =?utf-8?q?dvice=20on=20routing=20for=20crisis/disaster=20scenarios?=
Date: Mon, 05 Jan 2026 12:12:43 +0000
Message-Id: <em2c0588dc-358e-4dc1-95da-134fdb2c3195@meshpointone.com>
In-Reply-To: <4760451.kQq0lBPeGt@prime>
References: <7007a140a5226e6283b848128d97ca03fa49f1e8@meshpointone.com>
 <em1e8ae4ba-b0f7-4a25-8bf3-1964f746b2ef@meshpointone.com>
 <4760451.kQq0lBPeGt@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-MailFrom: valent@meshpointone.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 7OUUCJHNVX57D4TNVQMVFFH2FKBHPDA7
X-Message-ID-Hash: 7OUUCJHNVX57D4TNVQMVFFH2FKBHPDA7
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:08:32 +0100
X-Mailman-Version: 3.3.10
Precedence: list
Reply-To: "Valent@MeshPoint" <valent@meshpointone.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Simon,

Thank you very much for the detailed reply and the practical=20
suggestions. The timing is no problem at all =E2=80=93 I completely underst=
and=20
how busy things get around the holidays.

I should mention some background: I was an active member of wlan=20
slovenija and the Otvorena mre=C5=BEa (Open Network) project in Croatia. We=
=20
are now restarting nodewatcher =E2=80=93 our system for node monitoring and=
=20
firmware generation for community networks in Croatia and Slovenia.

Our approach is a bit different from Gluon. Instead of a unified=20
firmware image, nodewatcher generates custom firmware per node with all=20
parameters pre-configured: subnets, channel assignments, interface=20
roles, etc. This lets us handle complexity on the backend so that end=20
users just flash the image and everything works =E2=80=93 no wizard, no=20
configuration choices that might confuse home users. We will certainly=20
look at Gluon's technical choices for batman-adv tuning, but we prefer=20
this 'keep it simple' deployment model.

Some history: when building the mesh networks in Slovenia and Croatia,=20
we started with OLSR. It worked well initially, but once we crossed ~300=20
nodes we hit serious scaling limits. Around that time (6-7 years ago) we=20
were aware that Freifunk communities in Germany were also experiencing=20
scaling issues with batman-adv, so we chose to migrate to Babel instead.=20
Babel served us well and we never looked back.

Now, as we restart MeshPoint and consider protocol options again, I am=20
genuinely curious:

1. How has batman-adv addressed the scaling problem over the past 7=20
years? Since it operates at L2, there is inherently more broadcast=20
traffic. Do larger Freifunk networks segment into smaller batman-adv=20
domains connected via something else, or has the protocol itself=20
improved to handle hundreds of nodes in a single domain?

2. Are there established patterns for combining batman-adv with overlay=20
networks or L3 routing? For example, batman-adv for local mesh segments=20
with BGP or Babel connecting segments at gateways?

3. For mobile crisis deployments where topology changes constantly, is=20
pure batman-adv still recommended, or do experienced operators use=20
hybrid approaches?

These are deeper architectural questions =E2=80=93 I understand if the answ=
ers=20
are 'it depends' or require longer discussion. Any pointers to=20
documentation, mailing list threads, or real-world deployment writeups=20
would be very helpful.

Thank you again for your time and the work you and the team have put=20
into batman-adv over the years.

Best regards,
Valent


------ Original Message ------
>From "Simon Wunderlich" <sw@simonwunderlich.de>
To b.a.t.m.a.n@lists.open-mesh.org
Cc "Valent@MeshPoint" <valent@meshpointone.com>
Date 5.1.2026. 10:07:44
Subject Re: Restarting MeshPoint =E2=80=93 seeking advice on routing for=20
crisis/disaster scenarios

>Hi Valent,
>
>thank you for your interest and sorry for the late reply. The time before
>Christmas is usually a bit hectic ...
>
>I would suggest to look into the "gluon" Freifunk Firmware [1], including=
 the
>batman-adv parameters made there. There are setups with a couple of hundre=
d
>nodes, although some sparsely connected over cities. Those setups have bee=
n
>used and tested for a long time on different types of hardware.
>
>A few general suggestions for tuning for those scenarios are:
>
>* set up a high multicast rate, at least 12 MBit/s, perhaps 24 or more. Yo=
u
>will trade scalability with range
>
>* choose a higher than default OGM interval, e.g. 5 seconds instead of 1
>second. This makes batman-adv reaction time slower, but helps scaling with
>many nodes. Each node would repeat any other nodes OGM messages, which res=
ults
>in O(N^2) OGM messages per interval.
>
>* if you don't need encryption (SAE), turn it off. SAE by default does a p=
eer-
>to-peer handshake, which can kill a dense network with many participants i=
n
>one place, if everyone wants to handshake with everyone else at the same t=
ime.
>
>There are a few more things (e.g. reducing basic rates) which you may find =
in
>the gluon firmware and other places.
>
>As you can see, some of those suggestions are more Wi-Fi layer specific th=
an
>batman-adv specific, and would help with other protocols (e.g. babel) as w=
ell.
>From my experience with network simulators/emulators, you may verify proto=
col
>specific behavior (e.g. number of messages, failover time) to some extent. =
But
>testing Wi-Fi specific scaling effects like failing SAE handshakes, effect=
s of
>multicast rates, etc is rather hard - even if you use emulators based on
>mac80211_hwsim or so which partially emulate 802.11. For those experiments=
,
>it's best to actually set up 10-20 devices ...
>
>Cheers,
>         Simon
>
>[1] https://gluon.readthedocs.io/en/latest/
>
>On Saturday, December 20, 2025 11:43:20=E2=80=AFPM Central European Standa=
rd Time
>Valent@MeshPoint wrote:
>>  Hello,
>>
>>  I wanted to follow up on my previous message. I did not see any replies=
,
>>  so I hope it is ok to share one concrete finding from recent testing in
>>  case it helps the discussion.
>>
>>  To move beyond purely theoretical arguments, I have been running large
>>  scale tests using meshnet lab
>>  https://github.com/mwarning/meshnet-lab
>>
>>  The main reason for choosing it is that it allows replaying real world
>>  community network topologies, including Freifunk graphs, instead of
>>  relying on synthetic grids or ideal meshes. This makes it easier to
>>  observe behaviour under sparse, asymmetric, and imperfect conditions
>>  that are closer to what actually gets deployed.
>>
>>  One interesting observation so far is that results can vary
>>  significantly depending on how nodes are brought up and how control
>>  plane load interacts with the topology. In other words, the same
>>  protocol on the same topology can behave very differently depending on
>>  timing, churn, and scale effects, even when the underlying links are
>>  identical. This was not obvious to me before testing at this scale.
>>
>>  I am curious whether others here have used meshnet lab or similar
>>  namespace based emulation tools for BATMAN adv testing, and if so,
>>  whether your observations matched real deployments closely, or if there
>>  are known caveats when interpreting the results.
>>
>>  Any feedback or pointers would be appreciated.
>>
>>  Best regards,
>>  Valent
>>
>>
>>  ------ Original Message ------
>>
>>  >From "Valent Turkovic" <valent@meshpointone.com>
>>
>>  To b.a.t.m.a.n@lists.open-mesh.org
>>  Date 16.12.2025. 16:37:01
>>  Subject Restarting MeshPoint =E2=80=93 seeking advice on routing for
>>  crisis/disaster scenarios
>>
>>  >Hi everyone,
>>  >
>>  >My name is Valent Turkovic.
>>  >
>>  >Between 2015 and 2018 I ran the MeshPoint project =E2=80=93 a simple,=
 rugged Wi-Fi
>>  >hotspot designed to work in very tough conditions.
>>  >
>>  >During the refugee crisis in Croatia we deployed these devices in camp=
s and
>>  >transit centers, providing internet connectivity for humanitarian
>>  >organizations such as the Red Cross, UNICEF, IOM, Greenpeace, and many
>>  >smaller NGOs. Through these deployments, more than 500,000 people were
>>  >able to stay connected. The same system was also used in flood respons=
e
>>  >and other emergency situations. The project received the =E2=80=9CBest
>>  >Humanitarian Tech of the Year=E2=80=9D award at The Europas in 2016.
>>  >
>>  >Unfortunately, financial constraints forced me to pause the project af=
ter
>>  >2018. It was entirely self-funded, and the prolonged stress eventually =
led
>>  >to long-term health issues.
>>  >
>>  >Over the years I stayed in contact with first responders and field tea=
ms
>>  >from organizations such as WFP, UNICEF, the Red Cross, and various NGO=
s.
>>  >The feedback has remained consistent: when disasters strike, whether
>>  >earthquakes, floods, or large-scale displacement, teams still struggle =
to
>>  >bring up reliable communications quickly. What they need most is a mes=
h
>>  >network that works within minutes, not hours or days, and that continu=
es
>>  >operating on battery power when infrastructure is down.
>>  >
>>  >I am fully aware that in active conflict zones Wi-Fi can be jammed or
>>  >restricted, for example due to drone countermeasures. However, there a=
re
>>  >many other scenarios where Wi-Fi mesh remains extremely valuable:
>>  >evacuation centers, field hospitals, temporary shelters, flood-affecte=
d
>>  >villages, and coordination points for responders. In these environment=
s,
>>  >fast, robust, and easy-to-deploy networking makes a very real differen=
ce
>>  >for coordination, family contact, and medical or logistical data shari=
ng.
>>  >
>>  >Because of this, I am now restarting the project as MeshPoint V2. The=
 focus
>>  >is updated hardware, improved battery life, and even simpler deploymen=
t,
>>  >while keeping the original goal: crisis response and off-grid or
>>  >underserved communities.
>>  >
>>  >In the original MeshPoint we used Babel. This was largely driven by
>>  >practical constraints at the time: our deployment tooling was based on
>>  >Nodewatcher, which was Babel-only. Technically, Babel served us very w=
ell.
>>  >It converged fast, was reliable, and worked nicely for small to
>>  >medium-sized networks.
>>  >
>>  >At the same time, I am well aware that many community networks and
>>  >real-world mesh deployments successfully used batman-adv, often throug=
h
>>  >Gluon or custom firmware builds. In larger, more dynamic, or highly mo=
bile
>>  >topologies typical for crisis scenarios, the layer-2 approach and seam=
less
>>  >mobility properties of batman-adv are very attractive, especially when
>>  >nodes are frequently moved, powered on and off, or replaced in the fie=
ld.
>>  >
>>  >For MeshPoint V2 I am evaluating batman-adv and would appreciate insig=
hts
>>  >on the following aspects, specifically in the context of crisis and
>>  >emergency deployments:
>>  >
>>  >Behaviour at larger scale in real deployments
>>  >In crisis scenarios networks often start small but can grow quickly as =
more
>>  >nodes are deployed by different teams or organizations. We are interes=
ted
>>  >in how batman-adv behaves when scaling to hundreds or more nodes in
>>  >non-ideal, real-world conditions, without centralized planning and wit=
h
>>  >limited ability for on-site tuning.
>>  >
>>  >Performance in sparse or highly mobile topologies
>>  >Nodes in the field are frequently moved, turned off, replaced, or
>>  >temporarily isolated. Vehicles, backpacks, and mobile command posts
>>  >constantly change network topology. We are looking for practical
>>  >experience with how well batman-adv handles frequent topology changes,
>>  >intermittent links, and sparse node placement without requiring consta=
nt
>>  >manual intervention.
>>  >
>>  >Suitability for battery-powered and intermittently connected nodes
>>  >Many nodes run on battery for long periods and may sleep, reboot, or
>>  >disappear entirely when power is lost. Low overhead, predictable
>>  >behaviour, and fast recovery after reconnect are essential. We are
>>  >particularly interested in any known trade-offs between routing
>>  >performance, control traffic, and power consumption in such environmen=
ts.
>>  >
>>  >If there is existing work, documented limitations, field experience, o=
r
>>  >design guidance relevant to these constraints, pointers would be great=
ly
>>  >appreciated. The goal is to build a system that field teams can deploy =
and
>>  >rely on under stress, without requiring deep networking expertise on s=
ite.
>>  >
>>  >Thank you for your time, and thank you to everyone who has contributed =
to
>>  >making mesh networking viable outside of labs and into real-world,
>>  >high-stakes situations.
>>  >
>>  >Best regards,
>>  >Valent Turkovic
>>  >https://www.meshpointone.com/
>>  >
>>  >Technical specifications of the original MeshPoint (for reference):
>>  >https://www.meshpointone.com/technical-specifications/
>
>
>
>
