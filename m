Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0761DD609B7
	for <batman-adv@archiver.kernel.org>; Tue, 16 Dec 2025 15:55:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 510E6815D6
	for <batman-adv@archiver.kernel.org>; Tue, 16 Dec 2025 16:55:17 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1765900517;
 b=S8UrhqL5hWCaMA0qawA28Jcsew/hCrH5LoVOeppXPye3BahXovbSltL/pRAo5YRXSh/cC
 AujdP0ojaE0AeyOJA155Kk7Q7a51est4/GnZlXOE9/mFMGo1itg1OGvIaPln8yUvhMM7n7y
 8/ndtPGYAtaQb++H/t+o/a90uuWoF84=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1765900517; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1ZydW/pZpzkAdTcfIPNSf9Opok1csSMFmUiQNdG3mAg=;
 b=BwWZFm+/kcHxK4kFb3xuuMLzkuekP1Lm/NDLjeY9AYN15AcekIxMawPrPk1H5jtH2fxLc
 V5up7691fmSvJthSxRig1oH0wg6o/7M+I/+jTuZvm/CSbYparbpIgFOITt4mX6Q1m8P7QDv
 ie3CP/9nTN5w8oS60LfJ0satyoRBQxk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=meshpointone.com;
 arc=pass;
 dmarc=pass header.from=meshpointone.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=meshpointone.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=meshpointone.com policy.dmarc=none
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C56468439F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 16 Dec 2025 16:37:08 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1765899439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=1ZydW/pZpzkAdTcfIPNSf9Opok1csSMFmUiQNdG3mAg=;
	b=shw8hK1UGCBnfKJp+Ujx55GpRfonD+XTBfmM0OO1Qz7slslflSGGRcSJFcN7r1II1hfaVy
	NiEQSxJrrXNzq4z4tWW6w2PZJfj2kofkgKg+JzvyyAlGk6ykqywQ1fNvQ/dowuuF/08fv6
	mHvP6cRqkaZdMkWTnWkXCj+ElkL5Q7Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=meshpointone.com header.s=key1 header.b=RLP84wnR;
	spf=pass (diktynna.open-mesh.org: domain of valent@meshpointone.com
 designates 91.218.175.180 as permitted sender)
 smtp.mailfrom=valent@meshpointone.com;
	dmarc=pass (policy=none) header.from=meshpointone.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1765899439;
	b=pBterd5jxs0XCyRjZqQB9Ktdh8mKwClde8cILjSsaKC/CWw60VutYWIAHGWkXdBsEcmf8j
	RoPhUm0sYAky80fL7rsSz9K/tozBNW5lrmk2g1a23AnImBs1saINH7jO4zkcdRL/9UsX3t
	P01SqRpgPyhrYqLSNeR/9xPY1UGVmhY=
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meshpointone.com;
	s=key1; t=1765899426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ZydW/pZpzkAdTcfIPNSf9Opok1csSMFmUiQNdG3mAg=;
	b=RLP84wnR3H5xOOMKKMZPPZV92jXqbQoJfrYnZCPaThRvgNhoht1CtlmqFVwebgmIX0HeSM
	gI612q1UU0+vhKBvETVQA3gEBGgJ+ZuzzI/9Vc3gcu2N9US1rpp0h7zDVoB304jOu4rpWM
	BcQiTx1z9EXK662eMeLCLp35RkIhJ/HsvVhpiw0SqAWYY4Dr//X5A+2d5N21XX9ApJv92d
	EzHjMv530VF+yQCc/cs0xxu5smwURFjMLO4j6rnF4VxccTVxN4daybtqoVYYCip/9wcwIq
	jtdxyrHHUIXtGe4TmoCq4fijNpdHwBV2OQqcMjbjoGChUhnLFmd5KZ19uDYTpQ==
Date: Tue, 16 Dec 2025 15:37:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Valent Turkovic" <valent@meshpointone.com>
Message-ID: <7007a140a5226e6283b848128d97ca03fa49f1e8@meshpointone.com>
TLS-Required: No
Subject: =?utf-8?B?UmVzdGFydGluZyBNZXNoUG9pbnQg4oCTIHNlZWtpbmcgYWQ=?=
 =?utf-8?B?dmljZSBvbiByb3V0aW5nIGZvciBjcmlzaXMvZGlzYXN0ZXIgc2NlbmE=?=
 =?utf-8?B?cmlvcw==?=
