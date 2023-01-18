Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46212C32793
	for <batman@archiver.kernel.org>; Wed, 18 Jan 2023 21:16:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A207E83DFB
	for <batman@archiver.kernel.org>; Wed, 18 Jan 2023 22:16:14 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AE7168065C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Jan 2023 22:15:46 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1674076546; a=rsa-sha256;
	cv=none;
	b=ahi5OdAHcEojuek8WpbkrOfuTtWZ+YixFnaHy/RqJUMb4KkfxdRzC/1XbaGH4wO1JEPzr/
	g52fs7xBMKdGpyjKyw9yYCEGAtNpO7UjEFGMk+qG6DFBQYL/HGeiE/41B1OT/kFKSRdF7a
	RpQWImcxnKAjTzxW5RoQ+w5FmG1yBdI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Rz/2HCZU";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674076546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=35gY9HMGR8qg3128Le4UDVr1HUZ3REP4aNiiCNLt5Wg=;
	b=nvRdIzWlvSQNI1WNiNiuLb6cI+kJQiPFzzidlLACfbyOKKmj7sD5QpjCNMMEVwZhKm9dJT
	QGhmZnfc//uWBvo3/ztII5YnXPRLfO8nK0RxHgtJdBQz588/JZvsHICiLXHSatHzs/wewl
	Wmb7SWzZf/pY2fKhYA6+lggTG2kgwmw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1674076546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35gY9HMGR8qg3128Le4UDVr1HUZ3REP4aNiiCNLt5Wg=;
	b=Rz/2HCZUQkZkgUzSvLwo5QC8rd/jjdylq5PAtya1R3gkiiOYB2ZUXFYpOj5qxZCsTz0sxS
	hcuLqqLYZvTHh8MTT1L8VvIiCZRSTsD6WnAc2J7aojQS/84xeHLPn4TMygnXxj7DQra7Ev
	ejMFcozLKit/MKu5gfYADL433ABND9s=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 4/5] batman-adv: mcast: implement multicast packet generation
Date: Wed, 18 Jan 2023 22:15:35 +0100
Message-ID: <6523978.yeldW9W7Dk@sven-desktop>
In-Reply-To: <20221227193409.13461-5-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-5-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1810144.VFTImQeyzU"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 5MQMBTFWTGJ3NS6ZNEIIZDTUTGBQPVQ2
X-Message-ID-Hash: 5MQMBTFWTGJ3NS6ZNEIIZDTUTGBQPVQ2
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5MQMBTFWTGJ3NS6ZNEIIZDTUTGBQPVQ2/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1810144.VFTImQeyzU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 4/5] batman-adv: mcast: implement multicast packet generation
Date: Wed, 18 Jan 2023 22:15:35 +0100
Message-ID: <6523978.yeldW9W7Dk@sven-desktop>
In-Reply-To: <20221227193409.13461-5-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-5-linus.luessing@c0d3.blue>

On Tuesday, 27 December 2022 20:34:08 CET Linus L=FCssing wrote:
> Implement the preparation of a batman-adv multicast packet and use this
> under certain conditions.
>=20
> For one thing this implements the capability to push a complete
> batman-adv multicast packet header, including a tracker TVLV with all
> originator destinations that have signaled interest in it, onto a given
> ethernet frame with an IP multicast packet inside.
>=20
> For another checks are implemented to determine if encapsulating a
> multicast packet in this new batman-adv multicast packet type and using
> it is feasible. Those checks are:
>=20
> 1) Have all nodes signaled that they are capable of handling the new
>    batman-adv multicast packet type?
> 2) Do all active hard interfaces of all nodes, including us, have an MTU
>    of at least 1280 bytes?
> 3) Does a complete multicast packet header with all its destination
>    addresses fit onto the given multicast packet / ethernet frame and
>    does not exceed 1280 bytes?
>=20
> If all checks passed then the new batman-adv multicast packet type will
> be used for transmission and distribution. Otherwise we fall back to one =
or
> more batman-adv unicast packet transmissions, if possible. Or if not
> possible we will fall back to classic flooding through a batman-adv
> broadcast packet.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c      |  79 ++++-
>  net/batman-adv/multicast.h      |  25 +-
>  net/batman-adv/multicast_forw.c | 513 ++++++++++++++++++++++++++++++++
>  net/batman-adv/soft-interface.c |   6 +-
>  net/batman-adv/types.h          |   6 +
>  5 files changed, 621 insertions(+), 8 deletions(-)

Acked-by: Sven Eckelmann <sven@narfation.org>

Btw. it is spelled "outer" and not "outter"

[...]
> +/**
> + * batadv_mcast_forw_expand_head() - expand headroom for an mcast packet
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to send
> + *
> + * Tries to expand an skb's headroom so that its head to tail is 1298
> + * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
> + *
> + * Return: -EINVAL if the given skb's length is too large or -ENOMEM on =
memory
> + * allocation failure. Otherwise, on success, zero is returned.
> + */
> +static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
> +					 struct sk_buff *skb)
> +{
> +	int hdr_size =3D VLAN_ETH_HLEN + IPV6_MIN_MTU - skb->len;
> +
> +	 /* TODO: Could be tightened to actual number of destination nodes?
> +	  * But it's tricky, number of destinations might have increased since
> +	  * we last checked.
> +	  */


But it might at least be a good start. So basically a "we can at least=20
guarantee that there is enough room for what we've seen in our precheck"

And you could make sure that we still have enough headroom for our lower=20
devices. Not that we steal from the headroom which they need - because your=
=20
headroom is not part of the needed_headroom which we report. But of course,=
 we=20
don't know the outgoing device (yet) - so this makes it harder to figure ou=
t=20
how large we need to allocate it.


Kind regards,
	Sven
--nextPart1810144.VFTImQeyzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPIYXcACgkQXYcKB8Em
e0bTPxAAzhreOAl+WsxPkXoZgU2qwG9XJnI7PdDVg+jk/JX2wfCuSAvi5tRh2CA9
V/9SNZ2QIW3V/ipHvC7Ae8tujVxrk8SXnmQqF78TZSBvBu9eEtQHUv9bu2J9fmOh
gtvP9hjeU4umZWrIoDAM1BrMGU5XO47pBcTyzDVKjlQReLRznPiE5A2c99H1QPXN
ub5mIPdWznkIjeAcZgX1vMD1393C0UIsritRugOhMeUNJAaLfUN6MSDk7cvDDjlt
VzHe4VUr3d5DF/phq+cSsdoPCFvrzQGDHV9NKZUlvWI7Nr3wNduIs1APWcnHseQm
hDuzYtNR7ahdMT1ozeQNflbSOLf3sR6TxzuGHAa16jDy/0L/SEl40M2pQ1yx1Rq8
maCLDcdIQsVO2UHsv8hXAuh5Dy3rTUquBBXO8U5hCvsYghP6JmUf9zC3Ka5irhBH
R8tDI/o1HFVjWIcpoQsyed8Pz/QgYPbxiTmW4Pp5zmSQI7inq+5SgARVAfBdMCHC
zjGeyfAtAHrreXT+7qmdv7j74o5kXW97nf4K4GIlwSm8uJ6aMKUEJGr8Rli/boP9
NGxknOxdp76tyqgk5u7jhdE89K4og8ma41ZkYPDNVUx/2/wgdi782Qy0r+g4d+ZU
j28YaR3RkANzBvoeE0f6hbCBEHzozWlIlplKlgKYV9ct0LzBigI=
=toue
-----END PGP SIGNATURE-----

--nextPart1810144.VFTImQeyzU--


