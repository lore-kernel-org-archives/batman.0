Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4374F43698
	for <batman@archiver.kernel.org>; Fri, 17 Apr 2026 12:10:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F4DD8559A
	for <batman@archiver.kernel.org>; Fri, 17 Apr 2026 14:10:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776427800;
 b=mSdq0mp5WvmOpVLAk5PjpgzEsScLrr3A9arF5wMPyiu/6hCqr8Weovu/Vh3kK4/zb2DMN
 oCbfxu9eJPTk0IJyKEZ6HDSmPVaZhhwfDIHHUshQN2h+Oy3UgJsgmu21BAkVmWlt/wTOOQ6
 THw5XheuBsP0rTZCIjSO0lS82RUO6Jo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776427800; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gTgGO+I7o53OBab8iqP0ryi5Og2uQKDHqX9D1P37I4E=;
 b=TzNtJg/2iGJXJ2s5l90CZGWZQSIKbBvVR1/NefORbMsMgF7eWVRUuTCJ3xiY8icqkoGbx
 168IpSti034bUlGW6mxuAR21u4JYlvKO/Zib7g5+n7+h4VkIh3jisp2hLpgHuUHfn/MABt9
 Uc7F3h2mr1gI0r/dld+MRhfBH2sB7l0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=protonmail.com;
 arc=pass;
 dmarc=pass header.from=protonmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=protonmail.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=protonmail.com policy.dmarc=quarantine
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch
 [79.135.106.101])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AFE218195B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Apr 2026 09:49:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776412166;
	b=nsZuVJMotcCCXPXzodUZjifUmGRQ2g3DWkrrDYY6mv0hOXEdP+erBk8n+43I7LXNFQrUXh
	605inSoqpE/DqvGy+mTFAp+/dEZy/Zj/Bjr1TNpEKA9vaMzueVfpxY6lYImUwbcnidmh//
	RGsj+yC9W1JBT5+q+tFNgSWUmG/sYIE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=protonmail.com header.s=protonmail3 header.b="aA/T/I5/";
	spf=pass (diktynna.open-mesh.org: domain of martinvdberg@protonmail.com
 designates 79.135.106.101 as permitted sender)
 smtp.mailfrom=martinvdberg@protonmail.com;
	dmarc=pass (policy=quarantine) header.from=protonmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776412166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gTgGO+I7o53OBab8iqP0ryi5Og2uQKDHqX9D1P37I4E=;
	b=oHTxcY28rv7dU0w7HUQHlg9fsskcM/g6BDHaT/FU3IWodVM4vyLjcV6TFN/Bx/D+tQnLHE
	sQBcd8ehj4X2qN9uo2MQfPTGzUYllPwWFPs0WjSw1/aR3p9TWYDyvgksgjzQWmgav0k2lL
	H+p2bQWd7+v2LTHT/hgEOjln29nFqz4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1776412155; x=1776671355;
	bh=gTgGO+I7o53OBab8iqP0ryi5Og2uQKDHqX9D1P37I4E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aA/T/I5/zASMBxZLf0XKJJZmo4dIA9neQ9aMNETtkrIxYSZ8TwfaYUvgcqB29MQfC
	 Mm0h5FglnEr5OiKpnB0gmTzOm/C5vA/v6OqS2ltoIrPf58TgH4YIFM7/GyvQJ5Cjzy
	 w2sO3JCkdTz5tQSL5u7xqL0UNZZctYYkZWdeGbsaZ5CMQfWJAZOOY4Tsfa/QpR3YfJ
	 CRR0COtTikITRkEQau8/epa739901iHmtiNbwPdhG0ZJyVwr6rNNKaruqxd02U13sA
	 C7kdBVhZDmbX+ju7FNi76ZboliUshZKdTqY5xf5Ndoa5nVkjwzA75eeKh3Tf+cPd1G
	 F6T7xeu4lBsvg==
Date: Fri, 17 Apr 2026 07:49:13 +0000
To: Simon Wunderlich <sw@simonwunderlich.de>
From: Martin <martinvdberg@protonmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Gateway shut down detection takes too time from other nodes
Message-ID: 
 <Y7MSNnrQG9nc9mStihbiD3_QRV6QRc7K_7cBn5fJo-2Zzvu-XnKJ2E_z0wElZXZUrPGnpBKDasjjLryDqg5z8Y9jHdf7M4696K_kFweOlsk=@protonmail.com>
