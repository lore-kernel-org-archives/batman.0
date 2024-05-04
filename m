Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A97DC4345F
	for <batman@archiver.kernel.org>; Sat,  4 May 2024 09:48:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 91C9381E85
	for <batman@archiver.kernel.org>; Sat,  4 May 2024 11:48:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714816114;
 b=d7uVhu5zhdodf4M6hkmCk1C9lIT7sOORQRB6d3ZimombzTbuzcU9WGTJThO/Bgv0Yz/FX
 nOWS3+3OoBc8SD+OwHik/Ip47B1v4IPtkbjeQR/aCNjZ8ti0F6qyDYaMs1OMMuMN6qbaaQ0
 C9Ljk79aX0GQGo91iIBZvXNWPfMHGDs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714816114; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mw7SFuN2SHyU67C8OH1gLXKRgrvpMA94gKGdBbC2U5Y=;
 b=HUESBtWc7QF9WBDQTHjgyGrBl+SlKvntCH9a7a1jaamy/AdaVpilwNx7uUsHcRoaBLzyn
 bU8Z3neAT2tgoLvVP8qormIpG6h4v/8I9Kl2jWg1EBaalijeCqhvQklYisX6DyHp6IaWAjs
 AJQ2tFyzP5sPFzLw+ajieO0mcOdQweE=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4B69A81500
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 May 2024 11:35:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714815343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mw7SFuN2SHyU67C8OH1gLXKRgrvpMA94gKGdBbC2U5Y=;
	b=VNqz+SFXm75CMGCQrvPPv8lcyK2ZTi74LEGIO8JVleRa8Xx8MoxQSw+lBd8rnwQOjiLTr3
	ydHJ/UC3r7l8gvrCFQ9Ab6WOGiNb8YIfMtRlZoOhGx1ay6v7XHeRyNt4nPOYnFtJG/38Tu
	vpxKQe63kuJVzoGICAWk8qpmvWLDiZY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1714815343; a=rsa-sha256;
	cv=none;
	b=i2PLniOhZwFDaw/iVy5pw6jcmMzWJtnw70RROYswSsvzi3u/4PLshzAlKsDz9OPQ60Yz6E
	wdZ0H22wHwhTO45kPj0jqovMMuPIoF7Pm+QTro3vNT2tNs2qCKftlsrOAIId+d4afLxSNd
	xgtgEdld1i27UBjH1bN9BgnMOGHXCtQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=okWKVeJ1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1714815342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw7SFuN2SHyU67C8OH1gLXKRgrvpMA94gKGdBbC2U5Y=;
	b=okWKVeJ1LP27/Ihu8TKZpJV5+kdcRHrkgkz0ecctRtlkJ282/Py2klIdLw6RKUKpJqZCuz
	Q7Zq68Db9+BwMxEPvBY9lMElzorY66vigachpn46RQk2RGlW1eEGYjYcP3weo2837HXabl
	7WVzBNxDpncV72/vcVthNbJj6zHVWjw=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>
Cc: Erick Archer <erick.archer@outlook.com>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: 
 Re: [PATCH v3] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Sat, 04 May 2024 11:35:38 +0200
Message-ID: <3932737.ElGaqSPkdT@sven-l14>
In-Reply-To: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6497797.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: D6SLYFMBXVBNLLNK6ARSS7DKSYBKRXB4
X-Message-ID-Hash: D6SLYFMBXVBNLLNK6ARSS7DKSYBKRXB4
X-Mailman-Approved-At: Sat, 04 May 2024 11:48:31 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D6SLYFMBXVBNLLNK6ARSS7DKSYBKRXB4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6497797.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 May 2024 11:35:38 +0200
Message-ID: <3932737.ElGaqSPkdT@sven-l14>
MIME-Version: 1.0

On Wednesday, 1 May 2024 17:02:42 CEST Erick Archer wrote:
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index 6e25753015df..dfbe30536995 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
[...]
> +/**
> + * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
> + * @flags: translation table flags (see batadv_tt_data_flags)
> + * @ttvn: translation table version number
> + * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
> + *  one batadv_tvlv_tt_vlan_data object per announced vlan
> + * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
> + */
> +struct batadv_tvlv_tt_data {
> +       __u8   flags;
> +       __u8   ttvn;
> +       __be16 num_vlan;
> +       struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
> +};

Thanks for the updates. But I can't accept this at the moment because 
__counted_by_be is used in an uapi header without it being defined
include/uapi/linux/stddef.h (and this file is also not included in this 
header).

See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
identifier expansion") as an example for the similar __counted_by macro.

Kind regards,
	Sven
--nextPart6497797.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmY2AWoACgkQXYcKB8Em
e0aJDw//f+el64xroKLns43gvY+Z/mPIwf7Iy+THUq6U9zVQ0wp3XbW9QTmXP/5K
8it8yX2aNEEPu4Cd5w6eIrwxIdhDZW3pHxI9ipdgTjF/i0Jh40SpM9HOlgMLjCys
Ls0Innvs24uQ99h4OSk4TGuHay+6Z0aMEV0PrFsj6jsoB7su7nmQ6ebEpdY40246
soQfO7aJ3vrSYbuCJFOlMESNHm0wRxQu4QjK8RDmyk1wEyJIkQyVQ6QkjYj6ulkr
+eai2uDQWKEPav2vantbXXsTK4gu7nWEGTcHn2NoJJ/bqtzCrz1FS2u55PZ9l9P+
auO/nPz1RB2hHAA3t8igC5jRK6AQ9CdjRMt3rQ8Pmk2jZKt5G153j0lgQdq4nDaf
V6ji3IrDnjQvIAeUN5vkIlwqbmVo2BbIqHDXK1JMmUEryQCt9HHFCnLYVr0v2WuM
tIj/T68pcEThoF4TU2B30ScZUfMeZ8e3im53RPU+29ljldyX6WCxIGLIyFZM2mbo
U8cqULn7tN8LfMcB7CYf7+H6GDCOq+m+Xd50oQsIYb0LDIk5CuEAVBCA1/wNog5q
+HVplKYtp2LSIKQKMey2u0loQFq/EnwH0pS0Vv5SylRQMZ1PRFq54tWRDsjwDw4/
BMP9cF5Njh9uyD2Db0uZRZ+OWKH0KC41A+cvue7gjWA5uNDv6uA=
=qo9D
-----END PGP SIGNATURE-----

--nextPart6497797.GXAFRqVoOG--



