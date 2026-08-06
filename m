Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7863DC5AC67
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 18:31:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7FEBC841D5
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 20:31:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786041088;
 b=0cEelsUuPkwIu067rH3qawbftIvgLl8VCspWOWkyhatP3DGPKPKM8rRlCWs/Tw0vW0q3X
 MtzOyHAZK8CntCK49Z1SfxA8VlDsXIV6rfrEDtiLzItf7tX+H5pyfva6S0i3dv/axWf0Qb6
 hFWZjVT+Gmb8eopRIIjyZ3FeP9xmOr4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786041088; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SnMMoC+jkOYMoMxbTayS/0smcjrBmO15TJdbIvPpFQY=;
 b=rBrQQx8gmLwgwoW/AqCc/74U4UeqcYY2BLh5C8SEQ5orMiOCJJICRuHd0qFr3YByGGm4+
 E3mFrNNYEoi3a7kM6lkZlhQz8uqhFHJUpzeMU1A3Xp6gad2T43oSm6xJXqBcU/I3zTJ0F95
 B/Vl9+IVDllxs+vbbhWhIWx4qbODew8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 136BC802A6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 20:26:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786040764;
	b=SFzoL13GtQ0662xA2RQSXf9uDbmli3h2XkpDygzomjpMUnh+N/iLI86UlxLgm2LXFn/+vs
	5th2WaGjcfzXMIS/6sqOV376ET7TsnOy/iojVcb1WMhyF/9iw0D+tkp9hN9BQoyIZcbBdg
	TBS49ZoGcXvKhmoGgb5Fi6OJshk+Y58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786040764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SnMMoC+jkOYMoMxbTayS/0smcjrBmO15TJdbIvPpFQY=;
	b=w5e0J1KU2S6k1OwEEPZo/vYXm2MvLdpXaBKWyJRKRchemBetmdPwCdKr1IEy0/oJHTxVsQ
	HDY/HxQpJf89FOJsSMCds23dTh7TACF4Gc1Z/u1zHaUGDjjpGti+jH9Lh20bvXlsosuzki
	MUgPtXGYEOU0hGjwf8kfJW8LscBpUJ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Lr3Xtk/p";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 42785200D8;
	Thu, 06 Aug 2026 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786040759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMMoC+jkOYMoMxbTayS/0smcjrBmO15TJdbIvPpFQY=;
	b=Lr3Xtk/pGNS9X10GxkspK0UyOHLvrO9M6aOqkuAnIaDu8UG7xik0o0nh8MpIlPvkCMdGLA
	iP6NuM2s7lCMsWJk/4ThQQELe6Y9/QW7R2AmruQeXTNZt8j1oLIlR6PwBqVl6R7X5oXJEN
	Wqs6vvmPhxyj2D1H5plJGYjbLde7Hpw=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 03/10] batman-adv: add missing kernel-doc
 comments
Date: Thu, 06 Aug 2026 20:25:50 +0200
Message-ID: <2591882.ElGaqSPkdT@sven-desktop>
In-Reply-To: <20260805143200.722098-4-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5263483.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: UHPCXXWYB76TVFF563FEW6SDGU2RHXAR
X-Message-ID-Hash: UHPCXXWYB76TVFF563FEW6SDGU2RHXAR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UHPCXXWYB76TVFF563FEW6SDGU2RHXAR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5263483.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 20:25:50 +0200
Message-ID: <2591882.ElGaqSPkdT@sven-desktop>
In-Reply-To: <20260805143200.722098-4-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D3

=2D-- Patch [3]: [PATCH net-next 03/10] batman-adv: add missing kernel-doc =
comments ---

> > @@ -469,6 +510,17 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_=
node *neigh1,
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * batadv_v_neigh_is_sob() - check whether two B.A.T.M.A.N. V neighbou=
rs have
> > + *  a similar or better throughput
> > + * @neigh1: first neighbour to compare
> > + * @if_outgoing1: outgoing interface to use for @neigh1
> > + * @neigh2: second neighbour to compare
> > + * @if_outgoing2: outgoing interface to use for @neigh2
> > + *
> > + * Return: true if the throughput of @neigh2 is at least 3/4 of the
> > + *  @neigh1 throughput
> > + */
> >  static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
> >  				  struct batadv_hard_iface *if_outgoing1,
> >  				  struct batadv_neigh_node *neigh2,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Does "at least 3/4" match the comparison in the body?  The test is strict:
>=20
> 	threshold =3D ifinfo1->bat_v.throughput / 4;
> 	threshold =3D ifinfo1->bat_v.throughput - threshold;
>=20
> 	ret =3D ifinfo2->bat_v.throughput > threshold;
>=20
> For a neigh1 throughput of 100 the threshold is 75, so an exact 75 on
> neigh2 returns false rather than true.

Correct, will change it to "more than" in a patchset which deals with the=20
bonding in B.A.T.M.A.N. V. Shouldn't be too bad enough to force a resubmiss=
ion=20
of this PR.

>=20
> The second half is about the direction of the comparison.  The ops contra=
ct
> in net/batman-adv/types.h documents the hook the other way around:
>=20
> 	 * @is_similar_or_better: check if neigh1 is equally similar or better
> 	 *  than neigh2 for their respective outgoing interface from the metric
> 	 *  prospective

Already stumbled upon that. I am not really interested in B.A.T.M.A.N. V or=
=20
even bonding in B.A.T.M.A.N. V. But I don't think anyone of the developers=
=20
will react. I have therefore documented the background in=20
https://www.open-mesh.org/issues/464 and will send a patchset which uses mo=
re=20
descriptive names and reorders this calculation.

Regards,
	Sven
--nextPart5263483.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanTRrgAKCRBND3cr0xT1
yzoKAP4tAo9tZkYQ3fhZbmARuA3Zfr0Jg5KcSIH+u2NIcX2rLgD+K2jRljMl6jMC
bTghFlsQ7/TN/andWyX75pkJNiDVDAA=
=yFcm
-----END PGP SIGNATURE-----

--nextPart5263483.GXAFRqVoOG--



