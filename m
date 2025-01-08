Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D40BE77188
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 13:56:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 816B284241
	for <batman@archiver.kernel.org>; Wed,  8 Jan 2025 14:56:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736344599;
 b=iPt39NsOKEwt/NAYTur11uDB0Zt60mrT68ohBBQuF4AJRe+ErbIqLdICkcdNaYFrgHeDR
 H3nu2E4Ik7mIwWaRkwa8ASF2xfMjKSSHgHjONVxOjKU/4BF4OwwUW6P1tnhkRA3NCaSOlVh
 QC/+ECWvAHFL1sA9bOYl4E/qLm2R64c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736344599; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JiJl914Lvg88cyIS5fhyS7aAG4Zh+o7PkfFyZT8bU2Q=;
 b=Pj2AYB+4mhsG50uS09sNUcrqzPqw4r7d0c4Kfw6SmyEDY8WzmdsseajWkoiXXS2NjFr85
 2fwOSj1dRE6+uVI7Fl5GZn3F5SFQpjIzjyikVunxYMn0mL3Nd6kGoXJjLWUifFEogpL30pG
 8eai8bN+Rxec0nYdJX1B7QVHoQ2ovXE=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1479E83E0C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  8 Jan 2025 14:56:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736344581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JiJl914Lvg88cyIS5fhyS7aAG4Zh+o7PkfFyZT8bU2Q=;
	b=r7b4+I01DGkukAFMCKwqIBL/9M90zhhJBvIPfBS9tRETXGb2F8WEJrKv1VnVye1oK/Xx52
	Dm9T8NhihKbLffD68CDzmA0pCjgcP8zQx5zBefBOsj1bCCNapDmLIOKmG398YoA/X94GWn
	YaI0SQZSX/EbhPhhB+WrioV/JfXKiDk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ik48nOQS;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736344581; a=rsa-sha256;
	cv=none;
	b=GI9S9sI0YFaxsK5jB+gl7ZJc60r3tfyL+iLgCAuwUg2zQII50skdxaJO3cKSx5ssjqEH5G
	k9EgvAp+aQmREjucZ8xKDX5hPNxsplYwhRzO8ez26yo+zZimgN1k9qWK/z9Lt+lOkzezjz
	dS2ntLWvdsDHTRTeJgVK6wL319gp0X0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736344579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiJl914Lvg88cyIS5fhyS7aAG4Zh+o7PkfFyZT8bU2Q=;
	b=Ik48nOQS6XSPXL3K2EqxxiCGKtY3jvtxd/U//6xHYVYQ4uqSswy+j3++4WNzQww4AC/T5o
	7OkmlF0Cj9p+UvG+JQtazXj9g7JpTHMrhyKA+r0F6XVbA0YWh7cV5dsCS4/K2ynnW15k0z
	FkRPs6kOnq3UJPhdXOzslFtCpUppZ44=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v2] batman-adv: Use mailmap to fix old e-mail addresses
Date: Wed, 08 Jan 2025 14:56:13 +0100
Message-ID: <8515152.NyiUUSuA9g@ripper>
In-Reply-To: <Z36CtUlH-_1GLts_@sellars>
References: 
 <20250107-mailmap-v2-1-12d85da0b8e7@narfation.org> <Z36CtUlH-_1GLts_@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2010993.usQuhbGJ8B";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: DMPKWUNSTWNA3NGVUK5BG2YQKNXTQRBS
X-Message-ID-Hash: DMPKWUNSTWNA3NGVUK5BG2YQKNXTQRBS
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DMPKWUNSTWNA3NGVUK5BG2YQKNXTQRBS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2010993.usQuhbGJ8B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 08 Jan 2025 14:56:13 +0100
Message-ID: <8515152.NyiUUSuA9g@ripper>
In-Reply-To: <Z36CtUlH-_1GLts_@sellars>
MIME-Version: 1.0

On Wednesday, 8 January 2025 14:50:45 CET Linus L=FCssing wrote:
> There seem to be duplicate entries for me in there, both for the
> @ascom.ch and @web.de addresses?

You are right about the web.de address. The ascom is not a duplicate but yo=
u=20
(at some point) had a typo in the address - commit c4a94f32bbe8 ("batman-ad=
v:=20
Switch order of types.h and compat.h inclusion")

I think the web.de address had a different spelling of your name and I forg=
ot=20
to filter it out after removing the "old" name part.

Kind regards,
	Sven
--nextPart2010993.usQuhbGJ8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ36D/gAKCRBND3cr0xT1
yxVeAQCVEgV+QlA8UoHxPykwa1EJaeyt57OVhXWL56h5vAaHXAEA8Evcu0UeWcDM
5XCmkl+RC17QQpQbgeOnIUEDIEKZvAQ=
=vM6M
-----END PGP SIGNATURE-----

--nextPart2010993.usQuhbGJ8B--



