Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC167E66886
	for <batman-adv@archiver.kernel.org>; Sun, 21 Dec 2025 08:22:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 15B0E858CE
	for <batman-adv@archiver.kernel.org>; Sun, 21 Dec 2025 09:22:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1766305369;
 b=WlDP3IIuriF9Pz3IHSLXKfR1gkXr7BpazyHOsZxGCnL6mQ7rl+e59mJZICYAcJrPv9uDf
 I/S324+Ursj7mgzOmPuapsBFuKf4WBr3s5177Syh648Mj/hHZGg+K7LjM62yZjLTM0dt1OA
 USyOVEVsiozyoqXeuhwIRNjl6gR3wSU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1766305369; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tixElvWfZic6neBJx0wnMTBW1Kwx2f7gfSj2m6U48M4=;
 b=OW+0K4rJs8EfuvB2dyVM1XDdKMlAQLP0H8XZLWorU05tHlyq44Cfz3kEa6axVg4ZYfffP
 It2/VLBErIY2emcPQI41s5q9IjuN5aCCimtsjAKGJTUYNaIz5e5VCILYNj/RD8GA3IL24+B
 L8t/lma2841eMXd24WODmsCq12KCdRI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=meshpointone.com;
 arc=pass;
 dmarc=pass header.from=meshpointone.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=meshpointone.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=meshpointone.com policy.dmarc=none
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DB1CF817C4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 20 Dec 2025 23:43:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1766270621;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tixElvWfZic6neBJx0wnMTBW1Kwx2f7gfSj2m6U48M4=;
	b=rhxzSIquLQBtdSj3M/Xb+ars4h6iXt+9KGl13kVDFR5qxuvJ53xeQOBsASrgc2gNfM6dpN
	Enk/fh8KUCwxnC1nw79sQbmd2zEzxBxEFTHKp5j4F39+x8AlSeBKx7nPQ9CWgYZdoEex0U
	gpXObx3ebh1olw+niNkU2mTkO7oUQ0A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=meshpointone.com header.s=key1 header.b=GFeyGOyy;
	spf=pass (diktynna.open-mesh.org: domain of valent@meshpointone.com
 designates 2001:41d0:1004:224b::ba as permitted sender)
 smtp.mailfrom=valent@meshpointone.com;
	dmarc=pass (policy=none) header.from=meshpointone.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1766270621;
	b=uk+PtWZ12ZX7mb1mG9Mlw+37eoDi7GUNHkYvNjfeEtfJgJZlFx5CNWb6wpmcH3654J+Y2n
	kObSNkJR273gHysNtjqC/S+F5TNFBmgua6gjU/lT5YPdUmGOIBuynaeQJ97gyrORQTyvjU
	IvsvdOAYOcZ8bnwiGhvzeJy/WnI3eqc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meshpointone.com;
	s=key1; t=1766270602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tixElvWfZic6neBJx0wnMTBW1Kwx2f7gfSj2m6U48M4=;
	b=GFeyGOyyDPNJ21RAFN012l2Zh708A5qFlJejEK/gPtnxlojNHbjQ+rJFtddHrV7fTc/d8E
	U/9tQJapkwaaKHnSN1fQHWSHITJEi23kFev2PMQFo8dQsimObti2NHZpW5YUEj4UXxrzgR
	s8JGoFxJApWo+GugnvAdQiKeLTcT2UDcXiRaZFnfVPj3hHCkfV83xwQzY7sHbFwrCntRmm
	9KZ8EiGaB/Dp1relm6Qq6m2VGfrguO9b/pg2EkwgGcvbttle7tkhZO0Yvgveq5Adb44LTL
	L+q285mw/P6JwQDqn/MRKbZ6sjonnhmNF7fr2TTDAR866w+wTbaakT837ImuNg==
From: "Valent@MeshPoint" <valent@meshpointone.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 =?utf-8?q?Re=3a=20Restarting=20MeshPoint=20=e2=80=93=20seeking=20advice?=
 =?utf-8?q?=20on=20routing=20for=20crisis/disaster=20scenarios?=
Date: Sat, 20 Dec 2025 22:43:20 +0000
Message-Id: <em1e8ae4ba-b0f7-4a25-8bf3-1964f746b2ef@meshpointone.com>
In-Reply-To: <7007a140a5226e6283b848128d97ca03fa49f1e8@meshpointone.com>
References: <7007a140a5226e6283b848128d97ca03fa49f1e8@meshpointone.com>
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
Message-ID-Hash: DMT4VCNONWRHB7JSI3BDVMSZKA7QDHGJ
X-Message-ID-Hash: DMT4VCNONWRHB7JSI3BDVMSZKA7QDHGJ
X-Mailman-Approved-At: Sun, 21 Dec 2025 09:22:44 +0100
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

Hello,

I wanted to follow up on my previous message. I did not see any replies,=20
so I hope it is ok to share one concrete finding from recent testing in=20
case it helps the discussion.

To move beyond purely theoretical arguments, I have been running large=20
scale tests using meshnet lab
https://github.com/mwarning/meshnet-lab

The main reason for choosing it is that it allows replaying real world=20
community network topologies, including Freifunk graphs, instead of=20
relying on synthetic grids or ideal meshes. This makes it easier to=20
observe behaviour under sparse, asymmetric, and imperfect conditions=20
that are closer to what actually gets deployed.

