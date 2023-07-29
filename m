Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F14C001DC
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jul 2023 10:49:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9ECFE81F29
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jul 2023 12:49:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690627796;
 b=i44/YQeb4wKAlqS1IYtCSNy/VqqTJtCrxRjJNGPnxECSlr9JtNsZvOQHL1lPkbgx9zV6K
 CZNN7e5lV8R57L+g/UQ3jbnxGmMKcz1QGUNKSGYC2v2DRez+9/qcVm/AxBNHH1ufzI8Eupg
 rAfoNrNrr3IUQBwWmwWWBWL51dHuqrM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690627796; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6YjGmddjXU4zJIFdLQniMJxUubfu7S2RfaK8+4Mi1Cg=;
 b=DqT6cDh5lVoi40wakYgbRHW39SN+vr9di4aovIgUgSn1o7LiuF7iNJWKFinTPt2aolz5z
 W8QODpU7vy3MXTVR10K/cpn9AUCLFUYuvVY09Js06EIkchTgugZ7hxCpT7Fcw8NqszpbAAa
 ugU6CZaPqWNEuiwP+9g6VOOx03aCPC8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ECAF88076E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Jul 2023 12:49:36 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690627777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6YjGmddjXU4zJIFdLQniMJxUubfu7S2RfaK8+4Mi1Cg=;
	b=LgSKmzkef21uylDa2nrCWsO0Igl+2d1Fz8E9sdIFlNZFjLmcCgy2+bPxVgSwLIldN4YzYY
	HDrc+G+tQlfyjboRTtYYref+FxOesf3APxLbB36xgBRWdK+fjxAVOB1qhkcaNl84n+7ud6
	fynxQx4ejtaIiSto2MNsuxZVel7nFac=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xuIuU4Iz;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690627777; a=rsa-sha256;
	cv=none;
	b=tAu13SSRIfzZvycvH32uvcEphK9Y7gna0UfDFo+9TzIgVX6GUIq4VzydfoepIv5Fz204Sa
	Gn36nlWeHbyp4VlgsenZosQk/rOVAupnLUs1Kczkox0g1Z1TIfrsMkO5xjuGV+yxmy9c4/
	91+PCggVvRrF5tTSyVVqK6joN2zL/OI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690627776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YjGmddjXU4zJIFdLQniMJxUubfu7S2RfaK8+4Mi1Cg=;
	b=xuIuU4IzLue0bUAGC3gak0NX54FYK3cKyZBK+G5UbMRtpiiJbN0Gcn9uGr+uKIakyqmlZn
	06pU1pvOsR31oIwE0vT/xGwdbcgsYwKeZA+O8XdRjY/zL9bH6JC0zKWDqpzbOcErrB6zFD
	90yYScQyfsPHjwXrPkcWuqlrzu3uuNw=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 2/3] batman-adv: mcast: implement multicast packet generation
Date: Sat, 29 Jul 2023 12:49:29 +0200
Message-ID: <2654113.Lt9SDvczpP@sven-l14>
In-Reply-To: <20230720043556.12163-3-linus.luessing@c0d3.blue>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <20230720043556.12163-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4368739.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: UIB5Z2AIBFG43UPMTWP6RCAWUAZYIOMX
X-Message-ID-Hash: UIB5Z2AIBFG43UPMTWP6RCAWUAZYIOMX
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UIB5Z2AIBFG43UPMTWP6RCAWUAZYIOMX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4368739.ejJDZkT8p0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 29 Jul 2023 12:49:29 +0200
Message-ID: <2654113.Lt9SDvczpP@sven-l14>
In-Reply-To: <20230720043556.12163-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, 20 July 2023 06:35:54 CEST Linus L=FCssing wrote:
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
>  net/batman-adv/multicast.c      |  79 +++-
>  net/batman-adv/multicast.h      |  25 +-
>  net/batman-adv/multicast_forw.c | 727 ++++++++++++++++++++++++++++++++
>  net/batman-adv/soft-interface.c |   6 +-
>  net/batman-adv/types.h          |   6 +
>  5 files changed, 835 insertions(+), 8 deletions(-)

Acked-by: Sven Eckelmann <sven@narfation.org>

> +/**
> + * batadv_mcast_forw_scrape() - remove bytes within skb data
> + * @skb: the skb to remove bytes from
> + * @offset: the offset from the skb data from which to scrape
> + * @len: the amount of bytes to scrape starting from the offset
> + *
> + * Scrapes/removes len bytes from the given skb at the given offset from=
 the
> + * skb data.
> + *
> + * Caller needs to ensure that the region from the skb data's start up
> + * to/including the to be removed bytes are linearized.
> + */
> +static void batadv_mcast_forw_scrape(struct sk_buff *skb,
> +				     unsigned short offset,
> +				     unsigned short len)
> +{
> +	char *to =3D skb_pull(skb, len), *from =3D to - len;
> +
> +	memmove(to, from, offset);
> +}

Just because I remembered it when reading a comment: SKB_LINEAR_ASSERT(skb)=
=20
might be a good idea in places like this. Not all over the place but actual=
ly=20
in the code which operates on the buffer and assumes the skbuff to be=20
linearized. skb_put would do such a check (because it is a put at the end o=
f=20
the skb) but not an skb_pull.

Kind regards,
	Sven

--nextPart4368739.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTE7rkACgkQXYcKB8Em
e0Y0RxAA0n69X+XszGca631r7NLAyMUFSdk4lKKtBmuvm1fK3RWuyBB6NCasDZDe
2QAZECmGRbY3vFcPM5aeDadtIvdj1ugHUWhlAnk/8q9gPdsUwNWoyEbyMUJQzeYY
uuwRlmRTn2hB/medGAJvv6veopSfHp09lloeeUaeAAkhQHdA8L8uGIJOrVTDx5KO
fWMi9xkjdETDnXNWQPBAxOqvXIWzEKKoDJXogLOnz7XqL+qiJnjf9FJ37EWFdvU3
yrhoazJxWvETMK0vCbSclEJGH31OOQucr63sKCTfuyIsMDnYi5jVDW2Ze7uf5S2n
NkpKoXVqIwiZOcAIOSuuz1tGlkWW+9nceps//33mTyvklD9OkC/t66F562HWi95i
uDls0mAFpL0Lw86Ux5BGE8Ta678l6X9jdSLXI3Ptu77ZiTW2QopJQgZWqsGJSk36
oaYQ5m4Q4VQGrgYpyUo2OJiSEpKijj+mrpS911BFf6HiDB+yX+KnHd/j1QbFw+wA
a2n386r35obEXK9XsBOMW8imiuaEeG3PjPmnTj37QhPy6fufyodwqt8lLvfzs1Hv
ICfTUGKFqBnE3mheAe0YAdWOSCIspQLb6sXVa14uHdFHfvx4Xjemiz1q1ztEz243
wHrg1nnW2JRQfYmm25hOTwlB8nSuHrGvbRuG2M+T4eWIid8K4ZY=
=K2hc
-----END PGP SIGNATURE-----

--nextPart4368739.ejJDZkT8p0--



