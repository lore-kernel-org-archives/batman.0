Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAA0C001DF
	for <batman-adv@archiver.kernel.org>; Fri, 28 Jul 2023 17:52:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 883EE825A5
	for <batman-adv@archiver.kernel.org>; Fri, 28 Jul 2023 19:52:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690566752;
 b=ZX9pA2y/lq3ZfagVYHtgHC6qdhA9E2UAckVGYs6GHfOW7ID0UJC2Yic7t+GWOSMTC1haG
 ezJP9W1NQtvxSBgEbXF88+V6L0NtxEBX3Im+pzCNc0rpaogJUARgtqzYjwR3qP93lsgnCnL
 hrv6ehDfFcJtrLvWTkZ+hjXBDopaQJk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690566752; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iY5diABUcV9YscHPRfYkwrRSUAb7aCtFJcN3n1+T9Zw=;
 b=X/KaZBinOTE8N2rWSqoQGHTIWHYutwqQqfR1PCnZfq/oCzy9SVDdItHSGr3ai2vEYGHPA
 T6xLCT3yZj+2J2Cl/k9GsR73KX4uY8oFwtEdihwAx3byq2/sx0gijtnqnU1vvMMwkmD5oeP
 rarJUUIvaP8PHywWD6JtKqWVLDPRPx8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B14098022E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 28 Jul 2023 19:52:11 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690566731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iY5diABUcV9YscHPRfYkwrRSUAb7aCtFJcN3n1+T9Zw=;
	b=2SXbeZG2WcAuReZ/4+Tv/kE/tfRGzmgNuVo+33zNEiEwZH52r1k8tr7iVe0n/zU8qL3fYw
	40HwebxhKNcuY4gcxeLa6whacYg2gwH02NUF6jTouioHnfdsKS06gFxyIFCI7qrA3pumgy
	3Pn/sEvGA80rJ58G0U/6p3eIPg4kJmU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="sEbG/DT3";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690566731; a=rsa-sha256;
	cv=none;
	b=MnV7/B5L7mLcSVrkOqBqb9dW3hOADxubxTz4YBe9wg1mnF0WokChFb0nf+cCgCvQn8a+Ca
	rf0BphNMyvMailKDYuUrL/IlQ6Kp1BL9pzBsSHGoYTLynbF3SBwXygHUEG/1TmoOdgFFNE
	D+oVw4pVJbzKO8E56b0KkjVPWruXctU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690566731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iY5diABUcV9YscHPRfYkwrRSUAb7aCtFJcN3n1+T9Zw=;
	b=sEbG/DT3Rn1vspazxUVzyDpnyL2LLOPGcgWkQhmgCBZrePAzVvucdL0wG1Mj2N7mRIOLXc
	N+0C6bgSuRDAo5SG5SrdsqXwxdUVvwD9WWmBi7vSc4XN4fBmlDD5wClOaodkfgXhc6Jiog
	W3p05TqiJxqs4v82YDtAWpnXnzbY6wg=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 1/3] batman-adv: mcast: implement multicast packet reception
 and forwarding
Date: Fri, 28 Jul 2023 19:52:03 +0200
Message-ID: <5938380.MhkbZ0Pkbq@sven-l14>
In-Reply-To: <20230720043556.12163-2-linus.luessing@c0d3.blue>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <20230720043556.12163-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1851512.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KD7YKXGZMO4JIMC3IFG4FF7A7EEUHDW6
X-Message-ID-Hash: KD7YKXGZMO4JIMC3IFG4FF7A7EEUHDW6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KD7YKXGZMO4JIMC3IFG4FF7A7EEUHDW6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1851512.VLH7GnMWUR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 28 Jul 2023 19:52:03 +0200
Message-ID: <5938380.MhkbZ0Pkbq@sven-l14>
In-Reply-To: <20230720043556.12163-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, 20 July 2023 06:35:53 CEST Linus L=FCssing wrote:
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
>  include/uapi/linux/batadv_packet.h |  45 ++++-
>  net/batman-adv/Makefile            |   1 +
>  net/batman-adv/main.c              |   2 +
>  net/batman-adv/multicast.c         |  48 +++++-
>  net/batman-adv/multicast.h         |   5 +
>  net/batman-adv/multicast_forw.c    | 256 +++++++++++++++++++++++++++++
>  net/batman-adv/originator.c        |   1 +
>  net/batman-adv/routing.c           |  70 ++++++++
>  net/batman-adv/routing.h           |  11 ++
>  net/batman-adv/soft-interface.c    |  12 ++
>  net/batman-adv/types.h             |  64 ++++++++
>  11 files changed, 504 insertions(+), 11 deletions(-)
>  create mode 100644 net/batman-adv/multicast_forw.c

Acked-by: Sven Eckelmann <sven@narfation.org>
--nextPart1851512.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTEAEMACgkQXYcKB8Em
e0bbyA//UBBkURhB6jtMPhpy7Rv/OpuSnqNZO4Zt3jDlTcy4uG5qo7DRuPZgITki
SXwk/Rn7PANsRQdP4tlfqVAxSBxtD0qkChsl9WJ0yxTTdxlOzsms3zxkmn+lALTj
463z3RVbMuHOWjl+6JzUd3plM9lHDTOBBRtveUiTdjbaoYPpvhQ4r5zJnJFvsN0A
3BcCycZ9kNcZeO6gqOKiUBI4LbkJoIJjU5883xj1aPp+29XAca1lOWDRIpWhNSXv
q0pMdDM32pCpkAQ9nX1PZmktxWX4aO83rkuFKYiaJmQPp8/0rfJ8FcnVCY1BfFXj
tyVUcwZG7c1CiGVYW4UIH+AfUD52mHhgIhrF8CjJsahs6oYliTupCoCsHxSCanhn
v4f0R7YzJKRuY5TiwRog9b7gmlLDW8SixPB+buDr3EbHoIpK2pUjT8rDx3snRyd+
bM12I7kErHUb2GudCa+149GXXFh3txOfiASN8XhEP/MJgyUlyJqkF88Id2uuCpto
W0qNm5pXpyV+sHINin6z0f3O0ZXz/j2g5dJ3wgKwe9GGbUk1rR6jzewCZLXgpHUI
DUKgk3dhtwcHh5ccmqN/R4I4FM1zfqaofHH+QISkxqDUSwnKW8rgEymmOW1fzVPh
Etj43r+5aifk6T4lPmYcrnEQWr3NZy4VY9xcs3NU/GHqR2aHK10=
=TWnm
-----END PGP SIGNATURE-----

--nextPart1851512.VLH7GnMWUR--



