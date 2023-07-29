Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4312C001E0
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jul 2023 11:11:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3436A81FC7
	for <batman-adv@archiver.kernel.org>; Sat, 29 Jul 2023 13:11:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690629108;
 b=P3BdyWmblmq8JNW1/7fVc/yI790mLEg2+uS4mqcVx0PVf6u2fog/KA7lHTnMJ3m2gLw/y
 MqgFrHjRXeC/yDP4Z27gJ6AOZyYA9GCbuMwsLQsmbDKCWudptRjpFWwRPvnnjA9AvnBaPXq
 r4nlYbdf9p/f0qwnkGEWw4Wwuw1Bj6U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690629108; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sVS5FzF7620NVxN/iOomStXFHZlX2zljWJq04J2Pam8=;
 b=0HOJlctWdfClCwpTG5jWXhh3YwFLl8HIvVTQ2WL4GMektW+zfNU6wReilOYD537B2garW
 5EjC55qluQmVCIxy2t7i+m5SecNPYDbKpf+OUH31wq4faIwqZL8gaSCWU2k7phWx+UgKyi6
 SwJ0ikxpQ0xwdck2FcUjtYnGPPSUV1I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8F23480964
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Jul 2023 13:11:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690629089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sVS5FzF7620NVxN/iOomStXFHZlX2zljWJq04J2Pam8=;
	b=c46FNe1MJkzyIa8sEFfAJHwlIbCySzJLng/1dRKw6yx2HoWTu14dCSnTyxyMl3PHmzPQi+
	pGvuC/sZgwmQe8yDWvSPvRscX4rgSpCUE98eG3ENEU1PY+Kk738N/pVyZ8H8LnYOWbIFa2
	fOqefLQxHTd1kEyxzhb2nsVBIrn9Sg4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=dCCcZbpk;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690629089; a=rsa-sha256;
	cv=none;
	b=Kf61LuI8RCEtf7sVnGvCTHHhSBKyQuXGlA92RN2ZQ1OJkpKJkr4gX8TJL8U1CfTg5YkeLe
	opDGYCpeR6nE7K2WXAYJRxGS7swSDfiCgeR3EOW11eXgFmnVtLrQM5rXyndSXbmkuZJZFC
	k6PD+BFR6L4N3dDJmMA5xOz5boeo+a4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690629087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVS5FzF7620NVxN/iOomStXFHZlX2zljWJq04J2Pam8=;
	b=dCCcZbpk9oNbPCk9QsGegsSOIUvEqniFS8ZfXkLcVh6Jy902VE0tLHrhiZhZrG14k8M3RH
	lkdfjCVyfCnuWGKEKdjO/ikDkuR/ms1fXOGc6huoqNhzllK2nDWH9av4JoeM3OMFshWiy7
	MwELzJmNJs/7Jl8gRQs2zeURxq1cZHo=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v6 3/3] batman-adv: mcast: shrink tracker packet after scrubbing
Date: Sat, 29 Jul 2023 13:11:22 +0200
Message-ID: <3779998.MHq7AAxBmi@sven-l14>
In-Reply-To: <20230720043556.12163-4-linus.luessing@c0d3.blue>
References: 
 <20230720043556.12163-1-linus.luessing@c0d3.blue>
 <20230720043556.12163-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1990389.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: JO5A6K4XVPAEHL6FNWOYXLLRPSFXDNCH
X-Message-ID-Hash: JO5A6K4XVPAEHL6FNWOYXLLRPSFXDNCH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JO5A6K4XVPAEHL6FNWOYXLLRPSFXDNCH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1990389.taCxCBeP46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 29 Jul 2023 13:11:22 +0200
Message-ID: <3779998.MHq7AAxBmi@sven-l14>
In-Reply-To: <20230720043556.12163-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Thursday, 20 July 2023 06:35:55 CEST Linus L=FCssing wrote:
> Remove all zero MAC address entries (00:00:00:00:00:00) from a multicast
> packet's tracker TVLV before transmitting it and update all headers
> accordingly. This way, instead of keeping the multicast packet at a
> constant size throughout its journey through the mesh, it will become
> more lightweight, smaller with every interested receiver on the way and
> on each splitting intersection. Which can save some valuable bandwidth.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast_forw.c | 195 ++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart1990389.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTE89oACgkQXYcKB8Em
e0aM0w//ZCgnjuPi7NJb88OWDxfGbNICPhkO1/MXLLpr7z+7IZT77KE9bZnrnDt1
73MkwSDKxEnb58z2ABXGf4majEQtQNJhIP9Mfrac2oGDzRyPClHrcIMOqCxmMUaF
wkNXW8rGyKtXMYEqhvZNqV2phf5kpwHAv20w83kD3Ef/KqOIsOJ80F8vPMf/9Qsj
ncu1RnyUjf+isSiltd7cBcDZjEGbmsA8UGwIDZBUtN97fPNhlyRJO/JIwNX8ZAhc
Iklx1FGolA7PNPoDqEY9WkLug8PNr/0MdadNXgoOxe7ZQcj0Z0F29c1qWpa43yPn
l7vZFoFXAWNmCJRE/liW+bEQSQmqgvZdE2yVVLfByylosuhIowJaJ4pj+yjOrqIi
2pXLYLclKmp18OCs9k50P6NzdsYp72F/IQlb/kjpi9R02iK+JyQYNX0Pcb4tCYPY
hmHJXAHcqK0pxLVdGF4STcuke1zBav/GRizpBsNjkK/l28808sdVOfhMc9phYUtd
ZJgt9tjUZAhwLOss6L/CNSH+alIv8m7CSzvP7jlD+25ugY4x0woiM8zxtyTDiHcl
I1yZ/6BrY5i3bzRMAzSPt3S9WowCok3BDJb9j4DBNWHQjd0shWVkFIeYMVwipM2/
UZ/Hj8owD3hq1pH2D6fKNiM/37QwS3LGKf+OvowWOlLPYhZKrT4=
=Px5h
-----END PGP SIGNATURE-----

--nextPart1990389.taCxCBeP46--



