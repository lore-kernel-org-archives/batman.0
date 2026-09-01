Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A685CC624D3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 17:24:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 005228212D
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 19:24:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788283474;
 b=opyo7zes4fov3xCV7AIo0YHlmyt3KP/beIiFevU3a1S1HjzOZYU2Kn7huMn4gvQ9NIgpr
 mhImGgV3s6iMR0GsqAfi1hdZJW6RExglTiR4J4eZUQtiim4B+W78iT1GZrlmDdMhz+msykh
 LXNlFyAwzcaXs9+y431wzpF1Rym4dJg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788283474; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=X1ppzOEJMSS7dm9q753kJPAR6gmpcAyyraBBvCv4WzM=;
 b=wEJiLjGjcxaGP1XueLAx0asGL01Q98PzS9eIQ6UQoYhA0aiopmitl0vCtnnSfNgqgISvU
 7914gTXtYahfYRYcsnE9mIOBmSqnbZEV5Hf9wjcnJzhq7jkWiTmTkJ5lHJHO8Vw4wjPikQw
 ebPDVk2czTT4FmnH58H2oKHdQJg33uQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CB43D80E31
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 19:24:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788283466;
	b=VZEUVe12jLngT1luFFVuuHy34l1D86O9hi/1fjjqAENCh6Vhnis6K1w+65Zzs94Q6VlJYh
	nP+joyAoLxwPken/S51RwO6BZVj4vRjGqJZyJaPeGVKnFdxQpTQNy+p4bb0jHFdz5fvS+6
	k2ZMJ08ShQTEbYAlXaBjWOR9UKufiok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788283466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=X1ppzOEJMSS7dm9q753kJPAR6gmpcAyyraBBvCv4WzM=;
	b=R1Ax42VJWK9H8Ctx6meKonIL/Tsw7xXl2n32ueJrnFFcewBq63Q5eWIHMw/32c2EpBareA
	s89/zGnuCRHPc0+f4MCUVdE2d62E85qXQbC0KWNca1i6dKzQlv6Ju77fgopJjPHLx12N0K
	Nmm5nsfo0eCnZ8aumW6Ps9pMBlHsAlA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eEKWGOGD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0DF0E1FE7E;
	Tue, 01 Sep 2026 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788283462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1ppzOEJMSS7dm9q753kJPAR6gmpcAyyraBBvCv4WzM=;
	b=eEKWGOGD99etOq6BW66ReYBKdbCCj5IZuQTpKzuD6ewCo8I2JcmlNFi6tC4mqLfNynVI5X
	5hqHk2DXvNVszm719u/p/UZ7DEfV54BdKdvrRPbpn8TdFsWXyGXXblEz08Sw9NjkBfjpaa
	y486llneMYZKQ7rptIr7w/7AbQZIOHc=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 07/15] batman-adv: ensure u16 aligned mac address
 in
 structs
Date: Tue, 01 Sep 2026 19:24:14 +0200
Message-ID: <2932049.BEx9A2HvPv@sven-desktop>
In-Reply-To: <20260831135117.574836-8-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-8-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15835535.tv2OnDr8pf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: MP5VBM3VJHFXEE3GROGTY6OTB6TIJEPD
X-Message-ID-Hash: MP5VBM3VJHFXEE3GROGTY6OTB6TIJEPD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MP5VBM3VJHFXEE3GROGTY6OTB6TIJEPD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart15835535.tv2OnDr8pf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:24:14 +0200
Message-ID: <2932049.BEx9A2HvPv@sven-desktop>
In-Reply-To: <20260831135117.574836-8-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D7

> > An u8 array in structures have a natural alignment of only 1 byte. An
> > u8[ETH_ALEN] array must therefore be assumed to only be 1 byte aligned.=
 But
> > many etherdevices.h functions are requiring a 2 byte (u16) alignment.
> >
> > All these addresses were either on the start of a struct or after a str=
uct
> > member which required at least an alignment of 2 byte. Still, annote all
> > u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure that this
> > assumption isn't broken by other modifications inside the structs.
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should "arrays on the stack" read "arrays in structs" here?

Yes, copy+paste error. Minor for this PR

> > diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> > index 99667f632d4d..c42a4aa8f41a 100644
> > --- a/net/batman-adv/types.h
> > +++ b/net/batman-adv/types.h
>=20
> [ ... ]
>=20
> > @@ -634,12 +634,12 @@ struct batadv_hardif_neigh_node {
> >  	struct hlist_node list;
> > =20
> >  	/** @addr: the MAC address of the neighboring interface */
> > -	u8 addr[ETH_ALEN];
> > +	u8 addr[ETH_ALEN] __aligned(2);
> > =20
> >  	/**
> >  	 * @orig: the address of the originator this neighbor node belongs to
> >  	 */
> > -	u8 orig[ETH_ALEN];
> > +	u8 orig[ETH_ALEN] __aligned(2);
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Is the claim "All these addresses were either on the start of a struct or
> after a struct member which required at least an alignment of 2 byte"
> accurate for batadv_hardif_neigh_node.orig?
>=20
> That member directly follows u8 addr[ETH_ALEN], which only requires 1 byte
> alignment; orig ends up on an even offset because ETH_ALEN happens to be
> even, not because the preceding member forces 2 byte alignment.  Would it
> be worth rewording that sentence?

But the struct member required indirectly an aligned of 2 bytes

Regards,
	Sven
--nextPart15835535.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcKPgAKCRBND3cr0xT1
y4a4AQCjFk+sHDBBtfBPMvaF9V3OJlOI2QTKV2YLoSyrTCPdTQD9HKjKrKBqT+eF
+cEhLzSLSqF5uZjv7X/hyPhVLG1+vQg=
=9UEE
-----END PGP SIGNATURE-----

--nextPart15835535.tv2OnDr8pf--



