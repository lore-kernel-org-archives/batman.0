Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C6BEB64DA
	for <batman-adv@archiver.kernel.org>; Wed, 19 Jul 2023 09:22:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 573AC821A9
	for <batman-adv@archiver.kernel.org>; Wed, 19 Jul 2023 11:22:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689758545;
 b=06uhWnvkhzaj52WVVxdX7s61a8xbHPJC4RcTPFfI7IXCfUTUmf23aGhEM6i4MWEewI44k
 W0U4Kn3rLmtVS3BPtbk64C4BcYl+8CNnDZGaViKXeBlfkjytzbKZuHPLl2swtcCIgbKwE9I
 ZO1g2puFjXMfuVnPxwCjQCHqgJQy/WM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689758545; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mEWpYjjrY7iTSNPSw65KeuSgqNfLLQ8t1r7/plOeiUo=;
 b=iIo04LRixErnGNe/2abL5ywOgqLxsj5f0+xC9dcM9kfv05jHnp97lbS5xxDzAIR17V6yU
 UN34GinIJvQFfU7Qg+miB4yEK3zSzca8JwOi3GZpl6eQd2SRPbfW/oZKN1j1X1+yGTHOmK9
 HZtapuRW7j5Tv4OJ9vaPqbbi9DOvckc=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 112E2807AA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Jul 2023 11:22:14 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689758535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mEWpYjjrY7iTSNPSw65KeuSgqNfLLQ8t1r7/plOeiUo=;
	b=mRYJWMiSB+Zkz9Fcv1c5NGq0xodfQDWAf19hOTDWxF/qiGcl1Z703qAyYm4hmHEmB3D9sr
	tEdKWEKVnF6lY/bSAcXlRqGxIKy1IfsuyT3anU34l7WQWa+pRjo0ZhUIFQUwyP0IEPPXHs
	QnWIxqDosjA5aX/slA1O3c9vKnA499c=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1689758536; a=rsa-sha256;
	cv=none;
	b=SIHgKfxsS3DT9o7LHOYKSU2v+dZAGi7XQXaDkHb6TfaD+FRyfCztWVjgk0xuZjObzHGlvc
	s33ERO6oZELrHNPSc2aVxROd36HAzashGmR8qjZ8E+raURYSCrvfv4tkTNoBFA0bGzL8OA
	bhsWllfyIIhuzbIJVX9tGCZ8ht2qPKw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FOkiUMOv;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1689758534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEWpYjjrY7iTSNPSw65KeuSgqNfLLQ8t1r7/plOeiUo=;
	b=FOkiUMOv/Vz+01V1a6do/lHx4BSWoyEUm2jhtePQtrpucZT7EnlZ2DZLPiGx5+BSZxcxUH
	ZAwjHK48K9CZjTdeZBvqGP2f2lbV9yRM8ONFAsxHttuqa3LmKsUNzzcIK1S8qsP9UHo4Ce
	kpOcEgGvxyDewyN5MQl96F5bjZZULT8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v5 0/3] Implementation of a Stateless Multicast Packet Type
Date: Wed, 19 Jul 2023 11:22:12 +0200
Message-ID: <3919114.kQq0lBPeGt@sven-l14>
In-Reply-To: <20230708215113.15325-1-linus.luessing@c0d3.blue>
References: <20230708215113.15325-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3678145.iIbC2pHGDl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: V5R7MG345YOCHWMPJMH66OLEH4QLYIVE
X-Message-ID-Hash: V5R7MG345YOCHWMPJMH66OLEH4QLYIVE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V5R7MG345YOCHWMPJMH66OLEH4QLYIVE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3678145.iIbC2pHGDl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Wed, 19 Jul 2023 11:22:12 +0200
Message-ID: <3919114.kQq0lBPeGt@sven-l14>
In-Reply-To: <20230708215113.15325-1-linus.luessing@c0d3.blue>
References: <20230708215113.15325-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Saturday, 8 July 2023 23:51:10 CEST Linus L=FCssing wrote:
[...]
> Changelog v5:
> * removed patches 1/5 + 2/5, as they were already applied
> * rebased to current main branch
> * changed padding behaviour:
>   * now 2 bytes padding on the end of the multicast
>     tracker TVLV, if number of destination nodes is
>     even
>   * as number of destination nodes might change between
>     initial check until after pushing them, functions
>     to post-adjust padding after pushing were added
> * added/fixed TTL handling
> * removed skb_pull() bailing from sub-functions of
>   batadv_mcast_forw_push(), to only have a single
>   skb_pull() to keep track of in batadv_mcast_forw_push()
>   to revert the changes to the skb; instead a
>   "unsigned short *tvlv_len" is passsed along in=20
>   batadv_mcast_.*push.*() functions to keep track of
>   how many bytes were pushed
> * moved + verified skb->ip_summed invalidation
> * batadv_mcast_forw_shrink_tracker() xmas tree ordering
> * reword batadv_mcast_forw_push_dest() "Return:" kerneldoc
> * fixed spelling: outter -> outer


