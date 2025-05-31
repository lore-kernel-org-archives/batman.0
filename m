Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C04C5AE59
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 09:22:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5B159847A2
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 11:22:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748683333;
 b=xyaB4i+ipfdrJo/B74ae4cABJhQErqs9Yf4sqMYHrEYvrF28D0zPLXAHPyM6/6vi0N7De
 ymI1YII20TNm+7Y1oZIm2P7iIxZxBNzbsWN0EjbyW3ZZDQh3BRt6e+ZAe2lYQqaCGM8AWZs
 6GiXDxru+nr97xbogAQ813J5WkPAVKs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748683333; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j8v7hhYADUSDBALNMgGQ0eVg8nF9mMtO+msRRg6pCVQ=;
 b=OG9ggGm9g3pOcYI3I2JsbRd3TrqpXWfOOVwvFLxAZGDSRtNtCXkwPomi5/0irpKCyTcaM
 b4g4KSxj6APa/tGWGAQhytQN8zpxl2vbXNUSWyAIkqwv1+QRlCSU069leV2ZCRj4vqgbR44
 NaYM0xlgS59YqEEK5Fgecjhj4TBQqqo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3E544835FE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 11:22:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748683323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=j8v7hhYADUSDBALNMgGQ0eVg8nF9mMtO+msRRg6pCVQ=;
	b=qU8cL8sWxObP5vfRIsF6x6h0jzIrE0Q0d3DOP0SkfmT55q20uMHOz8B1sBbGHUjSBgmTth
	v3j66IKim5dkl8bqv2ND8BsdbzbUNemEJLmJZLlWjVyAte/YPeXiSPBUCx+v3NTGO6OY5P
	CUbTMMaqaPT5iPi7OnBgfJgBsbOfVPk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xE1048Mn;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748683323; a=rsa-sha256;
	cv=none;
	b=3MllZPaRO/Q/iyovQ9ItzzVpxid+FSyPCSxhJ4fruoq0yFFYcj7mNvTUfolWeb6nzlxE6+
	IFzVVZPiVbr3l9Ott/qZbCbM//F62azcPcCzqHFeUQvbPKNgvbJ0JmAgdToNXnKO7CaICE
	Rn00HWqNPaRRsZVuKBB0KXTUUbbEUjM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748683322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8v7hhYADUSDBALNMgGQ0eVg8nF9mMtO+msRRg6pCVQ=;
	b=xE1048MnNYlE8NWyUEINeLcBKvFzOU3ZrUeJI91t1dMT8EufgIXw40OqgkALKjiomh5ZnQ
	V7r0M8ACaKnWgOEQEw4JeoLD7fwgvB+hgLuiqmTwSO2IWrwdhKgupbbCeuuyNZtz8sTNUH
	Z9k1AiJROhhvyqVaYuT9+L8Pkuc5JLc=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev is part
 of a mesh
Date: Sat, 31 May 2025 11:21:59 +0200
Message-ID: <25663883.6Emhk5qWAg@sven-desktop>
In-Reply-To: <7760123.MhkbZ0Pkbq@sven-desktop>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
 <7760123.MhkbZ0Pkbq@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4362857.Lt9SDvczpP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XOKBSYETKJV73NEVWXAGIWJRPLZ3FD7I
X-Message-ID-Hash: XOKBSYETKJV73NEVWXAGIWJRPLZ3FD7I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XOKBSYETKJV73NEVWXAGIWJRPLZ3FD7I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4362857.Lt9SDvczpP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:21:59 +0200
Message-ID: <25663883.6Emhk5qWAg@sven-desktop>
In-Reply-To: <7760123.MhkbZ0Pkbq@sven-desktop>
MIME-Version: 1.0

On Saturday, 31 May 2025 11:16:30 CEST Sven Eckelmann wrote:
> And yes, this means that this needs to be removed in PATCH 3 again - together 
> with the `kref_get` from this chunk (from PATCH 3):


Sorry, I meant [PATCH batadv 4/5] batman-adv: remove global hardif list

Kind regards,
	Sven
--nextPart4362857.Lt9SDvczpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrKNwAKCRBND3cr0xT1
y/M0AP9g+BqAjjlxOI9kCnFV3nh+CKN2Ove7pEJWMkP87I5VgwEA5PqgyCOIwLh1
ubidCl1lIiLg5iFmDYyAEkgqy89H7AM=
=+h/T
-----END PGP SIGNATURE-----

--nextPart4362857.Lt9SDvczpP--



