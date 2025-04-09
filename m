Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E51C36002
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 15:44:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 687178415E
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 17:44:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744213470;
 b=M0vVhD2+lWmRNpy0u6jp8r6bxTb8khOZf9fBdGY4Uo/cUj2IX7YvabrEv0w9BuaS1Vzqe
 o3FekNsRiOoG4IbxyIoyhFQ048KwdiFISBDh+1B0gc18+iroqkXaD52T94ZEADggbCkKYy6
 XCYDfaONsMITrLtrTc4CGf3ie+A4CbE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744213470; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ByunKrilyL48d/c5MjnZJh9souP+RihV9Ah6M47bueA=;
 b=mt/N1v5VtcTQeepuab6EzE3/En+oPhKQGKtx30/wQkz5er1hCwzZzVZPqS3oU3uuuqoPX
 u4BTEoEamEVv8yr+nejNal9ojjwNBnPia3ZJNGXXvjizbj5IytXGYJ0p7cGMn5tfawNl1rc
 CoY+2Jw4pEs2E2fOSpXdLIfaV87JbIU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 83BC580F86
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  9 Apr 2025 17:44:04 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744213454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	in-reply-to:in-reply-to:references:references:dkim-signature:autocrypt:autocrypt;
	bh=ByunKrilyL48d/c5MjnZJh9souP+RihV9Ah6M47bueA=;
	b=G82Rq3VrULOw35qFW96Kd2r0SAyac37PssPT0f/cgaWyv2M8oocQycoM+xb1yGRbQ/2GaD
	O049lZqbSuj91nuQQCU2Q0jreJoNnwTg7Vvie720DDVHqCMh6zeSmSL9g6mysxtSxPR/1R
	UlOBbVLh00g7X2XrkHPrAObFK/UY2XE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=Aafp1mcA;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744213454; a=rsa-sha256;
	cv=none;
	b=CJii7OTlH1HMGk4nPhRXQhF8JUdYcjKp/YXNeAiuvaTomx+4qBcH3M+iZgb4510hInjedW
	KL5bzaK9TTGMD32CCHjP6d6cdK0IUmk4vsPRvUpqye29IFs+M1WAU0NUe0/8wJJyST6eB5
	WYAdy4sOGpXyTT10e2sGxqdrb+dDH44=
Message-ID: <3615fa6f-a837-4b4d-a987-52245710d84e@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744213443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ByunKrilyL48d/c5MjnZJh9souP+RihV9Ah6M47bueA=;
	b=Aafp1mcAiZH8DXqq0kdvvMDJv8NFT22AjB8NsPBEnvZADRi2tSeY4Enyq2XH9UJyrQLknZ
	2kf2xqN1Flc9CKMmrI6Yh2sl5aUGLb+uQDHLsBrsBkLflX+6fk1bayRUjV++iEK14OVkVK
	nwrLpa5DFraGh3nafaK/k+3QpQttUQkboHxm0Agt9x+i7WZ7JJ1abptJnIzMk+v5Gh5ydI
	EzdrKKwIElEwsqu5TXbRTsArPxydkKbAMQgZ8wIq/F094d0mBFlgciSg0WBz8KvKEhfhxd
	eRatMIdeFfsQgZqQC3aKxotH8tgUdbK9lRySvz6dT1GcST9KmRhNF2lOwfIhUA==
Date: Wed, 9 Apr 2025 17:44:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: batman-adv: constify and move broadcast
 addr definition
Content-Language: en-US-large
To: Sven Eckelmann <sven@narfation.org>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: 
 <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
 <2789676.Lt9SDvczpP@ripper>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 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
 cQqe8eRmcdNdqWSiJQ8VLoI=
In-Reply-To: <2789676.Lt9SDvczpP@ripper>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------60iJOc5p1wrpyh3HgNkqvD71"
X-Spamd-Bar: ----
Message-ID-Hash: 6PQYCG4QKMVBUWE7HAVC5HNPQK2P6BJ3
X-Message-ID-Hash: 6PQYCG4QKMVBUWE7HAVC5HNPQK2P6BJ3
X-MailFrom: mschiffer@universe-factory.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6PQYCG4QKMVBUWE7HAVC5HNPQK2P6BJ3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------60iJOc5p1wrpyh3HgNkqvD71
Content-Type: multipart/mixed; boundary="------------so68tEQeyh9weA1bi63OW1xD";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <3615fa6f-a837-4b4d-a987-52245710d84e@universe-factory.net>
Subject: Re: [PATCH net-next] net: batman-adv: constify and move broadcast
 addr definition
