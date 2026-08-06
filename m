Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41AAC5AC7C
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 16:34:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DAE6A811E5
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 18:34:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786034050;
 b=l8HQErensmpiAPR80vEr++YCJcaXWf+dgeK71n55gq5vOXQqHBXxiewUtdUvg/pB1bgJH
 KvgyMQdKfZw5Kel2vjqYkeq7AvPO/Ql5am+xKQxDWEC40xLbcN5pT+2XXCntPb1i1D1v70k
 2C3Wu6MlulDsQwYr4D3wBt4thoBFUzM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786034050; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=w4H2yC6PQ2JDPAI14NORM1ZMyLk4eXcA18IFYJSe5x4=;
 b=Klr8uoO9/K7TOSSIs9c3UDEWdrd6cL0dmMJFnQtK7VSej0uleK3hIg3frzzKXv32W5oJQ
 0wODR2J2QQLIi0wXj/UEjZl9WLkt4FxB1YtieGiDu8/4QfbQpD5F4+uOBFMwCr5VBi0Mp3d
 bffAH/XhEmFgOmfQ52TTmtNFe4XPPe4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7210680268
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 18:26:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786033578;
	b=d5DtNIN13esTPyY/6ippsS1rXXmX+kZfRkMNS+xZF4N1LYKOmMJunKMBIEKT3LTTn7wFcY
	mS5NcJJPiu27nqELJIYq4aOs8aryVvuwfFxT2UJ6PG5tfKSEqrcl5xB5/cvRUsDJ7W/xTR
	4scELR2Mq+xKFXw1eS4AdcRY1kNztb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786033578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=w4H2yC6PQ2JDPAI14NORM1ZMyLk4eXcA18IFYJSe5x4=;
	b=UZ5MlJ7K1PE9UC8C6dxhavmaHra9Kze3Xo+Z0SMIcok2Bhtr0Yf0Y99HnedUm+mGE22xkt
	q6UXIGRPpowIPo1EK7XyKxthYUGIHdsC0Ndn/7m032GUC6dgfM+R9TwbGh8udx+KGfDKlF
	qV6wwB0cDW8RZCl2XJvh0BLkugLsOQ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=1TzcCNwe;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 66A5120590;
	Thu, 06 Aug 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786033573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4H2yC6PQ2JDPAI14NORM1ZMyLk4eXcA18IFYJSe5x4=;
	b=1TzcCNweAvClvrGEez+sywN2Dj2fVj889fNaWTYIRPuLPNf9gXft8Pjv6+fpVCWzNVm/17
	o7O6qYcE1508LadKDLrGypBccePFntkyoWXm4MYBx8uYBqO/CVReDaDofdnUhbvqgUuWpT
	mJzfQ/EUxX7GDq0XK8BGQdo0VTmz5CE=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 10/10] batman-adv: remove negative returns for
 batadv_send_skb_unicast
Date: Thu, 06 Aug 2026 18:26:07 +0200
Message-ID: <3216364.e9J7NaK4W3@sven-desktop>
In-Reply-To: <20260805143200.722098-11-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-11-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3584836.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: JYXUDD4EAYXPCDN7QJM7Y4HQZIIPPN37
X-Message-ID-Hash: JYXUDD4EAYXPCDN7QJM7Y4HQZIIPPN37
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JYXUDD4EAYXPCDN7QJM7Y4HQZIIPPN37/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3584836.aeNJFYEL58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 18:26:07 +0200
Message-ID: <3216364.e9J7NaK4W3@sven-desktop>
In-Reply-To: <20260805143200.722098-11-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D10

> --- Patch [10]: [PATCH net-next 10/10] batman-adv: remove negative return=
s for batadv_send_skb_unicast ---
[...]
> > @@ -360,7 +361,10 @@ int batadv_send_skb_unicast(struct batadv_priv *ba=
t_priv,
> >  	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
> >  		unicast_packet->ttvn =3D unicast_packet->ttvn - 1;
> > =20
> > -	ret =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
> > +	res =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
> > +	if (res =3D=3D NET_XMIT_SUCCESS)
> > +		ret =3D NET_XMIT_SUCCESS;
> > +
>=20
> Discovered by: opus-5, old-prompts =C2=B7 Missed by: sashiko-gemini
> Does this change more than the counter in
> batadv_dat_snoop_incoming_arp_request()?
>=20
> In distributed-arp-table.c the same condition that bumps the counter also
> sets the boolean return value:
>=20
> 	err =3D batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
> 					   BATADV_P_DAT_CACHE_REPLY,
> 					   NULL, vid);
> 	if (err !=3D NET_XMIT_DROP) {
> 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
> 		ret =3D true;
> 	}
> out:
> 	batadv_dat_entry_put(dat_entry);
> 	if (ret)
> 		kfree_skb(skb);
> 	return ret;

[...]
> Could the changelog also mention that the packet disposition changes, i.e.
> that the snooped ARP request is now delivered locally instead of being
> dropped when the cached reply cannot be sent?

=46air enough, but not sure if it is worth sending the PR again to document=
 that=20
this is the correct behavior too.

Regards,
	Sven
--nextPart3584836.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanS1nwAKCRBND3cr0xT1
y7CvAQDMBvgESXFOmJfS2TUbdom9xSRdSCv5fy8cxYRiXvFVlwEAvSAvBEy1uAlu
+cteZTtC4bu4dF5Hsa+aXx3bkZnHHwc=
=0ajW
-----END PGP SIGNATURE-----

--nextPart3584836.aeNJFYEL58--