Didn't perform any actual review. But here are the buildbot complaints. The=
=20
compiler.h is missing since patch 2 (for the "likely()").

Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

ecsv/multicast: headers
=2D----------------------

    diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast=
_forw.c
    index a90e9057..96ec3f06 100644
    --- a/net/batman-adv/multicast_forw.c
    +++ b/net/batman-adv/multicast_forw.c
    @@ -10,6 +10,7 @@
     #include <linux/bug.h>
     #include <linux/build_bug.h>
     #include <linux/byteorder/generic.h>
    +#include <linux/compiler.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>

ecsv/multicast: kerneldoc ./net/batman-adv/multicast_forw.c
=2D----------------------------------------------------------

    ./net/batman-adv/multicast_forw.c:433: warning: Function parameter or m=
ember 'num_dests_pushed' not described in 'batadv_mcast_forw_push_adjust_pa=
dding'

ecsv/multicast: sparse linux-5.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.SpMnhX4MAz/net/batman-adv/multicast_forw=
=2Ec:783:7: warning: symbol 'batadv_mcast_forw_shrink_align_offset' was not=
 declared. Should it be static?

ecsv/multicast: unused_symbols linux-5.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRA=
CING=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_mcast_forw_shrink_align_offset

Kind regards,
	Sven

--nextPart3678145.iIbC2pHGDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmS3q0QACgkQXYcKB8Em
e0Y+Hg//XQSMmuwxVODGcPEKT6e3j1z1J6Dp8METw9P+j5oJ8pQIRRNJ9ak8feTb
8a05bTbyZrzwOETdJ0OcaY2rd1pcZZGkhjj9XldE63xRoyId3Whvqa4vfAFJ5Kay
Hh1esUKTNp60p+crJd0/agWTd5HRhZ3KcCqPOV0HiWZTfHS5YSRQux00FyF0Qh9z
JjdeMuJ3IC4EL7zEQA9T5WQs4lz/g4+xoG/0QviDSOMovR1lGOar6gJDb3IIXSdz
qLZJA6n6w3Duf6GYI/bshq+o60oZdKApUkiS6xa26l/Yo5jOZINtnfss+rZhhdsa
9NwIS0Mcz9/R7YQ+asnHE+qagEIW9SYna/gDRGmXDlBjghKKZGsoKCmJ7Hyd51FJ
R1Mxe+OZ6EWmTNCFjwRLaoBWb9XODBpWQ/A8mDlFzp6kbS6zbt1nJD5z2gxvn9Rk
XGerafeXRko1Rnla2+vIYhvsGAUJsHsl+uYOOhPwhcDw0iL5vE9B+zYm+hFg0rY+
pzAhnhqyjIojfGQH/KgiIxb5oM8PDqxLxpeylN/Bosajqa7e3vJH40DS1vV1UELM
mIXf87wR/M+Sb9h0wn2FamAbpWZsfYSS75e66vXGi7V3W5YGU1M4Z9Qjx9asncj+
d1fA2LyfIL6ytq7wzRM863i6uiVQkjRhlIcO8wrA7szfftV88nU=
=BLwU
-----END PGP SIGNATURE-----

--nextPart3678145.iIbC2pHGDl--



