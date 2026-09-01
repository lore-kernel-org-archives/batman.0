Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15F0C61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 17:10:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1EF0C80B80
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 19:10:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788282644;
 b=1fUthziPq8dkcuiJEnAMzRZlpBLGJuwkqXsEcFG8esnvuxNP6dZ4i2sbe/T0k2jc41eDo
 sNnEvZTQ5dROKs1vxA83x1rzdiIkjf7UshQgwl1Ex0NxM57qpHatkI7JBf6cMEZL44Ic3b/
 1IDpA+uOEcN0mGX2dhmy4QrmFKwHbgw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788282644; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iFv/gYEE+weqVIiW9IDNLzhXjgssJht0V2j5b9kXJJo=;
 b=Mq9CfsmBF1novz1v/HeahUfNjBtr2URqCNpX7xb5eSmwS2jWxxP4sqM05QkpVY0AzwpLZ
 NmnjzEiGowVqTA+IfkobFMuqj1zPZYSHK37M5F1TwJpKB+mcxhk4XiV//Pqg7CgseJQGuft
 P0yKeePR1uSaOmV7GX1rFX8WyLtOryQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 11D1E80B80
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 19:10:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788282635;
	b=z2ZVPryIULAEihbujlS4gJEQQ2WiFR1ves21NxDoAVmbtLv5NrsPfIQTG1ZJoy+BvvsATr
	LBViVlGnWJRqYwca7EpYKDG6+5QSnesMAWjpRsksNFLPKdFRoXF1fg8piOcF26O5InCrK3
	UW8tNqwcFkSjL8NWQQ7cM4MfsiVeMZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788282635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iFv/gYEE+weqVIiW9IDNLzhXjgssJht0V2j5b9kXJJo=;
	b=COWfx+xmy+aEoukoFGkdAgFPk1oDC7UlAPT8VmdoXeGvjteBXfxpDjlgyXyshga9sA5Dxq
	dI/hM6TDgAwRrsd4XzI5fEVm/be8ahccIt9RT2kv2eLSShd0ZrZbGc2cbJqcye0CASrgP5
	F02M08J1fT7HE7GebwjfNrBCHtDKA1Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QxMozD5M;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 07DFB2043A;
	Tue, 01 Sep 2026 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788282630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFv/gYEE+weqVIiW9IDNLzhXjgssJht0V2j5b9kXJJo=;
	b=QxMozD5M0QnQFi8EoE9XovU64m+o57RTbWP/Ose9GBvl8zPuP2mPdgm1oG9/qcnImT2aPf
	4f1CriXHg2q985ORP9fniMnVgAq+ASOW5a8wCHzWkxPQI/E4we1iAhuoK9qjy8uzcxqVkI
	46YPBVsjeywprk/7ph6poRS9wedqvxk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 03/15] batman-adv: bat_v: fix bonding candidate
 selection
Date: Tue, 01 Sep 2026 19:10:27 +0200
Message-ID: <48341980.fMDQidcC6G@sven-desktop>
In-Reply-To: <20260831135117.574836-4-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2293903.Icojqenx9y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: WDLUT7EX232MWMY3BGCLUMHJYA2TF6DH
X-Message-ID-Hash: WDLUT7EX232MWMY3BGCLUMHJYA2TF6DH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WDLUT7EX232MWMY3BGCLUMHJYA2TF6DH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2293903.Icojqenx9y
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:10:27 +0200
Message-ID: <48341980.fMDQidcC6G@sven-desktop>
In-Reply-To: <20260831135117.574836-4-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D3

> > diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> > index 0c27447cf688..2d3045733db1 100644
> > --- a/net/batman-adv/bat_v.c
> > +++ b/net/batman-adv/bat_v.c
> > @@ -519,8 +519,8 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_n=
ode *neigh1,
> >   * @neigh2: second neighbour to compare
> >   * @if_outgoing2: outgoing interface to use for @neigh2
> >   *
> > - * Return: true if the throughput of @neigh2 is at least 3/4 of the
> > - *  @neigh1 throughput
> > + * Return: true if the throughput of @neigh1 is at least 3/4 of the
> > + *  @neigh2 throughput
> >   */
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't an issue introduced by this patch, the "at least" wording was
> already there before the swap, but does the rewritten kernel-doc for
> batadv_v_neigh_is_sob() still describe the boundary case incorrectly?
>=20
> The implementation uses a strict comparison:
>=20
> net/batman-adv/bat_v.c:batadv_v_neigh_is_sob() {
> 	threshold =3D ifinfo2->bat_v.throughput / 4;
> 	threshold =3D ifinfo2->bat_v.throughput - threshold;
>=20
> 	ret =3D ifinfo1->bat_v.throughput > threshold;
> }
>=20
> So a candidate whose throughput is exactly tp2 - tp2/4 returns false, as
> does the tp1 =3D=3D tp2 =3D=3D 0 case, while "at least 3/4" reads as incl=
usive.

Out-of-scope for this patch and adjusted in a later patch.

>=20
> The remaining inclusive wording is the pre-existing ops-table description
> in net/batman-adv/types.h, which still documents
> batadv_algo_neigh_ops::is_similar_or_better as "check if neigh1 is equally
> similar or better than neigh2"; that text is untouched by this series.
> Should it be reworded too?

Out-of-scope for this patch.

>=20
> > @@ -540,10 +540,10 @@ static bool batadv_v_neigh_is_sob(struct batadv_n=
eigh_node *neigh1,
> >  	if (!ifinfo2)
> >  		goto err_ifinfo2;
> > =20
> > -	threshold =3D ifinfo1->bat_v.throughput / 4;
> > -	threshold =3D ifinfo1->bat_v.throughput - threshold;
> > +	threshold =3D ifinfo2->bat_v.throughput / 4;
> > +	threshold =3D ifinfo2->bat_v.throughput - threshold;
> > =20
> > -	ret =3D ifinfo2->bat_v.throughput > threshold;
> > +	ret =3D ifinfo1->bat_v.throughput > threshold;
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this carry a Fixes: tag and a stable indication?
[...]
> That means every released kernel containing 9786906022eb keeps accepting
> bonding candidates with arbitrarily low throughput whenever
> bat_priv->bonding is enabled.  Without a Fixes: tag the change is not
> visible to stable/AUTOSEL tooling.


I am not allowed to add Fixes: lines for patches targeting net-next. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

Regards,
Sven
--nextPart2293903.Icojqenx9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcHAwAKCRBND3cr0xT1
y+IYAQDnmKgD/H9L+eAiGA9H1fj/kFWars1dyEt/JXZ8K+MtNwEA+t2inykYK0mV
Ua0V1EiG+ZgEyqrJP60X4mGNTcQ+ugI=
=UMvS
-----END PGP SIGNATURE-----

--nextPart2293903.Icojqenx9y--



