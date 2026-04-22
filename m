Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C674F5A8DE
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 11:38:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9945B854B5
	for <batman@archiver.kernel.org>; Wed, 22 Apr 2026 13:38:57 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1776857937;
 b=X2wj1Y5ZiFcj+XtCL9uZF0xg6DQxwZXiyUQuaInFptvo2f42u0g1+WrYJrFPU+p9tGiIC
 tlhqM7ug6sjlFmnGV7RdgyFX2MOfy+JBxBJ0OP/PBmY9Pm8gPYlq+n8TllDmCwIZxBPKc4S
 1X4Fw9CLOJst5PRYu9NIlhJMkwHr1Ks=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1776857937; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MVzYDVDQURlW/ccfsHT8VeGBwMbip5akYta9Qis/mTg=;
 b=j4xEANizG+/7oohRK0VuVZMj9PSyCz5DxpqlaCNv/qjFVMeIE2PJJmmoN8552R66sh4P5
 +c7Z7ryAfQNVB79vwvXCxzTPssS2gAB34sxU11HoIsOShw/MnI7JX+vCwH0uPp2Ku4oZnQk
 p6upcpLNNxaFW8RNdfMh7Nv0N2DgR0o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 31E6184494
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Apr 2026 13:38:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1776857905;
	b=xamQGALW5P2DZ2DnSOrWTuq10VNskFm6ljDHGj8PIGyWOtkdO0cupxCcOdhCQhVtRyRGpy
	WUJQIW+/7x/RdyYbl1Ku5CQLNxu+FOv9V7/GXM32KmrBZb7D/5AOfc2YwCFnj1iyw5YRUj
	2nJab8cPAtMp6jEZ7mMUOaIKcqlBM0g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mnwueyTj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1776857905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MVzYDVDQURlW/ccfsHT8VeGBwMbip5akYta9Qis/mTg=;
	b=r0EUuke5huQ84Ct6N65R5gKOZN4VAQ/q2VLptaVlXOpsTwfhPKyUNpjf8YRo4YEOObwuv7
	pdnTobMdxZ7rw/S+ftKdZtCmdVoOVG7iIq3qyi0cUUD3t02ALwLLU6Kpzzhjko4gjUmgjo
	x51yx909OhHWV5v3l/JzH4pO+SMnERM=
Received: by dvalin.narfation.org (Postfix) id 928951FDD3;
	Wed, 22 Apr 2026 11:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1776857903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MVzYDVDQURlW/ccfsHT8VeGBwMbip5akYta9Qis/mTg=;
	b=mnwueyTj9cn+XQUzRJeuLZVaDaLuLbFzjNI8oJcYXMd5fwi1mbYqgPjTRKoX8QaZ30Vnx9
	8vuuLCfE9zsxHx70sOpVHLIqyKmRxzel6Cyp/hjQ7H6BHi7Gr8cWtDNeDn32UGqoojgDOp
	TscJqcmThwgUzltp5AO7rd5CA99QItE=
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 Lyes Bourennani <lbourennani@fuzzinglabs.com>
Cc: apinson@fuzzinglabs.com, security@kernel.org, syzkaller@googlegroups.com,
 b.a.t.m.a.n@lists.open-mesh.org,
 Lyes Bourennani <lbourennani@fuzzinglabs.com>
Subject: Re: [PATCH] batman-adv: fix integer overflow on buff_pos
Date: Wed, 22 Apr 2026 13:38:12 +0200
Message-ID: <4755009.cEBGB3zze1@ripper>
In-Reply-To: <20260421222022.21231-1-lbourennani@fuzzinglabs.com>
References: <20260421222022.21231-1-lbourennani@fuzzinglabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5169337.0VBMTVartN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: LO62WNRTOMUCNV2WMM7XGDZ2BKLE3PZZ
X-Message-ID-Hash: LO62WNRTOMUCNV2WMM7XGDZ2BKLE3PZZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LO62WNRTOMUCNV2WMM7XGDZ2BKLE3PZZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5169337.0VBMTVartN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: fix integer overflow on buff_pos
Date: Wed, 22 Apr 2026 13:38:12 +0200
Message-ID: <4755009.cEBGB3zze1@ripper>
In-Reply-To: <20260421222022.21231-1-lbourennani@fuzzinglabs.com>
References: <20260421222022.21231-1-lbourennani@fuzzinglabs.com>
MIME-Version: 1.0

On Wednesday, 22 April 2026 00:20:22 CEST Lyes Bourennani wrote:
> Fixing an integer overflow present in batadv_iv_ogm_send_to_if.
> The size check is done using the int type in batadv_iv_ogm_aggr_packet wh=
ereas the buff_pos variable uses the s16 type.
> This could lead to an out-of-bound read.
>=20
> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
>=20
> Signed-off-by: Lyes Bourennani <lbourennani@fuzzinglabs.com>
> Signed-off-by: Alexis Pinson <apinson@fuzzinglabs.com>
> ---

Applied after fixing style issues in the commit message:

    $ b4 mbox 20260421222022.21231-1-lbourennani@fuzzinglabs.com
    $ ./scripts/checkpatch.pl --strict 20260421222022.21231-1-lbourennani@f=
uzzinglabs.com.mbx=20
    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit =
description?)
    #147:=20
    The size check is done using the int type in batadv_iv_ogm_aggr_packet =
whereas the buff_pos variable uses the s16 type.
   =20
    total: 0 errors, 1 warnings, 0 checks, 8 lines checked
   =20
    NOTE: For some of the reported defects, checkpatch may be able to
          mechanically convert to the typical style using --fix or --fix-in=
place.
   =20
    20260421222022.21231-1-lbourennani@fuzzinglabs.com.mbx has style proble=
ms, please review.
   =20
    NOTE: If any of the errors are false positives, please report
          them to the maintainer, see CHECKPATCH in MAINTAINERS

Overall, it is unclear to me how Alexis Pinson <apinson@fuzzinglabs.com> is=
=20
part of the chain. Lyes Bourennani is the author and Lyes Bourennani submit=
ted=20
the patch. See the documentation [1]:

> Any further SoBs (Signed-off-by:=E2=80=99s) following the author=E2=80=99=
s SoB are from=20
> people handling and transporting the patch, but were not involved in its=
=20
> development. SoB chains should reflect the real route a patch took as it =
was=20
> propagated to the maintainers and ultimately to Linus, with the first SoB=
=20
> entry signalling primary authorship of a single author.


If you want to say that Alexis Pinson also developed this, you would usuall=
y=20
say "Co-developed-by: ..." followed by the Signed-off-by [1] from the same=
=20
person. And only then the Signed-off-by of the submitting Co-author. You=20
might better understand it when looking at the examples.

[1/1] batman-adv: fix integer overflow on buff_pos
      https://git.open-mesh.org/linux-merge.git/commit/?h=3Dbatadv/net&id=
=3Def6f94dbf35185c19d37bdb9cdd96bf0a6e985e4


[1] https://docs.kernel.org/process/submitting-patches.html#developer-s-cer=
tificate-of-origin-1-1
[2] https://docs.kernel.org/process/submitting-patches.html#when-to-use-ack=
ed-by-cc-and-co-developed-by

Best regards,
=2D--
Sven
--nextPart5169337.0VBMTVartN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaeizJAAKCRBND3cr0xT1
y/dIAP0YUO6t7ItHpmuAZEukY4neS1l6Bw6C2ZiJWc+ChJVLWQEAxkz7bPmvg3qZ
X88oEtc6K/5cr2sBsACRfXVGc4rUxAw=
=BeMY
-----END PGP SIGNATURE-----

--nextPart5169337.0VBMTVartN--



