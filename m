Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D09C56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 15:36:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C6DA84278
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 17:36:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786030609;
 b=pwIZJtx3ocuMV5QZdTsWjkRy5SA5q9hf6gOzBx8PZO/418p7b0G4/vGO5ZiUMUOv69tJE
 HF/KnlmsqsuMad9D/X63zCSzb97b7EcxjJ2CmaLb6BpM+V2i4BpttIGbA4sCHXDuBl7YCll
 KcezmbqY97+SGQpHS+XbYw5ur4fKYQw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786030609; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gxOqj046lOlY9vx8KGzYwQr5rgbueGKyjX7Y1DhoNNw=;
 b=eWCFwxvt/EKj2R+Bg1Bf8OogcPB2zzFfQVGTfn7i9zSACcdTWqOt2pd79UBKiw+ph/RTK
 xIPZjcJxiJoO7TazeqwpwVbzfCKVjW1ppYJs8a/KtVs+dlwLHN3lxh6gEQX2DX0ILNx4FCw
 k6EzNcILcEpYktVJ6ZqXAVl5e01x0VA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 810D2803FA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 17:36:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786030593;
	b=Xo48GVBQaPCjE1Rk9XejjFYKyYxfahaHaoAYNTceuIOS0R0QGFOr72RclFkBhBbMsBmWpS
	YDAj2KnNXT3kN7J6W0s9IcbRlegy2zjEQ5nU0Ng5ROATtt/Eh7d/XrkgcSVdk8d6EAk1Pt
	n67lzEie/UM2X6Lf4IFx91Itru7qX+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786030593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gxOqj046lOlY9vx8KGzYwQr5rgbueGKyjX7Y1DhoNNw=;
	b=x8rkBXoEmUDa1HyJ08ZrSzmf5FqEdAusBBVwaddp3uYyFAHxu7F5APKKKq3z406CSLmzX2
	bhw9TVFqTH5J+6ebTSh4AaaSdbTLyKnjT3AI1cErF83qiz9Lin3l6N97kD1COw+OpX40fd
	Rn1DImDL85Rzg941MEXz9uJL0lV2vm8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=cbpu+kEn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3CFA420E0D;
	Thu, 06 Aug 2026 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786030578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxOqj046lOlY9vx8KGzYwQr5rgbueGKyjX7Y1DhoNNw=;
	b=cbpu+kEnQLOBOc0wQldpcDVwcgqH1fXjrfN9MiZWfNXvQm3cC5e9xRckSzVaA8jEv76HvH
	IFuBA+zRenAHYPH/+TLN9gqC7chYFg0f7jtr8+R3SpUD3fzZmE7qyQ1jlVZ0F7hdtimyq0
	J5rD0lqV6phxMROhLeDw4E2+6PJrVdU=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 02/10] batman-adv: tvlv: handle negative tvlv
 processing
 return codes
Date: Thu, 06 Aug 2026 17:36:12 +0200
Message-ID: <13100789.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260805143200.722098-3-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-3-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6172109.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: SJLIEQDF4RUAPZBKMLWI6Y3MV4VB5UMW
X-Message-ID-Hash: SJLIEQDF4RUAPZBKMLWI6Y3MV4VB5UMW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SJLIEQDF4RUAPZBKMLWI6Y3MV4VB5UMW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6172109.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 17:36:12 +0200
Message-ID: <13100789.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260805143200.722098-3-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D2

> --- Patch [2]: [PATCH net-next 02/10] batman-adv: tvlv: handle negative t=
vlv=20
processing return codes ---
[...]
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Does batadv_recv_mcast_packet() really match the new "NET_RX_SUCCESS if t=
he
> skb was locally received" wording?
>=20
> In net/batman-adv/routing.c, ret is assigned exactly once, from
> batadv_tvlv_containers_process(), and the local delivery is gated by an
> additional length test:
>=20
> 	ret =3D batadv_tvlv_containers_process(bat_priv, BATADV_MCAST, NULL,=20
skb,
> 					     tvlv_buff,=20
tvlv_buff_len);
> 	...
> 	hdr_size +=3D tvlv_buff_len;
>=20
> 	if (ret =3D=3D NET_RX_SUCCESS && (skb->len - hdr_size >=3D ETH_HLEN)) {
> 		...
> 		batadv_interface_rx(bat_priv->mesh_iface, skb, hdr_size,=20
NULL);
> 		/* skb was consumed */
> 		skb =3D NULL;
> 	}
>=20
> free_skb:
> 	kfree_skb(skb);
>=20
> 	return ret;

Yes, there are additional checks down the path. But it was still considered=
 in=20
the parsing of the TVLV as code which should be received locally. I am not =
a=20
person which writes documentation all day and I have no idea how to convey =
all=20
the details without repeating basically the whole code. At some point, we h=
ave=20
to use something which is just good enough or somebody has to be found whic=
h=20
is better than me in writing of documentation.

I will not submit any patch for this.

[..]
> Since the stated goal here is to make these return values reliable for
> future callers, should the wording be something like "NET_RX_SUCCESS if t=
he
> skb was processed successfully"

No, this is not what is the (unfortunate) meaning of NET_RX_SUCCESS and=20
NET_RX_DROP here.

Regards,
	Sven
--nextPart6172109.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSp7AAKCRBND3cr0xT1
y+3cAP9Bgos/68o4rtE36Mp1RREe0rZHjuc9O9x2dvk1ChHLRAEAi8ofm3b8zmuj
wFad719lpRvDouBXIwMqgQDf4xtGuAQ=
=4etA
-----END PGP SIGNATURE-----

--nextPart6172109.DvuYhMxLoT--



