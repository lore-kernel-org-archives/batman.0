Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5B7C3DA78
	for <batman@archiver.kernel.org>; Sun, 15 Jan 2023 17:58:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8084D83C25
	for <batman@archiver.kernel.org>; Sun, 15 Jan 2023 18:58:13 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1318780314
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 15 Jan 2023 18:57:46 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673805466; a=rsa-sha256;
	cv=none;
	b=mSs4HYp2rgOMEjJJMMB9ADOSpdSYZ4hEznoMUW0vMqlKmywt6fa/MWkb6CSa13+D/PLn6U
	k78Fzb0N5lQL2EVHiSNGmkQB09lg8IXmU6vF5ID6Gt2CjdPafr/1aN+BAiCTlmlObd/HDC
	R/zSBouhXfDUJsSSsY9KUPwTU/qlxG0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nTaaFUSI;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673805466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L8hgV9/13cSNlY0KxHqeT4rHciyGu7iUw2CE2/wCDPs=;
	b=L250uTZfeNluPcAjTobMTM6TF4SXjpc2I3RYKnCnoOO1CAdarXHlK38YGF0XZVc39R15aW
	BEmAfAOIp6wG6Efjcte4RKRUkZBz7gdHhz5ebFtKEcVGwyrC2dvKQ2B+4t1seOUCXWS8lV
	YMtu/swGxwRUU/Gs9y3YCcqr9iR1LoI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1673805465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8hgV9/13cSNlY0KxHqeT4rHciyGu7iUw2CE2/wCDPs=;
	b=nTaaFUSIayiftDNC3THeIs4cEp0NRqpjgwsMXd5Tu4jYIisYEbrnosBTB1pLGOXdByRY6g
	huPNwClCWXx+YoEpzNY38Pe5FQhSckakJAFiqI1HDG6ZgOMKORJLodxxriawPbpyYPfUn+
	Ujyp26yPKIx3FirSBi7D0jbt2xnT+/A=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH v4 3/5] batman-adv: mcast: implement multicast packet reception
 and forwarding
Date: Sun, 15 Jan 2023 18:56:37 +0100
Message-ID: <7420352.31tnzDBltd@sven-l14>
In-Reply-To: <20221227193409.13461-4-linus.luessing@c0d3.blue>
References: 
 <20221227193409.13461-1-linus.luessing@c0d3.blue>
 <20221227193409.13461-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3634739.3Lj2Plt8kZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KCJTRTG7HNYH4EOTFZLDQJ6QNQ4EHR4D
X-Message-ID-Hash: KCJTRTG7HNYH4EOTFZLDQJ6QNQ4EHR4D
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KCJTRTG7HNYH4EOTFZLDQJ6QNQ4EHR4D/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3634739.3Lj2Plt8kZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 15 Jan 2023 18:56:37 +0100
Message-ID: <7420352.31tnzDBltd@sven-l14>
In-Reply-To: <20221227193409.13461-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Tuesday, 27 December 2022 20:34:07 CET Linus L=FCssing wrote:
> Implement functionality to receive and forward a new TVLV capable
> multicast packet type.
>=20
> The new batman-adv multicast packet type allows to contain several
> originator destination addresses within a TVLV. Routers on the way will
> potentially split the batman-adv multicast packet and adjust its tracker
> TVLV contents.
>=20
> Routing decisions are still based on the selected BATMAN IV or BATMAN V
> routing algorithm. So this new batman-adv multicast packet type retains
> the same loop-free properties.
>=20
> Also a new OGM multicast TVLV flag is introduced to signal to other
> nodes that we are capable of handling a batman-adv multicast packet and
> multicast tracker TVLV. And that all of our hard interfaces have an MTU
> of at least 1280 bytes (IPv6 minimum MTU), as a simple solution for now
> to avoid MTU issues while forwarding.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/batadv_packet.h |  48 ++++-
>  net/batman-adv/Makefile            |   1 +
>  net/batman-adv/main.c              |   2 +
>  net/batman-adv/multicast.c         |  48 ++++-
>  net/batman-adv/multicast.h         |   5 +
>  net/batman-adv/multicast_forw.c    | 274 +++++++++++++++++++++++++++++
>  net/batman-adv/originator.c        |   1 +
>  net/batman-adv/routing.c           |  68 +++++++
>  net/batman-adv/routing.h           |  11 ++
>  net/batman-adv/soft-interface.c    |  12 ++
>  net/batman-adv/types.h             |  64 +++++++
>  11 files changed, 523 insertions(+), 11 deletions(-)
>  create mode 100644 net/batman-adv/multicast_forw.c


