Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F5C5B572
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 11:35:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E6B6681490
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:35:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787398527;
 b=XLKdkm0CLeh/HHCPmW2jPjSH/3h7tH87P8OxciG2qdZIBKuFqRf+VsQn0AEsi7rsdHdHf
 CJoZ8XWeJjDftHdYIuvVtrXHReWy+woQHahFibgueADzPCOSjip/jDML/EwR7Ql6fz5NHQ4
 NxH1xmjJPoiT73vH/u3ZjeZpM8LrLGY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787398527; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WOiom71t1by/uQEF/Udcx0yVbE8LR7SZNYRLdPXyC0w=;
 b=PJiMEw4WSSDcxpovVCl3VqwTQA3Q6zdEI+uEBszELd9BTp0o72mZoarqbzYhvf1Us05t6
 xbLCQhCLDYiAXD1mMhV9pSQSC4tPtwuog3SctUxusSPDIRl38LbfAN88GbHk57VrWr0wLsw
 r8qgICu5owc/E9gcECCb5EEqDKN8wrM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F0707814CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 13:35:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787398520;
	b=lmdKuK+VtvxGblHI4jIht26ino0gizABL5ryTNmU+hZXY8xr/aIMMtaBuzYcR+gq+U80ds
	A1O5XW3N7KFsErPfYvRHst4fZbJh/2TkwkbDg52eA3cgbpYwXK6G3zJjZAxkXu+6rHBrxO
	pO4Yg7XfYULBiZzeS+m+U+PeZY9q+eY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787398520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WOiom71t1by/uQEF/Udcx0yVbE8LR7SZNYRLdPXyC0w=;
	b=AKNGW0Rn05TaeKgVsNtC7c0gaFfw63QdwAt7jmZgwNGpA7qh0KrLmUBTMAhns9WPZRpIGz
	1VBZY/AMwWZyvPNMKADdcLKpGkBFtIrtGUIFyco8z2aRAsG0hztfYKjk+jdrw+G5YLcaP0
	ZzWyZ0tBcMZxF9nRFQZc/vfnAXFjHSE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vN0HVntM;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 03B081FDD3;
	Sat, 22 Aug 2026 11:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787398505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOiom71t1by/uQEF/Udcx0yVbE8LR7SZNYRLdPXyC0w=;
	b=vN0HVntMQ+37Vkra/uFtyrDuTSrdaGw6U2iiSUA8+VWf0hXZIFzpaBDvFFSA2uOKbGfVec
	eP968BzuVvCcWxY0g+vJiDz9GuG9DX3Dhy7/g7aPS+6Qi8zRXAcfmu8CPan0OYu8PAXP1M
	k0d+7RiwmdCjHKoBx1X8ZcetRW53k2w=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 6/9] batman-adv: fix TX priority extraction for
 BATADV_FORW_MCAST
Date: Sat, 22 Aug 2026 13:34:57 +0200
Message-ID: <1972590.CQOukoFCf9@sven-desktop>
In-Reply-To: <20260821094813.201800-7-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-7-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24491166.6Emhk5qWAg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 3LZPLQBVW2GTCNVXULAVA27VAXZSMNH6
X-Message-ID-Hash: 3LZPLQBVW2GTCNVXULAVA27VAXZSMNH6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3LZPLQBVW2GTCNVXULAVA27VAXZSMNH6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart24491166.6Emhk5qWAg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:34:57 +0200
Message-ID: <1972590.CQOukoFCf9@sven-desktop>
In-Reply-To: <20260821094813.201800-7-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D6

[...]
> > @@ -338,6 +340,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
> > =20
> >  send:
> >  		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
> > +			/* WARNING batadv_mcast_forw_mode might add more headers
> > +			 * in front of the skb. and might even reallocate the skb
> > +			 */
> >  			forw_mode =3D batadv_mcast_forw_mode(bat_priv, skb, vid,
> >  							   &mcast_is_routable);
>=20
> Discovered by: opus-5 =C2=B7 Missed by: gpt-5-6-sol, sashiko-gemini =C2=
=B7 Confirmed by: gpt-5-6-sol
> This isn't a bug introduced by this patch, but would it make sense to put
> this warning into the kernel-doc of the callee instead of (or in addition
> to) the call site?
>=20
> Today only batadv_mcast_forw_push() carries the contract in
> net/batman-adv/multicast_forw.c:
>=20
>   * Warning: This function may reallocate the skb data buffer via
>   * batadv_mcast_forw_expand_head()/... Any pointer into the skb data (e.=
g.
>   * obtained from skb->data or eth_hdr()) before this call must be
>   * considered invalid afterwards and has to be reacquired.
>=20
> The two callers=20

What are the two callers? I only find batadv_mcast_forw_mode_by_count()

> in net/batman-adv/multicast.c do not mention it.
> batadv_mcast_forw_mode_by_count() only says:
>=20
>   * For a multicast packet with multiple destination originators, checks =
which
>   * mode to use. For BATADV_FORW_MCAST it also encapsulates the packet wi=
th a
>   * complete batman-adv multicast header.
>=20
> and the exported entry point batadv_mcast_forw_mode() (declared in
> net/batman-adv/multicast.h) documents only:
>=20
>   * Return: The forwarding mode as enum batadv_forw_mode.
>=20
> Since batadv_mcast_forw_mode() is the exported symbol, wouldn't a future
> caller reading its kernel-doc have no way to know that skb->data was push=
ed
> or that the buffer may have been reallocated?

Will not modify this patch for this request. Linus (or anyone else) can dea=
l=20
with it: https://www.open-mesh.org/issues/466

>=20
> Related to that: batadv_interface_tx() does not re-acquire ethhdr after
> batadv_mcast_forw_mode() returns, even though the new comment warns about
> reallocation. The only later use, is_broadcast_ether_addr(ethhdr->h_dest),
> is evaluated before the call,=20

The later use is before? This is crazy

> so nothing is dereferenced stale right now.
> Is it worth re-acquiring it anyway, or noting in the comment that ethhdr
> must not be used past this point?

Will not modify the patch for this.

>=20
> >  			switch (forw_mode) {
>=20
> [ ... ]
>=20
> > @@ -355,8 +360,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_bu=
ff *skb,
> >  		}
> >  	}
> > =20
> > -	batadv_skb_set_priority(skb, 0);
> > -
> >  	/* ethernet packet should be broadcasted */
> >  	if (do_bcast) {
> >  		primary_if =3D batadv_primary_if_get_selected(bat_priv);
>=20
> Discovered by: opus-5 =C2=B7 Missed by: gpt-5-6-sol, sashiko-gemini =C2=
=B7 Confirmed by: gpt-5-6-sol
> This is a pre-existing issue and not caused by this patch, but while the
> priority handling is being looked at: should the multicast forwarding path
> also set skb->priority?

This is a feature (or maybe minor bugfix) request. Will definitely not deal=
=20
with it here. Documented it at https://www.open-mesh.org/issues/467

Regards,
	Sven
--nextPart24491166.6Emhk5qWAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomJYQAKCRBND3cr0xT1
yzw5AP469c4z36X+byxIhnBaFmyRFiC/GpvlzlbsdL78KzUgSAD/aOU0xoOo4kkb
LAvboFcaIx0WGERyigppjmQ/N0r+kA8=
=gQlZ
-----END PGP SIGNATURE-----

--nextPart24491166.6Emhk5qWAg--



