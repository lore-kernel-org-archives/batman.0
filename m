Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC8FEE14A8
	for <batman@archiver.kernel.org>; Wed,  6 Sep 2023 15:59:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 77B1A830D9
	for <batman@archiver.kernel.org>; Wed,  6 Sep 2023 17:59:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694015941;
 b=ARsWyyPbIwQ3WkgHO++GSNxQXjOWFtrfmHVej2M9KoAyzJD67DmxmFHvUUd5LEDuj5SZs
 zWNFdKp+LpY9pDrnqsvneSMRh/2cha1KTtY2FhyCCHCxJy12z+Gtq91epqNMd/XbEMIXpuF
 KKvDWXAJBNAmy1qX7G3olnWy5vuwpGE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694015941; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JnKrd2uZHvEW8l8AL9kLWvZXNTrPFXEoeNMxDm+NPlk=;
 b=rM/OW4mVhDixBUcoXTEQxsiSpLhh+cZO7Iwl3BaLR7wHbhEvtjxFZbi/G6k9TxdpdG+pb
 4+t+D3Eg1SSKPCjVxeJIhYMflV6wdR7lpGHe8fDzJZ66R2SKiMu+iIIDZqIvrWnOpfkB9eG
 FJni78gfn3dnTYvVOri+raxzf4c2jmk=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 04B1A802B0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 17:58:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694015939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JnKrd2uZHvEW8l8AL9kLWvZXNTrPFXEoeNMxDm+NPlk=;
	b=qkHCXU8EKnUFzz+pbNP5k2De8P4HMY85WmyOnxmgoDLfD/NHShGV00kY5/tROqBFSNHaxY
	RNJ1LCmRDXbpSznEo7Rs9RXz8nGdZEKBvIXg7nlINEfRYErZW1FXxGyzJ4gxkL5dBJqh3k
	tllReD9rVvTd4Uz4/TpOlhFjBTRnrMg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lCCZsBOo;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694015939; a=rsa-sha256;
	cv=none;
	b=Rt5zEtucB0rdt8tDNk0lOsJjTP8ZoWqnFj4dLoBWwdBmyVPTnouaY6Sn7Py/w4EPdzLkJO
	jkXlFDZP/PNyMpSNPHIGJpxH7qCEv+hnT+nIDmZHQrf+ahSUEJbDd9I3EUsMlAaLNQ5+vB
	rEd/eWeN47U7OF4gfFZMJowABB2n/xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1694015938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnKrd2uZHvEW8l8AL9kLWvZXNTrPFXEoeNMxDm+NPlk=;
	b=lCCZsBOo+d5InIik7wDGc4qX71bOcKmv24lP/RDqE01FPCITENWTa6zVMqHC3jcBoTvv5R
	JvbotH+EyixbCHocQtAQ3UytXHnxpDEd4Xkv/RjT29iARZGyW5NqvQNAb2s/WQ626Q4wl7
	iUANAEQIfwug43DQje7Dn5qmkg6OFVo=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: batman 2023.1 fails to compile with implicit func kstrtou64 on debian
 5.10.0
Date: Wed, 06 Sep 2023 17:58:49 +0200
Message-ID: <5945222.6fTUFtlzNn@ripper>
In-Reply-To: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
References: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3095510.yKrmzQ4Hd0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 4XWRLFV2IFZVQACD2ZAIBCKJDCVZE7TU
X-Message-ID-Hash: 4XWRLFV2IFZVQACD2ZAIBCKJDCVZE7TU
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: MK <mailing.m1@kkk-web.de>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4XWRLFV2IFZVQACD2ZAIBCKJDCVZE7TU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3095510.yKrmzQ4Hd0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: MK <mailing.m1@kkk-web.de>
Date: Wed, 06 Sep 2023 17:58:49 +0200
Message-ID: <5945222.6fTUFtlzNn@ripper>
In-Reply-To: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
References: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
MIME-Version: 1.0

On Wednesday, 6 September 2023 17:50:26 CEST MK wrote:
[...]
> batman-adv/gateway_common.c:55:8: error: implicit declaration of=20
> function =E2=80=98kstrtou64=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
>     55 |  ret =3D kstrtou64(buff, 10, &lthroughput);
> cc1: some warnings being treated as errors
>=20
> Tried make CFLAGS=3D"-Wno-error=3Dimplicit-function-declaration" but that=
=20
> doesn't help. Successfully compiled on 5.15.0 (ubuntu LTS).

Please use 2023.2 or get following commit:
https://git.open-mesh.org/batman-adv.git/patch/8924adbdf993cd0521f9d0024b43=
e3b23af5114f

Kind regards,
	Sven
--nextPart3095510.yKrmzQ4Hd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmT4obkACgkQXYcKB8Em
e0Yd/g/+L3o7XsBtrUxzGGYHRkeLiKpUEu3qvO0LzXhzKQ/CIkcOsNbxChp1IDzS
AJ77A+wRxyJpqp6a2WOQErIJohf5a60iNNPIBmh28kiV1dCMqG8WkL1UaGQAzu7e
fvoomGz46TZ3IzZGhq998DtnmCJFdrzRLQ8j8fTa9TagCENa6e5Rm6ejG2Y4Q3vS
Ge1q6PY4RQT66E2yS2NeBCV7Fu9Gfi6lG0tmoACKtBOX4jiGx+iWFF9SUKY8I6kv
MVEMFGeaWIAKL6wAOn+rcx9rt9XumuKj+9pUaKXKoKuYDJaiCBeTpXk2H0gDzWVL
dXupcDRqYyO7UqHK++mzx7eNnm8i08+xPTSLJ3Un7T/1IE8q0TLsjlv9I3AtFOsl
5YzqW5VBOa1wwLP5SxRAHxWbTGHIUuP3DM2H53cBCNRppj2x+2nYUARGcjgn+C5b
OiwKCdPnK4rjYdsQhmP++rbS3W/D/RM935DHRRdHOAT97eXpSWaPdB6HTp9YaoLi
UPOuVKnW8DKCY+hkLrmU7oJ9hDcVb4tePPW68fy1HdOPxalsQmVp7a4lEqpaw74w
MjOB3hOxd3ZahrcXYA0Cvej8nY00z3/pYCtw6Id3WKuoOFNuTMkXjWaaLR/9RTPi
+2mRPQNG/ndF6SovPz9ht2Kt1mtgullinOOffqoKcvPHnV3lubY=
=DNDJ
-----END PGP SIGNATURE-----

--nextPart3095510.yKrmzQ4Hd0--



