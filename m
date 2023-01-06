Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7CDC54EBD
	for <batman@archiver.kernel.org>; Fri,  6 Jan 2023 18:16:35 +0000 (UTC)
Received: by diktynna.open-mesh.org (Postfix, from userid 0)
	id 9092A846CD; Fri,  6 Jan 2023 19:16:33 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A1BDA802D9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  6 Jan 2023 18:21:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673025665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aECQDuvOgmgfaYm9pl4DujutaWs/j0WDgyv7ehpmJJ8=;
	b=RQOqyueT6G722cIXPOzknBLUxwR7l16VHdpn1m8yBMct4qtn+V8TR7IJsCO2/bCVIeALCp
	up8Yf8Hbu5yb6jvwgIUaLGBeKxujXV/fbQ5Rt2W28F0BqGIpptImoUJqxDUBS23+pBunCl
	jSm8JuTFRGfl5G+3AbGDY3c2mUZhBQA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="kczs/yrJ";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673025665; a=rsa-sha256;
	cv=none;
	b=TEJIBoeU+iLjWaI4yEsDM4cvJyf1Bd+usnIiut3qXn6QylZJMQ/XyyDSkUyuEVzTmLi9+P
	EMFfqUfCDVExmvwZxjRWWLwxOL3O6FmLpDzrvm7cWOfksomnjOeTlxylmbnz+OprBUdnLj
	wY+OIad95SHjMvKUHRosUAseNY0Gzp4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1673025665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aECQDuvOgmgfaYm9pl4DujutaWs/j0WDgyv7ehpmJJ8=;
	b=kczs/yrJ7uryN/z4n/Ro2c+gdjpBtib+0Hng2Dx1h24pIZvY7Jy6UzzLmm9BVySH8y3Tk+
	xnTZ+mWf68gHc0r2aBstFIk5X75F6w+4kzdBh7OdFElUtMHY6Ok6XNF4ZP8HU0add+SBFA
	bOXNQJk4sbpb9UB6Z6Kfnw33PBJF+/M=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 1/5] batman-adv: mcast: remove now redundant single
 ucast forwarding
Date: Fri, 06 Jan 2023 18:21:02 +0100
Message-ID: <3367184.CQOukoFCf9@sven-l14>
In-Reply-To: <20221227193409.13461-2-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue>
 <20221227193409.13461-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24444831.6Emhk5qWAg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: EDUGWYIQOMPLQVUDOZH4WN2CLE6OZC4S
X-Message-ID-Hash: EDUGWYIQOMPLQVUDOZH4WN2CLE6OZC4S
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EDUGWYIQOMPLQVUDOZH4WN2CLE6OZC4S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart24444831.6Emhk5qWAg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 06 Jan 2023 18:21:02 +0100
Message-ID: <3367184.CQOukoFCf9@sven-l14>
In-Reply-To: <20221227193409.13461-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Tuesday, 27 December 2022 20:34:05 CET Linus L=FCssing wrote:
> The multicast code to send a multicast packet via multiple batman-adv
> unicast packets is not only capable of sending to multiple but also to a
> single node. Therefore we can safely remove the old, specialized, now
> redundant multicast-to-single-unicast code.
>=20
> The only functional change of this simplification is that the edge case
> of allowing a multicast packet with an unsnoopable destination address
> (224.0.0.0/24 or ff02::1) where only a single node has signaled interest
> in it via the batman-adv want-all-unsnoopables multicast flag is now
> transmitted via a batman-adv broadcast instead of a batman-adv unicast
> packet. Maintaining this edge case feature does not seem worth the extra
> lines of code and people should just not expect to be able to snoop and
> optimize such unsnoopable multicast addresses when bridges are involved.
>=20
> While at it also renaming a few items in the batadv_forw_mode enum to
> prepare for the new batman-adv multicast packet type.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c      | 249 ++------------------------------
>  net/batman-adv/multicast.h      |  38 +----
>  net/batman-adv/soft-interface.c |  26 ++--
>  3 files changed, 33 insertions(+), 280 deletions(-)

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart24444831.6Emhk5qWAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmO4WH4ACgkQXYcKB8Em
e0ZMZRAAwegBhINs8Ov63CAYGr0Lo6xiDPCyxHjSaMMpXoGtPF+CC9Zq6ZGBeDAG
qqqr8++5JCzPtJLrr7/nGH6KAgEfmqUV0/FSG+FSIq95mtvLvKBZ9hCRRwbg0XW9
kj67r/AtPAGHaOSvq+EpZhgQp/FpHA+l/qJ5wQ2WJf7B1jjc5eLiQnT3ZCtCQoqQ
AlFqgz68rzwTOIpfp+5hcYYUQvQwC+RA9mO1A0eARWGA8sPIljY55XodUFGDFA9f
zzp9qKYla0Yoa7XEghNbl1pQrxbZkp8TvsK5nQH4tLJbIWdrtPbAPMt6q2LpgDX5
Vrz0mWFQK7IROjULIGCEor8I9dnNC8KZWDNLrjygepqGqpLcaavcgUm216EgsRUT
DusNohAUjz8vXQm1BDtWg5HtX1TsblOZ34Mk98+7hUCwOHv5VOgR998IcqKyZtTr
W3fgdenemDQPVu8FuPXCPtqQ9M8u3/DjxUsDwRoXK72gU7yhNfLZRmbMNBKWAspp
FS3SoJ/b+LYUh/dQgpvDlgw9IvaNcr+3HJbLK+FKTxtdlpms1W3A/x122sXhFi9x
sDBPAIKvfS1r79wmZXElzWTvHJ3EDpZ/js5XYiw5uiBO91whHRxK4d/UAqF13/nC
+p0PkDNm2RpwHDp1ZqbxsK0EnVhHKJBPNiU8Ul6YrBXrYGKBWAc=
=S5HF
-----END PGP SIGNATURE-----

--nextPart24444831.6Emhk5qWAg--


