Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82854C46CD2
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 11:22:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0F81D83E2E
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 12:22:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1704194567;
 b=r+aaiwImm84I3vseLzvIBNNQuNKWCVzPihq+MZeLHXKMgiCIF2cqHXmCwz49q/vcy7ZET
 wSvG/RmOq2b2/pfjUI3mjOqfyjksFcmjMfLsbsdpfaUNtO4jjEoeN3B8vUPyl4NsHAhPzt7
 CYfbju/qBJEtwwSVilDelPIRbK5YYU4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1704194567; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IKJCpy+cXuzjprgjg+Of6HIRqe2chRqAQCoAEdEUmLc=;
 b=1MKq+L3omt5oyMnPjztJKdZ4SP6qbDMXrA0sgTngiZY7n1XdKZ1uWHbsL666sfgmMXlAq
 5kx7cZ8itwedb3RoypDInovejTwatIS96iPE/ldo/XHslTvNcuk5p94v2AP13ulUHkY44rx
 SwbUAIfhNLh9lPk6NaFNMGXTPKryQvs=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A434C807AA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  2 Jan 2024 12:22:21 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1704194541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IKJCpy+cXuzjprgjg+Of6HIRqe2chRqAQCoAEdEUmLc=;
	b=ZksVHuk63OWDYQ14n5aKYtWy2Y1/m7/h5X3eDyB/rt/Nliag4DMcOtUZUs+SpsNYOUzsEh
	ThF2gSzXJM7cBXQe6ax72ENlPArG+XUiEeIxSKyJIkEHn8Y9Ou0aGhVSQQriJA+Y+MG+NL
	P5DTo0r1aObNsGaB4/rxC/g7cEpLAWs=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1704194541; a=rsa-sha256;
	cv=none;
	b=GBLVYdA121IGuR+I9tdaLYOWnPI9NtjPrWoFQryZWszji5D4EbK1nGE0ROzUV8vIwHZaxn
	aCASUchkqzhceB4BTPrxemPGKgcSEhPT2yumZnKx4dNqwIoVcvm7GUqdbbhCNdW1d0YCEd
	uKkNRWGVoey8cNmOVJH2g+k6WZgbJjk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ma1AcYdF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1704194540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKJCpy+cXuzjprgjg+Of6HIRqe2chRqAQCoAEdEUmLc=;
	b=Ma1AcYdF6RGml4NMC2wYnGW8Vy7bjxkIzK37EUrf2SOtuanqn/FetHnrbA82SaaooQe92G
	Mhnjmwbsq85AfOHyz7iQ0XHuHmEeytkzWWUp4MladgBss0XUVBDLqt6+JL42CIWfs/dW8/
	/64eblXjavruLl8t+a/CvRTjviKw6ao=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner <mareklindner@neomailbox.ch>,
 Paolo Abeni <pabeni@redhat.com>, Simon Wunderlich <sw@simonwunderlich.de>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: 
 Re: [PATCH 1/2] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Tue, 02 Jan 2024 12:22:16 +0100
Message-ID: <12355496.O9o76ZdvQC@sven-l14>
In-Reply-To: <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
References: 
 <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
 <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5744289.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: X3NJFBZQKHOLTMSWZ35DVA6MMUIIYNLL
X-Message-ID-Hash: X3NJFBZQKHOLTMSWZ35DVA6MMUIIYNLL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X3NJFBZQKHOLTMSWZ35DVA6MMUIIYNLL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5744289.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jan 2024 12:22:16 +0100
Message-ID: <12355496.O9o76ZdvQC@sven-l14>
In-Reply-To: <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
MIME-Version: 1.0

On Tuesday, 2 January 2024 08:11:47 CET Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jan 2024 07:27:45 +0100
>=20
> The kfree() function was called in one case by
> the batadv_dat_forward_data() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
>=20
> * Thus return directly after a batadv_dat_select_candidates() call failed
>   at the beginning.
>=20
> * Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with th=
is refactoring.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Sven Eckelmann <sven@narfation.org>

> ---
>  net/batman-adv/distributed-arp-table.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
> index 28a939d56090..4c7e85534324 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_pri=
v *bat_priv,
>=20
>  	cand =3D batadv_dat_select_candidates(bat_priv, ip, vid);
>  	if (!cand)
> -		goto out;
> +		return ret;
>=20
>  	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
>=20
> @@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_pri=
v *bat_priv,
>  		batadv_orig_node_put(cand[i].orig_node);
>  	}
>=20
> -out:
>  	kfree(cand);
>  	return ret;
>  }
> --
> 2.43.0
>=20
>=20


--nextPart5744289.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWT8ekACgkQXYcKB8Em
e0Zezg/+P9PfejkVp+OoIyYjl/JOvoFqwplYaSBqhuTzvIVSx8fGZmzS0eBHploL
kIPHLR9UoxD4ghhd0JX1Vu/e2bWMQUFJGmzX92xFcXxMrx/FJ3DfMRM9rPSkd/FX
Z4QFQp5BkQuqWk1tICiOSP+GeGtiXY9UZnrYFEKmJG601RaziFMGXC8va/zmaBBD
7+YTYyJwPxO5jF+KLIEMJjCT1b4+o9fneoGdwpoyvk0JyC9FbYbiOPeeB+37PczD
X1YGGNnAmF8cPFU89J/8XXplraK8HAOaivzAsTDPnBOu4SP/spQKWefX/LgqkFWx
5c0l02CzZapL6szJEk1ZbqTfXrRbDjnqFxxIV7HBbtnx6hkSbPvNcubB+B1k56AA
l+2EY9gPnIUe/a5C11LUYc4zfNF5Z+k8ZgtrRiTiR+CstKtjBdiGytyRN4Lj/7ax
YmhnVkAKY/Dr79Frc76jP+sGNnCzHna9AhHUyHBtHRdr6/vx8ggEPtylrxjsVll0
VCZuKAM23pJ8fKdEiexVon9pX5UXq+nqIBc/iZvU0+i/QE8GK/DAd1lWVoDpFDvA
25O42/MbEUefcd4VHksZdNLOqxKwyFJunUZmS5piyt7VO2RhRUQQVCeWDvETpZ+/
oyV9q09FlZRIYbRioLqmv2jNV7WoUSw3DWOrh7GUe1vsWzYhzmM=
=QSP4
-----END PGP SIGNATURE-----

--nextPart5744289.DvuYhMxLoT--