One interesting observation so far is that results can vary=20
significantly depending on how nodes are brought up and how control=20
plane load interacts with the topology. In other words, the same=20
protocol on the same topology can behave very differently depending on=20
timing, churn, and scale effects, even when the underlying links are=20
identical. This was not obvious to me before testing at this scale.

I am curious whether others here have used meshnet lab or similar=20
namespace based emulation tools for BATMAN adv testing, and if so,=20
whether your observations matched real deployments closely, or if there=20
are known caveats when interpreting the results.

Any feedback or pointers would be appreciated.

Best regards,
Valent


------ Original Message ------
>From "Valent Turkovic" <valent@meshpointone.com>
To b.a.t.m.a.n@lists.open-mesh.org
Date 16.12.2025. 16:37:01
Subject Restarting MeshPoint =E2=80=93 seeking advice on routing for=20
crisis/disaster scenarios

>Hi everyone,
>
>My name is Valent Turkovic.
>
>Between 2015 and 2018 I ran the MeshPoint project =E2=80=93 a simple, rugg=
ed Wi-Fi hotspot designed to work in very tough conditions.
>
>During the refugee crisis in Croatia we deployed these devices in camps an=
d transit centers, providing internet connectivity for humanitarian organiz=
ations such as the Red Cross, UNICEF, IOM, Greenpeace, and many smaller NGO=
s. Through these deployments, more than 500,000 people were able to stay co=
nnected. The same system was also used in flood response and other emergenc=
y situations. The project received the =E2=80=9CBest Humanitarian Tech of t=
he Year=E2=80=9D award at The Europas in 2016.
>
>Unfortunately, financial constraints forced me to pause the project after=
 2018. It was entirely self-funded, and the prolonged stress eventually led=
 to long-term health issues.
>
>Over the years I stayed in contact with first responders and field teams f=
rom organizations such as WFP, UNICEF, the Red Cross, and various NGOs. The =
feedback has remained consistent: when disasters strike, whether earthquak=
es, floods, or large-scale displacement, teams still struggle to bring up r=
eliable communications quickly. What they need most is a mesh network that=
 works within minutes, not hours or days, and that continues operating on ba=
ttery power when infrastructure is down.
>
>I am fully aware that in active conflict zones Wi-Fi can be jammed or rest=
ricted, for example due to drone countermeasures. However, there are many o=
ther scenarios where Wi-Fi mesh remains extremely valuable: evacuation cent=
ers, field hospitals, temporary shelters, flood-affected villages, and coor=
dination points for responders. In these environments, fast, robust, and ea=
sy-to-deploy networking makes a very real difference for coordination, fami=
ly contact, and medical or logistical data sharing.
>
>Because of this, I am now restarting the project as MeshPoint V2. The focu=
s is updated hardware, improved battery life, and even simpler deployment,=
 while keeping the original goal: crisis response and off-grid or underserve=
d communities.
>
>In the original MeshPoint we used Babel. This was largely driven by practi=
cal constraints at the time: our deployment tooling was based on Nodewatche=
r, which was Babel-only. Technically, Babel served us very well. It converg=
ed fast, was reliable, and worked nicely for small to medium-sized networks=
.
>
>At the same time, I am well aware that many community networks and real-wo=
rld mesh deployments successfully used batman-adv, often through Gluon or c=
ustom firmware builds. In larger, more dynamic, or highly mobile topologies =
typical for crisis scenarios, the layer-2 approach and seamless mobility p=
roperties of batman-adv are very attractive, especially when nodes are freq=
uently moved, powered on and off, or replaced in the field.
>
>For MeshPoint V2 I am evaluating batman-adv and would appreciate insights=
 on the following aspects, specifically in the context of crisis and emergen=
cy deployments:
>
>Behaviour at larger scale in real deployments
>In crisis scenarios networks often start small but can grow quickly as mor=
e nodes are deployed by different teams or organizations. We are interested =
in how batman-adv behaves when scaling to hundreds or more nodes in non-id=
eal, real-world conditions, without centralized planning and with limited a=
bility for on-site tuning.
>
>Performance in sparse or highly mobile topologies
>Nodes in the field are frequently moved, turned off, replaced, or temporar=
ily isolated. Vehicles, backpacks, and mobile command posts constantly chan=
ge network topology. We are looking for practical experience with how well=
 batman-adv handles frequent topology changes, intermittent links, and spars=
e node placement without requiring constant manual intervention.
>
>Suitability for battery-powered and intermittently connected nodes
>Many nodes run on battery for long periods and may sleep, reboot, or disap=
pear entirely when power is lost. Low overhead, predictable behaviour, and=
 fast recovery after reconnect are essential. We are particularly interested =
in any known trade-offs between routing performance, control traffic, and=
 power consumption in such environments.
>
>If there is existing work, documented limitations, field experience, or de=
sign guidance relevant to these constraints, pointers would be greatly appr=
eciated. The goal is to build a system that field teams can deploy and rely =
on under stress, without requiring deep networking expertise on site.
>
>Thank you for your time, and thank you to everyone who has contributed to=
 making mesh networking viable outside of labs and into real-world, high-sta=
kes situations.
>
>Best regards,
>Valent Turkovic
>https://www.meshpointone.com/
>
>Technical specifications of the original MeshPoint (for reference):
>https://www.meshpointone.com/technical-specifications/
