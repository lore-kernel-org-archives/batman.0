Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1839CC54EAA
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 09:27:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 11FE382EFF
	for <batman-adv@archiver.kernel.org>; Fri, 27 Jan 2023 10:27:02 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CA9B18059E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 27 Jan 2023 10:26:37 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1674811597; a=rsa-sha256;
	cv=none;
	b=U7jf8DQzhkJ+8/kj0zbBOrtsLUPaWfVzSqeWiSQghfVqYlmLy0Dd+gstneG5j6StmRPu5i
	xB331HWEoBRvuZu8yDj+Di0zLMNZLWsnH+5mqo2E1Iu7dyb18LGoGdsjf6P4FDggJF2v9b
	ZioomiKAphILfx3YUWwDODHvhVBy4f8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=soKHyB45;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674811597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kmv0OVL2fMhvo77cyIn97Dt+xOGAUT6+stV2Eob1dAE=;
	b=Q3rEfBNnSQX8pXSQ6W+klHfEnu6VeJS8pa7ArFyqV6P7h591fTgI735oZWtxs9hZO9M7Qv
	so2zs8qoRjOy2k8A1fN5e2dHLi49ZoUtr952eVIRruROnK6ggtAAeEH7uBG8NV564TpCfI
	ZY7tEd5DCholpcVdHM5YhCGimBYySLw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1674811597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kmv0OVL2fMhvo77cyIn97Dt+xOGAUT6+stV2Eob1dAE=;
	b=soKHyB45O7Ni3QFAvvHm6j8rPp2Jr44w5BITUOU5I76VgQ3Q8Sp7dp4Uk/+Tk/i8KgQX0v
	XHwsE+tPvCQ/Hn2EwtsLTueEszF+xNQ80FfI3iz7aeU9APg/xgO1bVAu0uVpVXE1ryEhFX
	JqaiiugAz3iB54++hwtbh9bsSjqP3uk=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH v4 0/5] Implementation of a Stateless Multicast Packet Type
Date: Fri, 27 Jan 2023 10:26:34 +0100
Message-ID: <2666405.mvXUDI8C0e@ripper>
In-Reply-To: <20221227193409.13461-1-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12140063.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: SVBVDI6NOSVQJIT4EDFT7IAKV2LQIIYH
X-Message-ID-Hash: SVBVDI6NOSVQJIT4EDFT7IAKV2LQIIYH
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SVBVDI6NOSVQJIT4EDFT7IAKV2LQIIYH/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart12140063.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 27 Jan 2023 10:26:34 +0100
Message-ID: <2666405.mvXUDI8C0e@ripper>
In-Reply-To: <20221227193409.13461-1-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Tuesday, 27 December 2022 20:34:04 CET Linus L=FCssing wrote:
[...]
> The purpose of this new packet type is to allow to forward an IP
> multicast packet with less transmissions / overhead than the
> multicast-via-multiple-unicasts approach. Or to reach a lot more
> destinations (currently up to 196, depending on the payload size, see
> Wiki documentation for details) than with the default multicast fanout
> for the via-unicasts approach.

Please don't forget that batctl's tcpdump also requires support for parsing=
=20
it.

Kind regards,
	Sven
--nextPart12140063.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPTmMoACgkQXYcKB8Em
e0ZdLRAA2d8di55XyPirNX/xa8IGuTqLYd87aBxnTHPjFukggmZFVRxs/6NkFr3g
LKRraFH3/XxUZfR6st/pDUGkL5f7z6KFv9jNZkUsztS4m+a5wS0r4M1NIzaRZ6sV
u3Elv002vagRaaaUGkvVqkbzF3Aibmu8ykO6NuiJ3BCX5hPn9mbbgQCqxpBSIMak
2Rj+pEfgStNt8/bFNo/PlalwlMufwPsCrQ8ucbkE+KfiDvBDCnAopQ3137PkGbAT
uNFrFJ6D1H/nyJfcuijqlJLGoNhuIpiOgCeY79NiyQHqHLEljWxmaJwPdEv8tDow
C9DfwWpvPHO5m5eegFT2js6jF7z6PzQuOgY6dyUtszu5z1q5N+VCSaQYqyYDhGpU
JnrPbbISEJFoW6ho56WNUfj4zo8f4Ar42lPD4+SZD5sGEwa6y+o+rB0BvG5u/irK
lc8v8YEpP+WISOJ3OjGslR2VclaI+5ILMUJztOmDYsMz7r4RuyTYXbmwFsISJrJ5
YuHZ3he4VFLN9tGLVOFpTXFEVcZk5Gkgncq+nd5RBmOqUvWhSCemGo44zGKTpJFB
P2uQ+UerQ4SSPT1OfgTmqwg75A6mlHknaCuLHdQMz21Ur/3G+sqWlxY+KFqBC0hZ
SEuqD0uiaybXi15sJ82FDcbfYiN+DLEv1fias8XuM/jsmvcUGB4=
=uP4Q
-----END PGP SIGNATURE-----

--nextPart12140063.O9o76ZdvQC--