Acked-by: Sven Eckelmann <sven@narfation.org>

But I want to have at least another maintainer checking the new packet form=
at=20
and acking it.

Kind regards,
	Sven

[...]
> +static void
> +batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
> +			      struct batadv_neigh_node *comp_neigh, u8 *dest,
> +			      u8 *next_dest, u16 num_dests)
> +{
> +	struct batadv_neigh_node *next_neigh;
> +
> +	/* skip first entry, this is what we are comparing with */
> +	eth_zero_addr(dest);
> +	dest +=3D ETH_ALEN;
> +	next_dest +=3D ETH_ALEN;
> +	num_dests--;
> +
> +	batadv_mcast_forw_tracker_for_each_dest(next_dest, num_dests) {
> +		if (is_zero_ether_addr(next_dest))
> +			goto scrub_next;
> +
> +		if (is_multicast_ether_addr(next_dest)) {
> +			eth_zero_addr(dest);
> +			eth_zero_addr(next_dest);
> +			goto scrub_next;
> +		}
> +
> +		next_neigh =3D batadv_mcast_forw_orig_to_neigh(bat_priv,
> +							     next_dest);
> +		if (!next_neigh) {
> +			eth_zero_addr(next_dest);

Why is the original skb not touched in this case?

It might not be a problem because you are also doing the=20
batadv_mcast_forw_orig_to_neigh check in batadv_mcast_forw_packet. But I wa=
s=20
just wondering about it


Btw. it could happen that you send out a packet with zero destinations in t=
he=20
TVLV because the neighbor disappeared between the=20
batadv_mcast_forw_orig_to_neigh in batadv_mcast_forw_packet and in=20
batadv_mcast_forw_scrub_dests

Kind regards,
	Sven

--nextPart3634739.3Lj2Plt8kZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPEPlUACgkQXYcKB8Em
e0YGOw/7Bs5QVe7QGWv1Ou/Mk1XD6uQiWbPt5IAq/LiQ08JXkGl7ptRXMSqGKdl6
r2JVkeOrJDfUB5+acS8M6UwCOTrmiR3LkIF6nslAQm4PhhFbdmFTnJ91Rw2j2lVx
lbFxGUjUZU3IE97Alt4I8H+BvjjxU25lzEZ7eBDYqdoEUnNZbpue/sjlm/o7lUEy
NUbES2PtWUNoH2PzONwzUleBqPmyyfTYatlG81IMTyXwhmK1JJeNSVsQ7bYN1f7A
DuoQSe8lkuFPl9X7usQImV6aBcAEWsESs+yJlQd/wDMdnEwZLcbTYJRXPyCUTiNh
gyVTzPOgLdxHa56t6702Oca2EOXkGvSs9zK3yJrKiwU06Ze+JxphV9SH5Jz/nAgX
ImYsr+QrYhrdApqEQ69q3yaxPCh1TIg7ZyJpSGh47u+wJtFaBlk1wyYjvsWTuh06
YzrbM6ig1shtCih4r1nI9YKZzw0hZnrUxDxY0+sUBNREMzmLgiaXAzQcOFFcI/4t
b1isgqN6VYXrO2sJaU9X4PP5r1Rk4ECMwYlOb79hTg2iuBiArnRgAp/dH5Ka0G0M
6T3dJMe93Jb2B9MmgK5tunSeg56bl5/E01JJi5vL1y/rvnpdjUNwHlDSZ2FNzCpe
b1Hv4pMTH/vzBz388DUZ7s+GYr5QwZojwFi26yeHb0UOA6J23jI=
=xVAB
-----END PGP SIGNATURE-----

--nextPart3634739.3Lj2Plt8kZ--


