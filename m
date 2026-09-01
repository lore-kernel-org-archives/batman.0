Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01CEC61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 17:04:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E8FF5820CC
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 19:04:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788282244;
 b=VVkknXnf19S3cj86aYW0V5VrV+wFctNR2b/T1M7w0e/Fm/KC1X5S8rChMdnXC/c8Gb460
 9jik8a3kyJpNv5Wpxxmdp3nh2CVaQ+/MnXcP56xaQz9/ieVrWYFndzobm7+vB3lf6kCRfk/
 hhGbZU51EcLF8KHUd/x/DOh3Cw/dQgY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788282244; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2eEiFK4fhFRFEx4C3WuFVBW00EISoLMKBQpn4kxezFo=;
 b=BrYA2hn97sxrZydkR5aVNxrmKTILwgqpBlCJSb+2/WRofWlcLa+bo2IQxSIo7SrRVNEmL
 DMHnaiMFeWJIhQ4PNP5f0n8bZm8+X/TyyYF3fzybqMJxYRJCHpSubkIaMXkt9DfLQu48zj4
 HgDV9Zo6sUa9oZbav9ovuBuUSKReWSw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 596C080453
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 19:03:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788282237;
	b=ayuOKa92pBV/PW207uvtFPs+wQmB2pnzkGEa5Q5fr2plpJWi8/9921W24mdRewlDziId8p
	urJ1Q4I04U8wk6AjWnuwllhDYA4VzSrebGuXSyaPawanf9RIIh08hcn/+g8FhUIzEEeFaP
	4aMOnukZBIu+hyhnzQFObo37mLmoumg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788282237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2eEiFK4fhFRFEx4C3WuFVBW00EISoLMKBQpn4kxezFo=;
	b=zx7lPxGP7SbkABFE7lwRLC3hdOQEJOXkaOQ1IGnmUdexQTGkx1R/vb61hYarHl6ZypufZs
	iBcCdtpBozsyJvimC1dwV/Qf3t0vTlgLHO8d4Mu9hkIEZ3YvRJ86sEUQvTuQTsWr3DKF7F
	qYyeFZmYeKrINep0GNbiouSW3C2cy00=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="IHB/GMXr";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 78C721FE3B;
	Tue, 01 Sep 2026 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788282222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eEiFK4fhFRFEx4C3WuFVBW00EISoLMKBQpn4kxezFo=;
	b=IHB/GMXr9W/LqU5axoVxe6tEJRRkQBCjIZROd/e3317JkidlLJeo7Ou0wQa7U9+hj0Q7cf
	+7osDgO+o9+DoSss0R2O4Ebmw5O9JB6e8pshVqBuM+OA6otkn8AM+rytgsCVDxC98jwD2R
	U/yVbFzmmzpWM+MdkVPaQwYGwvMPRIY=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 01/15] batman-adv: dat: fix printing of unknown
 4addr
 subtype
Date: Tue, 01 Sep 2026 19:03:40 +0200
Message-ID: <2290990.Mh6RI2rZIc@sven-desktop>
In-Reply-To: <20260831135117.574836-2-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3782765.R56niFO833";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: T4MSUP4QCFWUM4G3RZHCDJINLUGNBNRP
X-Message-ID-Hash: T4MSUP4QCFWUM4G3RZHCDJINLUGNBNRP
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T4MSUP4QCFWUM4G3RZHCDJINLUGNBNRP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3782765.R56niFO833
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:03:40 +0200
Message-ID: <2290990.Mh6RI2rZIc@sven-desktop>
In-Reply-To: <20260831135117.574836-2-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D1


> --- Patch [1]: [PATCH net-next 01/15] batman-adv: dat: fix printing of un=
known 4addr subtype ---
> commit 974c511b32b67ede89d952e4508493380b181449
> Author: Sven Eckelmann <sven@narfation.org>
>=20
> batman-adv: dat: fix printing of unknown 4addr subtype
>=20
> The default arm of the subtype switch in batadv_dbg_arp() was printing
> unicast_4addr_packet->u.packet_type instead of the subtype that was not
> recognized. This changes the debug message to print the subtype value.
>=20
> > diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/di=
stributed-arp-table.c
> > index 011cfdc47fab..270f8d6e2954 100644
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> > @@ -548,7 +548,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_=
priv, struct sk_buff *skb,
> >  			break;
> >  		default:
> >  			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
> > -				   unicast_4addr_packet->u.packet_type);
> > +				   unicast_4addr_packet->subtype);
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this carry a Fixes: tag?
>=20
> The change corrects a real defect in batadv_dbg_arp(): the default arm of
> the switch (unicast_4addr_packet->subtype) block was printing the outer
> packet_type, which on that path is always BATADV_UNICAST_4ADDR, so the
> message never showed the unknown value.
[...]
> Would adding
>=20
>   Fixes: 5c3a0e553593 ("batman-adv: Distributed ARP Table - add ARP parsi=
ng functions")
>=20
> be appropriate here, so netdev and stable tooling can date the affected
> history? The code change itself looks correct; only the missing tag stands
> out.

I am not allowed to add Fixes: lines for patches targeting net-next. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

Regards,
Sven
--nextPart3782765.R56niFO833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcFbAAKCRBND3cr0xT1
y++pAQD8SbxH2mc0nZ1HpGd4OIjRN2vo2Nik6g6z46mCItAzgwD+ImssDGqfIkj+
gPZkWWEsl5xSHFE+IOQUXJ0a92bwogU=
=4oxe
-----END PGP SIGNATURE-----

--nextPart3782765.R56niFO833--



