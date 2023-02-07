Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142C5C636CD
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 10:58:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2029F846E5
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 11:58:11 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 92AD980578
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Feb 2023 11:57:47 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675767467; a=rsa-sha256;
	cv=none;
	b=whdbcuaaySILlha+Xmix42+Jpnoy0FEl+ndzJcA4dHiTvqJd6WVKCZs2qIXIs9UWeC0+oK
	H5zxrh3Ocz5Ay9KhZbS+9VtWyjhYN3YHtf40/gVcmd2MGDy81YtNMdyHq6jnvbq0IH/dgr
	NwH/GY9mbnoBvMnAAPCMnZ054vLHu0Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Bu1w6I/J";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675767467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=twwWEE4WjjCfg99cZRakSAtV07e2F6CYBPPCSXxSISM=;
	b=SC8ghepb+k/ofvcIY1siqTEuRN76IaOpLbQRJAmz0xQHZJh1B92Th+BsfzDLx681znC4ix
	IGuCA9k/qXtqR/Eq2HvBf1Zs7DYL1VbUWOgvhrDXHhPXGUqNNP6rX+5pb3qKrJ5/oTXkl+
	QiSXDUGiAv/1JyxoHgiXe5n0ROz3yWE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1675767467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twwWEE4WjjCfg99cZRakSAtV07e2F6CYBPPCSXxSISM=;
	b=Bu1w6I/JBYcenWPVw/KaX7Eyd3Q1a6ptM29w8VCgG6DffX3yuS4W+wLfbF9olSgF1/HOaD
	KD1+bQIIxv5klElwyf1LR7SY9Ydiwd8PpIbJz3nt8huylL99SFiNnME2f4R+tTWxC+ZmV7
	F7MOL+4Uoj078gv2+OkzUdneHFuDb9w=
From: Sven Eckelmann <sven@narfation.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Date: Tue, 07 Feb 2023 11:57:41 +0100
Message-ID: <3940036.VdNmn5OnKV@ripper>
In-Reply-To: <Y+Iq8dv0QZGebBFU@unreal>
References: 
 <20230127102133.700173-1-sw@simonwunderlich.de> <4503106.V25eIC5XRa@ripper>
 <Y+Iq8dv0QZGebBFU@unreal>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3012276.PIDvDuAF1L";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: GFCBZKVTJPOS4E5CCYQVL3XWT27RKSKR
X-Message-ID-Hash: GFCBZKVTJPOS4E5CCYQVL3XWT27RKSKR
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GFCBZKVTJPOS4E5CCYQVL3XWT27RKSKR/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3012276.PIDvDuAF1L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Date: Tue, 07 Feb 2023 11:57:41 +0100
Message-ID: <3940036.VdNmn5OnKV@ripper>
In-Reply-To: <Y+Iq8dv0QZGebBFU@unreal>
MIME-Version: 1.0

On Tuesday, 7 February 2023 11:41:53 CET Leon Romanovsky wrote:
> Once you stop to update version, you will push users to look on the real
> version (kernel) which really matters.

I would have understood if you say "let us use a magic value like 'in-tree' or 
'linux'" but setting it to an old (existing) version number - I don't want to 
live with the headaches it creates. Because this is what users often don't 
(want) to understand: if it looks like a valid version number, why isn't it 
the valid version number? So I have to do a lot of pushing - without any 
rewards because it is necessary to push every new "user".

Kind regards,
	Sven
--nextPart3012276.PIDvDuAF1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPiLqUACgkQXYcKB8Em
e0YKwxAAwewFwrNpytsfpzAIxdnmF3AgpNErn1Sv+GI0o2V41uBL0dFYi1WJu0xo
xxAqYNTujRT/+c62Rh2M64ex4pWj8rdPSk4qzHW/QYc3oxUkywger8LV6An8T5eV
LOUanSE3Jho3N2sZSxWBDrsX4d7qsDGxEm7V7LI9JTZj/OOOQhKnP4YFG2EAdXKv
a5mKp+knqu5hxjvFQHSTKRKim0rzIgo0vnWl/S2MMn9jZrwJ7Or5XBiQsUev7iTC
aWe+xoRmQRFakOBv/iedMgs2CaIUqE8u89nPm+MtaiLsyTyNArfpPU7NSsXA8sf/
DP/JtxcCvV1KYEw3709iZs89bESjAqpjk8z7wRzbYpC7yjxDoNEHZTh9bF+WKDzp
IYjsJXZ5//BcpuDDtNqnWJ81WmOue9ey+Mo1KBtW2h+1Mx8A+7z1qt1vYAGYtxgn
rnPZfZ5peIfmvt+isJCU+1W5acewaLY3UaW6D9VX4MM+HUbvk4RClUx2lcfvGITp
XooEo1Z0YOMr6GcbtYdz2Ze0uFweTlY/5lfI/C9iYY3W5Cf1B4l1xI9CdM8j7cBB
GP/smY5uARwGbGhUpdhSF+ZylvEVJLDxUh0YVTHrYjpfYMZgKOyOa0AYxy4rU1hA
ZHr8TAhqQLN83Q7hXBjHsVKCJ30W9ggNUojlDHIkorqCzQVwJ2g=
=UFiJ
-----END PGP SIGNATURE-----

--nextPart3012276.PIDvDuAF1L--