In-Reply-To: <3233879.U3zVgo479M@prime>
References: <3735338.hdfAi7Kttb@prime>
 <177556961939.1631.5621807886524407791@diktynna.open-mesh.org>
 <13667793.EVyyLHbfrO@prime> <3233879.U3zVgo479M@prime>
Feedback-ID: 6271043:user:proton
X-Pm-Message-ID: 6f09a134a06c2cafdca870c9981adf67a3d88e36
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: martinvdberg@protonmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: VNTAJPPNBKVI3GGV3EYTKRDAKBJERPLY
X-Message-ID-Hash: VNTAJPPNBKVI3GGV3EYTKRDAKBJERPLY
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:01:40 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VNTAJPPNBKVI3GGV3EYTKRDAKBJERPLY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Simon,

Thank you for your reply.

I=E2=80=99ve considered your suggestion, and it sounds feasible. The only i=
ssue I can think of is how to select the best possible gateway at the appli=
cation level in this scenario. Wouldn=E2=80=99t this result in duplication =
of logic?

For the time being, I=E2=80=99ve patched the batman code to reduce the time=
out from 200s to 20s. This works fine.

It would be great to have this timeout configurable via batctl. Is there an=
y chance that such a feature could be implemented in the near future?


Regards, Martin

Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 04/16/26 at 07:47 Simon Wunderlich <sw@simonwunderlich.de> wro=
te:
On Wednesday, April 15, 2026 5:10:23=E2=80=AFPM Central European Summer Tim=
e Simon
Wunderlich wrote:
> Hi Martin,
>
> On Tuesday, April 7, 2026 3:46:59=E2=80=AFPM Central European Summer Time
>
> martinvdberg@gmail.com wrote:
> > I think I have a similar use-case as the original poster and ran into t=
he
> > same problem.
> >
> > Let me try to explain:
> >
> > - Given a mesh network where each node is assigned a *static IP*.
> > - In the mesh network there are some nodes acting as a Gateway.
> > - The other nodes in the mesh are clients.
> > - Using BATMAN-V
> >
> > Each client node has a script running, when it detects "batctl gwl" to
> > elect another gateway, the script will set the gateway's IP-address as
> > default route: "ip route replace default via $gateway_ip dev bat0".
> >
> > Now whenever a mesh-gateway is turned off, it will take 200 seconds bef=
ore
> > it is removed from the originators and only then "batctl gwl" will elec=
t
> > another gateway. This results in some client nodes have no internet for
> > 200
> > seconds.
> >
> > So far, I haven't been able to get batman-adv (using batctl) to switch =
to
> > another gateway sooner, e.g. after 10 or 20 seconds.
> >
> >
> > Using DHCP is not an option in my use-case.
> >
> > Is there somehow a way to reduce the 200 seconds? Possibly by switching=
 to
> > BATMAN-IV?
> >
> > Regards, Martin
>
> that's an interesting use case, although I would like to make clear that =
the
> gateway feature was designed for DHCP in mind, yet you use it with static
> IPs. The main purpose was to re-route DHCP packets to the selected gatewa=
y.
> Nethertheless, you could still use this mechanism for "signaling".
>
> The gateway selection can be based on TQ or on bandwidth parameters, but
> there is no option to speed up the "dead marking" from the 200s of the
> originator timeout. you can decrease that number in the source code, but =
I
> would actually advise to use a completely different method independent of
> batman-adv - for example by using a layer 3 routing daemon, or another
> application which regularly signals their availability as a gateway. For
> DHCP (which it was originally designed for), lease times are typically 5
> minutes minmum, so the 200s timeout are not really a problem there ... bu=
t
> I acknowledge that it's not really useful for "fast" switching.

Perhaps one more practical idea: You could parse the gateway list and the
originator list yourself (batctl has json output options). Then, you could =
get
the "last seen" value from the originator list, and combine it with your
gatewaylist. In that way, you could easily filter the "best gateway which w=
as
last seen <20 s" in a script. This doesn't help with batmans internal DHCP
forwarding, but since you use static IPs anyway and probably already use a
script to get the current gateway to look up the IP, this may be an easy fi=
x
...

Cheers,
       Simon





