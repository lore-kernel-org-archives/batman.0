Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAF6C56205
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 15:04:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 29A968427A
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 17:04:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786028646;
 b=XKF7hXnm9xkVUhWS28DgRJdSKyosq+7NWhdk8bITOcj2O9oiTJDG7owKC89g2gBnH5kJF
 3MHq4vlR7WQBotmCtY64mkrP+oXfq/m2Mnh8EzjkkWqRVbB8J2y8YySwVMso+N6dMy9ben1
 47fZYW5p7+QZaqudL0DfU++AN+EAw2g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786028646; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JtwsqjhEg4/Ps2dJSppFH6CbIpUpKOfLmJgscIj5QtY=;
 b=j5bUvnVV0WzfIiIXKK0PstnOSR0X7YAozhi/KBuyo/UchOe/TLkH1PBO+spDw9SofMz29
 jTt/9rDE31bn5CClwEov6Jp9n7hmVNOrkc681XVEnZXpVwXH/9zxh01Fd6ELUdReQoPCpeY
 ZuTsZyWcaxARMH39edPzCwFk8wLnNUQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A31BD80C51
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 17:03:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786028629;
	b=TjlU/NntdsKlfV9GIo+qe8WDttGTahSg6BAvm2KW5EGvscPphd0iIOfHjp+a/w1MxhzKGi
	vHt6CIbInCtxvgX4rQyC1jXWpNNvOJFrM4bsibbIILDp0Oaeyx+7HVnzXAnruxIFHhFCGW
	NpnBBKDzOL5H+uZ8TcL97tBRw45YZiE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786028629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JtwsqjhEg4/Ps2dJSppFH6CbIpUpKOfLmJgscIj5QtY=;
	b=JsYNrqZ3Q95ArEQCEfxPzKenttjdMrFbFWp2TE+DCp5oc6RD/dh+0No/vft6zzYkPWmfMd
	tYfnTvLQvEOkdqytg9JlQ2F+PEfQZXIGjSoopqasX0eGObW8yfhUEA2q4fCaXOf677FQeE
	jcnSUgi3ctQAwF8JHUId/QhTxdxkZHY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JO1cmrW9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D64BF200D8;
	Thu, 06 Aug 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786028625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtwsqjhEg4/Ps2dJSppFH6CbIpUpKOfLmJgscIj5QtY=;
	b=JO1cmrW9A9AKSxP95YtIx7zZY1BW277EKJe7z+xcF1B1ir3EmHI9NGxCot4wt4XP44GtAH
	CMLSY1UL6lbzE9NQMOpXptAqclD/9n6BiFhcXT7lsS8TvC4HHZ5lTuF9ELcwAwNfldx7FZ
	09ywjbnKM+P1smQT5rUdh9O/IHN1A/Q=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@mandelbit.com>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr backwards
 compatibility
Date: Thu, 06 Aug 2026 17:03:41 +0200
Message-ID: <14211429.uLZWGnKmhe@sven-desktop>
In-Reply-To: <20260805143200.722098-2-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3201252.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: JCG343XV6BFJLXS5YIP575HOXAVVW7UE
X-Message-ID-Hash: JCG343XV6BFJLXS5YIP575HOXAVVW7UE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JCG343XV6BFJLXS5YIP575HOXAVVW7UE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3201252.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 17:03:41 +0200
Message-ID: <14211429.uLZWGnKmhe@sven-desktop>
In-Reply-To: <20260805143200.722098-2-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D1

> --- Patch [1]: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr bac=
kwards compatibility ---
[...]
> Discovered by: opus-5 =C2=B7 Missed by: old-prompts, sashiko-gemini =C2=
=B7 Confirmed by: old-prompts
> Was the removed else branch really only reachable when talking to
> pre-compat-15 nodes?

This is a misrepresentation of the commit. The code was added in batman-adv=
=20
with compat 14 when not all nodes had support for 4-addr packets.=20
With compat-15, all nodes must have support for 4addr packets and the=20
backwards compatibility hack is no longer needed

[...]
> After this change those cache replies go out as BATADV_UNICAST_4ADDR, and=
 on
> the receiver batadv_recv_unicast_packet() now takes the is4addr path:
>=20
> 			subtype =3D unicast_4addr_packet->subtype;
> 			batadv_dat_inc_counter(bat_priv, subtype);
>=20
> so BATADV_P_DAT_CACHE_REPLY RX accounting is incremented where it previou=
sly
> was not, and the encapsulation of these replies changes in packet capture=
s.

Yes, but what is wrong about the correct packets and correct accounting?

[...]=20
> Discovered by: opus-5 =C2=B7 Missed by: old-prompts, sashiko-gemini =C2=
=B7 Confirmed by: old-prompts
> This is a pre-existing issue and not introduced by this patch, but while
> looking at the DAT subtype decoding: the default arm of the inner switch =
in
> batadv_dbg_arp() prints the packet type where the message says subtype:
>=20
> 		switch (unicast_4addr_packet->subtype) {
> 		...
> 		default:
> 			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
> 				   unicast_4addr_packet->u.packet_type);
> 		}
>=20
> That arm is only reachable from case BATADV_UNICAST_4ADDR: of the outer
> switch, so the value printed is always 0x42 rather than the unrecognized
> value from enum batadv_subtype in include/uapi/linux/batadv_packet.h.

Irrelevant for this patch but I've submitted a mini fix:
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260806-4addr-u=
nknown-subtype-print-v1-1-e906357a5895@narfation.org/

Regards,
	Sven


--nextPart3201252.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSiTQAKCRBND3cr0xT1
y6t8AQD84YyhEiTBB6riLKZaG7fUtJLbGi7SGzoDcxIdade7fAEA7pecsXc6V744
BCmzGIuj+MzY9/64yJz9Z9ZFKcXOZAs=
=DknP
-----END PGP SIGNATURE-----

--nextPart3201252.e9J7NaK4W3--