References: <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
 <2789676.Lt9SDvczpP@ripper>
In-Reply-To: <2789676.Lt9SDvczpP@ripper>

--------------so68tEQeyh9weA1bi63OW1xD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkvMDQvMjAyNSAxMDoxMCwgU3ZlbiBFY2tlbG1hbm4gd3JvdGU6DQo+IE9uIFR1ZXNk
YXksIDggQXByaWwgMjAyNSAxNzo1MzozNiBDRVNUIE1hdHRoaWFzIFNjaGlmZmVyIHdyb3Rl
Og0KPj4gKyAgICAgICBjb25zdCB1OCBicm9hZGNhc3RfYWRkcltdID0gezB4ZmYsIDB4ZmYs
IDB4ZmYsIDB4ZmYsIDB4ZmYsIDB4ZmZ9Ow0KPiANCj4gU2hvdWxkIG1vc3QgbGlrZWx5IGJl
ICJzdGF0aWMgY29uc3QgdTggLi4uIg0KPiANCj4gKGNoZWNrcGF0Y2ggU1RBVElDX0NPTlNU
X0NIQVJfQVJSQVkpDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IAlTdmVuDQoNClRoYW5rcywg
d2lsbCBzZW5kIGEgdjIuIFRoZSBjaGVja3BhdGNoIGNoZWNrIG9ubHkgbG9va3MgZm9yIHN0
cmluZ3MsIG5vdCANCmFycmF5cyBkZWZpbmVkIHdpdGggeyB9LCBzbyBpdCBkaWRuJ3QgdHJp
Z2dlciBmb3IgbWUuDQoNCkJlc3QsDQpNYXR0aGlhcw0K

--------------so68tEQeyh9weA1bi63OW1xD--

--------------60iJOc5p1wrpyh3HgNkqvD71
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAmf2lcIFAwAAAAAACgkQFu8/ZMsgHZxu
fRAA02x0QMxxvLVurZGGbh1sjKGPgMeRcQwSoO6e516iXhjjlhali0f3Z+xVxSpPw9Hjg4OX/vs3
tupMNvLjFTizfw11jyTjQirrID8J813n1yRc+hJEayjEvhbrv5+nUGDUANiasAoASuikE7ah34jY
WIOrt4qD38EHEvbwRVFz0YUZqfGFDrJ/l3t+/wm24VFVFMHXLVLVcn8qJmfoCdAKmKP2Qh1HMqVG
OLNwiwMo5CBUYx0yhN/RzdU5F0660Q+CUT2ws1GN/MejfcqLUvwl4ol3RpM3heewLhPU2ArRJy+2
QBaN+mVZJK4LL3P+wtgeL+0FUxiJelIfDFaLrBg0fcuUnfgenkKPcwaHc4lzBqNPcdJJ20sCP4Go
In0Vz4WpgtV4HIAz4659tqxo3YkDrHSMiyE2p903AoTxTUn8hT+TpK8VacfaOjqcyMUKtkXHwSze
FGS09DJlQMiYCxbIRUzKNM6MkvCbBQaB5CuG+sJX5RDl6rDsZTXMX/PjvmTzKPPvwDMEln9QO+xz
l9bhOGi3FBQ3/OsXOwuCyenPtwRGfh/ZLkAwOIB9LPEmqq0HXO5EgcuuAomHfuiFw1Kd9gov6wcN
L7Phl4l0HrHLKGcIXQtZkfdqnbNJ1MTeVBBjkaiq1UqLQXbEJL6q1nll8QrFNVXcRXkAnw+U7GQa
IV8=
=xF61
-----END PGP SIGNATURE-----

--------------60iJOc5p1wrpyh3HgNkqvD71--
