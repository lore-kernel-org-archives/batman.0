Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81213C32793
	for <batman@archiver.kernel.org>; Wed, 18 Jan 2023 21:29:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9302483E6C
	for <batman@archiver.kernel.org>; Wed, 18 Jan 2023 22:29:41 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 93ADC8059E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Jan 2023 22:29:18 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1674077358; a=rsa-sha256;
	cv=none;
	b=olio4f9sy0sZHDJpdN2w4IA2nTlCz6I/R+Zf3aCKyZmWjfbgpAhqI0lm+bxUDBkS5gGqFL
	4ddH3UxVhVIDNMAtKuLDe4rV6mMpQGmYDGzJ6WppHLoSexvepoiiLDbn2J/n5w6E4YhykT
	5Oe0zJpG2MCQVGA6vXw/itV3wtkZ5dI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Qe2ISMZg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674077358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=c3uN558jdzeIgyZBuftZ+YdMLursq3BRxkPGrONxYAI=;
	b=4LNkL+p1D+PZdOMqvlmxyJU3dmGCWw/DWjdSgwMnMlk75TTKTRPGTfY7FmRkcDoMTyYq8a
	ts3vqhKdNO/1ccKNGLhkv+1v7DO8CWcxwIBQO6uU/qp47Gak3StMIj2kDN9rijdJqb7W5H
	TiZKUzUE+BdgME4blSQpKcZqL8X1Y1U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1674077358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3uN558jdzeIgyZBuftZ+YdMLursq3BRxkPGrONxYAI=;
	b=Qe2ISMZg9CSqqT0W/1iFJrUlFXjaXmXTJ+DkXyiYFwLfrqJaQPzKVjpylitnyR/X/lM1Po
	QpghA80hDMVwqih0FCiCqZdcmyyTfsnobJKUznq6j0+LpwicY+mGACAmK93UY1lidUxRPg
	2LazWAzIjVgfMijjgSwNF4zZ01KV+U8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 5/5] batman-adv: mcast: shrink tracker packet after scrubbing
Date: Wed, 18 Jan 2023 22:29:10 +0100
Message-ID: <2573733.TEPBkUXb7U@sven-desktop>
In-Reply-To: <20221227193409.13461-6-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-6-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2105277.ILssMJAjO1"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 3NREUGWH62V3K3XFDLXV7ZAJPUMU3OAH
X-Message-ID-Hash: 3NREUGWH62V3K3XFDLXV7ZAJPUMU3OAH
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3NREUGWH62V3K3XFDLXV7ZAJPUMU3OAH/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2105277.ILssMJAjO1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 5/5] batman-adv: mcast: shrink tracker packet after scrubbing
Date: Wed, 18 Jan 2023 22:29:10 +0100
Message-ID: <2573733.TEPBkUXb7U@sven-desktop>
In-Reply-To: <20221227193409.13461-6-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-6-linus.luessing@c0d3.blue>

On Tuesday, 27 December 2022 20:34:09 CET Linus L=FCssing wrote:
> +/**
> + * batadv_mcast_forw_shrink_move_headers() - move multicast headers by o=
ffset
> + * @skb: the batman-adv multicast packet to move headers for
> + * @offset: a non-negative offset to move headers by, towards the skb ta=
il
> + *
> + * Moves the batman-adv multicast packet header, its multicast tracker T=
VLV and
> + * any TVLVs in between by the given offset in direction towards the tai=
l.
> + *
> + * It also invalidates the skb checksum.
> + */
> +static void
> +batadv_mcast_forw_shrink_move_headers(struct sk_buff *skb, unsigned int =
offset)
> +{
> +       struct batadv_tvlv_mcast_tracker *mcast_tracker;
> +       unsigned int tracker_hdrlen, len;
> +       unsigned char *skb_net_hdr;
> +       u16 num_dests;
> +
> +       skb_net_hdr =3D skb_network_header(skb);
> +       mcast_tracker =3D (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
> +       num_dests =3D ntohs(mcast_tracker->num_dests);
> +       tracker_hdrlen =3D batadv_mcast_forw_tracker_hdrlen(num_dests);
> +       len =3D skb_network_offset(skb) + tracker_hdrlen;
> +
> +       memmove(skb->data + offset, skb->data, len);
> +       skb_pull(skb, offset);
> +
> +       /* invalidate checksum: */
> +       skb->ip_summed =3D CHECKSUM_NONE;


Shouldn't the invalidation be that already part of the patch 3? At least it=
=20
includes receive path processing and modification on the tvlv with the=20
destination originator addresses.

Kind regards,
	Sven
--nextPart2105277.ILssMJAjO1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPIZKYACgkQXYcKB8Em
e0ZjfA/7BywusEGpHxphNM3KQBVl1ygWwxrRCGoW9u0/0haAgf00RV2GanUwKKdk
zaUucrUgtxgdw49L+5X0bYVcoBuSWJHTdH8Gvy41R3lr7AQgIXY5DVjN+ABNP9+D
7A93JMUBJ3cyXhlVfyOT5LhJ0AcOV+P/XCMEO+1PWSMwyhwTd2fj9DvhYs/Kjky8
RTQ09wuzvu4me7Rrfb0ReSvCedHg+Jksw/Ueri086mAkLi2xZI2HIviX5qbJ8oZo
C+nMmxVLdHWThn2wIdoHLP1ixcrlc0xaTt3eXswxcz8awWRfceGkrckqzWM6sJzs
vvHrcYjhsXeJtPbe7MU3dJiAtkdlHS1g1dNLljYQ595RJDndaUPt7pmYu6pzlFtK
Jny5KEc+EUUc2ABaamTds8TnJ+ZtbDh6/MatN/4T6fmaSnXaEFA/7U9niYmsfBA9
jUykxx8NTKUlkuundfjCUGE7lnKlp3TAdhE1lRWQOjsjUyQAFZ1aRmjKHEpfdKzX
8q4VttxVkG6RbVwK9YcyiF4BRcwXBlIr1uSKJSilpKRW5Etq+q04UK9FUu2VemKe
tl0LeBbroZMrwZWPBNp79nuf5P/9Oij4SEqgT+YljqrWUGTfsU2C+tKMI2VBXq1+
bx7tqh+0PFGhl1N3vHGC4X18kyW1fr5kHCffri4NUvPaGBny6cE=
=Yw0b
-----END PGP SIGNATURE-----

--nextPart2105277.ILssMJAjO1--


