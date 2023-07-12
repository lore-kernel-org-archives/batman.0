Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D41EB64DA
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jul 2023 11:55:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB43D81D2F
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jul 2023 13:55:36 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689162936;
 b=TBtIPu3TQN/XHX0f/J60p7o9j6qyHuP1AL4ORpX6ljE+DdsNUDbRwPh78TgWywrjBpZxJ
 M4MOwWFwzOvLwNLI396g8fhIqpepT/R/KhbWJiuGQKK59WMZKmzvoN0vYg6Ksyx9EcPhlMe
 cngvd1LaSEpDzYFtoYuMl95yr4yfUhk=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689162936; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7V+J/yUSCnkrFG4+0oPHlrapPTOKo2P+72GkP6SJerU=;
 b=gcUdRJJFTcq+dA40EMYjlnbhajncUlGWpzfbFtDYCzFBtOnUkRjjqg1JffjjuPozc/wDv
 6g4wkNuzEniGsCpzEoAdKhnQmhX9zHmd3CnjpYOWwIkTHyyK2mW1sNDbGLIpLN9KZNUSllF
 v+wmE10kRH5R5aI5HonKhmdR7rDxN8s=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C02428018F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jul 2023 13:55:23 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689162924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7V+J/yUSCnkrFG4+0oPHlrapPTOKo2P+72GkP6SJerU=;
	b=UG8oMlNuw+zBK/Owr+mHMm0yfVrJ2FNMhfTG+fwrJTcy6vjKVmYOJQGNtWn6fhmgMA6iLh
	fPVk3/rIlY07kzXWdId6455l1bD1b3aY49RJLPW2+Hho8GXqxduByut1XL1gthLskTWoYm
	XFLNXA89uXrDxRXIcvwi7o9BprjLh78=
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1689162924; a=rsa-sha256;
	cv=pass;
	b=Bzaz01XjNHu/itpQ1Ag5OnUNHrZ43lU3Q+LviOrS0N/LNWtO4YobsJYk7dFhoFfdlnifUZ
	Cvznhyo+KY6pXTglOI9m8hJgHCPZFlqW4YFxXIg7ZWIpcONfnThd6hcEuD7ttApcKd4nqM
	dBCE1TpmllpZS5XBcqk2XCasNyzIafU=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=j9vNOP+y;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from prime.localnet
 (p200300C5970aE0d8a773BCC64F7760B0.dip0.t-ipconnect.de
 [IPv6:2003:c5:970a:e0d8:a773:bcc6:4f77:60b0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 16F9FFB581;
	Wed, 12 Jul 2023 13:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1689162923;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+J/yUSCnkrFG4+0oPHlrapPTOKo2P+72GkP6SJerU=;
	b=j9vNOP+yD4OhGcyxqVyXzmWeOUwqFWPZnFF6AL4zbzvcR3JWr/N37IxqJ1KSJxD4G/+b71
	9Kt2joyysiqHMxAWrSAlz7ckdyiLWvDgHA4yh3TOk2rFowy8Oo7OF+Mu6XtGZQzs39Imgz
	Bj3bk+r3mueZhCJr6Yho9DrpbLvyH3lg9xlFGbEQOyYo4oGuEJqzKQqGlrWUBFmF0zuTLV
	xXdikLvr3QropO0Hy3Jo159lzaiOoSBOTyJRWrkUFcDWSLtKp9GIF86I+EmMmmSM6UxmHL
	b/KUY76jcssxAL8yXhPUt9xIhNkEUKQh+cvBA0QU1M2SARfsDo0xpeVMvECHXQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Using BATMAN over ppp interfaces.
Date: Wed, 12 Jul 2023 13:55:22 +0200
Message-ID: <10972843.BaYr0rKQ5T@prime>
In-Reply-To: <168913619024.1040.2149557919065248797@diktynna.open-mesh.org>
References: <168913619024.1040.2149557919065248797@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2681214.uZKlY2gecq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1689162923;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+J/yUSCnkrFG4+0oPHlrapPTOKo2P+72GkP6SJerU=;
	b=NvXVqIzSHnLGqEvw3AjQQxqu9xoJYKWGsELnAemOU4Tkj2s0EcKaR2/yz9PkJ2TuhV694j
	R3uCKWb+wRaxa3HmrJN6mSJ/oaG7DJD0e0bdWB68nvyApBHfhS41s9L5FlQIPN/898yWeo
	IqsShzPGd3nxJtPAN6z1Y1tnq02Z8ftKeW3VD9Y2t35F8WFD9j3YsuKnxJVTjr+t/zbBZu
	vsXwuQ0OLUarDsEOvbEJWbNiw1nB64gjgWNEJrkt20Ajl8if0ce6lNEOTVJJ2/V+OrYDgT
	aiPhRlGvDhAYuFIAzgurJWtijLvrZ1qKMO40QPLPlc2mRZ8rBvHGpn/VbhMfsA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1689162923; a=rsa-sha256;
	cv=none;
	b=CMnXlJ8gAblRYEYBJqlARdDPougXqCaAUDeW1l3VwvGGGQZl3aB52KsQFH+srwS/qVICai2fLsN/eTk7+RzJ9XCt88FA2TxP4Mi1X13rUoNEaeHUbMMeGGnqr4aABJ99o5y340nbfgl4fdiKSYZ+y51mcNcpq1YB5CiWDd541KvlF2qenNf0iARJxe76kkdCWdUjI8Lw33sm4YgH34kWDwqx0KKGDDjipfnEFYvt9qdpYyWqNze31R4zKp5jPJPRMaObh07pSxOveDVGRhFtfzq9b2r5xJvwv2GejFisbenoKU8sm3l6hel4voQNWIZaN5DTCTFvGoxpI7QfWwK6Wg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: TKXGRRXB723ZX3EDRYWVWB2VUVUXCN25
X-Message-ID-Hash: TKXGRRXB723ZX3EDRYWVWB2VUVUXCN25
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: petermilani80@gmail.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TKXGRRXB723ZX3EDRYWVWB2VUVUXCN25/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2681214.uZKlY2gecq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: petermilani80@gmail.com
Subject: Re: Using BATMAN over ppp interfaces.
Date: Wed, 12 Jul 2023 13:55:22 +0200
Message-ID: <10972843.BaYr0rKQ5T@prime>
MIME-Version: 1.0

On Wednesday, July 12, 2023 6:29:50 AM CEST petermilani80@gmail.com wrote:
> Hi All,
> 
> I've just started using batman and was trying to see if I could get it to
> work over a serial radio link such as the simple serial devices commonly
> used in cheap drone telemetry. The goal here is to enable low bandwidth but
> adhoc ip networking.
> 
> I had set up a pair of radios to connect using pppd and I was wondering if I
> could utilise batman to try and create a mesh. An example of setting up the
> serial ports as ppp interfaces:
> 
> $ sudo pppd /dev/ttyUSB0 57600 noauth nodetach 10.42.5.5:
> 
> That works fine but applying batman to that interface was unsuccessful. I
> think that was due to limitations in the ppp and interfaces created by
> pppd: e.g.
> 
> $ sudo batctl if add ppp0
> Error - failed to add interface ppp0: Invalid argument
> 
> The interface ppp0 was specified as POINTTOPOINT e.g.
> 
> $ ip link
> $  ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> state UNKNOWN mode DEFAULT group default qlen 3
> 
> I'm not an expert in this so don't have full visibility of all the tools
> available.  I was wondering if there were better ways to set this up,
> possibly not using pppd? Any guidance would be appreciated.
> 
> cheers
> Peter

Hi Peter,

batman-adv requires an Ethernet compatible interface (Layer 2) to operate. PPP 
interfaces are Layer 3 interfaces (IP Layer), so that will not work. You could 
make a L2 tunnel over your PPP interface such as l2tp or vxlan and use that. 
Or perhaps there is a different/better way to enable an Ethernet Link over your 
drone radio directly ....

Cheers,
        Simon
--nextPart2681214.uZKlY2gecq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmSulKoACgkQoSvjmEKS
nqGD4A//V4AZ5mWccRw+nfDm0Z9yBCoRp27g3gk6HVD7miZyWc1rd9gqVPGJ/T9R
IzFk/Zm4UkoSixmqvw4wCxfyzdme0q9c4vIsIfY3FY8MvoL0oyG2h6xzIAPZHQ26
TEn5P4sWj6rR9BzB4UlS18BhwWzhY90k4O2JXpjVXbicpYvE+sidWCSeVAPXXyV6
ziu8hQRfyaHGf831w3wM8Youz0wgizXoWl+cHJqx/3zsPwTPJdYkgYaiNV8ZJXc7
ZUVUquRnrDGKKC5XCLri2GlBmH3ctHm8GsxIsZEUEAyRba/Avy72RoBq5ZCG/S2O
tJw/YbD8g2EdabCzar63hBjS+wmLyrxJ3wS5JU10maTa33oRfn+oFMBUuIPelQ8W
2vRmHl/UQb/r7lxJ1aXDFCxFUtJfg6loDlBcEA9BAyB0YfdTnUiTB591pFIBNea0
va2hFHjtpmYvHy4C886SRPnlIBExLkhzrHbt2VT7N0O5nOu3VtglzUAjEndrLrjU
i8m23B78Qo4KaAlYu1vfMBtU9ffyvNqotfDszfYw5PCNl+vxV3hnV5YXeUah3kDr
PEaWiDYJHG1h/lc8/1r5GifznUVNMEPnvVaw32IliVyhPlIuU+1AhKCxfGD+zMw/
I0RyH5avhcQoMXBsve98PgMxaT8ldqbPOmGHaWurxwD3JOxodhI=
=z4N/
-----END PGP SIGNATURE-----

--nextPart2681214.uZKlY2gecq--



