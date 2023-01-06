Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96387C3DA7A;
	Fri,  6 Jan 2023 17:54:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 80981846E7;
	Fri,  6 Jan 2023 18:54:16 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EC57B80704
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  6 Jan 2023 18:54:11 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673027652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4RnskvD0sPfFWrvvzCOeRK2FpF8AaFflIMbQkjTXqj8=;
	b=w9mOIqgdY6aXJR0inPbHymT5CdQGOgRJMJRAYFBsZy8e3SkE/SiObOR6I+C2pbph4o76UH
	a8jvVbCy8qObaIIUVpPUPwl4PXS3566XDWU5x+ayyZ8dyOdrYe2UyjuIJuyQpWHqNLwwcG
	lVAqMvpd6UZyG99a7VOcQIRvB/ZO3wc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CcCh6Z0s;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673027652; a=rsa-sha256;
	cv=none;
	b=iauxvl01tmL0J/4jdaP70IJuTFz2M0sjh9/pPn/Jo4x1bVSvZ57SX3MPp5j+PudLNTUZOA
	+cggwNDskqaAZawHu97osqIUl915XMBt6xuu8QmtpoIUkAqsak62+/GKWsYRqMnxhxlJwu
	NgqNUQn9PHObp7YGF6uUwSTAAIbNU30=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1673027651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RnskvD0sPfFWrvvzCOeRK2FpF8AaFflIMbQkjTXqj8=;
	b=CcCh6Z0sNRQtyLwAFMFeJg8HC6ipkSHNOuOJtu5pSyXieqL78+Cpv1rWdSjtN3C6+533gQ
	T6SJQJeS+ya2Zcv0fUvYjrYkQTTpfGnPG6P93LUxtE9vw8I7rm2bbWbD0ByQqn7Ej7Zrj8
	42WawiryfM3wnVAg6TpXipwwzmQGJoE=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 2/5] batman-adv: tvlv: prepare for tvlv enabled multicast packet type
Date: Fri, 06 Jan 2023 18:54:08 +0100
Message-ID: <3853553.NG923GbCHz@sven-l14>
In-Reply-To: <20221227193409.13461-3-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart838040496.0ifERbkFSE"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: H6WUQXKCONLMFQQRLXLSKC43XFK4IKAC
X-Message-ID-Hash: H6WUQXKCONLMFQQRLXLSKC43XFK4IKAC
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/H6WUQXKCONLMFQQRLXLSKC43XFK4IKAC/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart838040496.0ifERbkFSE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 06 Jan 2023 18:54:08 +0100
Message-ID: <3853553.NG923GbCHz@sven-l14>
In-Reply-To: <20221227193409.13461-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Tuesday, 27 December 2022 20:34:06 CET Linus L=FCssing wrote:
> Prepare TVLV infrastructure for more packet types, in particular the
> upcoming batman-adv multicast packet type.
>=20
> For that swap the OGM vs. unicast-tvlv packet boolean indicator to an
> explicit unsigned integer packet type variable. And provide the skb
> to a call to batadv_tvlv_containers_process(), as later the multicast
> packet's TVLV handler will need to have access not only to the TVLV but
> the full skb for forwarding. Forwarding will be invoked from the
> multicast packet's TVLVs' contents later.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/batadv_packet.h     |  2 +
>  net/batman-adv/bat_v_ogm.c             |  4 +-
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/gateway_common.c        |  2 +-
>  net/batman-adv/multicast.c             |  2 +-
>  net/batman-adv/network-coding.c        |  2 +-
>  net/batman-adv/routing.c               |  7 ++-
>  net/batman-adv/translation-table.c     |  4 +-
>  net/batman-adv/tvlv.c                  | 71 ++++++++++++++++++--------
>  net/batman-adv/tvlv.h                  |  9 ++--
>  net/batman-adv/types.h                 |  6 +++
>  11 files changed, 74 insertions(+), 37 deletions(-)


I am rather unhappy that the TVLV handlers parts are not static, constant,=
=20
global objects which are just presented to batadv_tvlv_handler_register. Th=
e=20
batadv_tvlv_containers_process parameters start to become a mess. Anyway, t=
his=20
has not really anything to do with your patch.=20


Acked-by: Sven Eckelmann <sven@narfation.org>

Just wondering if it is a good idea to use the network/transport header=20
offsets/pointers like this.

Kind regards,
	Sven

--nextPart838040496.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmO4YEAACgkQXYcKB8Em
e0b/TA//R64HtpAzwiiX69YT0o79AcDtFuOYPUxsXBB4b6I6Cxmpbp7Slw3nuysx
GcA5fNP1hG01VoWJV6ckhv+jX7V7aDSqPDvd27PoFSuC5sC/7p1raK883th26+vb
Yalisrhr9lHUFfNEgP+OyzR7QYNEsLPIJj8WSl3mmODAfcGnxVS+VKg4nqT/jrA5
t/EE38dkGiZsQhHOYVZRwxVwlhPUZP1vqH8+HQzzxS8Y8Fuy+fVN2m76LtnOWNlv
bTJi+sFOtU0Ejb3OAxu42YTRi51TdiZvqc3J7MP8zK1h6pQlVb+2ksZ9saeeQzHI
rSib76gi82Chd+IWtzbbU3ZuQMNQl+/3hy6rqsOSnd62PaLcLvX1kBxL3FNSd89d
2UFxkI61utzxGjo4wsGWXGpcfb/SsgOugUA3oJsw9QSsjPw9uZ1PR0APRKEj5rty
EbCG92SIPia2AtecehyKrcS6f1AwDDakeQ8c66W1JJjqzxursQxQgHzYV0GpvE/N
tm57xaGYIaIEpuzAeOv6paVdTqX+vqr7xMhRnv7fMkd2puDgtrw7rovCf6XfTrLs
ruhwEnB6PRUHR5UzuMq9rlpwwu8wW4+TLv34V+4qa48+xpg8rlvlmAD3X13nUPmR
Ar6PXlSk0ZPVrWtkelxR7clsJb3mG3BUC6qxcTXla3sYR6pR9QQ=
=n7Xc
-----END PGP SIGNATURE-----

--nextPart838040496.0ifERbkFSE--


