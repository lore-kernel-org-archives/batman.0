Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86C2CD4F54
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 19:24:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF79183F69
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 21:24:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780082650;
 b=U54IBs4BmnO/zhVuhoa7cszrYaMrot/XheFLvhdXKB/K3lsyfdqgeRYDhup77KdHZ9PAv
 yOHTATiHZs7DqMKItO0gxoc7e+tpqvNd9MZgklgBQqdsn0wd/kYqXTQ+6ZTp6XR04dCHT+w
 xSW4BxxkWddOCyTUZs2G+rfzPx7ypoI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780082650; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ifMQbo73xD+U9Kp8zhdBidzj4xF3PjSxIjqhbVROWok=;
 b=bljbcfr6XfDQXKh+c83UA4jWHHMy8CjNoz/jnNtzu9Inxl/eCWOKhBXUjH+dzCxKQTSKd
 2xG7hLAl2prkShw2s8xp92kA3QN2X1aBdQUrDbruZGxh3hMIta2I+mkITPS6vdK8Not0SvA
 T6Qgr7D9rFI1LEFhX1i7bAjRlKW7Ses=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F121E80FA2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 May 2026 21:23:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780082620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ifMQbo73xD+U9Kp8zhdBidzj4xF3PjSxIjqhbVROWok=;
	b=kT78JMjfTo1f6vn4lUYFMiXB62xacAGVtvRClCctzTVFZSYZmb6AbF+wTP8L4oIWseQN7r
	+9pXX9xlhQz/CczwXojT52adJqDQsGKULVhvJyN36CDzZDmTILdWNc/XZFv4jwCoKq1w27
	n6yGaejoMhlosWcNlxSMPhRfBF7mXFg=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780082620;
	b=peFECUFSY91wCkSFD5Kxyt8uGUoGbJw/Qk9fRfILNzqwmeJrQaPxTWZb01vqbBqOq/oZTg
	C2DRyY6IxtNhZJFWLDIMYig+GWPnI0L2DT1yYnAbI8rFnx0pP4+JW6j2Ul81+tw2w/Xnpv
	3/8BdDpsmG7eT1+UxE9m1NFNHZc9sls=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NuNKoHdV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8287320059;
	Fri, 29 May 2026 19:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780082608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifMQbo73xD+U9Kp8zhdBidzj4xF3PjSxIjqhbVROWok=;
	b=NuNKoHdVLKpgeyMG19mM29oJ0AtSBjRyp/lBvmUYPVEZ1GYmtHe+PG7jzj25QM5hG3gS31
	jIES4al59uAdOnOFxYTB2LICqlS1o/TFQbPls8JQ7dHqw7dsfjQFRZ68giNXL1EM4m3t9c
	tLCoNVU+/fwq0vv7Em/xxqdVPK7ShTM=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Date: Fri, 29 May 2026 21:23:21 +0200
Message-ID: <3637868.44csPzL39Z@sven-desktop>
In-Reply-To: <20260529112430.09c1a08e@kernel.org>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
 <5075322.GXAFRqVoOG@ripper>
 <20260529112430.09c1a08e@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8904532.T7Z3S40VBb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: OFNQ7KHDRCVFEPL2SB7SW7TC2MAYWJ4Z
X-Message-ID-Hash: OFNQ7KHDRCVFEPL2SB7SW7TC2MAYWJ4Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OFNQ7KHDRCVFEPL2SB7SW7TC2MAYWJ4Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart8904532.T7Z3S40VBb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 May 2026 21:23:21 +0200
Message-ID: <3637868.44csPzL39Z@sven-desktop>
In-Reply-To: <20260529112430.09c1a08e@kernel.org>
MIME-Version: 1.0

On Friday, 29 May 2026 20:24:30 CEST Jakub Kicinski wrote:
> > > To be clear, definitely a move in the right direction. I hope we can
> > > move _all the way_ in the right direction, tho, without still defining
> > > OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION =20
> >=20
> > version.c and version.h are there to not recompile more parts of batman=
=2Dadv=20
> > than necessary when the linux kernel version changes. Has nothing to do
> > with OOT. If you consider this a no-go, I can also just place=20
> > generated/utsrelease.h + UTS_RELEASE in the three different files.
>=20
> Ah! My bad, sorry for the accusation! =F0=9F=99=82
>=20
> The re-compilation thing is annoying but it's solvable.
> Please TAL at commit 3f9ed5f5aa9ecffd2 for inspiration.

Interesting, didn't knew about it. This should work for the in-function one=
s=20
and avoids the const batadv_version string + version.h.

https://git.open-mesh.org/batadv.git/commit/?id=3D6f864eb5cfd8315b8f9a29167=
263282fe4593f3a


Now we are left with version.c. MODULE_VERSION doesn't accept "dynamically=
=20
generated" strings for obvious reasons. Which could be handled via:

* MODULE_VERSION(UTS_RELEASE) in version.c (keeping it in a separate file)
* MODULE_VERSION(UTS_RELEASE) in main.c (requires recompilation of main.c)
* MODULE_VERSION($STATIC_STRING) in main.c (then somebody needs to come up=
=20
  with one)
* something else

What would you prefer?

Regards,
	Sven
--nextPart8904532.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahnnqQAKCRBND3cr0xT1
y9ZnAQD24lphhoj0ZUTST9soYaVsHJ0FJgejx6k7ey/9Ps5UuQEA7HgjYVaP8kbT
7C5kaF6r/QybbZuI6TPdYX+n+8+3Zws=
=7rgI
-----END PGP SIGNATURE-----

--nextPart8904532.T7Z3S40VBb--



