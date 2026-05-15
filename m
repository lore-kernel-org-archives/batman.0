Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D0CD4851
	for <batman-adv@archiver.kernel.org>; Fri, 15 May 2026 08:35:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 70B1B852C7
	for <batman-adv@archiver.kernel.org>; Fri, 15 May 2026 10:35:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778834131;
 b=bar+w2xGAje/up8L4sX0/31mnxJzAZV+pjfEJLuMjsEyurBJtKcN0K6f3WKWVBXHx1+vE
 Yspz7+HgLX/13osB51HRSVeq3PNLohdRqQ2lc4W7OIIHdCEaHd3+Fz3d2J1yEfMRAmF49hA
 /M01purtTYV57DbkfqK55xtSku1dCdA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778834131; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tI7XohlZO2m/m7VJKIWcb2nCDjHvtnmEIz0HbNJAZOU=;
 b=OSwOaRq6bxDuj4rJjd/Vy0AkImYKbRrouQAIFoG2Bkr1qoqnxfecO4AC9QGDzeqzoHmuc
 WyPU/vJYc6q7Y9YukzKnW94dGuSBJaC2aQt5olbf+FyzAwEjwW+Fxuc1x84zIpHrsk+tHBa
 OrcX/bN3y2z5qj+SuFjBLe7r6e2W74M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E0F2E80362
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 10:35:09 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778834109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tI7XohlZO2m/m7VJKIWcb2nCDjHvtnmEIz0HbNJAZOU=;
	b=e3YWGX0px/qRkKkLzNNwAllVR1PUX+jk2yFb+3T5HjrZsu0u1Xjc28g5Dx8YNgpS7LUPx0
	qImCVxIZ9iYEPNc7cfOtNJ9af8Mk92ZNVSDm9oQX0A92A5mh+/6wo1i7nvNHQmnJEDb7Sy
	iZmd/g29eLypCqk2mejEZbO87t4kYt4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=dMmpXBTD;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778834109;
	b=HiingaU0kNnRLuTS/vLFXcRrnnETo/7L7pWBPG9J515MD+T0uJ4YppHJ8jVjIho9JfC4mR
	TjyHmTMYoUFyXputzK1rnzQRrEk42tzUMB3FKd6wsH/XRG612nmHItFw0pH6pu7Y3gpX7q
	Q3L+80qUmuPREUnKNhLFiJHMQKc3hgs=
Received: by dvalin.narfation.org (Postfix) id 6771520C4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778834109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tI7XohlZO2m/m7VJKIWcb2nCDjHvtnmEIz0HbNJAZOU=;
	b=dMmpXBTDL3viETl+UHapSAsitgF8+WYFmbLQwnsoCfPFtyF+wA3g2agybLCrkwz2f0a4my
	yPjBQf/7QnaQd80gGUraWNOF+b+E0PoruykVT2lpJy+M6u1soOCrKjfLuRWXN6o7UX3eXO
	2mHRaBD1JjGF7x5imWDdzDZqkC2FEsc=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv] batman-adv: drop batman-adv specific version
 for
 in-tree module
Date: Fri, 15 May 2026 10:35:06 +0200
Message-ID: <6294938.lOV4Wx5bFT@sven-desktop>
In-Reply-To: 
 <20260515-no-upstream-version-bumps-v1-1-6aa349f8e949@narfation.org>
References: 
 <20260515-no-upstream-version-bumps-v1-1-6aa349f8e949@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5128383.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 5WRJOABTZI7ENE7IOUSXA6BPTCXMB6IF
X-Message-ID-Hash: 5WRJOABTZI7ENE7IOUSXA6BPTCXMB6IF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5WRJOABTZI7ENE7IOUSXA6BPTCXMB6IF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5128383.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Fri, 15 May 2026 10:35:06 +0200
Message-ID: <6294938.lOV4Wx5bFT@sven-desktop>
MIME-Version: 1.0

On Friday, 15 May 2026 10:00:00 CEST Sven Eckelmann wrote:
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 2baf8e2c..5d27175a 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -696,6 +696,5 @@ MODULE_LICENSE("GPL");
>  
>  MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
> -MODULE_VERSION(BATADV_SOURCE_VERSION);
>  MODULE_ALIAS_RTNL_LINK("batadv");
>  MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);

I was under the impression that I've removed the check for this version file 
in batctl a while ago - apparently, I haven't. We must therefore keep this 
"MODULE_VERSION" for a while in the in-tree batman-adv. I will do this now...

I will therefore drop this specific part of the patch. It just simplifies the 
patch and will focus only on the version bump.

Regards,
	Sven
--nextPart5128383.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagbaugAKCRBND3cr0xT1
y/LnAP9MMuoKE32BCzkgDjf2X2mJxqoa711wgeLgjd2mu8xr9AD+Kc9AghGP5NU+
ImKuqYH/hUqIMvZnD1u7Iz4JA3PS2Qw=
=MhVm
-----END PGP SIGNATURE-----

--nextPart5128383.31r3eYUQgx--



