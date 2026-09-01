Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C28EC61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 17:20:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E41FF8040A
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 19:20:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788283241;
 b=lAqIFD74fkGIjbqPGc6A79VWLajowIxFQTSzjj87g/g3M4LtJFeYepJlY//P7h2ZuKuNK
 KyhnjFAU14BWCi3l4pe8rqunV99tpLEdaJTHeO92bqmm/VRAe67O2hCCssUdV/9nvysLaSS
 BsDGek1Cqu86XpAjR4DXy4+1UDb4/7A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788283241; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LKotAP8wIM632B6Qzi4Laf7xzJu+rWicdboEu6B0ej8=;
 b=kozbLwt0HyTBVu2f7ucLfp4Fz7vMii9eXe/bgyDlkYCfkvbRYItBny5ehPas3miDKpoAO
 47nXFeTW/NSLIMSnZDyZnlIPf2y+xTvYRDZQbdf8Vgk7RAnlZXAaWYlpI9hI6UTd+WYyYCg
 aoaiBFP3ektEAYewNTkoJLtclz/0Vi4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3C34C8040A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 19:20:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788283234;
	b=qqRME2hiXpejcxxg1PxCH0K1O6Dd+0qm/BiD71ePduFizFzspk3exJ4TDRDEZ/F2w6nUuc
	kQ52zHswlsJ0UJCzL+3qEGza1C4/2bSb3kZ3JMEITf8C5REzZTjhdS2BTwiHq2BIQZxr5u
	JqwHifB3rYLpiNgYqv4dRZ7u2J683SU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788283234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LKotAP8wIM632B6Qzi4Laf7xzJu+rWicdboEu6B0ej8=;
	b=j+9U2PDXYqcqU+WTRGcxi/xw3RtsD0LlWtXur5mNf3S7KYaPMGyvopam4HK6zd4bBWOFRJ
	jJOhXGHSxr9jCTeJs1jS0+/P+RYz/B6N0w0Zm5HPM6Y+gQlJOXaKIqH974CYEk451zikjR
	5pWjmhGju9T8extEhVaj2kKwNoGP384=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hBQx4vaS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9F9071FE7E;
	Tue, 01 Sep 2026 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788283229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKotAP8wIM632B6Qzi4Laf7xzJu+rWicdboEu6B0ej8=;
	b=hBQx4vaS08u++5lmX+bTNC88m2XBLjeSOqDlBuUtdPljg4we65V/IInSANMhqFT9a8B0mu
	4cRz1fiVImlUVuA6VZep9pwMpP7IMhZwInLbFPnENXrg7Z8+/yIadOGfnXEkXuTe9pp89s
	6hFTC7YzP9Sp0MuOH8rWB/EfPSc9+ew=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 05/15] batman-adv: use more descriptive var names
 for
 is_similar_or_better
Date: Tue, 01 Sep 2026 19:20:26 +0200
Message-ID: <5705187.Sb9uPGUboI@sven-desktop>
In-Reply-To: <20260831135117.574836-6-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-6-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2067881.yKVeVyVuyW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: MASA44AY4YSTSWF25YBXY3HOKFFFIKCB
X-Message-ID-Hash: MASA44AY4YSTSWF25YBXY3HOKFFFIKCB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MASA44AY4YSTSWF25YBXY3HOKFFFIKCB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2067881.yKVeVyVuyW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:20:26 +0200
Message-ID: <5705187.Sb9uPGUboI@sven-desktop>
In-Reply-To: <20260831135117.574836-6-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D5

> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 53fbdbbe8f4f..3fe09b4c3046 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -2424,25 +2424,26 @@ static int batadv_iv_ogm_neigh_cmp(struct batad=
v_neigh_node *neigh1,
> >  /**
> >   * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or=
 better
> >   *  than neigh2 from the metric prospective
>                 ^^^^^^          ^^^^^^
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug, but was the summary line of the kernel-doc for
> batadv_iv_ogm_neigh_is_sob() meant to be converted too?

Good point, prepared a follow up patch.
https://patch.msgid.link/20260901-bat_iv-sob-kdoc-v1-1-54be2f58b715@narfati=
on.org

Regards,
	Sven
--nextPart2067881.yKVeVyVuyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcJWwAKCRBND3cr0xT1
yxAuAQDG1I805mYMpXg55gEtqWSCdXkO9pQvbiaP3RsjAwPQtwEAqgvHVVn/oUa/
XbNWp3FK3qw2v8YD4pjsSw95Q08EjgA=
=jSDt
-----END PGP SIGNATURE-----

--nextPart2067881.yKVeVyVuyW--