To: b.a.t.m.a.n@lists.open-mesh.org
X-Migadu-Flow: FLOW_OUT
X-MailFrom: valent@meshpointone.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: SYU2QKWKDCTN2X3EOR26ZE3LUEZPULM6
X-Message-ID-Hash: SYU2QKWKDCTN2X3EOR26ZE3LUEZPULM6
X-Mailman-Approved-At: Tue, 16 Dec 2025 16:55:13 +0100
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

Hi everyone,

My name is Valent Turkovic.

Between 2015 and 2018 I ran the MeshPoint project =E2=80=93 a simple, rug=
ged Wi-Fi hotspot designed to work in very tough conditions.

During the refugee crisis in Croatia we deployed these devices in camps a=
nd transit centers, providing internet connectivity for humanitarian orga=
nizations such as the Red Cross, UNICEF, IOM, Greenpeace, and many smalle=
r NGOs. Through these deployments, more than 500,000 people were able to =
stay connected. The same system was also used in flood response and other=
 emergency situations. The project received the =E2=80=9CBest Humanitaria=
n Tech of the Year=E2=80=9D award at The Europas in 2016.

Unfortunately, financial constraints forced me to pause the project after=
 2018. It was entirely self-funded, and the prolonged stress eventually l=
ed to long-term health issues.

Over the years I stayed in contact with first responders and field teams =
from organizations such as WFP, UNICEF, the Red Cross, and various NGOs. =
The feedback has remained consistent: when disasters strike, whether eart=
hquakes, floods, or large-scale displacement, teams still struggle to bri=
ng up reliable communications quickly. What they need most is a mesh netw=
ork that works within minutes, not hours or days, and that continues oper=
ating on battery power when infrastructure is down.

I am fully aware that in active conflict zones Wi-Fi can be jammed or res=
tricted, for example due to drone countermeasures. However, there are man=
y other scenarios where Wi-Fi mesh remains extremely valuable: evacuation=
 centers, field hospitals, temporary shelters, flood-affected villages, a=
nd coordination points for responders. In these environments, fast, robus=
t, and easy-to-deploy networking makes a very real difference for coordin=
ation, family contact, and medical or logistical data sharing.

Because of this, I am now restarting the project as MeshPoint V2. The foc=
us is updated hardware, improved battery life, and even simpler deploymen=
t, while keeping the original goal: crisis response and off-grid or under=
served communities.

In the original MeshPoint we used Babel. This was largely driven by pract=
ical constraints at the time: our deployment tooling was based on Nodewat=
cher, which was Babel-only. Technically, Babel served us very well. It co=
nverged fast, was reliable, and worked nicely for small to medium-sized n=
etworks.

At the same time, I am well aware that many community networks and real-w=
orld mesh deployments successfully used batman-adv, often through Gluon o=
r custom firmware builds. In larger, more dynamic, or highly mobile topol=
ogies typical for crisis scenarios, the layer-2 approach and seamless mob=
ility properties of batman-adv are very attractive, especially when nodes=
 are frequently moved, powered on and off, or replaced in the field.

For MeshPoint V2 I am evaluating batman-adv and would appreciate insights=
 on the following aspects, specifically in the context of crisis and emer=
gency deployments:

Behaviour at larger scale in real deployments
In crisis scenarios networks often start small but can grow quickly as mo=
re nodes are deployed by different teams or organizations. We are interes=
ted in how batman-adv behaves when scaling to hundreds or more nodes in n=
on-ideal, real-world conditions, without centralized planning and with li=
mited ability for on-site tuning.

Performance in sparse or highly mobile topologies
Nodes in the field are frequently moved, turned off, replaced, or tempora=
rily isolated. Vehicles, backpacks, and mobile command posts constantly c=
hange network topology. We are looking for practical experience with how =
well batman-adv handles frequent topology changes, intermittent links, an=
d sparse node placement without requiring constant manual intervention.

Suitability for battery-powered and intermittently connected nodes
Many nodes run on battery for long periods and may sleep, reboot, or disa=
ppear entirely when power is lost. Low overhead, predictable behaviour, a=
nd fast recovery after reconnect are essential. We are particularly inter=
ested in any known trade-offs between routing performance, control traffi=
c, and power consumption in such environments.

If there is existing work, documented limitations, field experience, or d=
esign guidance relevant to these constraints, pointers would be greatly a=
ppreciated. The goal is to build a system that field teams can deploy and=
 rely on under stress, without requiring deep networking expertise on sit=
e.

Thank you for your time, and thank you to everyone who has contributed to=
 making mesh networking viable outside of labs and into real-world, high-=
stakes situations.

Best regards,
Valent Turkovic
https://www.meshpointone.com/

Technical specifications of the original MeshPoint (for reference):
https://www.meshpointone.com/technical-specifications/
