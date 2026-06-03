Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2B2CD6E4A
	for <batman@archiver.kernel.org>; Wed,  3 Jun 2026 04:44:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 98CA28497E
	for <batman@archiver.kernel.org>; Wed, 03 Jun 2026 06:44:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780461866;
 b=2r/UgSgHGRr+aHILPIDcvRbxOY2+RVVryldo6nWVvZvEf7TzXuo2sV0oQwJMkLquM++P6
 OTfYTOT8XcuMUUhXTby7h1Oco0QFXJaLfi6nX8aAvpqz4gUdIXyCAauEbyQNUZOmtgbD8RW
 AvHm/WgLGduKQUMR/xmK0OVJyR9Q54E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780461866; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JD0IzI8sLxEETIOY5GidPb6bANGZ3n6dvh0j7MQE+k0=;
 b=dvRlzSZuPUrvfseIezbEyHTOk1fQVhWzNs4XkgUZ1yftbisjE1xcliWCqGIy+MRuvbsI5
 F0TMYylMV+rF/0AfrwQWHzsy/TzXnA1xXLpuMDu3ToAu0t/Jx/Yd3TvBRXsrsrjrBuCnJbo
 V+8pfoei4k2X4ruebR5NrlJgknecw4Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7F665810DB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:44:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780461849;
	b=E+aUsyqvX4OsWJOekjq+B+Awt3De3UkAQZ96nf7vbrWekPvUGlq/cSryAUVFbAGKHnyzbv
	4V7rIOa+15KFj94kdJ6SgUVMmhxYvrGFpY+auQSMmzO2cDPot+rz+44SAbPvYEhHJFB9YB
	63BR8CkPlEttrWOClI0+yrDdUa85cr8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=yVA2rvNv;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780461849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JD0IzI8sLxEETIOY5GidPb6bANGZ3n6dvh0j7MQE+k0=;
	b=pv3plsOhWid72zXIERLELwegerJd82qJJptpWXX3meYg/eZRxoMYDZ2dMxDEw9kVJ2pkMs
	63AxSQt28pt9kIORPWuYYkfHjKjRPsgs3/CdipSH7D9O6Nz7dG1KKnEs6S3zcgHwfrBNAx
	/4BTTrKJLVkUPZ4HVOchS5NaSDJEYyM=
Received: by dvalin.narfation.org (Postfix) id 2BC0F1FD9C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 04:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780461849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JD0IzI8sLxEETIOY5GidPb6bANGZ3n6dvh0j7MQE+k0=;
	b=yVA2rvNvMWNmZB6EK9Whzul00S3aJXXlqsQCuyikPwoEzr323Yy//5efjKzqQ46WBdmWYn
	tUT1HMOFndjuk+vZD6zbzUFRWWKCiK5VRliYzetT60DlB8ugKXjPaGQVUe707Rwhgx+0qh
	gL9FlcNO2P5p6I9EfaMi9tRNJXdjgqI=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv v2 1/5] batman-adv: tt: directly retrieve wifi
 flags of
 net_device
Date: Wed, 03 Jun 2026 06:44:07 +0200
Message-ID: <2272515.irdbgypaU6@sven-desktop>
In-Reply-To: <20260603-drop-hardif-list-v2-1-5f79821ca333@narfation.org>
References: <20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org>
 <20260603-drop-hardif-list-v2-1-5f79821ca333@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14029559.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: GP66B6ZGSJJCRS4RRZJDSGJ7UJ746INE
X-Message-ID-Hash: GP66B6ZGSJJCRS4RRZJDSGJ7UJ746INE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GP66B6ZGSJJCRS4RRZJDSGJ7UJ746INE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart14029559.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 03 Jun 2026 06:44:07 +0200
Message-ID: <2272515.irdbgypaU6@sven-desktop>
MIME-Version: 1.0

On Wednesday, 3 June 2026 06:29:00 CEST Sven Eckelmann wrote:
> +       u32 wifi_flags;

u32 wifi_flags = 0;
--nextPart14029559.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCah+xFwAKCRBND3cr0xT1
yxQLAP0SY9Lxrg8j48QEzWQmrWSlEU3+Id1eIXFaPLs813a0lAD/em7adL6McxCC
8ynIIMUcGxRPXk3Zhrh0cmXlwoHBWg0=
=dp3D
-----END PGP SIGNATURE-----

--nextPart14029559.uLZWGnKmhe--



